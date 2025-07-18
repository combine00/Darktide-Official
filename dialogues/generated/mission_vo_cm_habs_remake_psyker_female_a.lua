local mission_vo_cm_habs_remake_psyker_female_a = {
	info_extraction_response = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__info_extraction_response_01",
			[2.0] = "loc_psyker_female_a__info_extraction_response_02"
		},
		sound_events_duration = {
			[1.0] = 2.528833,
			[2.0] = 2.524292
		},
		randomize_indexes = {}
	},
	level_hab_block_apartments = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__level_hab_block_apartments_01",
			[2.0] = "loc_psyker_female_a__level_hab_block_apartments_02"
		},
		sound_events_duration = {
			[1.0] = 3.771833,
			[2.0] = 3.58725
		},
		randomize_indexes = {}
	},
	level_hab_block_apartments_response = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__level_hab_block_apartments_response_01",
			[2.0] = "loc_psyker_female_a__level_hab_block_apartments_response_02"
		},
		sound_events_duration = {
			[1.0] = 1.656458,
			[2.0] = 2.374146
		},
		randomize_indexes = {}
	},
	level_hab_block_collapse = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__level_hab_block_collapse_01",
			[2.0] = "loc_psyker_female_a__level_hab_block_collapse_02"
		},
		sound_events_duration = {
			[1.0] = 3.639417,
			[2.0] = 1.531167
		},
		randomize_indexes = {}
	},
	level_hab_block_corpse = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__level_hab_block_corpse_01",
			[2.0] = "loc_psyker_female_a__level_hab_block_corpse_02"
		},
		sound_events_duration = {
			[1.0] = 3.596417,
			[2.0] = 3.474292
		},
		randomize_indexes = {}
	},
	level_hab_block_security = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_psyker_female_a__level_hab_block_security_01",
			[2.0] = "loc_psyker_female_a__level_hab_block_security_02"
		},
		sound_events_duration = {
			[1.0] = 2.198479,
			[2.0] = 5.984479
		},
		randomize_indexes = {}
	},
	mission_habs_redux_start_zone_response = {
		randomize_indexes_n = 0,
		sound_events_n = 10,
		sound_events = {
			"loc_psyker_female_a__guidance_starting_area_01",
			"loc_psyker_female_a__guidance_starting_area_02",
			"loc_psyker_female_a__guidance_starting_area_03",
			"loc_psyker_female_a__guidance_starting_area_04",
			"loc_psyker_female_a__guidance_starting_area_05",
			"loc_psyker_female_a__guidance_starting_area_06",
			"loc_psyker_female_a__guidance_starting_area_07",
			"loc_psyker_female_a__guidance_starting_area_08",
			"loc_psyker_female_a__guidance_starting_area_09",
			"loc_psyker_female_a__guidance_starting_area_10"
		},
		sound_events_duration = {
			2.839167,
			3.078688,
			2.140896,
			3.877604,
			4.417042,
			2.364021,
			4.030083,
			3.321792,
			3.639792,
			3.531688
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

return settings("mission_vo_cm_habs_remake_psyker_female_a", mission_vo_cm_habs_remake_psyker_female_a)
