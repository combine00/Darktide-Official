local MissionObjectiveZoneScannable = component("MissionObjectiveZoneScannable")

function MissionObjectiveZoneScannable:init(unit)
	return
end

function MissionObjectiveZoneScannable:editor_validate(unit)
	return true, ""
end

function MissionObjectiveZoneScannable:enable(unit)
	return
end

function MissionObjectiveZoneScannable:disable(unit)
	return
end

function MissionObjectiveZoneScannable:destroy(unit)
	return
end

MissionObjectiveZoneScannable.component_data = {
	extensions = {
		"MissionObjectiveZoneScannableExtension"
	}
}

return MissionObjectiveZoneScannable
