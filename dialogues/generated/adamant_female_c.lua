return function ()
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_05_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_05_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
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
				"adamant_female_c_ogryn_bonding_conversation_05_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_05_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_05_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_05_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_05_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_05_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_05_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_05_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_05_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_05_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_05_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_05_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_05_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_05_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_05_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_07_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_07_a",
		database = "adamant_female_c",
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
					"ogryn_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_07_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_07_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_07_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_07_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_07_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_07_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_07_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_07_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_07_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_07_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_11_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_11_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_11_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_11_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_11_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_11_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_11_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_11_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_11_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_11_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_11_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_11_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_16_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_16_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_16_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_16_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_16_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_16_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_16_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_16_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_16_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_16_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_16_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_16_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_17_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_17_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_17_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_17_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_17_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_17_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_17_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_17_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_17_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_17_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_17_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_17_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_22_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_22_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_22_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_22_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_22_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_22_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_22_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_22_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_22_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_22_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_22_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_22_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_25_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_25_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_ogryn_bonding_conversation_25_b",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_25_b",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_25_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_b_user",
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
		name = "adamant_female_c_ogryn_bonding_conversation_25_c",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_25_c",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_25_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_ogryn_bonding_conversation_25_d",
		wwise_route = 0,
		response = "adamant_female_c_ogryn_bonding_conversation_25_d",
		database = "adamant_female_c",
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
					"adamant_female_c_ogryn_bonding_conversation_25_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"ogryn_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_ogryn_bonding_conversation_25_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_01_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_01_a",
		database = "adamant_female_c",
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
					"psyker_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_01_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_psyker_bonding_conversation_01_a",
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
				"adamant_female_c_psyker_bonding_conversation_01_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_01_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_01_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_01_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_01_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_01_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_01_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_01_b"
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
				"adamant_female_c_psyker_bonding_conversation_01_c_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_01_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_01_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_01_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_01_d_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_02_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_02_a",
		database = "adamant_female_c",
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
					"psyker_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_02_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_psyker_bonding_conversation_02_a",
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
				"adamant_female_c_psyker_bonding_conversation_02_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_02_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_02_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_02_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_01_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_02_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_02_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_02_b"
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
				"adamant_female_c_psyker_bonding_conversation_02_c_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_02_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_02_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_02_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_02_d_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_05_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_05_a",
		database = "adamant_female_c",
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
					"psyker_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_05_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_05_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_05_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_05_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_05_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_05_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_05_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_05_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_05_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_05_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_05_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_05_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_05_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_05_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_05_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_11_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_11_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_11_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_11_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_11_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_11_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_11_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_11_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_11_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_11_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_11_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_11_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_11_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_11_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_11_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_11_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_11_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_12_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_12_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_12_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_12_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_12_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_12_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_12_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_12_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_12_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_12_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_12_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_12_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_12_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_12_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_12_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_12_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_12_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_17_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_17_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_male_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_17_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_17_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_17_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_17_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_17_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_17_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_17_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_17_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_17_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_17_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_17_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_17_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_17_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_17_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_17_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_20_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_20_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_male_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_20_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_20_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_20_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_20_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_20_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_20_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_20_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_20_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_20_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_20_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_20_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_20_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_20_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_20_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_20_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_22_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_22_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_22_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_22_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_22_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_22_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_22_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_22_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_22_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_22_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_22_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_22_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_22_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_22_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_22_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_22_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_22_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_25_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_25_a",
		database = "adamant_female_c",
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
					"psyker_male_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_25_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_25_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_25_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_25_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_25_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_25_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_25_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_25_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_25_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_25_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_25_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_25_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_25_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_25_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_25_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_27_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_27_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_male_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_27_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_27_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_27_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_27_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_27_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_27_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_27_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_27_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_27_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_27_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_27_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_27_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_27_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_27_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_27_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_30_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_30_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_male_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_30_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_30_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_30_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_30_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_30_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_30_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_30_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_30_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_30_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_30_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_30_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_30_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_30_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_30_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_30_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_31_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_31_a",
		database = "adamant_female_c",
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
					"psyker_female_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_31_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_31_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_31_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_31_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_31_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_31_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_31_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_31_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_31_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_31_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_31_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_31_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_31_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_31_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_31_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_32_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_32_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_32_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_32_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_32_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_32_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_32_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_32_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_32_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_32_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_32_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_32_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_32_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_32_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_32_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_32_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_32_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_36_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_36_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_female_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_36_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_36_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_36_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_36_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_36_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_36_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_36_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_36_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_36_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_36_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_36_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_36_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_36_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_36_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_36_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_37_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_37_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_female_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_37_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_37_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_37_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_37_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_37_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_37_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_37_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_37_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_37_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_37_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_37_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_37_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_37_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_37_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_37_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_41_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_41_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_41_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_41_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_41_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_41_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_41_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_41_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_41_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_41_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_41_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_41_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_41_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_41_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_41_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_41_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_41_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_42_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_42_a",
		database = "adamant_female_c",
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
					"psyker_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_42_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_42_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_42_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_42_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_42_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_42_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_42_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_42_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_42_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_42_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_42_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_42_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_42_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_42_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_42_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_45_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_45_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_45_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_45_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_45_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_45_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_45_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_45_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_45_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_45_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_45_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_45_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_45_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_45_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_45_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_45_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_45_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_47_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_47_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_female_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_47_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_47_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_47_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_47_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_47_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_47_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_47_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_47_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_47_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_47_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_47_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_47_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_47_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_47_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_47_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_50_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_50_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_female_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_50_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_50_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_50_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_50_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_50_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_50_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_50_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_50_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_50_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_50_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_50_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_50_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_50_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_50_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_50_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_52_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_52_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_52_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_52_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_52_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_52_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_52_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_52_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_52_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_52_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_52_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_52_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_52_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_52_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_52_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_52_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_52_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_55_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_55_a",
		database = "adamant_female_c",
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
					"psyker_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_55_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_55_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_55_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_55_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_55_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_55_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_55_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_55_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_55_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_55_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_55_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_55_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_55_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_55_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_55_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_60_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_60_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"psyker_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_60_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_60_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_psyker_bonding_conversation_60_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_psyker_bonding_conversation_60_b",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_60_b",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_60_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_60_b_user",
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
		name = "adamant_female_c_psyker_bonding_conversation_60_c",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_60_c",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_60_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_60_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_psyker_bonding_conversation_60_d",
		wwise_route = 0,
		response = "adamant_female_c_psyker_bonding_conversation_60_d",
		database = "adamant_female_c",
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
					"adamant_female_c_psyker_bonding_conversation_60_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_psyker_bonding_conversation_60_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_01_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_01_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"veteran_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_01_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_veteran_bonding_conversation_01_a",
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
				"adamant_female_c_veteran_bonding_conversation_01_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_01_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_01_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_01_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_01_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_01_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_01_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_01_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_01_c_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_01_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_01_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_01_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_01_d_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_02_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_02_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"veteran_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_02_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_veteran_bonding_conversation_02_a",
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
				"adamant_female_c_veteran_bonding_conversation_02_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_02_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_02_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_02_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_02_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_02_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_02_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_02_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_02_c_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_02_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_02_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_02_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_01_d_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_03_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_03_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"veteran_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_03_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_03_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_03_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_03_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_03_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_03_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_03_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_03_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_03_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_03_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_03_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_03_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_03_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_03_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_03_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_07_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_07_a",
		database = "adamant_female_c",
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
					"veteran_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_07_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_07_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_07_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_07_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_07_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_07_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_07_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_07_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_07_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_07_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_07_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_07_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_07_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_07_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_07_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_26_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_26_a",
		database = "adamant_female_c",
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
					"veteran_male_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_26_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_26_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_26_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_26_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_26_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_26_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_26_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_26_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_26_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_26_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_26_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_26_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_26_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_26_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_26_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_33_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_33_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"veteran_female_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_33_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_33_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_33_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_33_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_33_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_33_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_33_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_33_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_33_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_33_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_33_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_33_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_33_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_33_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_33_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_37_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_37_a",
		database = "adamant_female_c",
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
					"veteran_female_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_37_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_37_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_37_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_37_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_37_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_37_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_37_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_37_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_37_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_37_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_37_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_37_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_37_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_37_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_37_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_50_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_50_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_50_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_50_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_veteran_bonding_conversation_50_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_veteran_bonding_conversation_50_b",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_50_b",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_50_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_50_b_user",
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
		name = "adamant_female_c_veteran_bonding_conversation_50_c",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_50_c",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_50_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_50_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_veteran_bonding_conversation_50_d",
		wwise_route = 0,
		response = "adamant_female_c_veteran_bonding_conversation_50_d",
		database = "adamant_female_c",
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
					"adamant_female_c_veteran_bonding_conversation_50_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_veteran_bonding_conversation_50_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_01_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_01_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_01_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_zealot_bonding_conversation_01_a",
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
				"adamant_female_c_zealot_bonding_conversation_01_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_01_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_01_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_01_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_01_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_01_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_01_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_01_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_01_c_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_01_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_01_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_01_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_01_d_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_02_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_02_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_02_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_female_c_zealot_bonding_conversation_02_a",
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
				"adamant_female_c_zealot_bonding_conversation_02_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_02_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_02_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_02_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_02_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_02_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_02_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_01_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_01_c_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_02_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_02_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_02_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_01_d_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_05_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_05_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_05_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_05_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_05_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_05_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_05_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_05_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_05_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_05_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_05_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_05_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_05_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_05_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_05_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_05_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_05_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_06_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_06_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_06_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_06_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_06_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_06_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_06_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_06_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_06_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_06_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_06_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_06_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_06_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_06_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_06_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_06_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_06_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_07_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_07_a",
		database = "adamant_female_c",
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
					"zealot_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_07_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_07_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_07_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_07_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_07_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_07_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_07_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_07_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_07_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_07_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_07_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_07_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_07_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_07_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_07_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_10_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_10_a",
		database = "adamant_female_c",
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
					"zealot_male_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_10_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_10_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_10_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_10_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_10_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_10_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_10_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_10_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_10_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_10_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_10_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_10_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_10_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_10_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_10_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_11_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_11_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_11_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_11_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_11_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_11_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_11_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_11_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_11_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_11_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_11_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_11_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_11_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_11_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_11_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_11_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_11_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_16_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_16_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_16_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_16_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_16_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_16_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_16_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_16_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_16_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_16_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_16_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_16_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_16_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_16_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_16_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_16_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_16_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_17_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_17_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_17_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_17_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_17_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_17_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_17_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_17_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_17_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_17_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_17_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_17_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_17_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_17_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_17_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_17_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_17_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_20_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_20_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_20_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_20_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_20_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_20_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_20_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_20_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_20_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_20_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_20_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_20_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_20_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_20_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_20_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_20_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_20_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_22_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_22_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_22_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_22_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_22_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_22_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_22_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_22_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_22_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_22_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_22_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_22_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_22_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_22_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_22_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_22_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_22_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_25_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_25_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_male_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_25_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_25_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_25_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_25_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_25_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_25_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_25_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_25_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_25_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_25_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_25_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_25_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_25_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_25_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_25_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_26_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_26_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_26_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_26_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_26_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_26_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_26_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_26_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_26_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_26_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_26_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_26_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_26_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_26_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_26_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_26_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_26_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_30_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_30_a",
		database = "adamant_female_c",
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
					"zealot_male_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_30_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_30_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_30_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_30_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_30_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_30_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_30_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_30_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_30_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_30_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_30_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_30_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_30_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_30_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_30_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_31_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_31_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_31_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_31_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_31_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_31_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_31_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_31_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_31_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_31_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_31_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_31_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_31_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_31_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_31_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_31_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_31_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_32_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_32_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_a"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_32_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_32_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_32_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_32_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_32_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_32_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_a"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_32_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_32_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_32_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_32_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_32_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_32_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_32_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_32_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_32_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_40_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_40_a",
		database = "adamant_female_c",
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
					"zealot_female_a"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_40_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_40_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_40_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_40_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_40_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_40_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_40_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_40_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_40_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_40_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_a"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_40_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_40_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_40_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_40_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_40_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_41_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_41_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_41_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_41_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_41_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_41_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_41_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_41_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_41_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_41_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_41_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_41_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_41_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_41_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_41_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_41_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_41_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_45_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_45_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_b"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_45_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_45_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_45_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_45_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_45_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_45_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_45_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_45_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_45_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_45_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_45_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_45_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_45_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_45_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_45_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_46_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_46_a",
		database = "adamant_female_c",
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
					"zealot_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_46_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_46_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_46_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_46_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_46_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_46_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_46_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_46_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_46_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_46_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_46_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_46_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_46_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_46_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_46_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_47_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_47_a",
		database = "adamant_female_c",
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
					"zealot_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_47_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_47_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_47_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_47_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_47_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_47_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_47_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_47_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_47_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_47_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_47_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_47_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_47_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_47_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_47_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_50_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_50_a",
		database = "adamant_female_c",
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
					"zealot_female_b"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_50_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_50_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_50_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_50_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_50_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_50_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_50_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_50_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_50_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_50_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_b"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_50_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_50_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_50_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_50_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_50_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_52_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_52_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_52_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_52_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_52_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMESET,
				"0"
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_52_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_52_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_52_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_52_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_52_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_52_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_52_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_52_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_52_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_52_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_52_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_52_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_55_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_55_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"zealot_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_55_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_55_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_55_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_55_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_55_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_55_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_55_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_55_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_55_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_55_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_55_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_55_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_55_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_55_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_55_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_56_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_56_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_56_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_56_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_56_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_56_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_56_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_56_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_56_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_56_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_56_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_56_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_56_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_56_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_56_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_56_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_56_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_57_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_57_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_57_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_57_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_57_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_57_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_57_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_57_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_57_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_57_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_57_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_57_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_57_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_57_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_57_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_57_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_57_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_60_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_60_a",
		database = "adamant_female_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_talk"
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
				"team_threat_level",
				OP.SET_INCLUDES,
				args = {
					"low"
				}
			},
			{
				"global_context",
				"level_time",
				OP.GT,
				0
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_female_c"
				}
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_60_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMEDIFF,
				OP.GT,
				220
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_60_a_user",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"adamant_female_c_zealot_bonding_conversation_60_a",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_last_conversation",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_female_c_zealot_bonding_conversation_60_b",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_60_b",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_60_a"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_60_b_user",
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
		name = "adamant_female_c_zealot_bonding_conversation_60_c",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_60_c",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_60_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"zealot_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_60_a_user",
				OP.EQ,
				1
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
		name = "adamant_female_c_zealot_bonding_conversation_60_d",
		wwise_route = 0,
		response = "adamant_female_c_zealot_bonding_conversation_60_d",
		database = "adamant_female_c",
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
					"adamant_female_c_zealot_bonding_conversation_60_c"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_female_c"
				}
			},
			{
				"user_memory",
				"adamant_female_c_zealot_bonding_conversation_60_b_user",
				OP.EQ,
				1
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_96_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_96_a",
		database = "adamant_female_c",
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
					"adamant_female_c"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"adamant_male_a"
				}
			},
			{
				"faction_memory",
				"adamant_to_adamant_bonding_conversation_96_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"time_since_last_short_conversation",
				OP.TIMEDIFF,
				OP.GT,
				120
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
				"adamant_to_adamant_bonding_conversation_96_a",
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
				"adamant_to_adamant_bonding_conversation_96_a_user",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "adamant_to_adamant_bonding_conversation_96_c",
		wwise_route = 0,
		response = "adamant_to_adamant_bonding_conversation_96_c",
		database = "adamant_female_c",
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
					"adamant_to_adamant_bonding_conversation_96_b"
				}
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"adamant_male_c"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_to_adamant_bonding_conversation_96_c_user",
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
end
