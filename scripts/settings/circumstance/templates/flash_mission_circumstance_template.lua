local MissionOverrides = require("scripts/settings/circumstance/mission_overrides")
local only_melee_mission_overrides = MissionOverrides.merge("no_ammo_pickups", "more_grenade_pickups")
local circumstance_templates = {
	flash_mission_01 = {
		theme_tag = "default",
		mutators = {
			"mutator_monster_specials",
			"mutator_waves_of_specials"
		},
		ui = {
			description = "loc_circumstance_flash_mission_01_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_01_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_02 = {
		theme_tag = "default",
		mutators = {
			"mutator_minion_nurgle_blessing",
			"mutator_waves_of_specials"
		},
		ui = {
			description = "loc_circumstance_flash_mission_02_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_02_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_03 = {
		theme_tag = "default",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_chaos_hounds"
		},
		ui = {
			description = "loc_circumstance_flash_mission_03_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_03_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_04 = {
		theme_tag = "default",
		mutators = {
			"mutator_chaos_hounds",
			"mutator_minion_nurgle_blessing",
			"mutator_ability_cooldown_reduction"
		},
		ui = {
			description = "loc_circumstance_flash_mission_04_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_04_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_05 = {
		dialogue_id = "circumstance_vo_darkness",
		wwise_state = "darkness_01",
		theme_tag = "darkness",
		mutators = {
			"mutator_monster_specials",
			"mutator_waves_of_specials",
			"mutator_darkness_los"
		},
		ui = {
			description = "loc_circumstance_flash_mission_05_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_05_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_06 = {
		dialogue_id = "circumstance_vo_ventilation_purge",
		wwise_state = "ventilation_purge_01",
		theme_tag = "ventilation_purge",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_ventilation_purge_los",
			"mutator_snipers"
		},
		ui = {
			description = "loc_circumstance_flash_mission_06_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_06_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_07 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_07_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_07_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_only_melee_roamers",
			"mutator_only_melee_trickle_hordes",
			"mutator_only_melee_terror_events",
			"mutator_waves_of_specials",
			"mutator_only_traitor_guard_faction",
			"mutator_more_ogryns"
		},
		mission_overrides = only_melee_mission_overrides
	},
	flash_mission_08 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_08_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_08_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_chaos_hounds",
			"mutator_waves_of_specials",
			"mutator_mutants",
			"mutator_ability_cooldown_reduction"
		}
	},
	flash_mission_09 = {
		dialogue_id = "circumstance_vo_ventilation_purge",
		wwise_state = "ventilation_purge_01",
		theme_tag = "ventilation_purge",
		mutators = {
			"mutator_no_encampments",
			"mutator_only_ranged_roamers",
			"mutator_only_ranged_trickle_hordes",
			"mutator_only_traitor_guard_faction",
			"mutator_ability_cooldown_reduction",
			"mutator_ventilation_purge_los",
			"mutator_more_ogryns"
		},
		ui = {
			description = "loc_circumstance_flash_mission_09_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_09_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_10 = {
		theme_tag = "default",
		mutators = {
			"mutator_no_encampments",
			"mutator_waves_of_specials",
			"mutator_minion_nurgle_blessing",
			"mutator_only_traitor_guard_faction",
			"mutator_monster_specials",
			"mutator_enchanced_grenade_ability"
		},
		ui = {
			description = "loc_circumstance_flash_mission_10_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_10_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		}
	},
	flash_mission_11 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_11_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_11_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_poxwalker_bombers",
			"mutator_snipers",
			"mutator_waves_of_specials",
			"mutator_enchanced_grenade_ability"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	flash_mission_12 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_12_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_12_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_poxwalker_bombers",
			"mutator_mutants",
			"mutator_chaos_hounds",
			"mutator_enchanced_grenade_ability"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	flash_mission_13 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_13_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_13_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_mutants",
			"mutator_minion_nurgle_blessing",
			"mutator_waves_of_specials",
			"mutator_ability_cooldown_reduction"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	flash_mission_14 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_14_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_14_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_no_encampments",
			"mutator_waves_of_specials",
			"mutator_more_boss_patrols",
			"mutator_more_ogryns"
		}
	},
	flash_mission_15 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes"
		},
		ui = {
			description = "loc_circumstance_flash_mission_15_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_15_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	flash_mission_16 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_chaos_hounds",
			"mutator_mutants"
		},
		ui = {
			description = "loc_circumstance_flash_mission_16_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_16_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	flash_mission_17 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_minion_nurgle_blessing",
			"mutator_only_cultist_faction",
			"mutator_more_boss_patrols"
		},
		ui = {
			description = "loc_circumstance_flash_mission_17_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_17_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	flash_mission_18 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_monster_specials",
			"mutator_snipers"
		},
		ui = {
			description = "loc_circumstance_flash_mission_18_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_18_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	flash_mission_19 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_monster_specials",
			"mutator_only_melee_roamers",
			"mutator_only_melee_trickle_hordes",
			"mutator_only_melee_terror_events",
			"mutator_more_ogryns"
		},
		ui = {
			description = "loc_circumstance_flash_mission_19_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_flash_mission_19_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	high_flash_mission_01 = {
		theme_tag = "default",
		mutators = {
			"mutator_monster_specials",
			"mutator_waves_of_specials",
			"mutator_add_resistance",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_01_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_01_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_02 = {
		theme_tag = "default",
		mutators = {
			"mutator_minion_nurgle_blessing",
			"mutator_waves_of_specials",
			"mutator_add_resistance",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_02_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_02_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_03 = {
		theme_tag = "default",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_chaos_hounds",
			"mutator_add_resistance",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_03_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_03_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_04 = {
		theme_tag = "default",
		mutators = {
			"mutator_chaos_hounds",
			"mutator_minion_nurgle_blessing",
			"mutator_add_resistance",
			"mutator_ability_cooldown_reduction",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_04_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_04_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_05 = {
		dialogue_id = "circumstance_vo_darkness",
		wwise_state = "darkness_01",
		theme_tag = "darkness",
		mutators = {
			"mutator_monster_specials",
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_darkness_los",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_05_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_05_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_06 = {
		dialogue_id = "circumstance_vo_ventilation_purge",
		wwise_state = "ventilation_purge_01",
		theme_tag = "ventilation_purge",
		mutators = {
			"mutator_waves_of_specials",
			"mutator_add_resistance",
			"mutator_ventilation_purge_los",
			"mutator_snipers",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_06_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_06_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_07 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_07_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_07_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_only_melee_roamers",
			"mutator_only_melee_trickle_hordes",
			"mutator_only_melee_terror_events",
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_only_traitor_guard_faction",
			"mutator_more_ogryns",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		mission_overrides = only_melee_mission_overrides
	},
	high_flash_mission_08 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_08_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_08_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_chaos_hounds",
			"mutator_waves_of_specials",
			"mutator_add_resistance",
			"mutator_mutants",
			"mutator_ability_cooldown_reduction",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		}
	},
	high_flash_mission_09 = {
		dialogue_id = "circumstance_vo_ventilation_purge",
		wwise_state = "ventilation_purge_01",
		theme_tag = "ventilation_purge",
		mutators = {
			"mutator_no_encampments",
			"mutator_only_ranged_roamers",
			"mutator_only_ranged_trickle_hordes",
			"mutator_add_resistance",
			"mutator_only_traitor_guard_faction",
			"mutator_ability_cooldown_reduction",
			"mutator_ventilation_purge_los",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_more_ogryns"
		},
		ui = {
			description = "loc_circumstance_flash_mission_09_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_09_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_10 = {
		theme_tag = "default",
		mutators = {
			"mutator_no_encampments",
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_minion_nurgle_blessing",
			"mutator_only_traitor_guard_faction",
			"mutator_monster_specials",
			"mutator_enchanced_grenade_ability",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		ui = {
			description = "loc_circumstance_flash_mission_10_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_10_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		}
	},
	high_flash_mission_11 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_11_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_11_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_poxwalker_bombers",
			"mutator_snipers",
			"mutator_waves_of_specials",
			"mutator_add_resistance",
			"mutator_enchanced_grenade_ability",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	high_flash_mission_12 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_12_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_12_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_poxwalker_bombers",
			"mutator_mutants",
			"mutator_chaos_hounds",
			"mutator_add_resistance",
			"mutator_enchanced_grenade_ability",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	high_flash_mission_13 = {
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_13_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_13_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_mutants",
			"mutator_minion_nurgle_blessing",
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_ability_cooldown_reduction",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		},
		mission_overrides = MissionOverrides.no_empty_hazards
	},
	high_flash_mission_14 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_flash_mission_14_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_14_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mutators = {
			"mutator_no_encampments",
			"mutator_waves_of_specials",
			"mutator_more_boss_patrols",
			"mutator_more_ogryns",
			"mutator_add_resistance",
			"mutator_increase_terror_event_points",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier"
		}
	},
	high_flash_mission_15 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_increase_terror_event_points"
		},
		ui = {
			description = "loc_circumstance_flash_mission_15_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_15_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	high_flash_mission_16 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_chaos_hounds",
			"mutator_mutants",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_increase_terror_event_points"
		},
		ui = {
			description = "loc_circumstance_flash_mission_16_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_16_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	high_flash_mission_17 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_minion_nurgle_blessing",
			"mutator_only_cultist_faction",
			"mutator_more_boss_patrols",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_increase_terror_event_points"
		},
		ui = {
			description = "loc_circumstance_flash_mission_17_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_17_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	high_flash_mission_18 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_monster_specials",
			"mutator_snipers",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_increase_terror_event_points"
		},
		ui = {
			description = "loc_circumstance_flash_mission_18_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_18_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	high_flash_mission_19 = {
		dialogue_id = "circumstance_vo_toxic_gas",
		wwise_state = "ventilation_purge_01",
		theme_tag = "toxic_gas",
		mutators = {
			"mutator_add_resistance",
			"mutator_waves_of_specials",
			"mutator_toxic_gas_volumes",
			"mutator_monster_specials",
			"mutator_reduced_ramp_duration",
			"mutator_auric_tension_modifier",
			"mutator_increase_terror_event_points",
			"mutator_only_melee_roamers",
			"mutator_only_melee_trickle_hordes",
			"mutator_only_melee_terror_events",
			"mutator_more_ogryns"
		},
		ui = {
			description = "loc_circumstance_flash_mission_19_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_02",
			display_name = "loc_circumstance_flash_mission_19_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_02"
		},
		mission_overrides = MissionOverrides.more_corruption_syringes
	},
	six_one_flash_mission_01 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_six_one_flash_mission_01_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_six_one_flash_mission_01_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_modify_challenge_resistance_scale_six_one",
			"mutator_specials_required_challenge_rating",
			"mutator_travel_distance_spawning_specials",
			"mutator_travel_distance_spawning_hordes",
			"mutator_more_alive_specials",
			"mutator_higher_stagger_thresholds",
			"mutator_no_encampments"
		}
	},
	six_one_flash_mission_02 = {
		dialogue_id = "circumstance_vo_ventilation_purge",
		wwise_state = "ventilation_purge_01",
		theme_tag = "ventilation_purge",
		ui = {
			description = "loc_circumstance_six_one_flash_mission_02_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_six_one_flash_mission_02_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_modify_challenge_resistance_scale_six_one",
			"mutator_specials_required_challenge_rating",
			"mutator_travel_distance_spawning_specials",
			"mutator_travel_distance_spawning_hordes",
			"mutator_more_alive_specials",
			"mutator_higher_stagger_thresholds",
			"mutator_no_encampments",
			"mutator_ventilation_purge_los"
		}
	},
	six_one_flash_mission_03 = {
		dialogue_id = "circumstance_vo_darkness",
		wwise_state = "darkness_01",
		theme_tag = "darkness",
		ui = {
			description = "loc_circumstance_six_one_flash_mission_03_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_six_one_flash_mission_03_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_darkness_los",
			"mutator_modify_challenge_resistance_scale_six_one",
			"mutator_specials_required_challenge_rating",
			"mutator_travel_distance_spawning_specials",
			"mutator_travel_distance_spawning_hordes",
			"mutator_more_alive_specials",
			"mutator_higher_stagger_thresholds",
			"mutator_no_encampments"
		}
	},
	six_one_flash_mission_04 = {
		wwise_state = "None",
		theme_tag = "default",
		ui = {
			description = "loc_circumstance_six_one_flash_mission_04_description",
			icon = "content/ui/materials/icons/circumstances/maelstrom_01",
			display_name = "loc_circumstance_six_one_flash_mission_04_title",
			mission_board_icon = "content/ui/materials/mission_board/circumstances/maelstrom_01"
		},
		mutators = {
			"mutator_modify_challenge_resistance_scale_six_one",
			"mutator_specials_required_challenge_rating",
			"mutator_travel_distance_spawning_specials",
			"mutator_travel_distance_spawning_hordes",
			"mutator_more_alive_specials",
			"mutator_higher_stagger_thresholds",
			"mutator_no_encampments",
			"mutator_waves_of_specials"
		}
	}
}

return circumstance_templates
