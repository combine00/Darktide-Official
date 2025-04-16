local circumstance_vo_ventilation_purge_veteran_male_b = {
	combat_pause_circumstance_ogryn_b_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_veteran_male_b__combat_pause_circumstance_ogryn_b_gas_b_01",
			[2.0] = "loc_veteran_male_b__combat_pause_circumstance_ogryn_b_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 6.050979,
			[2.0] = 4.796896
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_psyker_b_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_veteran_male_b__combat_pause_circumstance_psyker_b_gas_b_01",
			[2.0] = "loc_veteran_male_b__combat_pause_circumstance_psyker_b_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 4.836521,
			[2.0] = 4.982354
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_veteran_b_gas_a = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_veteran_male_b__combat_pause_circumstance_veteran_b_gas_a_01",
			[2.0] = "loc_veteran_male_b__combat_pause_circumstance_veteran_b_gas_a_02"
		},
		sound_events_duration = {
			[1.0] = 2.210167,
			[2.0] = 4.788813
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_veteran_b_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_veteran_male_b__combat_pause_circumstance_veteran_b_gas_b_01",
			[2.0] = "loc_veteran_male_b__combat_pause_circumstance_veteran_b_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 4.627167,
			[2.0] = 4.190333
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_zealot_b_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_veteran_male_b__combat_pause_circumstance_zealot_b_gas_b_01",
			[2.0] = "loc_veteran_male_b__combat_pause_circumstance_zealot_b_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 6.358438,
			[2.0] = 5.199563
		},
		randomize_indexes = {}
	},
	vent_circumstance_start_b = {
		randomize_indexes_n = 0,
		sound_events_n = 4,
		sound_events = {
			"loc_veteran_male_b__vent_circumstance_start_b_01",
			"loc_veteran_male_b__vent_circumstance_start_b_02",
			"loc_veteran_male_b__vent_circumstance_start_b_03",
			"loc_veteran_male_b__vent_circumstance_start_b_04"
		},
		sound_events_duration = {
			2.532563,
			3.821125,
			2.472979,
			5.213875
		},
		sound_event_weights = {
			0.25,
			0.25,
			0.25,
			0.25
		},
		randomize_indexes = {}
	}
}

return settings("circumstance_vo_ventilation_purge_veteran_male_b", circumstance_vo_ventilation_purge_veteran_male_b)
