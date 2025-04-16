local RitualShield = component("RitualShield")

function RitualShield:init(unit)
	self._unit = unit
	self._material_slot_name = self:get_data(unit, "material_slot_name")
	self._dissolve_variable_name = self:get_data(unit, "dissolve_variable_name")
	self._dissolve_duration = self:get_data(unit, "dissolve_duration")
	self._dissolve_timer = nil
	self._pulse_variable_name = self:get_data(unit, "pulse_variable_name")
	self._pulse_duration = self:get_data(unit, "pulse_duration")
	self._pulse_timer = nil
	self._dissolve_done = false
	self._pulse_done = false

	return true
end

function RitualShield:editor_init(unit)
	self:enable(unit)
end

function RitualShield:editor_validate(unit)
	return true, ""
end

function RitualShield:enable(unit)
	return
end

function RitualShield:disable(unit)
	return
end

function RitualShield:destroy(unit)
	return
end

function RitualShield:update(unit, dt, t)
	if self._pulse_timer and self._pulse_timer >= 0 then
		local lerp_t = (self._pulse_duration - self._pulse_timer) / self._pulse_duration
		local pulse_variable_value = math.ease_in_exp(math.lerp(0, 1, lerp_t))

		Unit.set_scalar_for_material(unit, self._material_slot_name, self._pulse_variable_name, pulse_variable_value)

		self._pulse_timer = self._pulse_timer - dt
		self._pulse_done = self._pulse_timer <= 0
	end

	if self._dissolve_timer and self._dissolve_timer >= 0 then
		local lerp_t = (self._dissolve_duration - self._dissolve_timer) / self._dissolve_duration
		local dissolve_variable_value = math.ease_in_exp(math.lerp(-1, 2, lerp_t))

		Unit.set_scalar_for_material(unit, self._material_slot_name, self._dissolve_variable_name, dissolve_variable_value)

		self._dissolve_timer = self._dissolve_timer - dt
		self._dissolve_done = self._dissolve_timer <= 0
	end

	return not self._pulse_done or not self._dissolve_done
end

function RitualShield:start_dissolve()
	self._dissolve_timer = self._dissolve_duration
end

function RitualShield:start_pulse()
	local unit = self._unit
	self._pulse_duration = self:get_data(unit, "pulse_duration")
	self._pulse_timer = self._pulse_duration

	Unit.set_scalar_for_material(unit, self._material_slot_name, "pulse_on_off", 1)
end

RitualShield.component_data = {
	material_slot_name = {
		ui_type = "text_box",
		value = "physics",
		ui_name = "Material Slot Name"
	},
	dissolve_variable_name = {
		ui_type = "text_box",
		value = "dissolve",
		ui_name = "Dissolve Variable Name",
		category = "Material Variable Name"
	},
	dissolve_duration = {
		ui_type = "number",
		min = 0.5,
		decimals = 3,
		value = 1,
		ui_name = "Dissolve Duration",
		max = 10
	},
	pulse_variable_name = {
		ui_type = "text_box",
		value = "pulse_intensity",
		ui_name = "Pulse Variable Name",
		category = "Material Variable Name"
	},
	pulse_duration = {
		ui_type = "number",
		min = 0.5,
		decimals = 3,
		value = 5,
		ui_name = "Pulse Duration",
		max = 10
	},
	inputs = {
		start_pulse = {
			accessibility = "public",
			type = "event"
		},
		start_dissolve = {
			accessibility = "public",
			type = "event"
		}
	}
}

return RitualShield
