local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local ExternalPaymentPlatformBase = require("scripts/backend/platform/external_payment_platform_base")
local Promise = require("scripts/foundation/utilities/promise")
local ExternalPaymentPlatformPlaystation = class("ExternalPaymentPlatformPlaystation", "ExternalPaymentPlatformBase")

function ExternalPaymentPlatformPlaystation:get_payment_platform()
	return "psn"
end

function ExternalPaymentPlatformPlaystation:get_platform_token(retry_delay)
	local request_id, start_time = nil

	if retry_delay then
		start_time = Managers.time:time("main")
	end

	return Promise.until_value_is_true(function ()
		if retry_delay then
			local current_time = Managers.time:time("main")

			if current_time < start_time + retry_delay then
				return false
			else
				retry_delay = nil
			end
		end

		if not request_id then
			request_id = Playstation.request_auth_code()

			return false
		end

		local result, err = Playstation.get_auth_code_results(request_id)

		if err then
			Log.error("ExternalPayment", "get_auth_code_results() " .. "%s", err)

			return nil, {
				message = err
			}
		end

		if result then
			return result.authorization_code
		end

		return false
	end)
end

local function _show_commerce_dialogue(product_id)
	return Promise.until_value_is_true(function ()
		local status = NpCommerceDialog.update()

		if status == NpCommerceDialog.NONE then
			NpCommerceDialog.initialize()

			return false
		end

		if status == NpCommerceDialog.INITIALIZED then
			NpCommerceDialog.open2(NpCommerceDialog.MODE_PRODUCT, PS5.initial_user_id(), product_id)

			return false
		end

		if status == NpCommerceDialog.RUNNING then
			return false
		end

		local result, authorized = NpCommerceDialog.result()

		NpCommerceDialog.terminate()

		if result == NpCommerceDialog.RESULT_PURCHASED then
			return {
				success = true
			}
		else
			return {
				success = false
			}
		end
	end)
end

function ExternalPaymentPlatformPlaystation:show_commerce_dialogue(product_id)
	return _show_commerce_dialogue(product_id)
end

function ExternalPaymentPlatformPlaystation:update_account_store_status()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformPlaystation:payment_options()
	local language = "en"
	local builder = BackendUtilities.url_builder():path("/store/payment-options"):query("language", language)

	return Managers.backend:title_request(builder:to_string()):next(function (response)
		return response.body
	end)
end

function ExternalPaymentPlatformPlaystation:reconcile_pending_txns(retry_delay)
	return self:get_platform_token(retry_delay):next(function (token)
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
	end):catch(function (error)
		if type(error) == "table" and error.message then
			error = error.message
		end

		if not retry_delay then
			local retry_delay = 2

			Log.error("ExternalPayment", "Failed to reconcile pending transactions, error: %s, retrying again with a %s seconds delay", tostring(error), retry_delay)

			return self:reconcile_pending_txns(retry_delay)
		else
			Log.exception("ExternalPayment", "Failed to reconcile pending transactions, error: %s", tostring(error))

			return Promise.rejected({
				error
			})
		end
	end)
end

function ExternalPaymentPlatformPlaystation:reconcile_dlc(store_ids)
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

function ExternalPaymentPlatformPlaystation:get_entitlement(entitlement_key)
	return self:get_platform_token():next(function (token)
		return Managers.backend:authenticate():next(function (account)
			local builder = BackendUtilities.url_builder():path("/store/"):path(account.sub):path("/psn/entitlement"):query("platform", self:get_payment_platform()):query("entitlementId", entitlement_key)

			return Managers.backend:title_request(builder:to_string(), {
				method = "GET",
				headers = {
					["platform-token"] = token
				}
			}):next(function (response)
				return response.body
			end):catch(function (error)
				Log.error("ExternalPayment", "Failed to get entitlement", tostring(error))

				return Promise.rejected({
					error = error
				})
			end)
		end)
	end)
end

function ExternalPaymentPlatformPlaystation:init_txn_tmp(payment_option)
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformPlaystation:init_txn(payment_option)
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

function ExternalPaymentPlatformPlaystation:finalize_txn(order_id)
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

function ExternalPaymentPlatformPlaystation:fail_txn(order_id)
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

function ExternalPaymentPlatformPlaystation:_get_entitlements()
	if self._platform_entitlements then
		return Promise.resolved({
			success = true,
			data = self._platform_entitlements
		})
	end

	local web_api = WebApi
	local user_id = PS5.initial_user_id()
	local api_group = "inGameCatalog"
	local path = string.format("/v5/container?serviceLabel=%s&containerIds=%s", 0, "DTVCAQUILAS")
	local method = WebApi.GET
	local content = nil
	local id = web_api.send_request(user_id, api_group, path, method, content)

	return Promise.until_value_is_true(function ()
		local status = web_api.status(id)

		if status == web_api.COMPLETED then
			local response = web_api.request_result(id, web_api.STRING)
			local parsed = cjson.decode(response)

			if parsed[1] == nil then
				return {
					success = false
				}
			end

			local item_count = 0
			local result_by_id = {}

			for i, v in ipairs(parsed[1].children) do
				local product = {
					displayPrice = v.skus[1].displayPrice
				}
				result_by_id[v.label] = product
				item_count = item_count + 1
			end

			if item_count == 0 then
				return {
					success = false
				}
			end

			self._platform_entitlements = result_by_id

			return {
				success = true,
				data = self._platform_entitlements
			}
		elseif status == web_api.ERROR then
			return {
				success = false
			}
		end

		return false
	end)
end

function ExternalPaymentPlatformPlaystation:_decorate_option(option, platform_entitlements)
	option.description = {
		type = "currency",
		description = option.value.amount .. " " .. option.value.type
	}
	option.price = {
		amount = {}
	}
	local offer_id = option.psn and option.psn.productId
	local offer = platform_entitlements[offer_id]

	if offer then
		option.price.amount.formattedPrice = offer.displayPrice
	end

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
			local product_id = self.psn and self.psn.productId

			if product_id then
				_show_commerce_dialogue(product_id):next(function (status)
					if status.success then
						return Managers.backend.interfaces.external_payment:finalize_txn(order_id):next(function (data)
							self.pending_txn_promise:resolve(data)

							self.pending_txn_promise = nil

							return data
						end):catch(function (data)
							self.pending_txn_promise:resolve(FAILED_TXN)

							self.pending_txn_promise = nil

							return data
						end)
					else
						return Managers.backend.interfaces.external_payment:fail_txn(order_id):next(function (data)
							self.pending_txn_promise:resolve(FAILED_TXN)

							self.pending_txn_promise = nil

							return data
						end):catch(function (data)
							self.pending_txn_promise:resolve(FAILED_TXN)

							self.pending_txn_promise = nil

							return data
						end)
					end
				end)
			else
				Log.error("ExternalPayment", "Attempted to make purchase on psn but psn product id was missing")
				self.pending_txn_promise:resolve(FAILED_TXN)

				self.pending_txn_promise = nil
			end
		end):catch(function (_)
			self.pending_txn_promise:resolve(FAILED_TXN)

			self.pending_txn_promise = nil
		end)

		return pending_txn_promise
	end
end

function ExternalPaymentPlatformPlaystation:get_options()
	local entitlement_promise = nil
	entitlement_promise = self:_get_entitlements()

	return entitlement_promise:next(function (platform_entitlements)
		if platform_entitlements.success == false then
			return Promise.rejected({
				error = "empty_store"
			})
		end

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

function ExternalPaymentPlatformPlaystation:show_empty_store_error()
	return Promise.until_value_is_true(function ()
		local status = MsgDialog.update()

		if status == MsgDialog.NONE then
			MsgDialog.initialize()

			return false
		end

		if status == MsgDialog.INITIALIZED then
			MsgDialog.open(MsgDialog.SYSTEM_MSG_EMPTY_STORE, PS5.initial_user_id())

			return false
		end

		if status == MsgDialog.RUNNING then
			return false
		end

		MsgDialog.terminate()

		return {
			success = true
		}
	end)
end

return ExternalPaymentPlatformPlaystation
