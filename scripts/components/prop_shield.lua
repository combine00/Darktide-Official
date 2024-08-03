local PropShield = component("PropShield")

function PropShield:init(unit)
	self._unit = unit
	local shield_extension = ScriptUnit.fetch_component_extension(unit, "shield_system")

	if shield_extension then
		local actor_names = self:get_data(unit, "actor_names")

		shield_extension:setup_from_component(actor_names)
	end
end

function PropShield:editor_init(unit)
	return
end

function PropShield:editor_validate(unit)
	return true, ""
end

function PropShield:enable(unit)
	return
end

function PropShield:disable(unit)
	return
end

function PropShield:destroy(unit)
	return
end

PropShield.component_data = {
	actor_names = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "Shield Actors",
		values = {}
	},
	extensions = {
		"PropShieldExtension"
	}
}

return PropShield
