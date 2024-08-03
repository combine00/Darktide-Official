local PropAnimation = component("PropAnimation")

function PropAnimation:init(unit)
	local animation_extension = ScriptUnit.fetch_component_extension(unit, "animation_system")

	if animation_extension then
		local animation_variables = self:get_data(unit, "animation_variables")
		local state_machine_override = self:get_data(unit, "state_machine_override")

		animation_extension:setup_from_component(animation_variables, state_machine_override)
	end
end

function PropAnimation:editor_init(unit)
	self:enable(unit)
end

function PropAnimation:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_animation_state_machine(unit) then
		success = false
		error_message = error_message .. "\nMissing unit animation state machine"
	end

	return success, error_message
end

function PropAnimation:enable(unit)
	return
end

function PropAnimation:disable(unit)
	return
end

function PropAnimation:destroy(unit)
	return
end

PropAnimation.component_data = {
	state_machine_override = {
		ui_type = "resource",
		preview = false,
		value = "",
		ui_name = "State Machine Override",
		filter = "state_machine"
	},
	animation_variables = {
		ui_type = "text_box_array",
		size = 0,
		ui_name = "Animation Variables",
		category = "Animation Variables"
	},
	extensions = {
		"PropAnimationExtension"
	}
}

return PropAnimation
