local event_vo_scan_adamant_male_c = {
	event_scan_first_target_scanned = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_adamant_male_c__event_scan_first_target_scanned_01",
			[2.0] = "loc_adamant_male_c__event_scan_first_target_scanned_02"
		},
		sound_events_duration = {
			[1.0] = 2.880479,
			[2.0] = 2.982531
		},
		randomize_indexes = {}
	}
}

return settings("event_vo_scan_adamant_male_c", event_vo_scan_adamant_male_c)
