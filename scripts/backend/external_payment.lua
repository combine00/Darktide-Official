local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local ExternalPaymentPlatformBase = require("scripts/backend/platform/external_payment_platform_base")
local ExternalPaymentPlatformSteam = require("scripts/backend/platform/external_payment_platform_steam")
local ExternalPaymentPlatformXbox = require("scripts/backend/platform/external_payment_platform_xbox")
local ExternalPaymentPlatformPlaystation = require("scripts/backend/platform/external_payment_platform_playstation")
local ExternalPaymentPlatform = {
	[Backend.AUTH_METHOD_NONE] = ExternalPaymentPlatformBase,
	[Backend.AUTH_METHOD_STEAM] = ExternalPaymentPlatformSteam,
	[Backend.AUTH_METHOD_XBOXLIVE] = ExternalPaymentPlatformXbox,
	[Backend.AUTH_METHOD_PSN] = ExternalPaymentPlatformPlaystation,
	[Backend.AUTH_METHOD_DEV_USER] = ExternalPaymentPlatformBase,
	[Backend.AUTH_METHOD_AWS] = ExternalPaymentPlatformBase
}
local ExternalPayment = {
	new = function (self)
		local authenticate_method = Backend:get_auth_method()
		local instance = ExternalPaymentPlatform[authenticate_method]:new()

		return instance
	end
}

return ExternalPayment
