local SideMissionPickupSynchronizer = component("SideMissionPickupSynchronizer")

function SideMissionPickupSynchronizer:init(unit)
	local side_mission_synchronizer_extension = ScriptUnit.fetch_component_extension(unit, "event_synchronizer_system")

	if side_mission_synchronizer_extension then
		local auto_start_on_level_spawned = self:get_data(unit, "automatic_start")

		side_mission_synchronizer_extension:setup_from_component(auto_start_on_level_spawned)
	end
end

function SideMissionPickupSynchronizer:editor_init(unit)
	return
end

function SideMissionPickupSynchronizer:editor_validate(unit)
	return true, ""
end

function SideMissionPickupSynchronizer:enable(unit)
	return
end

function SideMissionPickupSynchronizer:disable(unit)
	return
end

function SideMissionPickupSynchronizer:destroy(unit)
	return
end

SideMissionPickupSynchronizer.component_data = {
	automatic_start = {
		ui_type = "check_box",
		value = false,
		ui_name = "Auto Start On Level Spawned"
	},
	extensions = {
		"SideMissionPickupSynchronizerExtension"
	}
}

return SideMissionPickupSynchronizer
