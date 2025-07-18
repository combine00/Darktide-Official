local NavGraphQueries = require("scripts/extension_systems/nav_graph/utilities/nav_graph_queries")
local SharedNav = require("scripts/components/utilities/shared_nav")
local NavGraph = component("NavGraph")

function NavGraph:init(unit, is_server)
	if not is_server then
		return false
	end

	local nav_graph_extension = ScriptUnit.fetch_component_extension(unit, "nav_graph_system")

	if nav_graph_extension then
		self._nav_graph_extension = nav_graph_extension
		local enabled_on_spawn = self:get_data(unit, "enabled_on_spawn")
		local pregenerate_smart_objects = self:get_data(unit, "pregenerate_smart_objects")
		local simple_smart_objects = pregenerate_smart_objects and self:_fetch_smart_objects(unit)

		nav_graph_extension:setup_from_component(self, unit, enabled_on_spawn, simple_smart_objects)
	end
end

function NavGraph:_fetch_smart_objects(unit)
	local has_smart_object = true
	local smart_objects = {}
	local index = 1

	while has_smart_object do
		local smart_object = self:_fetch_smart_object(unit, index)
		index = index + 1

		if smart_object then
			smart_objects[#smart_objects + 1] = smart_object
		else
			has_smart_object = false
		end
	end

	return smart_objects
end

function NavGraph:_fetch_smart_object(unit, index)
	local layer_type = self:get_data(unit, "smart_objects", index, "layer_type")

	if layer_type == nil then
		return nil
	end

	local smart_object = {
		layer_type = layer_type,
		entrance_position = {
			self:get_data(unit, "smart_objects", index, "entrance_position", 1),
			self:get_data(unit, "smart_objects", index, "entrance_position", 2),
			self:get_data(unit, "smart_objects", index, "entrance_position", 3)
		},
		exit_position = {
			self:get_data(unit, "smart_objects", index, "exit_position", 1),
			self:get_data(unit, "smart_objects", index, "exit_position", 2),
			self:get_data(unit, "smart_objects", index, "exit_position", 3)
		},
		data = {
			is_bidirectional = self:get_data(unit, "smart_objects", index, "data", "is_bidirectional"),
			jump_flat_distance = self:get_data(unit, "smart_objects", index, "data", "jump_flat_distance"),
			ledge_type = self:get_data(unit, "smart_objects", index, "data", "ledge_type"),
			ledge_position = {
				self:get_data(unit, "smart_objects", index, "data", "ledge_position", 1),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position", 2),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position", 3)
			},
			ledge_position1 = {
				self:get_data(unit, "smart_objects", index, "data", "ledge_position1", 1),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position1", 2),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position1", 3)
			},
			ledge_position2 = {
				self:get_data(unit, "smart_objects", index, "data", "ledge_position2", 1),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position2", 2),
				self:get_data(unit, "smart_objects", index, "data", "ledge_position2", 3)
			}
		}
	}

	return smart_object
end

function NavGraph:destroy(unit)
	return
end

function NavGraph:enable(unit)
	return
end

function NavGraph:disable(unit)
	return
end

function NavGraph:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = Application.main_world()
	self._world = world
	self._physics_world = World.physics_world(world)
	self._line_object = World.create_line_object(world)
	self._drawer = DebugDrawer(self._line_object, "retained")
	self._active_debug_draw = false
	self._debug_draw_enabled = false
	self._debug_data_smart_objects = {}
	self._calculation_items = {}

	if NavGraph._nav_info == nil then
		NavGraph._nav_info = SharedNav.create_nav_info()
	end

	self._my_nav_gen_guid = nil
	local object_id = Unit.get_data(unit, "LevelEditor", "object_id")
	self._object_id = object_id
	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(object_id)

	return true
end

function NavGraph:editor_validate(unit)
	return true, ""
end

function NavGraph:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	if NavGraph._nav_info ~= nil then
		SharedNav.destroy(NavGraph._nav_info)
	end

	local line_object = self._line_object
	local world = self._world

	LineObject.reset(line_object)
	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)
end

local MAX_DEBUG_DRAW_CAMERA_DISTANCE_SQ = 2500

function NavGraph:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local should_debug_draw = self._debug_draw_enabled
	local refresh_needed = false

	if self._in_active_mission_table then
		local with_traverse_logic = false
		local nav_gen_guid = SharedNav.check_new_navmesh_generated(NavGraph._nav_info, self._my_nav_gen_guid, with_traverse_logic)

		if nav_gen_guid then
			self._my_nav_gen_guid = nav_gen_guid

			self:_generate_positions(unit)

			refresh_needed = self._active_debug_draw
		end

		if should_debug_draw then
			local camera_position = LevelEditor:get_camera_location()
			local unit_position = Unit.local_position(unit, 1)
			should_debug_draw = Vector3.distance_squared(camera_position, unit_position) < MAX_DEBUG_DRAW_CAMERA_DISTANCE_SQ
		end
	else
		should_debug_draw = false
	end

	if should_debug_draw ~= self._active_debug_draw or refresh_needed then
		self._active_debug_draw = should_debug_draw

		self:_editor_debug_draw(unit)
	end

	return true
end

function NavGraph:editor_on_mission_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(self._object_id)
end

function NavGraph:editor_world_transform_modified(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_generate_positions(unit)
	self:_editor_debug_draw(unit)
end

function NavGraph:editor_toggle_debug_draw(enable)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._debug_draw_enabled = enable
end

function NavGraph:_editor_debug_draw(unit)
	local drawer = self._drawer

	drawer:reset()

	if self._active_debug_draw then
		local debug_data_smart_objects = self._debug_data_smart_objects

		for i = 1, #debug_data_smart_objects do
			local debug_data_smart_object = debug_data_smart_objects[i]
			local is_one_way = debug_data_smart_object.is_one_way
			local entrance_position = debug_data_smart_object.entrance_position:unbox()
			local exit_position = debug_data_smart_object.exit_position:unbox()

			NavGraphDebug.draw_nav_graph(drawer, unit, is_one_way, entrance_position, exit_position)
		end

		local calculation_items = self._calculation_items

		NavGraphDebug.draw_item_list(drawer, calculation_items)
	end

	drawer:update(self._world)
end

function NavGraph:_generate_positions(unit)
	local calculation_items = self._calculation_items
	local debug_data_smart_objects = self._debug_data_smart_objects

	table.clear_array(debug_data_smart_objects, #debug_data_smart_objects)
	table.clear_array(calculation_items, #calculation_items)

	local nav_world = nil
	local pregenerate_smart_objects = self:get_data(unit, "pregenerate_smart_objects")

	if pregenerate_smart_objects then
		local _, level_id = LevelEditor:find_level_object(self._object_id)
		nav_world = NavGraph._nav_info.nav_world_from_level_id[level_id]
	else
		local active_mission_level_id = LevelEditor:get_active_mission_level()
		nav_world = NavGraph._nav_info.nav_world_from_level_id[active_mission_level_id]
	end

	if nav_world then
		local smart_objects, debug_draw_list = NavGraphQueries.generate_smart_objects(unit, nav_world, self._physics_world, self)

		table.merge_array(calculation_items, debug_draw_list)

		local is_one_way = self:get_data(unit, "is_one_way")

		for i = 1, #smart_objects do
			local smart_object = smart_objects[i]
			local entrance_position, exit_position = smart_object:get_entrance_exit_positions()
			local debug_data_smart_object = {
				entrance_position = Vector3Box(entrance_position),
				exit_position = Vector3Box(exit_position),
				is_one_way = is_one_way
			}
			debug_data_smart_objects[i] = debug_data_smart_object
		end
	end
end

function NavGraph:flow_nav_enable()
	if not self.is_server or not self._nav_graph_extension then
		return
	end

	self._nav_graph_extension:add_nav_graphs_to_database()
end

function NavGraph:flow_nav_disable()
	if not self.is_server or not self._nav_graph_extension then
		return
	end

	self._nav_graph_extension:remove_nav_graphs_from_database()
end

NavGraph.component_data = {
	is_one_way = {
		ui_type = "check_box",
		value = false,
		ui_name = "Is One Way"
	},
	enabled_on_spawn = {
		ui_type = "check_box",
		value = true,
		ui_name = "Navigation Enabled on Spawn"
	},
	pregenerate_smart_objects = {
		ui_type = "check_box",
		value = true,
		ui_name = "Pregenerate Smart Objects"
	},
	layer_type = {
		value = "auto_detect",
		ui_type = "combo_box",
		ui_name = "Layer Type",
		options_keys = {
			"auto_detect",
			"teleporters",
			"monster_walls"
		},
		options_values = {
			"auto_detect",
			"teleporters",
			"monster_walls"
		}
	},
	smart_object_calculation_method = {
		value = "use_node_pair",
		ui_type = "combo_box",
		ui_name = "Smart Object Calculation Method",
		options_keys = {
			"use_node_pair",
			"use_offset_node",
			"calculate_from_node_pair",
			"calculate_from_node_list"
		},
		options_values = {
			"use_node_pair",
			"use_offset_node",
			"calculate_from_node_pair",
			"calculate_from_node_list"
		}
	},
	node_a_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Node A Name",
		category = "Node Pair"
	},
	node_b_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Node B Name",
		category = "Node Pair"
	},
	offset_node_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Offset Node Name",
		category = "Offset Node"
	},
	entrance_offset = {
		ui_type = "vector",
		ui_name = "Entrance Offset",
		category = "Offset Node",
		value = Vector3Box(0, 0, 0)
	},
	exit_offset = {
		ui_type = "vector",
		ui_name = "Exit Offset",
		category = "Offset Node",
		value = Vector3Box(0, 0, 0)
	},
	node_list = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "Nodes",
		category = "Node List"
	},
	inputs = {
		flow_nav_enable = {
			accessibility = "public",
			type = "event"
		},
		flow_nav_disable = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"NavGraphExtension"
	}
}

return NavGraph
