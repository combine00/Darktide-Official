local mission_vo_hm_complex_adamant_male_a = {
	mission_complex_start_banter_a = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_male_a__mission_complex_start_banter_a_01"
		},
		sound_events_duration = {
			[1.0] = 4.823198
		},
		randomize_indexes = {}
	},
	mission_complex_start_banter_c = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_male_a__zone_throneside_01",
			"loc_adamant_male_a__zone_throneside_02",
			"loc_adamant_male_a__zone_throneside_03"
		},
		sound_events_duration = {
			3.03001,
			1.749344,
			3.894677
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_hm_complex_adamant_male_a", mission_vo_hm_complex_adamant_male_a)
