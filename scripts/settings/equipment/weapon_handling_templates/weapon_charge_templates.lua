local weapon_charge_templates = {
	lasgun_p2_m1_charge_up = {
		max_ammo_charge = 6,
		limit_max_charge_to_ammo_clip = true,
		charge_on_action_start = true,
		charge_delay = 0,
		charge_duration = {
			lerp_perfect = 0.4,
			lerp_basic = 0.8
		}
	},
	lasgun_p2_m2_charge_up = {
		max_ammo_charge = 4,
		limit_max_charge_to_ammo_clip = true,
		charge_on_action_start = true,
		charge_delay = 0,
		charge_duration = {
			lerp_perfect = 0.25,
			lerp_basic = 0.65
		}
	},
	lasgun_p2_m3_charge_up = {
		max_ammo_charge = 9,
		limit_max_charge_to_ammo_clip = true,
		charge_on_action_start = true,
		charge_delay = 0,
		charge_duration = {
			lerp_perfect = 0.5,
			lerp_basic = 1
		}
	},
	plasmagun_p1_m1_charge_direct = {
		fully_charged_charge_level = 0.525,
		full_charge_overheat_percent = 0.025,
		limit_max_charge_to_ammo_clip = true,
		charge_on_action_start = true,
		min_charge = 0.05,
		charge_duration = {
			lerp_perfect = 0.5,
			lerp_basic = 1
		},
		overheat_percent = {
			lerp_perfect = 0.045,
			lerp_basic = 0.09
		}
	},
	plasmagun_p1_m1_shoot = {
		use_charge = true,
		overheat_percent = {
			lerp_perfect = 0.15,
			lerp_basic = 0.3
		}
	},
	plasmagun_p1_m1_shoot_charged = {
		use_charge = true,
		limit_max_charge_to_ammo_clip = true,
		overheat_percent = {
			lerp_perfect = 0.2,
			lerp_basic = 0.4
		}
	},
	plasmagun_p1_m1_charge = {
		charge_on_action_start = true,
		charge_duration = {
			lerp_perfect = 1,
			lerp_basic = 2
		},
		overheat_percent = {
			lerp_perfect = 0.1,
			lerp_basic = 0.15
		},
		full_charge_overheat_percent = {
			lerp_perfect = 0.01,
			lerp_basic = 0.02
		}
	},
	psyker_throwing_knives = {
		psyker_smite = true,
		warp_charge_percent = 0.1
	},
	psyker_throwing_knives_homing = {
		psyker_smite = true,
		warp_charge_percent = 0.25
	},
	psyker_overcharge_stance_hit = {
		warp_charge_percent = 0.02
	},
	psyker_overcharge_stance_kill = {
		warp_charge_percent = 0.04
	},
	psyker_overcharge_stance_passive = {
		use_charge = true,
		warp_charge_percent = 0.00075
	},
	psyker_reload_speed_warp = {
		warp_charge_percent = 0.25
	},
	handgun_push_charge = {
		warp_charge_percent = 0.1
	},
	psyker_smite_charge = {
		charge_duration = 3,
		psyker_smite = true,
		warp_charge_percent = 0.2,
		full_charge_warp_charge_percent = 0.09,
		charge_on_action_start = true
	},
	psyker_smite_lock_target = {
		charge_duration = 3,
		full_charge_warp_charge_percent = 0.09,
		psyker_smite = true,
		warp_charge_percent = 0.3
	},
	psyker_smite_use_power = {
		charge_duration = 0.5,
		full_charge_warp_charge_percent = 0.1,
		psyker_smite = true,
		warp_charge_percent = 0.25
	},
	forcestaff_p1_m1_charge_aoe = {
		charge_on_action_start = true,
		charge_duration = {
			lerp_perfect = 0.5,
			lerp_basic = 3
		},
		warp_charge_percent = {
			lerp_perfect = 0.15,
			lerp_basic = 0.3
		},
		full_charge_warp_charge_percent = {
			lerp_perfect = 0.03,
			lerp_basic = 0.06
		}
	},
	forcestaff_p1_m1_use_aoe = {
		use_charge = false,
		warp_charge_percent = {
			lerp_perfect = 0.03,
			lerp_basic = 0.09
		}
	},
	forcestaff_p1_m1_projectile = {
		warp_charge_percent = {
			lerp_perfect = 0.025,
			lerp_basic = 0.075
		}
	},
	forcestaff_p2_m1_charge = {
		charge_on_action_start = true,
		charge_duration = {
			lerp_perfect = 1.5,
			lerp_basic = 2
		},
		warp_charge_percent = {
			lerp_perfect = 0.15,
			lerp_basic = 0.25
		},
		full_charge_warp_charge_percent = {
			lerp_perfect = 0.03,
			lerp_basic = 0.05
		}
	},
	forcestaff_p2_m1_flame_burst = {
		warp_charge_percent = {
			lerp_perfect = 0.025,
			lerp_basic = 0.075
		}
	},
	forcestaff_p2_m1_flamer_gas = {
		warp_charge_percent = {
			lerp_perfect = 0.005,
			lerp_basic = 0.02
		},
		charge_cost = {
			lerp_perfect = 0.4,
			lerp_basic = 0.2
		}
	},
	forcestaff_p3_m1_projectile = {
		warp_charge_percent = {
			lerp_perfect = 0.025,
			lerp_basic = 0.075
		}
	},
	forcestaff_p3_m1_charge = {
		charge_on_action_start = true,
		charge_duration = {
			lerp_perfect = 0.7,
			lerp_basic = 1.4
		},
		warp_charge_percent = {
			lerp_perfect = 0.1,
			lerp_basic = 0.2
		},
		full_charge_warp_charge_percent = {
			lerp_perfect = 0.03,
			lerp_basic = 0.05
		}
	},
	forcestaff_p3_m1_chain_lightning = {
		chain_lightning = true,
		warp_charge_percent = {
			lerp_perfect = 0.075,
			lerp_basic = 0.15
		}
	},
	forcestaff_p4_m1_projectile = {
		warp_charge_percent = {
			lerp_perfect = 0.025,
			lerp_basic = 0.075
		}
	},
	forcestaff_p4_m1_charged_projectile = {
		warp_charge_percent = {
			lerp_perfect = 0.05,
			lerp_basic = 0.12
		}
	},
	forcestaff_p4_m1_charge_projectile = {
		charge_on_action_start = true,
		charge_duration = {
			lerp_perfect = 1.5,
			lerp_basic = 2
		},
		warp_charge_percent = {
			lerp_perfect = 0.1,
			lerp_basic = 0.2
		},
		full_charge_warp_charge_percent = {
			lerp_perfect = 0.03,
			lerp_basic = 0.05
		}
	},
	forcesword_p1_m1_weapon_special_hit = {
		warp_charge_percent = {
			lerp_perfect = 0,
			lerp_basic = 0.5
		}
	},
	forcesword_p1_m1_charge_single_target = {
		charge_duration = 1,
		charge_on_action_start = true,
		full_charge_warp_charge_percent = 0.025,
		warp_charge_percent = 0.025
	},
	forcesword_p1_m1_fling = {
		use_charge = true,
		warp_charge_percent = 0.04
	},
	forcesword_p1_m1_push = {
		use_charge = true,
		warp_charge_percent = 0.08
	},
	forcesword_2h_p1_m1_weapon_special = {
		charge_duration = 3.1,
		charge_on_action_start = true,
		full_charge_warp_charge_percent = 0.025,
		warp_charge_percent = {
			lerp_perfect = 0.25,
			lerp_basic = 0.65
		}
	},
	powersword_2h_p1_m1_weapon_special = {
		overheat_overtime = {
			fully_charged_charge_level = 0.525,
			full_charge_overheat_percent = 0.025,
			limit_max_charge_to_ammo_clip = true,
			charge_duration = 1,
			charge_on_action_start = true,
			min_charge = 0.05,
			overheat_percent = {
				lerp_perfect = 0.03,
				lerp_basic = 0.05
			}
		},
		overheat_swing = {
			use_charge = true,
			lockout_enabled = true,
			overheat_percent = {
				lerp_perfect = 0.03,
				lerp_basic = 0.1
			}
		},
		overheat_decay = {
			auto_vent_delay = 1,
			low_threshold_decay_rate_modifier = 1.5,
			vent_interval = 0.25,
			high_threshold_decay_rate_modifier = 1,
			vent_duration = 2,
			critical_threshold_decay_rate_modifier = 0.5,
			thresholds = {
				high = 0.7,
				critical = 0.9,
				low = 0.3
			},
			auto_vent_duration = {
				lerp_perfect = 8,
				lerp_basic = 14
			}
		}
	},
	chain_lightning_ability_spread = {
		charge_duration = 0.1,
		charge_on_action_start = true,
		full_charge_warp_charge_percent = 0.18,
		warp_charge_percent = 0.0075
	},
	chain_lightning_ability_activated = {
		charge_duration = 0.001,
		charge_on_action_start = true,
		full_charge_warp_charge_percent = 0.6,
		warp_charge_percent = 0.6
	},
	chain_lightning_charge_heavy = {
		charge_duration = 0.8,
		charge_on_action_start = true,
		full_charge_warp_charge_percent = 0.01,
		warp_charge_percent = 0.05
	},
	chain_lightning_attack_heavy = {
		charge_duration = 0.5,
		start_warp_charge_percent = 0.05,
		full_charge_warp_charge_percent = 0.01,
		warp_charge_percent = 0.12
	}
}

return settings("WeaponChargeTemplates", weapon_charge_templates)
