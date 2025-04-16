local DangerSettings = {
	{
		resistance = 2,
		name = "sedition",
		display_name = "loc_mission_board_danger_lowest",
		is_auric = false,
		challenge = 1,
		difficulty = 1,
		unlocks_at = 1,
		color = {
			255,
			169,
			211,
			158
		}
	},
	{
		resistance = 2,
		name = "uprising",
		display_name = "loc_mission_board_danger_low",
		is_auric = false,
		challenge = 2,
		difficulty = 2,
		unlocks_at = 1,
		color = {
			255,
			169,
			211,
			158
		}
	},
	{
		resistance = 3,
		name = "malice",
		display_name = "loc_mission_board_danger_medium",
		is_auric = false,
		challenge = 3,
		difficulty = 3,
		unlocks_at = 3,
		color = {
			255,
			228,
			189,
			81
		}
	},
	{
		resistance = 4,
		name = "heresy",
		display_name = "loc_mission_board_danger_high",
		is_auric = false,
		challenge = 4,
		difficulty = 4,
		unlocks_at = 9,
		color = {
			255,
			228,
			189,
			81
		}
	},
	{
		resistance = 4,
		name = "damnation",
		display_name = "loc_mission_board_danger_highest",
		is_auric = false,
		challenge = 5,
		difficulty = 5,
		unlocks_at = 15,
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
