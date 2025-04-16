local ErrorInterface = require("scripts/managers/error/errors/error_interface")
local ErrorManager = require("scripts/managers/error/error_manager")
local PsPlusError = class("PsPlusError")

function PsPlusError:init(original_error)
	if type(original_error) == "string" then
		self._log_message = original_error
	elseif type(original_error) == "table" then
		self._log_message = table.tostring(original_error, 3)
	end
end

function PsPlusError:level()
	return ErrorManager.ERROR_LEVEL.error
end

function PsPlusError:log_message()
	return self._log_message
end

function PsPlusError:loc_title()
	return "loc_popup_header_error"
end

function PsPlusError:loc_description()
	return "loc_psn_premium_fail_desc"
end

function PsPlusError:options()
	return
end

implements(PsPlusError, ErrorInterface)

return PsPlusError
