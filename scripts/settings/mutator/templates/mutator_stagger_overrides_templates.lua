local StaggerSettings = require("scripts/settings/damage/stagger_settings")
local stagger_types = StaggerSettings.stagger_types
local mutator_templates = {
	mutator_higher_stagger_thresholds = {
		class = "scripts/managers/mutator/mutators/mutator_stagger_overrides",
		stagger_overrides = {
			stagger_thresholds = {
				renegade_melee = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				cultist_melee = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				renegade_rifleman = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				renegade_assault = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				cultist_assault = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				chaos_poxwalker = {
					[stagger_types.light] = 1,
					[stagger_types.medium] = 50,
					[stagger_types.heavy] = 100,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 8,
					[stagger_types.killshot] = 4
				},
				chaos_newly_infected = {
					[stagger_types.light] = 1,
					[stagger_types.medium] = 50,
					[stagger_types.heavy] = 100,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 8,
					[stagger_types.killshot] = 4
				},
				renegade_executor = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				renegade_gunner = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				cultist_gunner = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				cultist_shocktrooper = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				renegade_shocktrooper = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				cultist_berzerker = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				renegade_berzerker = {
					[stagger_types.light] = 100,
					[stagger_types.medium] = 200,
					[stagger_types.heavy] = 300,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				chaos_ogryn_executor = {
					[stagger_types.light] = 300,
					[stagger_types.medium] = 400,
					[stagger_types.heavy] = 500,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				chaos_ogryn_bulwark = {
					[stagger_types.light] = 300,
					[stagger_types.medium] = 400,
					[stagger_types.heavy] = 500,
					[stagger_types.light_ranged] = 300,
					[stagger_types.killshot] = 300,
					[stagger_types.sticky] = 1,
					[stagger_types.explosion] = 200
				},
				chaos_ogryn_gunner = {
					[stagger_types.light] = 300,
					[stagger_types.medium] = 400,
					[stagger_types.heavy] = 500,
					[stagger_types.light_ranged] = 300,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 300,
					[stagger_types.explosion] = 200
				},
				chaos_armored_infected = {
					[stagger_types.light] = 10,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 150,
					[stagger_types.explosion] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				}
			}
		}
	},
	havoc_higher_stagger_thresholds = {
		class = "scripts/managers/mutator/mutators/mutator_stagger_overrides",
		stagger_overrides = {
			stagger_thresholds = {
				renegade_melee = {
					[stagger_types.light] = 6,
					[stagger_types.medium] = 30,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 80,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				},
				cultist_melee = {
					[stagger_types.light] = 6,
					[stagger_types.medium] = 30,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 10,
					[stagger_types.killshot] = 40
				},
				renegade_rifleman = {
					[stagger_types.light] = 5,
					[stagger_types.medium] = 20,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 10,
					[stagger_types.killshot] = 8
				},
				renegade_assault = {
					[stagger_types.light] = 5,
					[stagger_types.medium] = 20,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 10,
					[stagger_types.killshot] = 8
				},
				cultist_assault = {
					[stagger_types.light] = 5,
					[stagger_types.medium] = 20,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 10,
					[stagger_types.killshot] = 8
				},
				chaos_poxwalker = {
					[stagger_types.light] = 3,
					[stagger_types.medium] = 20,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 8,
					[stagger_types.killshot] = 4
				},
				chaos_newly_infected = {
					[stagger_types.light] = 3,
					[stagger_types.medium] = 20,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 60,
					[stagger_types.light_ranged] = 8,
					[stagger_types.killshot] = 4
				},
				renegade_executor = {
					[stagger_types.light] = 35,
					[stagger_types.medium] = 50,
					[stagger_types.heavy] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 40,
					[stagger_types.explosion] = 200
				},
				renegade_gunner = {
					[stagger_types.light] = 15,
					[stagger_types.medium] = 40,
					[stagger_types.heavy] = 80,
					[stagger_types.light_ranged] = 60,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 60,
					[stagger_types.explosion] = 200
				},
				cultist_gunner = {
					[stagger_types.light] = 15,
					[stagger_types.medium] = 40,
					[stagger_types.heavy] = 80,
					[stagger_types.light_ranged] = 60,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 60,
					[stagger_types.explosion] = 200
				},
				cultist_shocktrooper = {
					[stagger_types.light] = 15,
					[stagger_types.medium] = 40,
					[stagger_types.heavy] = 80,
					[stagger_types.light_ranged] = 60,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 60,
					[stagger_types.explosion] = 200
				},
				renegade_shocktrooper = {
					[stagger_types.light] = 15,
					[stagger_types.medium] = 40,
					[stagger_types.heavy] = 80,
					[stagger_types.light_ranged] = 60,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 60,
					[stagger_types.explosion] = 200
				},
				cultist_berzerker = {
					[stagger_types.light] = 20,
					[stagger_types.medium] = 50,
					[stagger_types.heavy] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 40,
					[stagger_types.explosion] = 80
				},
				renegade_berzerker = {
					[stagger_types.light] = 20,
					[stagger_types.medium] = 50,
					[stagger_types.heavy] = 100,
					[stagger_types.light_ranged] = 80,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 40,
					[stagger_types.explosion] = 80
				},
				chaos_ogryn_executor = {
					[stagger_types.light] = 50,
					[stagger_types.medium] = 80,
					[stagger_types.heavy] = 160,
					[stagger_types.light_ranged] = 120,
					[stagger_types.sticky] = 20,
					[stagger_types.killshot] = 120,
					[stagger_types.explosion] = 200
				},
				chaos_ogryn_bulwark = {
					[stagger_types.light] = 35,
					[stagger_types.medium] = 60,
					[stagger_types.heavy] = 120,
					[stagger_types.light_ranged] = 100,
					[stagger_types.killshot] = 100,
					[stagger_types.sticky] = 5,
					[stagger_types.explosion] = 200
				},
				chaos_ogryn_gunner = {
					[stagger_types.light] = 35,
					[stagger_types.medium] = 60,
					[stagger_types.heavy] = 120,
					[stagger_types.light_ranged] = 60,
					[stagger_types.sticky] = 5,
					[stagger_types.killshot] = 60,
					[stagger_types.explosion] = 40
				},
				chaos_armored_infected = {
					[stagger_types.light] = 6,
					[stagger_types.medium] = 30,
					[stagger_types.heavy] = 50,
					[stagger_types.explosion] = 80,
					[stagger_types.light_ranged] = 80,
					[stagger_types.killshot] = 40
				}
			}
		}
	}
}

return mutator_templates
