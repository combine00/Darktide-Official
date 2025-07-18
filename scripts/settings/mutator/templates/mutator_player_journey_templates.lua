local mutator_templates = {
	mutator_player_journey_01_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				cultist_grenadier = "renegade_flamer",
				chaos_hound = "cultist_mutant",
				renegade_sniper = "renegade_gunner",
				chaos_ogryn_gunner = "renegade_gunner",
				renegade_berzerker = "renegade_melee",
				chaos_ogryn_executor = "renegade_executor"
			}
		}
	},
	mutator_player_journey_02_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				renegade_sniper = "renegade_gunner",
				chaos_hound = "cultist_mutant",
				cultist_grenadier = "renegade_flamer",
				chaos_ogryn_gunner = "renegade_gunner",
				chaos_ogryn_executor = "renegade_executor"
			}
		}
	},
	mutator_player_journey_03_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_ogryn_gunner = "renegade_gunner",
				renegade_sniper = "renegade_gunner",
				cultist_grenadier = "renegade_flamer",
				chaos_ogryn_executor = "renegade_executor"
			}
		}
	},
	mutator_player_journey_04_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_ogryn_gunner = "cultist_gunner",
				renegade_sniper = "cultist_gunner",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_05_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				renegade_sniper = "cultist_gunner",
				chaos_spawn = "chaos_plague_ogryn",
				chaos_beast_of_nurgle = "chaos_plague_ogryn",
				chaos_ogryn_gunner = "cultist_gunner",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_06_A_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				renegade_sniper = "cultist_gunner",
				chaos_spawn = "chaos_plague_ogryn",
				chaos_beast_of_nurgle = "chaos_plague_ogryn",
				chaos_ogryn_gunner = "cultist_gunner",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_07_A_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				renegade_sniper = "cultist_gunner",
				chaos_spawn = "chaos_plague_ogryn",
				chaos_beast_of_nurgle = "chaos_plague_ogryn",
				chaos_ogryn_gunner = "cultist_gunner",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_06_B_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				renegade_sniper = "cultist_gunner",
				chaos_spawn = "chaos_plague_ogryn",
				chaos_beast_of_nurgle = "chaos_plague_ogryn",
				chaos_ogryn_gunner = "cultist_gunner",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_07_B_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_ogryn_gunner = "cultist_gunner",
				chaos_spawn = "chaos_plague_ogryn",
				cultist_grenadier = "cultist_flamer"
			}
		}
	},
	mutator_player_journey_08_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_spawn = "chaos_plague_ogryn"
			}
		}
	},
	mutator_player_journey_09_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_spawn = "chaos_plague_ogryn"
			}
		}
	},
	mutator_player_journey_011_A_replacement = {
		class = "scripts/managers/mutator/mutators/mutator_replace_breed",
		init_replacement_breed = {
			breed_replacement = {
				chaos_spawn = "chaos_plague_ogryn"
			}
		}
	}
}

return mutator_templates
