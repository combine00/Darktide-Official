local PlasmaCoil = component("PlasmaCoil")

function PlasmaCoil:init(unit)
	self._coil_variable_name = self:get_data(unit, "coil_variable_name")
	self._coil_material_slot_name = self:get_data(unit, "coil_material_slot_name")
	self._overheat_percentage = nil

	self:enable(unit)
end

function PlasmaCoil:editor_init(unit)
	self:init(unit)
end

function PlasmaCoil:editor_validate(unit)
	return true, ""
end

function PlasmaCoil:enable(unit)
	self:set_overheat(unit, 0)
end

function PlasmaCoil:disable(unit)
	return
end

function PlasmaCoil:destroy(unit)
	return
end

function PlasmaCoil:set_overheat(unit, overheat_percentage)
	if self._overheat_percentage ~= overheat_percentage then
		Unit.set_scalar_for_material(unit, self._coil_material_slot_name, self._coil_variable_name, overheat_percentage)

		self._overheat_percentage = overheat_percentage
	end
end

PlasmaCoil.component_data = {
	coil_material_slot_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Material Slot Name"
	},
	coil_variable_name = {
		ui_type = "text_box",
		value = "external_overheat_glow",
		ui_name = "Material Variable Name"
	}
}

return PlasmaCoil
