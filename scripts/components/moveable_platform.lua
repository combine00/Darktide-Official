local Navigation = require("scripts/extension_systems/navigation/utilities/navigation")
local MoveablePlatform = component("MoveablePlatform")

function MoveablePlatform:init(unit, is_server)
	self._is_server = is_server
	local moveable_platform_extension = ScriptUnit.fetch_component_extension(unit, "moveable_platform_system")

	if moveable_platform_extension then
		local story = self:get_data(unit, "story")
		local story_start_immediately = self:get_data(unit, "story_start_immediately")
		local story_loop_mode = self:get_data(unit, "story_loop_mode")
		local story_speed_forward, story_speed_backward = self:_calculate_story_speed(unit)
		local player_side = self:get_data(unit, "player_side")
		local walls_collision = self:get_data(unit, "walls_collision")
		local walls_collision_filter = self:get_data(unit, "walls_collision_filter")
		local require_all_players_onboard = self:get_data(unit, "require_all_players_onboard")
		local end_sound_time = self:get_data(unit, "end_sound_time")
		local interactable_story_actions = self:get_data(unit, "interactable_story_actions")
		local interactable_hud_descriptions = self:get_data(unit, "interactable_hud_descriptions")
		local nav_handling_enabled = self:get_data(unit, "nav_handling_enabled")
		local stop_position = self:get_data(unit, "stop_position")

		moveable_platform_extension:setup_from_component(story, story_loop_mode, story_start_immediately, story_speed_forward, story_speed_backward, player_side, walls_collision, walls_collision_filter, require_all_players_onboard, end_sound_time, interactable_story_actions, interactable_hud_descriptions, nav_handling_enabled, stop_position)

		self._moveable_platform_extension = moveable_platform_extension
	end
end

function MoveablePlatform:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._unit = unit
	self._stop_units = {}
	local world = Application.main_world()
	self._world = world
	self._debug_text_id = nil
	self._gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1)
	self._line_object = World.create_line_object(world)
	self._drawer = DebugDrawer(self._line_object, "immediate")
	self._debug_draw_enabled = false
	self._is_selected = false

	self:_spawn_stop_points()

	return true
end

function MoveablePlatform:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") then
		if self:get_data(unit, "walls_collision") and Unit.find_actor(unit, "c_wall_1") == nil then
			success = false
			error_message = error_message .. "\nCouldn't find any wall actors on unit"
		end

		if Unit.find_actor(unit, "c_box_center") == nil then
			success = false
			error_message = error_message .. "\nCouldn't find actor 'c_box_center' on unit"
		end
	end

	return success, error_message
end

function MoveablePlatform:get_navgen_units()
	if not rawget(_G, "LevelEditor") then
		return
	end

	return self._stop_units
end

function MoveablePlatform:_spawn_stop_points()
	if not rawget(_G, "LevelEditor") then
		return
	end

	local unit = self._unit
	local nav_handling_enabled = self:get_data(unit, "nav_handling_enabled")
	local unit_name = self:get_data(unit, "stop_unit")

	if not nav_handling_enabled or not unit_name then
		return
	end

	local world = self._world
	local stop_position = self:get_data(unit, "stop_position")
	local stop_rotation = Unit.world_rotation(unit, 1)
	local end_unit = World.spawn_unit_ex(world, unit_name, nil, stop_position:unbox(), stop_rotation)

	table.insert(self._stop_units, end_unit)
end

function MoveablePlatform:_unspawn_stop_points()
	local world = self._world

	if not world then
		return
	end

	for _, stop_unit in ipairs(self._stop_units) do
		if stop_unit then
			World.destroy_unit(world, stop_unit)
		else
			Log.error("MoveablePlatform", "Trying to destroy nil unit")
		end
	end

	table.clear(self._stop_units)
end

function MoveablePlatform:enable(unit)
	return
end

function MoveablePlatform:disable(unit)
	return
end

function MoveablePlatform:destroy(unit)
	return
end

function MoveablePlatform:editor_update(unit, dt, t)
	if not rawget(_G, "LevelEditor") then
		return false
	end

	local should_debug_draw = self._debug_draw_enabled and self._is_selected

	if should_debug_draw and self:get_data(unit, "nav_handling_enabled") and Unit.has_volume(unit, "g_volume_block") then
		self:_debug_draw_stop_volume(unit)
	end

	return true
end

local TEMP_POSITIONS = {}

function MoveablePlatform:_debug_draw_stop_volume(unit)
	local stop_position = self:get_data(unit, "stop_position")
	local volume_points = Unit.volume_points(unit, "g_volume_block")
	local offset_position = stop_position:unbox() - Unit.world_position(unit, 1)

	table.clear(TEMP_POSITIONS)

	for i = 1, #volume_points do
		local volume_point = volume_points[i]
		TEMP_POSITIONS[i] = volume_point + offset_position
	end

	local volume_height = Unit.volume_height(unit, "g_volume_block")
	local line_object = self._line_object

	Navigation.debug_draw_nav_tag_volume_segments(line_object, TEMP_POSITIONS, volume_height, Color.yellow(), true)
	Navigation.debug_draw_nav_tag_volume_segments(line_object, TEMP_POSITIONS, 0, Color.yellow(), false)
	self._drawer:update(self._world)
end

function MoveablePlatform:editor_selection_changed(unit, selected)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._is_selected = selected

	if not selected then
		self._drawer:update(self._world)
	end
end

function MoveablePlatform:editor_property_changed(unit)
	self:_setup_change(unit)
end

function MoveablePlatform:editor_world_transform_modified(unit)
	self:_setup_change(unit)
end

function MoveablePlatform:editor_toggle_debug_draw(enable)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._debug_draw_enabled = enable

	if not enable then
		self._drawer:update(self._world)
	end
end

function MoveablePlatform:_setup_change(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_calculate_story_speed(unit)
	self:_unspawn_stop_points()
	self:_spawn_stop_points()
end

function MoveablePlatform:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_unspawn_stop_points()

	local line_object = self._line_object
	local world = self._world

	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)

	local gui = self._gui

	if self._debug_text_id then
		Gui.destroy_text_3d(gui, self._debug_text_id)
	end

	World.destroy_gui(world, gui)
end

function MoveablePlatform:editor_reset_physics(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local center_actor_id = Unit.find_actor(unit, "c_box_center")

	if center_actor_id then
		Unit.destroy_actor(unit, center_actor_id)
	end

	local wall_count = 1
	local wall_prefix = "c_wall_"
	local actor_id = Unit.find_actor(unit, wall_prefix .. tostring(wall_count))

	while actor_id ~= nil do
		Unit.destroy_actor(unit, actor_id)

		wall_count = wall_count + 1
		actor_id = Unit.find_actor(unit, wall_prefix .. tostring(wall_count))
	end
end

function MoveablePlatform:_calculate_story_speed(unit)
	if unit == nil then
		self:_draw_warning(unit, "Unit null")

		return 1, 1
	end

	local story_name = self:get_data(unit, "story")
	local override_forward = self:get_data(unit, "story_override_forward")
	local override_backward = self:get_data(unit, "story_override_backward")
	local story_speed_forward = 1
	local story_speed_backward = 1

	if override_forward or override_backward then
		local story_length = self:_get_story_length(unit, story_name)

		if story_length >= 0 then
			local min_speed = -2
			local max_speed = 1.9990234375

			if NetworkConstants then
				local story_speed_constants = NetworkConstants.story_speed
				min_speed = story_speed_constants.min
				max_speed = story_speed_constants.max
			end

			if override_forward then
				local story_time_forward = self:get_data(unit, "story_time_forward")
				story_speed_forward = story_length / story_time_forward

				if min_speed > story_speed_forward then
					self:_draw_warning(unit, string.format("forward override time is %s vs %s base time, causing speed multiplier to be too small %sx (%sx min)", story_time_forward, story_length, story_speed_forward, min_speed))

					story_speed_forward = min_speed
				elseif max_speed < story_speed_forward then
					self:_draw_warning(unit, string.format("forward override time is %ss vs %ss base time, causing speed multiplier to be too large %sx (%sx max) ", story_time_forward, story_length, story_speed_forward, max_speed))

					story_speed_forward = max_speed
				end
			end

			if override_backward then
				local story_time_backward = self:get_data(unit, "story_time_backward")
				story_speed_backward = story_length / story_time_backward

				if min_speed > story_speed_backward then
					self:_draw_warning(unit, string.format("backward override time is %ss vs %ss base time, causing speed multiplier to be too small %sx (%sx min)", story_time_backward, story_length, story_speed_backward, min_speed))

					story_speed_backward = min_speed
				elseif max_speed < story_speed_backward then
					self:_draw_warning(unit, string.format("backward override time is %ss vs %ss base time, causing speed multiplier to be too large %sx (%sx max)", story_time_backward, story_length, story_speed_backward, max_speed))

					story_speed_backward = max_speed
				end
			end
		end
	end

	return story_speed_forward, story_speed_backward
end

function MoveablePlatform:_get_story_length(unit, story_name)
	if rawget(_G, "LevelEditor") then
		local stories = LevelEditor:get_unit_story(Unit.id_string(unit))
		local num_stories = 0

		for id, story in pairs(stories) do
			local story_length = LevelEditor:get_story_length(story)

			if story_length then
				return story_length
			end
		end

		self:_draw_warning(unit, string.format("No story connected to unit", story_name, num_stories))

		return -1
	else
		local level = Unit.level(unit)
		local world = Unit.world(unit)

		if level == nil or world == nil then
			self:_draw_warning(unit, string.format("Unable to check story length. world: %s, level: %s", world ~= nil, level ~= nil))

			return -1
		end

		local storyteller = World.storyteller(world)
		local story_length = storyteller:length_from_name(level, story_name)

		return story_length
	end
end

local FONT = "core/editor_slave/gui/arial"
local FONT_MATERIAL = "core/editor_slave/gui/arial"
local FONT_SIZE = 0.3

function MoveablePlatform:_draw_warning(unit, text)
	if self._gui then
		local text_color = Color.red()
		local text_position = Unit.local_position(unit, 1) + Vector3.up()
		local translation_matrix = Matrix4x4.from_translation(text_position)

		if self._debug_text_id then
			Gui.update_text_3d(self._gui, self._debug_text_id, "MovablePlatform - " .. text, FONT_MATERIAL, FONT_SIZE, FONT, translation_matrix, Vector3.zero(), 3, text_color)
		else
			self._debug_text_id = Gui.text_3d(self._gui, "MovablePlatform - " .. text, FONT_MATERIAL, FONT_SIZE, FONT, translation_matrix, Vector3.zero(), 3, text_color)
		end
	else
		Log.error("MovablePlatform", text)
	end
end

function MoveablePlatform:set_story(story_name)
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension and self._is_server then
		moveable_platform_extension:set_story(story_name)
	end
end

function MoveablePlatform:move_forward()
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension and self._is_server then
		moveable_platform_extension:move_forward()
	end
end

function MoveablePlatform:move_backward()
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension and self._is_server then
		moveable_platform_extension:move_backward()
	end
end

function MoveablePlatform:platform_toggle_loop()
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension then
		moveable_platform_extension:platform_toggle_loop()
	end
end

function MoveablePlatform:toggle_require_all_players_onboard()
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension then
		moveable_platform_extension:toggle_require_all_players_onboard()
	end
end

function MoveablePlatform:teleport_bots_to_node(node_name)
	local moveable_platform_extension = self._moveable_platform_extension

	if moveable_platform_extension and self._is_server then
		moveable_platform_extension:teleport_bots_to_node(node_name)
	end
end

MoveablePlatform.component_data = {
	story = {
		ui_type = "text_box",
		value = "story_name",
		ui_name = "Story",
		category = "Story"
	},
	story_start_immediately = {
		ui_type = "check_box",
		value = false,
		ui_name = "Start Immediately",
		category = "Story"
	},
	story_loop_mode = {
		value = 0,
		ui_type = "combo_box",
		category = "Story",
		ui_name = "Loop Mode",
		options_keys = {
			"None",
			"Loop",
			"Ping Pong"
		},
		options_values = {
			0,
			1,
			2
		}
	},
	story_override_forward = {
		ui_type = "check_box",
		value = false,
		ui_name = "Override Forward Story Time",
		category = "Story"
	},
	story_time_forward = {
		ui_type = "number",
		decimals = 100,
		category = "Story",
		value = 0,
		ui_name = "Forward Play Time (sec.)",
		step = 0.1
	},
	story_override_backward = {
		ui_type = "check_box",
		value = false,
		ui_name = "Override Backward Story Time",
		category = "Story"
	},
	story_time_backward = {
		ui_type = "number",
		decimals = 100,
		category = "Story",
		value = 0,
		ui_name = "Backward Story Time (sec.)",
		step = 0.1
	},
	player_side = {
		ui_type = "text_box",
		value = "heroes",
		ui_name = "Player Side"
	},
	walls_collision = {
		ui_type = "check_box",
		value = true,
		ui_name = "Walls Collision"
	},
	walls_collision_filter = {
		ui_type = "text_box",
		value = "default",
		ui_name = "Walls Collision Filter"
	},
	require_all_players_onboard = {
		ui_type = "check_box",
		value = false,
		ui_name = "Require All Players Onboard"
	},
	end_sound_time = {
		ui_type = "number",
		value = 0,
		ui_name = "End Sound Time"
	},
	interactable_story_actions = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "Story Actions",
		category = "Interactables"
	},
	interactable_hud_descriptions = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "HUD Descriptions",
		category = "Interactables"
	},
	nav_handling_enabled = {
		ui_type = "check_box",
		value = false,
		ui_name = "Nav Handling",
		category = "Nav"
	},
	stop_unit = {
		ui_type = "resource",
		preview = true,
		category = "Nav",
		value = "",
		ui_name = "Stop Unit",
		filter = "unit"
	},
	stop_position = {
		ui_type = "vector",
		category = "Nav",
		ui_name = "Stop Position",
		step = 0.1,
		value = Vector3Box(0, 0, 0)
	},
	inputs = {
		move_forward = {
			accessibility = "public",
			type = "event"
		},
		move_backward = {
			accessibility = "public",
			type = "event"
		},
		platform_toggle_loop = {
			accessibility = "public",
			type = "event"
		},
		toggle_require_all_players_onboard = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"MoveablePlatformExtension",
		"InteracteeExtension"
	}
}

return MoveablePlatform
