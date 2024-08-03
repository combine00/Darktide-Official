local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local ScriptWebApiPsn = require("scripts/managers/account/script_web_api_psn")
local Promise = require("scripts/foundation/utilities/promise")
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
local FRIEND_REQUEST_STATES = table.enum("idle", "fetching_friends")
local BLOCKED_PROFILES_REQUEST_STATES = table.enum("idle", "fetching_blocked_profiles")
local FRIEND_LIST_REQUEST_DELAY = 10
local BLOCKED_PROFILES_REQUEST_DELAY = 10
local FRIEND_LIST_REQUEST_LIMIT = 500
local BLOCKED_PROFILES_REQUEST_LIMIT = 100
local PUBLIC_PROFILES_REQUEST_LIMIT = 100
local PORFILE_PRESENCES_REQUEST_LIMIT = 100
local AccountManagerPSN = class("AccountManagerPSN", "AccountManagerBase")

function AccountManagerPSN:init()
	self._web_api = ScriptWebApiPsn:new()
end

function AccountManagerPSN:reset()
	if Playstation.signed_in() then
		self._online_id = Playstation.online_id()
		local account_id_hex = Playstation.account_id()
		local account_id = Application.hex64_to_dec(account_id_hex)
		self._account_id = account_id
	end

	self._initial_user_id = PS5.initial_user_id()
	self._signin_state = SIGNIN_STATES.idle
	self._signin_callback = nil
	self._friend_profiles = {}
	self._friends_promise = nil
	self._next_friend_list_request = 0

	self:_change_friend_request_state(FRIEND_REQUEST_STATES.idle)

	self._block_profiles_refreshed = false
	self._blocked_profiles = {}
	self._blocked_profiles_promise = nil
	self._next_blocked_profiles_request = 0

	self:_change_blocked_profiles_request_state(BLOCKED_PROFILES_REQUEST_STATES.idle)

	self._wanted_state = nil
	self._wanted_state_params = nil
	self._leave_game = false
end

function AccountManagerPSN:destroy()
	self._web_api:destroy()

	self._web_api = nil
end

function AccountManagerPSN:update(dt, t)
	if self._leave_game then
		return
	end

	self._web_api:update(dt)
end

function AccountManagerPSN:signin_profile(signin_callback, optional_input_device)
	self._signin_state = SIGNIN_STATES.signin_profile
	self._signin_callback = signin_callback

	self:cb_signin_complete()
end

function AccountManagerPSN:cb_signin_complete()
	if self._signin_callback then
		self._signin_callback()

		self._signin_callback = nil
		self._signin_state = SIGNIN_STATES.idle
	end
end

function AccountManagerPSN:user_id()
	return self._initial_user_id
end

function AccountManagerPSN:platform_user_id()
	return self._account_id
end

function AccountManagerPSN:user_display_name()
	return self._online_id
end

function AccountManagerPSN:wanted_transition()
	return self._wanted_state, self._wanted_state_params
end

function AccountManagerPSN:do_re_signin()
	return false
end

function AccountManagerPSN:user_detached()
	return self._leave_game
end

function AccountManagerPSN:leaving_game()
	return self._leave_game
end

function AccountManagerPSN:signin_state()
	return self._signin_state
end

function AccountManagerPSN:is_guest()
	return false
end

function AccountManagerPSN:show_profile_picker()
	return
end

function AccountManagerPSN:return_to_title_screen()
	self._wanted_state = CLASSES.StateError
	self._wanted_state_params = {}
	self._leave_game = true
end

function AccountManagerPSN:get_friends()
	local friends_promise = self._friends_promise

	if friends_promise and friends_promise:is_pending() then
		return friends_promise
	end

	local t = Managers.time:time("main")

	if self._friend_request_state ~= FRIEND_REQUEST_STATES.idle or t < self._next_friend_list_request then
		return Promise.resolved(self._friend_profiles)
	else
		table.clear(self._friend_profiles)

		self._friends_promise = self:_fetch_friends()

		self._friends_promise:next(function (result)
			self._friend_profiles = result
			self._next_friend_list_request = t + FRIEND_LIST_REQUEST_DELAY
			self._friends_promise = nil
		end)

		return self._friends_promise
	end
end

function AccountManagerPSN:_fetch_friends(num_to_fetch, offset, result_promise, target_account_ids_array)
	num_to_fetch = num_to_fetch or FRIEND_LIST_REQUEST_LIMIT
	offset = offset or 0
	local limit = FRIEND_LIST_REQUEST_LIMIT
	local account_id = self._account_id
	local user_id = PS5.initial_user_id()
	local api_group = "userProfile"
	local path = string.format("/v1/users/%s/friends?offset=%s&limit=%s", account_id, offset, limit)
	local method = WebApi.GET
	local content = nil
	result_promise = result_promise or Promise.new()
	target_account_ids_array = target_account_ids_array or {}

	self:_change_friend_request_state(FRIEND_REQUEST_STATES.fetching_friends)
	self._web_api:send_request(user_id, api_group, path, method, content):next(function (result)
		self:_change_friend_request_state(FRIEND_REQUEST_STATES.idle)

		if not result then
			result_promise.reject()

			return result
		end

		local friends_account_ids = result.friends
		local total_friends_count = result.totalItemCount or 0

		table.append(target_account_ids_array, friends_account_ids)

		if #friends_account_ids == 0 then
			result_promise:resolve({})
		elseif total_friends_count > #target_account_ids_array then
			offset = offset + #friends_account_ids
			num_to_fetch = math.min(total_friends_count - #target_account_ids_array, limit)

			self:_fetch_friends(num_to_fetch, offset, result_promise, target_account_ids_array)
		else
			local profiles_result_promise = Promise.all(self:_fetch_public_profiles(table.clone_instance(target_account_ids_array)), self:_fetch_profile_presences(table.clone_instance(target_account_ids_array))):next(function (result)
				local public_profiles_by_account_id, presences_by_account_id = unpack(result)
				local profiles = {}

				for i = 1, #target_account_ids_array do
					local account_id = target_account_ids_array[i]
					local profile = public_profiles_by_account_id[account_id]
					local presence = presences_by_account_id[account_id]
					local profile_data = table.clone_instance(profile)

					table.merge_recursive(profile_data, presence)

					profiles[#profiles + 1] = profile_data
				end

				result_promise:resolve(profiles)
			end)
		end
	end)

	return result_promise
end

function AccountManagerPSN:_fetch_public_profiles(account_ids, result_promise, result_data_table)
	local limit = PUBLIC_PROFILES_REQUEST_LIMIT
	local account_id = self._account_id
	local user_id = PS5.initial_user_id()
	local api_group = "userProfile"
	local account_ids_string = ""

	for i = math.min(#account_ids, limit), 1, -1 do
		local account_id = account_ids[i]
		account_ids_string = account_ids_string .. account_id

		if i > 1 then
			account_ids_string = account_ids_string .. ","
		end

		table.remove(account_ids, i)
	end

	local path = string.format("/v1/users/profiles?accountIds=%s&includeFields=accountId&includeFields=relation", account_ids_string)
	local method = WebApi.GET
	local content = nil
	result_promise = result_promise or Promise.new()
	result_data_table = result_data_table or {}

	self._web_api:send_request(user_id, api_group, path, method, content):next(function (result)
		if not result then
			result_promise.reject()

			return result
		end

		local profiles = result.profiles

		table.append(result_data_table, profiles)

		if #account_ids > 0 then
			self:_fetch_public_profiles(account_ids, result_promise, result_data_table)
		else
			local result_by_id = {}

			for i = 1, #result_data_table do
				local data = result_data_table[i]
				local account_id = data.accountId

				if account_id then
					result_by_id[account_id] = data
				end
			end

			result_promise:resolve(result_by_id)
		end
	end)

	return result_promise
end

function AccountManagerPSN:_fetch_profile_presences(account_ids, result_promise, result_data_table)
	local limit = PORFILE_PRESENCES_REQUEST_LIMIT
	local account_id = self._account_id
	local user_id = PS5.initial_user_id()
	local api_group = "userProfile"
	local account_ids_string = ""

	for i = math.min(#account_ids, limit), 1, -1 do
		local account_id = account_ids[i]
		account_ids_string = account_ids_string .. account_id

		if i > 1 then
			account_ids_string = account_ids_string .. ","
		end

		table.remove(account_ids, i)
	end

	local path = string.format("/v1/users/basicPresences?accountIds=%s", account_ids_string)
	local method = WebApi.GET
	local content = nil
	result_promise = result_promise or Promise.new()
	result_data_table = result_data_table or {}

	self._web_api:send_request(user_id, api_group, path, method, content):next(function (result)
		if not result then
			result_promise.reject()

			return result
		end

		local presences = result.basicPresences

		table.append(result_data_table, presences)

		if #account_ids > 0 then
			self:_fetch_profile_presences(account_ids, result_promise, result_data_table)
		else
			local result_by_id = {}

			for i = 1, #result_data_table do
				local data = result_data_table[i]
				local account_id = data.accountId

				if account_id then
					result_by_id[account_id] = data
				end
			end

			result_promise:resolve(result_by_id)
		end
	end)

	return result_promise
end

function AccountManagerPSN:_change_friend_request_state(new_state)
	self._friend_request_state = new_state
end

function AccountManagerPSN:_change_blocked_profiles_request_state(new_state)
	self._blocked_profiles_request_state = new_state
end

function AccountManagerPSN:friends_list_has_changes()
	return
end

function AccountManagerPSN:refresh_communication_restrictions()
	return
end

function AccountManagerPSN:is_muted()
	return false
end

function AccountManagerPSN:is_blocked()
	return false
end

function AccountManagerPSN:fetch_crossplay_restrictions()
	return
end

function AccountManagerPSN:has_crossplay_restriction()
	return false
end

function AccountManagerPSN:verify_user_restriction()
	return
end

function AccountManagerPSN:verify_user_restriction_batched()
	return
end

function AccountManagerPSN:user_has_restriction()
	return false
end

function AccountManagerPSN:user_restriction_verified()
	return true
end

function AccountManagerPSN:verify_connection()
	return true
end

function AccountManagerPSN:communication_restriction_iteration()
	return self._communication_restriction_iteration
end

function AccountManagerPSN:get_blocked_profiles()
	local blocked_profiles_promise = self._blocked_profiles_promise

	if blocked_profiles_promise and blocked_profiles_promise:is_pending() then
		return blocked_profiles_promise
	end

	local t = Managers.time:time("main")

	if self._block_profiles_refreshed or self._blocked_profiles_request_state ~= BLOCKED_PROFILES_REQUEST_STATES.idle or t < self._next_blocked_profiles_request then
		return Promise.resolved(self._blocked_profiles)
	else
		table.clear(self._blocked_profiles)
		self:_change_blocked_profiles_request_state(BLOCKED_PROFILES_REQUEST_STATES.fetching_blocked_profiles)

		self._blocked_profiles_promise = self:_fetch_block_list()

		self._blocked_profiles_promise:next(function (result)
			self._blocked_profiles = result
			self._next_blocked_profiles_request = t + BLOCKED_PROFILES_REQUEST_DELAY
			self._blocked_profiles_promise = nil

			self:_change_blocked_profiles_request_state(BLOCKED_PROFILES_REQUEST_STATES.idle)

			self._block_profiles_refreshed = true
		end)

		return self._blocked_profiles_promise
	end
end

function AccountManagerPSN:_fetch_block_list(num_to_fetch, offset, result_promise, target_blocked_account_ids_array)
	num_to_fetch = num_to_fetch or BLOCKED_PROFILES_REQUEST_LIMIT
	offset = offset or 0
	local limit = BLOCKED_PROFILES_REQUEST_LIMIT
	local account_id = self._account_id
	local user_id = PS5.initial_user_id()
	local api_group = "userProfile"
	local path = string.format("/v1/users/me/blocks?offset=%s&limit=%s", offset, limit)
	local method = WebApi.GET
	local content = nil
	result_promise = result_promise or Promise.new()
	target_blocked_account_ids_array = target_blocked_account_ids_array or {}

	self._web_api:send_request(user_id, api_group, path, method, content):next(function (result)
		if not result then
			result_promise.reject()

			return result
		end

		local blocked_account_ids = result.blocks
		local total_item_count = result.totalItemCount or 0

		table.append(target_blocked_account_ids_array, blocked_account_ids)

		if #blocked_account_ids == 0 then
			result_promise:resolve({})
		elseif total_item_count > #target_blocked_account_ids_array then
			offset = offset + #blocked_account_ids
			num_to_fetch = math.min(total_item_count - #target_blocked_account_ids_array, limit)

			self:_fetch_block_list(num_to_fetch, offset, result_promise, target_blocked_account_ids_array)
		else
			local profiles_result_promise = Promise.all(self:_fetch_public_profiles(table.clone_instance(target_blocked_account_ids_array)), self:_fetch_profile_presences(table.clone_instance(target_blocked_account_ids_array))):next(function (result)
				local public_profiles_by_account_id, presences_by_account_id = unpack(result)
				local profiles = {}

				for i = 1, #target_blocked_account_ids_array do
					local account_id = target_blocked_account_ids_array[i]
					local profile = public_profiles_by_account_id[account_id]
					local presence = presences_by_account_id[account_id]
					local profile_data = table.clone_instance(profile)

					if presence then
						table.merge_recursive(profile_data, presence)
					end

					profiles[#profiles + 1] = profile_data
				end

				result_promise:resolve(profiles)
			end)
		end
	end)

	return result_promise
end

return AccountManagerPSN
