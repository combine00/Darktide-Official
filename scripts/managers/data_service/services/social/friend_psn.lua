local FriendInterface = require("scripts/managers/data_service/services/social/friend_interface")
local SocialConstants = require("scripts/managers/data_service/services/social/social_constants")
local FriendPSN = class("FriendPSN")

function FriendPSN:init(friend_data, is_blocked)
	self._friend_data = friend_data
	self._account_id = friend_data.accountId
	self._online_id = friend_data.onlineId
	self._name = self._online_id
	self._is_blocked = is_blocked
	self._playing_this_game = friend_data.inContext
	local personal_detail = friend_data.personalDetail

	if friend_data.onlineStatus == "online" or friend_data.is_online then
		self._online_state = SocialConstants.OnlineStatus.platform_online
	else
		self._online_state = SocialConstants.OnlineStatus.offline
	end
end

function FriendPSN:id()
	return self._account_id
end

function FriendPSN:platform()
	return SocialConstants.Platforms.psn
end

function FriendPSN:platform_icon()
	return ""
end

function FriendPSN:name()
	return self._name
end

function FriendPSN:is_friend()
	return not self._is_blocked
end

function FriendPSN:is_blocked()
	return self._is_blocked or Managers.account:is_blocked(self._account_id)
end

function FriendPSN:online_status()
	return self._online_state
end

implements(FriendPSN, FriendInterface)

return FriendPSN
