local sound_data = {
	events = {
		vce_awaken_short = "wwise/events/minions/play_enemy_daemonhost_alert_scream_short",
		ground_impact = "wwise/events/minions/play_enemy_foley_body_impact_medium_ground_gore",
		mutator_awakened_stinger = "wwise/events/minions/play_daemonhost_mutator_awakened_stinger",
		stop_vce = "wwise/events/minions/stop_all_daemonhost_vce",
		vce_lifted = "wwise/events/minions/play_enemy_daemonhost_lifted_vce",
		vce_struggle = "wwise/events/minions/play_enemy_daemonhost_struggle_vce",
		mutator_death_stinger = "wwise/events/minions/play_daemonhost_mutator_death_stinger",
		vce_attack_long = "wwise/events/minions/play_enemy_daemonhost_attack_vce_longer",
		vce_awaken = "wwise/events/minions/play_enemy_daemonhost_alert_scream",
		vce_attack_short = "wwise/events/minions/play_enemy_daemonhost_attack_vce_short"
	},
	use_proximity_culling = {
		vce_attack_long = false,
		vce_awaken_short = false,
		vce_awaken = false,
		stop_vce = false,
		vce_lifted = false,
		vce_struggle = false,
		vce_attack_short = false
	}
}

return sound_data
