local Promise = require("scripts/foundation/utilities/promise")
local Interface = require("scripts/backend/social_interface")
local SocialConstants = require("scripts/managers/data_service/services/social/social_constants")
local SocialLocal = class("SocialLocal")
local emulate_backend_failure = false

function SocialLocal:init()
	self._temp_block_list = {}
	self._friends = {}
end

local FriendStatus = SocialConstants.FriendStatus

function SocialLocal:fetch_friends()
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		local max_number_friends = 10
		local friends = {}

		for _, friend in pairs(self._friends) do
			friends[#friends + 1] = friend
		end

		local response_data = {
			friends = friends,
			maxFriends = max_number_friends
		}

		promise:resolve(response_data)
	end

	return promise
end

function SocialLocal:send_friend_request(account_id, method)
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		promise:next(function ()
			local t = Managers.time:time("main")
			local server_time = Managers.backend:get_server_time(t)

			if not method or method == "POST" then
				local is_sent = not self._is_sent_friend_request
				self._is_sent_friend_request = is_sent
				local friend = {
					accountName = "DummyData",
					accountId = account_id,
					status = is_sent and FriendStatus.invited or FriendStatus.invite,
					invitedTime = tostring(server_time)
				}
				self._friends[account_id] = friend
			elseif method == "PUT" then
				local friend = self._friends[account_id]
				friend.status = FriendStatus.friend
				friend.friendedTime = tostring(server_time)
			elseif method == "PATCH" or method == "DELETE" then
				self._friends[account_id] = nil
			end
		end)
	end

	return promise
end

function SocialLocal:unfriend_player(account_id)
	self._friends[account_id] = nil
end

function SocialLocal:fetch_recently_played(character_id)
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		local response_data = {
			recentParticipants = {}
		}

		promise:resolve(response_data)
	end

	return promise
end

function SocialLocal:add_blocked_account(account_id)
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		promise:next(function ()
			self._temp_block_list[account_id] = true
		end)
	end

	return promise
end

function SocialLocal:remove_blocked_account(account_id)
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		promise:next(function ()
			self._temp_block_list[account_id] = nil
		end)
	end

	return promise
end

function SocialLocal:fetch_blocked_accounts()
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		local response_data = {
			maxBlocks = 10,
			blockList = table.clone(self._temp_block_list)
		}

		promise:resolve(response_data)
	end

	return promise
end

function SocialLocal:suggested_names_by_archetype(archetype)
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		local names = {}
		local main_part = "Generic_" .. archetype .. "_"

		for i = 1, 10 do
			names[i] = main_part .. i
		end

		promise:resolve(names)
	end

	return promise
end

function SocialLocal:fetch_group_finder_tags()
	local promise = Promise.delay(2)

	if emulate_backend_failure then
		promise:reject({})
	else
		local response_data = {
			tags = {}
		}

		promise:resolve(response_data)
	end
end

implements(SocialLocal, Interface)

return SocialLocal
