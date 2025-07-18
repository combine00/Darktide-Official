local ArmorSettings = require("scripts/settings/damage/armor_settings")
local AttackSettings = require("scripts/settings/damage/attack_settings")
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
local melee_attack_strengths = AttackSettings.melee_attack_strength
local double_cleave = DamageProfileSettings.double_cleave
local medium_cleave = DamageProfileSettings.medium_cleave
local no_cleave = DamageProfileSettings.no_cleave
local DEFAULT_SHIELD_OVERRIDE_STAGGER_STRENGTH = 4
local damage_templates = {}
local overrides = {}

table.make_unique(damage_templates)
table.make_unique(overrides)

local ninja_fencer_crit_mod = {
	attack = {
		[armor_types.unarmored] = 0,
		[armor_types.armored] = 0.5,
		[armor_types.resistant] = 0.75,
		[armor_types.player] = 0,
		[armor_types.berserker] = 0.5,
		[armor_types.super_armor] = 0.2,
		[armor_types.disgustingly_resilient] = 0.25,
		[armor_types.void_shield] = 0
	},
	impact = {
		[armor_types.unarmored] = 0.75,
		[armor_types.armored] = 0.75,
		[armor_types.resistant] = 0.75,
		[armor_types.player] = 0.75,
		[armor_types.berserker] = 0.75,
		[armor_types.super_armor] = 0.75,
		[armor_types.disgustingly_resilient] = 0.75,
		[armor_types.void_shield] = 0.75
	}
}
local medium_ninja_fencer_crit_mod = {
	attack = {
		[armor_types.unarmored] = 0,
		[armor_types.armored] = 0.25,
		[armor_types.resistant] = 0.75,
		[armor_types.player] = 0,
		[armor_types.berserker] = 0.5,
		[armor_types.super_armor] = 0.2,
		[armor_types.disgustingly_resilient] = 0.25,
		[armor_types.void_shield] = 0
	},
	impact = {
		[armor_types.unarmored] = 0.75,
		[armor_types.armored] = 0.75,
		[armor_types.resistant] = 0.75,
		[armor_types.player] = 0.75,
		[armor_types.berserker] = 0.75,
		[armor_types.super_armor] = 0.75,
		[armor_types.disgustingly_resilient] = 0.75,
		[armor_types.void_shield] = 0.75
	}
}
damage_templates.light_combat_knife_ninja_fencer = {
	finesse_ability_damage_multiplier = 3,
	ragdoll_push_force = 10,
	stagger_category = "melee",
	cleave_distribution = double_cleave,
	damage_type = damage_types.metal_slashing_light,
	gibbing_type = gibbing_types.sawing,
	gibbing_power = gibbing_power.always,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.combat_knife,
	crit_mod = ninja_fencer_crit_mod,
	shield_override_stagger_strength = DEFAULT_SHIELD_OVERRIDE_STAGGER_STRENGTH,
	targets = {
		{
			crit_boost = 0.75,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1_25,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_9,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					2,
					4
				}
			},
			finesse_boost = PowerLevelSettings.ninjafencer_finesse_boost_amount,
			boost_curve = PowerLevelSettings.boost_curves.default,
			boost_curve_multiplier_finesse = {
				1,
				3
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					1,
					3
				}
			}
		},
		default_target = {
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_25,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.no_damage,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					10,
					20
				},
				impact = {
					1,
					3
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_light
}
overrides.light_combat_knife_ninja_fencer_stab = {
	parent_template_name = "light_combat_knife_ninja_fencer",
	overrides = {
		{
			"backstab_bonus",
			0.25
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				40,
				80
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				1.75,
				3.5
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"armored",
			damage_lerp_values.lerp_0_8
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"super_armor",
			damage_lerp_values.lerp_0_6
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"berserker",
			damage_lerp_values.lerp_0_8
		}
	}
}
damage_templates.medium_combat_knife_ninja_fencer = {
	finesse_ability_damage_multiplier = 3,
	backstab_bonus = 0.25,
	ragdoll_push_force = 10,
	stagger_category = "melee",
	crit_mod = medium_ninja_fencer_crit_mod,
	cleave_distribution = no_cleave,
	damage_type = damage_types.metal_slashing_light,
	gibbing_type = gibbing_types.sawing,
	gibbing_power = gibbing_power.always,
	melee_attack_strength = melee_attack_strengths.heavy,
	wounds_template = WoundsTemplates.combat_knife,
	shield_override_stagger_strength = DEFAULT_SHIELD_OVERRIDE_STAGGER_STRENGTH,
	targets = {
		{
			crit_boost = 0.75,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_9,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					4,
					8
				}
			},
			finesse_boost = PowerLevelSettings.ninjafencer_finesse_boost_amount,
			boost_curve = PowerLevelSettings.boost_curves.default,
			boost_curve_multiplier_finesse = {
				1.75,
				3.5
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					50,
					100
				},
				impact = {
					2,
					5
				}
			}
		},
		default_target = {
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					2,
					5
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_light
}
damage_templates.medium_combat_knife_linesman = {
	finesse_ability_damage_multiplier = 1.5,
	backstab_bonus = 0.15,
	ragdoll_push_force = 10,
	stagger_category = "melee",
	crit_mod = medium_ninja_fencer_crit_mod,
	cleave_distribution = medium_cleave,
	damage_type = damage_types.metal_slashing_light,
	gibbing_type = gibbing_types.sawing,
	gibbing_power = gibbing_power.always,
	melee_attack_strength = melee_attack_strengths.heavy,
	wounds_template = WoundsTemplates.combat_knife,
	shield_override_stagger_strength = DEFAULT_SHIELD_OVERRIDE_STAGGER_STRENGTH,
	targets = {
		{
			crit_boost = 0.75,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_9,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					4,
					8
				}
			},
			finesse_boost = PowerLevelSettings.ninjafencer_finesse_boost_amount,
			boost_curve = PowerLevelSettings.boost_curves.default,
			boost_curve_multiplier_finesse = {
				1.25,
				3
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					60,
					130
				},
				impact = {
					2,
					5
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					50,
					100
				},
				impact = {
					2,
					5
				}
			}
		},
		default_target = {
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_5,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_5
				}
			},
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					2,
					5
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_light
}
overrides.medium_combat_knife_linesman_old = {
	parent_template_name = "medium_combat_knife_ninja_fencer",
	overrides = {
		{
			"cleave_distribution",
			"attack",
			4
		},
		{
			"cleave_distribution",
			"impact",
			4
		}
	}
}
damage_templates.jab_special = {
	gibbing_power = 0,
	weapon_special = true,
	finesse_ability_damage_multiplier = 2,
	ragdoll_push_force = 250,
	ignore_stagger_reduction = true,
	stagger_category = "uppercut",
	cleave_distribution = no_cleave,
	damage_type = damage_types.blunt_thunder,
	melee_attack_strength = melee_attack_strengths.light,
	gib_push_force = GibbingSettings.gib_push_force.sawing_light,
	stagger_duration_modifier = {
		0.25,
		0.5
	},
	shield_override_stagger_strength = DEFAULT_SHIELD_OVERRIDE_STAGGER_STRENGTH,
	armor_damage_modifier = {
		attack = {
			[armor_types.unarmored] = damage_lerp_values.lerp_1,
			[armor_types.armored] = damage_lerp_values.lerp_0_75,
			[armor_types.resistant] = damage_lerp_values.lerp_2,
			[armor_types.player] = damage_lerp_values.lerp_1,
			[armor_types.berserker] = damage_lerp_values.lerp_1,
			[armor_types.super_armor] = damage_lerp_values.no_damage,
			[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
			[armor_types.void_shield] = damage_lerp_values.lerp_1
		},
		impact = {
			[armor_types.unarmored] = damage_lerp_values.lerp_1,
			[armor_types.armored] = damage_lerp_values.lerp_1,
			[armor_types.resistant] = damage_lerp_values.lerp_1,
			[armor_types.player] = damage_lerp_values.lerp_1,
			[armor_types.berserker] = damage_lerp_values.lerp_1,
			[armor_types.super_armor] = damage_lerp_values.lerp_1,
			[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
			[armor_types.void_shield] = damage_lerp_values.lerp_1
		}
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.5,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_2,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					12,
					30
				},
				impact = {
					2,
					5
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		default_target = {
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				impact = 3,
				attack = {
					10,
					20
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}

return {
	base_templates = damage_templates,
	overrides = overrides
}
