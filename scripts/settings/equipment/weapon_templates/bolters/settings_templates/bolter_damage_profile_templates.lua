local ArmorSettings = require("scripts/settings/damage/armor_settings")
local DamageProfileSettings = require("scripts/settings/damage/damage_profile_settings")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local GibbingSettings = require("scripts/settings/gibbing/gibbing_settings")
local PowerLevelSettings = require("scripts/settings/damage/power_level_settings")
local WoundsTemplates = require("scripts/settings/damage/wounds_templates")
local armor_types = ArmorSettings.types
local damage_lerp_values = DamageProfileSettings.damage_lerp_values
local damage_types = DamageSettings.damage_types
local gibbing_power = GibbingSettings.gibbing_power
local gibbing_types = GibbingSettings.gibbing_types
local double_cleave = DamageProfileSettings.double_cleave
local no_cleave = DamageProfileSettings.no_cleave
local damage_templates = {}
local overrides = {}

table.make_unique(damage_templates)
table.make_unique(overrides)

damage_templates.default_bolter_killshot = {
	suppression_value = 10,
	accumulative_stagger_strength_multiplier = 0.55,
	shield_multiplier = 10,
	ragdoll_only = true,
	stagger_category = "ranged",
	ragdoll_push_force = 600,
	cleave_distribution = double_cleave,
	ignore_hitzone_multipliers_breed_tags = {
		"horde",
		"roamer",
		"elite",
		"special"
	},
	ranges = {
		max = 40,
		min = 10
	},
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_9,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_9,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_25
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_25
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		}
	},
	power_distribution = {
		attack = {
			330,
			660
		},
		impact = {
			10,
			20
		}
	},
	damage_type = damage_types.boltshell,
	gibbing_power = gibbing_power.heavy,
	gibbing_type = gibbing_types.boltshell,
	wounds_template = WoundsTemplates.bolter,
	on_kill_area_suppression = {
		distance = 8,
		suppression_value = 12
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy,
	targets = {
		default_target = {
			boost_curve_multiplier_finesse = 1,
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
damage_templates.bolter_stop_explosion = {
	suppression_value = 0.5,
	ragdoll_push_force = 200,
	stagger_category = "flamer",
	ignore_hitzone_multipliers_breed_tags = {
		"horde",
		"roamer",
		"elite",
		"special"
	},
	cleave_distribution = {
		attack = 0.1,
		impact = 0.1
	},
	ranges = {
		max = 20,
		min = 10
	},
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.no_damage,
				[armor_types.armored] = damage_lerp_values.no_damage,
				[armor_types.resistant] = damage_lerp_values.no_damage,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.no_damage,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.no_damage,
				[armor_types.void_shield] = damage_lerp_values.no_damage
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.no_damage,
				[armor_types.armored] = damage_lerp_values.no_damage,
				[armor_types.resistant] = damage_lerp_values.no_damage,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.no_damage,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.no_damage,
				[armor_types.void_shield] = damage_lerp_values.no_damage
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_25,
				[armor_types.armored] = damage_lerp_values.no_damage,
				[armor_types.resistant] = damage_lerp_values.lerp_0_25,
				[armor_types.player] = damage_lerp_values.lerp_0_25,
				[armor_types.berserker] = damage_lerp_values.lerp_0_25,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_25,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_25
			}
		}
	},
	power_distribution = {
		attack = 0,
		impact = 16
	},
	damage_type = damage_types.boltshell,
	gibbing_power = gibbing_power.heavy,
	gibbing_type = gibbing_types.boltshell,
	wounds_template = WoundsTemplates.bolter,
	targets = {
		default_target = {
			boost_curve_multiplier_finesse = 1.2,
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			}
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy
}
damage_templates.bolter_kill_explosion = {
	suppression_value = 0.5,
	ragdoll_push_force = 200,
	stagger_category = "flamer",
	ignore_hitzone_multipliers_breed_tags = {
		"horde",
		"roamer",
		"elite",
		"special"
	},
	cleave_distribution = {
		attack = 0.1,
		impact = 0.1
	},
	ranges = {
		max = 20,
		min = 10
	},
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_8,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_25,
				[armor_types.armored] = damage_lerp_values.lerp_0_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_25,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_25,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_25,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_25
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_25,
				[armor_types.armored] = damage_lerp_values.no_damage,
				[armor_types.resistant] = damage_lerp_values.lerp_0_25,
				[armor_types.player] = damage_lerp_values.lerp_0_25,
				[armor_types.berserker] = damage_lerp_values.lerp_0_25,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_25,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_25
			}
		}
	},
	power_distribution = {
		attack = 50,
		impact = 16
	},
	damage_type = damage_types.boltshell,
	gibbing_power = gibbing_power.heavy,
	gibbing_type = gibbing_types.boltshell,
	wounds_template = WoundsTemplates.bolter,
	on_kill_area_suppression = {
		distance = 8,
		suppression_value = 12
	},
	targets = {
		default_target = {
			boost_curve_multiplier_finesse = 1.2,
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			}
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy
}
damage_templates.weapon_special_push = {
	is_push = true,
	stagger_category = "melee",
	power_distribution = {
		attack = 30,
		impact = 15
	},
	armor_damage_modifier = {
		attack = {
			[armor_types.unarmored] = 0.8,
			[armor_types.armored] = 0.3,
			[armor_types.resistant] = 0.5,
			[armor_types.player] = 0,
			[armor_types.berserker] = 0.6,
			[armor_types.super_armor] = 0,
			[armor_types.disgustingly_resilient] = 1,
			[armor_types.void_shield] = 0.1
		},
		impact = {
			[armor_types.unarmored] = 1.25,
			[armor_types.armored] = 1,
			[armor_types.resistant] = 1,
			[armor_types.player] = 0,
			[armor_types.berserker] = 0.5,
			[armor_types.super_armor] = 0.5,
			[armor_types.disgustingly_resilient] = 1,
			[armor_types.void_shield] = 0
		}
	},
	gibbing_power = gibbing_power.always,
	gibbing_type = gibbing_types.default,
	targets = {
		default_target = {}
	}
}
damage_templates.weapon_special_push_outer = {
	is_push = true,
	stagger_category = "melee",
	power_distribution = {
		attack = 10,
		impact = 10
	},
	armor_damage_modifier = {
		attack = {
			[armor_types.unarmored] = 0,
			[armor_types.armored] = 0,
			[armor_types.resistant] = 0,
			[armor_types.player] = 0,
			[armor_types.berserker] = 0,
			[armor_types.super_armor] = 0,
			[armor_types.disgustingly_resilient] = 1,
			[armor_types.void_shield] = 0
		},
		impact = {
			[armor_types.unarmored] = 1,
			[armor_types.armored] = 1,
			[armor_types.resistant] = 1,
			[armor_types.player] = 0,
			[armor_types.berserker] = 0.5,
			[armor_types.super_armor] = 0.5,
			[armor_types.disgustingly_resilient] = 1,
			[armor_types.void_shield] = 0
		}
	},
	gibbing_power = gibbing_power.always,
	gibbing_type = gibbing_types.default,
	targets = {
		default_target = {}
	}
}

return {
	base_templates = damage_templates,
	overrides = overrides
}
