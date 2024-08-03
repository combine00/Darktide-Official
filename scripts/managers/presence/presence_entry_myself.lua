local PresenceEntryInterface = require("scripts/managers/presence/presence_entry")
local PresenceSettings = require("scripts/settings/presence/presence_settings")
local Promise = require("scripts/foundation/utilities/promise")
local PresenceEntryMyself = class("PresenceEntryMyself")

function PresenceEntryMyself.get_platform()
	local platform = nil
	local authenticate_method = Managers.backend:get_auth_method()

	if authenticate_method == Managers.backend.AUTH_METHOD_STEAM and HAS_STEAM then
		platform = "steam"
	elseif authenticate_method == Managers.backend.AUTH_METHOD_XBOXLIVE and PLATFORM == "win32" then
		platform = "xbox"
	elseif authenticate_method == Managers.backend.AUTH_METHOD_XBOXLIVE and Application.xbox_live and Application.xbox_live() == true then
		platform = "xbox"
	else
		Log.warning("PresenceEntryMyself", "Could not resolve a platform for authenticate_method: " .. tostring(authenticate_method))

		platform = "unknown"
	end

	return platform
end

function PresenceEntryMyself:init()
	local platform = self.get_platform()
	self._platform = platform
	self._profile_version_counter = 1

	self:set_activity_id("splash_screen")
end

function PresenceEntryMyself:reset()
	self._character_profile = nil
	self._party_id = nil
	self._num_party_members = nil
	self._num_mission_members = nil
	self._cross_play_disabled = nil
	self._cross_play_disabled_in_party = nil
	self._is_cross_playing = nil
end

function PresenceEntryMyself:account_id()
	return gRPC.get_account_id()
end

function PresenceEntryMyself:account_name()
	return Managers.account:user_display_name()
end

function PresenceEntryMyself:activity_id()
	return self._activity_id
end

function PresenceEntryMyself:activity_localized()
	local hud_localization = PresenceSettings.settings[self:activity_id()].hud_localization

	return Managers.localization:localize(hud_localization)
end

function PresenceEntryMyself:set_activity_id(activity_id)
	self._activity_id = activity_id
end

function PresenceEntryMyself:character_id()
	return self:character_profile() and self:character_profile().character_id or ""
end

function PresenceEntryMyself:character_name()
	return self:character_profile() and self:character_profile().name or ""
end

function PresenceEntryMyself:character_profile()
	return self._character_profile
end

function PresenceEntryMyself:account_and_platform_composite_id()
	return "myself"
end

function PresenceEntryMyself:first_update_promise()
	return Promise.resolved(self)
end

function PresenceEntryMyself:set_character_profile(character_profile)
	local profile_version_counter = self._profile_version_counter + 1
	self._profile_version_counter = profile_version_counter
	character_profile.hash = profile_version_counter
	self._character_profile = character_profile
end

function PresenceEntryMyself:platform()
	return self._platform
end

function PresenceEntryMyself:platform_icon()
	local platform = self._platform

	if platform == "steam" then
		return ""
	elseif platform == "xbox" then
		return ""
	elseif platform == "psn" then
		return ""
	end

	return nil
end

function PresenceEntryMyself:platform_user_id()
	return Managers.account:platform_user_id()
end

function PresenceEntryMyself:is_myself()
	return true
end

function PresenceEntryMyself:is_online()
	return true
end

function PresenceEntryMyself:platform_persona_name_or_account_name()
	return self:account_name()
end

function PresenceEntryMyself:num_party_members()
	return tonumber(self._num_party_members) or 0
end

function PresenceEntryMyself:set_num_party_members(num_party_members)
	self._num_party_members = tostring(num_party_members)
end

function PresenceEntryMyself:num_mission_members()
	return tonumber(self._num_mission_members) or 0
end

function PresenceEntryMyself:set_num_mission_members(num_mission_members)
	self._num_mission_members = tostring(num_mission_members)
end

function PresenceEntryMyself:party_id()
	return self._party_id
end

function PresenceEntryMyself:set_party_id(party_id)
	self._party_id = party_id
end

function PresenceEntryMyself:cross_play_disabled()
	return self._cross_play_disabled == "true"
end

function PresenceEntryMyself:set_cross_play_disabled(disabled)
	self._cross_play_disabled = disabled and "true" or "false"
end

function PresenceEntryMyself:cross_play_disabled_in_party()
	return self._cross_play_disabled_in_party == "true"
end

function PresenceEntryMyself:set_cross_play_disabled_in_party(disabled)
	self._cross_play_disabled_in_party = disabled and "true" or "false"
end

function PresenceEntryMyself:is_cross_playing()
	return self._is_cross_playing == "true"
end

function PresenceEntryMyself:set_is_cross_playing(value)
	self._is_cross_playing = value and "true" or "false"
end

function PresenceEntryMyself:is_alive()
	return true
end

local key_values = {}

function PresenceEntryMyself:create_key_values(white_list)
	table.clear(key_values)

	if (not white_list or white_list.character_profile) and self._character_profile then
		key_values.character_id = self._character_profile.character_id
	end

	if not white_list or white_list.activity_id then
		key_values.activity_id = self._activity_id
	end

	if not white_list or white_list.party_id then
		key_values.party_id = self._party_id
	end

	if not white_list or white_list.num_party_members then
		key_values.num_party_members = self._num_party_members
	end

	if not white_list or white_list.num_mission_members then
		key_values.num_mission_members = self._num_mission_members
	end

	if not white_list or white_list.cross_play_disabled then
		key_values.cross_play_disabled = self._cross_play_disabled
	end

	if not white_list or white_list.cross_play_disabled_in_party then
		key_values.cross_play_disabled_in_party = self._cross_play_disabled_in_party
	end

	if not white_list or white_list.is_cross_playing then
		key_values.is_cross_playing = self._is_cross_playing
	end

	return key_values
end

implements(PresenceEntryMyself, PresenceEntryInterface)

return PresenceEntryMyself
