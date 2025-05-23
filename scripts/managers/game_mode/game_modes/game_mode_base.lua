local AfkChecker = require("scripts/managers/game_mode/afk_checker")
local GameModeSettings = require("scripts/settings/game_mode/game_mode_settings")
local GameModeBase = class("GameModeBase")
GameModeBase.INTERFACE = {
	"server_update",
	"complete",
	"fail",
	"evaluate_end_conditions",
	"on_player_unit_spawn",
	"on_player_unit_despawn",
	"can_spawn_player",
	"player_time_until_spawn",
	"cleanup_game_mode_units"
}
local CLIENT_RPCS = {
	"rpc_change_game_mode_state",
	"rpc_client_set_local_player_orientation"
}

local function _log(...)
	Log.info("GameModeBase", ...)
end

function GameModeBase:init(game_mode_context, game_mode_name, network_event_delegate)
	self._name = game_mode_name
	self._world = game_mode_context.world
	self._is_server = game_mode_context.is_server
	local settings = GameModeSettings[game_mode_name]
	self._settings = settings
	local states = settings.states
	self._states = states
	self._states_lookup = table.mirror_table(states)
	self._state = states[1]

	if not self._is_server then
		network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))

		self._network_event_delegate = network_event_delegate
	end

	if not DEDICATED_SERVER and settings.cache_local_player_profile then
		local local_player_id = 1
		local player = Managers.player:local_player(local_player_id)
		local player_profile = player:profile()
		self._cached_player_profile = table.clone_instance(player_profile)
	end

	if settings.afk_check then
		self._afk_checker = AfkChecker:new(self._is_server, settings.afk_check, network_event_delegate)
	end
end

function GameModeBase:on_gameplay_init()
	return
end

function GameModeBase:on_gameplay_post_init()
	return
end

function GameModeBase:can_player_enter_game()
	return true
end

function GameModeBase:destroy()
	if not self._is_server then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end

	local settings = self._settings

	if not DEDICATED_SERVER and settings.cache_local_player_profile then
		local cached_profile = self._cached_player_profile
		local player = Managers.player:local_player(1)

		player:set_profile(cached_profile)
	end

	if self._afk_checker then
		self._afk_checker:delete()

		self._afk_checker = nil
	end
end

function GameModeBase:server_update(dt, t)
	if self._afk_checker then
		self._afk_checker:server_update(dt, t)
	end
end

function GameModeBase:client_update(dt, t)
	if self._afk_checker then
		self._afk_checker:client_update(dt, t)
	end
end

function GameModeBase:name()
	return self._name
end

function GameModeBase:settings()
	return self._settings
end

function GameModeBase:state()
	return self._state
end

function GameModeBase:on_player_unit_spawn(player, unit, is_respawn)
	return
end

function GameModeBase:on_player_unit_despawn(player)
	return
end

function GameModeBase:can_spawn_player(player)
	return true
end

function GameModeBase:player_time_until_spawn(player)
	return nil
end

function GameModeBase:cleanup_game_mode_dynamic_lavels()
	return
end

function GameModeBase:cleanup_game_mode_units()
	local bot_backfilling_allowed = self._settings.bot_backfilling_allowed

	if bot_backfilling_allowed then
		Managers.state.player_unit_spawn:remove_all_bots()
	end
end

function GameModeBase:_change_state(new_state)
	local old_state = self._state

	_log("[_change_state] Switching game mode state from %q to %q", old_state, new_state)
	self:_game_mode_state_changed(new_state, old_state)

	self._state = new_state

	if self._is_server then
		local new_state_id = self._states_lookup[new_state]

		Managers.state.game_session:send_rpc_clients("rpc_change_game_mode_state", new_state_id)
	end
end

function GameModeBase:_game_mode_state_changed(new_state, old_state)
	return
end

function GameModeBase:rpc_change_game_mode_state(channel_id, new_state_id)
	local new_state = self._states_lookup[new_state_id]

	self:_change_state(new_state)
end

function GameModeBase:rpc_client_set_local_player_orientation(channel_id, yaw, pitch, roll)
	local player_manager = Managers.player
	local local_player = player_manager:local_player(1)

	local_player:set_orientation(yaw, pitch, roll)
end

function GameModeBase:hot_join_sync(sender, channel)
	local state = self._state
	local state_id = self._states_lookup[state]

	if state_id ~= 1 then
		RPC.rpc_change_game_mode_state(channel, state_id)
	end
end

function GameModeBase:_cinematic_active()
	if Managers.state.cinematic:cinematic_active() then
		return true
	end

	local cinematic_scene_system = Managers.state.extension:system("cinematic_scene_system")

	return cinematic_scene_system:is_active()
end

function GameModeBase:should_spawn_dead(player)
	return false
end

function GameModeBase:get_additional_pickups()
	return nil
end

return GameModeBase
