local volume_data = {
	{
		height = 2,
		type = "content/volume_types/player_mover_blocker",
		name = "volume_blocker_pipemain",
		alt_max_vector = {
			19.32338523864746,
			-235.98648071289062,
			4.705709457397461
		},
		alt_min_vector = {
			19.426258087158203,
			-235.95065307617188,
			2.7086780071258545
		},
		bottom_points = {
			{
				20.061798095703125,
				-234.67335510253906,
				2.764326810836792
			},
			{
				18.151187896728516,
				-236.5884246826172,
				2.631556272506714
			},
			{
				18.79071807861328,
				-237.2279510498047,
				2.653029203414917
			},
			{
				20.70132827758789,
				-235.31288146972656,
				2.785799741744995
			}
		},
		color = {
			255,
			255,
			125,
			0
		},
		up_vector = {
			-0.051436200737953186,
			-0.017910098657011986,
			0.9985157251358032
		}
	},
	{
		height = 1.25,
		type = "content/volume_types/player_mover_blocker",
		name = "volume",
		alt_max_vector = {
			17.45155143737793,
			-235.37161254882812,
			2.7585668563842773
		},
		alt_min_vector = {
			17.45155143737793,
			-235.37161254882812,
			1.508566975593567
		},
		bottom_points = {
			{
				18.164915084838867,
				-236.95980834960938,
				1.508566975593567
			},
			{
				18.858821868896484,
				-235.92010498046875,
				1.508566975593567
			},
			{
				16.738187789916992,
				-233.78341674804688,
				1.508566975593567
			},
			{
				15.912599563598633,
				-234.70518493652344,
				1.508566975593567
			}
		},
		color = {
			255,
			255,
			125,
			0
		},
		up_vector = {
			-0,
			[2.0] = 0,
			[3.0] = 1
		}
	}
}

return {
	volume_data = volume_data
}
