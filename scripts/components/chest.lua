local Chest = component("Chest")

function Chest:init(unit)
	local chest_extension = ScriptUnit.fetch_component_extension(unit, "chest_system")

	if chest_extension then
		local locked = self:get_data(unit, "locked")

		chest_extension:setup_from_component(locked)
	end
end

function Chest:editor_init(unit)
	return
end

function Chest:editor_validate(unit)
	return true, ""
end

function Chest:enable(unit)
	return
end

function Chest:disable(unit)
	return
end

function Chest:destroy(unit)
	return
end

Chest.component_data = {
	locked = {
		ui_type = "check_box",
		value = false,
		ui_name = "Locked"
	},
	extensions = {
		"ChestExtension"
	}
}

return Chest
