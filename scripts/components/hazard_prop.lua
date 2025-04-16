local HazardProp = component("HazardProp")

function HazardProp:init(unit, is_server)
	self._is_server = is_server
	local hazard_prop_extension = ScriptUnit.fetch_component_extension(unit, "hazard_prop_system")

	if hazard_prop_extension then
		local hazard_shape = self:get_data(unit, "hazard_shape")
		local broadphase_radius = self:get_data(unit, "broadphase_radius")

		hazard_prop_extension:setup_from_component(hazard_shape, broadphase_radius)

		self._hazard_prop_extension = hazard_prop_extension
	end
end

function HazardProp:editor_init(unit)
	return
end

function HazardProp:editor_validate(unit)
	return true, ""
end

function HazardProp:enable(unit)
	return
end

function HazardProp:disable(unit)
	return
end

function HazardProp:destroy(unit)
	return
end

function HazardProp.events:add_damage(damage_amount, hit_actor, attack_direction)
	local hazard_prop_extension = self._hazard_prop_extension

	if self._is_server and hazard_prop_extension then
		hazard_prop_extension:add_damage(damage_amount, hit_actor, attack_direction)
	end
end

HazardProp.component_data = {
	extensions = {
		"HazardPropExtension"
	},
	hazard_shape = {
		value = "barrel",
		ui_type = "combo_box",
		ui_name = "Collider Setup",
		options_keys = {
			"barrel/canister/pipe",
			"sphere"
		},
		options_values = {
			"barrel",
			"sphere"
		}
	},
	broadphase_radius = {
		ui_type = "number",
		min = 0.1,
		max = 40,
		decimals = 2,
		value = 0.5,
		ui_name = "Broadphase Radius",
		step = 0.1
	}
}

return HazardProp
