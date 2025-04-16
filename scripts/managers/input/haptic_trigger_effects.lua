local HapticTrigger = require("scripts/managers/input/haptic_trigger")
local HapticTriggerSettings = require("scripts/settings/equipment/haptic_trigger_settings")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local TRUE = 1
local FALSE = 0
local HapticTriggerEffects = class("HapticTriggerEffects")
local SUPPRESS_REASONS = {
	"character_disabled",
	"menu",
	menu = 2,
	character_disabled = 1
}

function HapticTriggerEffects:init()
	self._haptics_suppressed = nil
	self._haptics_enabled = nil
	local suppression_reasons = {
		[SUPPRESS_REASONS.character_disabled] = 0,
		[SUPPRESS_REASONS.menu] = 0
	}
	self._suppression_reasons = suppression_reasons
	self._left_trigger = HapticTrigger:new("left")
	self._right_trigger = HapticTrigger:new("right")
end

function HapticTriggerEffects:_disable_haptics()
	self._left_trigger:disable_haptics()
	self._right_trigger:disable_haptics()
end

function HapticTriggerEffects:_enable_haptics()
	self._left_trigger:enable_haptics()
	self._right_trigger:enable_haptics()
end

function HapticTriggerEffects:_update_menu_state()
	local wants_suppression = Managers.ui:has_active_view()
	self._suppression_reasons[SUPPRESS_REASONS.menu] = wants_suppression and TRUE or FALSE
end

function HapticTriggerEffects:update(dt, t)
	if not self._haptics_enabled then
		return
	end

	local was_suppressed = self._haptics_suppressed

	self:_update_menu_state()

	local suppression_reasons = self._suppression_reasons
	local wants_suppression = bit.bor(unpack(suppression_reasons)) == 1
	local start_suppression = wants_suppression and not was_suppressed
	local stop_suppression = not wants_suppression and was_suppressed

	if start_suppression then
		self._left_trigger:suppress_haptics(true)
		self._right_trigger:suppress_haptics(true)
	elseif stop_suppression then
		self._left_trigger:suppress_haptics(false)
		self._right_trigger:suppress_haptics(false)
	end

	self._haptics_suppressed = wants_suppression

	self._left_trigger:update(dt, t)
	self._right_trigger:update(dt, t)
end

function HapticTriggerEffects:trigger_vibration(frequency)
	self._left_trigger:trigger_vibration(frequency)
	self._right_trigger:trigger_vibration(frequency)
end

function HapticTriggerEffects:stop_vibration()
	self._left_trigger:stop_vibration()
	self._right_trigger:stop_vibration()
end

local function _haptic_trigger_template(action_settings_or_weapon_template, condition_func_params)
	local haptic_trigger_template = action_settings_or_weapon_template and action_settings_or_weapon_template.haptic_trigger_template
	local haptic_trigger_template_condition_func = action_settings_or_weapon_template and action_settings_or_weapon_template.haptic_trigger_template_condition_func

	if haptic_trigger_template_condition_func and condition_func_params then
		haptic_trigger_template = haptic_trigger_template_condition_func(condition_func_params)
	end

	return haptic_trigger_template
end

function HapticTriggerEffects:set_haptic_trigger_template(action_settings, weapon_template, condition_func_params)
	local haptic_trigger_template = _haptic_trigger_template(action_settings, condition_func_params) or _haptic_trigger_template(weapon_template, condition_func_params)
	self._haptic_trigger_template = haptic_trigger_template

	self._left_trigger:set_haptic_trigger_template(haptic_trigger_template)
	self._right_trigger:set_haptic_trigger_template(haptic_trigger_template)
end

function HapticTriggerEffects:unwield()
	self._left_trigger:unwield()
	self._right_trigger:unwield()
end

function HapticTriggerEffects:on_character_state_enter(character_state_component)
	local is_disabled = PlayerUnitStatus.is_disabled(character_state_component)
	self._suppression_reasons[SUPPRESS_REASONS.character_disabled] = is_disabled and TRUE or FALSE
end

function HapticTriggerEffects:on_character_state_exit()
	self._suppression_reasons[SUPPRESS_REASONS.character_disabled] = FALSE
end

function HapticTriggerEffects:set_ammo_count_percentage(ammo_percentage)
	self._left_trigger:set_ammo_count_percentage(ammo_percentage)
	self._right_trigger:set_ammo_count_percentage(ammo_percentage)
end

function HapticTriggerEffects:set_haptic_trigger_effects_enabled(enabled)
	self._haptics_enabled = enabled

	if not enabled then
		self._left_trigger:disable_haptics()
		self._right_trigger:disable_haptics()
	else
		self._left_trigger:enable_haptics()
		self._right_trigger:enable_haptics()
	end
end

function HapticTriggerEffects:set_haptic_trigger_melee_resistance_strength(value)
	self._left_trigger:set_haptic_trigger_melee_resistance_strength(value)
	self._right_trigger:set_haptic_trigger_melee_resistance_strength(value)
end

function HapticTriggerEffects:set_haptic_trigger_ranged_resistance_strength(value)
	self._left_trigger:set_haptic_trigger_ranged_resistance_strength(value)
	self._right_trigger:set_haptic_trigger_ranged_resistance_strength(value)
end

function HapticTriggerEffects:set_haptic_trigger_melee_vibration_strength(value)
	self._left_trigger:set_haptic_trigger_melee_vibration_strength(value)
	self._right_trigger:set_haptic_trigger_melee_vibration_strength(value)
end

function HapticTriggerEffects:set_haptic_trigger_ranged_vibration_strength(value)
	self._left_trigger:set_haptic_trigger_ranged_vibration_strength(value)
	self._right_trigger:set_haptic_trigger_ranged_vibration_strength(value)
end

return HapticTriggerEffects
