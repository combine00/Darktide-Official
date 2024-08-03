local ErrorCodes = require("scripts/managers/error/error_codes")
local ErrorInterface = require("scripts/managers/error/errors/error_interface")
local ErrorManager = require("scripts/managers/error/error_manager")
local MultiplayerSessionDisconnectError = class("MultiplayerSessionDisconnectError")

function MultiplayerSessionDisconnectError:init(error_source, error_reason, optional_error_details)
	self._error_reason = error_reason
	local error_details = "n/a"

	if optional_error_details then
		if type(optional_error_details) == "table" then
			error_details = table.tostring(optional_error_details, 3)
		else
			error_details = optional_error_details
		end
	end

	self._log_message = string.format("source: %s, reason: %s, error_details: %s", error_source, error_reason, error_details)

	if ErrorCodes.should_report_to_crashify(error_reason) then
		Crashify.print_exception("MultiplayerSessionDisconnectError", error_reason)
	end
end

function MultiplayerSessionDisconnectError:level()
	local error_level = ErrorCodes.get_error_code_level_from_reason(self._error_reason)

	return ErrorManager.ERROR_LEVEL[error_level]
end

function MultiplayerSessionDisconnectError:log_message()
	return self._log_message
end

function MultiplayerSessionDisconnectError:loc_title()
	local override, title = ErrorCodes.get_error_code_title_from_reason(self._error_reason, false)

	if override then
		return title
	end

	return "loc_disconnected_from_server"
end

function MultiplayerSessionDisconnectError:loc_description()
	local error_reason = self._error_reason
	local override, title, format = ErrorCodes.get_error_code_description_from_reason(error_reason, false)

	if override then
		return title, format
	end

	local error_code_string = ErrorCodes.get_error_code_string_from_reason(error_reason)
	local string_format = "%s %s"

	return "loc_error_reason", {
		error_reason = error_code_string
	}, string_format
end

function MultiplayerSessionDisconnectError:options()
	return
end

implements(MultiplayerSessionDisconnectError, ErrorInterface)

return MultiplayerSessionDisconnectError
