local mission_vo_dm_forge_adamant_male_b = {
	event_demolition_first_corruptor_destroyed_a_enginseer = {
		randomize_indexes_n = 0,
		sound_events_n = 4,
		sound_events = {
			"loc_adamant_male_b__event_demolition_first_corruptor_destroyed_a_01",
			"loc_adamant_male_b__event_demolition_first_corruptor_destroyed_a_02",
			"loc_adamant_male_b__event_demolition_first_corruptor_destroyed_a_03",
			"loc_adamant_male_b__event_demolition_first_corruptor_destroyed_a_04"
		},
		sound_events_duration = {
			1.775104,
			2.103021,
			2.919448,
			1.74224
		},
		sound_event_weights = {
			0.25,
			0.25,
			0.25,
			0.25
		},
		randomize_indexes = {}
	},
	mission_forge_main_entrance_response = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_male_b__region_mechanicus_01",
			"loc_adamant_male_b__region_mechanicus_02",
			"loc_adamant_male_b__region_mechanicus_03"
		},
		sound_events_duration = {
			3.802344,
			4.56775,
			5.080719
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	},
	mission_forge_start_banter_a = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_male_b__mission_forge_start_banter_a_01"
		},
		sound_events_duration = {
			[1.0] = 3.939333
		},
		randomize_indexes = {}
	},
	mission_forge_start_banter_c = {
		randomize_indexes_n = 0,
		sound_events_n = 3,
		sound_events = {
			"loc_adamant_male_b__zone_tank_foundry_01",
			"loc_adamant_male_b__zone_tank_foundry_02",
			"loc_adamant_male_b__zone_tank_foundry_03"
		},
		sound_events_duration = {
			2.649396,
			3.449958,
			4.36201
		},
		sound_event_weights = {
			0.3333333,
			0.3333333,
			0.3333333
		},
		randomize_indexes = {}
	},
	mission_forge_strategic_asset = {
		randomize_indexes_n = 0,
		sound_events_n = 1,
		sound_events = {
			[1.0] = "loc_adamant_male_b__mission_forge_strategic_asset_01"
		},
		sound_events_duration = {
			[1.0] = 4.973875
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_dm_forge_adamant_male_b", mission_vo_dm_forge_adamant_male_b)
