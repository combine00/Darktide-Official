local talent_settings = {
	adamant = {
		combat_ability = {
			shout = {
				cooldown = 60,
				range = 6,
				far_range = 12,
				max_charges = 1
			},
			shout_improved = {
				far_range = 16,
				range = 6,
				cooldown = 60,
				toughness = 0.3,
				max_charges = 1
			},
			charge = {
				duration = 6,
				range = 5,
				damage = 0.25,
				cooldown_reduction = 5,
				cooldown = 20,
				impact = 0.5,
				stamina = 0.5,
				toughness = 0.5,
				max_charges = 1
			},
			stance = {
				max_charges = 1,
				movement_speed = 0.2,
				damage = 0.25,
				companion_damage = 0.5,
				cooldown = 60,
				duration = 20,
				sprint_cost = 0.25,
				cooldown_reduction = 0.05
			}
		},
		coherency = {
			adamant_wield_speed_aura = {
				wield_speed = 0.1
			},
			adamant_damage_vs_staggered_aura = {
				damage_vs_staggered = 0.1
			}
		},
		blitz_ability = {
			drone = {
				duration = 20,
				range = 7.5,
				damage_taken = 1.15,
				suppression = 0.25,
				impact = 0.25,
				toughness = 0.05
			},
			shock_mine = {
				duration = 12,
				range = 6
			},
			whistle = {
				movement_speed = 0.25,
				damage = 0.5,
				charges = 3,
				cooldown = 30,
				duration = 8
			},
			grenade = {
				radius_increase = 0.5
			}
		},
		elite_special_kills_offensive_boost = {
			duration = 3,
			movement_speed = 0.1,
			damage = 0.1
		},
		damage_after_reloading = {
			ranged_damage = 0.15,
			duration = 5
		},
		multiple_hits_attack_speed = {
			duration = 3,
			melee_attack_speed = 0.1,
			num_hits = 3
		},
		dog_kills_replenish_toughness = {
			duration = 5,
			toughness = 0.05
		},
		elite_special_kills_replenish_toughness = {
			duration = 4,
			toughness = 0.025,
			instant_toughness = 0.1
		},
		close_kills_restore_toughness = {
			toughness = 0.05
		},
		staggers_replenish_toughness = {
			toughness = 0.025
		},
		dog_attacks_electrocute = {
			power_level = 500,
			duration = 5
		},
		increased_damage_vs_horde = {
			damage = 0.2
		},
		limit_dmg_taken_from_hits = {
			limit = 25
		},
		armor = {
			toughness = 25
		},
		mag_strips = {
			wield_speed = 0.2
		},
		plasteel_plates = {
			toughness = 25
		},
		verispex = {
			range = 25
		},
		ammo_belt = {
			ammo_reserve_capacity = 0.25
		},
		rebreather = {
			damage_taken_from_toxic_gas_multiplier = 0.25,
			corruption_taken_multiplier = 0.85
		},
		riot_pads = {
			stacks = 5,
			cooldown = 5
		},
		gutter_forged = {
			tdr = -0.15,
			movement_speed = -0.1
		},
		shield_plates = {
			toughness = 0.05
		},
		disable_companion = {
			damage = 0.1,
			tdr = -0.1
		},
		damage_reduction_after_elite_kill = {
			damage_taken_multiplier = 0.75,
			duration = 5
		},
		toughness_regen_near_companion = {
			range = 8,
			toughness_percentage_per_second = 0.05
		},
		perfect_block_damage_boost = {
			damage = 0.15,
			duration = 8,
			attack_speed = 0.1
		},
		staggers_reduce_damage_taken = {
			ogryn_stacks = 5,
			duration = 8,
			damage_taken_multiplier = 0.95,
			max_stacks = 5,
			normal_stacks = 1
		},
		cleave_after_push = {
			cleave = 0.75,
			duration = 5
		},
		melee_attacks_on_staggered_rend = {
			rending_multiplier = 0.15
		},
		wield_speed_on_melee_kill = {
			max_stacks = 5,
			duration = 8,
			wield_speed_per_stack = 0.05
		},
		heavy_attacks_increase_damage = {
			damage = 0.15,
			duration = 5
		},
		dog_damage_after_ability = {
			damage = 0.25,
			duration = 12
		},
		hitting_multiple_gives_tdr = {
			duration = 5,
			tdr = 0.8,
			num_hits = 3
		},
		dog_pounces_bleed_nearby = {
			bleed_stacks = 2
		},
		dog_applies_brittleness = {
			stacks = 4
		},
		no_movement_penalty = {
			reduced_move_penalty = 0.5
		},
		restore_toughness_to_allies_on_combat_ability = {
			toughness_percent = 0.15
		},
		forceful = {
			stacks = 1,
			stack_duration = 8,
			tdr = 0.85,
			max_stacks = 20,
			power_level_modifier = 0.2,
			duration = 10,
			short_duration = 5
		},
		forceful_ranged = {
			reload_speed = 0.15,
			ranged_attack_speed = 0.1
		},
		forceful_melee = {
			cleave = 0.5,
			melee_attack_speed = 0.1
		},
		forceful_companion = {
			companion_damage = 0.25
		},
		forceful_toughness_regen = {
			instant_toughness = 0.25,
			toughness_per_second = 0.05
		},
		exterminator = {
			duration = 12,
			stamina = 0.1,
			damage = 0.04,
			boss_damage = 0.04,
			cooldown = 0.25,
			ammo = 0.1,
			stacks = 2,
			companion_damage = 0.04,
			max_stacks = 10,
			toughness = 0.1
		},
		crit_chance_on_kill = {
			max_stacks = 8,
			duration = 10,
			crit_chance = 0.02
		},
		crits_rend = {
			rending = 0.2
		},
		elite_special_kills_reload_speed = {
			reload_speed = 0.25
		},
		dodge_grants_damage = {
			damage = 0.2,
			duration = 5
		},
		stacking_weakspot_strength = {
			max_stacks = 10,
			duration = 5,
			strength = 0.05
		},
		bullet_rain = {
			duration = 6,
			stack_duration = 8,
			tdr = 0.5,
			ranged_damage = 0.15,
			suppression_dealt = 1,
			fire_rate = 0.25,
			tdr_per_stack = 0.01,
			max_stacks = 30,
			toughness_replenish = 0.75
		},
		movement_speed_on_block = {
			duration = 3,
			movement_speed = 0.25
		},
		damage_vs_suppressed = {
			damage_vs_suppressed = 0.25
		},
		clip_size = {
			clip_size_modifier = 0.3
		}
	}
}

return talent_settings
