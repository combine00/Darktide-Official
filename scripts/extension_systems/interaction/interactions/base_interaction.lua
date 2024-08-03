local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local PlayerUnitVisualLoadout = require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
local BaseInteraction = class("BaseInteraction")

function BaseInteraction:init(template)
	self._template = template
end

function BaseInteraction:start(world, interactor_unit, unit_data_component, t, interactor_is_server)
	return
end

function BaseInteraction:stop(world, interactor_unit, unit_data_component, t, result, interactor_is_server)
	return
end

function BaseInteraction:interactor_condition_func(interactor_unit, interactee_unit)
	return not self:_interactor_disabled(interactor_unit)
end

function BaseInteraction:interactee_condition_func(interactee_unit)
	return true
end

function BaseInteraction:interactee_show_marker_func(interactor_unit, interactee_unit)
	return not self:_interactor_disabled(interactor_unit)
end

function BaseInteraction:hud_description(interactor_unit, interactee_unit, target_node)
	local interactee_extension = ScriptUnit.extension(interactee_unit, "interactee_system")

	return interactee_extension:description()
end

function BaseInteraction:hud_block_text(interactor_unit, interactee_unit, target_node)
	local interactee_extension = ScriptUnit.extension(interactee_unit, "interactee_system")

	return interactee_extension:block_text(interactor_unit)
end

function BaseInteraction:type()
	return self._template.type
end

function BaseInteraction:duration()
	return self._template.duration
end

function BaseInteraction:interaction_input()
	return self._template.interaction_input or "interact_pressed"
end

function BaseInteraction:interaction_priority()
	return self._template.interaction_priority or 1
end

function BaseInteraction:ui_interaction_type()
	return self._template.ui_interaction_type
end

function BaseInteraction:interaction_icon()
	return self._template.interaction_icon
end

function BaseInteraction:description()
	return self._template.description
end

function BaseInteraction:action_text()
	return self._template.action_text
end

function BaseInteraction:ui_view_name()
	return self._template.ui_view_name
end

function BaseInteraction:only_once()
	return self._template.only_once
end

function BaseInteraction:_interactor_disabled(interactor_unit)
	local unit_data_extension = ScriptUnit.extension(interactor_unit, "unit_data_system")
	local character_state_component = unit_data_extension:read_component("character_state")

	return PlayerUnitStatus.is_disabled(character_state_component)
end

function BaseInteraction:_unequip_slot(t, interactor_unit, slot_name)
	local unit_data_extension = ScriptUnit.extension(interactor_unit, "unit_data_system")
	local inventory_component = unit_data_extension:read_component("inventory")
	local visual_loadout_extension = ScriptUnit.extension(interactor_unit, "visual_loadout_system")

	if PlayerUnitVisualLoadout.slot_equipped(inventory_component, visual_loadout_extension, slot_name) then
		PlayerUnitVisualLoadout.unequip_item_from_slot(interactor_unit, slot_name, t)
	end
end

return BaseInteraction
