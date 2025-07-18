local FixedFrame = require("scripts/utilities/fixed_frame")
local HuskCoherencyExtension = class("HuskCoherencyExtension")
local EMPTY_TABLE = {}
local RPCS = {
	"rpc_player_unit_enter_coherency",
	"rpc_player_unit_exit_coherency"
}

function HuskCoherencyExtension:init(extension_init_context, unit, extension_init_data, game_session, game_object_id)
	self._unit = unit
	self._coherency_buff_units = {}
	self._num_units_in_coherence = 0
	self._game_object_id = Managers.state.unit_spawner:game_object_id(self._unit)
	self._network_event_delegate = extension_init_context.network_event_delegate

	self._network_event_delegate:register_session_unit_events(self, self._game_object_id, unpack(RPCS))
end

function HuskCoherencyExtension:destroy()
	self._network_event_delegate:unregister_unit_events(self._game_object_id, unpack(RPCS))
end

function HuskCoherencyExtension:in_coherence_units()
	return self._coherency_buff_units
end

function HuskCoherencyExtension:buff_template_names()
	return EMPTY_TABLE
end

function HuskCoherencyExtension:external_buff_template_names()
	return EMPTY_TABLE
end

function HuskCoherencyExtension:num_units_in_coherency()
	return self._num_units_in_coherence
end

function HuskCoherencyExtension:add_external_buff()
	return
end

function HuskCoherencyExtension:remove_external_buffs()
	return
end

function HuskCoherencyExtension:on_coherency_enter(coherency_unit, coherency_buff_extension, t)
	self._num_units_in_coherence = self._num_units_in_coherence + 1
	self._coherency_buff_units[coherency_unit] = true
end

function HuskCoherencyExtension:on_coherency_exit(coherency_unit, coherency_buff_extension, t)
	self._coherency_buff_units[coherency_unit] = nil
	self._num_units_in_coherence = self._num_units_in_coherence - 1
end

function HuskCoherencyExtension:update(unit, dt, t)
	return
end

function HuskCoherencyExtension:rpc_player_unit_enter_coherency(channel_id, game_object_id, enter_game_object_id)
	local enter_unit = Managers.state.unit_spawner:unit(enter_game_object_id)
	local t = FixedFrame.get_latest_fixed_time()

	self:on_coherency_enter(enter_unit, nil, t)
end

function HuskCoherencyExtension:rpc_player_unit_exit_coherency(channel_id, game_object_id, exit_game_object_id)
	local exit_unit = Managers.state.unit_spawner:unit(exit_game_object_id)
	local t = FixedFrame.get_latest_fixed_time()

	self:on_coherency_exit(exit_unit, nil, t)
end

local function _is_controlled_by_local_player(unit)
	local player = Managers.state.player_unit_spawn:owner(unit)

	if not player then
		return
	end

	local is_player_remote = player.remote
	local is_human_controlled = player:is_human_controlled()
	local is_local_human = not is_player_remote and is_human_controlled

	return is_local_human
end

return HuskCoherencyExtension
