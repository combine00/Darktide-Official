local default_ingame_input_filters = {
	move_keys = {
		filter_type = "virtual_axis",
		input_mappings = {
			right = "keyboard_move_right",
			back = "keyboard_move_backward",
			left = "keyboard_move_left",
			forward = "keyboard_move_forward"
		}
	},
	axis_virtual_move_forward = {
		filter_type = "vector_y",
		input_mappings = "move_controller"
	},
	axis_virtual_move_backward = {
		filter_type = "vector_y",
		input_mappings = "move_controller",
		scale = -1
	},
	axis_virtual_move_right = {
		filter_type = "vector_x",
		input_mappings = "move_controller"
	},
	axis_virtual_move_left = {
		filter_type = "vector_x",
		input_mappings = "move_controller",
		scale = -1
	},
	move_forward = {
		filter_type = "scalar_combine",
		to_bool = false,
		max_value = 1,
		min_value = 0,
		input_mappings = {
			button_1 = "axis_virtual_move_forward",
			button_2 = "keyboard_move_forward"
		}
	},
	move_backward = {
		filter_type = "scalar_combine",
		to_bool = false,
		max_value = 1,
		min_value = 0,
		input_mappings = {
			button_1 = "axis_virtual_move_backward",
			button_2 = "keyboard_move_backward"
		}
	},
	move_right = {
		filter_type = "scalar_combine",
		to_bool = false,
		max_value = 1,
		min_value = 0,
		input_mappings = {
			button_1 = "axis_virtual_move_right",
			button_2 = "keyboard_move_right"
		}
	},
	move_left = {
		filter_type = "scalar_combine",
		to_bool = false,
		max_value = 1,
		min_value = 0,
		input_mappings = {
			button_1 = "axis_virtual_move_left",
			button_2 = "keyboard_move_left"
		}
	},
	move = {
		filter_type = "axis_combine",
		input_mappings = {
			source2 = "move_controller",
			source1 = "move_keys"
		}
	},
	look = {
		filter_type = "scale_vector3",
		input_mappings = "look_raw",
		scale = "mouse_look_scale",
		invert_look_y = "mouse_invert_look_y"
	},
	look_ranged = {
		filter_type = "scale_vector3",
		input_mappings = "look_raw",
		scale = "mouse_look_scale_ranged",
		invert_look_y = "mouse_invert_look_y"
	},
	look_ranged_alternate_fire = {
		filter_type = "scale_vector3",
		input_mappings = "look_raw",
		scale = "mouse_look_scale_ranged_alternate_fire",
		invert_look_y = "mouse_invert_look_y"
	},
	look_controller = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0.2,
		response_curve = "controller_response_curve",
		threshold = 0.925,
		multiplier_min_x = 2,
		accelerate_time_ref = 0.5,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 0.75,
		multiplier_x = 7,
		response_curve_strength = "controller_response_curve_strength",
		scale_y = "controller_look_scale_vertical",
		power_of = 1.75,
		scale = "controller_look_scale",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_improved = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0,
		response_curve = "controller_response_curve",
		threshold = 0.925,
		multiplier_min_x = 2,
		accelerate_time_ref = 0.2,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 1.5,
		multiplier_x = 5.5,
		x_acceleration_threshold = 0.4,
		response_curve_strength = "controller_response_curve_strength",
		scale_y = "controller_look_scale_vertical",
		power_of = 1.75,
		scale = "controller_look_scale",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_lunging = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0,
		response_curve = "controller_response_curve",
		threshold = 0.925,
		multiplier_min_x = 1,
		accelerate_time_ref = 0.5,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 0.75,
		multiplier_x = 2.2,
		response_curve_strength = "controller_response_curve_strength",
		scale_y = "controller_look_scale_vertical",
		power_of = 1,
		scale = "controller_look_scale",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_ranged = {
		turnaround_threshold = 0.925,
		multiplier_min_x = 1.9,
		acceleration_delay = 0.05,
		turnaround_time_ref = 0.75,
		response_curve = "controller_response_curve_ranged",
		accelerate_time_ref = 0.6,
		multiplier_x = 4.6,
		turnaround_multiplier_x = 12,
		turnaround_delay = 0.01,
		response_curve_strength = "controller_response_curve_strength_ranged",
		scale_y = "controller_look_scale_vertical_ranged",
		power_of = 2,
		enable_acceleration = "controller_enable_acceleration",
		invert_look_y = "controller_invert_look_y",
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		threshold = 0.925,
		multiplier_y = 0.9,
		scale = "controller_look_scale_ranged",
		turnaround_power_of = 2
	},
	look_controller_ranged_improved = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0,
		response_curve = "controller_response_curve_ranged",
		threshold = 0.925,
		multiplier_min_x = 2,
		accelerate_time_ref = 0.2,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 1.5,
		multiplier_x = 5.5,
		x_acceleration_threshold = 0.4,
		response_curve_strength = "controller_response_curve_strength_ranged",
		scale_y = "controller_look_scale_vertical_ranged",
		power_of = 1.75,
		scale = "controller_look_scale_ranged",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_ranged_alternate_fire = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0,
		response_curve = "controller_response_curve_ranged",
		threshold = 0.8,
		multiplier_min_x = 0.45,
		accelerate_time_ref = 0.3,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 0.8,
		multiplier_x = 1.9,
		response_curve_strength = "controller_response_curve_strength_ranged",
		scale_y = "controller_look_scale_vertical_ranged_alternate_fire",
		power_of = 1.1,
		scale = "controller_look_scale_ranged_alternate_fire",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_ranged_alternate_fire_improved = {
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		acceleration_delay = 0,
		response_curve = "controller_response_curve_ranged",
		threshold = 0.925,
		multiplier_min_x = 1,
		accelerate_time_ref = 0.1,
		enable_acceleration = "controller_enable_acceleration",
		multiplier_y = 0.8,
		multiplier_x = 1.9,
		x_acceleration_threshold = 0.4,
		response_curve_strength = "controller_response_curve_strength_ranged",
		scale_y = "controller_look_scale_vertical_ranged_alternate_fire",
		power_of = 1.75,
		scale = "controller_look_scale_ranged_alternate_fire",
		invert_look_y = "controller_invert_look_y"
	},
	look_controller_melee = {
		turnaround_threshold = 0.925,
		multiplier_min_x = 2.5,
		acceleration_delay = 0.01,
		turnaround_time_ref = 0.75,
		response_curve = "controller_response_curve",
		accelerate_time_ref = 0.15,
		multiplier_x = 3.6,
		turnaround_multiplier_x = 3,
		turnaround_delay = 0.01,
		response_curve_strength = "controller_response_curve_strength",
		scale_y = "controller_look_scale_vertical",
		power_of = 1.5,
		enable_acceleration = "controller_enable_acceleration",
		invert_look_y = "controller_invert_look_y",
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		threshold = 0.65,
		multiplier_y = 1,
		scale = "controller_look_scale",
		turnaround_power_of = 2
	},
	look_controller_melee_sticky = {
		turnaround_threshold = 0.925,
		multiplier_min_x = 1,
		acceleration_delay = 0,
		turnaround_time_ref = 0.75,
		response_curve = "controller_response_curve",
		accelerate_time_ref = 0.3,
		multiplier_x = 1,
		turnaround_multiplier_x = 3,
		turnaround_delay = 0.01,
		response_curve_strength = "controller_response_curve_strength",
		scale_y = "controller_look_scale_vertical",
		power_of = 1,
		enable_acceleration = "controller_enable_acceleration",
		invert_look_y = "controller_invert_look_y",
		filter_type = "scale_vector3_xy_accelerated_x",
		input_mappings = "look_raw_controller",
		threshold = 0.65,
		multiplier_y = 1,
		scale = "controller_look_scale",
		turnaround_power_of = 2
	}
}

return settings("DefaultIngameInputFilters", default_ingame_input_filters)
