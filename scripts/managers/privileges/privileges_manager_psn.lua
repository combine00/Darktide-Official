local Promise = require("scripts/foundation/utilities/promise")
local PrivilegesManagerPSN = class("PrivilegesManagerPSN")

function PrivilegesManagerPSN:init()
	return
end

function PrivilegesManagerPSN:update(dt, t)
	return
end

function PrivilegesManagerPSN:destroy()
	return
end

function PrivilegesManagerPSN:multiplayer_privilege(resolve_privilege)
	local p = Promise:new()

	p:resolve({
		has_privilege = true
	})

	return p
end

function PrivilegesManagerPSN:communications_privilege(resolve_privilege)
	local restriction = Managers.account:user_has_restriction()
	local p = Promise:new()

	p:resolve({
		has_privilege = not restriction
	})

	return p
end

function PrivilegesManagerPSN:cross_play(resolve_privilege)
	local restriction = Managers.account:has_crossplay_restriction()
	local p = Promise:new()

	p:resolve({
		has_privilege = not restriction
	})

	return p
end

return PrivilegesManagerPSN
