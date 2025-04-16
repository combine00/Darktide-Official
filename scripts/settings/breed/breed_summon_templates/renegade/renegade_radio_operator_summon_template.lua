local summon_templates = {
	renegade_radio_operator = {
		wwise_event_probability = 0.25,
		requires_owner = false,
		wwise_on_death_events = {
			"wwise/events/minions/play_minion_captain__force_field_overload_vce"
		}
	}
}

return summon_templates
