require("scripts/extension_systems/weapon/actions/action_ability_base")

local ActionDirectionalDashAim = class("ActionDirectionalDashAim", "ActionAbilityBase")

function ActionDirectionalDashAim:init(action_context, ...)
	ActionDirectionalDashAim.super.init(self, action_context, ...)

	local unit_data_extension = action_context.unit_data_extension
	self._lunge_character_state_component = unit_data_extension:write_component("lunge_character_state")
end

function ActionDirectionalDashAim:start(action_settings, t, time_scale, action_start_params)
	ActionDirectionalDashAim.super.start(self, action_settings, t, time_scale, action_start_params)

	self._lunge_character_state_component.is_aiming = true
end

function ActionDirectionalDashAim:finish(reason, data, t, time_in_action)
	ActionDirectionalDashAim.super.finish(self, reason, data, t, time_in_action)

	self._lunge_character_state_component.is_aiming = false
end

return ActionDirectionalDashAim
