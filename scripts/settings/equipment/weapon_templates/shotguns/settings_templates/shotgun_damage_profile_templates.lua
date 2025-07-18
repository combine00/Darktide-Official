local ArmorSettings = require("scripts/settings/damage/armor_settings")
local DamageProfileSettings = require("scripts/settings/damage/damage_profile_settings")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local GibbingSettings = require("scripts/settings/gibbing/gibbing_settings")
local HerdingTemplates = require("scripts/settings/damage/herding_templates")
local PowerLevelSettings = require("scripts/settings/damage/power_level_settings")
local WoundsTemplates = require("scripts/settings/damage/wounds_templates")
local armor_types = ArmorSettings.types
local damage_lerp_values = DamageProfileSettings.damage_lerp_values
local damage_types = DamageSettings.damage_types
local gibbing_power = GibbingSettings.gibbing_power
local gibbing_types = GibbingSettings.gibbing_types
local double_cleave = DamageProfileSettings.double_cleave
local light_cleave = DamageProfileSettings.light_cleave
local medium_cleave = DamageProfileSettings.medium_cleave
local damage_templates = {}
local overrides = {}

table.make_unique(damage_templates)
table.make_unique(overrides)

damage_templates.default_shotgun_killshot = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = {
			2,
			4
		},
		impact = {
			2,
			4
		}
	},
	ranges = {
		min = {
			6,
			14
		},
		max = {
			20,
			40
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			300,
			600
		},
		impact = {
			20,
			40
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.25,
		0.75
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.8,
				1.6
			}
		}
	},
	ragdoll_push_force = {
		450,
		550
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.default_shotgun_assault = {
	ragdoll_only = false,
	stagger_category = "ranged",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = {
			2,
			4
		},
		impact = {
			2,
			4
		}
	},
	ranges = {
		min = {
			6,
			14
		},
		max = {
			15,
			25
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1_25,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			300,
			600
		},
		impact = {
			20,
			40
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.25,
		0.75
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.25,
				0.75
			}
		}
	},
	ragdoll_push_force = {
		750,
		850
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_assault_p2 = {
	ragdoll_only = false,
	stagger_category = "ranged",
	ignore_stagger_reduction = true,
	cleave_distribution = light_cleave,
	ranges = {
		min = {
			5,
			9
		},
		max = {
			13,
			22
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1_25,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1_33,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1_25,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_8,
				[armor_types.armored] = damage_lerp_values.lerp_0_4,
				[armor_types.resistant] = damage_lerp_values.lerp_0_65,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_4,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_3
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_65,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			450,
			975
		},
		impact = {
			20,
			80
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.6,
		1.6
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3.5
		},
		distance = {
			2.5,
			5
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.6
			},
			boost_curve_multiplier_finesse = {
				0.1,
				0.5
			}
		}
	},
	ragdoll_push_force = {
		750,
		850
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
overrides.shotgun_assault_p2_special = {
	parent_template_name = "shotgun_assault_p2",
	overrides = {
		{
			"power_distribution",
			"attack",
			{
				1080,
				2400
			}
		},
		{
			"power_distribution",
			"impact",
			{
				50,
				150
			}
		},
		{
			"cleave_distribution",
			medium_cleave
		},
		{
			"ranges",
			"min",
			{
				4,
				6
			}
		},
		{
			"ranges",
			"max",
			{
				8,
				14
			}
		},
		{
			"ragdoll_push_force",
			{
				600,
				900
			}
		},
		{
			"gibbing_power",
			gibbing_power.medium
		}
	}
}
overrides.shotgun_assault_p2_special_high_gibbing = {
	parent_template_name = "shotgun_assault_p2",
	overrides = {
		{
			"power_distribution",
			"attack",
			{
				1080,
				2400
			}
		},
		{
			"power_distribution",
			"impact",
			{
				50,
				150
			}
		},
		{
			"cleave_distribution",
			medium_cleave
		},
		{
			"ranges",
			"min",
			{
				4,
				6
			}
		},
		{
			"ranges",
			"max",
			{
				8,
				14
			}
		},
		{
			"ragdoll_push_force",
			{
				600,
				900
			}
		},
		{
			"gibbing_power",
			gibbing_power.impossible
		}
	}
}
damage_templates.shotgun_cleaving_special = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = medium_cleave,
	ranges = {
		min = {
			6,
			14
		},
		max = {
			20,
			40
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_8,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_9,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			250,
			400
		},
		impact = {
			60,
			80
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.heavy,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.25,
		0.75
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	finesse_boost = {
		[armor_types.unarmored] = 0.75
	},
	targets = {
		{
			power_distribution = {
				attack = {
					300,
					480
				},
				impact = {
					60,
					80
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		{
			power_distribution = {
				attack = {
					150,
					300
				},
				impact = {
					50,
					70
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		{
			power_distribution = {
				attack = {
					100,
					200
				},
				impact = {
					40,
					60
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		default_target = {
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					40,
					50
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		}
	},
	ragdoll_push_force = {
		50,
		50
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_assault_burninating = {
	suppression_value = 15,
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = light_cleave,
	ranges = {
		min = {
			6,
			14
		},
		max = {
			20,
			40
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_25,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_65,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_8,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_6,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_4,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_6,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_25,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.no_damage,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_35,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_8,
				[armor_types.armored] = damage_lerp_values.lerp_0_8,
				[armor_types.resistant] = damage_lerp_values.lerp_0_6,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_4,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_2,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_4,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.medium,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			60,
			120
		},
		impact = {
			50,
			100
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.ballistic,
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	targets = {
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			}
		}
	},
	ragdoll_push_force = {
		50,
		50
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_slug_special = {
	ignore_stagger_reduction = true,
	ragdoll_only = false,
	stagger_category = "melee",
	shield_override_stagger_strength = 250,
	cleave_distribution = double_cleave,
	ranges = {
		min = {
			16,
			24
		},
		max = {
			32,
			48
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_8,
				[armor_types.resistant] = damage_lerp_values.lerp_0_9,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_9,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_4,
				[armor_types.resistant] = damage_lerp_values.lerp_0_35,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_35,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.medium,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			500,
			800
		},
		impact = {
			80,
			100
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		3.5,
		4.5
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			10,
			15
		},
		distance = {
			6,
			8
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				1.125,
				2.25
			}
		}
	},
	ragdoll_push_force = {
		450,
		550
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy
}
damage_templates.shotgun_p1_m2_assault = {
	ragdoll_only = false,
	stagger_category = "ranged",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = 2.5,
		impact = 2.5
	},
	ranges = {
		min = {
			12,
			16
		},
		max = {
			24,
			32
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.medium,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			250,
			480
		},
		impact = {
			15,
			30
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.15,
		0.45
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				1.25,
				2.5
			}
		}
	},
	ragdoll_push_force = {
		50,
		50
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_p1_m2_killshot = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = 2.5,
		impact = 2.5
	},
	ranges = {
		min = {
			16,
			24
		},
		max = {
			32,
			48
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			250,
			480
		},
		impact = {
			15,
			30
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.15,
		0.45
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			1,
			3
		},
		distance = {
			2,
			4
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				1.25,
				2.5
			}
		}
	},
	ragdoll_push_force = {
		450,
		550
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_p1_m3_assault = {
	ragdoll_only = false,
	stagger_category = "ranged",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = 3.5,
		impact = 3
	},
	ranges = {},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			550,
			740
		},
		impact = {
			30,
			60
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		7,
		8
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		distance = 5,
		suppression_value = {
			4.5,
			5.5
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.25,
				0.75
			}
		}
	},
	ragdoll_push_force = {
		150,
		150
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_p1_m3_killshot = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = 3.5,
		impact = 3
	},
	ranges = {
		min = {
			8,
			12
		},
		max = {
			16,
			24
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
				[armor_types.armored] = damage_lerp_values.lerp_0_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_4
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			550,
			740
		},
		impact = {
			30,
			60
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		7,
		8
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		distance = 5,
		suppression_value = {
			4.5,
			5.5
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.5,
				1
			}
		}
	},
	ragdoll_push_force = {
		150,
		150
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_medium
}
damage_templates.shotgun_p4_m1 = {
	ragdoll_only = false,
	stagger_category = "melee",
	ragdoll_push_force = 300,
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = {
			5.3,
			5.3
		},
		impact = {
			1,
			1
		}
	},
	ranges = {
		min = {
			8,
			14
		},
		max = {
			15,
			25
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_8,
				[armor_types.resistant] = damage_lerp_values.lerp_0_9,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_9,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_2,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_8,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_3,
				[armor_types.armored] = damage_lerp_values.lerp_0_2,
				[armor_types.resistant] = damage_lerp_values.lerp_0_2,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_2,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_2
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_4,
				[armor_types.armored] = damage_lerp_values.lerp_0_3,
				[armor_types.resistant] = damage_lerp_values.lerp_0_3,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_3,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_3,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_1
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			650,
			1280
		},
		impact = {
			25,
			50
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		1.5,
		2.5
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			3.5,
			4.5
		},
		distance = {
			2.2,
			4.2
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.5,
				1
			}
		}
	}
}
damage_templates.shotgun_p4_m2 = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = {
			5.7,
			5.7
		},
		impact = {
			4,
			4
		}
	},
	ranges = {
		min = {
			18,
			22
		},
		max = {
			23,
			40
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_8,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_8,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_8,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_6,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_6,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_8,
				[armor_types.armored] = damage_lerp_values.lerp_0_6,
				[armor_types.resistant] = damage_lerp_values.lerp_0_8,
				[armor_types.player] = damage_lerp_values.lerp_0_6,
				[armor_types.berserker] = damage_lerp_values.lerp_0_6,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_4,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_7,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_3
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_6,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_4,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_6
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			675,
			1140
		},
		impact = {
			25,
			50
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		0.75,
		1.55
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		suppression_value = {
			5,
			5.5
		},
		distance = {
			3.5,
			4.5
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.5,
				1
			}
		}
	},
	ragdoll_push_force = {
		300,
		300
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy
}
damage_templates.shotgun_p4_m3 = {
	ragdoll_only = false,
	stagger_category = "melee",
	ignore_stagger_reduction = true,
	cleave_distribution = {
		attack = {
			5.1,
			5.1
		},
		impact = {
			1,
			1
		}
	},
	ranges = {
		min = {
			8,
			12
		},
		max = {
			16,
			24
		}
	},
	herding_template = HerdingTemplates.shotgun,
	armor_damage_modifier_ranged = {
		near = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_0_9,
				[armor_types.resistant] = damage_lerp_values.lerp_1,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_4,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
				[armor_types.void_shield] = damage_lerp_values.lerp_1
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_1,
				[armor_types.armored] = damage_lerp_values.lerp_1_5,
				[armor_types.resistant] = damage_lerp_values.lerp_0_75,
				[armor_types.player] = damage_lerp_values.lerp_1,
				[armor_types.berserker] = damage_lerp_values.lerp_1,
				[armor_types.super_armor] = damage_lerp_values.lerp_1,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_2,
				[armor_types.void_shield] = damage_lerp_values.lerp_2
			}
		},
		far = {
			attack = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_6,
				[armor_types.armored] = damage_lerp_values.lerp_0_6,
				[armor_types.resistant] = damage_lerp_values.lerp_0_6,
				[armor_types.player] = damage_lerp_values.lerp_0_1,
				[armor_types.berserker] = damage_lerp_values.lerp_0_6,
				[armor_types.super_armor] = damage_lerp_values.no_damage,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_6,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			},
			impact = {
				[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
				[armor_types.armored] = damage_lerp_values.lerp_0_75,
				[armor_types.resistant] = damage_lerp_values.lerp_0_5,
				[armor_types.player] = damage_lerp_values.no_damage,
				[armor_types.berserker] = damage_lerp_values.lerp_0_5,
				[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
				[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
				[armor_types.void_shield] = damage_lerp_values.lerp_0_5
			}
		}
	},
	critical_strike = {
		gibbing_power = gibbing_power.heavy,
		gibbing_type = gibbing_types.ballistic
	},
	power_distribution = {
		attack = {
			405,
			910
		},
		impact = {
			25,
			50
		}
	},
	damage_type = damage_types.pellet,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.ballistic,
	suppression_value = {
		7,
		8
	},
	wounds_template = WoundsTemplates.shotgun,
	on_kill_area_suppression = {
		distance = 5,
		suppression_value = {
			4.5,
			5.5
		}
	},
	targets = {
		default_target = {
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.75
			},
			boost_curve_multiplier_finesse = {
				0.5,
				1
			}
		}
	},
	ragdoll_push_force = {
		300,
		300
	},
	gib_push_force = GibbingSettings.gib_push_force.ranged_heavy
}
damage_templates.shotgun_weapon_special_bash_light = {
	ignore_stagger_reduction = true,
	weakspot_stagger_resistance_modifier = 0.2,
	is_push = true,
	ragdoll_push_force = 300,
	stagger_category = "uppercut",
	cleave_distribution = medium_cleave,
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
			[armor_types.resistant] = 0.25,
			[armor_types.player] = 0,
			[armor_types.berserker] = 0.5,
			[armor_types.super_armor] = 0.5,
			[armor_types.disgustingly_resilient] = 1,
			[armor_types.void_shield] = 0
		}
	},
	targets = {
		{
			power_distribution = {
				attack = {
					30,
					80
				},
				impact = {
					5,
					10
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		{
			power_distribution = {
				attack = {
					20,
					60
				},
				impact = {
					5,
					10
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		{
			power_distribution = {
				attack = {
					10,
					40
				},
				impact = {
					5,
					10
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			}
		},
		default_target = {
			power_distribution = {
				attack = {
					10,
					20
				},
				impact = {
					5,
					10
				}
			}
		}
	},
	gibbing_power = gibbing_power.always,
	gibbing_type = gibbing_types.default
}

return {
	base_templates = damage_templates,
	overrides = overrides
}
