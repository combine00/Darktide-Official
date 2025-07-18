local HeresyFinaleMaterialVariables = component("HeresyFinaleMaterialVariables")

function HeresyFinaleMaterialVariables:init(unit)
	self._unit = unit
	self._world = Unit.world(unit)
	self._start_effect_time_variable_name = self:get_data(unit, "start_effect_time_variable_name")
	self._material_slot_name = self:get_data(unit, "material_slot_name")
	self._start_effect_duration = self:get_data(unit, "start_effect_duration")
	self._start_effect_duration_variable_name = self:get_data(unit, "start_effect_variable_name")
	self._stage2_effect_time_variable_name = self:get_data(unit, "stage2_time_variable_name")
	self._stage2_effect_duration = self:get_data(unit, "stage2_effect_duration")
	self._stage2_effect_duration_variable_name = self:get_data(unit, "stage2_effect_variable_name")
	self._stage3_effect_time_variable_name = self:get_data(unit, "stage3_time_variable_name")
	self._stage3_effect_duration = self:get_data(unit, "stage3_effect_duration")
	self._stage3_effect_duration_variable_name = self:get_data(unit, "stage3_effect_variable_name")
	self._stage4_effect_time_variable_name = self:get_data(unit, "stage4_time_variable_name")
	self._stage4_effect_duration = self:get_data(unit, "stage4_effect_duration")
	self._stage4_effect_duration_variable_name = self:get_data(unit, "stage4_effect_variable_name")
end

function HeresyFinaleMaterialVariables:editor_validate(unit)
	return true, ""
end

function HeresyFinaleMaterialVariables:enable(unit)
	return
end

function HeresyFinaleMaterialVariables:disable(unit)
	return
end

function HeresyFinaleMaterialVariables:destroy(unit)
	return
end

function HeresyFinaleMaterialVariables:start_effect()
	local t = World.time(self._world)

	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._start_effect_time_variable_name, t)
	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._start_effect_duration_variable_name, self._start_effect_duration)
	Log.info("hello")
end

function HeresyFinaleMaterialVariables:stage2_effect()
	local t = World.time(self._world)

	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage2_effect_time_variable_name, t)
	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage2_effect_duration_variable_name, self._stage2_effect_duration)
	Log.info("hello")
end

function HeresyFinaleMaterialVariables:stage3_effect()
	local t = World.time(self._world)

	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage3_effect_time_variable_name, t)
	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage3_effect_duration_variable_name, self._stage3_effect_duration)
end

function HeresyFinaleMaterialVariables:stage4_effect()
	local t = World.time(self._world)

	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage4_effect_time_variable_name, t)
	Unit.set_scalar_for_material(self._unit, self._material_slot_name, self._stage4_effect_duration_variable_name, self._stage4_effect_duration)
end

HeresyFinaleMaterialVariables.component_data = {
	start_effect_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Start Effect Start Time Variable"
	},
	material_slot_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Material Slot Name"
	},
	start_effect_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Start Effect Duration Variable"
	},
	start_effect_duration = {
		ui_type = "number",
		decimals = 2,
		value = 1,
		ui_name = "Start Effect Duration",
		step = 0.01
	},
	stage2_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 2 Effect Start Time Variable"
	},
	stage2_effect_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 2 Effect Duration Variable"
	},
	stage2_effect_duration = {
		ui_type = "number",
		decimals = 2,
		value = 1,
		ui_name = "Stage 2 Effect Duration",
		step = 0.01
	},
	stage3_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 2 Effect Start Time Variable"
	},
	stage3_effect_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 3 Effect Duration Variable"
	},
	stage3_effect_duration = {
		ui_type = "number",
		decimals = 2,
		value = 1,
		ui_name = "Stage 3 Effect Duration",
		step = 0.01
	},
	stage4_time_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 2 Effect Start Time Variable"
	},
	stage4_effect_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Stage 4 Effect Duration Variable"
	},
	stage4_effect_duration = {
		ui_type = "number",
		decimals = 2,
		value = 1,
		ui_name = "Stage 4 Effect Duration",
		step = 0.01
	},
	inputs = {
		start_effect = {
			accessibility = "public",
			type = "event"
		},
		stage2_effect = {
			accessibility = "public",
			type = "event"
		},
		stage3_effect = {
			accessibility = "public",
			type = "event"
		},
		stage4_effect = {
			accessibility = "public",
			type = "event"
		}
	}
}

return HeresyFinaleMaterialVariables
