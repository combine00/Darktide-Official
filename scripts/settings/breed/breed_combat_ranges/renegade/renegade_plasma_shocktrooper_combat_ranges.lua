local combat_ranges = {
	name = "renegade_plasma_shocktrooper",
	calculate_target_velocity_dot = true,
	target_velocity_dot_reset = 0.5,
	starting_combat_range = "far",
	config = {
		far = {
			{
				distance = 22,
				require_line_of_sight = true,
				enter_combat_range_flag = true,
				sticky_time = 0,
				switch_anim_state = "to_ranged",
				distance_operator = "lesser",
				switch_combat_range = "close"
			}
		},
		close = {
			{
				switch_combat_range = "far",
				distance_operator = "greater",
				distance = 28,
				sticky_time = 0
			}
		}
	}
}

return combat_ranges
