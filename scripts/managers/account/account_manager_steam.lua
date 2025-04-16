local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local RegionRestrictionsSteam = require("scripts/settings/region/region_restrictions_steam")
local AccountManagerSteam = class("AccountManagerSteam", "AccountManagerBase")

function AccountManagerSteam:signin_profile(signin_callback)
	self:_setup_region()

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

function AccountManagerSteam:_setup_region()
	local country_code = Steam.user_country_code()
	country_code = country_code or "unknown"
	self._region_restrictions = RegionRestrictionsSteam[country_code] or {}
end

function AccountManagerSteam:region_has_restriction(restriction)
	return not not self._region_restrictions[restriction]
end

return AccountManagerSteam
