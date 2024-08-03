local ServoSkull = component("ServoSkull")

function ServoSkull:init(unit)
	local servo_skull_extension = ScriptUnit.fetch_component_extension(unit, "servo_skull_system")

	if servo_skull_extension then
		local pulse_interval = self:get_data(unit, "pulse_interval")

		servo_skull_extension:setup_from_component(pulse_interval)
	end
end

function ServoSkull:editor_init(unit)
	return
end

function ServoSkull:editor_validate(unit)
	return true, ""
end

function ServoSkull:enable(unit)
	return
end

function ServoSkull:disable(unit)
	return
end

function ServoSkull:destroy(unit)
	return
end

ServoSkull.component_data = {
	pulse_interval = {
		ui_type = "number",
		value = 10,
		ui_name = "Pulse Interval"
	},
	extensions = {
		"ServoSkullExtension"
	}
}

return ServoSkull
