local circumstance_vo_toxic_gas_pilot_a = {
	toxic_circumstance_start_a = {
		randomize_indexes_n = 0,
		sound_events_n = 4,
		sound_events = {
			"loc_pilot_a__toxic_circumstance_start_a_01",
			"loc_pilot_a__toxic_circumstance_start_a_02",
			"loc_pilot_a__toxic_circumstance_start_a_03",
			"loc_pilot_a__toxic_circumstance_start_a_04"
		},
		sound_events_duration = {
			3.45678,
			3.45678,
			3.45678,
			3.45678
		},
		randomize_indexes = {}
	},
	toxic_circumstance_start_b = {
		randomize_indexes_n = 0,
		sound_events_n = 4,
		sound_events = {
			"loc_pilot_a__toxic_circumstance_start_b_01",
			"loc_pilot_a__toxic_circumstance_start_b_02",
			"loc_pilot_a__toxic_circumstance_start_b_03",
			"loc_pilot_a__toxic_circumstance_start_b_04"
		},
		sound_events_duration = {
			3.45678,
			3.45678,
			3.45678,
			3.45678
		},
		randomize_indexes = {}
	}
}

return settings("circumstance_vo_toxic_gas_pilot_a", circumstance_vo_toxic_gas_pilot_a)
