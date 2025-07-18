require("scripts/extension_systems/weapon/actions/action_charge")

local ActionModules = require("scripts/extension_systems/weapon/actions/modules/action_modules")
local ActionOverloadChargeTargetFinder = class("ActionOverloadChargeTargetFinder", "ActionCharge")

function ActionOverloadChargeTargetFinder:init(action_context, action_params, action_settings)
	ActionOverloadChargeTargetFinder.super.init(self, action_context, action_params, action_settings)

	local is_server = self._is_server
	local player_unit = self._player_unit
	local unit_data_extension = action_context.unit_data_extension
	local overload_module_class_name = action_settings.overload_module_class_name
	local target_finder_module_class_name = action_settings.target_finder_module_class_name
	local targeting_component = unit_data_extension:write_component("action_module_targeting")
	self._overload_module = ActionModules[overload_module_class_name]:new(is_server, player_unit, action_settings, self._inventory_slot_component)
	self._targeting_module = ActionModules[target_finder_module_class_name]:new(is_server, self._physics_world, player_unit, targeting_component, action_settings)
end

function ActionOverloadChargeTargetFinder:start(action_settings, t, time_scale, action_start_params)
	ActionOverloadChargeTargetFinder.super.start(self, action_settings, t, time_scale, action_start_params)
	self._overload_module:start(t)
	self._targeting_module:start(t)
end

function ActionOverloadChargeTargetFinder:fixed_update(dt, t, time_in_action, frame)
	ActionOverloadChargeTargetFinder.super.fixed_update(self, dt, t, time_in_action, frame)
	self._overload_module:fixed_update(dt, t)
	self._targeting_module:fixed_update(dt, t)
end

function ActionOverloadChargeTargetFinder:finish(reason, data, t, time_in_action, action_settings, next_action_params)
	ActionOverloadChargeTargetFinder.super.finish(self, reason, data, t, time_in_action, next_action_params)
	self._overload_module:finish(reason, data, t)
	self._targeting_module:finish(reason, data, t)
end

return ActionOverloadChargeTargetFinder
