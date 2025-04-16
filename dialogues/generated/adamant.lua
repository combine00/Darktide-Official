return function ()
	define_rule({
		name = "adamant_male_a_ogryn_bonding_conversation_01_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_male_a_ogryn_bonding_conversation_01_a",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"short_story_talk"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				1
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				90
			},
			{
				"global_context",
				"is_decaying_tension",
				OP.EQ,
				"true"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a"
				}
			},
			{
				"faction_memory",
				"adamant_male_a_ogryn_bonding_conversation_01_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				140
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"adamant_male_a_ogryn_bonding_conversation_01_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			},
			{
				"user_memory",
				"adamant_male_a_ogryn_bonding_conversation_01_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_seen_killstreak_adamant",
		wwise_route = 0,
		response = "adamant_seen_killstreak_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_killstreak_adamant"
			},
			{
				"query_context",
				"killer_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"number_of_kills",
				OP.GTEQ,
				15
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 4,
				hold_for = 2
			}
		}
	})
	define_rule({
		name = "adamant_seen_killstreak_ogryn",
		wwise_route = 0,
		response = "adamant_seen_killstreak_ogryn",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_killstreak_ogryn"
			},
			{
				"query_context",
				"killer_class",
				OP.EQ,
				"ogryn"
			},
			{
				"query_context",
				"number_of_kills",
				OP.GTEQ,
				15
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_seen_killstreak_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 4,
				hold_for = 2
			}
		}
	})
	define_rule({
		name = "adamant_seen_killstreak_psyker",
		wwise_route = 0,
		response = "adamant_seen_killstreak_psyker",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_killstreak_psyker"
			},
			{
				"query_context",
				"killer_class",
				OP.EQ,
				"psyker"
			},
			{
				"query_context",
				"number_of_kills",
				OP.GTEQ,
				15
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_seen_killstreak_user",
				OP.TIMESET
			},
			{
				"user_memory",
				"ogryn_seen_killstreak_psyker_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 4,
				hold_for = 2
			}
		}
	})
	define_rule({
		name = "adamant_seen_killstreak_veteran",
		wwise_route = 0,
		response = "adamant_seen_killstreak_veteran",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_killstreak_veteran"
			},
			{
				"query_context",
				"killer_class",
				OP.EQ,
				"veteran"
			},
			{
				"query_context",
				"number_of_kills",
				OP.GTEQ,
				15
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 4,
				hold_for = 2
			}
		}
	})
	define_rule({
		name = "adamant_seen_killstreak_zealot",
		wwise_route = 0,
		response = "adamant_seen_killstreak_zealot",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_killstreak_zealot"
			},
			{
				"query_context",
				"killer_class",
				OP.EQ,
				"zealot"
			},
			{
				"query_context",
				"number_of_kills",
				OP.GTEQ,
				15
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 4,
				hold_for = 2
			}
		}
	})
	define_rule({
		name = "adamant_start_revive_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "adamant_start_revive_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"interaction_vo"
			},
			{
				"user_context",
				"interactor_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"user_context",
				"interactee_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"start_revive"
			},
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_start_revive_ogryn",
		category = "player_prio_1",
		wwise_route = 0,
		response = "adamant_start_revive_ogryn",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"interaction_vo"
			},
			{
				"user_context",
				"interactor_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"user_context",
				"interactee_class",
				OP.SET_INCLUDES,
				args = {
					"ogryn"
				}
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"start_revive"
			},
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_start_revive_psyker",
		category = "player_prio_1",
		wwise_route = 0,
		response = "adamant_start_revive_psyker",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"interaction_vo"
			},
			{
				"user_context",
				"interactor_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"user_context",
				"interactee_class",
				OP.SET_INCLUDES,
				args = {
					"psyker"
				}
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"start_revive"
			},
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_start_revive_veteran",
		category = "player_prio_1",
		wwise_route = 0,
		response = "adamant_start_revive_veteran",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"interaction_vo"
			},
			{
				"user_context",
				"interactor_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"user_context",
				"interactee_class",
				OP.SET_INCLUDES,
				args = {
					"veteran"
				}
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"start_revive"
			},
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_start_revive_zealot",
		category = "player_prio_1",
		wwise_route = 0,
		response = "adamant_start_revive_zealot",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"interaction_vo"
			},
			{
				"user_context",
				"interactor_class",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"user_context",
				"interactee_class",
				OP.SET_INCLUDES,
				args = {
					"zealot"
				}
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"start_revive"
			},
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_revived_friendly",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_01_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_01_a",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"short_story_talk"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				1
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				90
			},
			{
				"global_context",
				"is_decaying_tension",
				OP.EQ,
				"true"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_male_b"
				}
			},
			{
				"faction_memory",
				"adamant_to_adamant_bonding_conversation_01_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				140
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"adamant_to_adamant_bonding_conversation_01_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			},
			{
				"user_memory",
				"adamant_to_adamant_bonding_conversation_01_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_01_b",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_01_b",
		database = "adamant",
		category = "conversations_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_to_adamant_bonding_conversation_01_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_to_adamant_bonding_conversation_01_b_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_01_c",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_01_c",
		database = "adamant",
		category = "conversations_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_to_adamant_bonding_conversation_01_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_to_adamant_bonding_conversation_01_c_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_01_d",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_01_d",
		database = "adamant",
		category = "conversations_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_to_adamant_bonding_conversation_01_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_male_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_to_adamant_bonding_conversation_01_d_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "found_health_booster_adamant_low_on_health",
		category = "player_prio_0",
		wwise_route = 0,
		response = "found_health_booster_adamant_low_on_health",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_mission_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"found_health_booster_low_on_health"
			},
			{
				"faction_context",
				"health",
				OP.LT,
				0.3
			},
			{
				"faction_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"adamant"
				}
			},
			{
				"faction_memory",
				"deployed_medical_crate",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"deployed_medical_crate",
				OP.TIMESET
			}
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.5
			}
		}
	})
	define_rule({
		name = "friendly_fire_from_adamant_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "friendly_fire_from_adamant_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "friendly_fire_from_ogryn_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "friendly_fire_from_ogryn_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"ogryn"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "friendly_fire_from_psyker_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "friendly_fire_from_psyker_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"psyker"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "friendly_fire_from_veteran_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "friendly_fire_from_veteran_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"veteran"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "friendly_fire_from_zealot_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "friendly_fire_from_zealot_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"zealot"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "knocked_down_multiple_times_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "knocked_down_multiple_times_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"knocked_down_multiple_times"
			},
			{
				"query_context",
				"player_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"faction_memory",
				"time_since_knocked_down_multiple_times",
				OP.TIMEDIFF,
				OP.GT,
				300
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_knocked_down_multiple_times",
				OP.TIMESET
			}
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 1
			}
		}
	})
	define_rule({
		name = "player_death_adamant",
		wwise_route = 0,
		response = "player_death_adamant",
		database = "adamant",
		category = "player_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"player_death"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				30
			},
			{
				"query_context",
				"died_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"current_mission",
				OP.NEQ,
				"prologue"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_player_death",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 1
			}
		}
	})
	define_rule({
		name = "response_for_adamant_cover_me",
		wwise_route = 0,
		response = "response_for_adamant_cover_me",
		database = "adamant",
		category = "conversations_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"cover_me"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"response_for_adamant_cover_me",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"response_for_adamant_cover_me",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_critical_health",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_adamant_critical_health",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				10
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"critical_health"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"veteran"
			},
			{
				"user_memory",
				"rapid_loosing_health_response",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.LT,
				180
			}
		},
		on_done = {
			{
				"user_memory",
				"rapid_loosing_health_response",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_seen_veteran_losing_health",
				OP.TIMESET
			}
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_disabled_by_chaos_hound",
		wwise_route = 0,
		response = "response_for_adamant_disabled_by_chaos_hound",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"disabled_by_chaos_hound"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"response_for_adamant_disabled_by_chaos_hound",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"response_for_psyker_disabled_by_chaos_hound",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_disabled_by_enemy",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_adamant_disabled_by_enemy",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				10
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"disabled_by_enemy"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			}
		},
		on_done = {}
	})
	define_rule({
		name = "response_for_adamant_enemy_kill_monster",
		wwise_route = 0,
		response = "response_for_adamant_enemy_kill_monster",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"enemy_kill_monster"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"",
				OP.TIMEDIFF,
				OP.GT,
				240
			}
		},
		on_done = {
			{
				"faction_memory",
				"",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_knocked_down_3",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_adamant_knocked_down_3",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"knocked_down_3"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"response_for_adamant_knocked_down_3",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"response_for_ogryn_knocked_down_3",
				OP.TIMESET
			}
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_ledge_hanging",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_adamant_ledge_hanging",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"ledge_hanging"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"response_for_adamant_ledge_hanging",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"response_for_ogryn_ledge_hanging",
				OP.TIMESET
			}
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_adamant_start_revive_adamant",
		wwise_route = 0,
		response = "response_for_adamant_start_revive_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LTEQ,
				7
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_start_revive_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_revivee",
				OP.GT,
				1
			},
			{
				"user_memory",
				"last_revivee",
				OP.TIMEDIFF,
				OP.LT,
				10
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_friendly_fire_from_adamant_to_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_friendly_fire_from_adamant_to_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"adamant"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "response_for_friendly_fire_from_adamant_to_ogryn",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_friendly_fire_from_adamant_to_ogryn",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"ogryn"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "response_for_friendly_fire_from_adamant_to_psyker",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_friendly_fire_from_adamant_to_psyker",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"psyker"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "response_for_friendly_fire_from_adamant_to_veteran",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_friendly_fire_from_adamant_to_veteran",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"veteran"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "response_for_friendly_fire_from_adamant_to_zealot",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_friendly_fire_from_adamant_to_zealot",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"attacking_class",
				OP.EQ,
				"adamant"
			},
			{
				"query_context",
				"attacked_class",
				OP.EQ,
				"zealot"
			},
			{
				"user_context",
				"threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				5
			},
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMEDIFF,
				OP.GT,
				45
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"time_since_friendly_fire",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_friendly_fire_global",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "response_for_ogryn_seen_killstreak_adamant",
		wwise_route = 0,
		response = "response_for_ogryn_seen_killstreak_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"ogryn_seen_killstreak_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"ogryn"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"zealot"
			},
			{
				"user_memory",
				"last_killstreak",
				OP.TIMEDIFF,
				OP.LT,
				10
			},
			{
				"user_memory",
				"last_killstreak",
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_ogryn_start_revive_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_ogryn_start_revive_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LTEQ,
				7
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"ogryn_start_revive_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"ogryn"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_revivee",
				OP.GT,
				1
			},
			{
				"user_memory",
				"last_revivee",
				OP.TIMEDIFF,
				OP.LT,
				10
			}
		},
		on_done = {},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_pinned_by_enemies_adamant",
		wwise_route = 0,
		response = "response_for_pinned_by_enemies_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"pinned_by_enemies"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"adamant"
			},
			{
				"faction_memory",
				"response_for_pinned_by_enemies_adamant",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"response_for_pinned_by_enemies_zealot",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_psyker_seen_killstreak_adamant",
		wwise_route = 0,
		response = "response_for_psyker_seen_killstreak_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"psyker_seen_killstreak_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"psyker"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_killstreak",
				OP.TIMEDIFF,
				OP.LT,
				10
			},
			{
				"user_memory",
				"last_killstreak",
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_psyker_start_revive_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_psyker_start_revive_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LTEQ,
				7
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"psyker_start_revive_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"psyker"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_revivee",
				OP.GT,
				1
			},
			{
				"user_memory",
				"last_revivee",
				OP.TIMEDIFF,
				OP.LT,
				10
			}
		},
		on_done = {},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_veteran_seen_killstreak_adamant",
		wwise_route = 0,
		response = "response_for_veteran_seen_killstreak_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"veteran_seen_killstreak_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"veteran"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_killstreak",
				OP.TIMEDIFF,
				OP.LT,
				10
			},
			{
				"user_memory",
				"last_killstreak",
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_veteran_start_revive_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_veteran_start_revive_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LTEQ,
				7
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"veteran_start_revive_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"veteran"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_revivee",
				OP.GT,
				1
			},
			{
				"user_memory",
				"last_revivee",
				OP.TIMEDIFF,
				OP.LT,
				10
			}
		},
		on_done = {},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_zealot_seen_killstreak_adamant",
		wwise_route = 0,
		response = "response_for_zealot_seen_killstreak_adamant",
		database = "adamant",
		category = "player_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.GTEQ,
				0
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"zealot_seen_killstreak_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"zealot"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"ogryn"
			},
			{
				"user_memory",
				"last_killstreak",
				OP.TIMEDIFF,
				OP.LT,
				10
			},
			{
				"user_memory",
				"last_killstreak",
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_killstreak",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "response_for_zealot_start_revive_adamant",
		category = "player_prio_1",
		wwise_route = 0,
		response = "response_for_zealot_start_revive_adamant",
		database = "adamant",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				0
			},
			{
				"user_context",
				"enemies_close",
				OP.LTEQ,
				7
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"zealot_start_revive_adamant"
				}
			},
			{
				"query_context",
				"speaker_class",
				OP.EQ,
				"zealot"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"adamant"
			},
			{
				"user_memory",
				"last_revivee",
				OP.GT,
				1
			},
			{
				"user_memory",
				"last_revivee",
				OP.TIMEDIFF,
				OP.LT,
				10
			}
		},
		on_done = {},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
end
