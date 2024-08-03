local FriendsInterface = require("scripts/managers/data_service/services/friends/friends_interface")
local FriendsDummy = class("FriendsDummy")

function FriendsDummy:init()
	return
end

function FriendsDummy:destroy()
	return
end

local temp_friend_data = {}

function FriendsDummy:fetch()
	return temp_friend_data
end

implements(FriendsDummy, FriendsInterface)

return FriendsDummy
