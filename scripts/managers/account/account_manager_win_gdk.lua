local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local XboxLiveUtils = require("scripts/foundation/utilities/xbox_live_utils")
local Promise = require("scripts/foundation/utilities/promise")
local RegionRestrictionsXboxLive = require("scripts/settings/region/region_restrictions_xbox_live")
local XboxPrivileges = require("scripts/managers/account/xbox_privileges")
local AccountManagerWinGDK = class("AccountManagerWinGDK", "AccountManagerBase")
local SIGNIN_STATES = {
	fetching_privileges = "loc_signin_fetch_privileges",
	fetching_sandbox_id = "loc_signin_fetch_sandbox_id",
	idle = "",
	signin_profile = "loc_signin_acquiring_user_profile"
}

function AccountManagerWinGDK:init()
	self._xbox_privileges = XboxPrivileges:new()
	self._signin_state = SIGNIN_STATES.idle
	self._friends = {}

	self:_setup_region()
end

function AccountManagerWinGDK:reset()
	if self._social_groups_created_id then
		XSocialManager.remove_local_user(self._social_groups_created_id)
	end

	self._social_groups_created_id = nil

	table.clear(self._friends)

	self._signin_callback = nil
	self._popup_id = nil
	self._leave_game = nil
	self._network_fatal_error = nil
	self._network_connectivity = nil
	self._wanted_state = nil
	self._wanted_state_params = nil
	self._signin_state = SIGNIN_STATES.idle
	self._is_guest = nil
	self._xuid = nil
	self._user_id = nil
	self._gamertag = nil
	self._mute_list = {}
	self._block_list = {}
	self._block_list_refreshed = false
	self._communication_restriction_iteration = self._communication_restriction_iteration or 1
end

function AccountManagerWinGDK:signin_profile(signin_callback)
	local success_cb = callback(self, "_cb_user_signed_in")
	local fail_cb = callback(self, "_show_fatal_error", "loc_popup_header_error", "loc_user_signin_failed_desc")

	if not self:verify_connection() then
		fail_cb()

		return
	end

	local async_task = nil
	local users = XUser.users()

	if #users > 1 then
		async_task = XUser.add_user_async(XUserAddOptions.None)
	else
		async_task = XUser.add_user_async(XUserAddOptions.AddDefaultUserAllowingUI)
	end

	if async_task then
		Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)
	else
		fail_cb()
	end

	self._signin_state = SIGNIN_STATES.signin_profile
	self._signin_callback = signin_callback
end

function AccountManagerWinGDK:signin_state()
	return self._signin_state
end

function AccountManagerWinGDK:user_id()
	return self._user_id
end

function AccountManagerWinGDK:platform_user_id()
	return self._xuid
end

function AccountManagerWinGDK:user_display_name()
	return self._gamertag
end

function AccountManagerWinGDK:is_guest()
	return self._is_guest
end

function AccountManagerWinGDK:get_privilege(privilege)
	return self._xbox_privileges:has_privilege(privilege)
end

function AccountManagerWinGDK:sandbox_id()
	return self._sandbox_id
end

function AccountManagerWinGDK:friends_list_has_changes()
	return XSocialManager.is_dirty()
end

local ADDED_FRIENDS = {}

function AccountManagerWinGDK:get_friends(do_fetch)
	if do_fetch or XSocialManager.is_dirty() then
		table.clear(self._friends)
		table.clear(ADDED_FRIENDS)

		local title_online_friends = XSocialManager.social_group(self._title_online_friends_id)

		for i = 1, #title_online_friends do
			local friend = title_online_friends[i]

			if not ADDED_FRIENDS[friend.xuid] then
				friend.title_online = true
				friend.is_online = true
				self._friends[#self._friends + 1] = friend
			end

			ADDED_FRIENDS[friend.xuid] = true
		end

		local online_friends = XSocialManager.social_group(self._online_friends_id)

		for i = 1, #online_friends do
			local friend = online_friends[i]

			if not ADDED_FRIENDS[friend.xuid] then
				friend.title_online = false
				friend.is_online = true
				self._friends[#self._friends + 1] = friend
			end

			ADDED_FRIENDS[friend.xuid] = true
		end

		local offline_friends = XSocialManager.social_group(self._offline_friends_id)

		for i = 1, #offline_friends do
			local friend = offline_friends[i]

			if not ADDED_FRIENDS[friend.xuid] then
				friend.title_online = false
				friend.is_online = false
				self._friends[#self._friends + 1] = friend
			end

			ADDED_FRIENDS[friend.xuid] = true
		end
	end

	return self._friends
end

function AccountManagerWinGDK:xuid()
	return self._xuid
end

function AccountManagerWinGDK:xbox_live_block_list()
	local promise = Promise:new()

	if self._block_list_refreshed then
		promise:resolve(table.clone(self._block_list))
	else
		XboxLiveUtils.get_block_list():next(function (block_list)
			self._block_list = block_list
			self._block_list_refreshed = true

			promise:resolve(table.clone(block_list))
		end):catch(function (err)
			promise:reject(err)
		end)
	end

	return promise
end

function AccountManagerWinGDK:refresh_communication_restrictions()
	XboxLiveUtils.get_mute_list():next(function (mute_list)
		self._mute_list = mute_list

		self:xbox_live_block_list():next(function ()
			self._communication_restriction_iteration = self._communication_restriction_iteration + 1

			self:fetch_crossplay_restrictions()
		end)
	end)
end

function AccountManagerWinGDK:communication_restriction_iteration()
	return self._communication_restriction_iteration
end

function AccountManagerWinGDK:is_muted(xuid)
	return table.find(self._mute_list, xuid) ~= nil or self:is_blocked() or self:user_has_restriction(xuid, XblPermission.CommunicateUsingVoice)
end

function AccountManagerWinGDK:is_blocked(xuid)
	return table.find(self._block_list, xuid) ~= nil
end

function AccountManagerWinGDK:fetch_crossplay_restrictions()
	self._xbox_privileges:fetch_crossplay_restrictions()
end

function AccountManagerWinGDK:has_crossplay_restriction(relation, restriction)
	local has_restriction = self._xbox_privileges:has_crossplay_restriction(relation, restriction)

	return has_restriction
end

function AccountManagerWinGDK:wanted_transition()
	return self._wanted_state, self._wanted_state_params
end

function AccountManagerWinGDK:leaving_game()
	return self._leave_game
end

function AccountManagerWinGDK:verify_gdk_store_account(optional_callback, hide_dialog)
	local xuid = XboxLive.xuid_hex_to_dec(self._xuid)
	local success, error_code = XboxLive.verify_ms_store_account(xuid)

	if success then
		if optional_callback then
			optional_callback()
		end

		return true
	end

	if not hide_dialog then
		if error_code == GDKStoreErrors.MISMATCHED_ACCOUNTS then
			self:_show_store_account_error("loc_ms_store_popup_header_error", "loc_ms_store_mismatched_accounts", optional_callback)
		elseif error_code == GDKStoreErrors.MISMATCHED_XUID then
			self:_show_store_account_error("loc_ms_store_popup_header_error", "loc_ms_store_mismatched_xuid", optional_callback)
		elseif error_code == GDKStoreErrors.MISSING_STORE_ACCOUNT_ID then
			self:_show_store_account_error("loc_ms_store_popup_header_error", "loc_ms_store_missing_store_id", optional_callback)
		elseif error_code == GDKStoreErrors.READ_ERROR then
			self:_show_store_account_error("loc_ms_store_popup_header_error", "loc_ms_store_read_error", optional_callback)
		end
	end

	return false
end

function AccountManagerWinGDK:verify_user_restriction(xuid, restriction, optional_callback)
	self._xbox_privileges:verify_user_restriction(xuid, restriction, optional_callback)
end

function AccountManagerWinGDK:verify_user_restriction_batched(xuid, restriction, batch_type)
	self._xbox_privileges:verify_user_restriction_batched(xuid, restriction, batch_type)
end

function AccountManagerWinGDK:user_has_restriction(xuid, restriction)
	return self._xbox_privileges:user_has_restriction(xuid, restriction)
end

function AccountManagerWinGDK:user_restriction_verified(xuid, restriction)
	return self._xbox_privileges:user_restriction_verified(xuid, restriction)
end

function AccountManagerWinGDK:update(dt, t)
	if not self._user_id or self._network_fatal_error or self._leave_game then
		return
	end

	self:verify_connection()
	self._xbox_privileges:update(dt, t)
end

KILL = false

function AccountManagerWinGDK:verify_connection()
	local network_connectivity = KILL and 2 or XboxLive.get_network_connectivity()

	if network_connectivity ~= NetworkConnectivity.ACTIVE and not self._network_fatal_error then
		self:_show_fatal_error("loc_popup_header_error", "loc_signed_in_multiplayer_privilege_fail_desc")

		self._network_fatal_error = true
		self._network_connectivity = network_connectivity
	end

	return self._network_fatal_error == nil
end

function AccountManagerWinGDK:user_detached()
	return self._popup_id or self._network_fatal_error or self._leave_game
end

function AccountManagerWinGDK:region_has_restriction(restriction)
	return not not self._region_restrictions[restriction]
end

function AccountManagerWinGDK:do_re_signin()
	return false
end

function AccountManagerWinGDK:destroy()
	return
end

function AccountManagerWinGDK:show_profile_picker()
	return
end

function AccountManagerWinGDK:_cb_user_signed_in(async_block)
	local user_id = XUser.get_user_result(async_block)

	self:_set_user_data(user_id)
	self._xbox_privileges:fetch_all_privileges(self._user_id, callback(self, "_cb_privileges_updated"))

	self._signin_state = SIGNIN_STATES.fetching_privileges
end

function AccountManagerWinGDK:_set_user_data(user_id)
	local user_info = XUser.user_info(user_id)
	local gamertag = XUser.get_gamertag(user_id)
	self._is_guest = user_info.guest
	self._xuid = user_info.xuid
	self._user_id = user_id
	self._gamertag = gamertag

	Crashify.print_property("gdk_user_id", self._user_id)
	Crashify.print_property("gdk_gamertag", self._gamertag)
	Crashify.print_property("gdk_xuid", self._xuid)
	Crashify.print_property("guest", self._is_guest)
end

function AccountManagerWinGDK:_cb_privileges_updated()
	if self._xbox_privileges:has_error() then
		self:_show_fatal_error("loc_popup_header_error", "loc_privilege_fetch_fail_desc")

		return
	end

	if not self._xbox_privileges:has_privilege(XUserPrivilege.Multiplayer) then
		self:_show_fatal_error("loc_popup_header_error", "loc_multiplayer_privilege_fail_desc")

		return
	end

	local success_cb = callback(self, "_cb_sanbox_id_fetched")
	local fail_cb = callback(self, "_show_fatal_error", "loc_popup_header_error", "loc_user_signin_failed_desc")
	local async_task, error_code = XboxLive.get_sandbox_id_async()

	if async_task then
		Managers.xasync:wrap(async_task):next(success_cb, fail_cb)

		self._signin_state = SIGNIN_STATES.fetching_sandbox_id
	else
		fail_cb()
	end
end

function AccountManagerWinGDK:_cb_sanbox_id_fetched(async_block)
	local sandbox_id, error_code = XboxLive.get_sandbox_id_async_result(async_block)

	if not sandbox_id then
		self:_show_fatal_error("loc_popup_header_error", "loc_user_signin_failed_desc")

		return
	end

	self._sandbox_id = sandbox_id

	self:_setup_friends_list()
end

function AccountManagerWinGDK:_setup_friends_list()
	if not self._user_id then
		self:_show_fatal_error("loc_popup_header_error", "loc_user_signin_failed_desc")

		return
	end

	local error_code = XSocialManager.add_local_user(self._user_id)

	if error_code == nil then
		self._title_online_friends_id = XSocialManager.create_social_group(self._user_id, XPresenceFilter.TitleOnline, XRelationshipFilter.Friends)
		self._online_friends_id = XSocialManager.create_social_group(self._user_id, XPresenceFilter.AllOnline, XRelationshipFilter.Friends)
		self._offline_friends_id = XSocialManager.create_social_group(self._user_id, XPresenceFilter.AllOffline, XRelationshipFilter.Friends)
		self._social_groups_created_id = self._user_id
	else
		self:_show_fatal_error("loc_popup_header_error", "loc_user_signin_failed_desc")

		return
	end

	self:_verify_ms_store()
end

function AccountManagerWinGDK:_verify_ms_store()
	local cb = callback(self, "_finalize_signin")

	self:verify_gdk_store_account(cb)
end

function AccountManagerWinGDK:_finalize_signin()
	self._signin_callback()

	self._signin_callback = nil
	self._signin_state = SIGNIN_STATES.idle

	self._xbox_privileges:push_telemetry()
end

function AccountManagerWinGDK:_show_fatal_error(title_text, description_text)
	local context = {
		title_text = title_text,
		description_text = description_text,
		options = {
			{
				text = "loc_popup_button_close",
				close_on_pressed = true,
				callback = callback(self, "_return_to_title_screen")
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context, function (id)
		self._popup_id = id
	end)
end

function AccountManagerWinGDK:_show_store_account_error(title_text, description_text, optional_callback)
	local context = {
		title_text = title_text,
		description_text = description_text,
		options = {
			{
				text = "loc_popup_button_close",
				close_on_pressed = true,
				callback = optional_callback or function ()
					return
				end
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context)
end

function AccountManagerWinGDK:_return_to_title_screen()
	self._popup_id = nil
	self._leave_game = true
	self._wanted_state = CLASSES.StateError
	self._wanted_state_params = {}
end

function AccountManagerWinGDK:_setup_region()
	local country_code = XboxLive.user_default_geo_name()

	if country_code then
		country_code = string.lower(country_code)
	else
		country_code = "unknown"
	end

	self._region_restrictions = RegionRestrictionsXboxLive[country_code] or {}

	Log.info("AccountManagerWinGDK", "Geo location: %q, regional restrictions: %s", country_code, table.tostring(self._region_restrictions))
end

function AccountManagerWinGDK:open_to_store(product_id)
	local async_job, error_code = XboxLive.show_product_page_ui_async(product_id)

	if not async_job then
		return Promise.rejected({
			message = string.format("show_product_page_ui_async returned error_code=0x%x", error_code)
		})
	end

	local was_focus_lost = false

	return Promise.until_value_is_true(function ()
		local has_focus = Window.has_focus()

		if not has_focus then
			was_focus_lost = true
		end

		if not was_focus_lost then
			return false
		end

		if not has_focus then
			return false
		end

		local result = XboxLive.show_product_page_ui_async_result(async_job)

		if result == nil then
			return false
		end

		if result == 0 then
			return {
				success = true
			}
		else
			return {
				success = false
			}
		end
	end)
end

function AccountManagerWinGDK:is_owner_of(product_id)
	local async_job, error_code = XboxLive.acquire_license_for_durables_async(product_id)

	if not async_job then
		return Promise.rejected({
			message = string.format("acquire_license_for_durables_async returned error_code=0x%x", error_code)
		})
	end

	return Promise.until_value_is_true(function ()
		local result, error_code = XboxLive.acquire_license_for_durables_async_result(async_job)

		if result == nil and error_code == nil then
			return false
		end

		if result ~= nil then
			return {
				is_owner = result
			}
		end

		return {
			is_owner = false
		}
	end)
end

return AccountManagerWinGDK
