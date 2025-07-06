local mission_vo_lm_cooling_adamant_male_c = {
	info_mission_cooling_vents_response = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_male_c__zone_tank_foundry_01",
			"loc_adamant_male_c__zone_tank_foundry_02",
			"loc_adamant_male_c__zone_tank_foundry_03"
		},
		sound_events_duration = {
			3.808,
			4.590667,
			4.961333
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	},
	mission_cooling_heat = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_male_c__mission_cooling_heat_01"
		},
		sound_events_duration = {
			[1.0] = 4.808521
		},
		randomize_indexes = {}
	},
	mission_cooling_heat_response_two = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_adamant_male_c__region_mechanicus_02",
			[2.0] = "loc_adamant_male_c__region_mechanicus_03"
		},
		sound_events_duration = {
			[1.0] = 4.177969,
			[2.0] = 5.495927
		},
		sound_event_weights = {
			[1.0] = 0.5,
			[2.0] = 0.5
		},
		randomize_indexes = {}
	},
	mission_cooling_leaving = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_male_c__mission_cooling_leaving_01"
		},
		sound_events_duration = {
			[1.0] = 3.371885
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_lm_cooling_adamant_male_c", mission_vo_lm_cooling_adamant_male_c)
