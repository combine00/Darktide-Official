local InputManagerTestify = {}

function InputManagerTestify.input_service(input_manager, service_type)
	local input_service = input_manager:get_input_service(service_type)

	return input_service
end

return InputManagerTestify
