local mission_vo_cm_raid_adamant_male_b = {
	mission_raid_trapped_a = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_adamant_male_b__mission_raid_trapped_a_01",
			[2.0] = "loc_adamant_male_b__mission_raid_trapped_a_02"
		},
		sound_events_duration = {
			[1.0] = 2.362198,
			[2.0] = 3.710385
		},
		randomize_indexes = {}
	},
	mission_raid_trapped_b = {
		randomize_indexes_n = 0,
		sound_events_n = 2,
		sound_events = {
			[1.0] = "loc_adamant_male_b__mission_raid_trapped_b_01",
			[2.0] = "loc_adamant_male_b__mission_raid_trapped_b_02"
		},
		sound_events_duration = {
			[1.0] = 2.615385,
			[2.0] = 1.795625
		},
		randomize_indexes = {}
	}
}

return settings("mission_vo_cm_raid_adamant_male_b", mission_vo_cm_raid_adamant_male_b)
