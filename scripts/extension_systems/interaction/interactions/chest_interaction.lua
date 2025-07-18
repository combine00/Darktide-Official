require("scripts/extension_systems/interaction/interactions/base_interaction")

local ChestInteraction = class("ChestInteraction", "BaseInteraction")

function ChestInteraction:stop(world, interactor_unit, unit_data_component, t, result, interactor_is_server)
	if interactor_is_server and result == "success" then
		local target_unit = unit_data_component.target_unit
		local chest_extension = ScriptUnit.extension(target_unit, "chest_system")

		chest_extension:open(interactor_unit)
	end
end

function ChestInteraction:interactor_condition_func(interactor_unit, interactee_unit)
	local chest_extension = ScriptUnit.extension(interactee_unit, "chest_system")
	local chest_interactable = chest_extension:is_interactable()

	return chest_interactable and not self:_interactor_disabled(interactor_unit)
end

function ChestInteraction:interactee_show_marker_func(interactor_unit, interactee_unit)
	return ChestInteraction:interactor_condition_func(interactor_unit, interactee_unit)
end

return ChestInteraction
