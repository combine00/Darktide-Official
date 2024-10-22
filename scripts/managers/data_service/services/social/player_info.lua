local FriendInterface = require("scripts/managers/data_service/services/social/friend_interface")
local PresenceInterface = require("scripts/managers/presence/presence_entry")
local PresenceSettings = require("scripts/settings/presence/presence_settings")
local SocialConstants = require("scripts/managers/data_service/services/social/social_constants")
local Promise = require("scripts/foundation/utilities/promise")
local ProfileUtils = require("scripts/utilities/profile_utils")
local PlayerInfo = class("PlayerInfo")
local OnlineStatus = SocialConstants.OnlineStatus
local PartyStatus = SocialConstants.PartyStatus
local FriendStatus = SocialConstants.FriendStatus
local Platforms = SocialConstants.Platforms

function PlayerInfo:init(presence_account_id_change_callback)
	self._presence = nil
	self._platform_social = nil
	self._account_id = nil
	self._account_name = nil
	self._activity_id = nil
	self._friend_status = FriendStatus.none
	self._is_blocked = false
	self._is_party_member = false
	self._is_text_muted = false
	self._is_voice_muted = false
	self._online_status = OnlineStatus.offline
	self._player_unique_id = nil
	self._last_time_played_with = nil
	self._presence_account_id_change_callback = presence_account_id_change_callback
end

function PlayerInfo:destroy()
	return
end

function PlayerInfo:set_account(account_id, account_name)
	if account_id ~= self._account_id or account_name ~= self._account_name then
		self._account_id = account_id
		self._account_name = account_id and account_name

		self:_update_presence()
	end
end

function PlayerInfo:set_platform_social(platform_social)
	if not platform_social then
		self._platform_social = platform_social

		self:_update_presence()

		return
	end

	local old_platform_social = self._platform_social

	if platform_social == old_platform_social then
		return
	elseif platform_social and old_platform_social and platform_social:id() == old_platform_social:id() then
		self._platform_social = platform_social

		return
	end

	self._platform_social = platform_social

	self:_update_presence()
end

function PlayerInfo:platform_social()
	return self._platform_social
end

function PlayerInfo:account_id()
	local presence = self:_get_presence()

	return self._account_id or presence and presence:account_id() ~= "" and presence:account_id()
end

function PlayerInfo:user_display_name(use_stale, no_platform_icon)
	local name = self._user_display_name

	if use_stale and name then
		return name
	end

	local presence = self:_get_presence()
	local platform_social = self._platform_social
	name = presence and presence:platform_persona_name_or_account_name() or platform_social and platform_social:name() or self._account_name or "N/A"
	local platform_icon, color_override = self:platform_icon()

	if platform_icon and not no_platform_icon then
		name = string.format("%s %s", platform_icon, name)
	end

	if not no_platform_icon then
		color_override = nil
	end

	self._user_display_name = name

	return name, color_override
end

function PlayerInfo:platform_icon()
	local presence = self:_get_presence()
	local platform_social = self._platform_social

	if presence then
		return presence:platform_icon()
	elseif platform_social then
		return platform_social:platform_icon()
	end

	return nil
end

function PlayerInfo:online_status(use_stale)
	local online_status = self._online_status

	if use_stale and online_status then
		return online_status
	end

	local platform_social = self._platform_social
	local presence = self:_get_presence()

	if presence and presence:is_online() then
		online_status = OnlineStatus.online
	elseif platform_social then
		online_status = platform_social:online_status()
	elseif presence then
		online_status = OnlineStatus.offline
	end

	if (online_status == OnlineStatus.offline or online_status == OnlineStatus.platform_online) and self._is_party_member then
		online_status = OnlineStatus.reconnecting
	end

	if online_status ~= self._online_status then
		self:_update_presence()
	end

	self._online_status = online_status

	return online_status
end

function PlayerInfo:is_friend()
	local platform_social = self._platform_social

	if platform_social then
		return not self._is_blocked and not platform_social:is_blocked() and self._friend_status ~= FriendStatus.friend and platform_social and platform_social:is_friend() or false
	else
		return not self._is_blocked and self._friend_status == FriendStatus.friend or false
	end
end

function PlayerInfo:friend_status()
	return self._friend_status
end

function PlayerInfo:set_friend_status(status)
	self._friend_status = status
end

function PlayerInfo:platform_friend_status()
	local platform_social = self._platform_social

	return platform_social and (platform_social:is_friend() and FriendStatus.friend or FriendStatus.none)
end

function PlayerInfo:is_blocked()
	local platform_social = self._platform_social

	return self._is_blocked or self._friend_status == FriendStatus.ignored or platform_social and platform_social:is_blocked() or false
end

function PlayerInfo:is_platform_blocked()
	local platform_social = self._platform_social

	return platform_social and platform_social:is_blocked() or false
end

function PlayerInfo:set_is_blocked(is_blocked)
	self._is_blocked = is_blocked
	self._is_text_muted = is_blocked
	self._is_voice_muted = is_blocked

	Managers.event:trigger("player_mute_status_changed", self._account_id)
end

function PlayerInfo:is_text_muted()
	return self._is_text_muted
end

function PlayerInfo:set_is_text_muted(is_muted)
	self._is_text_muted = is_muted

	Managers.event:trigger("player_mute_status_changed", self._account_id)
end

function PlayerInfo:is_voice_muted()
	local platform_user_id = self:platform_user_id()
	local is_platform_muted = Managers.account:is_muted(platform_user_id)

	return is_platform_muted or self._is_voice_muted
end

function PlayerInfo:set_is_voice_muted(is_muted)
	self._is_voice_muted = is_muted

	Managers.event:trigger("player_mute_status_changed", self._account_id)
end

function PlayerInfo:last_time_played_with()
	return self._last_time_played_with
end

function PlayerInfo:set_last_time_played_with(time)
	self._last_time_played_with = time
end

function PlayerInfo:cross_play_disabled()
	local presence = self:_get_presence()

	return presence and presence:cross_play_disabled()
end

function PlayerInfo:cross_play_disabled_in_party()
	local presence = self:_get_presence()

	return presence and presence:cross_play_disabled_in_party()
end

function PlayerInfo:is_cross_playing()
	local presence = self:_get_presence()

	return presence and presence:is_cross_playing()
end

function PlayerInfo:is_myself()
	local presence = self:_get_presence()

	return presence and presence:is_myself()
end

function PlayerInfo:is_platform_friend()
	return self._platform_social ~= nil and self:is_friend()
end

function PlayerInfo:platform()
	local platform_social = self._platform_social
	local presence = self:_get_presence()

	return platform_social and platform_social:platform() or presence and presence:platform() or "Unknown"
end

function PlayerInfo:platform_user_id()
	local platform_social = self._platform_social
	local presence = self:_get_presence()

	return platform_social and platform_social:id() or presence and presence:platform_user_id() or ""
end

function PlayerInfo:player_activity_id()
	local presence = self:_get_presence()

	return presence and presence:activity_id()
end

function PlayerInfo:player_activity_loc_string()
	local activity_id = self:player_activity_id()

	if activity_id then
		return PresenceSettings.settings[activity_id].hud_localization
	end

	return nil
end

function PlayerInfo:character_name()
	if self:is_blocked() then
		return Localize("loc_blocking_player")
	else
		local user_has_restrictions = Managers.account:user_has_restriction()
		local is_own_player = self:is_own_player()
		local profile = self:profile()

		if user_has_restrictions and not is_own_player then
			return profile and ProfileUtils.character_archetype_title(profile, true) or ""
		else
			return profile and profile.name or ""
		end
	end
end

function PlayerInfo:character_level()
	local profile = self:profile()

	return profile and profile.current_level or 0
end

function PlayerInfo:character_id()
	local profile = self:profile()

	return profile and profile.character_id or ""
end

function PlayerInfo:is_own_player()
	return Managers.presence:presence_entry_myself():account_id() == self._account_id
end

function PlayerInfo:num_party_members()
	local presence = self:_get_presence()

	return presence and presence:num_party_members() or 1
end

function PlayerInfo:num_mission_members()
	local presence = self:_get_presence()

	return presence and presence:num_mission_members() or 1
end

function PlayerInfo:party_status()
	local presence = self:_get_presence()
	local party_manager = Managers.party_immaterium

	if presence and party_manager then
		local account_id = self:account_id()
		local party_member = party_manager:member_from_account_id(account_id)

		if party_manager:get_invite_by_account_id(account_id) then
			return PartyStatus.invite_pending
		elseif party_member and presence:num_party_members() > 1 then
			return PartyStatus.mine
		elseif self._is_party_member then
			return PartyStatus.same_mission
		elseif presence:num_party_members() > 1 then
			return PartyStatus.other
		end
	end

	return PartyStatus.none
end

function PlayerInfo:set_is_party_member(is_member)
	self._is_party_member = is_member
end

function PlayerInfo:party_id()
	local presence = self:_get_presence()

	return presence and presence:party_id()
end

function PlayerInfo:peer_id()
	local presence = self:_get_presence()

	if presence then
		local account_id = self:account_id()
		local players = Managers.player:players()

		for _, player in pairs(players) do
			if player:account_id() == account_id then
				return player:peer_id()
			end
		end
	end

	return nil
end

function PlayerInfo:profile()
	local player_unique_id = self._player_unique_id
	local player = player_unique_id and Managers.player:human_player(player_unique_id)

	if player then
		return player:profile()
	else
		local account_id = self:account_id()
		local players = Managers.player:human_players()

		for unique_id, player in pairs(players) do
			if player:account_id() == account_id then
				self._player_unique_id = unique_id

				return player:profile()
			end
		end
	end

	local presence = self:_get_presence()
	local profile = presence and presence:character_profile()

	return profile
end

function PlayerInfo:first_update_promise()
	local presence = self:_get_presence()

	return presence:first_update_promise():next(function (presence)
		return self
	end)
end

function PlayerInfo:_update_presence()
	local platform_social = self._platform_social

	if self._account_id then
		self._presence = Managers.presence:get_presence(self._account_id)
	elseif platform_social and (platform_social:online_status() == OnlineStatus.platform_online or platform_social:platform() == Platforms.xbox) then
		local promise = nil
		self._presence, promise = Managers.presence:get_presence_by_platform(self._platform_social:platform(), self._platform_social:id())

		promise:next(function ()
			local presence = self._presence
			local account_id = self._account_id or ""

			if presence:account_id() ~= account_id then
				self._account_id = presence:account_id()
				self._account_name = presence:account_name()

				self:_presence_account_id_change_callback()
			end
		end)
	end
end

function PlayerInfo:_get_presence()
	local presence = self._presence

	if presence and presence:is_alive() then
		return presence
	else
		self._presence = nil

		self:_update_presence()

		return self._presence
	end
end

function PlayerInfo:__tostring()
	return string.format("account_id: [%s], has platform_social: %s, has presence: %s", self._account_id, self._platform_social and "Yes" or "No", self._presence and "Yes" or "No")
end

return PlayerInfo
