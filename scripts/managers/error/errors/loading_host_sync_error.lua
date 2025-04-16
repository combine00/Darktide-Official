local ErrorInterface = require("scripts/managers/error/errors/error_interface")
local ErrorManager = require("scripts/managers/error/error_manager")
local LoadingHostSyncError = class("LoadingHostSyncError")
local LOOKUP_ERROR_REASON = {
	sync_other = {
		log_message = "Failed to sync with other peers",
		error_code = 1
	},
	sync_spawning = {
		log_message = "Failed to sync with spawning peers",
		error_code = 2
	},
	sync_host = {
		log_message = "Failed to sync with host",
		error_code = 3
	},
	unknown = {
		log_message = "Unknown error",
		error_code = 99
	}
}

function LoadingHostSyncError:init(optional_error_details)
	optional_error_details = optional_error_details or "unknown"
	local reason_data = LOOKUP_ERROR_REASON[optional_error_details] or LOOKUP_ERROR_REASON.unknown
	self._error_log_message = reason_data.log_message
	self._error_code = reason_data.error_code
end

function LoadingHostSyncError:level()
	return ErrorManager.ERROR_LEVEL.warning_popup
end

function LoadingHostSyncError:log_message()
	return self._error_log_message
end

function LoadingHostSyncError:loc_title()
	return "loc_popup_header_loading_host_sync_error"
end

function LoadingHostSyncError:loc_description()
	return "loc_popup_description_loading_host_sync_error", {
		error_code = self._error_code
	}
end

function LoadingHostSyncError:options()
	return
end

implements(LoadingHostSyncError, ErrorInterface)

return LoadingHostSyncError
