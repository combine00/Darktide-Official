local mission_templates = {
	om_hub_01 = {
		zone_id = "hub",
		mission_name = "loc_mission_name_hub_ship",
		wwise_state = "hub",
		objectives = "onboarding",
		game_mode_name = "prologue_hub",
		hud_elements = "scripts/ui/hud/hud_elements_player_hub",
		mechanism_name = "onboarding",
		not_needed_for_penance = true,
		force_third_person_mode = true,
		level = "content/levels/hub/hub_ship/missions/mission_om_hub_01",
		cinematics = {
			cutscene_5_hub = {
				"cs_05_hub"
			},
			cutscene_7 = {
				"cs_07"
			},
			hub_location_intro_training_grounds = {
				"hub_location_intro_training_grounds"
			}
		},
		testify_flags = {
			run_through_mission = false,
			validate_minion_pathing_on_mission = false,
			fly_through = false,
			mission_server = false
		}
	},
	om_hub_02 = {
		zone_id = "hub",
		mission_name = "loc_mission_name_hub_ship",
		wwise_state = "hub",
		objectives = "onboarding",
		game_mode_name = "prologue_hub",
		hud_elements = "scripts/ui/hud/hud_elements_player_hub",
		mechanism_name = "onboarding",
		not_needed_for_penance = true,
		force_third_person_mode = true,
		level = "content/levels/hub/hub_ship/missions/mission_om_hub_02",
		testify_flags = {
			cutscenes = false,
			validate_minion_pathing_on_mission = false,
			run_through_mission = false,
			fly_through = false,
			mission_server = false
		}
	},
	om_basic_combat_01 = {
		zone_id = "training_grounds",
		mission_name = "loc_mission_name_tg_basic_combat_01",
		hud_elements = "scripts/ui/hud/hud_elements_player_onboarding",
		objectives = "training_grounds",
		game_mode_name = "training_grounds",
		mechanism_name = "onboarding",
		not_needed_for_penance = true,
		level = "content/levels/training_grounds/missions/mission_tg_basic_combat_01",
		cinematics = {
			hub_location_intro_psykhanium = {
				"hub_location_intro_psykhanium"
			}
		},
		terror_event_templates = {
			"terror_events_training_ground"
		},
		testify_flags = {
			performance = false,
			screenshot = false,
			validate_minion_pathing_on_mission = false,
			run_through_mission = false,
			fly_through = false,
			mission_server = false
		}
	},
	tg_shooting_range = {
		mission_name = "loc_mission_name_tg_basic_combat_01",
		hud_elements = "scripts/ui/hud/hud_elements_player_onboarding",
		objectives = "training_grounds",
		game_mode_name = "shooting_range",
		zone_id = "training_grounds",
		mechanism_name = "onboarding",
		not_needed_for_penance = true,
		level = "content/levels/training_grounds/missions/mission_tg_basic_combat_01",
		terror_event_templates = {
			"terror_events_training_ground"
		},
		testify_flags = {
			performance = false,
			screenshot = false,
			cutscenes = false,
			validate_minion_pathing_on_mission = false,
			run_through_mission = false,
			fly_through = false,
			mission_server = false
		},
		spawn_settings = {
			next_mission = "tg_shooting_range"
		},
		dialogue_settings = {
			npc_story_ticker_enabled = true,
			npc_story_tick_time = 180,
			short_story_ticker_enabled = false,
			story_ticker_enabled = false,
			npc_story_ticker_start_delay = 80 + math.random(0, 120)
		},
		mission_brief_vo = {
			vo_profile = "training_ground_psyker_a",
			mission_giver_packs = {
				training_ground_psyker_a = {
					"training_ground_psyker",
					"past"
				}
			}
		}
	}
}

return mission_templates
