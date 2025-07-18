local Component = require("scripts/utilities/component")
local MinionSpawnerSpawnPosition = require("scripts/extension_systems/minion_spawner/utilities/minion_spawner_spawn_position")
local SharedNav = require("scripts/components/utilities/shared_nav")
local MinionSpawner = component("MinionSpawner")

function MinionSpawner:init(unit, is_server)
	local spawner_extension = ScriptUnit.fetch_component_extension(unit, "minion_spawner_system")

	if spawner_extension then
		local spawner_groups, spawn_position_offset, exit_position_offset, anim_data, exclude_from_pacing, exclude_from_specials_pacing, spawn_type, exit_rotation_num_directions, exit_rotation_random_degree_range = self:_get_data(unit)
		self._anim_data = anim_data
		local tm = Unit.world_pose(unit, 1)
		local has_spawn_node = Unit.has_node(unit, "spawn_node")

		if has_spawn_node then
			local spawn_node = Unit.node(unit, "spawn_node")
			local spawn_node_position = Unit.world_position(unit, spawn_node)

			Matrix4x4.set_translation(tm, spawn_node_position)
		end

		local spawn_position = Matrix4x4.transform(tm, spawn_position_offset:unbox())
		local exit_position = Matrix4x4.transform(tm, exit_position_offset:unbox())

		spawner_extension:setup_from_component(spawner_groups, spawn_position, exit_position, exclude_from_pacing, exclude_from_specials_pacing, spawn_type, exit_rotation_num_directions, exit_rotation_random_degree_range)
	end
end

function MinionSpawner:_get_data(unit)
	local spawner_groups = self:get_data(unit, "spawner_groups")
	local spawn_position_offset = self:get_data(unit, "spawn_offset")
	local exit_position_offset = self:get_data(unit, "exit_offset")
	local anim_duration = self:get_data(unit, "duration")
	local anim_data = nil

	if anim_duration ~= 0 then
		local anim_length = Unit.simple_animation_length(unit)
		local spawning_started_anim = {
			time_from = self:get_data(unit, "spawning_started_time_from") * anim_length,
			time_to = self:get_data(unit, "spawning_started_time_to") * anim_length
		}
		spawning_started_anim.speed = (spawning_started_anim.time_to - spawning_started_anim.time_from) / anim_duration
		local spawning_done_anim = {
			time_from = self:get_data(unit, "spawning_done_time_from") * anim_length,
			time_to = self:get_data(unit, "spawning_done_time_to") * anim_length
		}
		spawning_done_anim.speed = (spawning_done_anim.time_to - spawning_done_anim.time_from) / anim_duration
		anim_data = {
			spawning_started = spawning_started_anim,
			spawning_done = spawning_done_anim
		}
	end

	local exclude_from_pacing = self:get_data(unit, "exclude_from_pacing")
	local exclude_from_specials_pacing = self:get_data(unit, "exclude_from_specials_pacing")
	local spawn_type = self:get_data(unit, "spawn_type")
	local exit_rotation_num_directions = self:get_data(unit, "exit_rotation_num_directions")
	local exit_rotation_random_degree_range = self:get_data(unit, "exit_rotation_random_degree_range")

	return spawner_groups, spawn_position_offset, exit_position_offset, anim_data, exclude_from_pacing, exclude_from_specials_pacing, spawn_type, exit_rotation_num_directions, exit_rotation_random_degree_range
end

function MinionSpawner:destroy()
	return
end

function MinionSpawner:enable(unit)
	return
end

function MinionSpawner:disable(unit)
	return
end

function MinionSpawner.events:minion_spawner_spawning_started()
	if self.is_server then
		Component.trigger_event_on_clients(self, "minion_spawner_spawning_started")
	end

	local unit = self.unit
	local anim_data = self._anim_data

	Unit.flow_event(unit, "lua_spawning_started")

	if anim_data then
		local data = anim_data.spawning_started

		Unit.play_simple_animation(unit, data.time_from, data.time_to, false, data.speed)
	end
end

function MinionSpawner.events:minion_spawner_spawning_done()
	if self.is_server then
		Component.trigger_event_on_clients(self, "minion_spawner_spawning_done")
	end

	local unit = self.unit
	local anim_data = self._anim_data

	Unit.flow_event(unit, "lua_spawning_done")

	if anim_data then
		local data = anim_data.spawning_done

		Unit.play_simple_animation(unit, data.time_from, data.time_to, false, data.speed)
	end
end

function MinionSpawner:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = Application.main_world()
	self._world = world
	self._line_object = World.create_line_object(world)
	self._drawer = DebugDrawer(self._line_object, "retained")
	local _, spawn_offset, exit_offset = self:_get_data(unit)
	self._spawn_offset = spawn_offset
	self._exit_offset = exit_offset

	if MinionSpawner._nav_info == nil then
		MinionSpawner._nav_info = SharedNav.create_nav_info()
	end

	self._my_nav_gen_guid = nil
	self._active_debug_draw = false
	self._debug_draw_enabled = false
	local object_id = Unit.get_data(unit, "LevelEditor", "object_id")
	self._object_id = object_id
	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(object_id)

	return true
end

function MinionSpawner:editor_validate(unit)
	return true, ""
end

function MinionSpawner:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	if MinionSpawner._nav_info ~= nil then
		SharedNav.destroy(MinionSpawner._nav_info)
	end

	local world = self._world
	local line_object = self._line_object

	LineObject.reset(line_object)
	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)
end

function MinionSpawner:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return false
	end

	local should_debug_draw = self._debug_draw_enabled

	if self._in_active_mission_table then
		local with_traverse_logic = true
		local nav_gen_guid = SharedNav.check_new_navmesh_generated(MinionSpawner._nav_info, self._my_nav_gen_guid, with_traverse_logic)

		if nav_gen_guid then
			self._my_nav_gen_guid = nav_gen_guid

			self:_editor_debug_draw(unit)
		end
	else
		should_debug_draw = false
	end

	if should_debug_draw ~= self._active_debug_draw and self._my_nav_gen_guid then
		self._active_debug_draw = should_debug_draw

		self:_editor_debug_draw(unit)
	end

	return true
end

function MinionSpawner:_editor_debug_draw(unit)
	local drawer = self._drawer

	drawer:reset()

	if self._active_debug_draw then
		local active_mission_level_id = LevelEditor:get_active_mission_level()
		local nav_world = MinionSpawner._nav_info.nav_world_from_level_id[active_mission_level_id]
		local traverse_logic = MinionSpawner._nav_info.traverse_logic_from_level_id[active_mission_level_id]
		local spawn_offset = self._spawn_offset:unbox()
		local exit_offset = self._exit_offset:unbox()
		local tm = Unit.world_pose(unit, 1)
		local spawn_position = Matrix4x4.transform(tm, spawn_offset)
		local exit_position = Matrix4x4.transform(tm, exit_offset)
		local exit_position_on_nav_mesh = MinionSpawnerSpawnPosition.find_exit_position_on_nav_mesh(nav_world, spawn_position, exit_position, traverse_logic)

		drawer:sphere(spawn_position, 0.2, Color.white())

		if exit_position_on_nav_mesh then
			drawer:sphere(exit_position_on_nav_mesh, 0.2, Color.green())
			drawer:line(spawn_position, exit_position_on_nav_mesh, Color.green())
		else
			drawer:sphere(exit_position, 0.2, Color.red())
			drawer:line(spawn_position, exit_position, Color.red())
		end
	end

	drawer:update(self._world)
end

function MinionSpawner:editor_on_mission_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(self._object_id)
	self._in_active_mission_table = in_active_mission_table

	if in_active_mission_table and self._active_debug_draw then
		self:_editor_debug_draw(unit)
	end
end

function MinionSpawner:editor_world_transform_modified(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_editor_debug_draw(unit)
end

function MinionSpawner:editor_toggle_debug_draw(enable)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._debug_draw_enabled = enable
end

function MinionSpawner:debug_started_animation()
	Component.event(self.unit, "minion_spawner_spawning_started")
end

function MinionSpawner:debug_done_animation()
	Component.event(self.unit, "minion_spawner_spawning_done")
end

MinionSpawner.component_data = {
	spawn_offset = {
		ui_type = "vector",
		category = "Position Offset",
		ui_name = "Spawn Position Offset",
		step = 0.5,
		value = Vector3Box(0, 0, 0)
	},
	exit_offset = {
		ui_type = "vector",
		category = "Position Offset",
		ui_name = "Exit Position Offset",
		step = 0.5,
		value = Vector3Box(0, 1, 0)
	},
	spawning_started_time_from = {
		ui_type = "number",
		min = 0,
		step = 0.1,
		category = "Spawning Started",
		value = 0,
		decimals = 1,
		ui_name = "Time From (Normalized)",
		max = 1
	},
	spawning_started_time_to = {
		ui_type = "number",
		min = 0,
		step = 0.1,
		category = "Spawning Started",
		value = 1,
		decimals = 1,
		ui_name = "Time To (Normalized)",
		max = 1
	},
	spawning_done_time_from = {
		ui_type = "number",
		min = 0,
		step = 0.1,
		category = "Spawning Done",
		value = 0,
		decimals = 1,
		ui_name = "Time From (Normalized)",
		max = 1
	},
	spawning_done_time_to = {
		ui_type = "number",
		min = 0,
		step = 0.1,
		category = "Spawning Done",
		value = 1,
		decimals = 1,
		ui_name = "Time To (Normalized)",
		max = 1
	},
	duration = {
		ui_type = "number",
		min = 0,
		decimals = 1,
		value = 0,
		ui_name = "Duration (0 if no animation)",
		step = 0.1
	},
	spawner_groups = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "Spawner Groups",
		category = "Spawner Groups"
	},
	exclude_from_pacing = {
		ui_type = "check_box",
		value = false,
		ui_name = "Exclude From Pacing"
	},
	exclude_from_specials_pacing = {
		ui_type = "check_box",
		value = false,
		ui_name = "Exclude From Specials Pacing"
	},
	spawn_type = {
		ui_type = "text_box",
		value = "default",
		ui_name = "Spawn Type(default, from_ground)"
	},
	exit_rotation_random_degree_range = {
		ui_type = "number",
		value = 0,
		ui_name = "Exit Rotation Degree Range"
	},
	exit_rotation_num_directions = {
		ui_type = "number",
		value = 0,
		ui_name = "Exit Rotation Num Directions"
	},
	inputs = {
		debug_started_animation = {
			accessibility = "public",
			type = "event"
		},
		debug_done_animation = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"MinionSpawnerExtension"
	}
}

return MinionSpawner
