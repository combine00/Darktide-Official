local mission_templates = {
	dm_stockpile = {
		mission_name = "loc_mission_name_dm_stockpile",
		wwise_state = "zone_2",
		zone_id = "watertown",
		texture_small = "content/ui/textures/pj_missions/dm_stockpile_small",
		mission_brief_material = "content/environment/cinematic/mission_briefing/mission_briefing_hologram_dm_stockpile_01",
		texture_medium = "content/ui/textures/pj_missions/dm_stockpile_medium",
		face_state_machine_key = "state_machine_missions",
		mechanism_name = "adventure",
		texture_big = "content/ui/textures/pj_missions/dm_stockpile_big",
		coordinates = "loc_mission_coordinates_dm_stockpile",
		mission_type = "strike",
		level = "content/levels/watertown/missions/mission_dm_stockpile",
		game_mode_name = "coop_complete_objective",
		mission_intro_minimum_time = 5,
		objectives = "dm_stockpile",
		mission_description = "loc_mission_board_main_objective_waterstockpile_description",
		cinematics = {
			intro_abc = {
				"c_cam"
			},
			outro_fail = {
				"outro_fail"
			},
			outro_win = {
				"outro_win"
			}
		},
		pickup_settings = {},
		hazard_prop_settings = {
			explosion = 0.3,
			fire = 0.2,
			none = 0.4
		},
		terror_event_templates = {
			"terror_events_dm_stockpile"
		},
		health_station = {},
		testify_flags = {},
		mission_brief_vo = {
			vo_profile = "sergeant_a",
			wwise_route_key = 1,
			vo_events = {
				"mission_stockpile_briefing_a",
				"mission_stockpile_briefing_b",
				"mission_stockpile_briefing_c"
			}
		},
		dialogue_settings = {
			npc_story_ticker_enabled = false,
			short_story_ticker_enabled = true,
			story_ticker_enabled = true
		},
		spawn_settings = {
			next_mission = "recent_mission"
		}
	},
	hm_cartel = {
		mission_name = "loc_mission_name_hm_cartel",
		wwise_state = "zone_2",
		zone_id = "watertown",
		texture_small = "content/ui/textures/pj_missions/hm_cartel_small",
		mission_brief_material = "content/environment/cinematic/mission_briefing/mission_briefing_hologram_hm_cartel_01",
		texture_medium = "content/ui/textures/pj_missions/hm_cartel_medium",
		face_state_machine_key = "state_machine_missions",
		mechanism_name = "adventure",
		texture_big = "content/ui/textures/pj_missions/hm_cartel_big",
		coordinates = "loc_mission_coordinates_hm_cartel",
		mission_type = "espionage",
		level = "content/levels/watertown/missions/mission_hm_cartel",
		game_mode_name = "coop_complete_objective",
		mission_intro_minimum_time = 25,
		objectives = "hm_cartel",
		mission_description = "loc_mission_board_main_objective_cartel_description",
		cinematics = {
			intro_abc = {
				"c_cam"
			},
			outro_fail = {
				"outro_fail"
			},
			outro_win = {
				"outro_win"
			}
		},
		hazard_prop_settings = {
			explosion = 0.3,
			fire = 0.2,
			none = 0.4
		},
		pickup_settings = {},
		terror_event_templates = {
			"terror_events_hm_cartel"
		},
		testify_flags = {},
		health_station = {},
		mission_brief_vo = {
			vo_profile = "explicator_a",
			wwise_route_key = 1,
			vo_events = {
				"mission_cartel_brief_one",
				"mission_cartel_brief_two",
				"mission_cartel_brief_three"
			}
		},
		dialogue_settings = {
			npc_story_ticker_enabled = false,
			short_story_ticker_enabled = true,
			story_ticker_enabled = true
		},
		spawn_settings = {
			next_mission = "recent_mission"
		}
	},
	km_enforcer = {
		mission_name = "loc_mission_name_km_enforcer",
		wwise_state = "zone_2",
		zone_id = "watertown",
		texture_small = "content/ui/textures/pj_missions/km_enforcer_small",
		mission_brief_material = "content/environment/cinematic/mission_briefing/mission_briefing_hologram_km_enforcer_01",
		texture_medium = "content/ui/textures/pj_missions/km_enforcer_medium",
		face_state_machine_key = "state_machine_missions",
		mechanism_name = "adventure",
		texture_big = "content/ui/textures/pj_missions/km_enforcer_big",
		coordinates = "loc_mission_coordinates_km_enforcer",
		mission_type = "assassination",
		level = "content/levels/watertown/missions/mission_km_enforcer",
		game_mode_name = "coop_complete_objective",
		mission_intro_minimum_time = 5,
		objectives = "km_enforcer",
		mission_description = "loc_mission_board_main_objective_enforcer_description",
		cinematics = {
			intro_abc = {
				"c_cam"
			},
			outro_fail = {
				"outro_fail"
			},
			outro_win = {
				"outro_win"
			}
		},
		pickup_settings = {},
		hazard_prop_settings = {
			explosion = 0.3,
			fire = 0.2,
			none = 0.4
		},
		terror_event_templates = {
			"terror_events_km_enforcer"
		},
		health_station = {},
		testify_flags = {},
		mission_brief_vo = {
			vo_profile = "sergeant_a",
			wwise_route_key = 1,
			vo_events = {
				"mission_enforcer_briefing_a",
				"mission_enforcer_briefing_b",
				"mission_enforcer_briefing_c"
			}
		},
		dialogue_settings = {
			npc_story_ticker_enabled = false,
			short_story_ticker_enabled = true,
			story_ticker_enabled = true
		},
		spawn_settings = {
			next_mission = "recent_mission"
		}
	},
	km_enforcer_twins = {
		mission_name = "loc_mission_name_km_enforcer_twins",
		wwise_state = "zone_twins",
		zone_id = "watertown",
		texture_small = "content/ui/textures/pj_missions/km_enforcer_twins_small",
		mission_brief_material = "content/environment/cinematic/mission_briefing/mission_briefing_hologram_km_enforcer_twins_01",
		texture_medium = "content/ui/textures/pj_missions/km_enforcer_twins_medium",
		face_state_machine_key = "state_machine_missions",
		mechanism_name = "adventure",
		texture_big = "content/ui/textures/pj_missions/km_enforcer_twins_big",
		not_needed_for_penance = true,
		coordinates = "loc_mission_coordinates_km_enforcer",
		level = "content/levels/watertown_twins/missions/mission_km_enforcer_twins",
		game_mode_name = "coop_complete_objective",
		mission_intro_minimum_time = 5,
		objectives = "km_enforcer",
		mission_type = "assassination",
		mission_description = "loc_mission_board_main_objective_enforcer_twins_description",
		cinematics = {
			intro_abc = {
				"c_cam"
			},
			outro_fail = {
				"outro_fail"
			},
			outro_win = {
				"outro_win"
			},
			traitor_captain_intro = {
				"traitor_captain_intro"
			}
		},
		pickup_settings = {
			primary = {
				ammo = {
					ammo_cache_pocketable = {
						-100
					}
				},
				health = {
					medical_crate_pocketable = {
						-100
					}
				},
				forge_material = {
					small_metal = {
						-100
					},
					large_metal = {
						-100
					},
					small_platinum = {
						-100
					},
					large_platinum = {
						-100
					}
				}
			},
			secondary = {
				ammo = {
					ammo_cache_pocketable = {
						-100
					}
				},
				health = {
					medical_crate_pocketable = {
						-100
					}
				},
				forge_material = {
					small_metal = {
						-100
					},
					large_metal = {
						-100
					},
					small_platinum = {
						-100
					},
					large_platinum = {
						-100
					}
				}
			},
			rubberband_pool = {
				ammo = {
					ammo_cache_pocketable = {
						-100
					}
				},
				health = {
					medical_crate_pocketable = {
						-100
					}
				}
			}
		},
		hazard_prop_settings = {
			explosion = 0.3,
			fire = 0.2,
			none = 0.4
		},
		terror_event_templates = {
			"terror_events_km_enforcer_twins"
		},
		health_station = {},
		testify_flags = {},
		mission_brief_vo = {
			vo_profile = "explicator_a",
			wwise_route_key = 1,
			vo_events = {
				"mission_twins_briefing_a",
				"mission_twins_briefing_b",
				"mission_twins_briefing_b2",
				"mission_twins_briefing_c"
			}
		},
		dialogue_settings = {
			npc_story_ticker_enabled = false,
			short_story_ticker_enabled = false,
			story_ticker_enabled = false
		},
		narrative_story = {
			chapter = "s1_twins_mission",
			story = "s1_twins"
		},
		spawn_settings = {
			next_mission = "recent_mission"
		}
	}
}

return mission_templates
