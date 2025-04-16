local ExternalPaymentPlatformInterface = require("scripts/backend/platform/external_payment_platform_interface")
local Promise = require("scripts/foundation/utilities/promise")
local ExternalPaymentPlatformBase = class("ExternalPaymentPlatformBase")

function ExternalPaymentPlatformBase:_get_platform_token()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:_get_payment_platform()
	return "none"
end

function ExternalPaymentPlatformBase:payment_options()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:update_account_store_status()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:reconcile_pending_txns()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:reconcile_dlc(store_ids)
	return Promise.rejected({})
end

function ExternalPaymentPlatformBase:get_options()
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:init_txn(payment_option)
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:finalize_txn(order_id)
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:fail_txn(order_id)
	return Promise.resolved(nil)
end

function ExternalPaymentPlatformBase:show_empty_store_error()
	return Promise.resolved(nil)
end

implements(ExternalPaymentPlatformBase, ExternalPaymentPlatformInterface)

return ExternalPaymentPlatformBase
