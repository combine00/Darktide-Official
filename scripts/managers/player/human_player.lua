local PlayerManager = require("scripts/foundation/managers/player/player_manager")
local HumanPlayer = class("HumanPlayer")

function HumanPlayer:init(unique_id, session_id, channel_id, peer_id, local_player_id, profile, slot, account_id, viewport_name, telemetry_game_session, last_mission_id)
	self.player_unit = nil
	self.viewport_name = viewport_name
	self.owned_units = {}
	self.sensitivity = 1
	self.aim_assist_data = self:_create_aim_assist_data()
	self._telemetry_game_session = telemetry_game_session

	if self:type() == "HumanPlayer" then
		self._debug_name = "Local #" .. peer_id:sub(-3, -1)
	elseif self:type() == "BotPlayer" then
		self._debug_name = string.format("Bot Player %d", local_player_id)
	end

	self._session_id = session_id
	self._unique_id = unique_id
	self._peer_id = peer_id
	self._local_player_id = local_player_id
	self._account_id = account_id
	self._cached_name = nil
	self._orientation = {
		yaw = 0,
		pitch = 0,
		roll = 0
	}
	self._game_state_object = nil
	self._slot = slot
	self._is_spectating = false
	self._spectated_by = {}
	self._wanted_spawn_point = nil

	self:set_profile(profile)
end

function HumanPlayer:type()
	return "HumanPlayer"
end

function HumanPlayer:set_wanted_spawn_point(wanted_spawn_point)
	self._wanted_spawn_point = wanted_spawn_point
end

function HumanPlayer:wanted_spawn_point()
	return self._wanted_spawn_point
end

function HumanPlayer:set_slot(slot)
	self._slot = slot
end

function HumanPlayer:slot()
	return self._slot
end

function HumanPlayer:session_id()
	return self._session_id
end

function HumanPlayer:connection_channel_id()
	return
end

function HumanPlayer:channel_id()
	return
end

function HumanPlayer:unique_id()
	return self._unique_id
end

function HumanPlayer:peer_id()
	return self._peer_id
end

function HumanPlayer:local_player_id()
	return self._local_player_id
end

function HumanPlayer:account_id()
	return self._account_id
end

function HumanPlayer:character_id()
	local profile = self._profile

	return profile and profile.character_id
end

function HumanPlayer:is_human_controlled()
	return true
end

function HumanPlayer:name()
	if self._profile and self._profile.name then
		return self._profile.name
	elseif HAS_STEAM then
		local cached_name = self._cached_name

		if cached_name then
			return cached_name
		end

		cached_name = Steam.user_name(Steam.user_id())
		self._cached_name = cached_name

		return cached_name
	else
		return self._debug_name
	end
end

function HumanPlayer:set_profile(profile)
	self._profile = profile
	self._telemetry_subject = {
		account_id = self._account_id,
		character_id = self:character_id()
	}

	Managers.event:trigger("event_player_set_profile", self, profile)
end

function HumanPlayer:profile()
	return self._profile
end

function HumanPlayer:has_local_profile()
	return self._account_id == PlayerManager.NO_ACCOUNT_ID or type(self:character_id()) == "number"
end

function HumanPlayer:archetype_name()
	return self._profile.archetype.name
end

function HumanPlayer:breed_name()
	return self._profile.archetype.breed
end

function HumanPlayer:companion_name()
	local companion_data = self._profile.companion

	return companion_data and companion_data.name or nil
end

function HumanPlayer:telemetry_game_session()
	return self._telemetry_game_session
end

function HumanPlayer:telemetry_subject()
	return self._telemetry_subject
end

function HumanPlayer:destroy()
	return
end

function HumanPlayer:set_orientation(yaw, pitch, roll)
	self._orientation.yaw = math.mod_two_pi(yaw)
	self._orientation.pitch = math.mod_two_pi(pitch)
	self._orientation.roll = math.mod_two_pi(roll)
end

function HumanPlayer:get_orientation()
	return self._orientation
end

function HumanPlayer:unit_is_alive()
	local player_unit = self.player_unit

	return player_unit and Unit.alive(player_unit)
end

function HumanPlayer:_create_aim_assist_data()
	local aim_assist_data = {}

	return aim_assist_data
end

implements(HumanPlayer, PlayerManager.PLAYER_INTERFACE)

return HumanPlayer
