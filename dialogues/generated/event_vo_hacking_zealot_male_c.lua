local event_vo_hacking_zealot_male_c = {
	hacking_auspex_mutter_a = {
		randomize_indexes_n = 0,
		sound_events_n = 5,
		sound_events = {
			"loc_zealot_male_c__hacking_auspex_mutter_a_01",
			"loc_zealot_male_c__hacking_auspex_mutter_a_02",
			"loc_zealot_male_c__hacking_auspex_mutter_a_03",
			"loc_zealot_male_c__hacking_auspex_mutter_a_04",
			"loc_zealot_male_c__hacking_auspex_mutter_a_05"
		},
		sound_events_duration = {
			2.045823,
			2.088156,
			1.969646,
			1.861021,
			3.179552
		},
		randomize_indexes = {}
	},
	response_to_hacking_fix_decode = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_zealot_male_c__response_to_hacking_fix_decode_01",
			[2.0] = "loc_zealot_male_c__response_to_hacking_fix_decode_02"
		},
		sound_events_duration = {
			[1.0] = 1.649063,
			[2.0] = 1.95099
		},
		randomize_indexes = {}
	}
}

return settings("event_vo_hacking_zealot_male_c", event_vo_hacking_zealot_male_c)
