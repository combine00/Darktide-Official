local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local EffectTemplates = require("scripts/settings/fx/effect_templates")
local HitZone = require("scripts/utilities/attack/hit_zone")
local UtilityConsiderations = require("scripts/extension_systems/behavior/utility_considerations")
local damage_types = DamageSettings.damage_types
local hit_zone_names = HitZone.hit_zone_names
local action_data = {
	name = "chaos_ogryn_houndmaster",
	summon = {
		initial_delay = 3,
		stinger_delay = 3,
		shout_radius = 10,
		should_close_spawn_outside_los = true,
		shout_wwise_event = "wwise/events/minions/play_minion_captain__force_field_overload_vce",
		pre_stinger = "wwise/events/minions/play_chaos_hound_mutator_houndmaster_stinger",
		spawn_aggro_state = "passive",
		amount_of_tries = 5,
		stinger = "wwise/events/minions/play_chaos_hound_mutator_spawn",
		shout_wwise_event_timing = 0.16666666666666666,
		calculate_after_delay = true,
		anim_events = {
			"summon_minions"
		},
		shout_timings = {
			summon_minions = 0.9666666666666667
		},
		action_durations = {
			summon_minions = 2
		},
		interval_til_next_summon = {
			[1.0] = 10,
			[2.0] = 20
		},
		breed_data = {
			{
				name = "chaos_hound",
				amount = {
					1,
					3
				}
			},
			{
				name = "chaos_armored_hound",
				amount = {
					1,
					3
				}
			}
		}
	},
	idle = {
		rotate_towards_target = true,
		anim_events = {
			"idle",
			"idle_2"
		}
	},
	patrol = {
		anim_events = {
			"move_fwd_passive"
		},
		speeds = {
			move_fwd_passive = 1.2
		}
	},
	death = {
		5,
		instant_ragdoll_chance = 0,
		death_animations = {
			[hit_zone_names.head] = {
				"death_shot_head_left",
				"death_decapitate"
			},
			[hit_zone_names.torso] = {
				"death_strike_chest_front",
				"death_strike_chest_back",
				"death_burn"
			},
			[hit_zone_names.upper_left_arm] = {
				"death_arm_left"
			},
			[hit_zone_names.lower_left_arm] = {
				"death_arm_left"
			},
			[hit_zone_names.upper_right_arm] = {
				"death_arm_right"
			},
			[hit_zone_names.lower_right_arm] = {
				"death_arm_right"
			},
			[hit_zone_names.upper_left_leg] = {
				"death_leg_left"
			},
			[hit_zone_names.lower_left_leg] = {
				"death_leg_left"
			},
			[hit_zone_names.upper_right_leg] = {
				"death_leg_right"
			},
			[hit_zone_names.lower_right_leg] = {
				"death_leg_right"
			}
		},
		ragdoll_timings = {
			death_leg_left = 0.8333333333333334,
			death_leg_right = 0.6666666666666666,
			death_strike_chest_front = 1.6666666666666667,
			death_decapitate = 2.1333333333333333,
			death_strike_chest_back = 2.7666666666666666,
			death_burn = 6.333333333333333,
			death_shot_head_left = 3.066666666666667,
			death_arm_left = 6,
			death_arm_right = 3.8666666666666667
		}
	},
	combat_idle = {
		utility_weight = 2,
		anim_events = "idle",
		rotate_towards_target = true,
		considerations = UtilityConsiderations.melee_combat_idle
	},
	alerted = {
		override_aggro_distance = 8,
		vo_event = "alerted_idle",
		moving_alerted_anim_events = {
			bwd = "alerted_bwd",
			fwd = "alerted_fwd",
			left = "alerted_left",
			right = "alerted_right"
		},
		start_move_anim_data = {
			alerted_fwd = {},
			alerted_bwd = {
				sign = -1,
				rad = math.pi
			},
			alerted_left = {
				sign = 1,
				rad = math.pi / 2
			},
			alerted_right = {
				sign = -1,
				rad = math.pi / 2
			}
		},
		start_move_rotation_timings = {
			alerted_bwd = 3.3666666666666667,
			alerted_right = 3.7333333333333334,
			alerted_left = 3.6666666666666665
		},
		start_rotation_durations = {
			alerted_bwd = 0.4666666666666667,
			alerted_right = 4.566666666666666,
			alerted_left = 4.4
		},
		alerted_durations = {
			alerted_bwd = 5.666666666666667,
			alerted_right = 6.233333333333333,
			alerted_left = 5.5,
			alerted_fwd = 3.8333333333333335
		}
	},
	climb = {
		stagger_immune = true,
		rotation_duration = 0.1,
		anim_timings = {
			jump_up_3m = 2.923076923076923,
			jump_up_fence_5m = 1.3,
			jump_down_land = 1.3333333333333333,
			jump_up_1m_2 = 1.2424242424242424,
			jump_up_fence_1m = 0.6,
			jump_up_fence_3m = 1.4,
			jump_up_5m = 4.166666666666667,
			jump_up_3m_2 = 2.923076923076923,
			jump_up_fence_2m = 0.6,
			jump_up_2m = 1.2424242424242424,
			jump_up_1m = 1.2424242424242424
		},
		land_timings = {
			jump_down_1m_2 = 0.2,
			jump_down_fence_3m = 0.3333333333333333,
			jump_down_3m = 0.3333333333333333,
			jump_down_fence_5m = 0.3333333333333333,
			jump_down_1m = 0.2,
			jump_down_3m_2 = 0.3333333333333333,
			jump_down_fence_1m = 0.26666666666666666
		},
		ending_move_states = {
			jump_up_3m = "jumping",
			jump_up_3m_2 = "jumping",
			jump_up_5m = "jumping",
			jump_up_1m_2 = "jumping",
			jump_down_land = "jumping",
			jump_up_2m = "jumping",
			jump_up_1m = "jumping"
		},
		blend_timings = {
			jump_up_3m = 0.1,
			jump_up_fence_5m = 0.2,
			jump_down_land = 0,
			jump_up_1m_2 = 0.1,
			jump_down_3m = 0.1,
			jump_down_3m_2 = 0.1,
			jump_down_1m = 0.1,
			jump_up_fence_1m = 0.2,
			jump_down_1m_2 = 0.1,
			jump_up_fence_3m = 0.2,
			jump_up_5m = 0.1,
			jump_up_3m_2 = 0.1,
			jump_up_fence_2m = 0.2,
			jump_up_2m = 0.1,
			jump_up_1m = 0.1
		}
	},
	disable = {
		disable_anims = {
			pounced = {
				fwd = {
					"stagger_fwd_heavy"
				},
				bwd = {
					"stagger_fwd_heavy"
				},
				left = {
					"stagger_fwd_heavy"
				},
				right = {
					"stagger_fwd_heavy"
				}
			}
		}
	},
	jump_across = {
		stagger_immune = true,
		rotation_duration = 0.1,
		anim_timings = {
			jump_over_gap_4m_2 = 1.2333333333333334,
			jump_over_gap_4m = 1.2333333333333334
		},
		ending_move_states = {
			jump_over_gap_4m_2 = "jumping",
			jump_over_gap_4m = "jumping"
		}
	},
	follow = {
		idle_anim_events = "idle",
		utility_weight = 1,
		follow_vo_interval_t = 3,
		leave_walk_distance = 7,
		run_anim_event = "move_fwd",
		rotation_speed = 5,
		move_speed = 5.4,
		vo_event = "assault",
		walk_anim_event = "move_fwd_walk",
		enter_walk_distance = 4,
		considerations = UtilityConsiderations.melee_follow,
		start_move_anim_events = {
			walking = {
				bwd = "move_bwd_walk",
				fwd = "move_fwd_walk",
				left = "move_left_walk",
				right = "move_right_walk"
			},
			running = {
				bwd = "move_start_bwd",
				fwd = "move_start_fwd",
				left = "move_start_left",
				right = "move_start_right"
			}
		},
		start_move_anim_data = {
			move_start_fwd = {},
			move_start_bwd = {
				sign = 1,
				rad = math.pi
			},
			move_start_left = {
				sign = 1,
				rad = math.pi / 2
			},
			move_start_right = {
				sign = -1,
				rad = math.pi / 2
			}
		},
		start_move_rotation_timings = {
			move_start_right = 0,
			move_start_fwd = 0,
			move_start_bwd = 0,
			move_start_left = 0
		},
		start_rotation_durations = {
			move_start_right = 1.4333333333333333,
			move_start_fwd = 0.26666666666666666,
			move_start_bwd = 1.4333333333333333,
			move_start_left = 1.5
		},
		start_move_event_anim_speed_durations = {
			move_start_fwd = 1.2666666666666666
		}
	},
	assault_follow = {
		idle_anim_events = "idle",
		utility_weight = 1,
		follow_vo_interval_t = 3,
		leave_walk_distance = 7,
		run_anim_event = "move_fwd",
		rotation_speed = 5,
		move_speed = 7,
		vo_event = "assault",
		walk_anim_event = "move_fwd_walk",
		enter_walk_distance = 4,
		considerations = UtilityConsiderations.melee_follow,
		start_move_anim_events = {
			walking = {
				bwd = "move_bwd_walk",
				fwd = "move_fwd_walk",
				left = "move_left_walk",
				right = "move_right_walk"
			},
			running = {
				bwd = "move_start_bwd",
				fwd = "move_start_fwd",
				left = "move_start_left",
				right = "move_start_right"
			}
		},
		start_move_anim_data = {
			move_start_fwd = {},
			move_start_bwd = {
				sign = 1,
				rad = math.pi
			},
			move_start_left = {
				sign = 1,
				rad = math.pi / 2
			},
			move_start_right = {
				sign = -1,
				rad = math.pi / 2
			}
		},
		start_move_rotation_timings = {
			move_start_right = 0,
			move_start_fwd = 0,
			move_start_bwd = 0,
			move_start_left = 0
		},
		start_rotation_durations = {
			move_start_right = 1.4333333333333333,
			move_start_fwd = 0.26666666666666666,
			move_start_bwd = 1.4333333333333333,
			move_start_left = 1.5
		},
		start_move_event_anim_speed_durations = {
			move_start_fwd = 1.2666666666666666
		}
	},
	melee_attack = {
		utility_weight = 5,
		max_z_diff = 3,
		ignore_blocked = true,
		aoe_threat_timing = 0.4,
		considerations = UtilityConsiderations.melee_attack,
		attack_anim_events = {
			normal = {
				"attack_03",
				"attack_04",
				"attack_05",
				"attack_06",
				"attack_standing_combo"
			},
			up = {
				"attack_reach_up"
			},
			down = {
				"attack_down_01"
			}
		},
		attack_anim_damage_timings = {
			attack_05 = 0.9333333333333333,
			attack_down_01 = 1.0666666666666667,
			attack_04 = 0.9333333333333333,
			attack_03 = 0.8,
			attack_reach_up = 0.6923076923076923,
			attack_06 = 0.8095238095238095,
			attack_standing_combo = {
				1,
				1.8666666666666667
			}
		},
		attack_anim_durations = {
			attack_05 = 3.6666666666666665,
			attack_down_01 = 2.6666666666666665,
			attack_04 = 3.3333333333333335,
			attack_03 = 3.3333333333333335,
			attack_reach_up = 1.7435897435897436,
			attack_06 = 2.857142857142857,
			attack_standing_combo = 3
		},
		attack_intensities = {
			ranged = 1,
			melee = 3
		},
		damage_profile = DamageProfileTemplates.chaos_ogryn_houndmaster_default,
		damage_type = damage_types.minion_melee_blunt_elite,
		weapon_reach = {
			default = 3.75,
			attack_reach_up = 4
		},
		stagger_type_reduction = {
			ranged = 50,
			melee = 50
		},
		effect_template = EffectTemplates.chaos_ogryn_houndmaster_electric,
		effect_template_start_timings = {
			attack_05 = 0.3333333333333333,
			attack_04 = 0.3333333333333333,
			attack_03 = 0.3333333333333333,
			attack_06 = 0.23809523809523808,
			attack_standing_combo = 0.3333333333333333
		},
		apply_buff_to_target_unit = {
			buff_template_name = "houndmaster_electrocution",
			buff_keyword = "electrocuted"
		}
	},
	melee_attack_kick = {
		weapon_reach = 3.5,
		utility_weight = 3,
		ignore_blocked = true,
		considerations = UtilityConsiderations.melee_attack,
		attack_anim_events = {
			"attack_push_kick_01"
		},
		attack_anim_damage_timings = {
			attack_push_kick_01 = 0.7407407407407407
		},
		attack_anim_durations = {
			attack_push_kick_01 = 1.9753086419753085
		},
		attack_intensities = {
			ranged = 1,
			melee = 2
		},
		stagger_type_reduction = {
			ranged = 50,
			melee = 50
		},
		damage_profile = DamageProfileTemplates.chaos_ogryn_executor_kick,
		damage_type = damage_types.minion_ogryn_kick
	},
	combo_attack = {
		ignore_blocked = true,
		vo_event = "assault",
		utility_weight = 1,
		move_speed_variable_name = "moving_attack_fwd_speed",
		assault_vo_interval_t = 3,
		moving_attack = true,
		move_speed_variable_lerp_speed = 5,
		ignore_dodge = true,
		weapon_reach = 4,
		aoe_threat_timing = 0.4,
		move_speed = 4,
		considerations = UtilityConsiderations.cultist_berzerker_combo_attack,
		attack_anim_events = {
			"attack_move_combo_01_fast",
			"attack_move_combo_04_fast",
			"attack_move_combo_08"
		},
		attack_anim_damage_timings = {
			attack_move_combo_01_fast = {
				0.7777777777777778,
				1.5833333333333333,
				1.6666666666666667,
				2.4722222222222223,
				2.5277777777777777,
				3.361111111111111,
				3.4444444444444446
			},
			attack_move_combo_04_fast = {
				0.5277777777777778,
				0.8611111111111112,
				1.25,
				1.9444444444444444,
				2.5277777777777777,
				2.611111111111111,
				2.6666666666666665
			},
			attack_move_combo_08 = {
				0.6,
				1.4333333333333333,
				1.5,
				2.6,
				3.466666666666667
			}
		},
		move_start_timings = {
			attack_move_combo_04_fast = 0,
			attack_move_combo_01_fast = 0,
			attack_move_combo_08 = 0
		},
		attack_anim_durations = {
			attack_move_combo_04_fast = 2.9166666666666665,
			attack_move_combo_01_fast = 3.888888888888889,
			attack_move_combo_08 = 3.6666666666666665
		},
		attack_intensities = {
			ranged = 1,
			melee = 2
		},
		damage_profile = DamageProfileTemplates.chaos_ogryn_houndmaster_default,
		damage_type = damage_types.minion_melee_blunt_elite,
		stagger_type_reduction = {
			ranged = 60,
			melee = 60
		},
		animation_move_speed_configs = {
			attack_move_combo_01_fast = {
				{
					value = 4,
					distance = 2.6
				},
				{
					value = 3,
					distance = 2.5
				},
				{
					value = 2,
					distance = 2.2
				},
				{
					value = 1,
					distance = 1.5
				},
				{
					value = 0,
					distance = 0.8
				}
			},
			attack_move_combo_04_fast = {
				{
					value = 4,
					distance = 2.6
				},
				{
					value = 3,
					distance = 2.5
				},
				{
					value = 2,
					distance = 2.2
				},
				{
					value = 1,
					distance = 1.5
				},
				{
					value = 0,
					distance = 0.8
				}
			},
			attack_move_combo_08 = {
				{
					value = 4,
					distance = 3.3
				},
				{
					value = 3,
					distance = 2.3
				},
				{
					value = 2,
					distance = 2.1
				},
				{
					value = 1,
					distance = 1.2
				},
				{
					value = 0,
					distance = 0.86
				}
			}
		},
		effect_template = EffectTemplates.chaos_ogryn_houndmaster_electric,
		effect_template_start_timings = {
			attack_move_combo_04_fast = 0.1388888888888889,
			attack_move_combo_01_fast = 0.1388888888888889,
			attack_move_combo_08 = 0.16666666666666666
		},
		apply_buff_to_target_unit = {
			buff_template_name = "houndmaster_electrocution",
			buff_keyword = "electrocuted"
		}
	},
	blocked = {
		blocked_duration = 1.6666666666666667,
		blocked_anims = {
			"blocked"
		}
	},
	stagger = {
		stagger_anims = {
			light = {
				fwd = {
					"stagger_fwd_light"
				},
				bwd = {
					"stagger_bwd_light"
				},
				left = {
					"stagger_left_light"
				},
				right = {
					"stagger_right_light"
				},
				dwn = {
					"stun_down"
				}
			},
			medium = {
				fwd = {
					"stagger_fwd"
				},
				bwd = {
					"stagger_bwd"
				},
				left = {
					"stagger_left"
				},
				right = {
					"stagger_right"
				},
				dwn = {
					"stagger_medium_downward"
				}
			},
			heavy = {
				fwd = {
					"stagger_fwd_heavy"
				},
				bwd = {
					"stagger_bwd_heavy"
				},
				left = {
					"stagger_left_heavy"
				},
				right = {
					"stagger_right_heavy"
				},
				dwn = {
					"stagger_down_heavy"
				}
			},
			light_ranged = {
				fwd = {
					"stagger_fwd_light"
				},
				bwd = {
					"stagger_bwd_light"
				},
				left = {
					"stagger_left_light"
				},
				right = {
					"stagger_right_light"
				},
				dwn = {
					"stun_down"
				}
			},
			explosion = {
				fwd = {
					"stagger_explosion_fwd"
				},
				bwd = {
					"stagger_explosion_bwd"
				},
				left = {
					"stagger_explosion_left"
				},
				right = {
					"stagger_explosion_right"
				}
			},
			killshot = {
				fwd = {
					"stagger_fwd_light"
				},
				bwd = {
					"stagger_bwd_light"
				},
				left = {
					"stagger_left_light"
				},
				right = {
					"stagger_right_light"
				},
				dwn = {
					"stun_down"
				}
			},
			sticky = {
				bwd = {
					"stagger_front_sticky",
					"stagger_front_sticky_2",
					"stagger_front_sticky_3"
				},
				fwd = {
					"stagger_bwd_sticky",
					"stagger_bwd_sticky_2",
					"stagger_bwd_sticky_3"
				},
				left = {
					"stagger_left_sticky",
					"stagger_left_sticky_2",
					"stagger_left_sticky_3"
				},
				right = {
					"stagger_right_sticky",
					"stagger_right_sticky_2",
					"stagger_right_sticky_3"
				},
				dwn = {
					"stagger_bwd_sticky",
					"stagger_bwd_sticky_2",
					"stagger_bwd_sticky_3"
				}
			},
			electrocuted = {
				bwd = {
					"stagger_front_sticky",
					"stagger_front_sticky_2",
					"stagger_front_sticky_3"
				},
				fwd = {
					"stagger_bwd_sticky",
					"stagger_bwd_sticky_2",
					"stagger_bwd_sticky_3"
				},
				left = {
					"stagger_left_sticky",
					"stagger_left_sticky_2",
					"stagger_left_sticky_3"
				},
				right = {
					"stagger_right_sticky",
					"stagger_right_sticky_2",
					"stagger_right_sticky_3"
				},
				dwn = {
					"stagger_bwd_sticky",
					"stagger_bwd_sticky_2",
					"stagger_bwd_sticky_3"
				}
			},
			blinding = {
				fwd = {
					"stagger_fwd_light"
				},
				bwd = {
					"stagger_bwd_light"
				},
				left = {
					"stagger_left_light"
				},
				right = {
					"stagger_right_light"
				},
				dwn = {
					"stun_down"
				}
			}
		}
	},
	smash_obstacle = {
		rotation_duration = 0.1,
		attack_anim_events = {
			"attack_01",
			"attack_02",
			"attack_03",
			"attack_04"
		},
		attack_anim_damage_timings = {
			attack_01 = 0.6,
			attack_03 = 0.6,
			attack_02 = 0.6,
			attack_04 = 0.6
		},
		attack_anim_durations = {
			attack_01 = 1.7241379310344827,
			attack_03 = 1.7241379310344827,
			attack_02 = 1.7241379310344827,
			attack_04 = 1.728395061728395
		},
		damage_profile = DamageProfileTemplates.chaos_ogryn_executor_default,
		damage_type = damage_types.minion_melee_blunt_elite
	},
	open_door = {
		rotation_duration = 0.1,
		stagger_immune = true
	},
	exit_spawner = {
		run_anim_event = "move_fwd"
	}
}

return action_data
