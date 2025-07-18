local CompanionDogSettings = require("scripts/utilities/companion/companion_dog_settings")
local idle_circle_distances = {
	outer_circle_distance = 2.5,
	inner_circle_distance = 0.75
}
local hub_far_distance = idle_circle_distances.outer_circle_distance * 2
local move_to_position_default = {
	too_close_distance = 1.5,
	rotation_speed = 20,
	enable_disable_locomotion_speed = false,
	skip_start_animation_event = "to_walk",
	skip_start_anim = true,
	speed = 5,
	leave_distance = 16,
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
		max_acceleration = 12,
		max_speed_multiplier = 1.8,
		max_deceleration = 8
	},
	dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
	dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_hub_config,
	dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_hub_config
}
local action_data = {
	name = "companion_dog_hub",
	idle = {
		anim_events = {
			"idle_to_sit",
			"idle"
		}
	},
	manual_teleport = {
		wait_time = 0.1
	},
	move_close_to_owner_selector = {
		distance_from_owner = 2.85,
		angle_rotation_for_check = 40,
		idle_circle_distances = idle_circle_distances,
		far_distance = hub_far_distance,
		close_distance = idle_circle_distances.inner_circle_distance
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
	companion_has_move_position = {
		reset_position_timer = 0.1,
		override_lrb_to_use_owner_speed = true,
		follow_owner_cooldown = 1,
		dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
		dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_hub_config,
		dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_hub_config,
		companion_cone_check = {
			angle = 90
		}
	},
	follow = {
		reset_position_timer = 0.1,
		follow_owner_cooldown = 1,
		idle_circle_distances = idle_circle_distances,
		dog_owner_follow_config = CompanionDogSettings.dog_owner_follow_config,
		dog_forward_follow_config = CompanionDogSettings.dog_forward_follow_hub_config,
		dog_lrb_follow_config = CompanionDogSettings.dog_lrb_follow_hub_config,
		far_distance = hub_far_distance,
		cone_angle = math.pi / 3
	},
	move_to_position = table.merge(table.clone(move_to_position_default), {
		stop_at_target_position = true,
		arrived_at_distance_threshold_sq = 1
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
	hub_interaction_with_player_selector = {
		rotation_speed = 1,
		relocation_speed = 1
	},
	hub_interaction_move_to_position = table.merge(table.clone(move_to_position_default), {
		stop_when_not_following_path = true,
		stop_at_target_position = true
	}),
	start_hub_interaction_with_player = table.merge(table.clone(move_to_position_default), {
		stop_at_target_position = true
	})
}

return action_data
