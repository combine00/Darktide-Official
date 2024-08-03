local PlacementVisibility = component("PlacementVisibility")

function PlacementVisibility:init(unit)
	self._unit = unit
	local interactee_extension = ScriptUnit.has_extension(unit, "interactee_system")
	self._interactee_extension = interactee_extension
	self._placed = false
	self._show = interactee_extension and interactee_extension:active()
	local material_slots = self:get_data(unit, "material_slots")
	self._material_slots = material_slots
	local main_materials = self:get_data(unit, "main_materials")
	self._material_resources = main_materials
	local ghost_material = self:get_data(unit, "ghost_material")
	self._ghost_material = ghost_material

	for i = 1, #material_slots do
		if material_slots[i] == "" then
			Log.error("PlacementVisibility", "Undefined material slot with index %s.", i)
		elseif main_materials[i] == "" then
			Log.error("PlacementVisibility", "Missing materials for material %s", material_slots[i])
		end
	end

	if ghost_material == "" then
		Log.error("PlacementVisibility", "Missing ghost material.")
	end

	self:_update_visibility()
end

function PlacementVisibility:editor_init(unit)
	return
end

function PlacementVisibility:editor_validate(unit)
	return true, ""
end

function PlacementVisibility:enable(unit)
	return
end

function PlacementVisibility:disable(unit)
	return
end

function PlacementVisibility:destroy(unit)
	return
end

function PlacementVisibility:_update_visibility()
	local unit = self._unit
	local material_slots = self._material_slots

	if self._placed then
		local materials = self._material_resources

		for i = 1, #material_slots do
			local material_slot_name = material_slots[i]

			Unit.set_unit_visibility(unit, true)
			Unit.set_material(unit, material_slot_name, materials[i])
		end
	elseif self._show then
		local ghost_material = self._ghost_material

		for i = 1, #material_slots do
			local material_slot_name = material_slots[i]

			Unit.set_unit_visibility(unit, true)
			Unit.set_material(unit, material_slot_name, ghost_material)
		end
	else
		Unit.set_unit_visibility(unit, false)
	end
end

function PlacementVisibility.events:interactee_hot_joined()
	local interactee_extension = self._interactee_extension
	self._show = interactee_extension and interactee_extension:active()

	self:_update_visibility()
end

function PlacementVisibility.events:interaction_success(type, unit)
	self:place(unit)
end

function PlacementVisibility:place()
	if not self._show then
		Log.warning("PlacementVisibility", "Placed while disabled")

		return
	end

	self._placed = true

	self:_update_visibility()
end

function PlacementVisibility:remove()
	self._placed = false
	self._show = false

	self:_update_visibility()
end

function PlacementVisibility:visibility_enable()
	self._show = true

	self:_update_visibility()
end

function PlacementVisibility:visibility_disable()
	if self._placed then
		Log.warning("PlacementVisibility", "Trying to disable when already placed, not possible")

		return
	end

	self._show = false

	self:_update_visibility()
end

PlacementVisibility.component_data = {
	material_slots = {
		ui_type = "text_box_array",
		value = "",
		ui_name = "Material Slot",
		category = "Material"
	},
	main_materials = {
		ui_type = "resource_array",
		category = "Material",
		value = "",
		ui_name = "Main Material",
		filter = "material"
	},
	ghost_material = {
		ui_type = "resource",
		category = "Material",
		value = "",
		ui_name = "Ghost Material",
		filter = "material"
	},
	inputs = {
		visibility_enable = {
			accessibility = "public",
			type = "event"
		},
		visibility_disable = {
			accessibility = "public",
			type = "event"
		},
		place = {
			accessibility = "public",
			type = "event"
		},
		remove = {
			accessibility = "public",
			type = "event"
		}
	}
}

return PlacementVisibility
