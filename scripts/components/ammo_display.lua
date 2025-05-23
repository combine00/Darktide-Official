local AmmoDisplay = component("AmmoDisplay")

function AmmoDisplay:editor_init(unit)
	self._max_ammo = self:get_data(unit, "max_ammo")
	self._ammo = self:get_data(unit, "ammo")
	self._ammo_display_steps = self:get_data(unit, "ammo_display_steps")
	self._critical_threshold = self:get_data(unit, "critical_threshold")
	self._material_slot_name = self:get_data(unit, "material_slot_name")

	self:enable(unit)
end

function AmmoDisplay:editor_validate(unit)
	return true, ""
end

function AmmoDisplay:init(unit)
	self._max_ammo = self:get_data(unit, "max_ammo")
	self._ammo = self:get_data(unit, "ammo")
	self._ammo_display_steps = self:get_data(unit, "ammo_display_steps")
	self._critical_threshold = self:get_data(unit, "critical_threshold")
	self._material_slot_name = self:get_data(unit, "material_slot_name")

	self:enable(unit)
end

function AmmoDisplay:enable(unit)
	self:_update_material_values(unit, 0, false)
end

function AmmoDisplay:disable(unit)
	return
end

function AmmoDisplay:destroy(unit)
	return
end

function AmmoDisplay:set_ammo(unit, ammo, max_ammo, critical_threshold)
	if ammo == 0 then
		ammo = 1
	end

	if max_ammo == 0 then
		max_ammo = 1
	end

	if max_ammo ~= self._max_ammo then
		self._max_ammo = max_ammo
	end

	if ammo ~= self._ammo or critical_threshold ~= self._critical_threshold then
		self._ammo = ammo
		self._critical_threshold = critical_threshold
		local charge_value = ammo / max_ammo
		local critical_value = critical_threshold / max_ammo
		local is_critical = charge_value <= critical_value

		self:_update_material_values(unit, charge_value, is_critical, is_critical and Vector3(0.5, 0, 0), Vector3(0, 0.5, 0))
	end
end

function AmmoDisplay:_update_material_values(unit, charge_value, is_critical, color)
	local material_slot_name = self._material_slot_name
	local num_steps = self._ammo_display_steps

	Unit.set_scalar_for_material(unit, material_slot_name, "charge", charge_value)
	Unit.set_scalar_for_material(unit, material_slot_name, "warning", is_critical and 1 or 0)
	Unit.set_scalar_for_material(unit, material_slot_name, "steps", num_steps)
	Unit.set_vector3_for_material(unit, material_slot_name, "color", color or Vector3(0, 0.5, 0))
end

AmmoDisplay.component_data = {
	ammo_display_steps = {
		ui_type = "slider",
		decimals = 0,
		value = 6,
		ui_name = "Ammo Steps",
		step = 1
	},
	max_ammo = {
		ui_type = "slider",
		decimals = 0,
		value = 30,
		ui_name = "Max Ammo",
		step = 1
	},
	ammo = {
		ui_type = "slider",
		step = 1,
		decimals = 0,
		value = 30,
		ui_name = "Ammo",
		max = 30
	},
	critical_threshold = {
		ui_type = "slider",
		step = 1,
		decimals = 0,
		value = 3,
		ui_name = "Critical Threshold",
		max = 30
	},
	material_slot_name = {
		ui_type = "text_box",
		value = "display_01",
		ui_name = "Material Slot Name"
	}
}

return AmmoDisplay
