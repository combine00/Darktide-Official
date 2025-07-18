local mission_objective_templates = {
	lm_cooling = {
		objectives = {
			objective_lm_cooling_leave_start = {
				description = "loc_objective_lm_cooling_leave_start_desc",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_leave_start_header"
			},
			objective_lm_cooling_locate = {
				description = "loc_objective_lm_cooling_locate_desc",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_locate_header"
			},
			objective_lm_cooling_decrypt = {
				description = "loc_objective_lm_cooling_decrypt_desc",
				music_wwise_state = "hacking_event",
				header = "loc_objective_lm_cooling_decrypt_header",
				event_type = "mid_event",
				progress_bar = true,
				mission_objective_type = "decode"
			},
			objective_lm_cooling_send_elevator = {
				description = "loc_objective_lm_cooling_send_elevator_desc",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_send_elevator_header"
			},
			objective_lm_cooling_descend = {
				description = "loc_objective_lm_cooling_descend_desc",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_descend_header"
			},
			objective_lm_cooling_unlock = {
				description = "loc_objective_lm_cooling_unlock_desc",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_unlock_header"
			},
			objective_lm_cooling_reactor = {
				description = "loc_objective_lm_cooling_reactor_desc",
				music_wwise_state = "collect_event",
				turn_off_backfill = true,
				header = "loc_objective_lm_cooling_reactor_header",
				event_type = "end_event",
				mission_objective_type = "luggable"
			},
			objective_lm_cooling_machine = {
				description = "loc_objective_lm_cooling_machine_desc",
				music_wwise_state = "collect_event",
				header = "loc_objective_lm_cooling_machine_header",
				event_type = "end_event",
				mission_objective_type = "goal"
			},
			objective_lm_cooling_wait = {
				description = "loc_objective_lm_cooling_wait_desc",
				progress_bar = true,
				music_wwise_state = "collect_event",
				header = "loc_objective_lm_cooling_wait_header",
				event_type = "end_event",
				duration = 30,
				mission_objective_type = "timed"
			},
			objective_lm_cooling_clear = {
				description = "loc_objective_lm_cooling_clear_desc",
				music_wwise_state = "collect_event",
				header = "loc_objective_lm_cooling_clear_header",
				event_type = "end_event",
				mission_objective_type = "goal"
			},
			objective_lm_cooling_escape = {
				description = "loc_objective_lm_cooling_escape_desc",
				music_wwise_state = "escape_event",
				mission_objective_type = "goal",
				header = "loc_objective_lm_cooling_escape_header"
			}
		}
	}
}

return mission_objective_templates
