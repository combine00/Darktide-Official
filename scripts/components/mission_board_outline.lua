local MissionBoardOutline = component("MissionBoardOutline")

function MissionBoardOutline:init(unit)
	self._unit = unit
	self._world = Unit.world(unit)
	self._variable_name = self:get_data(unit, "variable_name")
	self._material_layer_name = self:get_data(unit, "material_layer_name")
	self._material_slot_name = self:get_data(unit, "material_slot_name")
	self._lerp_on = false
end

function MissionBoardOutline:editor_validate(unit)
	return true, ""
end

function MissionBoardOutline:enable(unit)
	return
end

function MissionBoardOutline:disable(unit)
	return
end

function MissionBoardOutline:destroy(unit)
	return
end

function MissionBoardOutline:outline_on()
	Unit.set_material_layer(self._unit, self._material_layer_name, true)
end

function MissionBoardOutline:outline_off()
	Unit.set_material_layer(self._unit, self._material_layer_name, false)
end

MissionBoardOutline.component_data = {
	variable_name = {
		ui_type = "text_box",
		value = "on_off",
		ui_name = "variable name"
	},
	material_slot_name = {
		ui_type = "text_box",
		value = "hologram",
		ui_name = "material slot name"
	},
	material_layer_name = {
		ui_type = "text_box",
		value = "hologram_outline",
		ui_name = "material layer name"
	},
	inputs = {
		outline_on = {
			accessibility = "public",
			type = "event"
		},
		outline_off = {
			accessibility = "public",
			type = "event"
		}
	}
}

return MissionBoardOutline
