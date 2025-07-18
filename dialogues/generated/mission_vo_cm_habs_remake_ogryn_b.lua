local mission_vo_cm_habs_remake_ogryn_b = {
	info_extraction_response = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__info_extraction_response_01",
			[2.0] = "loc_ogryn_b__info_extraction_response_02"
		},
		sound_events_duration = {
			[1.0] = 1.119781,
			[2.0] = 1.482417
		},
		randomize_indexes = {}
	},
	level_hab_block_apartments = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__level_hab_block_apartments_01",
			[2.0] = "loc_ogryn_b__level_hab_block_apartments_02"
		},
		sound_events_duration = {
			[1.0] = 4.139104,
			[2.0] = 2.489031
		},
		randomize_indexes = {}
	},
	level_hab_block_apartments_response = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__level_hab_block_apartments_response_01",
			[2.0] = "loc_ogryn_b__level_hab_block_apartments_response_02"
		},
		sound_events_duration = {
			[1.0] = 2.847896,
			[2.0] = 3.700698
		},
		randomize_indexes = {}
	},
	level_hab_block_collapse = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__level_hab_block_collapse_01",
			[2.0] = "loc_ogryn_b__level_hab_block_collapse_02"
		},
		sound_events_duration = {
			[1.0] = 1.599917,
			[2.0] = 1.802625
		},
		randomize_indexes = {}
	},
	level_hab_block_corpse = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__level_hab_block_corpse_01",
			[2.0] = "loc_ogryn_b__level_hab_block_corpse_02"
		},
		sound_events_duration = {
			[1.0] = 2.632427,
			[2.0] = 2.209302
		},
		randomize_indexes = {}
	},
	level_hab_block_security = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_ogryn_b__level_hab_block_security_01",
			[2.0] = "loc_ogryn_b__level_hab_block_security_02"
		},
		sound_events_duration = {
			[1.0] = 4.620125,
			[2.0] = 4.436792
		},
		randomize_indexes = {}
	},
	mission_habs_redux_start_zone_response = {
		randomize_indexes_n = 0,
		sound_events_n = 10,
		sound_events = {
			"loc_ogryn_b__guidance_starting_area_01",
			"loc_ogryn_b__guidance_starting_area_02",
			"loc_ogryn_b__guidance_starting_area_03",
			"loc_ogryn_b__guidance_starting_area_04",
			"loc_ogryn_b__guidance_starting_area_05",
			"loc_ogryn_b__guidance_starting_area_06",
			"loc_ogryn_b__guidance_starting_area_07",
			"loc_ogryn_b__guidance_starting_area_08",
			"loc_ogryn_b__guidance_starting_area_09",
			"loc_ogryn_b__guidance_starting_area_10"
		},
		sound_events_duration = {
			2.409448,
			3.01275,
			1.793698,
			2.30924,
			3.229344,
			5.244063,
			3.821292,
			2.978958,
			3.775854,
			5.305125
		},
		sound_event_weights = {
			0.1,
			0.1,
			0.1,
			0.1,
			0.1,
			0.1,
			0.1,
			0.1,
			0.1,
			0.1
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_cm_habs_remake_ogryn_b", mission_vo_cm_habs_remake_ogryn_b)
