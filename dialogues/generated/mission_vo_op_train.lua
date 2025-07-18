return function ()
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_boss_arrival_a",
		response = "mission_train_boss_arrival_a",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"cultist_captain_taunt"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"global_context",
				"current_mission",
				OP.EQ,
				"op_train"
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 1
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_boss_arrival_foreshadow_a",
		response = "mission_train_boss_arrival_foreshadow_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_boss_arrival_foreshadow_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"cargo_pilot"
				}
			},
			{
				"faction_memory",
				"mission_train_boss_arrival_foreshadow_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_boss_arrival_foreshadow_a",
				OP.ADD,
				1
			}
		},
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
		name = "mission_train_boss_dead_a",
		response = "mission_train_boss_dead_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_boss_dead_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_boss_dead_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_boss_dead_a",
				OP.ADD,
				1
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
		name = "mission_train_cinematic_intro_a",
		response = "mission_train_cinematic_intro_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_cinematic_intro_a"
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
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_dropship_withdraw_response",
		response = "mission_train_dropship_withdraw_response",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_agnostic_dropship_withdraw_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_fifth_objective_brake_a",
		response = "mission_train_fifth_objective_brake_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_fifth_objective_brake_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_fifth_objective_brake_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_fifth_objective_brake_a",
				OP.ADD,
				1
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
		name = "mission_train_fifth_objective_complete_a",
		response = "mission_train_fifth_objective_complete_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_fifth_objective_complete_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_fifth_objective_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_fifth_objective_complete_a",
				OP.ADD,
				1
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
		name = "mission_train_fifth_objective_complete_b",
		response = "mission_train_fifth_objective_complete_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_fifth_objective_complete_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"cargo_pilot"
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
		name = "mission_train_fifth_objective_sighted_a",
		wwise_route = 1,
		response = "mission_train_fifth_objective_sighted_a",
		database = "mission_vo_op_train",
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
					"mission_train_boss_dead_a"
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
			target = "mission_giver_default"
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
		name = "mission_train_fifth_objective_sighted_b",
		wwise_route = 1,
		response = "mission_train_fifth_objective_sighted_b",
		database = "mission_vo_op_train",
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
					"mission_train_fifth_objective_sighted_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		},
		on_pre_rule_execution = {
			delay_vo = {
				duration = 0.1
			}
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		name = "mission_train_fifth_objective_sighted_c",
		wwise_route = 1,
		response = "mission_train_fifth_objective_sighted_c",
		database = "mission_vo_op_train",
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
					"mission_train_fifth_objective_sighted_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
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
		name = "mission_train_first_interstitial_01_a",
		response = "mission_train_first_interstitial_01_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_interstitial_01_a"
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
				"mission_train_first_interstitial_01_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_interstitial_01_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_first_interstitial_01_b",
		response = "mission_train_first_interstitial_01_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_first_interstitial_01_c",
		response = "mission_train_first_interstitial_01_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_01_b"
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
		name = "mission_train_first_interstitial_02_a",
		response = "mission_train_first_interstitial_02_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_interstitial_02_a"
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
				"mission_train_first_interstitial_02_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_interstitial_02_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_first_interstitial_02_b",
		response = "mission_train_first_interstitial_02_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_first_interstitial_02_c",
		response = "mission_train_first_interstitial_02_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_02_b"
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
		name = "mission_train_first_interstitial_03_a",
		response = "mission_train_first_interstitial_03_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_interstitial_03_a"
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
				"mission_train_first_interstitial_03_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_interstitial_03_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_first_interstitial_03_b",
		response = "mission_train_first_interstitial_03_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_first_interstitial_03_c",
		response = "mission_train_first_interstitial_03_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_interstitial_03_b"
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
		name = "mission_train_first_objective_a",
		response = "mission_train_first_objective_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_objective_a"
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
				"mission_train_first_objective_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_objective_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_first_objective_b",
		response = "mission_train_first_objective_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_objective_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
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
		name = "mission_train_first_objective_c",
		response = "mission_train_first_objective_c",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_objective_c"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_first_objective_c",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_objective_c",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "level_event"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_first_objective_complete_a",
		response = "mission_train_first_objective_complete_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_objective_complete_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_first_objective_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_objective_complete_a",
				OP.ADD,
				1
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
		name = "mission_train_first_objective_mid_a",
		response = "mission_train_first_objective_mid_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_objective_mid_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_first_objective_mid_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_objective_mid_a",
				OP.ADD,
				1
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
		name = "mission_train_first_objective_sighted_a",
		response = "mission_train_first_objective_sighted_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_first_objective_sighted_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_first_objective_sighted_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_first_objective_sighted_a",
				OP.ADD,
				1
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
		name = "mission_train_first_objective_sighted_a_backup",
		response = "mission_train_first_objective_sighted_a_backup",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_first_objective_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"first_objective_triggered",
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
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_fourth_objective_complete_a",
		response = "mission_train_fourth_objective_complete_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_fourth_objective_complete_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_fourth_objective_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_fourth_objective_complete_a",
				OP.ADD,
				1
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
		name = "mission_train_fourth_objective_sighted_a",
		response = "mission_train_fourth_objective_sighted_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_fourth_objective_sighted_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_fourth_objective_sighted_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_fourth_objective_sighted_a",
				OP.ADD,
				1
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
		name = "mission_train_fourth_objective_sighted_a_backup",
		response = "mission_train_fourth_objective_sighted_a_backup",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_01_d",
					"mission_train_second_interstitial_02_d",
					"mission_train_second_interstitial_03_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"reached_last_bomb",
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
		name = "mission_train_ogryn_joy_a",
		category = "conversations_prio_1",
		wwise_route = 0,
		response = "mission_train_ogryn_joy_a",
		database = "mission_vo_op_train",
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
				"mission_train_ogryn_joy_a"
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
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_outro_fail_a",
		response = "mission_train_outro_fail_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
		category = "cutscene",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"cutscene_vo_line"
			},
			{
				"query_context",
				"vo_line_id",
				OP.EQ,
				"mission_train_outro_fail_a"
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
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_outro_success_a",
		response = "mission_train_outro_success_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
		category = "cutscene",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"cutscene_vo_line"
			},
			{
				"query_context",
				"vo_line_id",
				OP.EQ,
				"mission_train_outro_success_a"
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
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_outro_success_b",
		response = "mission_train_outro_success_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_outro_success_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_path_blocked_a",
		response = "mission_train_path_blocked_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_path_blocked_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_path_blocked_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_path_blocked_a",
				OP.ADD,
				1
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
		name = "mission_train_path_blocked_bypassed_a",
		response = "mission_train_path_blocked_bypassed_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_path_blocked_bypassed_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_path_blocked_bypassed_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_path_blocked_bypassed_a",
				OP.ADD,
				1
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
		name = "mission_train_second_interstitial_01_a",
		response = "mission_train_second_interstitial_01_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_interstitial_01_a"
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
				"mission_train_second_interstitial_01_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_interstitial_01_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_second_interstitial_01_b",
		response = "mission_train_second_interstitial_01_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_second_interstitial_01_c",
		response = "mission_train_second_interstitial_01_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_01_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"cargo_pilot"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_giver_default"
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
		name = "mission_train_second_interstitial_01_d",
		response = "mission_train_second_interstitial_01_d",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_01_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
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
		name = "mission_train_second_interstitial_02_a",
		response = "mission_train_second_interstitial_02_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_interstitial_02_a"
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
				"mission_train_second_interstitial_02_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_interstitial_02_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_second_interstitial_02_b",
		response = "mission_train_second_interstitial_02_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_second_interstitial_02_c",
		response = "mission_train_second_interstitial_02_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"cargo_pilot"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_giver_default"
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
		name = "mission_train_second_interstitial_02_d",
		response = "mission_train_second_interstitial_02_d",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_02_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
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
		name = "mission_train_second_interstitial_03_a",
		response = "mission_train_second_interstitial_03_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_interstitial_03_a"
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
				"mission_train_second_interstitial_03_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_interstitial_03_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_giver_default"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_second_interstitial_03_b",
		response = "mission_train_second_interstitial_03_b",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
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
		name = "mission_train_second_interstitial_03_c",
		response = "mission_train_second_interstitial_03_c",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_03_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"cargo_pilot"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_giver_default"
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
		name = "mission_train_second_interstitial_03_d",
		response = "mission_train_second_interstitial_03_d",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_second_interstitial_03_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
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
		name = "mission_train_second_objective_complete_a",
		response = "mission_train_second_objective_complete_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_objective_complete_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_second_objective_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_objective_complete_a",
				OP.ADD,
				1
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
		name = "mission_train_second_objective_mid_a",
		response = "mission_train_second_objective_mid_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_objective_mid_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_second_objective_mid_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_objective_mid_a",
				OP.ADD,
				1
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
		name = "mission_train_second_objective_sighted_a",
		response = "mission_train_second_objective_sighted_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_second_objective_sighted_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_second_objective_sighted_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_second_objective_sighted_a",
				OP.ADD,
				1
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
		name = "mission_train_third_objective_complete_a",
		response = "mission_train_third_objective_complete_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_third_objective_complete_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_third_objective_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_third_objective_complete_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "level_event"
		}
	})
	define_rule({
		post_wwise_event = "play_radio_static_end",
		concurrent_wwise_event = "play_vox_static_loop",
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_third_objective_mid_a",
		response = "mission_train_third_objective_mid_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_third_objective_mid_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_third_objective_mid_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_third_objective_mid_a",
				OP.ADD,
				1
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
		name = "mission_train_third_objective_sighted_a",
		response = "mission_train_third_objective_sighted_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_third_objective_sighted_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_third_objective_sighted_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_third_objective_sighted_a",
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
		pre_wwise_event = "play_radio_static_start",
		name = "mission_train_third_objective_start_a",
		response = "mission_train_third_objective_start_a",
		database = "mission_vo_op_train",
		wwise_route = 1,
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
				"mission_train_third_objective_start_a"
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"sergeant",
					"enginseer"
				}
			},
			{
				"faction_memory",
				"mission_train_third_objective_start_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"mission_train_third_objective_start_a",
				OP.ADD,
				1
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
		name = "mission_train_third_objective_start_a_backup",
		response = "mission_train_third_objective_start_a_backup",
		database = "mission_vo_op_train",
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
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"mission_train_third_objective_sighted_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"enginseer",
					"sergeant"
				}
			},
			{
				"faction_memory",
				"luggable_event_started",
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
end
