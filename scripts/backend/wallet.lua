local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Wallet = class("Wallet")

function Wallet:get_currency_configuration()
	return Managers.backend:title_request("/store/currencies", {
		method = "GET"
	}):next(function (data)
		return data.body.currencies
	end)
end

function Wallet:character_wallets(character_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder():path(character_id):path("/wallets")):next(function (data)
		local wallets = data.body.wallets

		return wallets
	end)
end

function Wallet:account_wallets()
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder():path("wallets")):next(function (data)
		local wallets = data.body.wallets

		return wallets
	end)
end

return Wallet
