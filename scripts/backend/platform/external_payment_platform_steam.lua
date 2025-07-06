local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local ExternalPaymentPlatformBase = require("scripts/backend/platform/external_payment_platform_base")
local Promise = require("scripts/foundation/utilities/promise")
local ExternalPaymentPlatformSteam = class("ExternalPaymentPlatformSteam", "ExternalPaymentPlatformBase")

function ExternalPaymentPlatformSteam:get_payment_platform()
	return "steam"
end

function ExternalPaymentPlatformSteam:get_platform_token()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformSteam:update_account_store_status()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformSteam:payment_options()
	local language = "en"
	language = Steam.language()
	local builder = BackendUtilities.url_builder():path("/store/payment-options"):query("language", language)

	return Managers.backend:title_request(builder:to_string()):next(function (response)
		return response.body
	end)
end

function ExternalPaymentPlatformSteam:reconcile_pending_txns()
	return self:get_platform_token():next(function (token)
		return Managers.backend:authenticate():next(function (account)
			local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/payments/reconcile"):query("platform", self:get_payment_platform())

			return Managers.backend:title_request(builder:to_string(), {
				method = "POST",
				headers = {
					["platform-token"] = token
				}
			}):next(function (response)
				return response.body
			end)
		end)
	end)
end

function ExternalPaymentPlatformSteam:reconcile_dlc(store_ids)
	return self:get_platform_token():next(function (token)
		return Managers.backend:authenticate():next(function (account)
			local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/dlc/reconcile"):query("platform", self:get_payment_platform())

			return Managers.backend:title_request(builder:to_string(), {
				method = "POST",
				headers = {
					["platform-token"] = token
				}
			}):next(function (response)
				return response.body
			end):catch(function (error)
				Log.error("ExternalPayment", "Failed to reconcile dlc", tostring(error))

				return Promise.rejected({
					error = error
				})
			end)
		end)
	end)
end

function ExternalPaymentPlatformSteam:init_txn(payment_option)
	return Managers.backend:authenticate():next(function (account)
		local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/payments"):query("platform", self:get_payment_platform())

		return Managers.backend:title_request(builder:to_string(), {
			method = "POST",
			body = {
				paymentOptionId = payment_option
			}
		}):next(function (response)
			return response.body.orderId
		end)
	end)
end

function ExternalPaymentPlatformSteam:finalize_txn(order_id)
	return self:get_platform_token():next(function (token)
		return Managers.backend:authenticate():next(function (account)
			local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/payments/"):path(order_id):query("platform", self:get_payment_platform())

			return Managers.backend:title_request(builder:to_string(), {
				method = "POST",
				body = {
					placeholder = ""
				},
				headers = {
					["platform-token"] = token
				}
			}):next(function (response)
				return response.body.data
			end)
		end)
	end)
end

function ExternalPaymentPlatformSteam:fail_txn(order_id)
	return Managers.backend:authenticate():next(function (account)
		local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/payments/"):path(order_id):query("platform", self:get_payment_platform())

		return Managers.backend:title_request(builder:to_string(), {
			method = "DELETE"
		}):catch(function (error)
			Log.error("ExternalPayment", "Failed to remove pending transaction %s", tostring(error))

			return Promise.rejected({
				error = error
			})
		end)
	end)
end

local FAILED_TXN = {
	body = {
		state = "failed"
	}
}

function ExternalPaymentPlatformSteam:_decorate_option(option, platform_entitlements)
	option.description = {
		type = "currency",
		description = option.value.amount .. " " .. option.value.type
	}
	option.price = {
		amount = {}
	}
	option.price.amount.amount = option.steam.priceCents / 100
	option.price.amount.type = option.steam.currency

	function option:_on_micro_txn(authorized, order_id)
		if authorized then
			Managers.backend.interfaces.external_payment:finalize_txn(order_id):next(function (data)
				self.pending_txn_promise:resolve(data)

				self.pending_txn_promise = nil

				return data
			end):catch(function (data)
				self.pending_txn_promise:resolve(FAILED_TXN)

				self.pending_txn_promise = nil

				return data
			end)
		else
			Managers.backend.interfaces.external_payment:fail_txn(order_id):next(function (data)
				self.pending_txn_promise:resolve(data)

				self.pending_txn_promise = nil

				return data
			end):catch(function (data)
				self.pending_txn_promise:resolve(FAILED_TXN)

				self.pending_txn_promise = nil

				return data
			end)
		end
	end

	function option:seconds_remaining(now)
		return nil
	end

	function option:make_purchase()
		if self.pending_txn_promise then
			return Promise.rejected({
				message = "Called init transaction when a transaction was already pending"
			})
		end

		local pending_txn_promise = Promise:new()
		self.pending_txn_promise = pending_txn_promise

		Managers.backend.interfaces.external_payment:init_txn(self.id):next(function (order_id)
			Managers.steam:register_micro_txn_callback(order_id, callback(self, "_on_micro_txn"))
		end):catch(function (_)
			self.pending_txn_promise:resolve(FAILED_TXN)

			self.pending_txn_promise = nil
		end)

		return pending_txn_promise
	end
end

function ExternalPaymentPlatformSteam:get_options()
	local entitlement_promise = nil
	entitlement_promise = Promise.resolved(nil)

	return entitlement_promise:next(function (platform_entitlements)
		return self:payment_options():next(function (body)
			local options = body.options

			for _, v in ipairs(options) do
				self:_decorate_option(v, platform_entitlements and platform_entitlements.data or {})
			end

			local result = {
				offers = options
			}

			if body._links.layout then
				return Managers.backend:title_request(body._links.layout.href):next(function (data)
					data.body._links = nil
					result.layout_config = {
						layout = data.body
					}

					return result
				end)
			else
				return result
			end
		end)
	end)
end

return ExternalPaymentPlatformSteam
