local settings = {
	name = "training_grounds",
	default_player_side_name = "heroes",
	host_singleplay = true,
	vaulting_allowed = true,
	force_base_talents = true,
	class_file_name = "scripts/managers/game_mode/game_modes/game_mode_training_grounds",
	disable_hologram = true,
	bot_backfilling_allowed = false,
	cache_local_player_profile = true,
	use_side_color = false,
	states = {
		"loading",
		"in_game",
		"leaving_game",
		"training_complete"
	},
	side_compositions = {
		{
			name = "heroes",
			color_name = "blue",
			relations = {
				enemy = {
					"villains"
				}
			}
		},
		{
			name = "villains",
			color_name = "red",
			relations = {
				enemy = {
					"heroes"
				}
			}
		}
	},
	side_sub_faction_types = {
		villains = {
			"chaos",
			"cultist",
			"renegade"
		}
	},
	hud_settings = {
		player_composition = "party"
	},
	hotkeys = {
		hotkey_system = "system_view"
	},
	default_init_scripted_scenario = {
		alias = "training_grounds",
		name = "default"
	}
}

return settings
