local mission_vo_lm_scavenge_adamant_female_b = {
	mission_scavenge_daylight = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_female_b__mission_scavenge_daylight_01"
		},
		sound_events_duration = {
			[1.0] = 3.520698
		},
		randomize_indexes = {}
	},
	mission_scavenge_daylight_response_b = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_female_b__region_periferus_01",
			"loc_adamant_female_b__region_periferus_02",
			"loc_adamant_female_b__region_periferus_03"
		},
		sound_events_duration = {
			4.278677,
			3.882677,
			3.411344
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	},
	mission_scavenge_servitors = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_female_b__mission_scavenge_servitors_01"
		},
		sound_events_duration = {
			[1.0] = 3.939385
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_lm_scavenge_adamant_female_b", mission_vo_lm_scavenge_adamant_female_b)
