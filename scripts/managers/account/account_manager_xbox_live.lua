local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local DefaultGameParameters = require("scripts/foundation/utilities/parameters/default_game_parameters")
local FGRLLimits = require("scripts/foundation/utilities/fgrl_limits")
local InputDevice = require("scripts/managers/input/input_device")
local Promise = require("scripts/foundation/utilities/promise")
local RegionRestrictionsXboxLive = require("scripts/settings/region/region_restrictions_xbox_live")
local RenderSettings = require("scripts/settings/options/render_settings")
local SoundSettings = require("scripts/settings/options/sound_settings")
local XboxLiveUtils = require("scripts/foundation/utilities/xbox_live_utils")
local XboxPrivileges = require("scripts/managers/account/xbox_privileges")
local AccountManagerXboxLive = class("AccountManagerXboxLive", "AccountManagerBase")
local SIGNIN_STATES = {
	fetching_sandbox_id = "loc_signin_fetch_sandbox_id",
	loading_save = "loc_signin_load_save",
	idle = "",
	signin_profile = "loc_signin_acquiring_user_profile",
	fetching_privileges = "loc_signin_fetch_privileges",
	querying_storage = "loc_signin_query_storage",
	acquiring_storage = "loc_signin_acquire_storage",
	deleting_save = "loc_signin_delete_save"
}

function AccountManagerXboxLive:init()
	self._signin_state = SIGNIN_STATES.idle
	self._xbox_privileges = XboxPrivileges:new()
	self._friends = {}

	self:_setup_region()
end

function AccountManagerXboxLive:reset()
	if self._social_groups_created_id then
		XSocialManager.remove_local_user(self._social_groups_created_id)
	end

	if self._popup_id then
		Managers.event:trigger("event_remove_ui_popup", self._popup_id)
	end

	if self._info_popup_id then
		Managers.event:trigger("event_remove_ui_popup", self._info_popup_id)
	end

	self._social_groups_created_id = nil

	table.clear(self._friends)

	self._signin_callback = nil
	self._popup_id = nil
	self._info_popup_id = nil
	self._fatal_error_popup_id = nil
	self._leave_game = nil
	self._network_fatal_error = nil
	self._signin_state = SIGNIN_STATES.idle
	self._wanted_state = nil
	self._wanted_state_params = nil
	self._local_user_changed = nil
	self._user_state_changed = nil
	self._user_privileges_changed = nil
	self._user_device_association_changed = nil
	self._mute_list = {}
	self._block_list = {}
	self._block_list_refreshed = false
	self._communication_restriction_iteration = self._communication_restriction_iteration or 1

	if not self._do_re_signin then
		self._is_guest = nil
		self._xuid = nil
		self._user_id = nil
		self._gamertag = nil
		self._active_controller = nil
		self._do_re_signin = nil
	end

	Managers.save:release_storage()
end

function AccountManagerXboxLive:wanted_transition()
	return self._wanted_state, self._wanted_state_params
end

function AccountManagerXboxLive:do_re_signin()
	return self._do_re_signin
end

function AccountManagerXboxLive:destroy()
	return
end

function AccountManagerXboxLive:user_detached()
	return self._popup_id or self._leave_game or self._network_fatal_error
end

function AccountManagerXboxLive:leaving_game()
	return self._leave_game
end

function AccountManagerXboxLive:user_id()
	return not self._popup_id and not self._network_fatal_error and self._user_id
end

function AccountManagerXboxLive:platform_user_id()
	return self._xuid
end

function AccountManagerXboxLive:user_display_name()
	return self._gamertag
end

function AccountManagerXboxLive:is_guest()
	return self._is_guest
end

function AccountManagerXboxLive:signin_state()
	return self._signin_state
end

function AccountManagerXboxLive:get_privilege(privilege)
	return self._xbox_privileges:has_privilege(privilege)
end

function AccountManagerXboxLive:update(dt, t)
	if not self._user_id or self._leave_game then
		return
	end

	self:_handle_user_changes()
	self:verify_connection()
	self._xbox_privileges:update(dt, t)
end

function AccountManagerXboxLive:verify_connection()
	local network_connectivity = XboxLive.get_network_connectivity()

	if network_connectivity ~= NetworkConnectivity.ACTIVE and not self._network_fatal_error then
		self:_show_fatal_error("loc_popup_header_error", "loc_signed_in_multiplayer_privilege_fail_desc")

		self._network_fatal_error = true
		self._network_connectivity = network_connectivity
	end

	return self._network_fatal_error == nil
end

function AccountManagerXboxLive:show_profile_picker()
	local success_cb = callback(self, "_cb_profile_selected")
	local fail_cb = callback(self, "_cb_verify_profile")
	local async_task, error_code = XUser.add_user_async(XUserAddOptions.None)

	if async_task then
		Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)
	else
		fail_cb()
	end
end

function AccountManagerXboxLive:signin_profile(signin_callback, optional_input_device)
	local success_cb = callback(self, "_cb_user_signed_in", optional_input_device)
	local fail_cb = callback(self, "_show_fatal_error", "loc_popup_header_error", "loc_user_signin_failed_desc")

	if not self:verify_connection() then
		fail_cb()

		return
	end

	if self._do_re_signin then
		self._do_re_signin = nil

		self._xbox_privileges:fetch_all_privileges(self._user_id, callback(self, "_cb_privileges_updated"))

		self._signin_state = SIGNIN_STATES.fetching_privileges
	else
		local async_task, error_code = nil
		local users = XUser.users()

		if #users > 1 then
			async_task, error_code = XUser.add_user_async(XUserAddOptions.None)
		else
			async_task, error_code = XUser.add_user_async(XUserAddOptions.AddDefaultUserAllowingUI)
		end

		if async_task then
			Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)
		else
			fail_cb()

			return
		end

		self._signin_state = SIGNIN_STATES.signin_profile
	end

	self._signin_callback = signin_callback
end

function AccountManagerXboxLive:sandbox_id()
	return self._sandbox_id
end

function AccountManagerXboxLive:friends_list_has_changes()
	return XSocialManager.is_dirty()
end

local ADDED_FRIENDS = {}

function AccountManagerXboxLive:get_friends(do_fetch)
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

function AccountManagerXboxLive:xuid()
	return self._xuid
end

function AccountManagerXboxLive:xbox_live_block_list()
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

function AccountManagerXboxLive:refresh_communication_restrictions()
	XboxLiveUtils.get_mute_list():next(function (mute_list)
		self._mute_list = mute_list

		self:xbox_live_block_list():next(function ()
			self._communication_restriction_iteration = self._communication_restriction_iteration + 1

			self:fetch_crossplay_restrictions()
		end)
	end)
end

function AccountManagerXboxLive:communication_restriction_iteration()
	return self._communication_restriction_iteration
end

function AccountManagerXboxLive:is_muted(xuid)
	return table.find(self._mute_list, xuid) ~= nil or self:is_blocked() or self:user_has_restriction(xuid, XblPermission.CommunicateUsingVoice)
end

function AccountManagerXboxLive:is_blocked(xuid)
	return table.find(self._block_list, xuid) ~= nil
end

function AccountManagerXboxLive:fetch_crossplay_restrictions()
	self._xbox_privileges:fetch_crossplay_restrictions()
end

function AccountManagerXboxLive:has_crossplay_restriction(relation, restriction)
	local has_restriction = self._xbox_privileges:has_crossplay_restriction(relation, restriction)

	return has_restriction
end

function AccountManagerXboxLive:verify_gdk_store_account()
	return true
end

function AccountManagerXboxLive:verify_user_restriction(xuid, restriction, optional_callback)
	self._xbox_privileges:verify_user_restriction(xuid, restriction, optional_callback)
end

function AccountManagerXboxLive:verify_user_restriction_batched(xuid, restriction, batch_type)
	self._xbox_privileges:verify_user_restriction_batched(xuid, restriction, batch_type)
end

function AccountManagerXboxLive:user_has_restriction(xuid, restriction)
	return self._xbox_privileges:user_has_restriction(xuid, restriction)
end

function AccountManagerXboxLive:user_restriction_verified(xuid, restriction)
	return self._xbox_privileges:user_restriction_verified(xuid, restriction)
end

function AccountManagerXboxLive:network_error()
	return self._network_fatal_error
end

function AccountManagerXboxLive:region_has_restriction(restriction)
	return not not self._region_restrictions[restriction]
end

function AccountManagerXboxLive:_cb_user_signed_in(optional_input_device, async_block)
	self._do_re_signin = nil
	local user_id = XUser.get_user_result(async_block)

	self:_set_user_data(user_id)
	self:_set_active_device(optional_input_device)
	self._xbox_privileges:fetch_all_privileges(self._user_id, callback(self, "_cb_privileges_updated"))

	self._signin_state = SIGNIN_STATES.fetching_privileges
end

function AccountManagerXboxLive:_cb_profile_selected(async_task)
	local user_id = XUser.get_user_result(async_task)
	local old_xuid = self._xuid

	self:_set_user_data(user_id)

	if self._xuid ~= old_xuid then
		if self._social_groups_created_id then
			XSocialManager.remove_local_user(self._social_groups_created_id)
		end

		self._social_groups_created_id = nil

		Crashify.print_property("console_type", "unknown")

		self._do_re_signin = true

		self:return_to_title_screen()
	end
end

function AccountManagerXboxLive:_set_user_data(user_id)
	local user_info = XUser.user_info(user_id)
	local gamertag = XUser.get_gamertag(user_id)
	self._is_guest = user_info.guest
	self._xuid = user_info.xuid
	self._user_id = user_id
	self._gamertag = gamertag

	Crashify.print_property("xbs_user_id", self._user_id)
	Crashify.print_property("xbs_gamertag", self._gamertag)
	Crashify.print_property("xbs_xuid", self._xuid)
	Crashify.print_property("guest", self._is_guest)
end

function AccountManagerXboxLive:_set_active_device(optional_input_device)
	if not optional_input_device then
		return
	end

	local device_type = optional_input_device.type()
	local device_id = optional_input_device.device_id()
	InputDevice.default_device_id[device_type] = device_id
	self._active_controller = optional_input_device
end

function AccountManagerXboxLive:_cb_privileges_updated()
	if self._xbox_privileges:has_error() then
		self:_show_fatal_error("loc_popup_header_error", "loc_privilege_fetch_fail_desc")

		return
	end

	if not self._xbox_privileges:has_privilege(XUserPrivilege.Multiplayer) then
		self:_show_fatal_error("loc_popup_header_error", "loc_multiplayer_privilege_fail_desc")

		return
	end

	self:_fetch_sandbox_id()
end

function AccountManagerXboxLive:_fetch_sandbox_id()
	local success_cb = callback(self, "_cb_sanbox_id_fetched")
	local fail_cb = callback(self, "_show_fatal_error", "loc_popup_header_error", "loc_user_signin_failed_desc")
	local async_task, error_code = XboxLive.get_sandbox_id_async()

	if async_task then
		Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)

		self._signin_state = SIGNIN_STATES.fetching_sandbox_id
	else
		fail_cb()
	end
end

function AccountManagerXboxLive:_cb_sanbox_id_fetched(async_block)
	local sandbox_id, error_code = XboxLive.get_sandbox_id_async_result(async_block)

	if not sandbox_id then
		self:_show_fatal_error("loc_popup_header_error", "loc_user_signin_failed_desc")

		return
	end

	self._sandbox_id = sandbox_id

	Managers.save:acquire_storage(self._user_id, callback(self, "_cb_storage_acquired"))

	self._signin_state = SIGNIN_STATES.acquiring_storage
end

function AccountManagerXboxLive:_cb_storage_acquired(success)
	if not success then
		self:_show_fatal_error("loc_popup_header_error", "loc_acquire_storage_failed_desc")

		return
	end

	Managers.save:query_storage_containers(callback(self, "_cb_query_storage_results"))

	self._signin_state = SIGNIN_STATES.querying_storage
end

function AccountManagerXboxLive:_cb_query_storage_results(success, data)
	if not success then
		self:_show_fatal_error("loc_popup_header_error", "loc_query_storage_failed_desc")

		return
	end

	if self:_save_exists(data) then
		Managers.save:load(callback(self, "_cb_save_loaded"))

		self._signin_state = SIGNIN_STATES.loading_save
	else
		self:_finalize_signin()
	end
end

function AccountManagerXboxLive:_cb_save_loaded(success)
	if not success then
		self:_show_fatal_error("loc_popup_header_error", "loc_load_save_failed_desc")

		return
	end

	self:_finalize_signin()
end

function AccountManagerXboxLive:_cb_storage_deleted(success)
	if not success then
		self:_show_fatal_error("loc_popup_header_error", "loc_delete_save_failed_desc")

		return
	end

	self:_finalize_signin()
end

function AccountManagerXboxLive:_setup_friends_list()
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

	self:cb_signin_complete()
end

function AccountManagerXboxLive:_finalize_signin()
	if BUILD ~= "release" then
		ParameterResolver.resolve_dev_parameters()
	end

	local render_settings = RenderSettings.settings

	self:_apply_render_settings(render_settings)
	self:_apply_audio_settings()
	self:_show_gamertag_popup()
end

function AccountManagerXboxLive:_show_gamertag_popup()
	if GameParameters.skip_gamertag_popup then
		self:_setup_friends_list()
	else
		local context = {
			title_text = "loc_popup_info",
			description_text = "loc_popup_desc_signed_in_gamertag",
			description_text_params = {
				gamertag = self._gamertag
			},
			options = {
				{
					text = "loc_popup_button_confirm",
					close_on_pressed = true,
					callback = callback(self, "_setup_friends_list")
				},
				{
					text = "loc_exit_to_title_display_name",
					close_on_pressed = true,
					hotkey = "back",
					callback = callback(self, "return_to_title_screen")
				}
			}
		}

		Managers.event:trigger("event_show_ui_popup", context, function (id)
			self._info_popup_id = id
		end)
	end
end

function AccountManagerXboxLive:cb_signin_complete()
	self._info_popup_id = nil

	self._xbox_privileges:push_telemetry()

	if self._signin_callback then
		self._signin_callback()

		self._signin_callback = nil
		self._signin_state = SIGNIN_STATES.idle
	end
end

function AccountManagerXboxLive:_apply_render_settings(settings)
	for _, setting in ipairs(settings) do
		if setting.pages then
			for i = 1, #setting.pages do
				local page_setting = setting.pages[i].entries

				self:_apply_render_settings(page_setting)
			end
		end

		local valid = not setting.validation_function or setting:validation_function()

		if valid then
			local apply_on_startup = setting.apply_on_startup

			if apply_on_startup then
				local get_function = setting.get_function

				if get_function then
					local value = get_function(setting)

					if value ~= nil then
						local on_activated = setting.on_activated

						if on_activated then
							on_activated(value, setting)
						end
					end
				end
			end
		end
	end
end

function AccountManagerXboxLive:_apply_audio_settings()
	local settings = SoundSettings.settings

	for _, setting in ipairs(settings) do
		local get_function = setting.get_function

		if get_function then
			local value = get_function()

			if value ~= nil then
				local commit = setting.commit

				if commit then
					commit(value)
				end
			end
		end
	end
end

function AccountManagerXboxLive:_save_exists(data)
	local container_info = data.container_info

	if not container_info then
		return false
	end

	local save_container_name = Managers.save:save_container_name()

	for i = 1, #container_info do
		local container = container_info[i]

		if container.name == save_container_name then
			return true
		end
	end
end

function AccountManagerXboxLive:_handle_user_changes(dt, t)
	local local_user_changed, user_state_changed, user_privileges_changed, user_device_association_changed = XUser.user_info_changed()
	self._local_user_changed = local_user_changed or self._local_user_changed
	self._user_state_changed = user_state_changed or self._user_state_changed
	self._user_privileges_changed = user_privileges_changed or self._user_privileges_changed
	self._user_device_association_changed = user_device_association_changed or self._user_device_association_changed

	if self:_work_in_progress() then
		return
	end

	if self._local_user_changed then
		self._local_user_changed = nil

		print("################## local_user_changed")
		self:_handle_local_user_change()
	elseif self._user_state_changed then
		self._user_state_changed = nil

		print("################## user_state_changed")
		self:_handle_user_state_change()
	elseif self._user_privileges_changed then
		self._user_privileges_changed = nil

		print("################## user_privileges_changed")
		self:_handle_privilege_change()
	elseif self._user_device_association_changed then
		self._user_device_association_changed = nil

		print("################## user_device_association_changed")
		self:_handle_user_device_association_change()
	end
end

function AccountManagerXboxLive:_work_in_progress()
	return self._popup_id or self._do_re_signin or self._leave_game or Managers.xasync:in_progress()
end

function AccountManagerXboxLive:_handle_local_user_change()
	local profile_active = self:_update_active_profile()

	if not profile_active then
		self:_handle_user_device_association_change()
	end
end

function AccountManagerXboxLive:_update_active_profile()
	local profile_active = false
	local user = self:_find_user()

	if user then
		self._is_guest = user.guest
		self._user_id = user.id
		local state = XUser.get_state(user.id)
		profile_active = state ~= XUserState.SignedOut
	end

	return profile_active
end

function AccountManagerXboxLive:_find_user()
	local users = XUser.users()

	for i = 1, #users do
		local user = users[i]

		if user.xuid == self._xuid then
			return user
		end
	end
end

function AccountManagerXboxLive:_handle_user_state_change()
	local user = self:_find_user()

	if user then
		local state = XUser.get_state(user.id)

		if state == XUserState.SignedIn then
			print("### XUserState.SignedIn ###")
		elseif state == XUserState.SignedOut then
			print("### XUserState.SignedOut ###")
			self:_show_signed_out_error()
		elseif state == XUserState.SigningOut then
			print("### XUserState.SigningOut ###")
		end
	end
end

function AccountManagerXboxLive:_handle_privilege_change()
	self._xbox_privileges:update_privileges(self._user_id)

	if not self._xbox_privileges:has_privilege(XUserPrivilege.Multiplayer) then
		self:_show_fatal_error("loc_popup_header_error", "loc_signed_in_multiplayer_privilege_fail_desc")
	end
end

function AccountManagerXboxLive:_handle_user_device_association_change()
	if self._popup_id then
		return
	end

	if self._active_controller then
		if not self._active_controller.active() then
			self:_show_disconnect_error()
		else
			local success_cb = callback(self, "_cb_from_device_async")
			local fail_cb = callback(self, "_show_disconnect_error")
			local async_task, error_code = XUser.from_device_async(self._active_controller.device_pointer())

			if async_task then
				Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)
			else
				fail_cb()
			end
		end
	else
		self:_show_disconnect_error()
	end
end

function AccountManagerXboxLive:_cb_from_device_async(async_task)
	local user_id = XUser.from_device_result(async_task)
	local user_info = user_id and XUser.user_info(user_id) or nil

	if not user_info or user_info.xuid ~= self._xuid then
		self:_show_disconnect_error()
	else
		self:_set_user_data(user_id)
	end
end

function AccountManagerXboxLive:_show_disconnect_error()
	if self._active_controller then
		local device_type = self._active_controller.type()
		InputDevice.default_device_id[device_type] = nil
	end

	local context = {
		title_text = "loc_popup_header_controller_disconnect_error",
		description_text = "loc_popup_desc_signed_out_error",
		priority_order = math.huge,
		description_text_params = {
			gamertag = self._gamertag
		},
		options = {
			{
				text = "loc_retry",
				close_on_pressed = true,
				callback = callback(self, "_cb_verify_profile")
			},
			{
				text = "loc_select_profile",
				close_on_pressed = true,
				callback = callback(self, "_cb_open_profile_picker")
			},
			{
				text = "loc_exit_to_title_display_name",
				close_on_pressed = true,
				hotkey = "back",
				callback = callback(self, "return_to_title_screen")
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context, function (id)
		self._popup_id = id
	end)
end

function AccountManagerXboxLive:_show_signed_out_error()
	if self._active_controller then
		local device_type = self._active_controller.type()
		InputDevice.default_device_id[device_type] = nil
	end

	local context = {
		title_text = "loc_popup_header_signed_out_error",
		description_text = "loc_popup_desc_signed_out_error",
		priority_order = math.huge,
		description_text_params = {
			gamertag = self._gamertag
		},
		options = {
			{
				text = "loc_retry",
				close_on_pressed = true,
				callback = callback(self, "_cb_verify_profile")
			},
			{
				text = "loc_select_profile",
				close_on_pressed = true,
				callback = callback(self, "_cb_open_profile_picker")
			},
			{
				text = "loc_exit_to_title_display_name",
				close_on_pressed = true,
				hotkey = "back",
				callback = callback(self, "return_to_title_screen")
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context, function (id)
		self._popup_id = id
	end)
end

function AccountManagerXboxLive:_show_fatal_error(title_text, description_text)
	local context = {
		priority_order = 1000,
		title_text = title_text,
		description_text = description_text,
		options = {
			{
				text = "loc_popup_button_close",
				close_on_pressed = true,
				callback = callback(self, "return_to_title_screen")
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context, function (id)
		self._fatal_error_popup_id = id
	end)
end

function AccountManagerXboxLive:_cb_verify_profile()
	self._popup_id = nil

	if self._network_fatal_error or self._leave_game then
		return
	end

	local input_device = InputDevice.last_pressed_device

	if input_device and input_device:type() == "xbox_controller" then
		self._active_controller = input_device:raw_device()
	end

	self:_set_active_device(self._active_controller)

	local profile_active = self:_update_active_profile()

	if profile_active then
		self:_handle_user_device_association_change()
	else
		self:_show_signed_out_error()
	end
end

function AccountManagerXboxLive:_cb_open_profile_picker()
	local success_cb = callback(self, "_cb_verify_profile_selection")
	local fail_cb = callback(self, "_cb_verify_profile")
	local async_task, error_code = XUser.add_user_async(XUserAddOptions.None)

	if async_task then
		Managers.xasync:wrap(async_task):next(success_cb, fail_cb):catch(fail_cb)
	else
		fail_cb()
	end
end

function AccountManagerXboxLive:_cb_verify_profile_selection(async_task)
	local user_id = XUser.get_user_result(async_task)
	local user_info = XUser.user_info(user_id)

	if self._xuid ~= user_info.xuid then
		self:_show_disconnect_error()
	else
		self:_set_user_data(user_id)
		self:_cb_verify_profile()
	end
end

function AccountManagerXboxLive:return_to_title_screen()
	Managers.event:trigger("event_remove_ui_popups_by_priority", math.huge)

	self._popup_id = nil
	self._info_popup_id = nil
	self._fatal_error_popup_id = nil
	self._leave_game = true
	self._wanted_state = CLASSES.StateError
	self._wanted_state_params = {}
end

function AccountManagerXboxLive:_setup_region()
	local country_code = XboxLive.user_default_geo_name()

	if country_code then
		country_code = string.lower(country_code)
	else
		country_code = "unknown"
	end

	self._region_restrictions = RegionRestrictionsXboxLive[country_code] or {}

	Log.info("AccountManagerXboxLive", "Geo location: %q, regional restrictions: %s", country_code, table.tostring(self._region_restrictions))
end

function AccountManagerXboxLive:open_to_store(product_id)
	local async_job, error_code = XboxLive.show_product_page_ui_async(product_id)

	if not async_job then
		return Promise.rejected({
			message = string.format("show_product_page_ui_async returned error_code=0x%x", error_code)
		})
	end

	local was_constrained = false

	return Promise.until_value_is_true(function ()
		local is_constrained = Application.is_constrained()

		if is_constrained then
			was_constrained = true
		end

		if not was_constrained then
			return false
		end

		if is_constrained then
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

function AccountManagerXboxLive:is_owner_of(product_id)
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

return AccountManagerXboxLive
