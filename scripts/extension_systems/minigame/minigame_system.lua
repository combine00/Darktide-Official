local MinigameSettings = require("scripts/settings/minigame/minigame_settings")

require("scripts/extension_systems/minigame/minigame_extension")

local MinigameSystem = class("MinigameSystem", "ExtensionSystemBase")
local CLIENT_RPCS = {
	"rpc_minigame_hot_join",
	"rpc_minigame_sync_start",
	"rpc_minigame_sync_stop",
	"rpc_minigame_sync_completed",
	"rpc_minigame_sync_game_state",
	"rpc_minigame_sync_set_stage",
	"rpc_minigame_sync_generate_board",
	"rpc_minigame_sync_balance_set_position",
	"rpc_minigame_sync_decode_symbols_set_start_time",
	"rpc_minigame_sync_decode_symbols_set_symbols",
	"rpc_minigame_sync_decode_symbols_set_target",
	"rpc_minigame_sync_defuse_set_selection",
	"rpc_minigame_sync_drill_generate_targets",
	"rpc_minigame_sync_drill_set_cursor",
	"rpc_minigame_sync_drill_set_search",
	"rpc_minigame_sync_frequency_set_frequency",
	"rpc_minigame_sync_frequency_set_target_frequency"
}

function MinigameSystem:init(context, system_init_data, ...)
	MinigameSystem.super.init(self, context, system_init_data, ...)

	self._seed = self._is_server and system_init_data.level_seed or nil
	self._default_minigame_type = system_init_data.mission.minigame_type or MinigameSettings.default_minigame_type
	local network_event_delegate = self._network_event_delegate

	if not self._is_server and network_event_delegate then
		network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function MinigameSystem:destroy(...)
	local network_event_delegate = self._network_event_delegate

	if not self._is_server and network_event_delegate then
		network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end

	MinigameSystem.super.destroy(self, ...)
end

function MinigameSystem:on_add_extension(world, unit, extension_name, extension_init_data, ...)
	local extension = MinigameSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data, ...)

	extension:on_add_extension(self._seed)

	if self._seed then
		self._seed = self._seed + 1
	end

	return extension
end

function MinigameSystem:default_minigame_type()
	return self._default_minigame_type
end

function MinigameSystem:rpc_minigame_hot_join(channel_id, unit_id, is_level_unit, state_id)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local state = NetworkLookup.minigame_states[state_id]

	extension:rpc_set_minigame_state(state)
end

function MinigameSystem:rpc_minigame_sync_start(channel_id, unit_id, is_level_unit)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:start()
end

function MinigameSystem:rpc_minigame_sync_stop(channel_id, unit_id, is_level_unit)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:stop()
end

function MinigameSystem:rpc_minigame_sync_completed(channel_id, unit_id, is_level_unit)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:completed()
end

function MinigameSystem:rpc_minigame_sync_game_state(channel_id, unit_id, is_level_unit, state_id)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame()
	local state = NetworkLookup.minigame_game_states[state_id]

	minigame:set_state(state)
end

function MinigameSystem:rpc_minigame_sync_generate_board(channel_id, unit_id, is_level_unit, seed)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame()

	minigame:generate_board(seed)
end

function MinigameSystem:rpc_minigame_sync_balance_set_position(channel_id, unit_id, is_level_unit, position_x, position_y)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.balance)

	minigame:set_position(position_x, position_y)
end

function MinigameSystem:rpc_minigame_sync_set_stage(channel_id, unit_id, is_level_unit, stage)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame()

	minigame:set_current_stage(stage)
end

function MinigameSystem:rpc_minigame_sync_decode_symbols_set_start_time(channel_id, unit_id, is_level_unit, fixed_frame_id)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.decode_symbols)
	local start_time = fixed_frame_id * Managers.state.game_session.fixed_time_step

	minigame:set_start_time(start_time)
end

function MinigameSystem:rpc_minigame_sync_decode_symbols_set_symbols(channel_id, unit_id, is_level_unit, symbols)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.decode_symbols)

	minigame:set_symbols(symbols)
end

function MinigameSystem:rpc_minigame_sync_decode_symbols_set_target(channel_id, unit_id, is_level_unit, stage, target)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.decode_symbols)

	minigame:set_target(stage, target)
end

function MinigameSystem:rpc_minigame_sync_defuse_set_selection(channel_id, unit_id, is_level_unit, selection)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.defuse)

	minigame:set_selection(selection)
end

function MinigameSystem:rpc_minigame_sync_drill_generate_targets(channel_id, unit_id, is_level_unit, seed)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.drill)

	minigame:generate_targets(seed)
end

function MinigameSystem:rpc_minigame_sync_drill_set_cursor(channel_id, unit_id, is_level_unit, x, y, index)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.drill)

	minigame:set_cursor_position(x, y, index)
end

function MinigameSystem:rpc_minigame_sync_drill_set_search(channel_id, unit_id, is_level_unit, searching, time)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.drill)

	minigame:set_searching(searching and time)
end

function MinigameSystem:rpc_minigame_sync_frequency_set_frequency(channel_id, unit_id, is_level_unit, frequency_x, frequency_y)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.frequency)

	minigame:set_frequency(frequency_x, frequency_y)
end

function MinigameSystem:rpc_minigame_sync_frequency_set_target_frequency(channel_id, unit_id, is_level_unit, frequency_x, frequency_y)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local minigame = extension:minigame(MinigameSettings.types.frequency)

	minigame:set_target_frequency(frequency_x, frequency_y)
end

return MinigameSystem
