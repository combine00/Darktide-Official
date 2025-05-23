local DialogueSettings = {
	default_rule_path = "dialogues/generated/",
	default_voSources_path = "dialogues/generated/",
	default_lookup_path = "dialogues/generated/",
	auto_load_files = {
		"asset_vo",
		"class_rework",
		"enemy_vo",
		"event_vo_fortification",
		"event_vo_kill",
		"event_vo_demolition",
		"event_vo_delivery",
		"event_vo_survive",
		"event_vo_hacking",
		"event_vo_scan",
		"gameplay_vo",
		"guidance_vo",
		"mission_giver_vo",
		"on_demand_vo"
	},
	menu_vo_files = {
		"conversations_hub",
		"mission_briefing"
	},
	level_specific_load_files = {
		om_hub_01 = {
			"mission_vo_om_hub_01",
			"cutscenes_vo"
		},
		om_hub_02 = {
			"mission_vo_om_hub_02",
			"cutscenes_vo"
		},
		om_basic_combat_01 = {
			"on_demand_vo",
			"training_grounds"
		},
		hub_ship = {
			"cutscenes_vo",
			"conversations_hub"
		},
		prologue = {
			"cutscenes_vo",
			"enemy_vo",
			"mission_vo_prologue"
		},
		dm_forge = {
			"mission_vo_dm_forge",
			"conversations_core"
		},
		lm_rails = {
			"mission_vo_lm_rails",
			"conversations_core"
		},
		lm_cooling = {
			"mission_vo_lm_cooling",
			"conversations_core"
		},
		fm_cargo = {
			"mission_vo_fm_cargo",
			"conversations_core"
		},
		fm_armoury = {
			"mission_vo_fm_armoury",
			"conversations_core"
		},
		cm_raid = {
			"mission_vo_cm_raid",
			"conversations_core"
		},
		fm_resurgence = {
			"mission_vo_fm_resurgence",
			"conversations_core"
		},
		hm_complex = {
			"mission_vo_hm_complex",
			"conversations_core"
		},
		cm_archives = {
			"mission_vo_cm_archives",
			"conversations_core"
		},
		km_station = {
			"mission_vo_km_station",
			"conversations_core"
		},
		hm_strain = {
			"mission_vo_hm_strain",
			"conversations_core"
		},
		lm_scavenge = {
			"mission_vo_lm_scavenge",
			"conversations_core"
		},
		dm_propaganda = {
			"mission_vo_dm_propaganda",
			"conversations_core"
		},
		dm_stockpile = {
			"mission_vo_dm_stockpile",
			"conversations_core"
		},
		km_enforcer = {
			"mission_vo_km_enforcer",
			"conversations_core"
		},
		hm_cartel = {
			"mission_vo_hm_cartel",
			"conversations_core"
		},
		cm_habs = {
			"mission_vo_cm_habs_remake",
			"conversations_core"
		},
		dm_rise = {
			"mission_vo_dm_rise",
			"conversations_core"
		},
		km_enforcer_twins = {
			"mission_vo_km_enforcer_twins"
		},
		tg_shooting_range = {
			"meat_grinder_vo",
			"mission_vo_psykhanium"
		},
		core_research = {
			"mission_vo_core_research",
			"conversations_core"
		},
		op_train = {
			"mission_vo_op_train"
		},
		km_heresy = {
			"mission_vo_km_heresy",
			"conversations_core"
		},
		psykhanium = {
			"mission_vo_psykhanium"
		}
	},
	player_load_files = {
		ogryn_a = {
			"ogryn_a"
		},
		ogryn_b = {
			"ogryn_b"
		},
		ogryn_c = {
			"ogryn_c"
		},
		psyker_female_a = {
			"psyker_a",
			"psyker_female_a"
		},
		psyker_female_b = {
			"psyker_b",
			"psyker_female_b"
		},
		psyker_female_c = {
			"psyker_c",
			"psyker_female_c"
		},
		psyker_male_a = {
			"psyker_a",
			"psyker_male_a"
		},
		psyker_male_b = {
			"psyker_b",
			"psyker_male_b"
		},
		psyker_male_c = {
			"psyker_c",
			"psyker_male_c"
		},
		veteran_female_a = {
			"veteran_a",
			"veteran_female_a"
		},
		veteran_female_b = {
			"veteran_b",
			"veteran_female_b"
		},
		veteran_female_c = {
			"veteran_c",
			"veteran_female_c"
		},
		veteran_male_a = {
			"veteran_a",
			"veteran_male_a"
		},
		veteran_male_b = {
			"veteran_b",
			"veteran_male_b"
		},
		veteran_male_c = {
			"veteran_c",
			"veteran_male_c"
		},
		zealot_female_a = {
			"zealot_a",
			"zealot_female_a"
		},
		zealot_female_b = {
			"zealot_b",
			"zealot_female_b"
		},
		zealot_female_c = {
			"zealot_c",
			"zealot_female_c"
		},
		zealot_male_a = {
			"zealot_a",
			"zealot_male_a"
		},
		zealot_male_b = {
			"zealot_b",
			"zealot_male_b"
		},
		zealot_male_c = {
			"zealot_c",
			"zealot_male_c"
		}
	},
	blocked_auto_load_files = {
		hub_ship = true,
		om_basic_combat_01 = true,
		prologue = true,
		tutorial = true,
		tg_shooting_range = true
	},
	ranged_special_kill_threshold = 20,
	friends_close_distance = 25,
	friends_distant_distance = 40,
	enemies_close_distance = 10,
	enemies_distant_distance = 40,
	dialogue_level_start_delay = 120,
	story_tickers_intensity_cooldown = 6,
	story_ticker_enabled = true,
	story_start_delay = 173,
	story_tick_time = 5.1,
	short_story_ticker_enabled = true,
	short_story_start_delay = 181,
	short_story_tick_time = 3.9,
	decaying_tension_delay = 2,
	npc_story_ticker_enabled = true,
	npc_story_ticker_start_delay = 127,
	npc_story_tick_time = 10,
	player_load_files_game_modes = {
		coop_complete_objective = true
	},
	store_npc_cooldown_time = 5,
	sound_event_default_length = 3.4567,
	knocked_down_vo_interval = 11,
	netted_vo_start_delay_t = 1,
	netted_vo_interval_t = 3,
	pounced_vo_start_delay_t = 0.2,
	pounced_vo_interval_t = 3,
	monster_tough_to_kill_vo_health_percent = 0.6,
	monster_critical_health_percent_vo = 0.3,
	monster_near_death_health_percent_vo = 0.2,
	heavy_land_on_air_threshold = 0.7,
	raycast_enemy_check_interval = 0.25,
	hear_enemy_check_interval = 10,
	enemy_proximity_distance = 30,
	enemy_proximity_distance_heard = 30,
	seen_enemy_precision = 0.999,
	health_hog_health_before_healing = 0.8,
	ammo_hog_pickup_share = 0.7,
	friendly_fire_bullet_counter = 4,
	heard_speak_distance = 25,
	default_voice_switch_group = "voice_profile",
	player_vce_light_damage_threshold = 55,
	surrounded_vo_slot_percent = 0.3,
	distance_culled_wwise_routes = {
		[19.0] = 20,
		[50.0] = 25,
		[52.0] = 30,
		[45.0] = 15
	},
	dynamic_smart_tags = table.enum("aggroed", "renegade_netgunner", "seen_netgunner_flee"),
	manual_subtitles = table.enum("loc_captain_twin_male_a__mission_twins_arrival_04_a_01"),
	manual_subtitle_data = {
		{
			duration = 9.26,
			speaker_name = "captain_twin_male_a"
		}
	},
	backend_vo_groups = table.enum("horde_mode"),
	horde_mode = table.enum("story_echo_morrow_01_a", "story_echo_morrow_05_a", "story_echo_morrow_09_a", "story_echo_morrow_13_a", "story_echo_morrow_17_a", "story_echo_morrow_21_a", "story_echo_morrow_25_a", "story_echo_morrow_29_a", "story_echo_morrow_33_a", "story_echo_zola_01_a", "story_echo_zola_05_a", "story_echo_zola_09_a", "story_echo_zola_13_a", "story_echo_zola_17_a", "story_echo_zola_21_a", "story_echo_zola_25_a"),
	stats = {
		horde_mode = {
			story_echo_morrow_09_a = "hook_backstory_morrow_part_3",
			story_echo_morrow_33_a = "hook_backstory_morrow_part_9",
			story_echo_zola_01_a = "hook_backstory_zola_part_1",
			story_echo_morrow_25_a = "hook_backstory_morrow_part_7",
			story_echo_zola_05_a = "hook_backstory_zola_part_2",
			story_echo_zola_09_a = "hook_backstory_zola_part_3",
			story_echo_morrow_17_a = "hook_backstory_morrow_part_5",
			story_echo_morrow_01_a = "hook_backstory_morrow_part_1",
			story_echo_zola_13_a = "hook_backstory_zola_part_4",
			story_echo_zola_17_a = "hook_backstory_zola_part_5",
			story_echo_morrow_29_a = "hook_backstory_morrow_part_8",
			story_echo_morrow_21_a = "hook_backstory_morrow_part_6",
			story_echo_zola_21_a = "hook_backstory_zola_part_6",
			story_echo_zola_25_a = "hook_backstory_zola_part_7",
			story_echo_morrow_05_a = "hook_backstory_morrow_part_2",
			story_echo_morrow_13_a = "hook_backstory_morrow_part_4"
		}
	}
}

return DialogueSettings
