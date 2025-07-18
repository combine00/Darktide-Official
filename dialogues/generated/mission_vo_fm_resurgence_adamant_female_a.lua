local mission_vo_fm_resurgence_adamant_female_a = {
	luggable_mission_pick_up_fm_resurgence = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_adamant_female_a__luggable_mission_pick_up_01",
			[2.0] = "loc_adamant_female_a__luggable_mission_pick_up_02"
		},
		sound_events_duration = {
			[1.0] = 3.626604,
			[2.0] = 4.677427
		},
		sound_event_weights = {
			[1.0] = 0.5,
			[2.0] = 0.5
		},
		randomize_indexes = {}
	},
	mission_resurgence_boulevard_response = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_female_a__zone_throneside_01",
			"loc_adamant_female_a__zone_throneside_02",
			"loc_adamant_female_a__zone_throneside_03"
		},
		sound_events_duration = {
			2.639917,
			2.068042,
			3.882344
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	},
	mission_resurgence_start_banter_a = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_female_a__mission_resurgence_start_banter_a_01"
		},
		sound_events_duration = {
			[1.0] = 3.912813
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_fm_resurgence_adamant_female_a", mission_vo_fm_resurgence_adamant_female_a)
