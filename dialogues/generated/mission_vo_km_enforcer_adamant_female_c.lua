local mission_vo_km_enforcer_adamant_female_c = {
	mission_enforcer_start_banter_a = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_female_c__mission_enforcer_start_banter_a_01"
		},
		sound_events_duration = {
			[1.0] = 3.41374
		},
		randomize_indexes = {}
	},
	mission_enforcer_start_banter_c = {
		randomize_indexes_n = 0,
		sound_events_n = 6,
		sound_events = {
			"loc_adamant_female_c__region_habculum_01",
			"loc_adamant_female_c__region_habculum_02",
			"loc_adamant_female_c__region_habculum_03",
			"loc_adamant_female_c__zone_watertown_01",
			"loc_adamant_female_c__zone_watertown_02",
			"loc_adamant_female_c__zone_watertown_03"
		},
		sound_events_duration = {
			4.67876,
			3.265594,
			3.567938,
			2.757531,
			2.499698,
			3.361615
		},
		sound_event_weights = {
			0.1666667,
			0.1666667,
			0.1666667,
			0.1666667,
			0.1666667,
			0.1666667
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_km_enforcer_adamant_female_c", mission_vo_km_enforcer_adamant_female_c)
