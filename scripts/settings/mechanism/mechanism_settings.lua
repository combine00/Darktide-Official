local StateGameScore = require("scripts/game_states/game/state_game_score")
local StateMissionServerExit = require("scripts/game_states/game/state_mission_server_exit")
local mechanism_settings = {
	sandbox = {
		class_name = "MechanismSandbox",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_sandbox",
		states = {
			"init",
			"gameplay",
			"game_mode_ended"
		},
		player_package_synchronization_settings = {
			prioritization_template = "default"
		},
		loader_paths = {}
	},
	onboarding = {
		class_name = "MechanismOnboarding",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_onboarding",
		states = {
			"init",
			"gameplay",
			"game_mode_ended",
			"joining_hub_server",
			"joining_party_game_session",
			"client_exit_gameplay",
			"client_wait_for_server"
		},
		player_package_synchronization_settings = {
			prioritization_template = "default"
		},
		loader_paths = {}
	},
	hub = {
		class_name = "MechanismHub",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_hub",
		states = {
			"init",
			"request_hub_config",
			"init_hub",
			"in_hub",
			"joining_party_game_session",
			"client_exit_gameplay",
			"client_wait_for_server"
		},
		player_package_synchronization_settings = {
			prioritization_template = "hub"
		},
		loader_paths = {}
	},
	idle = {
		class_name = "MechanismIdle",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_idle",
		states = {
			"idle"
		},
		player_package_synchronization_settings = {
			prioritization_template = "default"
		},
		loader_paths = {}
	},
	adventure = {
		class_name = "MechanismAdventure",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_adventure",
		states = {
			"adventure_selected",
			"mission_server_exit",
			"client_exit_gameplay",
			"client_wait_for_server",
			"adventure",
			"score",
			"joining_party_game_session"
		},
		game_states = {
			score = StateGameScore,
			mission_server_exit = StateMissionServerExit
		},
		player_package_synchronization_settings = {
			prioritization_template = "default"
		},
		loader_paths = {}
	},
	left_session = {
		class_name = "MechanismLeftSession",
		class_file_name = "scripts/managers/mechanism/mechanisms/mechanism_left_session",
		states = {
			"init",
			"search_for_session",
			"wait_for_session"
		},
		player_package_synchronization_settings = {
			prioritization_template = "default"
		},
		loader_paths = {}
	}
}

return settings("MechanismSettings", mechanism_settings)
