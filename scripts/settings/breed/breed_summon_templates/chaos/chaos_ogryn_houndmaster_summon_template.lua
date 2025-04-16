local summon_templates = {
	chaos_ogryn_houndmaster = {
		requires_owner = true,
		initial_delay = 1,
		wwise_event_probability = 0.25,
		wwise_on_death_events = {
			"wwise/events/minions/play_minion_captain__force_field_overload_vce"
		},
		wwise_on_success_events = {
			"wwise/events/minions/play_minion_captain__force_field_overload_vce"
		}
	}
}

return summon_templates
