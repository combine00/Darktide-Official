local MinigameSettings = require("scripts/settings/minigame/minigame_settings")
local NetworkLookup = require("scripts/network_lookup/network_lookup")
local MinigameBase = class("MinigameBase")

function MinigameBase:init(unit, is_server, seed, wwise_world)
	self._minigame_unit = unit
	self._is_server = is_server
	self._current_state = MinigameSettings.game_states.none
	self._seed = seed
	self._player_session_id = nil
	self._wwise_world = wwise_world
	self._current_stage = nil
	self._state_started = nil

	if is_server then
		self._fx_extension = nil
		self._fx_source_name = nil
	end

	local unit_spawner_manager = Managers.state.unit_spawner
	self._is_level_unit, self._minigame_unit_id = unit_spawner_manager:game_object_id_or_level_index(unit)
end

function MinigameBase:setup_game()
	self:set_state(MinigameSettings.game_states.intro)
end

function MinigameBase:hot_join_sync(sender, channel)
	if self._current_state ~= MinigameSettings.game_states.none then
		local state_lookup_id = NetworkLookup.minigame_game_states[self._current_state]

		self:send_rpc_to_channel(channel, "rpc_minigame_sync_game_state", state_lookup_id)
	end

	local current_decode_stage = self._current_stage

	if current_decode_stage then
		self:send_rpc_to_channel(channel, "rpc_minigame_sync_set_stage", current_decode_stage)
	end
end

function MinigameBase:decode_interrupt()
	return
end

function MinigameBase:start(player_or_nil)
	self._player_session_id = player_or_nil and player_or_nil:session_id()
end

function MinigameBase:set_state(state)
	self._current_state = self:handle_state(state)

	if self._is_server and self._current_state ~= MinigameSettings.game_states.none then
		local state_lookup_id = NetworkLookup.minigame_game_states[self._current_state]

		self:send_rpc("rpc_minigame_sync_game_state", state_lookup_id)
	end
end

function MinigameBase:handle_state(state)
	local states = MinigameSettings.game_states

	if state == states.intro then
		state = MinigameSettings.game_states.gameplay
	elseif state == states.transition and self:is_completed() then
		state = MinigameSettings.game_states.outro
	end

	return state
end

function MinigameBase:state()
	return self._current_state
end

function MinigameBase:stop()
	self._player_session_id = nil
end

function MinigameBase:complete()
	return
end

function MinigameBase:player_session_id()
	return self._player_session_id
end

function MinigameBase:is_completed()
	local stage_amount = self._stage_amount
	local current_stage = self._current_stage

	if current_stage and current_stage then
		return stage_amount < current_stage
	end

	return false
end

function MinigameBase:should_exit()
	return self:is_completed()
end

function MinigameBase:uses_action()
	return true
end

function MinigameBase:uses_joystick()
	return false
end

function MinigameBase:update(dt, t)
	return
end

function MinigameBase:on_action_pressed(t)
	return
end

function MinigameBase:on_action_released(t)
	return
end

function MinigameBase:on_axis_set(t, x, y)
	return
end

function MinigameBase:send_rpc(rpc_name, ...)
	Managers.state.game_session:send_rpc_clients(rpc_name, self._minigame_unit_id, self._is_level_unit, ...)
end

function MinigameBase:send_rpc_to_server(rpc_name, ...)
	Managers.state.game_session:send_rpc_server(rpc_name, self._minigame_unit_id, self._is_level_unit, ...)
end

function MinigameBase:send_rpc_to_channel(channel, rpc_name, ...)
	local rpc = RPC[rpc_name]

	rpc(channel, self._minigame_unit_id, self._is_level_unit, ...)
end

function MinigameBase:_setup_sound(player, fx_source_name)
	local player_unit = player.player_unit
	local visual_loadout_extension = ScriptUnit.extension(player_unit, "visual_loadout_system")
	local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
	local inventory_component = unit_data_extension:read_component("inventory")
	local fx_sources = visual_loadout_extension:source_fx_for_slot(inventory_component.wielded_slot)
	self._fx_extension = ScriptUnit.extension(player_unit, "fx_system")
	self._fx_source_name = fx_sources[fx_source_name]
end

function MinigameBase:play_sound(alias, sync_with_clients, include_client)
	if self._fx_extension then
		sync_with_clients = sync_with_clients == nil and true
		include_client = include_client == nil and true

		if self._fx_extension:sound_source(self._fx_source_name) then
			self._fx_extension:trigger_gear_wwise_event_with_source(alias, nil, self._fx_source_name, sync_with_clients, include_client)
		end
	end
end

function MinigameBase:set_parameter_sound(parameter_name, parameter_value)
	if self._fx_extension and self._fx_extension:sound_source(self._fx_source_name) then
		self._fx_extension:set_source_parameter(parameter_name, parameter_value, self._fx_source_name)
	end
end

function MinigameBase:current_stage()
	return self._current_stage
end

function MinigameBase:set_current_stage(stage)
	if self._current_stage then
		if stage < self._current_stage then
			Unit.flow_event(self._minigame_unit, "lua_minigame_fail")
		elseif self._current_stage < stage then
			if self._stage_amount < stage then
				Unit.flow_event(self._minigame_unit, "lua_minigame_success_last")
			else
				Unit.flow_event(self._minigame_unit, "lua_minigame_success")
			end
		end
	end

	self._current_stage = stage
end

function MinigameBase:progressing()
	return false
end

return MinigameBase
