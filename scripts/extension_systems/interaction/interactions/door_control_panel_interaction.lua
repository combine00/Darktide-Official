require("scripts/extension_systems/interaction/interactions/base_interaction")

local DoorControlPanelInteraction = class("DoorControlPanelInteraction", "BaseInteraction")

function DoorControlPanelInteraction:stop(world, interactor_unit, unit_data_component, t, result, interactor_is_server)
	if interactor_is_server and result == "success" then
		local target_unit = unit_data_component.target_unit
		local door_control_panel_extension = ScriptUnit.extension(target_unit, "door_control_panel_system")

		door_control_panel_extension:toggle_door_state(interactor_unit)
	end
end

function DoorControlPanelInteraction:interactor_condition_func(interactor_unit, interactee_unit)
	local door_control_panel_extension = ScriptUnit.extension(interactee_unit, "door_control_panel_system")
	local door_control_panel_interactable = door_control_panel_extension:is_active() and not door_control_panel_extension:is_on_hold()

	return door_control_panel_interactable and not self:_interactor_disabled(interactor_unit)
end

function DoorControlPanelInteraction:hud_block_text(interactor_unit, interactee_unit)
	local door_control_panel_extension = ScriptUnit.extension(interactee_unit, "door_control_panel_system")

	if door_control_panel_extension:is_on_hold() then
		return "loc_door_interlude"
	end

	return nil
end

return DoorControlPanelInteraction
