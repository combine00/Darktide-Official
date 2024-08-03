local WeaponMaterialVariables = component("WeaponMaterialVariables")

function WeaponMaterialVariables:init(unit)
	self._start_time_variable_name = self:get_data(unit, "start_time_variable_name")
	self._stop_time_variable_name = self:get_data(unit, "stop_time_variable_name")
	self._on_off_variable_name = self:get_data(unit, "on_off_variable_name")
	self._material_slot_name = self:get_data(unit, "material_slot_name")
	self._intensity_variable_names = self:get_data(unit, "intensity_variable_names")
end

function WeaponMaterialVariables:editor_validate(unit)
	return true, ""
end

function WeaponMaterialVariables:enable(unit)
	return
end

function WeaponMaterialVariables:disable(unit)
	return
end

function WeaponMaterialVariables:destroy(unit)
	return
end

function WeaponMaterialVariables:set_start_time(t, unit)
	Unit.set_scalar_for_material(unit, self._material_slot_name, self._start_time_variable_name, t)
	Unit.set_scalar_for_material(unit, self._material_slot_name, self._on_off_variable_name, 1)
end

function WeaponMaterialVariables:set_stop_time(t, unit)
	Unit.set_scalar_for_material(unit, self._material_slot_name, self._stop_time_variable_name, t)
	Unit.set_scalar_for_material(unit, self._material_slot_name, self._on_off_variable_name, 0)
end

function WeaponMaterialVariables:set_intensity(intensity, unit)
	local intensity_variable_names = self._intensity_variable_names
	local material_slot_name = self._material_slot_name

	for ii = 1, #intensity_variable_names do
		local variable_name = intensity_variable_names[ii].variable_name

		Unit.set_scalar_for_material(unit, material_slot_name, variable_name, intensity)
	end
end

WeaponMaterialVariables.component_data = {
	start_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Start Time Variable"
	},
	stop_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stop Time Variable"
	},
	on_off_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "On/Off Variable"
	},
	material_slot_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Material Slot Name"
	},
	intensity_variable_names = {
		ui_type = "struct_array",
		ui_name = "Intensity Variables",
		definition = {
			variable_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Variable Name"
			}
		},
		control_order = {
			"variable_name"
		}
	}
}

return WeaponMaterialVariables
