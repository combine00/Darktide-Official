local player_difficulty_settings = {
	archetype_wounds = {
		none = {
			1,
			1,
			1,
			1,
			1
		},
		ogryn = {
			5,
			4,
			4,
			3,
			3
		},
		psyker = {
			4,
			3,
			3,
			2,
			2
		},
		veteran = {
			4,
			3,
			3,
			2,
			2
		},
		zealot = {
			4,
			3,
			3,
			2,
			2
		}
	}
}

return settings("PlayerDifficultySettings", player_difficulty_settings)
