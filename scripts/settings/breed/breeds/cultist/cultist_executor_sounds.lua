local RenegadeCommonSounds = require("scripts/settings/breed/breeds/renegade/renegade_common_sounds")
local sound_data = {
	events = {
		footstep_land = "wwise/events/minions/play_minion_footsteps_barefoot_land",
		ground_impact = "wwise/events/minions/play_shared_foley_armoured_body_fall_medium",
		vce_special_attack = "wwise/events/minions/play_enemy_cultist_berzerker__melee_attack_short_vce",
		vce_death = "wwise/events/minions/play_enemy_cultist_berzerker__death_vce",
		vce_death_long = "wwise/events/minions/play_enemy_traitor_executor__death_long_vce",
		vce_melee_attack_short = "wwise/events/minions/play_enemy_cultist_berzerker__combat_idle_vce",
		vce_hurt = "wwise/events/minions/play_enemy_cultist_berzerker__hurt_vce",
		vce_grunt = "wwise/events/minions/play_enemy_cultist_berzerker__grunt_vce",
		vce_melee_attack_normal = "wwise/events/minions/play_enemy_cultist_berzerker__melee_attack_normal_vce",
		vce_death_gassed = "wwise/events/minions/play_enemy_traitor_executor__death_long_gassed_vce",
		swing = "wwise/events/weapon/play_heavy_swing_hit_slashing",
		foley_movement_long = "wwise/events/minions/play_shared_foley_chaos_cultist_light_drastic_short",
		vce_breathing_running = "wwise/events/minions/play_enemy_traitor_executor__running_breath_vce",
		footstep = "wwise/events/minions/play_minion_footsteps_wrapped_feet_specials",
		run_foley = "wwise/events/minions/play_shared_foley_chaos_cultist_light_run"
	},
	use_proximity_culling = {
		footstep_land = false,
		footstep = false,
		vce_special_attack = false,
		swing = false,
		vce_melee_attack_short = false
	}
}

table.add_missing(sound_data.events, RenegadeCommonSounds.events)
table.add_missing(sound_data.use_proximity_culling, RenegadeCommonSounds.use_proximity_culling)

return sound_data
