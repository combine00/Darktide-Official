local ScriptableScenarioDirectionalUnitExtension = class("ScriptableScenarioDirectionalUnitExtension")
ScriptableScenarioDirectionalUnitExtension.UPDATE_DISABLED_BY_DEFAULT = true

function ScriptableScenarioDirectionalUnitExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._unit = unit
	self._spawn_group = Unit.get_data(unit, "attached_unit_settings.spawn_group")
	self._identifier = Unit.get_data(unit, "directional_unit_identifier")
	local attached_unit = Unit.flow_variable(self._unit, "attached_unit")
	self._attached_unit = Unit.alive(attached_unit) and attached_unit or nil
end

function ScriptableScenarioDirectionalUnitExtension:unit()
	return self._unit
end

function ScriptableScenarioDirectionalUnitExtension:spawn_attached_unit()
	Unit.flow_event(self._unit, "spawn_attached_unit")

	self._attached_unit = Unit.flow_variable(self._unit, "attached_unit")

	return self._attached_unit
end

function ScriptableScenarioDirectionalUnitExtension:unspawn_attached_unit()
	Unit.flow_event(self._unit, "unspawn_attached_unit")

	self._attached_unit = nil
end

function ScriptableScenarioDirectionalUnitExtension:attached_unit()
	return self._attached_unit
end

function ScriptableScenarioDirectionalUnitExtension:spawn_group()
	return self._spawn_group
end

function ScriptableScenarioDirectionalUnitExtension:identifier()
	return self._identifier
end

function ScriptableScenarioDirectionalUnitExtension:update(unit, dt, t)
	return
end

function ScriptableScenarioDirectionalUnitExtension:destroy()
	self._unit = nil
end

return ScriptableScenarioDirectionalUnitExtension
