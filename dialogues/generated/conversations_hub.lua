return function ()
	define_rule({
		name = "adamant_officer_hub_greeting_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "adamant_officer_hub_greeting_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"adamant_officer_hub_greeting_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"veteran_female_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_officer"
				}
			},
			{
				"user_memory",
				"last_adamant_officer_likes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_adamant_officer_likes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "adamant_officer_hub_greeting_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "adamant_officer_hub_greeting_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"adamant_officer_hub_greeting"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a",
					"psyker_male_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_officer"
				}
			},
			{
				"user_memory",
				"adamant_officer_hub_greeting",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"adamant_officer_hub_greeting",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_distance",
		category = "npc_prio_0",
		response = "barber_distance",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_distance"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"barber"
				}
			},
			{
				"user_memory",
				"barber_goodbye",
				OP.EQ,
				0
			},
			{
				"user_memory",
				"barber_distance",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"user_memory",
				"barber_distance",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "barber_goodbye",
		category = "npc_prio_0",
		response = "barber_goodbye",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"barber"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "barber_hello",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "barber_hello",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_hello"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_intro_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "barber_intro_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_intro_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_intro_b",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "barber_intro_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_intro_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_intro_c",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "barber_intro_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_intro_c"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_intro_d",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "barber_intro_d",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_intro_d"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "barber_purchase",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "barber_purchase",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"barber_purchase"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "boon_vendor_distance_restocked_dislikes_character",
		category = "npc_prio_0",
		response = "boon_vendor_distance_restocked_dislikes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_distance_restocked_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"veteran_male_c",
					"veteran_female_c",
					"psyker_male_c",
					"psyker_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_boon_vendor_distant",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_boon_vendor_distant",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "boon_vendor_distance_restocked_likes_character",
		category = "npc_prio_0",
		response = "boon_vendor_distance_restocked_likes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_distance_restocked_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"zealot_male_b",
					"zealot_female_b",
					"ogryn_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_boon_vendor_distant",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_boon_vendor_distant",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "boon_vendor_goodbye_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "boon_vendor_goodbye_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_goodbye_dislikes_character"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "boon_vendor_goodbye_likes_character",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "boon_vendor_goodbye_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_goodbye_likes_character"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "boon_vendor_purchase",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "boon_vendor_purchase",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_purchase"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "concourse_exchange_01_b",
		wwise_route = 19,
		response = "concourse_exchange_01_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_01_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_02_b",
		wwise_route = 19,
		response = "concourse_exchange_02_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_02_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_03_b",
		wwise_route = 19,
		response = "concourse_exchange_03_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_03_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_04_b",
		wwise_route = 19,
		response = "concourse_exchange_04_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_04_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_05_b",
		wwise_route = 19,
		response = "concourse_exchange_05_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_05_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_06_b",
		wwise_route = 19,
		response = "concourse_exchange_06_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_06_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_07_b",
		wwise_route = 19,
		response = "concourse_exchange_07_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_07_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_08_b",
		wwise_route = 19,
		response = "concourse_exchange_08_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_08_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_09_b",
		wwise_route = 19,
		response = "concourse_exchange_09_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_09_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_10_b",
		wwise_route = 19,
		response = "concourse_exchange_10_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_boon_vendor_a__concourse_exchange_10_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		name = "concourse_exchange_11_b",
		wwise_route = 19,
		response = "concourse_exchange_11_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_11_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_12_b",
		wwise_route = 19,
		response = "concourse_exchange_12_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_12_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_13_b",
		wwise_route = 19,
		response = "concourse_exchange_13_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_13_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_14_b",
		wwise_route = 19,
		response = "concourse_exchange_14_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_14_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_15_b",
		wwise_route = 19,
		response = "concourse_exchange_15_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_15_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_16_b",
		wwise_route = 19,
		response = "concourse_exchange_16_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_16_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_17_b",
		wwise_route = 19,
		response = "concourse_exchange_17_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_17_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_18_b",
		wwise_route = 19,
		response = "concourse_exchange_18_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_18_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_19_b",
		wwise_route = 19,
		response = "concourse_exchange_19_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_19_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_20_b",
		wwise_route = 19,
		response = "concourse_exchange_20_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_contract_vendor_a__concourse_exchange_20_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		name = "concourse_exchange_boon_vendor",
		wwise_route = 19,
		response = "concourse_exchange_boon_vendor",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"concourse_exchange_boon_vendor"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
			},
			{
				"faction_memory",
				"concourse_exchange",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"concourse_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "concourse_exchange_contract_vendor",
		wwise_route = 19,
		response = "concourse_exchange_contract_vendor",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"concourse_exchange_contract_vendor"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			},
			{
				"faction_memory",
				"concourse_exchange",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"concourse_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "contract_vendor_distance_dislikes_character",
		wwise_route = 19,
		response = "contract_vendor_distance_dislikes_character",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_distance"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "contract_vendor_distance_likes_character",
		wwise_route = 19,
		response = "contract_vendor_distance_likes_character",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_distance"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"psyker_male_c",
					"psyker_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "contract_vendor_goodbye_dislikes_character",
		category = "npc_prio_0",
		response = "contract_vendor_goodbye_dislikes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "contract_vendor_goodbye_likes_character",
		category = "npc_prio_0",
		response = "contract_vendor_goodbye_likes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"psyker_male_c",
					"psyker_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "contract_vendor_purchase_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "contract_vendor_purchase_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_purchase_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "contract_vendor_replacing_task",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "contract_vendor_replacing_task",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_replacing_task"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "contract_vendor_servitor_purchase_b",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "contract_vendor_servitor_purchase_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_servitor_purchase_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "contract_vendor_setting_contract",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "contract_vendor_setting_contract",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_setting_contract"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "crafting_complete",
		wwise_route = 40,
		response = "crafting_complete",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"crafting_complete"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"psyker_male_c",
					"psyker_female_c",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "crafting_interact",
		wwise_route = 40,
		response = "crafting_interact",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"crafting_interact"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"psyker_male_c",
					"psyker_female_c",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "credit_store_servitor_distance_restocked",
		category = "npc_prio_0",
		response = "credit_store_servitor_distance_restocked",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_distance_restocked_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					""
				}
			},
			{
				"user_memory",
				"",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"user_memory",
				"",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_distance_restocked_b",
		category = "npc_prio_0",
		response = "credit_store_servitor_distance_restocked_b",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_distance_restocked_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"credit_store_servitor"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"credit_store_servitor_goodbye_b",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"credit_store_servitor_distance_restocked_b",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"user_memory",
				"credit_store_servitor_distance_restocked_b",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_distance_restocked_c",
		category = "npc_prio_0",
		response = "credit_store_servitor_distance_restocked_c",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_distance_restocked"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"credit_store_servitor"
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "credit_store_servitor_goodbye",
		category = "npc_prio_0",
		response = "credit_store_servitor_goodbye",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"credit_store_servitor"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"credit_store_servitor_goodbye",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_goodbye_b",
		category = "npc_prio_0",
		response = "credit_store_servitor_goodbye_b",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_goodbye_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"credit_store_servitor"
				}
			}
		},
		on_done = {
			{
				"user_memory",
				"credit_store_servitor_goodbye_b",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_hello",
		category = "npc_prio_0",
		response = "credit_store_servitor_hello",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "credit_store_servitor_hello_b",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "credit_store_servitor_hello_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_hello_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"credit_store_servitor"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "credit_store_servitor_purchase",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "credit_store_servitor_purchase",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_purchase_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_purchase_b",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "credit_store_servitor_purchase_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_purchase_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "credit_store_servitor_purchase_c",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "credit_store_servitor_purchase_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"credit_store_servitor_purchase"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "explicator_distance",
		concurrent_wwise_event = "play_vox_static_loop",
		wwise_route = 19,
		response = "explicator_distance",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"explicator_distance"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"psyker_male_c",
					"psyker_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_01_a",
		response = "hammersmith_hub_announcement_01_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_01_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_01_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_01_b",
		response = "hammersmith_hub_announcement_01_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_02_a",
		response = "hammersmith_hub_announcement_02_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_02_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_02_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_02_b",
		response = "hammersmith_hub_announcement_02_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_03_a",
		response = "hammersmith_hub_announcement_03_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_03_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_03_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_03_b",
		response = "hammersmith_hub_announcement_03_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_04_a",
		response = "hammersmith_hub_announcement_04_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_04_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_04_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_04_b",
		response = "hammersmith_hub_announcement_04_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_05_a",
		response = "hammersmith_hub_announcement_05_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_05_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_05_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_05_b",
		response = "hammersmith_hub_announcement_05_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_06_a",
		response = "hammersmith_hub_announcement_06_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_06_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_06_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_06_b",
		response = "hammersmith_hub_announcement_06_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_06_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_07_a",
		response = "hammersmith_hub_announcement_07_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_07_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_07_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_07_b",
		response = "hammersmith_hub_announcement_07_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_07_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_08_a",
		response = "hammersmith_hub_announcement_08_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_08_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_08_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_08_b",
		response = "hammersmith_hub_announcement_08_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_08_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_09_a",
		response = "hammersmith_hub_announcement_09_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_09_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_09_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_09_b",
		response = "hammersmith_hub_announcement_09_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_10_a",
		response = "hammersmith_hub_announcement_10_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_10_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_10_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_10_b",
		response = "hammersmith_hub_announcement_10_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hammersmith_hub_announcement_10_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_a",
		response = "hammersmith_hub_announcement_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"hammersmith_hub_announcement_a",
				OP.TIMEDIFF,
				OP.GT,
				240
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				100
			}
		},
		on_done = {
			{
				"faction_memory",
				"hammersmith_hub_announcement_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_a_07_b",
		response = "hammersmith_hub_announcement_a_07_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_interrogator_a__hammersmith_hub_announcement_a_07"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_a_09_b",
		response = "hammersmith_hub_announcement_a_09_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_interrogator_a__hammersmith_hub_announcement_a_09"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hammersmith_hub_announcement_a_19_b",
		response = "hammersmith_hub_announcement_a_19_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_interrogator_a__hammersmith_hub_announcement_a_19"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_01_a",
		response = "hub_announcement_waterloo_01_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			},
			{
				"faction_memory",
				"hub_announcement_waterloo_01_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_announcement_waterloo_01_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_01_b",
		response = "hub_announcement_waterloo_01_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_announcement_waterloo_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_02_a",
		response = "hub_announcement_waterloo_02_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			},
			{
				"faction_memory",
				"hub_announcement_waterloo_02_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_announcement_waterloo_02_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_02_b",
		response = "hub_announcement_waterloo_02_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_announcement_waterloo_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_02_c",
		response = "hub_announcement_waterloo_02_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_announcement_waterloo_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_02_d",
		response = "hub_announcement_waterloo_02_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_announcement_waterloo_02_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_03_a",
		response = "hub_announcement_waterloo_03_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			},
			{
				"faction_memory",
				"hub_announcement_waterloo_03_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_announcement_waterloo_03_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_announcement_waterloo_03_b",
		response = "hub_announcement_waterloo_03_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_announcement_waterloo_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
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
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_flight_deck_announcement",
		response = "hub_flight_deck_announcement",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_servitor_a"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				329
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_greeting_commissar_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_commissar_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_first_interaction_commissar_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_first_interaction_commissar_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_first_interaction_commissar_b",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_first_interaction_commissar_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_first_interaction_commissar_c",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_first_interaction_commissar_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_first_interaction_commissar_d",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_first_interaction_commissar_d",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "hub_greeting_live_event_21st_01_a",
		pre_wwise_event = "play_radio_static_start",
		response = "hub_greeting_live_event_21st_01_a",
		database = "conversations_hub",
		wwise_route = 40,
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_greeting_live_event_21st_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_greeting_mission_failure_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_mission_failure_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_mission_success_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_mission_success_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_greeting_reward_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_greeting_reward_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_hadron_servitor_idle_mutter_a",
		wwise_route = 19,
		response = "hub_hadron_servitor_idle_mutter_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_hadron_servitor_idle_mutter_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_hadron_servitor"
				}
			},
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "hub_hadron_servitor_idle_mutter_b",
		wwise_route = 19,
		response = "hub_hadron_servitor_idle_mutter_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
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
					"hub_hadron_servitor_idle_mutter_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			},
			random_ignore_vo = {
				chance = 0.7,
				max_failed_tries = 0,
				hold_for = 0
			}
		}
	})
	define_rule({
		name = "hub_hadron_servitor_idle_mutter_c",
		wwise_route = 19,
		response = "hub_hadron_servitor_idle_mutter_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
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
					"hub_hadron_servitor_idle_mutter_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_hadron_servitor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_horde_greeting_agnostic_a",
		category = "npc_prio_0",
		wwise_route = 42,
		response = "hub_horde_greeting_agnostic_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_horde_greeting_first_a",
		category = "npc_prio_0",
		wwise_route = 42,
		response = "hub_horde_greeting_first_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_horde_greeting_first_b",
		category = "npc_prio_0",
		wwise_route = 42,
		response = "hub_horde_greeting_first_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_horde_greeting_first_c",
		category = "npc_prio_0",
		wwise_route = 42,
		response = "hub_horde_greeting_first_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_idle",
		wwise_route = 19,
		response = "hub_idle",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_idle"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"psyker_male_c",
					"psyker_female_c",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"user_memory",
				"last_contract_vendor_distant",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_eighteen_a",
		response = "hub_idle_2nd_phase_conversation_eighteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_eighteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_eighteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_eighteen_b",
		response = "hub_idle_2nd_phase_conversation_eighteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_eighteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_eleven_a",
		response = "hub_idle_2nd_phase_conversation_eleven_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_eleven_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_eleven_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_eleven_b",
		response = "hub_idle_2nd_phase_conversation_eleven_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_eleven_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fifteen_a",
		response = "hub_idle_2nd_phase_conversation_fifteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fifteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fifteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fifteen_b",
		response = "hub_idle_2nd_phase_conversation_fifteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_fifteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_forty_one_a",
		response = "hub_idle_2nd_phase_conversation_forty_one_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_forty_one_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_forty_one_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_forty_one_b",
		response = "hub_idle_2nd_phase_conversation_forty_one_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_forty_one_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fortytwo_a",
		response = "hub_idle_2nd_phase_conversation_fortytwo_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fortytwo_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fortytwo_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fortytwo_b",
		response = "hub_idle_2nd_phase_conversation_fortytwo_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_fortytwo_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fortytwo_c",
		response = "hub_idle_2nd_phase_conversation_fortytwo_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_fortytwo_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_four_a",
		response = "hub_idle_2nd_phase_conversation_four_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_four_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_four_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_four_b",
		response = "hub_idle_2nd_phase_conversation_four_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_four_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fourteen_a",
		response = "hub_idle_2nd_phase_conversation_fourteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fourteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_fourteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_fourteen_b",
		response = "hub_idle_2nd_phase_conversation_fourteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_fourteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_nineteen_a",
		response = "hub_idle_2nd_phase_conversation_nineteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_nineteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_nineteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_nineteen_b",
		response = "hub_idle_2nd_phase_conversation_nineteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_nineteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_one_a",
		response = "hub_idle_2nd_phase_conversation_one_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_one_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_one_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_one_b",
		response = "hub_idle_2nd_phase_conversation_one_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_one_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_seven_a",
		response = "hub_idle_2nd_phase_conversation_seven_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_seven_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_seven_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_seven_b",
		response = "hub_idle_2nd_phase_conversation_seven_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_seven_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_seven_c",
		response = "hub_idle_2nd_phase_conversation_seven_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_seven_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_seventeen_a",
		response = "hub_idle_2nd_phase_conversation_seventeen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_seventeen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_seventeen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_seventeen_b",
		response = "hub_idle_2nd_phase_conversation_seventeen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_seventeen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_six_a",
		response = "hub_idle_2nd_phase_conversation_six_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_six_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_six_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_six_b",
		response = "hub_idle_2nd_phase_conversation_six_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_six_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_six_c",
		response = "hub_idle_2nd_phase_conversation_six_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_six_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_sixteen_a",
		response = "hub_idle_2nd_phase_conversation_sixteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_sixteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_sixteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_sixteen_b",
		response = "hub_idle_2nd_phase_conversation_sixteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_sixteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_ten_a",
		response = "hub_idle_2nd_phase_conversation_ten_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_ten_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_ten_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_ten_b",
		response = "hub_idle_2nd_phase_conversation_ten_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_ten_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirteen_a",
		response = "hub_idle_2nd_phase_conversation_thirteen_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirteen_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirteen_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirteen_b",
		response = "hub_idle_2nd_phase_conversation_thirteen_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirteen_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirty_a",
		response = "hub_idle_2nd_phase_conversation_thirty_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirty_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirty_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirty_b",
		response = "hub_idle_2nd_phase_conversation_thirty_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirty_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyeight_a",
		response = "hub_idle_2nd_phase_conversation_thirtyeight_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyeight_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyeight_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyeight_b",
		response = "hub_idle_2nd_phase_conversation_thirtyeight_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyeight_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyfive_a",
		response = "hub_idle_2nd_phase_conversation_thirtyfive_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyfive_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyfive_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyfive_b",
		response = "hub_idle_2nd_phase_conversation_thirtyfive_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyfive_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		pre_wwise_event = "play_radio_static_start",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "hub_idle_2nd_phase_conversation_thirtyfour_a",
		post_wwise_event = "play_radio_static_end",
		response = "hub_idle_2nd_phase_conversation_thirtyfour_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyfour_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyfour_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyfour_b",
		response = "hub_idle_2nd_phase_conversation_thirtyfour_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyfour_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtynine_a",
		response = "hub_idle_2nd_phase_conversation_thirtynine_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtynine_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtynine_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtynine_b",
		response = "hub_idle_2nd_phase_conversation_thirtynine_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtynine_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyone_a",
		response = "hub_idle_2nd_phase_conversation_thirtyone_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyone_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyone_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyone_b",
		response = "hub_idle_2nd_phase_conversation_thirtyone_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyone_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyone_c",
		response = "hub_idle_2nd_phase_conversation_thirtyone_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyone_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyseven_a",
		response = "hub_idle_2nd_phase_conversation_thirtyseven_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyseven_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtyseven_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtyseven_b",
		response = "hub_idle_2nd_phase_conversation_thirtyseven_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtyseven_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtysix_a",
		response = "hub_idle_2nd_phase_conversation_thirtysix_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtysix_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtysix_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtysix_b",
		response = "hub_idle_2nd_phase_conversation_thirtysix_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtysix_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtythree_a",
		response = "hub_idle_2nd_phase_conversation_thirtythree_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtythree_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtythree_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtythree_b",
		response = "hub_idle_2nd_phase_conversation_thirtythree_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtythree_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtytwo_a",
		response = "hub_idle_2nd_phase_conversation_thirtytwo_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtytwo_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_thirtytwo_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_thirtytwo_b",
		response = "hub_idle_2nd_phase_conversation_thirtytwo_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_thirtytwo_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_three_a",
		response = "hub_idle_2nd_phase_conversation_three_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_three_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_three_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_three_b",
		response = "hub_idle_2nd_phase_conversation_three_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_three_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twelve_a",
		response = "hub_idle_2nd_phase_conversation_twelve_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twelve_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twelve_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twelve_b",
		response = "hub_idle_2nd_phase_conversation_twelve_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twelve_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twenty_a",
		response = "hub_idle_2nd_phase_conversation_twenty_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twenty_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twenty_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twenty_b",
		response = "hub_idle_2nd_phase_conversation_twenty_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twenty_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyeight_a",
		response = "hub_idle_2nd_phase_conversation_twentyeight_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyseven_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyseven_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyeight_b",
		response = "hub_idle_2nd_phase_conversation_twentyeight_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentyeight_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyfive_a",
		response = "hub_idle_2nd_phase_conversation_twentyfive_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyfive_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyfive_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyfive_b",
		response = "hub_idle_2nd_phase_conversation_twentyfive_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentyfive_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyfour_a",
		response = "hub_idle_2nd_phase_conversation_twentyfour_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyfour_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyfour_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyfour_b",
		response = "hub_idle_2nd_phase_conversation_twentyfour_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentyfour_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentynine_a",
		response = "hub_idle_2nd_phase_conversation_twentynine_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentynine_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentynine_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentynine_b",
		response = "hub_idle_2nd_phase_conversation_twentynine_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentynine_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentynine_c",
		response = "hub_idle_2nd_phase_conversation_twentynine_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentynine_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyone_a",
		response = "hub_idle_2nd_phase_conversation_twentyone_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyone_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyone_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyone_b",
		response = "hub_idle_2nd_phase_conversation_twentyone_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentyone_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyseven_a",
		response = "hub_idle_2nd_phase_conversation_twentyseven_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyseven_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentyseven_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentyseven_b",
		response = "hub_idle_2nd_phase_conversation_twentyseven_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentyseven_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentysix_a",
		response = "hub_idle_2nd_phase_conversation_twentysix_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentysix_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentysix_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentysix_b",
		response = "hub_idle_2nd_phase_conversation_twentysix_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentysix_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentysixa_a",
		response = "hub_idle_2nd_phase_conversation_twentysixa_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentysixa_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentysixa_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentysixa_b",
		response = "hub_idle_2nd_phase_conversation_twentysixa_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentysixa_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentythree_a",
		response = "hub_idle_2nd_phase_conversation_twentythree_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentythree_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentythree_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentythree_b",
		response = "hub_idle_2nd_phase_conversation_twentythree_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentythree_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentythree_c",
		response = "hub_idle_2nd_phase_conversation_twentythree_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentythree_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentytwo_a",
		response = "hub_idle_2nd_phase_conversation_twentytwo_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentytwo_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_twentytwo_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_twentytwo_b",
		response = "hub_idle_2nd_phase_conversation_twentytwo_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_twentytwo_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_two_a",
		response = "hub_idle_2nd_phase_conversation_two_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_two_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_idle_2nd_phase_conversation_two_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_idle_2nd_phase_conversation_two_b",
		response = "hub_idle_2nd_phase_conversation_two_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_idle_2nd_phase_conversation_two_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		name = "hub_idle_crafting",
		wwise_route = 19,
		response = "hub_idle_crafting",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_idle_crafting"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"psyker_male_c",
					"psyker_female_c",
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_idle_greeting_dislike_a",
		wwise_route = 19,
		response = "hub_idle_greeting_dislike_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_idle_greeting_crew"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"query_context",
				"player_level_string",
				OP.SET_INCLUDES,
				args = {
					"2",
					"3",
					"4",
					"5",
					"6",
					"7",
					"8",
					"9",
					"10",
					"11"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_idle_greeting_like_a",
		wwise_route = 19,
		response = "hub_idle_greeting_like_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_idle_greeting_crew"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"query_context",
				"player_level_string",
				OP.SET_INCLUDES,
				args = {
					"26",
					"27",
					"28",
					"29",
					"30"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_idle_greeting_neutral_a",
		wwise_route = 19,
		response = "hub_idle_greeting_neutral_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_idle_greeting_crew"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"query_context",
				"player_level_string",
				OP.SET_INCLUDES,
				args = {
					"12",
					"13",
					"14",
					"15",
					"16",
					"17",
					"18",
					"19",
					"20",
					"21",
					"22",
					"23",
					"24",
					"25"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_idle_oath_01_b",
		wwise_route = 19,
		response = "hub_idle_oath_01_b",
		database = "conversations_hub",
		category = "chorus_vo_prio_1",
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
					"shipmistress_hub_announcement_a_61_b"
				}
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
		pre_wwise_event = "play_radio_static_start",
		name = "hub_initial_greeting_live_event_21st_01_a",
		wwise_route = 40,
		response = "hub_initial_greeting_live_event_21st_01_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_initial_greeting_live_event_21st_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "hub_initial_greeting_live_event_21st_01_b",
		wwise_route = 40,
		response = "hub_initial_greeting_live_event_21st_01_b",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_initial_greeting_live_event_21st_01_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_interact_boon_vendor_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_boon_vendor_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"psyker_female_a",
					"psyker_male_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
			},
			{
				"user_memory",
				"last_boon_vendor_dislikes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_boon_vendor_dislikes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_boon_vendor_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_boon_vendor_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"boon_vendor_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"veteran_female_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"boon_vendor"
				}
			},
			{
				"user_memory",
				"last_boon_vendor_likes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_boon_vendor_likes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_boon_vendor_rumour_politics_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_boon_vendor_rumour_politics_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_interact_rumour_politics_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_contract_vendor_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_contract_vendor_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_interaction"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			},
			{
				"user_memory",
				"last_contract_vendor_dislikes_character",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_contract_vendor_dislikes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_contract_vendor_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_contract_vendor_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"contract_vendor_interaction"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			},
			{
				"user_memory",
				"last_contract_vendor_likes_character",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_contract_vendor_likes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_explicator_likes_character",
		category = "npc_prio_0",
		response = "hub_interact_explicator_likes_character",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_interact_explicator_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_interact_penance_greeting_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_penance_greeting_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_interact_penance_greeting_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_purser_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_purser_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_interact_purser_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"user_memory",
				"last_purser_dislikes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_purser_dislikes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_purser_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_purser_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_interact_purser_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_interact_shipmistress_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_shipmistress_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"shipmistress_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"low_level"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			},
			{
				"user_memory",
				"last_shipmistress_dislikes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_shipmistress_dislikes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_shipmistress_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_shipmistress_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"shipmistress_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"high_level"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			},
			{
				"user_memory",
				"last_shipmistress_likes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_shipmistress_likes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_training_ground_psyker_dislikes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_training_ground_psyker_dislikes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"training_ground_psyker_dislikes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_female_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
			},
			{
				"user_memory",
				"last_training_ground_psyker_dislikes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_training_ground_psyker_dislikes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_interact_training_ground_psyker_likes_character",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_interact_training_ground_psyker_likes_character",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"training_ground_psyker_likes_character"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
			},
			{
				"user_memory",
				"last_training_ground_psyker_likes_character",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_training_ground_psyker_likes_character",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "hub_map_table_call_and_response_01_b",
		wwise_route = 19,
		response = "hub_map_table_call_and_response_01_b",
		database = "conversations_hub",
		category = "chorus_vo_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_call_and_response_01_a_01"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_call_and_response_01_c",
		wwise_route = 19,
		response = "hub_map_table_call_and_response_01_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_call_and_response_01_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_call_and_response_02_b",
		wwise_route = 19,
		response = "hub_map_table_call_and_response_02_b",
		database = "conversations_hub",
		category = "chorus_vo_prio_1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_call_and_response_02_a_01"
				}
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
		name = "hub_map_table_conversation_01_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_01_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_01_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_01_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_01_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_01_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_01_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_01_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_01_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_02_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_02_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_02_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_02_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_02_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_02_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_conversation_03_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_03_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_03_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_03_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_03_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_03_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_03_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_03_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_03_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_04_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_04_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_04_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_04_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_04_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_04_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_conversation_05_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_05_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_05_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_05_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_05_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_05_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_conversation_06_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_06_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_06_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_06_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_06_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_commissar_a__hub_map_table_conversation_06_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_06_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_06_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_officer_male_a__hub_map_table_conversation_06_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_conversation_07_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_07_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_07_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_08_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_08_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_08_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_08_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_08_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_08_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_08_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_08_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_08_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_08_e",
		wwise_route = 19,
		response = "hub_map_table_conversation_08_e",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_08_d_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		name = "hub_map_table_conversation_09_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_09_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_09_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_09_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_09_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_09_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_09_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_09_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_09_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_10_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_10_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_10_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_10_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_10_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_10_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_10_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_10_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_10_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_11_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_11_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_11_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_11_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_11_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_11_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_11_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_11_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_11_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_12_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_12_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_12_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_12_c",
		wwise_route = 19,
		response = "hub_map_table_conversation_12_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_a__hub_map_table_conversation_12_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "hub_map_table_conversation_12_d",
		wwise_route = 19,
		response = "hub_map_table_conversation_12_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_steelhead_b__hub_map_table_conversation_12_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "hub_map_table_conversation_commissar",
		wwise_route = 19,
		response = "hub_map_table_conversation_commissar",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_map_table_conversation_commissar"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "hub_map_table_conversation_officer",
		wwise_route = 19,
		response = "hub_map_table_conversation_officer",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_map_table_conversation_officer"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "hub_map_table_conversation_steelhead_a",
		wwise_route = 19,
		response = "hub_map_table_conversation_steelhead_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_map_table_conversation_steelhead_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "hub_map_table_conversation_steelhead_b",
		wwise_route = 19,
		response = "hub_map_table_conversation_steelhead_b",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_map_table_conversation_steelhead_b"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_map_table_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "hub_mindwipe_backstory_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_backstory_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_backstory_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_mindwipe_body_type_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_body_type_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_body_type_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_mindwipe_conclusion_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_conclusion_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_conclusion_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_mindwipe_frequent_customer_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_frequent_customer_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_frequent_customer_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_mindwipe_personality_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_personality_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_personality_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "hub_mindwipe_select_option_a",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "hub_mindwipe_select_option_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_mindwipe_select_option_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_carnival_a",
		response = "hub_mission_board_announcement_carnival_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_raid",
					"fm_armoury"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_carnival_circumstance_a",
		response = "hub_mission_board_announcement_carnival_circumstance_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_raid",
					"fm_armoury"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_core_a",
		response = "hub_mission_board_announcement_core_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"core_research"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_core_circumstance_a",
		response = "hub_mission_board_announcement_core_circumstance_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"core_research"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_dust",
		response = "hub_mission_board_announcement_dust",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"dm_propaganda",
					"hm_strain",
					"lm_scavenge"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_dust_circumstance",
		response = "hub_mission_board_announcement_dust_circumstance",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"dm_propaganda",
					"hm_strain",
					"lm_scavenge"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_tank_foundry",
		response = "hub_mission_board_announcement_tank_foundry",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"dm_forge",
					"fm_cargo",
					"lm_cooling"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_tank_foundry_circumstance",
		response = "hub_mission_board_announcement_tank_foundry_circumstance",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"dm_forge",
					"fm_cargo",
					"lm_cooling"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_throneside_a",
		response = "hub_mission_board_announcement_throneside_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_archives",
					"fm_resurgence",
					"hm_complex"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_throneside_circumstance_a",
		response = "hub_mission_board_announcement_throneside_circumstance_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_archives",
					"fm_resurgence",
					"hm_complex"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_transit",
		response = "hub_mission_board_announcement_transit",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_habs",
					"km_station",
					"lm_rails"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_transit_circumstance",
		response = "hub_mission_board_announcement_transit_circumstance",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"cm_habs",
					"km_station",
					"lm_rails"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_watertown",
		response = "hub_mission_board_announcement_watertown",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"km_enforcer",
					"dm_stockpile",
					"hm_cartel"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"false"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_mission_board_announcement_watertown_circumstance",
		response = "hub_mission_board_announcement_watertown_circumstance",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_update_vo"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"mission_update"
			},
			{
				"query_context",
				"mission",
				OP.SET_INCLUDES,
				args = {
					"km_enforcer",
					"dm_stockpile",
					"hm_cartel"
				}
			},
			{
				"query_context",
				"is_circumstance",
				OP.EQ,
				"true"
			},
			{
				"query_context",
				"class_name",
				OP.EQ,
				"mourningstar_servitor"
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMESET
			},
			{
				"user_memory",
				"last_mission_update_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_news_announcement",
		response = "hub_news_announcement",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_servitor_c"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				329
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "hub_onboarding_03_a",
		wwise_route = 1,
		response = "hub_onboarding_03_a",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_info"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"hub_onboarding_03_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_officer"
				}
			},
			{
				"faction_memory",
				"prologue_hub_mourningstar_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"prologue_hub_mourningstar_intro",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "hub_onboarding_03_b",
		wwise_route = 1,
		response = "hub_onboarding_03_b",
		database = "conversations_hub",
		category = "vox_prio_0",
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
					"hub_onboarding_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"adamant_officer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_propaganda_announcement",
		response = "hub_propaganda_announcement",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"vocator_b"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				229
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "hub_rumour_barber_idle",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "hub_rumour_barber_idle",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_rumour_barber_idle"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"barber"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "hub_rumour_farewell_a_barber",
		category = "npc_prio_0",
		response = "hub_rumour_farewell_a_barber",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_rumour_farewell_a_barber"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"barber"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_01_a",
		response = "hub_rumours_vox_01_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_01_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_01_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_01_b",
		response = "hub_rumours_vox_01_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_02_a",
		response = "hub_rumours_vox_02_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_02_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_02_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_02_b",
		response = "hub_rumours_vox_02_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_02_c",
		response = "hub_rumours_vox_02_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_03_a",
		response = "hub_rumours_vox_03_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_03_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_03_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_03_b",
		response = "hub_rumours_vox_03_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_03_c",
		response = "hub_rumours_vox_03_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_03_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_04_a",
		response = "hub_rumours_vox_04_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_04_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_04_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_04_b",
		response = "hub_rumours_vox_04_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_05_a",
		response = "hub_rumours_vox_05_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_05_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_05_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_05_b",
		response = "hub_rumours_vox_05_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_06_a",
		response = "hub_rumours_vox_06_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_06_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_06_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_06_b",
		response = "hub_rumours_vox_06_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_06_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_07_a",
		response = "hub_rumours_vox_07_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_07_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_07_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_07_b",
		response = "hub_rumours_vox_07_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_07_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_07_c",
		response = "hub_rumours_vox_07_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_07_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_07_d",
		response = "hub_rumours_vox_07_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_07_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_08_a",
		response = "hub_rumours_vox_08_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_08_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_08_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_08_b",
		response = "hub_rumours_vox_08_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_08_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_09_a",
		response = "hub_rumours_vox_09_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_09_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_09_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_09_b",
		response = "hub_rumours_vox_09_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_10_a",
		response = "hub_rumours_vox_10_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_giver_conversation_starter"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			},
			{
				"faction_memory",
				"hub_rumours_vox_10_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"hub_rumours_vox_10_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_10_b",
		response = "hub_rumours_vox_10_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_10_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_10_c",
		response = "hub_rumours_vox_10_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_10_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "hub_rumours_vox_10_d",
		response = "hub_rumours_vox_10_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"hub_rumours_vox_10_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"contract_vendor"
				}
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
		post_wwise_event = "play_radio_static_end",
		name = "hub_seasonal_juno_a",
		pre_wwise_event = "play_radio_static_start",
		response = "hub_seasonal_juno_a",
		database = "conversations_hub",
		wwise_route = 40,
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_seasonal_juno_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "hub_seasonal_kalyx_mid_a",
		pre_wwise_event = "play_radio_static_start",
		response = "hub_seasonal_kalyx_mid_a",
		database = "conversations_hub",
		wwise_route = 40,
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_seasonal_kalyx_mid_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "hub_seasonal_kalyx_start_a",
		pre_wwise_event = "play_radio_static_start",
		response = "hub_seasonal_kalyx_start_a",
		database = "conversations_hub",
		wwise_route = 40,
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"hub_seasonal_kalyx_start_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "hub_status_announcement",
		response = "hub_status_announcement",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_servitor_b"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				329
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "may_hub_announcement",
		response = "may_hub_announcement",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"sergeant_a"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				229
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "all_including_self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_04_a",
		response = "may_hub_conversation_04_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_04_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_04_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_04_b",
		response = "may_hub_conversation_04_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_05_a",
		response = "may_hub_conversation_05_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_05_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_05_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_05_b",
		response = "may_hub_conversation_05_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_05_c",
		response = "may_hub_conversation_05_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_05_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_09_a",
		response = "may_hub_conversation_09_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_09_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_09_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_09_b",
		response = "may_hub_conversation_09_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_12_a",
		response = "may_hub_conversation_12_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_12_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_12_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_12_b",
		response = "may_hub_conversation_12_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_12_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_13_a",
		response = "may_hub_conversation_13_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_13_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_13_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_13_b",
		response = "may_hub_conversation_13_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_13_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_13_c",
		response = "may_hub_conversation_13_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_13_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_14_a",
		response = "may_hub_conversation_14_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_14_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_14_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_14_b",
		response = "may_hub_conversation_14_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_14_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_16_a",
		response = "may_hub_conversation_16_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_16_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_16_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_16_b",
		response = "may_hub_conversation_16_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_16_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_17_a",
		response = "may_hub_conversation_17_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_17_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_17_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_17_b",
		response = "may_hub_conversation_17_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_17_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_17_c",
		response = "may_hub_conversation_17_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_17_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_18_a",
		response = "may_hub_conversation_18_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"may_hub_conversation_18_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"may_hub_conversation_18_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "may_hub_conversation_18_b",
		response = "may_hub_conversation_18_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"may_hub_conversation_18_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "mourningstar_announcement_a",
		response = "mourningstar_announcement_a",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_confessor_a",
					"mourningstar_wing_commander_a"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				229
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "npc_first_interaction_boon_vendor",
		category = "conversations_prio_1",
		wwise_route = 19,
		response = "npc_first_interaction_boon_vendor",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"environmental_story"
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"query_context",
				"story_name",
				OP.EQ,
				""
			},
			{
				"faction_memory",
				"",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_contract_vendor_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_contract_vendor_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_contract_vendor_b",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_contract_vendor_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_contract_vendor_c",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_contract_vendor_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_contract_vendor_d",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_contract_vendor_d",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_contract_vendor_e",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_contract_vendor_e",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_purser_a",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_purser_a",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"npc_first_interaction_purser_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_purser_b",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_purser_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"npc_first_interaction_purser_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_purser_c",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_purser_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"npc_first_interaction_purser_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_purser_d",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_purser_d",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"npc_first_interaction_purser_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_purser_e",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_purser_e",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"npc_first_interaction_purser_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "npc_first_interaction_shipmistress",
		category = "npc_prio_0",
		wwise_route = 19,
		response = "npc_first_interaction_shipmistress",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_01_b",
		wwise_route = 19,
		response = "oval_hub_conversation_01_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_tech_priest_a__oval_hub_conversation_01_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
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
		name = "oval_hub_conversation_02_b",
		wwise_route = 19,
		response = "oval_hub_conversation_02_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_travelling_salesman_a__oval_hub_conversation_02_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		name = "oval_hub_conversation_03_b",
		wwise_route = 19,
		response = "oval_hub_conversation_03_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_travelling_salesman_a__oval_hub_conversation_03_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		name = "oval_hub_conversation_04_b",
		wwise_route = 19,
		response = "oval_hub_conversation_04_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_tech_priest_a__oval_hub_conversation_04_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
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
		name = "oval_hub_conversation_05_b",
		wwise_route = 19,
		response = "oval_hub_conversation_05_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_tech_priest_a__oval_hub_conversation_05_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
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
		name = "oval_hub_conversation_21_b",
		wwise_route = 19,
		response = "oval_hub_conversation_21_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_travelling_salesman_a__oval_hub_conversation_21_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_21_c",
		wwise_route = 19,
		response = "oval_hub_conversation_21_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_f__oval_hub_conversation_21_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_22_b",
		wwise_route = 19,
		response = "oval_hub_conversation_22_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_g__oval_hub_conversation_22_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_22_c",
		wwise_route = 19,
		response = "oval_hub_conversation_22_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_travelling_salesman_a__oval_hub_conversation_23_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_24_b",
		wwise_route = 19,
		response = "oval_hub_conversation_24_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_travelling_salesman_a__oval_hub_conversation_24_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_24_c",
		wwise_route = 19,
		response = "oval_hub_conversation_24_c",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_f__oval_hub_conversation_24_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_24_d",
		wwise_route = 19,
		response = "oval_hub_conversation_24_d",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_g__oval_hub_conversation_25_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "visible_npcs"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "oval_hub_conversation_hadron",
		wwise_route = 19,
		response = "oval_hub_conversation_hadron",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_conversation_hadron"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "oval_hub_conversation_swagger",
		wwise_route = 19,
		response = "oval_hub_conversation_swagger",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_conversation_swagger"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"travelling_salesman"
				}
			},
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "oval_hub_soldier_exchange_01_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_01_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_b__oval_hub_soldier_exchange_01_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_02_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_02_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_e__oval_hub_soldier_exchange_02_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_03_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_03_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_e__oval_hub_soldier_exchange_03_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_04_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_04_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_b__oval_hub_soldier_exchange_04_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_05_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_05_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_b__oval_hub_soldier_exchange_05_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_06_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_06_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_f__oval_hub_soldier_exchange_06_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_07_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_07_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_g__oval_hub_soldier_exchange_07_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_08_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_08_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_f__oval_hub_soldier_exchange_08_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_09_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_09_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_g__oval_hub_soldier_exchange_09_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_10_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_10_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_mourningstar_soldier_male_f__oval_hub_soldier_exchange_10_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
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
		name = "oval_hub_soldier_exchange_male_b",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_male_b",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_soldier_exchange_male_b"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"exchange_male_b_male_e",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"exchange_male_b_male_e",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "oval_hub_soldier_exchange_male_e",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_male_e",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_soldier_exchange_male_e"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"exchange_male_b_male_e",
				OP.TIMEDIFF,
				OP.GT,
				180
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"exchange_male_b_male_e",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "oval_hub_soldier_exchange_male_f",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_male_f",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_soldier_exchange_male_f"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "oval_hub_soldier_exchange_male_g",
		wwise_route = 19,
		response = "oval_hub_soldier_exchange_male_g",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "all"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"oval_hub_soldier_exchange_male_g"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"mourningstar_soldier"
				}
			},
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMEDIFF,
				OP.GT,
				120
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				12
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				25
			}
		},
		on_done = {
			{
				"faction_memory",
				"crafting_exchange",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "visible_npcs"
		}
	})
	define_rule({
		name = "pilot_distance",
		concurrent_wwise_event = "play_vox_static_loop",
		category = "npc_prio_0",
		response = "pilot_distance",
		database = "conversations_hub",
		wwise_route = 1,
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"pilot_distance"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "prologue_hub_go_mission_board_a",
		wwise_route = 1,
		response = "prologue_hub_go_mission_board_a",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"mission_info"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"prologue_hub_go_mission_board_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 2
			}
		}
	})
	define_rule({
		concurrent_wwise_event = "play_vox_static_loop",
		wwise_route = 1,
		name = "prologue_hub_go_mission_board_b",
		response = "prologue_hub_go_mission_board_b",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"prologue_hub_go_mission_board_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_male_a",
					"psyker_female_b",
					"psyker_male_b",
					"psyker_female_c",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_male_a",
					"veteran_female_b",
					"veteran_male_b",
					"veteran_female_c",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_male_a",
					"zealot_female_b",
					"zealot_male_b",
					"zealot_female_c",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "prologue_hub_go_mission_board_c",
		wwise_route = 1,
		response = "prologue_hub_go_mission_board_c",
		database = "conversations_hub",
		category = "npc_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"prologue_hub_go_mission_board_c"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_male_a",
					"psyker_female_b",
					"psyker_male_b",
					"psyker_female_c",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_male_a",
					"veteran_female_b",
					"veteran_male_b",
					"veteran_female_c",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_male_a",
					"zealot_female_b",
					"zealot_male_b",
					"zealot_female_c",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "purser_goodbye_dislikes_character",
		category = "npc_prio_0",
		response = "purser_goodbye_dislikes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"purser_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"veteran_male_a",
					"veteran_female_a",
					"zealot_male_a",
					"zealot_female_a",
					"psyker_male_a",
					"psyker_female_a",
					"ogryn_c",
					"veteran_male_c",
					"veteran_female_c",
					"zealot_male_c",
					"zealot_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "purser_goodbye_likes_character",
		category = "npc_prio_0",
		response = "purser_goodbye_likes_character",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"purser_goodbye"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"veteran_male_b",
					"veteran_female_b",
					"zealot_male_b",
					"zealot_female_b",
					"psyker_male_b",
					"psyker_female_b",
					"psyker_male_c",
					"psyker_female_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "purser_purchase",
		category = "npc_prio_0",
		wwise_route = 40,
		response = "purser_purchase",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"purser_purchase"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"global_context",
				"player_voice_profiles",
				OP.SET_INTERSECTS,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_memory",
				"last_t",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"user_memory",
				"last_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "reject_npc_goodbye_a",
		category = "npc_prio_0",
		response = "reject_npc_goodbye_a",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "reject_npc_hub_interact_a",
		category = "npc_prio_0",
		response = "reject_npc_hub_interact_a",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "reject_npc_purchase_a",
		category = "npc_prio_0",
		response = "reject_npc_purchase_a",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				""
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_01_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_01_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_01_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_01_c",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_01_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_01_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_02_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_02_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_02_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_03_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_03_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_03_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_04_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_04_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_04_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_05_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_05_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_05_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_06_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_06_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_06_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_07_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_07_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_07_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_09_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_09_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_09_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_16_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_16_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_16_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_17_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_17_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_17_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_20_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_20_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_20_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_20_c",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_20_c",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_20_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_32_b",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_32_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_32_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_a_33_b",
		response = "shipmistress_hub_announcement_a_33_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_33_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_35_b",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_35_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_35_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_37_b",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_37_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_37_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_48_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_48_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_48_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_50_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_50_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_50_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_52_b",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_52_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_52_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_a_55_b",
		category = "conversations_prio_0",
		wwise_route = 22,
		response = "shipmistress_hub_announcement_a_55_b",
		database = "conversations_hub",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_55_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"vocator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_a_55_c",
		response = "shipmistress_hub_announcement_a_55_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_55_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
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
		concurrent_wwise_event = "play_vox_static_loop",
		wwise_route = 1,
		name = "shipmistress_hub_announcement_a_56_b",
		response = "shipmistress_hub_announcement_a_56_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_56_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_56_c",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_56_c",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_56_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "shipmistress_hub_announcement_a_60_b",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_a_60_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_60_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_a_61_b",
		response = "shipmistress_hub_announcement_a_61_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_61_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "all"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "shipmistress_hub_announcement_b_25_b",
		pre_wwise_event = "play_radio_static_start",
		wwise_route = 1,
		response = "shipmistress_hub_announcement_b_25_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_25_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_b_26_b",
		response = "shipmistress_hub_announcement_b_26_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_26_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"explicator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_b_27_b",
		response = "shipmistress_hub_announcement_b_27_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_27_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_b_28_b",
		response = "shipmistress_hub_announcement_b_28_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_28_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"pilot"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_b_29_b",
		response = "shipmistress_hub_announcement_b_29_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_29_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_b_30_b",
		response = "shipmistress_hub_announcement_b_30_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_30_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_b_44_b",
		wwise_route = 42,
		response = "shipmistress_hub_announcement_b_44_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_44_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
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
		name = "shipmistress_hub_announcement_b_45_b",
		wwise_route = 42,
		response = "shipmistress_hub_announcement_b_45_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_45_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
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
		name = "shipmistress_hub_announcement_b_46_b",
		wwise_route = 42,
		response = "shipmistress_hub_announcement_b_46_b",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_46_a_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_b_50_b",
		wwise_route = 0,
		response = "shipmistress_hub_announcement_b_50_b",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_a_50_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"ogryn"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.3
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_c_28_c",
		response = "shipmistress_hub_announcement_c_28_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_pilot_a__shipmistress_hub_announcement_b_28_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_c_30_c",
		response = "shipmistress_hub_announcement_c_30_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_purser_a__shipmistress_hub_announcement_b_30_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_c_46_c",
		response = "shipmistress_hub_announcement_c_46_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_training_ground_psyker_a__shipmistress_hub_announcement_b_46_b_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_d_30_d",
		response = "shipmistress_hub_announcement_d_30_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_c_30_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"purser"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		name = "shipmistress_hub_announcement_d_46_d",
		wwise_route = 42,
		response = "shipmistress_hub_announcement_d_46_d",
		database = "conversations_hub",
		category = "vox_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.SET_INCLUDES,
				args = {
					"loc_shipmistress_a__shipmistress_hub_announcement_c_46_c_01"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"training_ground_psyker"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		pre_wwise_event = "play_hub_pa_notification",
		wwise_route = 22,
		name = "shipmistress_hub_announcement_pa",
		response = "shipmistress_hub_announcement_pa",
		database = "conversations_hub",
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"generic_vo_event"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"random_talk"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"shipmistress_a"
				}
			},
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMEDIFF,
				OP.GT,
				139
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMEDIFF,
				OP.GT,
				229
			},
			{
				"faction_memory",
				"last_mission_update",
				OP.TIMEDIFF,
				OP.GT,
				15
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_random_talk",
				OP.TIMESET
			},
			{
				"user_memory",
				"time_since_last_random_talk_user",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "all_including_self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "shipmistress_hub_announcement_vox",
		response = "shipmistress_hub_announcement_vox",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"shipmistress"
				}
			},
			{
				"faction_memory",
				"shipmistress_hub_announcement_vox",
				OP.TIMEDIFF,
				OP.GT,
				240
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				100
			}
		},
		on_done = {
			{
				"faction_memory",
				"shipmistress_hub_announcement_vox",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "all_including_self"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_01_a",
		response = "southwark_hub_conversation_01_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_01_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_01_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_01_b",
		response = "southwark_hub_conversation_01_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_01_c",
		response = "southwark_hub_conversation_01_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_01_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_02_a",
		response = "southwark_hub_conversation_02_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_02_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_02_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_02_b",
		response = "southwark_hub_conversation_02_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_02_c",
		response = "southwark_hub_conversation_02_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_02_d",
		response = "southwark_hub_conversation_02_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_02_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_03_a",
		response = "southwark_hub_conversation_03_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_03_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_03_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_03_b",
		response = "southwark_hub_conversation_03_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_03_c",
		response = "southwark_hub_conversation_03_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_03_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_04_a",
		response = "southwark_hub_conversation_04_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_04_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_04_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_04_b",
		response = "southwark_hub_conversation_04_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_04_c",
		response = "southwark_hub_conversation_04_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_04_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"interrogator"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_05_a",
		response = "southwark_hub_conversation_05_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_05_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_05_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_05_b",
		response = "southwark_hub_conversation_05_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_05_c",
		response = "southwark_hub_conversation_05_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_05_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_05_d",
		response = "southwark_hub_conversation_05_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_05_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_05_e",
		response = "southwark_hub_conversation_05_e",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_05_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_06_a",
		response = "southwark_hub_conversation_06_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_06_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_06_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_06_b",
		response = "southwark_hub_conversation_06_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_06_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_06_c",
		response = "southwark_hub_conversation_06_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_06_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_06_d",
		response = "southwark_hub_conversation_06_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_06_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "all"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_07_a",
		response = "southwark_hub_conversation_07_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_07_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_07_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_07_b",
		response = "southwark_hub_conversation_07_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_07_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_07_c",
		response = "southwark_hub_conversation_07_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_07_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_07_d",
		response = "southwark_hub_conversation_07_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_07_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "all"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_08_a",
		response = "southwark_hub_conversation_08_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_08_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_08_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_08_b",
		response = "southwark_hub_conversation_08_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_08_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_08_c",
		response = "southwark_hub_conversation_08_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_08_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_08_d",
		response = "southwark_hub_conversation_08_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_08_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_08_e",
		response = "southwark_hub_conversation_08_e",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_08_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_09_a",
		response = "southwark_hub_conversation_09_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_09_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_09_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_09_b",
		response = "southwark_hub_conversation_09_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_09_c",
		response = "southwark_hub_conversation_09_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_09_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_09_d",
		response = "southwark_hub_conversation_09_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_09_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_10_a",
		response = "southwark_hub_conversation_10_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_10_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_10_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_10_b",
		response = "southwark_hub_conversation_10_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_10_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_10_c",
		response = "southwark_hub_conversation_10_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_10_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_11_a",
		response = "southwark_hub_conversation_11_a",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"query_context",
				"trigger_id",
				OP.EQ,
				"npc_story_talk"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			},
			{
				"faction_memory",
				"southwark_hub_conversation_11_a",
				OP.TIMEDIFF,
				OP.GT,
				4800
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMEDIFF,
				OP.GT,
				120
			}
		},
		on_done = {
			{
				"faction_memory",
				"southwark_hub_conversation_11_a",
				OP.TIMESET
			},
			{
				"faction_memory",
				"time_since_last_vox_story_talk",
				OP.TIMESET
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_11_b",
		response = "southwark_hub_conversation_11_b",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_11_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_11_c",
		response = "southwark_hub_conversation_11_c",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_11_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"commissar"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.2
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_conversation_11_d",
		response = "southwark_hub_conversation_11_d",
		database = "conversations_hub",
		wwise_route = 1,
		category = "conversations_prio_0",
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
					"southwark_hub_conversation_11_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant"
				}
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
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_first_greeting_launch_a",
		wwise_route = 40,
		response = "southwark_hub_first_greeting_launch_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "southwark_hub_first_greeting_launch_b",
		category = "npc_prio_0",
		response = "southwark_hub_first_greeting_launch_b",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "southwark_hub_first_greeting_launch_c",
		category = "npc_prio_0",
		response = "southwark_hub_first_greeting_launch_c",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_c"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "southwark_hub_first_greeting_launch_d",
		category = "npc_prio_0",
		response = "southwark_hub_first_greeting_launch_d",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_d"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "southwark_hub_first_greeting_launch_e",
		wwise_route = 40,
		response = "southwark_hub_first_greeting_launch_e",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_e"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		name = "southwark_hub_first_greeting_launch_f",
		wwise_route = 40,
		response = "southwark_hub_first_greeting_launch_f",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_f"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "southwark_hub_first_greeting_launch_g",
		wwise_route = 40,
		response = "southwark_hub_first_greeting_launch_g",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"southwark_hub_first_greeting_launch_g"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "tech_priest_distance",
		category = "npc_prio_0",
		response = "tech_priest_distance",
		database = "conversations_hub",
		wwise_route = 19,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"tech_priest_distance"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					"ogryn_a",
					"ogryn_b",
					"ogryn_c",
					"psyker_female_a",
					"psyker_female_b",
					"psyker_female_c",
					"psyker_male_a",
					"psyker_male_b",
					"psyker_male_c",
					"veteran_female_a",
					"veteran_female_b",
					"veteran_female_c",
					"veteran_male_a",
					"veteran_male_b",
					"veteran_male_c",
					"zealot_female_a",
					"zealot_female_b",
					"zealot_female_c",
					"zealot_male_a",
					"zealot_male_b",
					"zealot_male_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"tech_priest"
				}
			},
			{
				"query_context",
				"player_level_string",
				OP.SET_NOT_INCLUDES,
				args = {
					"0"
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "tech_priest_goodbye",
		concurrent_wwise_event = "play_vox_static_loop",
		category = "npc_prio_0",
		response = "tech_priest_goodbye",
		database = "conversations_hub",
		wwise_route = 1,
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"tech_priest_goodbye"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		name = "twins_epilogue_01_a",
		wwise_route = 40,
		response = "twins_epilogue_01_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_b",
		category = "npc_prio_0",
		response = "twins_epilogue_01_b",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_c",
		category = "npc_prio_0",
		response = "twins_epilogue_01_c",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_c"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_d",
		category = "npc_prio_0",
		response = "twins_epilogue_01_d",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_d"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_e",
		category = "npc_prio_0",
		response = "twins_epilogue_01_e",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_e"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_f",
		category = "npc_prio_0",
		response = "twins_epilogue_01_f",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_f"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_g",
		category = "npc_prio_0",
		response = "twins_epilogue_01_g",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_g"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_01_h",
		category = "npc_prio_0",
		response = "twins_epilogue_01_h",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_h"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "twins_epilogue_01_i",
		wwise_route = 40,
		response = "twins_epilogue_01_i",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_01_i"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_a",
		category = "npc_prio_0",
		response = "twins_epilogue_02_a",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_b",
		category = "npc_prio_0",
		response = "twins_epilogue_02_b",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_c",
		category = "npc_prio_0",
		response = "twins_epilogue_02_c",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_d",
		category = "npc_prio_0",
		response = "twins_epilogue_02_d",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_e",
		category = "npc_prio_0",
		response = "twins_epilogue_02_e",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_f",
		category = "npc_prio_0",
		response = "twins_epilogue_02_f",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_g",
		category = "npc_prio_0",
		response = "twins_epilogue_02_g",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_h",
		category = "npc_prio_0",
		response = "twins_epilogue_02_h",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_i",
		category = "npc_prio_0",
		response = "twins_epilogue_02_i",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_j",
		category = "npc_prio_0",
		response = "twins_epilogue_02_j",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_epilogue_02_k",
		category = "npc_prio_0",
		response = "twins_epilogue_02_k",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_02_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "twins_epilogue_03_a",
		pre_wwise_event = "play_radio_static_start",
		response = "twins_epilogue_03_a",
		database = "conversations_hub",
		wwise_route = 40,
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_epilogue_03_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		name = "twins_prologue_01_a",
		wwise_route = 40,
		response = "twins_prologue_01_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_prologue_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_prologue_01_b",
		category = "npc_prio_0",
		response = "twins_prologue_01_b",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_prologue_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "twins_prologue_01_c",
		category = "npc_prio_0",
		response = "twins_prologue_01_c",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_prologue_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "twins_prologue_01_d",
		wwise_route = 40,
		response = "twins_prologue_01_d",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"twins_prologue_01_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		pre_wwise_event = "play_radio_static_start",
		name = "uxbridge_hub_heresy_greeting_a",
		wwise_route = 40,
		response = "uxbridge_hub_heresy_greeting_a",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"uxbridge_hub_heresy_greeting_a"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		name = "uxbridge_hub_heresy_greeting_b",
		category = "npc_prio_0",
		response = "uxbridge_hub_heresy_greeting_b",
		database = "conversations_hub",
		wwise_route = 40,
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"uxbridge_hub_heresy_greeting_b"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		name = "uxbridge_hub_heresy_greeting_c",
		wwise_route = 40,
		response = "uxbridge_hub_heresy_greeting_c",
		database = "conversations_hub",
		category = "npc_prio_0",
		speaker_routing = {
			target = "dialogist"
		},
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"npc_interacting_vo"
			},
			{
				"query_context",
				"vo_event",
				OP.EQ,
				"uxbridge_hub_heresy_greeting_c"
			},
			{
				"query_context",
				"interactor_voice_profile",
				OP.SET_INCLUDES,
				args = {
					""
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					""
				}
			}
		},
		on_done = {}
	})
end
