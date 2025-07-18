local BuffSettings = require("scripts/settings/buff/buff_settings")
local buff_keywords = BuffSettings.keywords
local mutator_templates = {
	mutator_common_minions_on_fire = {
		class = "scripts/managers/mutator/mutators/mutator_modify_havoc",
		init_modify_horde = {
			horde_buffed_config = {
				buff_name = "common_minion_on_fire",
				breed_allowed = {
					chaos_poxwalker = true,
					chaos_newly_infected = true
				}
			}
		}
	},
	mutator_corrupted_enemies = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_corrupted_enemies"
			},
			breed_chances = {
				cultist_assault = 0.1,
				cultist_flamer = 0.1,
				renegade_assault = 0.1,
				chaos_spawn = 0,
				chaos_poxwalker_bomber = 0.1,
				cultist_mutant = 0.1,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 1,
				cultist_melee = 0.1,
				chaos_poxwalker = 0.1,
				cultist_shocktrooper = 0.1,
				chaos_beast_of_nurgle = 0,
				chaos_ogryn_gunner = 0.1,
				renegade_berzerker = 0.1,
				chaos_newly_infected = 0.1,
				renegade_sniper = 0.1,
				renegade_flamer = 0.1,
				chaos_armored_infected = 0.1,
				renegade_gunner = 0.1,
				renegade_grenadier = 0.1,
				cultist_berzerker = 0.1,
				renegade_netgunner = 0.1,
				renegade_rifleman = 0.1,
				cultist_grenadier = 0.1,
				renegade_shocktrooper = 0.1,
				chaos_hound = 0.1,
				renegade_captain = 0.2,
				chaos_ogryn_bulwark = 0.1,
				cultist_gunner = 0.1,
				renegade_melee = 0.1,
				renegade_executor = 0.1,
				chaos_ogryn_executor = 0.1
			}
		}
	},
	mutator_duplicating_enemies = {
		class = "scripts/managers/mutator/mutators/mutator_nurgle_warp",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_duplicating_enemies"
			},
			breed_chances = {
				cultist_assault = 1,
				cultist_flamer = 1,
				renegade_assault = 1,
				chaos_spawn = 1,
				chaos_poxwalker_bomber = 0,
				cultist_mutant = 1,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 1,
				cultist_melee = 1,
				chaos_poxwalker = 0,
				cultist_shocktrooper = 1,
				chaos_beast_of_nurgle = 0,
				chaos_ogryn_gunner = 1,
				renegade_berzerker = 1,
				chaos_newly_infected = 0,
				renegade_sniper = 1,
				renegade_flamer = 1,
				renegade_shocktrooper = 1,
				renegade_gunner = 1,
				renegade_netgunner = 1,
				cultist_berzerker = 1,
				renegade_rifleman = 1,
				renegade_grenadier = 1,
				cultist_grenadier = 1,
				renegade_captain = 1,
				chaos_hound = 0,
				chaos_ogryn_bulwark = 1,
				cultist_gunner = 1,
				renegade_melee = 1,
				renegade_executor = 1,
				chaos_ogryn_executor = 1
			}
		}
	},
	mutator_explosive_enemies = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_explosive_enemies"
			},
			breed_chances = {
				cultist_assault = 0.1,
				cultist_flamer = 0.35,
				renegade_assault = 0.1,
				chaos_spawn = 1,
				chaos_poxwalker_bomber = 0.35,
				cultist_mutant = 0.35,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 1,
				cultist_melee = 0.1,
				chaos_poxwalker = 1,
				cultist_shocktrooper = 0.25,
				chaos_beast_of_nurgle = 1,
				chaos_ogryn_gunner = 0.25,
				renegade_berzerker = 0.25,
				chaos_newly_infected = 1,
				renegade_sniper = 0.35,
				renegade_flamer = 0.35,
				renegade_shocktrooper = 0.25,
				renegade_gunner = 0.25,
				renegade_netgunner = 0.35,
				cultist_berzerker = 0.25,
				renegade_rifleman = 0.1,
				renegade_grenadier = 0.25,
				cultist_grenadier = 0.35,
				renegade_captain = 0.2,
				chaos_hound = 0.35,
				chaos_ogryn_bulwark = 0.35,
				cultist_gunner = 0.1,
				renegade_melee = 0.1,
				renegade_executor = 0.25,
				chaos_ogryn_executor = 0.35
			}
		}
	},
	mutator_headshot_parasite_enemies = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"headshot_parasite_enemies"
			},
			breed_chances = {
				renegade_flamer = 0.05,
				chaos_mutated_poxwalker = 0.1,
				renegade_assault = 0.1,
				cultist_grenadier = 0.1,
				cultist_melee = 0.1,
				chaos_lesser_mutated_poxwalker = 0.1,
				cultist_flamer = 0.1,
				chaos_beast_of_nurgle = 0,
				cultist_mutant = 0,
				chaos_poxwalker = 0.1,
				renegade_rifleman = 0.1,
				cultist_shocktrooper = 0.1,
				chaos_ogryn_gunner = 0.2,
				cultist_assault = 0.1,
				renegade_shocktrooper = 0.1,
				chaos_armored_infected = 0.05,
				renegade_gunner = 0.1,
				cultist_berzerker = 0.1,
				chaos_newly_infected = 0.1,
				chaos_spawn = 0,
				renegade_melee = 0.1,
				chaos_ogryn_executor = 0.2,
				chaos_poxwalker_bomber = 0,
				renegade_grenadier = 0.1,
				chaos_daemonhost = 0,
				chaos_plague_ogryn = 0,
				renegade_berzerker = 0.25,
				renegade_sniper = 0,
				renegade_netgunner = 0,
				renegade_captain = 0,
				chaos_hound = 0,
				chaos_ogryn_bulwark = 0.2,
				cultist_gunner = 0.1,
				renegade_executor = 0.05
			}
		}
	},
	mutator_bolstering_minions = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_bolstering"
			},
			ignored_buff_keyword = buff_keywords.stimmed,
			breed_chances = {
				renegade_flamer = 0.35,
				renegade_rifleman = 0.1,
				renegade_assault = 0.1,
				chaos_beast_of_nurgle = 1,
				cultist_melee = 0.1,
				cultist_captain = 0.2,
				cultist_grenadier = 0.35,
				chaos_armored_infected = 0.05,
				cultist_mutant = 0.35,
				chaos_poxwalker = 0.05,
				cultist_flamer = 0.35,
				cultist_shocktrooper = 0.25,
				chaos_ogryn_gunner = 0.25,
				cultist_assault = 0.1,
				renegade_shocktrooper = 0.25,
				renegade_gunner = 0.25,
				cultist_berzerker = 0.25,
				chaos_newly_infected = 0.05,
				chaos_spawn = 1,
				renegade_melee = 0.1,
				chaos_ogryn_executor = 0.35,
				chaos_poxwalker_bomber = 0.35,
				renegade_grenadier = 0.25,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 1,
				renegade_berzerker = 0.25,
				renegade_sniper = 0.35,
				renegade_netgunner = 0.35,
				renegade_captain = 0.2,
				chaos_hound = 0.35,
				chaos_ogryn_bulwark = 0.35,
				cultist_gunner = 0.1,
				renegade_executor = 0.25
			}
		}
	},
	mutator_tough_skin_enemies = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_toughened_skin"
			},
			breed_chances = {
				cultist_assault = 0.1,
				cultist_flamer = 0.35,
				renegade_assault = 0.1,
				chaos_spawn = 0,
				chaos_poxwalker_bomber = 0.5,
				cultist_mutant = 0,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 0,
				cultist_melee = 0.1,
				chaos_poxwalker = 0,
				cultist_shocktrooper = 0.25,
				chaos_beast_of_nurgle = 0,
				chaos_ogryn_gunner = 0.5,
				renegade_berzerker = 0.25,
				chaos_newly_infected = 0,
				renegade_sniper = 0.35,
				renegade_flamer = 0.35,
				chaos_armored_infected = 0,
				renegade_gunner = 0.5,
				renegade_grenadier = 0.25,
				cultist_berzerker = 0.3,
				renegade_netgunner = 0.35,
				renegade_rifleman = 0.1,
				cultist_grenadier = 0.35,
				renegade_shocktrooper = 0.25,
				chaos_hound = 0.3,
				renegade_captain = 0.2,
				chaos_ogryn_bulwark = 0.5,
				cultist_gunner = 0.5,
				renegade_melee = 0.1,
				renegade_executor = 0.25,
				chaos_ogryn_executor = 0
			}
		}
	},
	mutator_havoc_horde_toughened_skin = {
		class = "scripts/managers/mutator/mutators/mutator_modify_havoc",
		init_modify_horde = {
			horde_buffed_config = {
				buff_name = "havoc_toughened_skin",
				breed_allowed = {
					chaos_poxwalker = true,
					chaos_newly_infected = true
				}
			}
		}
	},
	mutator_havoc_sticky_poxburster = {
		class = "scripts/managers/mutator/mutators/mutator_nurgle_warp",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_sticky_poxburster"
			},
			breed_chances = {
				chaos_poxwalker_bomber = 1,
				chaos_armored_bomber = 1
			}
		},
		compositions = {
			{
				"chaos_poxwalker",
				"chaos_poxwalker",
				"chaos_poxwalker",
				"chaos_lesser_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker"
			},
			{
				"chaos_lesser_mutated_poxwalker",
				"chaos_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker"
			},
			{
				"chaos_lesser_mutated_poxwalker",
				"chaos_poxwalker",
				"chaos_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker",
				"chaos_mutated_poxwalker"
			}
		}
	},
	mutator_havoc_thorny_armor = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_thorny_armor"
			},
			breed_chances = {
				cultist_assault = 0.1,
				cultist_flamer = 0.35,
				renegade_assault = 0.1,
				chaos_spawn = 0,
				chaos_poxwalker_bomber = 0.35,
				cultist_mutant = 0,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 0,
				cultist_melee = 0.1,
				chaos_poxwalker = 0.35,
				cultist_shocktrooper = 0.25,
				chaos_beast_of_nurgle = 0,
				chaos_ogryn_gunner = 0.25,
				renegade_berzerker = 0.25,
				chaos_newly_infected = 0.35,
				renegade_sniper = 0.35,
				renegade_flamer = 0.35,
				chaos_armored_infected = 0.1,
				renegade_gunner = 0.25,
				renegade_grenadier = 0.25,
				cultist_berzerker = 0.25,
				renegade_netgunner = 0.35,
				renegade_rifleman = 0.1,
				cultist_grenadier = 0.35,
				renegade_shocktrooper = 0.25,
				chaos_hound = 0.35,
				renegade_captain = 0.2,
				chaos_ogryn_bulwark = 0.35,
				cultist_gunner = 0.1,
				renegade_melee = 0.1,
				renegade_executor = 0.25,
				chaos_ogryn_executor = 0
			}
		}
	},
	mutator_havoc_enraged = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_enraged_enemies_trigger"
			},
			breed_chances = {
				renegade_flamer = 0,
				renegade_rifleman = 0,
				renegade_assault = 0,
				chaos_beast_of_nurgle = 0,
				cultist_melee = 0,
				cultist_captain = 1,
				cultist_grenadier = 0,
				chaos_armored_infected = 0,
				cultist_mutant = 0,
				chaos_poxwalker = 0,
				cultist_flamer = 0,
				cultist_shocktrooper = 1,
				chaos_ogryn_gunner = 1,
				cultist_assault = 0,
				renegade_shocktrooper = 1,
				renegade_gunner = 1,
				cultist_berzerker = 1,
				chaos_newly_infected = 0,
				chaos_spawn = 0,
				renegade_melee = 0,
				chaos_ogryn_executor = 1,
				chaos_poxwalker_bomber = 0,
				renegade_grenadier = 0,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 0,
				renegade_berzerker = 1,
				renegade_sniper = 0,
				renegade_netgunner = 0,
				renegade_captain = 1,
				chaos_hound = 0,
				chaos_ogryn_bulwark = 1,
				cultist_gunner = 1,
				renegade_executor = 1
			}
		}
	},
	mutator_encroaching_garden = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_encroaching_garden"
			},
			breed_chances = {
				renegade_flamer = 0,
				renegade_rifleman = 0,
				renegade_assault = 0,
				chaos_beast_of_nurgle = 0,
				cultist_melee = 0,
				cultist_captain = 1,
				cultist_grenadier = 0,
				chaos_armored_infected = 0,
				cultist_mutant = 0,
				chaos_poxwalker = 0,
				cultist_flamer = 0,
				cultist_shocktrooper = 0.25,
				chaos_ogryn_gunner = 0.25,
				cultist_assault = 0,
				renegade_shocktrooper = 0.25,
				renegade_gunner = 0.25,
				cultist_berzerker = 0.25,
				chaos_newly_infected = 0,
				chaos_spawn = 0,
				renegade_melee = 0,
				chaos_ogryn_executor = 0.35,
				chaos_poxwalker_bomber = 0,
				renegade_grenadier = 0,
				chaos_daemonhost = 0.1,
				chaos_plague_ogryn = 0,
				renegade_berzerker = 0.25,
				renegade_sniper = 0,
				renegade_netgunner = 0,
				renegade_captain = 0.2,
				chaos_hound = 0,
				chaos_ogryn_bulwark = 0.35,
				cultist_gunner = 0.25,
				renegade_executor = 0.25
			}
		}
	},
	mutator_havoc_no_stagger_ritualist = {
		class = "scripts/managers/mutator/mutators/mutator_minion_nurgle_blessing",
		random_spawn_buff_templates = {
			buffs = {
				"havoc_no_stagger"
			},
			breed_chances = {
				chaos_mutator_ritualist = 1
			}
		}
	},
	mutator_enable_auric = {
		class = "scripts/managers/mutator/mutators/mutator_modify_pacing",
		init_modify_pacing = {
			is_auric = true
		}
	},
	mutator_havoc_override_horde_pacing_01 = {
		pacing_override = "havoc_01",
		class = "scripts/managers/mutator/mutators/mutator_horde_pacing_overrides",
		template_name = "mutator_horde"
	},
	mutator_havoc_override_horde_pacing_02 = {
		pacing_override = "havoc_02",
		class = "scripts/managers/mutator/mutators/mutator_horde_pacing_overrides",
		template_name = "mutator_horde"
	},
	mutator_havoc_bauble = {
		class = "scripts/managers/mutator/mutators/mutator_pestilent_bauble"
	}
}

return mutator_templates
