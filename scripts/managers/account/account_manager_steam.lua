local AccountManagerBase = require("scripts/managers/account/account_manager_base")
local RegionRestrictionsSteam = require("scripts/settings/region/region_restrictions_steam")
local Promise = require("scripts/foundation/utilities/promise")
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

function AccountManagerSteam:open_to_store(to_target)
	if not Steam.is_overlay_enabled() then
		Log.info("AccountManagerSteam", "Can't open store. Steam Overlay is not enabled.")

		return Promise.resolved({
			success = true
		})
	end

	if type(to_target) == "number" then
		Steam.open_overlay_store(to_target)
	else
		Steam.open_url(to_target)
	end

	local did_open = false

	return Promise.until_value_is_true(function ()
		if Managers.steam:is_overlay_active() then
			did_open = true
		end

		local should_return = did_open and not Managers.steam:is_overlay_active()

		if not should_return then
			return false
		end

		return {
			success = true
		}
	end)
end

function AccountManagerSteam:is_owner_of(app_id)
	return Promise.resolved({
		is_owner = Steam.is_subscribed(app_id)
	})
end

return AccountManagerSteam
