local LuggableSynchronizer = component("LuggableSynchronizer")

function LuggableSynchronizer:init(unit, is_server)
	self:enable(unit)

	self._is_server = is_server
	local luggable_synchronizer_extension = ScriptUnit.fetch_component_extension(unit, "event_synchronizer_system")

	if luggable_synchronizer_extension then
		local objective_name = self:get_data(unit, "objective_name")
		local objective_stages = self:get_data(unit, "objective_stages")
		local shuffle_stages = self:get_data(unit, "shuffle_stages")
		local auto_start = self:get_data(unit, "automatic_start")
		local manual_luggable_spawn = self:get_data(unit, "manual_luggable_spawn")
		local max_socket_target = self:get_data(unit, "max_socket_target")
		local keep_unused_sockets = self:get_data(unit, "keep_unused_sockets")
		local luggable_should_respawn = self:get_data(unit, "luggable_should_respawn")
		local luggable_respawn_timer = self:get_data(unit, "luggable_respawn_timer")
		local luggable_reset_timer = self:get_data(unit, "luggable_reset_timer")
		local luggable_consume_timer = self:get_data(unit, "luggable_consume_timer")
		local is_side_mission_synchronizer = self:get_data(unit, "is_side_mission_synchronizer")
		local automatic_start_on_level_spawned = self:get_data(unit, "automatic_start_on_level_spawned")

		luggable_synchronizer_extension:setup_from_component(objective_name, objective_stages, shuffle_stages, auto_start, manual_luggable_spawn, max_socket_target, keep_unused_sockets, luggable_should_respawn, luggable_respawn_timer, luggable_reset_timer, luggable_consume_timer, is_side_mission_synchronizer, automatic_start_on_level_spawned)

		self._luggable_synchronizer_extension = luggable_synchronizer_extension
	end
end

function LuggableSynchronizer:editor_init(unit)
	self:enable(unit)
end

function LuggableSynchronizer:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_volume(unit, "g_luggable_safe_zone") then
		success = false
		error_message = error_message .. "\nMissing volume 'g_luggable_safe_zone'"
	end

	return success, error_message
end

function LuggableSynchronizer:enable(unit)
	return
end

function LuggableSynchronizer:disable(unit)
	return
end

function LuggableSynchronizer:destroy(unit)
	return
end

function LuggableSynchronizer:start_luggable_event(unit)
	if self._luggable_synchronizer_extension then
		self._luggable_synchronizer_extension:start_event()
	end
end

function LuggableSynchronizer:spawn_single_luggable(unit)
	local luggable_synchronizer_extension = self._luggable_synchronizer_extension

	if self._is_server and luggable_synchronizer_extension then
		luggable_synchronizer_extension:spawn_single_luggable()
	end
end

function LuggableSynchronizer:hide_all_luggables(unit)
	local luggable_synchronizer_extension = self._luggable_synchronizer_extension

	if self._is_server and luggable_synchronizer_extension then
		luggable_synchronizer_extension:hide_all_luggables()
	end
end

LuggableSynchronizer.component_data = {
	objective_name = {
		ui_type = "text_box",
		value = "default",
		ui_name = "Objective Name"
	},
	shuffle_stages = {
		ui_type = "check_box",
		value = false,
		ui_name = "Shuffle Stages"
	},
	objective_stages = {
		value = 1,
		min = 1,
		ui_type = "number",
		decimals = 0,
		ui_name = "Objective Stages"
	},
	automatic_start = {
		ui_type = "check_box",
		value = false,
		ui_name = "Auto Start On Mission Start"
	},
	manual_luggable_spawn = {
		ui_type = "check_box",
		value = false,
		ui_name = "Spawn Luggable Manually"
	},
	max_socket_target = {
		value = 10,
		min = 1,
		ui_type = "number",
		decimals = 0,
		ui_name = "Max Socket Target"
	},
	keep_unused_sockets = {
		ui_type = "check_box",
		value = false,
		ui_name = "Keep Unused Sockets"
	},
	luggable_should_respawn = {
		ui_type = "check_box",
		value = true,
		ui_name = "Luggable should Respawn",
		category = "Spawn settings"
	},
	luggable_respawn_timer = {
		ui_type = "number",
		decimals = 1,
		category = "Spawn settings",
		value = 3,
		ui_name = "Luggable Respawn Timer (in sec.)",
		step = 0.1
	},
	luggable_reset_timer = {
		ui_type = "number",
		decimals = 1,
		category = "Spawn settings",
		value = 120,
		ui_name = "Luggable Reset Timer (in sec.)",
		step = 0.1
	},
	luggable_consume_timer = {
		ui_type = "number",
		decimals = 1,
		category = "Spawn settings",
		value = 3,
		ui_name = "Luggable Consume Timer (in sec.)",
		step = 0.1
	},
	is_side_mission_synchronizer = {
		ui_type = "check_box",
		value = false,
		ui_name = "Is Side Mission Synchronizer",
		category = "Side Mission"
	},
	automatic_start_on_level_spawned = {
		ui_type = "check_box",
		value = false,
		ui_name = "Automatic Start On Mission Start",
		category = "Side Mission"
	},
	inputs = {
		start_luggable_event = {
			accessibility = "public",
			type = "event"
		},
		spawn_single_luggable = {
			accessibility = "public",
			type = "event"
		},
		hide_all_luggables = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"LuggableSynchronizerExtension"
	}
}

return LuggableSynchronizer
