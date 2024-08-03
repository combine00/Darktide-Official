local MissionLuggableSpawner = component("MissionLuggableSpawner")

function MissionLuggableSpawner:init(unit, is_server)
	self._unit = unit
	self._is_server = is_server
end

function MissionLuggableSpawner:editor_init(unit)
	return
end

function MissionLuggableSpawner:editor_validate(unit)
	return true, ""
end

function MissionLuggableSpawner:enable(unit)
	return
end

function MissionLuggableSpawner:disable(unit)
	return
end

function MissionLuggableSpawner:destroy(unit)
	return
end

function MissionLuggableSpawner:spawn_mission_luggable()
	if self._is_server then
		local unit = self._unit
		local mission_target_extension = ScriptUnit.extension(unit, "mission_objective_target_system")
		local objective_name = mission_target_extension:objective_name()
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")
		local synchronizer_unit = mission_objective_system:objective_synchronizer_unit(objective_name)
		local synchronizer_extension = ScriptUnit.extension(synchronizer_unit, "event_synchronizer_system")

		synchronizer_extension:spawn_luggable(unit)
	end
end

function MissionLuggableSpawner:activate_objective_target_on_luggable()
	if self._is_server then
		local unit = self._unit
		local mission_target_extension = ScriptUnit.extension(unit, "mission_objective_target_system")
		local objective_name = mission_target_extension:objective_name()
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")
		local synchronizer_unit = mission_objective_system:objective_synchronizer_unit(objective_name)
		local synchronizer_extension = ScriptUnit.extension(synchronizer_unit, "event_synchronizer_system")

		synchronizer_extension:add_marker_on_luggable(unit)
	end
end

MissionLuggableSpawner.component_data = {
	inputs = {
		spawn_mission_luggable = {
			accessibility = "public",
			type = "event"
		},
		activate_objective_target_on_luggable = {
			accessibility = "public",
			type = "event"
		}
	}
}

return MissionLuggableSpawner
