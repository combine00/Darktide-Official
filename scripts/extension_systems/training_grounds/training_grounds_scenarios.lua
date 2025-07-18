local TrainingGroundsSteps = require("scripts/extension_systems/training_grounds/training_grounds_steps")
local TrainingGroundsItemNames = require("scripts/settings/training_grounds/training_grounds_item_names")
local scenarios = {}
local post_scenario_complete_ui_remove_delay = 1
local post_ui_removed_transition_start_delay = 1.8
scenarios.default = {
	steps = {
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "basic_training")
	},
	cleanup = {}
}
scenarios.basic_training = {
	steps = {
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", false, true),
		TrainingGroundsSteps.dynamic.level_flow_event("training_grounds_initialized"),
		TrainingGroundsSteps.make_player_invulnerable,
		TrainingGroundsSteps.basic_training,
		TrainingGroundsSteps.dynamic.delay(5),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "attack_chains")
	},
	cleanup = {}
}
scenarios.attack_chains = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_nerfed_damage"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m3),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.m1_chain_attack_prompt,
		TrainingGroundsSteps.attack_chains_kill_infected_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "attack_chains_heavy")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff("tg_player_nerfed_damage"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.attack_chains_heavy = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_nerfed_damage"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m3),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.chain_attack_heavy_prompt,
		TrainingGroundsSteps.attack_chains_kill_infected_loop_heavy,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "weapon_special")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff("tg_player_nerfed_damage"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.weapon_special = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.weapon_special_prompt_ogrynknife,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("psyker"),
		TrainingGroundsSteps.weapon_special_prompt_forcesword,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.forcesword_p1_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.weapon_special_prompt_chainsword,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.chainsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.use_weapon_special_attack,
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.use_activated_weapon_special_attack,
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "push")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.push = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.push_prompt,
		TrainingGroundsSteps.push_enemies_loop,
		TrainingGroundsSteps.dynamic.delay(1),
		TrainingGroundsSteps.push_clean_enemies,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.condition_if.archetype_is("psyker"),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "biomancer_blitz"),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "ranged_grenade")
	},
	cleanup = {
		TrainingGroundsSteps.push_clean_enemies,
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.ranged_grenade = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.set_grenade_count(4),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.condition_if.archetype_is("veteran"),
		TrainingGroundsSteps.veteran_ranger_blitz_prompt,
		TrainingGroundsSteps.kill_enemies_grenade_loop,
		TrainingGroundsSteps.condition_elseif.archetype_is("ogryn"),
		TrainingGroundsSteps.ogryn_bonebreaker_blitz_prompt,
		TrainingGroundsSteps.kill_enemies_grenade_loop_ogryn_bonebreaker,
		TrainingGroundsSteps.condition_elseif.archetype_is("zealot"),
		TrainingGroundsSteps.dynamic.scenario_data_set("grenade_objective", "maniac_blitz"),
		TrainingGroundsSteps.zealot_maniac_blitz_prompt,
		TrainingGroundsSteps.stun_enemies_grenade_loop,
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.veteran_ranger_blitz_prompt,
		TrainingGroundsSteps.kill_enemies_grenade_loop,
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.ranged_grenade_prompt,
		TrainingGroundsSteps.kill_enemies_grenade_loop,
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.set_grenade_count(0),
		TrainingGroundsSteps.dynamic.wield_slot("slot_primary"),
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "combat_ability")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.set_grenade_count(0),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.biomancer_blitz = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.psyker_biomancer_blitz_prompt,
		TrainingGroundsSteps.psyker_biomancer_blitz_loop,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "combat_ability")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.combat_ability = {
	steps = {
		TrainingGroundsSteps.ensure_player_healthy,
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", true, true),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_short_ability_cooldown"),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.combat_ability_prompt_ogryn_bonebreaker,
		TrainingGroundsSteps.combat_ability_loop_ogryn_bonebreaker,
		TrainingGroundsSteps.dynamic.delay(2.5),
		TrainingGroundsSteps.combat_ability_ogryn_bonebreaker_remove,
		TrainingGroundsSteps.condition_elseif.archetype_is("psyker"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", false, true),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_on_combat_ability_hook"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.combat_ability_prompt_psyker_biomancer,
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", true, true),
		TrainingGroundsSteps.dynamic.trigger_vo_event("combat_ability_psyker_1"),
		TrainingGroundsSteps.combat_ability_loop_psyker_biomancer,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.combat_ability_biomancer_remove,
		TrainingGroundsSteps.dynamic.remove_unique_buff("tg_on_combat_ability_hook"),
		TrainingGroundsSteps.condition_elseif.archetype_is("zealot"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_on_combat_ability_hook"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.chainsword_p1_m1),
		TrainingGroundsSteps.combat_ability_prompt_zealot_maniac,
		TrainingGroundsSteps.combat_ability_loop_zealot_maniac,
		TrainingGroundsSteps.dynamic.remove_unique_buff("tg_on_combat_ability_hook"),
		TrainingGroundsSteps.condition_elseif.archetype_is("veteran"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.lasgun_p1_m1),
		TrainingGroundsSteps.combat_ability_prompt,
		TrainingGroundsSteps.combat_ability_loop_veteran_ranger,
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.shotgun_p4_m1),
		TrainingGroundsSteps.combat_ability_prompt_adamant_buff_drone,
		TrainingGroundsSteps.combat_ability_loop_adamant_buff_drone,
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.condition_if.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "adamant_companion_targeting"),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "dodging"),
		TrainingGroundsSteps.condition_end
	},
	cleanup = {
		TrainingGroundsSteps.generic_dissolve_scenario_enemies,
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_short_ability_cooldown"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_on_combat_ability_hook")
	}
}
scenarios.adamant_companion_targeting = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.adamant_companion_targeting_prompt,
		TrainingGroundsSteps.dynamic.delay(1),
		TrainingGroundsSteps.adamant_companion_spawn,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.adamant_companion_targeting_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "dodging")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.adamant_companion_despawn,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.dodging = {
	steps = {
		TrainingGroundsSteps.ensure_player_healthy,
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_on_dodge_tutorial"),
		TrainingGroundsSteps.dodge_prompt,
		TrainingGroundsSteps.dodge_loop,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "toughness_pre")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_on_dodge_tutorial")
	}
}
scenarios.toughness_pre = {
	steps = {
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", false, true),
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.remove_player_invulnerable,
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.toughness_pre_prompt,
		TrainingGroundsSteps.toughness_pre_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.make_player_invulnerable,
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "toughness")
	},
	cleanup = {
		TrainingGroundsSteps.make_player_invulnerable,
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false)
	}
}
scenarios.toughness = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.toughness_prompt,
		TrainingGroundsSteps.toughness_wait_for_kill,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_no_coherency"),
		TrainingGroundsSteps.toughness_spawn_bot,
		TrainingGroundsSteps.dynamic.delay(3),
		TrainingGroundsSteps.toughness_remove_bot,
		TrainingGroundsSteps.dynamic.trigger_vo_event("training_end"),
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", true, true),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "part_1_completed")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_increased_coherency"),
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_no_coherency")
	}
}
scenarios.part_1_completed = {
	steps = {
		TrainingGroundsSteps.part_1_completed_decide_continue,
		TrainingGroundsSteps.condition_if.scenario_data_equals("continue_training", true),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "advanced_training"),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.trigger_training_complete,
		TrainingGroundsSteps.condition_end
	},
	cleanup = {}
}
scenarios.advanced_training = {
	steps = {
		TrainingGroundsSteps.advanced_training,
		TrainingGroundsSteps.make_player_invulnerable,
		TrainingGroundsSteps.dynamic.set_ability_enabled("combat_ability", false, true),
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "armor_types")
	},
	cleanup = {}
}
scenarios.armor_types = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.trigger_vo_event("armor"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.armor_types_prompt,
		TrainingGroundsSteps.armor_types_heavy_armored_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "push_follow")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.push_follow = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_club_p2_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("psyker"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.forcesword_p1_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.chainsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.push_follow_prompt,
		TrainingGroundsSteps.push_follow_enemies_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "healing_self_and_others")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.healing_self_and_others = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.ogryn_rippergun_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.shotgun_p4_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.lasgun_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.healing_self_and_others_prompt,
		TrainingGroundsSteps.healing_self_and_others_spawn_bot,
		TrainingGroundsSteps.spawn_med_and_ammo_kits,
		TrainingGroundsSteps.wait_for_full_health_and_ammo,
		TrainingGroundsSteps.wait_for_full_ammo,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "reviving")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.health_and_ammo_cleanup
	}
}
scenarios.reviving = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.reviving_prompt,
		TrainingGroundsSteps.reviving_spawn_bot,
		TrainingGroundsSteps.reviving_wait_for_bot_revival,
		TrainingGroundsSteps.dynamic.delay(1),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.corruption_prompt,
		TrainingGroundsSteps.remove_player_invulnerable,
		TrainingGroundsSteps.reviving_spawn_servitor,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.reviving_wait_for_player_revival,
		TrainingGroundsSteps.make_player_invulnerable,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.health_station_prompt,
		TrainingGroundsSteps.reviving_spawn_health_station,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "tagging")
	},
	cleanup = {
		TrainingGroundsSteps.reviving_cleanup,
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.remove_all_bots
	}
}
scenarios.tagging = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.tagging_prompt,
		TrainingGroundsSteps.dynamic.delay(2),
		TrainingGroundsSteps.sniper_tag_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "sprint_slide")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.sprint_slide = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.sprint_slide_prompt,
		TrainingGroundsSteps.sprint_slide,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.dynamic.teleport_player("sprint_player_start"),
		TrainingGroundsSteps.sprint_dodge_run_through_corridor,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.lock_in_melee_prompt,
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.sprint_dodge_flank_enemies,
		TrainingGroundsSteps.sprint_dodge_kill_enemies,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "ranged_suppression")
	},
	cleanup = {
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.sprint_dodge_cleanup,
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}
scenarios.ranged_suppression = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("suppression_player_spawn"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.ogryn_rippergun_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.shotgun_p4_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.autopistol_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.ranged_suppression_prompt,
		TrainingGroundsSteps.ranged_suppression_enemies_loop,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "incoming_suppression")
	},
	cleanup = {
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.hide_prompt
	}
}
scenarios.incoming_suppression = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("suppression_player_spawn"),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", false, false),
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_on_ammo_consumed_hook"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.ogryn_rippergun_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.autogun_p1_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.lasgun_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.incoming_supression_prompt,
		TrainingGroundsSteps.incoming_suppression_crouch,
		TrainingGroundsSteps.incoming_suppression_loop,
		TrainingGroundsSteps.dynamic.delay(1.5),
		TrainingGroundsSteps.incoming_suppression_loop_2,
		TrainingGroundsSteps.dynamic.delay(1.5),
		TrainingGroundsSteps.dynamic.set_ability_enabled("grenade_ability", true, false),
		TrainingGroundsSteps.incoming_suppression_loop_3,
		TrainingGroundsSteps.dynamic.delay(post_scenario_complete_ui_remove_delay),
		TrainingGroundsSteps.dynamic.trigger_vo_event("training_end_advanced"),
		TrainingGroundsSteps.hide_prompt,
		TrainingGroundsSteps.dynamic.delay(post_ui_removed_transition_start_delay),
		TrainingGroundsSteps.dynamic.swap_scenario("training_grounds", "end_of_training_grounds")
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_on_ammo_consumed_hook"),
		TrainingGroundsSteps.cleanup_incoming_suppression,
		TrainingGroundsSteps.hide_prompt
	}
}
scenarios.end_of_training_grounds = {
	steps = {
		TrainingGroundsSteps.dynamic.teleport_player("player_reset"),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.unarmed_training_grounds),
		TrainingGroundsSteps.condition_if.archetype_is("ogryn"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.ogryn_combatblade_p1_m1),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.ogryn_rippergun_p1_m1),
		TrainingGroundsSteps.condition_elseif.archetype_is("adamant"),
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.powermaul_p2_m1),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.autogun_p1_m1),
		TrainingGroundsSteps.condition_else,
		TrainingGroundsSteps.dynamic.equip_item("slot_primary", TrainingGroundsItemNames.combatsword_p1_m1),
		TrainingGroundsSteps.dynamic.equip_item("slot_secondary", TrainingGroundsItemNames.lasgun_p1_m1),
		TrainingGroundsSteps.condition_end,
		TrainingGroundsSteps.dynamic.add_unique_buff("tg_player_unperceivable"),
		TrainingGroundsSteps.end_of_tg_prompt,
		TrainingGroundsSteps.end_of_tg_loop,
		TrainingGroundsSteps.trigger_training_complete
	},
	cleanup = {
		TrainingGroundsSteps.cleanup_ragdolls,
		TrainingGroundsSteps.dynamic.remove_unique_buff_safe("tg_player_unperceivable")
	}
}

for name, scenario_template in pairs(scenarios) do
	scenario_template.name = name
end

return scenarios
