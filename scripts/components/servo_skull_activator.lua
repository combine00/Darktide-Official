local ServoSkullActivator = component("ServoSkullActivator")

function ServoSkullActivator:init(unit)
	return
end

function ServoSkullActivator:editor_init(unit)
	return
end

function ServoSkullActivator:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_visibility_group(unit, "main") then
		success = false
		error_message = error_message .. "\nCouldn't find visibility group 'main'"
	end

	return success, error_message
end

function ServoSkullActivator:enable(unit)
	return
end

function ServoSkullActivator:disable(unit)
	return
end

function ServoSkullActivator:destroy(unit)
	return
end

ServoSkullActivator.component_data = {
	extensions = {
		"ServoSkullActivatorExtension"
	}
}

return ServoSkullActivator
