local ColorUtilities = require("scripts/utilities/ui/colors")
local HudElementPlayerAbilitySettings = require("scripts/ui/hud/elements/player_ability/hud_element_player_ability_settings")
local InputUtils = require("scripts/managers/input/input_utils")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local HudElementPlayerSlotItemAbility = class("HudElementPlayerSlotItemAbility", "HudElementBase")

function HudElementPlayerSlotItemAbility:init(parent, draw_layer, start_scale, data)
	local definition_path = data.definition_path
	local definitions = dofile(definition_path)

	HudElementPlayerSlotItemAbility.super.init(self, parent, draw_layer, start_scale, definitions)

	self._data = data
	self._slot_id = data.slot_id
	local slot_configuration = PlayerCharacterConstants.slot_configuration
	local slot_config = slot_configuration[self._slot_id]
	local wield_inputs = slot_config.wield_inputs
	self._wield_input = wield_inputs and wield_inputs[1]

	self:_set_progress(1)
	self:set_charges_amount()
	self:set_icon(data.icon)

	local on_cooldown = false
	local uses_charges = false
	local has_charges_left = true

	self:_set_widget_state_colors(on_cooldown, uses_charges, has_charges_left)
	self:_update_input()
	self:_register_events()
	self:_play_sound(UISoundEvents.ability_off_cooldown)
end

function HudElementPlayerSlotItemAbility:destroy(ui_renderer)
	self:_unregister_events()
	HudElementPlayerSlotItemAbility.super.destroy(self, ui_renderer)
end

function HudElementPlayerSlotItemAbility:_update_input()
	local wield_input = self._wield_input
	local service_type = "Ingame"
	local alias_name = wield_input
	local alias_array_index = 1
	local color_tint_text = true
	local input_key = InputUtils.input_text_for_current_input_device(service_type, alias_name, color_tint_text)

	self:set_input_text(tostring(input_key))
end

function HudElementPlayerSlotItemAbility:set_charges_amount(amount)
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.ability
	local content = widget.content
	content.text = amount and tostring(amount) or nil
	widget.dirty = true
end

function HudElementPlayerSlotItemAbility:_set_widget_state_colors(on_cooldown, uses_charges, has_charges_left)
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.ability
	local source_colors = nil

	if on_cooldown then
		if uses_charges then
			if has_charges_left then
				source_colors = HudElementPlayerAbilitySettings.has_charges_cooldown_colors
			else
				source_colors = HudElementPlayerAbilitySettings.out_of_charges_cooldown_colors
			end
		else
			source_colors = HudElementPlayerAbilitySettings.cooldown_colors
		end
	elseif not uses_charges or uses_charges and has_charges_left then
		source_colors = HudElementPlayerAbilitySettings.active_colors
	else
		source_colors = HudElementPlayerAbilitySettings.inactive
	end

	local style = widget.style

	for pass_id, pass_style in pairs(style) do
		local source_color = source_colors[pass_id]

		if source_color then
			ColorUtilities.color_copy(source_color, pass_style.color or pass_style.text_color)
		end
	end
end

function HudElementPlayerSlotItemAbility:set_input_text(text)
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.ability
	widget.content.input_text = text
	widget.dirty = true
end

function HudElementPlayerSlotItemAbility:set_icon(icon)
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.ability
	local content = widget.content
	content.icon = icon
	widget.dirty = true
end

function HudElementPlayerSlotItemAbility:_set_progress(progress)
	self._ability_progress = progress
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.ability
	local content = widget.content
	content.duration_progress = progress
	widget.dirty = true
end

function HudElementPlayerSlotItemAbility:_register_events()
	local event_manager = Managers.event
	local events = HudElementPlayerAbilitySettings.events

	for i = 1, #events do
		local event = events[i]

		event_manager:register(self, event[1], event[2])
	end
end

function HudElementPlayerSlotItemAbility:_unregister_events()
	local event_manager = Managers.event
	local events = HudElementPlayerAbilitySettings.events

	for i = 1, #events do
		local event = events[i]

		event_manager:unregister(self, event[1])
	end
end

function HudElementPlayerSlotItemAbility:event_on_input_changed()
	self:_update_input()
end

return HudElementPlayerSlotItemAbility
