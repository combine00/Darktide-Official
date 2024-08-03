local SplineGroup = component("SplineGroup")

function SplineGroup:init(unit)
	local spline_group_extension = ScriptUnit.fetch_component_extension(unit, "spline_group_system")

	if spline_group_extension then
		local objective_name = self:get_data(unit, "objective_name")
		local spline_names = self:get_data(unit, "spline_names")

		spline_group_extension:setup_from_component(objective_name, spline_names)
	end
end

function SplineGroup:editor_init(unit)
	return
end

function SplineGroup:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") then
		local objective_name = self:get_data(unit, "objective_name")

		if objective_name == "" or objective_name == "None" then
			error_message = error_message .. "\nObjective Name can't be empty. Available Objective Names are found in one of the '..._objective_template.lua' files"
			success = false
		end

		local spline_names = self:get_data(unit, "spline_names")

		for i = 1, #spline_names do
			if spline_names[i] == "" then
				error_message = error_message .. "\nSpline Name can't be empty."
				success = false
			end
		end
	end

	return success, error_message
end

function SplineGroup:enable(unit)
	return
end

function SplineGroup:disable(unit)
	return
end

function SplineGroup:destroy(unit)
	return
end

SplineGroup.component_data = {
	objective_name = {
		ui_type = "text_box",
		value = "None",
		ui_name = "Objective Name"
	},
	spline_names = {
		ui_type = "text_box_array",
		ui_name = "Spline Name",
		values = {}
	},
	extensions = {
		"SplineGroupExtension"
	}
}

return SplineGroup
