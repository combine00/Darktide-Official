require("scripts/extension_systems/interaction/interactee_extension")
require("scripts/extension_systems/interaction/player_interactee_extension")

local InteracteeSystem = class("InteracteeSystem", "ExtensionSystemBase")
local RPCS = {
	"rpc_interaction_started",
	"rpc_interaction_stopped",
	"rpc_interaction_set_active",
	"rpc_interaction_set_missing_player",
	"rpc_interaction_hot_join"
}

function InteracteeSystem:init(...)
	InteracteeSystem.super.init(self, ...)
	self._network_event_delegate:register_session_events(self, unpack(RPCS))
end

function InteracteeSystem:destroy(...)
	self._network_event_delegate:unregister_events(unpack(RPCS))
	InteracteeSystem.super.destroy(self, ...)
end

function InteracteeSystem:rpc_interaction_started(channel_id, unit_id, is_level_unit, game_object_id)
	local interactor_unit = Managers.state.unit_spawner:unit(game_object_id)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:started(interactor_unit)
end

function InteracteeSystem:rpc_interaction_stopped(channel_id, unit_id, is_level_unit, result)
	local result_name = NetworkLookup.interaction_result[result]
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:stopped(result_name)
end

function InteracteeSystem:rpc_interaction_set_active(channel_id, unit_id, is_level_unit, state)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:set_active(state)
end

function InteracteeSystem:rpc_interaction_set_missing_player(channel_id, unit_id, is_level_unit, is_missing)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:set_missing_players(is_missing)
end

function InteracteeSystem:rpc_interaction_hot_join(channel_id, unit_id, is_level_unit, state, is_used, active_type_id)
	local unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]
	local active_type = active_type_id ~= 0 and NetworkLookup.interaction_type_strings[active_type_id] or nil

	extension:hot_join_setup(state, is_used, active_type)
end

return InteracteeSystem
