local Promise = require("scripts/foundation/utilities/promise")
local PrivilegesManagerXboxLive = class("PrivilegesManagerXboxLive")

function PrivilegesManagerXboxLive:init()
	return
end

function PrivilegesManagerXboxLive:update(dt, t)
	return
end

function PrivilegesManagerXboxLive:destroy()
	return
end

local function _get_xbox_privilege(privilege_name)
	local p = Promise:new()
	local has_privilege, deny_reason = Managers.account:get_privilege(privilege_name)

	p:resolve({
		has_privilege = has_privilege or false,
		deny_reason = deny_reason
	})

	return p
end

function PrivilegesManagerXboxLive:multiplayer_privilege(resolve_privilege)
	return _get_xbox_privilege(XUserPrivilege.Multiplayer)
end

function PrivilegesManagerXboxLive:communications_privilege(resolve_privilege)
	return _get_xbox_privilege(XUserPrivilege.Communications)
end

function PrivilegesManagerXboxLive:cross_play(resolve_privilege)
	return _get_xbox_privilege(XUserPrivilege.CrossPlay)
end

return PrivilegesManagerXboxLive
