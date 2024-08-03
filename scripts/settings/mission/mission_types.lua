local MissionTypes = {
	raid = {
		index = 1,
		name = "loc_mission_type_01_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_01"
	},
	assassination = {
		index = 2,
		name = "loc_mission_type_02_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_02"
	},
	investigation = {
		index = 3,
		name = "loc_mission_type_03_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_03"
	},
	disruption = {
		index = 4,
		name = "loc_mission_type_04_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_04"
	},
	strike = {
		index = 5,
		name = "loc_mission_type_05_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_05"
	},
	espionage = {
		index = 6,
		name = "loc_mission_type_06_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_06"
	},
	repair = {
		index = 7,
		name = "loc_mission_type_07_name",
		icon = "content/ui/materials/icons/mission_types/mission_type_07"
	},
	undefined = {
		icon = "content/ui/materials/icons/mission_types/mission_type_operations",
		name = "loc_mission_type_undefined_name"
	},
	hub = {
		icon = "content/ui/materials/icons/mission_types/mission_type_operations",
		name = "loc_mission_type_undefined_name"
	}
}

return settings("MissionTypes", MissionTypes)
