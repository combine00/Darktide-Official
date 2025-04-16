local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local CompanionDogSettings = {
	dog_forward_follow_config = {
		max_angle_per_second = 135,
		outer_circle_min_distance = 4,
		outer_circle_max_distance = 6.5,
		seconds_for_movement_prediction = 0.1,
		inner_circle_min_distance = 2,
		inner_circle_max_distance = 4,
		direction_timer = 0,
		front_angle = 15,
		side_angle = 40,
		angle_rotation_for_check = 80,
		min_owner_speed = PlayerCharacterConstants.crouch_move_speed * 1.5,
		max_owner_speed = PlayerCharacterConstants.move_speed * 1.5
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
		angle_rotation_for_check = 80,
		min_owner_speed = PlayerCharacterConstants.crouch_move_speed * 1.5,
		max_owner_speed = PlayerCharacterConstants.move_speed * 1.5
	},
	dog_owner_follow_config = {
		angle_rotation_for_check = 80
	},
	dog_leap_settings = {
		long_leap_start_offset_distance = 8,
		leap_target_node_name = "j_spine",
		leap_acceptable_accuracy = 0.1,
		collision_radius = 0.5,
		leap_gravity = 13.82,
		short_distance = 9.5,
		leap_max_time_in_flight = 10,
		long_leap_min_speed = 6,
		leap_radius = 0.5,
		leap_collision_filter = "filter_minion_mover",
		leap_target_z_offset = -0.1,
		leap_speed = 21,
		leap_num_sections = 10
	},
	leaning = {
		right_lean_value = 2,
		left_lean_value = 0,
		max_dot_lean_value = 0.01,
		lean_variable_name = "gallop_lean",
		path_lean_node_offset = 8,
		lean_speed = 5,
		default_lean_value = 1
	}
}

return CompanionDogSettings
