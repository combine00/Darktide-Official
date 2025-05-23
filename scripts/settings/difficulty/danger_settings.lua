local DangerSettings = {
	{
		is_auric = false,
		name = "sedition",
		display_name = "loc_mission_board_danger_lowest",
		icon = "content/ui/materials/icons/difficulty/difficulty_skull_uprising",
		resistance = 2,
		unlocks_at = 1,
		challenge = 1,
		difficulty = 1,
		color = {
			255,
			169,
			211,
			158
		}
	},
	{
		is_auric = false,
		name = "uprising",
		display_name = "loc_mission_board_danger_low",
		icon = "content/ui/materials/icons/difficulty/difficulty_skull_malice",
		resistance = 2,
		unlocks_at = 1,
		challenge = 2,
		difficulty = 2,
		color = {
			255,
			169,
			211,
			158
		}
	},
	{
		is_auric = false,
		name = "malice",
		display_name = "loc_mission_board_danger_medium",
		icon = "content/ui/materials/icons/difficulty/difficulty_skull_heresy",
		resistance = 3,
		unlocks_at = 3,
		challenge = 3,
		difficulty = 3,
		color = {
			255,
			228,
			189,
			81
		}
	},
	{
		is_auric = false,
		name = "heresy",
		display_name = "loc_mission_board_danger_high",
		icon = "content/ui/materials/icons/difficulty/difficulty_skull_damnation",
		resistance = 4,
		unlocks_at = 9,
		challenge = 4,
		difficulty = 4,
		color = {
			255,
			228,
			189,
			81
		}
	},
	{
		is_auric = false,
		name = "damnation",
		display_name = "loc_mission_board_danger_highest",
		icon = "content/ui/materials/icons/difficulty/difficulty_skull_auric",
		resistance = 4,
		unlocks_at = 15,
		challenge = 5,
		difficulty = 5,
		color = {
			255,
			233,
			84,
			84
		}
	}
}

for i, data in ipairs(DangerSettings) do
	data.index = i
end

return settings("DangerSettings", DangerSettings)
