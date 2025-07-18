local CompanionDogSettings = require("scripts/utilities/companion/companion_dog_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local ExplosionTemplates = require("scripts/settings/damage/explosion_templates")
local GroundImpactFxTemplates = require("scripts/settings/fx/ground_impact_fx_templates")
local EffectTemplates = require("scripts/settings/fx/effect_templates")
local damage_types = DamageSettings.damage_types
local idle_circle_distances = {
	outer_circle_distance = 4,
	inner_circle_distance = 2
}
local move_to_position_default = {
	push_enemies_radius = 0.5,
	enable_disable_locomotion_speed = false,
	skip_start_animation_event = "to_walk",
	push_enemies_power_level = 50,
	speed = 5,
	rotation_speed = 20,
	skip_start_animation_on_crouch = true,
	start_move_anim_events = {
		bwd = "run_start_bwd",
		fwd = "run_start_fwd",
		left = "run_start_left",
		right = "run_start_right"
	},
	start_move_anim_data = {
		run_start_fwd = {},
		run_start_bwd = {
			sign = 1,
			rad = math.pi
		},
		run_start_left = {
			sign = 1,
			rad = math.pi / 2
		},
		run_start_right = {
			sign = -1,
			rad = math.pi / 2
		}
	},
	start_move_rotation_timings = {
		run_start_right = 0,
		run_start_left = 0,
		run_start_bwd = 0
	},
	start_rotation_durations = {
		run_start_right = 0.23333333333333334,
		run_start_left = 0.23333333333333334,
		run_start_bwd = 0.26666666666666666
	},
	start_move_event_anim_speed_durations = {
		run_start_fwd = 0
	},
	idle_anim_events = {
		"idle"
	},
	adapt_speed = {
		speed_timer = 0,
		epsilon = 0.3,
		slow_max_deceleration = 16,
		slow_epsilon = 1.3,
		min_speed_multiplier = 0,
		max_acceleration = 8,
		max_speed_multiplier = 2,
		max_deceleration = 8
	},
	push_enemies_damage_profile = DamageProfileTemplates.chaos_hound_push,
	push_ignored_breeds = {
		chaos_poxwalker_bomber = true
	},
	dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
	dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_config,
	dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_config
}
local action_data = {
	name = "companion_dog",
	idle = {
		anim_events = "idle"
	},
	manual_teleport = {
		wait_time = 1
	},
	move_with_platform = {
		anim_events = "idle"
	},
	companion_unstuck = {
		waiting_time = 0.1,
		anim_events = "idle"
	},
	move_close_to_owner_follow_selector = {
		angle_rotation_for_check = 40,
		close_distance = 2,
		idle_circle_distances = idle_circle_distances,
		far_distance = math.huge,
		companion_cone_check = {
			angle = 90
		}
	},
	move_close_to_owner_selector = {
		angle_rotation_for_check = 40,
		idle_circle_distances = idle_circle_distances,
		far_distance = idle_circle_distances.outer_circle_distance,
		close_distance = idle_circle_distances.inner_circle_distance,
		angle_to_prioritize = {
			-40,
			40
		}
	},
	falling = {
		leap_cooldown = 1.5
	},
	companion_has_move_position = {
		reset_position_timer = 0.1,
		follow_owner_cooldown = 1,
		dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
		dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_config,
		dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_config,
		companion_cone_check = {
			angle = 90
		}
	},
	follow = {
		reset_position_timer = 0.1,
		follow_owner_cooldown = 1,
		idle_circle_distances = idle_circle_distances,
		dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
		dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_config,
		dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_config
	},
	move_to_position = table.merge(table.clone(move_to_position_default), {
		stop_at_target_position = true,
		arrived_at_distance_threshold_sq = 1,
		effect_template = EffectTemplates.companion_dog_breath_effect
	}),
	move_close_to_owner_action = table.merge(table.clone(move_to_position_default), {
		stop_at_target_position = true,
		arrived_at_distance_threshold_sq = 0.1,
		follow_aim = {
			player = {
				0,
				math.huge
			}
		}
	}),
	approach_target = {
		forbid_fast_jump_t = 0.5,
		speed = 6,
		push_enemies_radius = 0.5,
		force_check_leap_distance = 1.5,
		push_enemies_power_level = 50,
		fast_jump_speed_threshold = 7,
		rotation_speed = 20,
		leap_cooldown = 1.5,
		start_move_anim_events = {
			bwd = "run_start_bwd",
			fwd = "run_start_fwd",
			left = "run_start_left",
			right = "run_start_right"
		},
		start_move_anim_data = {
			run_start_fwd = {},
			run_start_bwd = {
				sign = 1,
				rad = math.pi
			},
			run_start_left = {
				sign = 1,
				rad = math.pi / 2
			},
			run_start_right = {
				sign = -1,
				rad = math.pi / 2
			}
		},
		start_move_rotation_timings = {
			run_start_right = 0,
			run_start_left = 0,
			run_start_bwd = 0
		},
		start_rotation_durations = {
			run_start_right = 0.23333333333333334,
			run_start_left = 0.23333333333333334,
			run_start_bwd = 0.26666666666666666
		},
		start_move_event_anim_speed_durations = {
			run_start_fwd = 0.6666666666666666
		},
		adapt_speed = {
			speed_timer = 0,
			epsilon = 0.3,
			slow_max_deceleration = 16,
			slow_epsilon = 1.3,
			min_speed_multiplier = 1.2,
			max_acceleration = 8,
			max_speed_multiplier = 2,
			max_deceleration = 8
		},
		idle_anim_events = {
			"idle"
		},
		push_enemies_damage_profile = DamageProfileTemplates.chaos_hound_push,
		push_ignored_breeds = {
			chaos_poxwalker_bomber = true
		},
		max_angle_for_fast_jump = math.pi / 6
	},
	leap = {
		controlled_stagger = true,
		stop_duration = 0.5,
		land_impact_timing = 0,
		controlled_stagger_min_distance = 0,
		push_minions_power_level = 2000,
		max_pounce_dot = 0.1,
		start_leap_anim_event_short = "attack_leap_short",
		start_leap_anim_event = "attack_leap_start",
		start_duration = 0.1,
		push_enemies_radius = 1.25,
		land_anim_event = "leap_land",
		wall_jump_rotation_timing = 0.16666666666666666,
		start_duration_short = 0.8,
		push_minions_radius = 2,
		push_enemies_power_level = 2000,
		wall_land_anim_event = "leap_hit_wall_land",
		stuck_between_walls_time = 10,
		leap_cooldown = 1.5,
		landing_duration = 1.5,
		stuck_time = 3,
		wall_jump_unobstructed_height = 2.5,
		start_move_speed = 12,
		wall_jump_speed = 10,
		aoe_bot_threat_duration = 1,
		wall_jump_nav_mesh_offset = 2,
		push_minions_side_relation = "allied",
		wall_jump_align_rotation_speed = 30,
		aoe_bot_threat_timing = 0.5,
		wall_land_length = 3,
		in_air_stagger_duration = 0.9,
		wall_jump_anim_event = "leap_hit_wall",
		stop_anim = "run_to_stop",
		wall_jump_rotation_duration = 0.5333333333333333,
		wall_land_duration = 0.5333333333333333,
		extra_push_wwise_event = "wwise/events/weapon/play_specials_push_unarmored",
		push_minions_damage_profile = DamageProfileTemplates.cyber_mastiff_push,
		push_enemies_damage_profile = DamageProfileTemplates.cyber_mastiff_push,
		aoe_bot_threat_size = Vector3Box(1.5, 2, 2),
		in_air_staggers = {
			"stagger_inair_bwd"
		},
		land_ground_impact_fx_template = GroundImpactFxTemplates.chaos_hound_leap_land,
		effect_template = EffectTemplates.companion_dog_leap_attack_effect
	},
	target_pounced = {
		lerp_position_time = 0.06666666666666667,
		hit_position_node = "j_jaw",
		damage_start_time = 0.6666666666666666,
		explosion_power_level = 500,
		damage_frequency = 1.3333333333333333,
		damage_type = damage_types.chaos_hound_tearing,
		enter_explosion_template = ExplosionTemplates.companion_dog_pounced_explosion,
		effect_template = EffectTemplates.companion_dog_pounce_attack_effect
	},
	target_pounced_and_escape = {
		pounce_back_gravity = 27,
		hit_position_node = "j_jaw",
		explosion_power_level = 500,
		leap_cooldown = 1.5,
		damage_type = damage_types.chaos_hound_tearing,
		enter_explosion_template = ExplosionTemplates.companion_dog_pounced_explosion,
		select_jump_off_direction_settings = {
			max_distance_check = 20,
			estimated_animation_angle = 15,
			sweep_radius = 0.5,
			angle_frequency_check = 15,
			animation_variable_name = "attack_start_angle",
			angle_range = 180
		}
	},
	move_around_enemy = {
		max_distance_to_target = 8,
		min_distance_to_target = 4,
		push_enemies_radius = 0.5,
		new_position_cooldown = 0.2,
		push_enemies_power_level = 50,
		speed = 7,
		rotation_speed = 20,
		offset_distance = 0.5,
		start_move_anim_events = {
			bwd = "run_start_bwd",
			fwd = "run_start_fwd",
			left = "run_start_left",
			right = "run_start_right"
		},
		start_move_anim_data = {
			run_start_fwd = {},
			run_start_bwd = {
				sign = 1,
				rad = math.pi
			},
			run_start_left = {
				sign = 1,
				rad = math.pi / 2
			},
			run_start_right = {
				sign = -1,
				rad = math.pi / 2
			}
		},
		start_move_rotation_timings = {
			run_start_right = 0,
			run_start_left = 0,
			run_start_bwd = 0
		},
		start_rotation_durations = {
			run_start_right = 0.23333333333333334,
			run_start_left = 0.23333333333333334,
			run_start_bwd = 0.26666666666666666
		},
		start_move_event_anim_speed_durations = {
			run_start_fwd = 0.6666666666666666
		},
		idle_anim_events = {
			"idle"
		},
		push_enemies_damage_profile = DamageProfileTemplates.chaos_hound_push,
		push_ignored_breeds = {
			chaos_poxwalker_bomber = true
		},
		rotation_angle = math.pi / 3
	},
	climb = {
		stagger_immune = true,
		rotation_duration = 0.1,
		anim_timings = {
			jump_up_3m = 0.9333333333333333,
			jump_down_land_3m = 1.3333333333333333,
			jump_up_fence_1m = 0.8333333333333334,
			jump_down_fence_land_1m = 0.2,
			jump_down_land = 0.3333333333333333,
			jump_down_land_1m = 1.1666666666666667,
			jump_up_fence_3m = 0.8333333333333334,
			jump_up_5m = 1.4333333333333333,
			jump_up_fence_5m = 1.0333333333333334,
			jump_up_1m = 0.8666666666666667
		},
		ending_move_states = {
			jump_up_3m = "jumping",
			jump_down_fence_land_1m = "moving",
			jump_up_5m = "jumping",
			jump_down_land_5m = "jumping",
			jump_down_land_3m = "jumping",
			jump_down_land = "moving",
			jump_up_1m = "jumping",
			jump_down_land_1m = "moving"
		},
		blend_timings = {
			jump_up_3m = 0.1,
			jump_down_land_3m = 0,
			jump_down = 0,
			jump_down_fence_land_1m = 0,
			jump_down_2 = 0,
			jump_up_fence_1m = 0.1,
			jump_down_land = 0,
			jump_down_land_1m = 0,
			jump_up_fence_3m = 0.1,
			jump_up_5m = 0.1,
			jump_up_fence_5m = 0.1,
			jump_down_1m = 0,
			jump_up_1m = 0.1
		}
	},
	jump_across = {
		stagger_immune = true,
		rotation_duration = 0.1,
		anim_timings = {
			jump_vault_left_1 = 1,
			jump_over_gap_4m = 0.7333333333333333,
			jump_over_gap_4m_2 = 0.7333333333333333
		},
		ending_move_states = {
			jump_vault_left_1 = "moving",
			jump_over_gap_4m = "moving",
			jump_over_gap_4m_2 = "moving"
		}
	},
	open_door = {
		rotation_duration = 0.1
	},
	teleport = {
		keep_outline = true
	}
}

return action_data
