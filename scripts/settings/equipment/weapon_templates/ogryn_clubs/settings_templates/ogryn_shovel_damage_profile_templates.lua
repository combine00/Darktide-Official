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
local big_cleave = DamageProfileSettings.big_cleave
local large_cleave = DamageProfileSettings.large_cleave
local medium_cleave = DamageProfileSettings.medium_cleave
local single_cleave = DamageProfileSettings.single_cleave
local damage_templates = {}
local overrides = {}

table.make_unique(damage_templates)
table.make_unique(overrides)

local tank_light_am_1 = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_0_75,
		[armor_types.resistant] = damage_lerp_values.lerp_2,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
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
}
local tank_light_am_default = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_0_75,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.no_damage,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_5,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
local tank_heavy_am_1 = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1_33,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_2,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1_33,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
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
}
local tank_heavy_am_default = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1_25,
		[armor_types.armored] = damage_lerp_values.lerp_0_75,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.no_damage,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1_25,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_5,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
local tank_heavy_am_m3 = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1_5,
		[armor_types.armored] = damage_lerp_values.lerp_0_5,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_65,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_2,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1_5,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_0_5,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_5,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_65,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
damage_templates.ogryn_shovel_light_tank = {
	ragdoll_push_force = 350,
	ragdoll_only = true,
	stagger_category = "melee",
	cleave_distribution = large_cleave,
	damage_type = damage_types.shovel_heavy,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	armor_damage_modifier = tank_light_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = tank_light_am_1,
			power_distribution = {
				attack = {
					70,
					140
				},
				impact = {
					8,
					16
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					50,
					100
				},
				impact = {
					7,
					14
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					45,
					90
				},
				impact = {
					6,
					12
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					35,
					65
				},
				impact = {
					5,
					10
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					5,
					10
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = tank_light_am_default,
			power_distribution = {
				attack = {
					10,
					20
				},
				impact = {
					4,
					8
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
damage_templates.ogryn_shovel_light_tank_followup = {
	ragdoll_push_force = 350,
	ragdoll_only = true,
	stagger_category = "melee",
	cleave_distribution = medium_cleave,
	damage_type = damage_types.shovel_heavy,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	armor_damage_modifier = tank_light_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = tank_light_am_1,
			power_distribution = {
				attack = {
					70,
					140
				},
				impact = {
					12,
					24
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					25,
					50
				},
				impact = {
					10,
					20
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					20,
					30
				},
				impact = {
					5,
					10
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = tank_light_am_default,
			power_distribution = {
				attack = {
					0,
					0
				},
				impact = {
					3,
					6
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
damage_templates.ogryn_shovel_heavy_tank = {
	ragdoll_push_force = 750,
	ragdoll_only = true,
	stagger_category = "melee",
	cleave_distribution = big_cleave,
	damage_type = damage_types.shovel_heavy,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.heavy,
	wounds_template = WoundsTemplates.ogryn_shovel,
	armor_damage_modifier = tank_heavy_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.35,
			armor_damage_modifier = tank_heavy_am_1,
			power_distribution = {
				attack = {
					100,
					200
				},
				impact = {
					10,
					25
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					10,
					25
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					60,
					120
				},
				impact = {
					10,
					20
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					40,
					80
				},
				impact = {
					10,
					25
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					10,
					20
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = tank_heavy_am_default,
			power_distribution = {
				attack = {
					10,
					20
				},
				impact = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
overrides.ogryn_shovel_heavy_tank_m3 = {
	parent_template_name = "ogryn_shovel_heavy_tank",
	overrides = {
		{
			"armor_damage_modifier",
			tank_heavy_am_m3
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			tank_heavy_am_m3
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				120,
				260
			}
		},
		{
			"ragdoll_push_force",
			350
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				90,
				220
			}
		},
		{
			"targets",
			3,
			"power_distribution",
			"attack",
			{
				80,
				180
			}
		},
		{
			"targets",
			4,
			"power_distribution",
			"attack",
			{
				70,
				150
			}
		}
	}
}
damage_templates.ogryn_shovel_light_smiter = {
	ragdoll_push_force = 500,
	ragdoll_only = true,
	stagger_category = "melee",
	cleave_distribution = single_cleave,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	armor_damage_modifier = tank_light_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.5,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_75,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_75,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				}
			},
			power_distribution = {
				attack = {
					150,
					300
				},
				impact = {
					8,
					16
				}
			},
			finesse_boost = {
				[armor_types.unarmored] = 0.6,
				[armor_types.armored] = 0.5,
				[armor_types.resistant] = 0.5,
				[armor_types.player] = 0.1,
				[armor_types.berserker] = 0.2,
				[armor_types.super_armor] = 0.1,
				[armor_types.disgustingly_resilient] = 0.5,
				[armor_types.void_shield] = 0.25
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					60,
					80
				},
				impact = {
					5,
					10
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.no_damage,
					[armor_types.void_shield] = damage_lerp_values.no_damage
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.no_damage,
					[armor_types.void_shield] = damage_lerp_values.no_damage
				}
			},
			power_distribution = {
				attack = {
					20,
					30
				},
				impact = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.1,
				[armor_types.armored] = 0.5,
				[armor_types.resistant] = 0.1,
				[armor_types.player] = 0.1,
				[armor_types.berserker] = 0.1,
				[armor_types.super_armor] = 0.1,
				[armor_types.disgustingly_resilient] = 0.5,
				[armor_types.void_shield] = 0.5
			}
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
overrides.ogryn_shovel_light_special = {
	parent_template_name = "ogryn_shovel_light_smiter",
	overrides = {
		{
			"stagger_category",
			"melee"
		},
		{
			"cleave_distribution",
			big_cleave
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"weapon_special",
			true
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				175,
				650
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"super_armor",
			damage_lerp_values.lerp_0_5
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"berserker",
			damage_lerp_values.lerp_2
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				90,
				120
			}
		}
	}
}
overrides.ogryn_shovel_heavy_special = {
	parent_template_name = "ogryn_shovel_heavy_smiter",
	overrides = {
		{
			"stagger_category",
			"melee"
		},
		{
			"cleave_distribution",
			big_cleave
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"weapon_special",
			true
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				300,
				1100
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			0.25
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"super_armor",
			damage_lerp_values.lerp_0_9
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"disgustingly_resilient",
			damage_lerp_values.lerp_1
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"berserker",
			damage_lerp_values.lerp_1_5
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				100,
				200
			}
		}
	}
}
damage_templates.ogryn_shovel_heavy_smiter = {
	ragdoll_push_force = 800,
	ragdoll_only = true,
	stagger_category = "melee",
	cleave_distribution = single_cleave,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.heavy,
	wounds_template = WoundsTemplates.ogryn_shovel,
	armor_damage_modifier = tank_heavy_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.5,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1_5,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
					[armor_types.void_shield] = damage_lerp_values.lerp_0_75
				}
			},
			power_distribution = {
				attack = {
					190,
					380
				},
				impact = {
					10,
					24
				}
			},
			finesse_boost = {
				[armor_types.unarmored] = 0.9,
				[armor_types.armored] = 0.5,
				[armor_types.resistant] = 0.5,
				[armor_types.player] = 0.1,
				[armor_types.berserker] = 0.5,
				[armor_types.super_armor] = 0.1,
				[armor_types.disgustingly_resilient] = 0.7,
				[armor_types.void_shield] = 0.25
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					60,
					80
				},
				impact = {
					10,
					20
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.no_damage,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.no_damage
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.no_damage
				}
			},
			power_distribution = {
				attack = {
					20,
					30
				},
				impact = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default,
			finesse_boost = {
				[armor_types.unarmored] = 0.1,
				[armor_types.armored] = 0.5,
				[armor_types.resistant] = 0.1,
				[armor_types.player] = 0.1,
				[armor_types.berserker] = 0.1,
				[armor_types.super_armor] = 0.1,
				[armor_types.disgustingly_resilient] = 0.5,
				[armor_types.void_shield] = 0.5
			}
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
damage_templates.ogryn_shovel_uppercut = {
	ragdoll_only = true,
	weapon_special = true,
	ragdoll_push_force = 700,
	stagger_category = "explosion",
	cleave_distribution = medium_cleave,
	gibbing_power = gibbing_power.always,
	gibbing_type = gibbing_types.default,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	armor_damage_modifier = tank_light_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.5,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_75,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_1,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1_5
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_1,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					30,
					60
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
					[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				impact = 8,
				attack = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
damage_templates.ogryn_shovel_uppercut_plus = {
	ragdoll_only = true,
	weapon_special = true,
	ragdoll_push_force = 500,
	stagger_category = "explosion",
	cleave_distribution = medium_cleave,
	gibbing_power = gibbing_power.always,
	gibbing_type = gibbing_types.default,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	armor_damage_modifier = tank_light_am_default,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.5,
			armor_damage_modifier = {
				attack = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_2,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_5,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_7,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_9,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_6,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					100,
					200
				},
				impact = {
					30,
					60
				}
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
					[armor_types.armored] = damage_lerp_values.lerp_0_4,
					[armor_types.resistant] = damage_lerp_values.lerp_0_2,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_4,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_05,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.unarmored] = damage_lerp_values.lerp_1,
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_7,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_9,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_6,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					8,
					16
				}
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
					[armor_types.armored] = damage_lerp_values.lerp_0_5,
					[armor_types.resistant] = damage_lerp_values.lerp_0_7,
					[armor_types.player] = damage_lerp_values.lerp_1,
					[armor_types.berserker] = damage_lerp_values.lerp_0_9,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_6,
					[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
					[armor_types.void_shield] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				impact = 8,
				attack = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
overrides.ogryn_shovel_smiter_pushfollow = {
	parent_template_name = "ogryn_shovel_heavy_smiter",
	overrides = {
		{
			"cleave_distribution",
			"attack",
			0.2
		},
		{
			"cleave_distribution",
			"impact",
			0.6
		}
	}
}
damage_templates.ogryn_shovel_heavy_linesman = {
	ragdoll_push_force = 800,
	ragdoll_only = true,
	stagger_category = "melee",
	armor_damage_modifier = tank_light_am_default,
	cleave_distribution = large_cleave,
	damage_type = damage_types.shovel_heavy,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.heavy,
	wounds_template = WoundsTemplates.ogryn_shovel,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					175,
					360
				},
				impact = {
					10,
					25
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					100,
					220
				},
				impact = {
					10,
					25
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					70,
					150
				},
				impact = {
					10,
					20
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					10,
					20
				},
				impact = {
					5,
					10
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}
damage_templates.ogryn_shovel_light_linesman = {
	ragdoll_push_force = 800,
	ragdoll_only = true,
	stagger_category = "melee",
	armor_damage_modifier = tank_light_am_default,
	cleave_distribution = medium_cleave,
	damage_type = damage_types.shovel_heavy,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.light,
	wounds_template = WoundsTemplates.ogryn_shovel,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	targets = {
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					100,
					220
				},
				impact = {
					6,
					13
				}
			},
			power_level_multiplier = {
				0.5,
				1.5
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					5,
					10
				}
			}
		},
		{
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					60,
					120
				},
				impact = {
					4,
					8
				}
			}
		},
		default_target = {
			boost_curve_multiplier_finesse = 0.25,
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					3,
					6
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	},
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy
}

return {
	base_templates = damage_templates,
	overrides = overrides
}
