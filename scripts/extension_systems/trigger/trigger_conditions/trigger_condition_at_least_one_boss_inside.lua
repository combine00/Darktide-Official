require("scripts/extension_systems/trigger/trigger_conditions/trigger_condition_base")

local TriggerConditionOneBossInside = class("TriggerConditionOneBossInside", "TriggerConditionBase")

function TriggerConditionOneBossInside:on_volume_enter(entering_unit, dt, t)
	if self:_is_boss(entering_unit) then
		return self:_register_unit(entering_unit)
	end

	return false
end

function TriggerConditionOneBossInside:on_volume_exit(exiting_unit)
	return self:_unregister_unit(exiting_unit)
end

function TriggerConditionOneBossInside:filter_passed(filter_unit, volume_id)
	local filter_passed = table.size(self._registered_units) ~= 0

	return filter_passed
end

function TriggerConditionOneBossInside:_is_boss(unit)
	local unit_data_extension = ScriptUnit.has_extension(unit, "unit_data_system")

	if not unit_data_extension then
		return false
	end

	local breed = unit_data_extension:breed()

	if breed.is_boss then
		return true
	end

	return false
end

return TriggerConditionOneBossInside
