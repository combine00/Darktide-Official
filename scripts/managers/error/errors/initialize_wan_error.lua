local ErrorInterface = require("scripts/managers/error/errors/error_interface")
local ErrorManager = require("scripts/managers/error/error_manager")
local InitializeWanError = class("InitializeWanError")

function InitializeWanError:init(original_error)
	if type(original_error) == "string" then
		self._log_message = original_error
	elseif type(original_error) == "table" then
		self._log_message = table.tostring(original_error, 3)
	end
end

function InitializeWanError:level()
	return ErrorManager.ERROR_LEVEL.error
end

function InitializeWanError:log_message()
	return self._log_message
end

function InitializeWanError:loc_title()
	return "loc_popup_header_initialize_wan_error"
end

function InitializeWanError:loc_description()
	return "loc_popup_description_initialize_wan_error"
end

function InitializeWanError:options()
	return
end

implements(InitializeWanError, ErrorInterface)

return InitializeWanError
