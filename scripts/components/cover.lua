local CoverSlots = require("scripts/extension_systems/cover/utilities/cover_slots")
local SharedNav = require("scripts/components/utilities/shared_nav")
local Cover = component("Cover")

function Cover:init(unit)
	self:enable(unit)

	local cover_extension = ScriptUnit.fetch_component_extension(unit, "cover_system")

	if cover_extension then
		local cover_type = self:get_data(unit, "cover_type")
		local enabled = self:get_data(unit, "enabled")

		cover_extension:setup_from_component(cover_type, enabled)
	end
end

function Cover:destroy(unit)
	return
end

function Cover:enable(unit)
	return
end

function Cover:disable(unit)
	return
end

function Cover:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = Application.main_world()
	self._world = world
	self._physics_world = World.physics_world(world)
	self._line_object = World.create_line_object(world)
	self._drawer = DebugDrawer(self._line_object, "retained")
	self._should_debug_draw = false

	if Cover._nav_info == nil then
		Cover._nav_info = SharedNav.create_nav_info()
	end

	self._my_nav_gen_guid = nil
	local object_id = Unit.get_data(unit, "LevelEditor", "object_id")
	self._object_id = object_id
	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(object_id)

	self:_reset_data()

	return true
end

function Cover:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	if Cover._nav_info ~= nil then
		SharedNav.destroy(Cover._nav_info)
	end

	local world = self._world
	local line_object = self._line_object

	LineObject.reset(line_object)
	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)
end

function Cover:editor_validate(unit)
	return true, ""
end

function Cover:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local with_traverse_logic = false
	local nav_gen_guid = SharedNav.check_new_navmesh_generated(Cover._nav_info, self._my_nav_gen_guid, with_traverse_logic)

	if nav_gen_guid then
		self._my_nav_gen_guid = nav_gen_guid

		self:_generate_cover_slots(unit)
	end

	return true
end

function Cover:editor_on_mission_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(self._object_id)

	self:_generate_cover_slots(unit)
end

function Cover:editor_world_transform_modified(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_generate_cover_slots(unit)
end

function Cover:editor_toggle_debug_draw(enable)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._should_debug_draw = enable
end

function Cover:_generate_cover_slots(unit)
	self:_reset_data()

	if not self._in_active_mission_table then
		return
	end

	local active_mission_level_id = LevelEditor:get_active_mission_level()
	local nav_world = Cover._nav_info.nav_world_from_level_id[active_mission_level_id]

	if nav_world then
		local enabled = self:get_data(unit, "enabled")
		local cover_type = self:get_data(unit, "cover_type")
		local node_positions = CoverSlots.fetch_node_positions(unit)
		local cover_slots = CoverSlots.create(self._physics_world, nav_world, unit, cover_type, node_positions)
		self._cover_type = cover_type
		self._enabled = enabled
		self._node_positions = node_positions
		self._cover_slots = cover_slots
	end
end

function Cover:_reset_data()
	self._cover_type = "high"
	self._enabled = true
	self._node_positions = {}
	self._cover_slots = {}
end

Cover.component_data = {
	cover_type = {
		value = "high",
		ui_type = "combo_box",
		ui_name = "Cover Type",
		options_keys = {
			"high",
			"low"
		},
		options_values = {
			"high",
			"low"
		}
	},
	enabled = {
		ui_type = "check_box",
		value = true,
		ui_name = "Enabled"
	},
	extensions = {
		"CoverExtension"
	}
}

return Cover
