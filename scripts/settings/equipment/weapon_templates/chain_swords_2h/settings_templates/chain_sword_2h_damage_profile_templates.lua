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
local no_cleave = DamageProfileSettings.no_cleave
local single_cleave = DamageProfileSettings.single_cleave
local damage_templates = {}
local overrides = {}

table.make_unique(damage_templates)
table.make_unique(overrides)

local chainsword_sawing = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1_5,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_1,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
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
local chain_sword_crit_mod = {
	attack = {
		[armor_types.unarmored] = 0,
		[armor_types.armored] = 0.3,
		[armor_types.resistant] = 0,
		[armor_types.player] = 0,
		[armor_types.berserker] = 0,
		[armor_types.super_armor] = 0.2,
		[armor_types.disgustingly_resilient] = 0,
		[armor_types.void_shield] = 0
	},
	impact = {
		[armor_types.unarmored] = 0,
		[armor_types.armored] = 0,
		[armor_types.resistant] = 0,
		[armor_types.player] = 0,
		[armor_types.berserker] = 0,
		[armor_types.super_armor] = 0.5,
		[armor_types.disgustingly_resilient] = 0,
		[armor_types.void_shield] = 0
	}
}
local chain_sword_light_mod = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_0_5,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.no_damage,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1_25,
		[armor_types.void_shield] = damage_lerp_values.lerp_0_75
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_1_5,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
local chain_sword_light_smiter_mod = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_0_75,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_9,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_0_75
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_0_75,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_0_75,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_0_75,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
local chain_sword_heavy_mod = {
	attack = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_0_8,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_1,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_25,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1_25,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	},
	impact = {
		[armor_types.unarmored] = damage_lerp_values.lerp_1,
		[armor_types.armored] = damage_lerp_values.lerp_1,
		[armor_types.resistant] = damage_lerp_values.lerp_1,
		[armor_types.player] = damage_lerp_values.lerp_1,
		[armor_types.berserker] = damage_lerp_values.lerp_1_75,
		[armor_types.super_armor] = damage_lerp_values.lerp_0_5,
		[armor_types.disgustingly_resilient] = damage_lerp_values.lerp_1,
		[armor_types.void_shield] = damage_lerp_values.lerp_1
	}
}
damage_templates.default_light_chainsword_2h = {
	sticky_attack = false,
	finesse_ability_damage_multiplier = 1.5,
	ragdoll_only = true,
	ragdoll_push_force = 380,
	stagger_category = "melee",
	crit_mod = chain_sword_crit_mod,
	cleave_distribution = medium_cleave,
	damage_type = damage_types.sawing,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.light,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	wounds_template = WoundsTemplates.chainsword_2h,
	armor_damage_modifier = chain_sword_light_mod,
	targets = {
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_25
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_25
				}
			},
			power_distribution = {
				attack = {
					150,
					300
				},
				impact = {
					8,
					15
				}
			},
			boost_curve_multiplier_finesse = {
				0.4,
				1
			},
			power_level_multiplier = {
				0.6,
				1.4
			}
		},
		{
			power_distribution = {
				attack = {
					100,
					200
				},
				impact = {
					4,
					11
				}
			}
		},
		{
			power_distribution = {
				attack = {
					70,
					140
				},
				impact = {
					3,
					9
				}
			}
		},
		{
			power_distribution = {
				attack = {
					40,
					80
				},
				impact = {
					2,
					5
				}
			}
		},
		{
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					2,
					5
				}
			}
		},
		{
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					2,
					5
				}
			}
		},
		default_target = {
			power_distribution = {
				attack = {
					15,
					30
				},
				impact = {
					2,
					5
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
overrides.light_chainsword_2h_tank = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
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
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				120,
				270
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				90,
				200
			}
		}
	}
}
overrides.light_chainsword_2h_push_follow = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"ragdoll_push_force",
			450
		},
		{
			"cleave_distribution",
			no_cleave
		}
	}
}
overrides.light_chainsword_active_2h_push_follow = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_push_force",
			450
		},
		{
			"cleave_distribution",
			no_cleave
		},
		{
			"weapon_special",
			true
		}
	}
}
overrides.light_chainsword_active_2h = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_hit_reacts",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"cleave_distribution",
			no_cleave
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"weapon_special",
			true
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		}
	}
}
overrides.light_chainsword_active_2h_cleave = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_hit_reacts",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				100,
				200
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
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
		},
		{
			"targets",
			2,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			3,
			"power_distribution",
			"attack",
			{
				75,
				150
			}
		},
		{
			"targets",
			3,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			4,
			"power_distribution",
			"attack",
			{
				75,
				150
			}
		},
		{
			"targets",
			4,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			5,
			"power_distribution",
			"attack",
			{
				75,
				150
			}
		},
		{
			"targets",
			5,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			6,
			"power_distribution",
			"attack",
			{
				75,
				150
			}
		},
		{
			"targets",
			6,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"weapon_special",
			true
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"cleave_distribution",
			big_cleave
		}
	}
}
overrides.light_chainsword_sticky_2h = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"gibbing_power",
			gibbing_power.medium
		},
		{
			"sticky_attack",
			true
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"melee_attack_strength",
			melee_attack_strengths.light
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				10,
				10
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.light_chainsword_sticky_last_2h = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_only",
			true
		},
		{
			"gibbing_power",
			gibbing_power.medium
		},
		{
			"sticky_attack",
			true
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"melee_attack_strength",
			melee_attack_strengths.light
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				350,
				600
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.4,
				0.8
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.light_chainsword_2h_sticky_last_quick = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_only",
			true
		},
		{
			"gibbing_power",
			gibbing_power.medium
		},
		{
			"sticky_attack",
			true
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"melee_attack_strength",
			melee_attack_strengths.light
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				100,
				350
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				5,
				13
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_65
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
damage_templates.smiter_light_chainsword_2h = {
	sticky_attack = false,
	finesse_ability_damage_multiplier = 1.5,
	ragdoll_only = true,
	ragdoll_push_force = 300,
	stagger_category = "melee",
	crit_mod = chain_sword_crit_mod,
	cleave_distribution = single_cleave,
	damage_type = damage_types.sawing,
	gibbing_power = gibbing_power.light,
	gibbing_type = gibbing_types.crushing,
	melee_attack_strength = melee_attack_strengths.light,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	wounds_template = WoundsTemplates.chainsword_2h,
	armor_damage_modifier = chain_sword_light_smiter_mod,
	targets = {
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_3
				}
			},
			power_distribution = {
				attack = {
					175,
					350
				},
				impact = {
					7,
					14
				}
			},
			boost_curve_multiplier_finesse = {
				1,
				2
			},
			power_level_multiplier = {
				0.6,
				1.4
			}
		},
		{
			power_distribution = {
				attack = {
					40,
					80
				},
				impact = {
					3,
					8
				}
			},
			boost_curve_multiplier_finesse = {
				0.4,
				1
			},
			power_level_multiplier = {
				0.6,
				1.4
			}
		},
		default_target = {
			power_distribution = {
				attack = damage_lerp_values.no_damage,
				impact = {
					2,
					5
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
overrides.light_chainsword_2h_smiter_push_follow = {
	parent_template_name = "smiter_light_chainsword_2h",
	overrides = {
		{
			"ragdoll_push_force",
			450
		},
		{
			"cleave_distribution",
			no_cleave
		}
	}
}
overrides.light_chainsword_active_2h_smiter_push_follow = {
	parent_template_name = "smiter_light_chainsword_2h",
	overrides = {
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_push_force",
			450
		},
		{
			"cleave_distribution",
			no_cleave
		},
		{
			"weapon_special",
			true
		}
	}
}
overrides.smiter_light_chainsword_2h_active = {
	parent_template_name = "smiter_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_hit_reacts",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"cleave_distribution",
			no_cleave
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"weapon_special",
			true
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		}
	}
}
overrides.smiter_light_chainsword_2h_sticky = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"gibbing_power",
			gibbing_power.medium
		},
		{
			"sticky_attack",
			true
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"melee_attack_strength",
			melee_attack_strengths.light
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				10,
				10
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.smiter_light_chainsword_sticky_last_2h = {
	parent_template_name = "default_light_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_only",
			true
		},
		{
			"gibbing_power",
			gibbing_power.medium
		},
		{
			"sticky_attack",
			true
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"melee_attack_strength",
			melee_attack_strengths.light
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				425,
				850
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.4,
				0.8
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
damage_templates.heavy_chainsword_2h = {
	sticky_attack = false,
	ragdoll_push_force = 800,
	finesse_ability_damage_multiplier = 1.5,
	ragdoll_only = true,
	stagger_category = "melee",
	crit_mod = chain_sword_crit_mod,
	cleave_distribution = large_cleave,
	damage_type = damage_types.sawing,
	gibbing_power = gibbing_power.heavy,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.heavy,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	wounds_template = WoundsTemplates.chainsword_2h,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	armor_damage_modifier = chain_sword_heavy_mod,
	targets = {
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_5
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					165,
					345
				},
				impact = {
					12,
					24
				}
			},
			boost_curve_multiplier_finesse = {
				0.4,
				1
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					110,
					220
				},
				impact = {
					11,
					22
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					80,
					160
				},
				impact = {
					8,
					16
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					40,
					85
				},
				impact = {
					5,
					9
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					30,
					60
				},
				impact = {
					4,
					8
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					4,
					8
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					20,
					40
				},
				impact = {
					4,
					8
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					20,
					30
				},
				impact = {
					4,
					8
				}
			}
		},
		default_target = {
			armor_damage_modifier = chain_sword_heavy_mod,
			power_distribution = {
				attack = {
					15,
					30
				},
				impact = {
					4,
					8
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
damage_templates.heavy_chainsword_2h_smiter = {
	sticky_attack = false,
	finesse_ability_damage_multiplier = 1.5,
	ragdoll_push_force = 400,
	stagger_category = "melee",
	crit_mod = chain_sword_crit_mod,
	cleave_distribution = no_cleave,
	damage_type = damage_types.sawing,
	gibbing_power = gibbing_power.medium,
	gibbing_type = gibbing_types.sawing,
	melee_attack_strength = melee_attack_strengths.heavy,
	gib_push_force = GibbingSettings.gib_push_force.sawing_heavy,
	wounds_template = WoundsTemplates.chainsword_2h,
	stagger_duration_modifier = {
		0.1,
		0.5
	},
	armor_damage_modifier = chain_sword_heavy_mod,
	targets = {
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1,
					[armor_types.super_armor] = damage_lerp_values.lerp_0_5
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_1
				}
			},
			power_distribution = {
				attack = {
					175,
					350
				},
				impact = {
					8,
					16
				}
			},
			boost_curve_multiplier_finesse = {
				0.5,
				1
			},
			power_level_multiplier = {
				0.7,
				1.3
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					50,
					100
				},
				impact = {
					8,
					14
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					40,
					80
				},
				impact = {
					7,
					10
				}
			}
		},
		{
			armor_damage_modifier = {
				attack = {
					[armor_types.armored] = damage_lerp_values.lerp_1
				},
				impact = {
					[armor_types.super_armor] = damage_lerp_values.lerp_0_65
				}
			},
			power_distribution = {
				attack = {
					25,
					50
				},
				impact = {
					5,
					9
				}
			}
		},
		default_target = {
			armor_damage_modifier = chain_sword_heavy_mod,
			power_distribution = {
				attack = {
					0,
					0
				},
				impact = {
					4,
					8
				}
			},
			boost_curve = PowerLevelSettings.boost_curves.default
		}
	}
}
overrides.heavy_chainsword_active_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"melee"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ragdoll_push_force",
			1300
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				250,
				500
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				200,
				400
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"attack",
			{
				40,
				80
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"impact",
			{
				10,
				20
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"cleave_distribution",
			big_cleave
		}
	}
}
overrides.heavy_chainsword_active_2h_smiter = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"melee"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ragdoll_push_force",
			1300
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				250,
				500
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				200,
				400
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"attack",
			{
				40,
				80
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"impact",
			{
				10,
				20
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"cleave_distribution",
			single_cleave
		}
	}
}
overrides.heavy_chainsword_active_2h_cleave = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"melee"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"ragdoll_push_force",
			1300
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				200,
				400
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				2,
				5
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"attack",
			{
				150,
				300
			}
		},
		{
			"targets",
			2,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			3,
			"power_distribution",
			"attack",
			{
				150,
				300
			}
		},
		{
			"targets",
			3,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			4,
			"power_distribution",
			"attack",
			{
				150,
				300
			}
		},
		{
			"targets",
			4,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			5,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			5,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			6,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			6,
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			7,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			7,
			"power_distribution",
			"impact",
			{
				1,
				2
			}
		},
		{
			"targets",
			8,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			8,
			"power_distribution",
			"impact",
			{
				1,
				2
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"attack",
			{
				40,
				80
			}
		},
		{
			"targets",
			"default_target",
			"power_distribution",
			"impact",
			{
				2,
				4
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		},
		{
			"cleave_distribution",
			"attack",
			math.huge
		},
		{
			"cleave_distribution",
			"impact",
			math.huge
		}
	}
}
overrides.heavy_chainsword_active_abort_2h = {
	parent_template_name = "heavy_chainsword_2h_smiter",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				75,
				200
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"cleave_distribution",
			medium_cleave
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		}
	}
}
overrides.heavy_chainsword_sticky_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template"
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				100,
				200
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				12,
				24
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_3
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_smiter_sticky_quick_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			gibbing_power.light
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template"
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				50,
				100
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				12,
				24
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_3
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_sticky_quick_last_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			gibbing_power.heavy
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				150,
				300
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				0,
				0
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.7,
				1.4
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_65
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_sticky_last_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			6
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				500,
				1000
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				0,
				0
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.4,
				0.8
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_5
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_smiter_sticky_quick_last_2h = {
	parent_template_name = "heavy_chainsword_2h",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			gibbing_power.light
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				150,
				300
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				0,
				0
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.7,
				1.4
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_75
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_smiter_active_abort_2h = {
	parent_template_name = "heavy_chainsword_2h_smiter",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ragdoll_push_force",
			300
		},
		{
			"ignore_shield",
			true
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				18,
				24
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"cleave_distribution",
			no_cleave
		},
		{
			"gibbing_power",
			gibbing_power.light
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"weapon_special",
			true
		}
	}
}
overrides.heavy_chainsword_smiter_sticky_2h = {
	parent_template_name = "heavy_chainsword_2h_smiter",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"stagger_override",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_stagger_reduction",
			true
		},
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_push_force",
			300
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			gibbing_power.light
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template"
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				100,
				200
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				10,
				20
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.2,
				0.6
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			table.clone(chainsword_sawing)
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			"attack",
			"void_shield",
			damage_lerp_values.lerp_0_3
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}
overrides.heavy_chainsword_smiter_sticky_last_2h = {
	parent_template_name = "heavy_chainsword_2h_smiter",
	overrides = {
		{
			"stagger_category",
			"sticky"
		},
		{
			"shield_stagger_category",
			"melee"
		},
		{
			"ignore_shield",
			true
		},
		{
			"ragdoll_push_force",
			300
		},
		{
			"damage_type",
			damage_types.sawing_stuck
		},
		{
			"sticky_attack",
			true
		},
		{
			"ignore_instant_ragdoll_chance",
			true
		},
		{
			"gibbing_power",
			gibbing_power.light
		},
		{
			"gibbing_type",
			gibbing_types.sawing
		},
		{
			"wounds_template",
			WoundsTemplates.chainsword_sawing_2h
		},
		{
			"targets",
			1,
			"power_distribution",
			"attack",
			{
				600,
				1200
			}
		},
		{
			"targets",
			1,
			"power_distribution",
			"impact",
			{
				0,
				0
			}
		},
		{
			"targets",
			1,
			"power_level_multiplier",
			{
				0.5,
				1.5
			}
		},
		{
			"targets",
			1,
			"boost_curve_multiplier_finesse",
			{
				0.4,
				0.8
			}
		},
		{
			"targets",
			1,
			"armor_damage_modifier",
			chainsword_sawing
		},
		{
			"weapon_special",
			true
		},
		{
			"skip_on_hit_proc",
			true
		}
	}
}

return {
	base_templates = damage_templates,
	overrides = overrides
}
