return function ()
	define_rule({
		name = "cmd_deploy_skull_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "cmd_deploy_skull_horde",
		database = "mission_vo_psykhanium",
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
				"cmd_deploy_skull"
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
				"cmd_deploy_skull",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"user_memory",
				"cmd_deploy_skull",
				OP.TIMESET,
				0
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "cmd_hacking_place_device_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "cmd_hacking_place_device_horde",
		database = "mission_vo_psykhanium",
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
				"cmd_hacking_place_device"
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
			target = "players"
		}
	})
	define_rule({
		name = "cmd_luggable_prompt_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "cmd_luggable_prompt_a",
		database = "mission_vo_psykhanium",
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
				OP.SET_INCLUDES,
				args = {
					"cmd_luggable_prompt_a",
					"all_targets_scanned"
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
				"faction_memory",
				"scanning_active",
				OP.EQ,
				0
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "cmd_wandering_skull_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "cmd_wandering_skull_horde",
		database = "mission_vo_psykhanium",
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
				"cmd_wandering_skull"
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
				"faction_memory",
				"cmd_wandering_skull",
				OP.TIMEDIFF,
				OP.GT,
				30
			},
			{
				"faction_memory",
				"mission_scan_final",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"cmd_wandering_skull",
				OP.TIMESET,
				0
			}
		},
		heard_speak_routing = {
			target = "players"
		}
	})
	define_rule({
		name = "event_corruptor_objective_start",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "event_corruptor_objective_start",
		database = "mission_vo_psykhanium",
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
				"event_corruptor_objective_start"
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
		}
	})
	define_rule({
		name = "event_demolition_first_corruptor_destroyed_b_horde",
		wwise_route = 42,
		response = "event_demolition_first_corruptor_destroyed_b_horde",
		database = "mission_vo_psykhanium",
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
					"event_demolition_first_corruptor_destroyed_a"
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
				duration = 0.3
			}
		}
	})
	define_rule({
		name = "event_demolition_last_corruptor_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "event_demolition_last_corruptor_horde",
		database = "mission_vo_psykhanium",
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
				"event_demolition_last_corruptor"
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
		}
	})
	define_rule({
		name = "event_scan_all_targets_scanned_horde",
		wwise_route = 42,
		response = "event_scan_all_targets_scanned_horde",
		database = "mission_vo_psykhanium",
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
				"all_targets_scanned_disabled"
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
				duration = 0.5
			}
		}
	})
	define_rule({
		name = "event_scan_more_data_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "event_scan_more_data_horde",
		database = "mission_vo_psykhanium",
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
				"event_scan_more_data"
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
				"faction_memory",
				"event_scan_more_data",
				OP.EQ,
				OP.GT,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"event_scan_more_data",
				OP.ADD,
				0
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "event_scan_skull_waiting_horde",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "event_scan_skull_waiting_horde",
		database = "mission_vo_psykhanium",
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
				"event_scan_skull_waiting"
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
		}
	})
	define_rule({
		name = "horde_claim_prize_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_claim_prize_a",
		database = "mission_vo_psykhanium",
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
				"horde_claim_prize_a"
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
				"faction_memory",
				"horde_claim_prize_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_claim_prize_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_defend_area_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_defend_area_a",
		database = "mission_vo_psykhanium",
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
				"horde_defend_area_a"
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
		}
	})
	define_rule({
		name = "horde_mission_complete_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_mission_complete_a",
		database = "mission_vo_psykhanium",
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
				"horde_mission_complete_a"
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
				"faction_memory",
				"horde_mission_complete_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_mission_complete_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "level_event"
		}
	})
	define_rule({
		name = "horde_new_wave_start_post_upgrade_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_new_wave_start_post_upgrade_a",
		database = "mission_vo_psykhanium",
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
				"horde_new_wave_start_post_upgrade_a"
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
		}
	})
	define_rule({
		name = "horde_objective_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_objective_a",
		database = "mission_vo_psykhanium",
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
				"horde_objective_a"
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
		}
	})
	define_rule({
		name = "horde_resupply_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_resupply_a",
		database = "mission_vo_psykhanium",
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
				"horde_resupply_a"
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
		}
	})
	define_rule({
		name = "horde_safe_zone_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_safe_zone_a",
		database = "mission_vo_psykhanium",
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
				"horde_safe_zone_a"
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
				"faction_memory",
				"horde_safe_zone_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_safe_zone_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_safe_zone_b",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_safe_zone_b",
		database = "mission_vo_psykhanium",
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
				"horde_safe_zone_b"
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
				"faction_memory",
				"horde_safe_zone_b",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_safe_zone_b",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_wave_interstitial_strain_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_interstitial_strain_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_interstitial_strain_a"
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
				"faction_memory",
				"horde_wave_interstitial_strain_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_wave_interstitial_strain_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "level_event"
		}
	})
	define_rule({
		name = "horde_wave_interstitial_voices_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_interstitial_voices_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_interstitial_voices_a"
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
				"faction_memory",
				"horde_wave_interstitial_voices_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_wave_interstitial_voices_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_wave_start_01_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_start_01_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_start_01_a"
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
				"faction_memory",
				"horde_wave_start_01_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_wave_start_01_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_wave_start_02_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_start_02_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_start_02_a"
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
				"faction_memory",
				"horde_wave_start_02_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_wave_start_02_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_wave_start_03_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_start_03_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_start_03_a"
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
				"faction_memory",
				"horde_wave_start_03_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"horde_wave_start_03_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		}
	})
	define_rule({
		name = "horde_wave_upgrade_prompt_a",
		category = "vox_prio_0",
		wwise_route = 42,
		response = "horde_wave_upgrade_prompt_a",
		database = "mission_vo_psykhanium",
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
				"horde_wave_upgrade_prompt_a"
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
		}
	})
	define_rule({
		name = "info_servo_skull_deployed_horde",
		wwise_route = 42,
		response = "info_servo_skull_deployed_horde",
		database = "mission_vo_psykhanium",
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
				"info_servo_skull_deployed"
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
				"info_servo_skull_deployed",
				OP.GTEQ,
				0
			}
		},
		on_done = {
			{
				"user_memory",
				"info_servo_skull_deployed",
				OP.ADD,
				1
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
		name = "story_echo_morrow_01_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_01_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_01_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_captain_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_01_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_01_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_01_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_01_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_01_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_01_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_01_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_01_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_01_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_01_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_01_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_01_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_01_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_02_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_02_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_captain_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_02_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_01_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_02_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_02_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_02_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_02_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_02_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_02_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_02_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_02_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_02_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_02_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_02_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_world_eater_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_03_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_02_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_03_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_03_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_03_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_03_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_03_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_03_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_03_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_04_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_04_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_04_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_03_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_04_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_04_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_04_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_04_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_04_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_04_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_04_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_04_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_04_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_05_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_05_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_05_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_05_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_05_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_05_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_05_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_05_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_05_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_05_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_05_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_05_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_05_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_05_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_05_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_05_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_commissar_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_06_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_05_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_06_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_06_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_06_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_06_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_06_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_06_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_06_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_06_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_trooper_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_07_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_06_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_07_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_b_disabled"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_07_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_07_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_07_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_08_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_08_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_trooper_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_08_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_07_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_08_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_08_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_08_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_08_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_08_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_08_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_08_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_08_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_08_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_08_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_09_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_trooper_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_09_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_09_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_09_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_09_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_09_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_09_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_09_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_09_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_trooper_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_10_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_09_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_10_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_10_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_10_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_10_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_10_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_10_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_10_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_10_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_legion_commissar_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_11_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_10_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_11_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_11_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_11_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_11_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_11_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_11_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_11_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_11_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_12_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_12_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_12_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_11_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_12_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_12_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_12_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_12_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_12_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_12_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_12_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_12_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_12_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_12_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_12_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_12_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_12_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_13_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_13_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_13_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_13_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_13a_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13a_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_13a_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_13_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_13a_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13a_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13a_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13a_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13a_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13a_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13a_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_13a_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_13a_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13a_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_14_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_14_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_13a_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_14_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_14_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_14_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_14_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_14_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_14_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_15_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_13a_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_15_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_15_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_15_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_15_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_15_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_15_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_15_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_15_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_16_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_16_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_b"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_16_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_15_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_16_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_16_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_16_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_16_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_16_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_16_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_16_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_16_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_16_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_16_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_17_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_17_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_17_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_17_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_17_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_17_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_17_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_17_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_17_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_17_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_17_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_17_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_17_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_17_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_17_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_17_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_17_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_18_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_17_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_18_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_18_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_18_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_18_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_18_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_18_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_18_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_18_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_19_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_19_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_19_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_18_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_19_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_19_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_19_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_19_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_19_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_19_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_19_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_19_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_19_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_19_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_19_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_19_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_19_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_20_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_19_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_20_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_20_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_20_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_20_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_20_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_20_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_20_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_20_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_21_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_21_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_21_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_auspex_operator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_21_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_21_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_21_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_21_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_21_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_21_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_21_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_21_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_21_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_21_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_21_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_21_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_21_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_21_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_22_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_22_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_22_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_21_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_22_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_22_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_22_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_22_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_22_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_22_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_22_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_23_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_22_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_23_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_h",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_h",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_g"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_i",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_i",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_h"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_j",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_j",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_i"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_23_k",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_23_k",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_23_j"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_24_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_24_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_24_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_23_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_24_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_24_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_24_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_24_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_24_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_24_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_24_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_24_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_24_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_24_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_24_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_24_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_24_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_25_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_25_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_25_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_auspex_operator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_25_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_25_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_25_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_25_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_25_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_25_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_25_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_25_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_25_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_25_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_25_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_26_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_26_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_26_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_25_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_26_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_26_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_26_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_26_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_26_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_26_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_26_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_26_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_26_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_26_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_27_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_27_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_27_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_26_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_27_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_27_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_27_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_27_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_27_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_27_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_27_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_27_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_27_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_27_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_morrow_27_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_27_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_27_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_28_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_28_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_enemy_nemesis_wolfer_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_28_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_27_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_28_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_28_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_28_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_28_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_28_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_28_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_28_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_28_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_28_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_28_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_29_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_29_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_29_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_29_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_29_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_29_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_29_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_29_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_29_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_29_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_29_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_29_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_29_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_29_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_enemy_nemesis_wolfer_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_30_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_29_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_30_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_30_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_30_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_30_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_30_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_30_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_30_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_30_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_31_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_31_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_armourer_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_31_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_30_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_31_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_31_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_31_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_31_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_31_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_31_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_31_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_31_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_31_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_31_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_31_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_31_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_31_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_32_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_32_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_32_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_31_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_32_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_32_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_32_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_32_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_32_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_32_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_32_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_32_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_32_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_32_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_32_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_32_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_32_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_morrow_33_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_cartel_tough_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_33_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_33_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_33_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_33_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_33_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_33_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_33_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_33_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_33_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_sergeant_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_34_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_33_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_34_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_34_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_34_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_34_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_armourer_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_35_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_34_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_35_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_35_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_35_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_35_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_morrow_36_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_36_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_morrow_36_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_morrow_35_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_morrow_36_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_36_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_36_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_36_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_36_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_36_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_36_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_36_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_36_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_36_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_morrow_36_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_morrow_36_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_morrow_36_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_01_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_01_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_01_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_young_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_01_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_01_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_01_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_01_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_01_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_01_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_01_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_01_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_01_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_01_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_01_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_01_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_01_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_01_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_02_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_02_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_cartel_tough_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_02_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_01_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_02_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_02_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_02_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_02_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_02_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_02_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_02_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_02_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_02_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_02_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_02_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_02_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_02_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_03_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_03_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_young_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_03_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_02_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_03_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_03_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_03_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_03_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_03_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_03_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_03_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_03_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_03_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_03_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_04_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_04_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_young_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_04_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_03_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_04_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_04_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_04_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_04_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_04_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_04_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_04_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_04_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_04_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_04_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_04_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_04_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_04_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_05_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_05_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_05_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_ragged_king_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_05_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_05_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_05_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_05_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_05_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_05_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_05_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_05_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_05_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_05_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_05_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_06_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"fx"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_06_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_05_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_06_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_06_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_06_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_06_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_07_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_07_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_07_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_06_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_07_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_07_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_07_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_07_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_07_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_07_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_07_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_07_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_07_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_07_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_07_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_07_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_07_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_08_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_08_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_08_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_07_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_08_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_08_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_08_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_08_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_08_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_08_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_08_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_08_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_08_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_08_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_08_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_08_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_08_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_09_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_09_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_09_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_09_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_09_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_09_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_09_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_09_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_09_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_09_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_09_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_09_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_09_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_09_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_10_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"fx"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_10_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_09_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_10_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_10_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_10_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_10_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_10_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_10_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_10_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_10_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_10_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_11_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_11_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_cartel_tough_c"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_11_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_10_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_11_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_11_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_11_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_11_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_11_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_11_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_11_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_11_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_11_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_11_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_11_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_11_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_11_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_12_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_12_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_12_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_11_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_12_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_12_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_12_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_12_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_12_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_12_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_12_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_12_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_12_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_12_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_12_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_12_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_12_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_13_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_13_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_13_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_13_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_13_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_13_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_13_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_13_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_13_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_13_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_13_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_13_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_13_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_13_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_13_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_13_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_13_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_14_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_14_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_14_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_13_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_14_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_14_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_14_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_14_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_14_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_14_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_14_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_14_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_14_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_14_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_14_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_14_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_14_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_15_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_15_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_15_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_14_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_15_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_15_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_15_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_15_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_15_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_15_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_15_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_15_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_15_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_15_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_15_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_15_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_15_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_16_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_16_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_15_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_16_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_h",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_h",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_g"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_16_i",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_16_i",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_16_h"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_17_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_17_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_17_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_17_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_17_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_17_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_17_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_17_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_17_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_17_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_17_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_17_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_17_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_17_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_18_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_18_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_18_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_17_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_18_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_18_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_18_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_18_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_18_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_18_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_18_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_18_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_18_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_18_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_18_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_18_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_18_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_19_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_armourer_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_19_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_18_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_19_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_19_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_19_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_19_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_19_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_19_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_19_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_19_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_19_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_19_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_19_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_19_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_20_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_ragged_king_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_20_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_19_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_20_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_20_g",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_20_g",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_20_f"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_21_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_21_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_21_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_21_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_21_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_21_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_21_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_21_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_21_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_21_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_21_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_21_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_21_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_21_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_21_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_21_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_21_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_22_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_ragged_king_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_22_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_21_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_22_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_22_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_22_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_22_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_22_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_22_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_22_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_22_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_22_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_22_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_22_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_22_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_23_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_23_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_23_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_22_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_23_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_23_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_23_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_23_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_23_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_23_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_23_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_23_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_23_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_23_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_24_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_explicator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_24_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_23_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_24_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_24_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_24_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_24_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_24_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_24_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_24_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_24_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_24_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_24_f",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_24_f",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_24_e"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_25_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_25_a",
		database = "mission_vo_psykhanium",
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
				"story_echo_zola_25_a"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_25_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_25_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_25_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_25_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_25_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "self"
		}
	})
	define_rule({
		name = "story_echo_zola_25_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_25_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_25_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_25_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_25_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_25_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_25_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_25_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_25_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_26_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_26_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_26_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_25_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_26_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_26_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_26_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_26_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_26_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_26_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_26_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_26_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_26_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_26_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_26_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_26_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_26_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_27_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_27_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_27_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_26_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_27_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_27_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_27_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_27_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_27_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_27_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_27_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_27_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_27_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_27_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_27_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_27_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_27_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "story_echo_zola_28_a",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_28_a",
		database = "mission_vo_psykhanium",
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
				"story_echo"
			},
			{
				"user_context",
				"voice_template",
				OP.SET_INCLUDES,
				args = {
					"past_interrogator_a"
				}
			},
			{
				"faction_memory",
				"story_echo_zola_28_a",
				OP.EQ,
				0
			},
			{
				"faction_memory",
				"story_echo_zola_27_a",
				OP.EQ,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"story_echo_zola_28_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_28_b",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_28_b",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_28_a"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_28_c",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_28_c",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_28_b"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_28_d",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_28_d",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_28_c"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "mission_givers"
		}
	})
	define_rule({
		name = "story_echo_zola_28_e",
		category = "vox_prio_0",
		wwise_route = 1,
		response = "story_echo_zola_28_e",
		database = "mission_vo_psykhanium",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name",
				OP.SET_INCLUDES,
				args = {
					"story_echo_zola_28_d"
				}
			},
			{
				"user_context",
				"class_name",
				OP.SET_INCLUDES,
				args = {
					"past"
				}
			}
		},
		on_done = {},
		heard_speak_routing = {
			target = "level_event_generic"
		}
	})
	define_rule({
		name = "wave_start_flamers_a",
		wwise_route = 42,
		response = "wave_start_flamers_a",
		database = "mission_vo_psykhanium",
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
				"wave_start_flamers_a"
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
				"faction_memory",
				"wave_start_flamers_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"wave_start_flamers_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 0,
				hold_for = 0
			}
		}
	})
	define_rule({
		name = "wave_start_hounds_a",
		wwise_route = 42,
		response = "wave_start_hounds_a",
		database = "mission_vo_psykhanium",
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
				"wave_start_hounds_a"
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
				"faction_memory",
				"wave_start_hounds_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"wave_start_hounds_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 0,
				hold_for = 0
			}
		}
	})
	define_rule({
		name = "wave_start_mutants_a",
		wwise_route = 42,
		response = "wave_start_mutants_a",
		database = "mission_vo_psykhanium",
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
				"wave_start_mutants_a"
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
				"faction_memory",
				"wave_start_mutants_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"wave_start_mutants_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 0,
				hold_for = 0
			}
		}
	})
	define_rule({
		name = "wave_start_poxbursters_a",
		wwise_route = 42,
		response = "wave_start_poxbursters_a",
		database = "mission_vo_psykhanium",
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
				"wave_start_poxbursters_a"
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
				"faction_memory",
				"wave_start_poxbursters_a",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"wave_start_poxbursters_a",
				OP.ADD,
				1
			}
		},
		heard_speak_routing = {
			target = "disabled"
		},
		on_pre_rule_execution = {
			random_ignore_vo = {
				chance = 0.5,
				max_failed_tries = 0,
				hold_for = 0
			}
		}
	})
end
