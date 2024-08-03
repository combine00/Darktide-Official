local MissionObjectiveZoneSynchronizer = component("MissionObjectiveZoneSynchronizer")

function MissionObjectiveZoneSynchronizer:init(unit)
	local mission_objective_zone_synchronizer_extension = ScriptUnit.fetch_component_extension(unit, "event_synchronizer_system")

	if mission_objective_zone_synchronizer_extension then
		local num_zones_in_mission_objective = self:get_data(unit, "num_zones_in_mission_objective")
		local objective_name = self:get_data(unit, "objective_name")
		local automatic_start = self:get_data(unit, "automatic_start")

		mission_objective_zone_synchronizer_extension:setup_from_component(num_zones_in_mission_objective, objective_name, automatic_start)
	end
end

function MissionObjectiveZoneSynchronizer:editor_init(unit)
	return
end

function MissionObjectiveZoneSynchronizer:editor_validate(unit)
	return true, ""
end

function MissionObjectiveZoneSynchronizer:start_mission_objective_zone_event()
	self._mission_objective_zone_synchronizer_extension:start_event()
end

function MissionObjectiveZoneSynchronizer:enable(unit)
	return
end

function MissionObjectiveZoneSynchronizer:disable(unit)
	return
end

function MissionObjectiveZoneSynchronizer:destroy(unit)
	return
end

MissionObjectiveZoneSynchronizer.component_data = {
	num_zones_in_mission_objective = {
		ui_type = "number",
		value = 1,
		ui_name = "Number of zones in mission objective"
	},
	objective_name = {
		ui_type = "text_box",
		value = "default",
		ui_name = "Objective name"
	},
	automatic_start = {
		ui_type = "check_box",
		value = false,
		ui_name = "Auto start on mission start"
	},
	inputs = {
		start_mission_objective_zone_event = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"MissionObjectiveZoneSynchronizerExtension"
	}
}

return MissionObjectiveZoneSynchronizer
