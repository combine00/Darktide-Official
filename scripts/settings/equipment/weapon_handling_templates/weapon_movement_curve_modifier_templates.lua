local weapon_movement_curve_modifier_templates = {
	default = {
		modifier = {
			lerp_perfect = 1,
			lerp_basic = 0.5
		}
	},
	lasgun_p1_m1 = {
		modifier = {
			lerp_perfect = 1,
			lerp_basic = 0.25
		}
	},
	lasgun_p1_m2 = {
		modifier = {
			lerp_perfect = 1.25,
			lerp_basic = 0.5
		}
	},
	lasgun_p3 = {
		modifier = {
			lerp_perfect = 1,
			lerp_basic = 0.6
		}
	},
	chainsword_p1_m1 = {
		modifier = {
			lerp_perfect = 1.5,
			lerp_basic = 0.5
		}
	},
	combataxe_p1_m1 = {
		modifier = {
			lerp_perfect = 1.5,
			lerp_basic = 0.5
		}
	},
	forcesword_p1_m1 = {
		modifier = {
			lerp_perfect = 1.25,
			lerp_basic = 0.5
		}
	},
	thumper_p1_m2 = {
		modifier = {
			lerp_perfect = 1.25,
			lerp_basic = 0.5
		}
	},
	autopistol_p1_m1 = {
		modifier = {
			lerp_perfect = 1.5,
			lerp_basic = 0.5
		}
	},
	ogryn_club_p1_m1 = {
		modifier = {
			lerp_perfect = 1.5,
			lerp_basic = 0.5
		}
	},
	shotgun_p2 = {
		modifier = {
			lerp_perfect = 1.2,
			lerp_basic = 0.7
		}
	},
	shotgun_p4 = {
		modifier = {
			lerp_perfect = 1.2,
			lerp_basic = 0.6
		}
	},
	shotpistol = {
		modifier = {
			lerp_perfect = 1.1,
			lerp_basic = 0.6
		}
	},
	boltpistol_p1_m1 = {
		modifier = {
			lerp_perfect = 1.25,
			lerp_basic = 0.4
		}
	},
	forcesword_2h = {
		modifier = {
			lerp_perfect = 1.1,
			lerp_basic = 0.6
		}
	}
}

return settings("WeaponCurveModifierTemplates", weapon_movement_curve_modifier_templates)
