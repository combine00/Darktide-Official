local circumstance_vo_ventilation_purge_ogryn_a = {
	combat_pause_circumstance_ogryn_a_gas_a = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_a__combat_pause_circumstance_ogryn_a_gas_a_01",
			[2.0] = "loc_ogryn_a__combat_pause_circumstance_ogryn_a_gas_a_02"
		},
		sound_events_duration = {
			[1.0] = 6.048115,
			[2.0] = 5.846333
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_ogryn_a_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_a__combat_pause_circumstance_ogryn_a_gas_b_01",
			[2.0] = "loc_ogryn_a__combat_pause_circumstance_ogryn_a_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 3.633094,
			[2.0] = 4.880635
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_psyker_a_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_a__combat_pause_circumstance_psyker_a_gas_b_01",
			[2.0] = "loc_ogryn_a__combat_pause_circumstance_psyker_a_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 6.386948,
			[2.0] = 4.916771
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_veteran_a_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_a__combat_pause_circumstance_veteran_a_gas_b_01",
			[2.0] = "loc_ogryn_a__combat_pause_circumstance_veteran_a_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 5.350865,
			[2.0] = 5.112552
		},
		randomize_indexes = {}
	},
	combat_pause_circumstance_zealot_a_gas_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_a__combat_pause_circumstance_zealot_a_gas_b_01",
			[2.0] = "loc_ogryn_a__combat_pause_circumstance_zealot_a_gas_b_02"
		},
		sound_events_duration = {
			[1.0] = 3.877135,
			[2.0] = 5.715906
		},
		randomize_indexes = {}
	},
	vent_circumstance_start_b = {
		randomize_indexes_n = 0,
		sound_events_n = 4,
		sound_events = {
			"loc_ogryn_a__vent_circumstance_start_b_01",
			"loc_ogryn_a__vent_circumstance_start_b_02",
			"loc_ogryn_a__vent_circumstance_start_b_03",
			"loc_ogryn_a__vent_circumstance_start_b_04"
		},
		sound_events_duration = {
			3.702604,
			3.174625,
			3.916052,
			3.809708
		},
		randomize_indexes = {}
	}
}

return settings("circumstance_vo_ventilation_purge_ogryn_a", circumstance_vo_ventilation_purge_ogryn_a)
