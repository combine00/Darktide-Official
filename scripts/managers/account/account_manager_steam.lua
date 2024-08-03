local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local AccountManagerSteam = class("AccountManagerSteam", "AccountManagerBase")

function AccountManagerSteam:signin_profile(signin_callback)
	if signin_callback then
		signin_callback()
	end
end

function AccountManagerSteam:user_display_name()
	return Steam.user_name()
end

function AccountManagerSteam:platform_user_id()
	return Steam.user_id()
end

return AccountManagerSteam
