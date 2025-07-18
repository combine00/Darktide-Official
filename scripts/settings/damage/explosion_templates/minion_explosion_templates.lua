local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local damage_types = DamageSettings.damage_types
local explosion_templates = {
	renegade_grenadier_fire_grenade_impact = {
		damage_falloff = false,
		radius = 2.5,
		min_radius = 2,
		scalable_radius = true,
		close_radius = 1,
		collision_filter = "filter_minion_explosion",
		static_power_level = 0,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact_close,
		damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/weapons/grenades/flame_grenade_initial_blast"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_flame_minion",
			"wwise/events/weapon/play_explosion_refl_small"
		}
	},
	cultist_grenadier_gas_grenade_impact = {
		damage_falloff = false,
		radius = 2,
		min_radius = 1.25,
		scalable_radius = true,
		close_radius = 1.25,
		collision_filter = "filter_minion_explosion",
		static_power_level = 0,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact_close,
		damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_gas",
			"wwise/events/weapon/play_explosion_refl_small"
		}
	},
	twin_gas_grenade_impact = {
		damage_falloff = false,
		radius = 3,
		min_radius = 1.25,
		scalable_radius = true,
		close_radius = 1.5,
		collision_filter = "filter_minion_explosion",
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.twin_grenade_explosion,
		damage_profile = DamageProfileTemplates.twin_grenade_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		scaled_power_level = {
			100,
			200,
			500,
			700,
			850
		},
		vfx = {
			"content/fx/particles/enemies/twin_disappear_cloud"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_gas_proximity_mine",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	poxwalker_bomber = {
		damage_falloff = false,
		radius = 6,
		min_radius = 3,
		scalable_radius = true,
		close_radius = 3,
		collision_filter = "filter_minion_explosion",
		override_friendly_fire = true,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.poxwalker_explosion_close,
		damage_profile = DamageProfileTemplates.poxwalker_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/explosions/poxwalker_explode"
		},
		sfx = {
			"wwise/events/minions/play_explosion_bomber",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	beast_of_nurgle_death = {
		damage_falloff = false,
		radius = 6,
		min_radius = 3,
		scalable_radius = true,
		close_radius = 3,
		collision_filter = "filter_minion_explosion",
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.poxwalker_explosion_close,
		damage_profile = DamageProfileTemplates.poxwalker_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/beast_of_nurgle/bon_death_splatter"
		},
		sfx = {
			"wwise/events/minions/play_beast_of_nurgle_death_explode"
		}
	},
	nurgle_head_parasite = {
		static_power_level = 250,
		radius = 6,
		min_radius = 3,
		close_radius = 3,
		scalable_radius = true,
		collision_filter = "filter_minion_explosion",
		override_friendly_fire = true,
		damage_falloff = false,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.nurgle_head_parasite,
		damage_profile = DamageProfileTemplates.nurgle_head_parasite,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/beast_of_nurgle/bon_death_splatter"
		},
		sfx = {
			"wwise/events/minions/play_nurgle_head_parasite_explode"
		}
	},
	renegade_captain_bolt_shell_kill = {
		damage_falloff = true,
		radius = 5,
		scalable_radius = false,
		collision_filter = "filter_minion_explosion",
		damage_profile = DamageProfileTemplates.renegade_captain_bolt_pistol_kill_explosion,
		damage_type = damage_types.boltshell,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/weapons/rifles/bolter/bolter_burrowed_explode"
		},
		sfx = {
			"wwise/events/weapon/play_bullet_hits_explosive_gen_husk"
		}
	},
	renegade_captain_bolt_shell_stop = {
		damage_falloff = true,
		radius = 3,
		scalable_radius = false,
		collision_filter = "filter_minion_explosion",
		damage_profile = DamageProfileTemplates.renegade_captain_bolt_pistol_stop_explosion,
		damage_type = damage_types.boltshell,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		explosion_area_suppression = {
			distance = 4,
			suppression_value = 4
		},
		vfx = {
			"content/fx/particles/weapons/rifles/bolter/bolter_bullet_surface_explode"
		},
		sfx = {
			"wwise/events/weapon/play_bullet_hits_explosive_gen_husk"
		}
	},
	renegade_captain_plasma_stop = {
		damage_falloff = true,
		radius = 3,
		scalable_radius = false,
		collision_filter = "filter_minion_explosion",
		damage_profile = DamageProfileTemplates.renegade_captain_bolt_pistol_stop_explosion,
		damage_type = damage_types.boltshell,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		explosion_area_suppression = {
			distance = 4,
			suppression_value = 4
		},
		vfx = {
			"content/fx/particles/weapons/rifles/plasma_gun/plasma_charged_explosion_medium"
		}
	},
	renegade_captain_fire_grenade = {
		damage_falloff = false,
		radius = 5,
		min_radius = 2.5,
		scalable_radius = true,
		close_radius = 2.5,
		collision_filter = "filter_minion_explosion",
		static_power_level = 500,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact_close,
		damage_profile = DamageProfileTemplates.renegade_grenadier_fire_grenade_impact,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/weapons/grenades/flame_grenade_initial_blast"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_flame_minion",
			"wwise/events/weapon/play_explosion_refl_small"
		}
	},
	renegade_captain_frag_grenade = {
		damage_falloff = true,
		radius = 10,
		min_radius = 5,
		close_radius = 5,
		scalable_radius = true,
		collision_filter = "filter_minion_explosion",
		override_friendly_fire = true,
		static_power_level = 500,
		min_close_radius = 3,
		close_damage_profile = DamageProfileTemplates.renegade_captain_frag_grenade_close,
		close_damage_type = damage_types.grenade_frag,
		damage_profile = DamageProfileTemplates.renegade_captain_frag_grenade,
		damage_type = damage_types.grenade_frag,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/explosions/frag_grenade_01"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_frag",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	renegade_shocktrooper_frag_grenade = {
		damage_falloff = true,
		radius = 8,
		min_radius = 3,
		close_radius = 5,
		scalable_radius = true,
		collision_filter = "filter_minion_explosion",
		override_friendly_fire = true,
		static_power_level = 500,
		min_close_radius = 3,
		close_damage_profile = DamageProfileTemplates.renegade_shocktrooper_frag_grenade_close,
		close_damage_type = damage_types.grenade_frag,
		damage_profile = DamageProfileTemplates.renegade_shocktrooper_frag_grenade,
		damage_type = damage_types.grenade_frag,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/explosions/frag_grenade_01"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_frag",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	renegade_captain_toughness_depleted = {
		damage_falloff = false,
		radius = 8,
		min_radius = 3,
		scalable_radius = true,
		close_radius = 3,
		collision_filter = "filter_minion_explosion",
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.renegade_captain_toughness_depleted,
		damage_profile = DamageProfileTemplates.renegade_captain_toughness_depleted,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/renegade_captain/renegade_captain_shield_burst"
		},
		sfx = {
			"wwise/events/minions/play_traitor_captain_shield_break"
		}
	},
	chaos_hound_pounced_explosion = {
		damage_falloff = false,
		radius = 3.5,
		min_radius = 2,
		scalable_radius = true,
		close_radius = 2,
		collision_filter = "filter_minion_explosion",
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.chaos_hound_push,
		damage_profile = DamageProfileTemplates.chaos_hound_push,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/chaos_hound/chaos_hound_pounce"
		}
	},
	purple_stimmed_explosion = {
		damage_falloff = false,
		radius = 0.2,
		min_radius = 0.1,
		scalable_radius = true,
		close_radius = 0.1,
		collision_filter = "filter_minion_explosion",
		static_power_level = 0,
		min_close_radius = 0.05,
		close_damage_profile = DamageProfileTemplates.chaos_hound_push,
		damage_profile = DamageProfileTemplates.chaos_hound_push,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/purple_stimmed_explosion"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_grenade_gas",
			"wwise/events/weapon/play_explosion_refl_small"
		}
	},
	twin_appear_explosion = {
		damage_falloff = false,
		radius = 0.2,
		min_radius = 0.1,
		scalable_radius = true,
		close_radius = 0.1,
		collision_filter = "filter_minion_explosion",
		static_power_level = 0,
		min_close_radius = 0.05,
		close_damage_profile = DamageProfileTemplates.chaos_hound_push,
		damage_profile = DamageProfileTemplates.chaos_hound_push,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/twin_disappear_cloud"
		},
		sfx = {
			"wwise/events/minions/play_minion_twins_ambush_spawn_impact_hit"
		}
	},
	twin_disappear_explosion = {
		damage_falloff = false,
		radius = 0.2,
		min_radius = 0.1,
		scalable_radius = true,
		close_radius = 0.1,
		collision_filter = "filter_minion_explosion",
		static_power_level = 0,
		min_close_radius = 0.05,
		close_damage_profile = DamageProfileTemplates.chaos_hound_push,
		damage_profile = DamageProfileTemplates.chaos_hound_push,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/twin_disappear_cloud"
		},
		sfx = {
			"wwise/events/minions/play_minion_twins_disappear_explosion",
			"wwise/events/weapon/play_explosion_refl_small"
		}
	},
	explosion_settings_renegade_flamer = {
		damage_falloff = false,
		radius = 6,
		min_radius = 3,
		scalable_radius = true,
		close_radius = 3,
		collision_filter = "filter_player_character_explosion",
		override_friendly_fire = true,
		static_power_level = 500,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.flamer_backpack_explosion_close,
		damage_profile = DamageProfileTemplates.flamer_backpack_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/renegade_flamer/renegade_flamer_fuel_detonation"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_flamer_tank",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	explosion_settings_interrupted_renegade_flamer = {
		damage_falloff = false,
		radius = 3,
		min_radius = 1,
		scalable_radius = true,
		close_radius = 1,
		collision_filter = "filter_player_character_explosion",
		override_friendly_fire = true,
		static_power_level = 150,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.interrupted_flamer_backpack_explosion_close,
		damage_profile = DamageProfileTemplates.interrupted_flamer_backpack_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/renegade_flamer/renegade_flamer_fuel_detonation"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_flamer_tank",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	explosion_settings_cultist_flamer = {
		damage_falloff = false,
		radius = 6,
		min_radius = 3,
		scalable_radius = true,
		close_radius = 3,
		collision_filter = "filter_player_character_explosion",
		override_friendly_fire = true,
		static_power_level = 500,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.flamer_backpack_explosion_close,
		damage_profile = DamageProfileTemplates.flamer_backpack_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/cultist_flamer/cultist_flamer_fuel_detonation"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_flamer_tank",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	},
	explosion_settings_interrupted_cultist_flamer = {
		damage_falloff = false,
		radius = 3,
		min_radius = 1,
		scalable_radius = true,
		close_radius = 1,
		collision_filter = "filter_player_character_explosion",
		override_friendly_fire = true,
		static_power_level = 500,
		min_close_radius = 0.5,
		close_damage_profile = DamageProfileTemplates.interrupted_flamer_backpack_explosion_close,
		damage_profile = DamageProfileTemplates.interrupted_flamer_backpack_explosion,
		broadphase_explosion_filter = {
			"heroes",
			"villains",
			"destructibles"
		},
		vfx = {
			"content/fx/particles/enemies/cultist_flamer/cultist_flamer_fuel_detonation"
		},
		sfx = {
			"wwise/events/weapon/play_explosion_flamer_tank",
			"wwise/events/weapon/play_explosion_refl_gen"
		}
	}
}

return explosion_templates
