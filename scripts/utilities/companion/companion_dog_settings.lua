local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local CompanionDogSettings = {
	dog_forward_follow_config = {
		crouch_adapt_threshold_multiplier = 1,
		adapt_threshold_multiplier = 1,
		outer_circle_max_distance = 6.5,
		seconds_to_enlarge_adaptive_angle = 0.5,
		inner_circle_min_distance = 2,
		inner_circle_max_distance = 4,
		numbers_of_adaptive_angle_checks = 5,
		direction_timer = 0,
		outer_circle_min_distance = 4,
		max_angle_per_second = 135,
		front_angle = 15,
		side_angle = 40,
		angle_rotation_for_check = 80,
		seconds_for_movement_prediction = 0,
		min_owner_speed = PlayerCharacterConstants.crouch_move_speed * 1.25,
		max_owner_speed = PlayerCharacterConstants.move_speed * 1.25,
		follow_aim = {
			player = {
				0,
				4
			},
			move_to_position = {
				4,
				math.huge
			}
		}
	},
	dog_lrb_follow_config = {
		max_angle_per_second = 135,
		outer_circle_min_distance = 4,
		outer_circle_max_distance = 6.5,
		seconds_for_movement_prediction = 0.1,
		inner_circle_min_distance = 2,
		inner_circle_max_distance = 4,
		direction_timer = 0,
		front_angle = 0,
		side_angle = 60,
		adapt_threshold_multiplier = 1,
		angle_rotation_for_check = 80,
		crouch_adapt_threshold_multiplier = 1,
		min_owner_speed = PlayerCharacterConstants.crouch_move_speed * 1.25,
		max_owner_speed = PlayerCharacterConstants.move_speed * 1.25,
		follow_aim = {
			player = {
				0,
				4
			},
			move_to_position = {
				4,
				math.huge
			}
		}
	}
}
local dog_forward_follow_hub_config = table.clone(CompanionDogSettings.dog_forward_follow_config)
dog_forward_follow_hub_config.inner_circle_min_distance = 1.25
dog_forward_follow_hub_config.inner_circle_max_distance = 2.25
dog_forward_follow_hub_config.outer_circle_min_distance = 3.5
dog_forward_follow_hub_config.outer_circle_max_distance = 5
CompanionDogSettings.dog_forward_follow_hub_config = dog_forward_follow_hub_config
local dog_lrb_follow_hub_config = table.clone(CompanionDogSettings.dog_lrb_follow_config)
dog_lrb_follow_hub_config.inner_circle_min_distance = 1.25
dog_lrb_follow_hub_config.inner_circle_max_distance = 2.25
dog_lrb_follow_hub_config.outer_circle_min_distance = 3.5
dog_lrb_follow_hub_config.outer_circle_max_distance = 5
CompanionDogSettings.dog_lrb_follow_hub_config = dog_lrb_follow_hub_config
CompanionDogSettings.dog_owner_follow_config = {
	adapt_threshold_multiplier = 1,
	crouch_adapt_threshold_multiplier = 1,
	angle_rotation_for_check = 80,
	follow_aim = {
		move_to_position = {
			0,
			math.huge
		}
	}
}
CompanionDogSettings.dog_leap_settings = {
	leap_target_z_offset = -0.1,
	leap_leave_distance = 10,
	leap_target_start_z_offset = 0.1,
	leap_target_node_name = "j_spine",
	close_distance = 2,
	leap_max_time_in_flight = 10,
	leap_speed_close_distance = 11,
	leap_radius = 0.05,
	move_time_to_use_fast_jump = 0.5,
	leap_speed = 21,
	leap_num_sections = 10,
	leap_acceptable_accuracy = 0.1,
	leap_gravity = 13.82,
	long_leap_min_speed = 6,
	collision_radius = 0.5,
	leap_collision_filter = "filter_minion_mover",
	leap_ray_trace_radius = 0.2,
	max_jump_angle = math.pi / 3,
	max_jump_angle_close_distance = math.pi / 6
}
CompanionDogSettings.leaning = {
	right_lean_value = 2,
	left_lean_value = 0,
	max_dot_lean_value = 0.1,
	lean_variable_name = "gallop_lean",
	path_lean_node_offset = 8,
	lean_speed = 5,
	default_lean_value = 1
}
CompanionDogSettings.initial_target_disable_cooldown = 1

return CompanionDogSettings
