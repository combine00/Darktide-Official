local SmartTagTarget = component("SmartTagTarget")

function SmartTagTarget:init(unit)
	self:enable(unit)

	local smart_tag_extension = ScriptUnit.fetch_component_extension(unit, "smart_tag_system")

	if smart_tag_extension then
		local target_type = self:get_data(unit, "target_type")

		smart_tag_extension:setup_from_component(target_type)
	end
end

function SmartTagTarget:editor_init(unit)
	self:enable(unit)
end

function SmartTagTarget:editor_validate(unit)
	return true, ""
end

function SmartTagTarget:enable(unit)
	return
end

function SmartTagTarget:disable(unit)
	return
end

function SmartTagTarget:destroy(unit)
	return
end

SmartTagTarget.component_data = {
	target_type = {
		value = "health_station",
		ui_type = "combo_box",
		ui_name = "Target Type",
		options_keys = {
			"health_station",
			"pickup"
		},
		options_values = {
			"health_station",
			"pickup"
		}
	},
	extensions = {
		"SmartTagExtension"
	}
}

return SmartTagTarget
