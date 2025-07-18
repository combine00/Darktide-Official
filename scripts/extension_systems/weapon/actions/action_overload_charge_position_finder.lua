require("scripts/extension_systems/weapon/actions/action_charge")

local ActionModules = require("scripts/extension_systems/weapon/actions/modules/action_modules")
local ActionOverloadChargePositionFinder = class("ActionOverloadChargePositionFinder", "ActionCharge")

function ActionOverloadChargePositionFinder:init(action_context, action_params, action_settings)
	ActionOverloadChargePositionFinder.super.init(self, action_context, action_params, action_settings)

	local is_server = self._is_server
	local player_unit = self._player_unit
	local unit_data_extension = action_context.unit_data_extension
	local overload_module_class_name = action_settings.overload_module_class_name
	local position_finder_module_class_name = action_settings.position_finder_module_class_name
	local position_component = unit_data_extension:write_component("action_module_position_finder")
	self._overload_module = ActionModules[overload_module_class_name]:new(is_server, player_unit, action_settings, self._inventory_slot_component)
	self._position_finder_module = ActionModules[position_finder_module_class_name]:new(is_server, self._physics_world, player_unit, position_component, action_settings)
end

function ActionOverloadChargePositionFinder:start(action_settings, t, time_scale, action_start_params)
	ActionOverloadChargePositionFinder.super.start(self, action_settings, t, time_scale, action_start_params)
	self._position_finder_module:start(t)
	self._overload_module:start(t)
end

function ActionOverloadChargePositionFinder:fixed_update(dt, t, time_in_action, frame)
	ActionOverloadChargePositionFinder.super.fixed_update(self, dt, t, time_in_action, frame)
	self._position_finder_module:fixed_update(dt, t)
	self._overload_module:fixed_update(dt, t)
end

function ActionOverloadChargePositionFinder:finish(reason, data, t, time_in_action)
	ActionOverloadChargePositionFinder.super.finish(self, reason, data, t, time_in_action)
	self._position_finder_module:finish(reason, data, t)
	self._overload_module:finish(reason, data, t)
end

return ActionOverloadChargePositionFinder
