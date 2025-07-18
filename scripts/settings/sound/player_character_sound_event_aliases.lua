local events = {
	sfx_foley_upper_body = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_upper_body_gen",
				cloth_metal = "wwise/events/player/play_upper_body_gen",
				cloth = "wwise/events/player/play_foley_material_cloth",
				cloth_chains = "wwise/events/player/play_upper_body_gen",
				metal = "wwise/events/player/play_foley_material_metal",
				leather_chains = "wwise/events/player/play_foley_material_leather",
				nude = "wwise/events/player/play_foley_material_cloth",
				leather_plate = "wwise/events/player/play_upper_body_plate_leather",
				cloth_loose = "wwise/events/player/play_foley_material_cloth",
				leather_metal = "wwise/events/player/play_foley_material_leather",
				leather = "wwise/events/player/play_foley_material_leather"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_upper_body_gen",
				cloth_metal = "wwise/events/player/play_ogryn_upper_body_gen",
				cloth = "wwise/events/player/play_ogryn_upper_body_cloth",
				cloth_chains = "wwise/events/player/play_ogryn_upper_body_cloth_chains",
				nude = "wwise/events/player/play_ogryn_upper_body_cloth",
				leather_chains = "wwise/events/player/play_ogryn_upper_body_leather",
				metal = "wwise/events/player/play_ogryn_upper_body_armor_metal",
				cloth_loose = "wwise/events/player/play_ogryn_upper_body_cloth",
				leather_metal = "wwise/events/player/play_ogryn_upper_body_leather",
				leather = "wwise/events/player/play_ogryn_upper_body_leather"
			}
		}
	},
	sfx_foley_upper_body_emotes = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_upper_body_gen_emote",
				cloth_metal = "wwise/events/player/play_upper_body_gen_emote",
				cloth = "wwise/events/player/play_foley_material_cloth_emote",
				cloth_chains = "wwise/events/player/play_upper_body_gen_emote",
				metal = "wwise/events/player/play_foley_material_metal_emote",
				leather_chains = "wwise/events/player/play_foley_material_leather_emote",
				nude = "wwise/events/player/play_foley_material_cloth_emote",
				leather_plate = "wwise/events/player/play_upper_body_plate_leather_emote",
				cloth_loose = "wwise/events/player/play_foley_material_cloth_emote",
				leather_metal = "wwise/events/player/play_foley_material_leather_emote",
				leather = "wwise/events/player/play_foley_material_leather_emote"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_upper_body_gen_emote",
				cloth_metal = "wwise/events/player/play_ogryn_upper_body_gen_emote",
				cloth = "wwise/events/player/play_ogryn_upper_body_cloth_emote",
				cloth_chains = "wwise/events/player/play_ogryn_upper_body_gen_emote",
				nude = "wwise/events/player/play_ogryn_upper_body_cloth_emote",
				leather_chains = "wwise/events/player/play_ogryn_upper_body_leather_emote",
				metal = "wwise/events/player/play_ogryn_upper_body_armor_metal_emote",
				cloth_loose = "wwise/events/player/play_ogryn_upper_body_cloth_emote",
				leather_metal = "wwise/events/player/play_ogryn_upper_body_leather_emote",
				leather = "wwise/events/player/play_ogryn_upper_body_leather_emote"
			}
		}
	},
	sfx_foley_land = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_land_gen",
				cloth_metal = "wwise/events/player/play_land_gen",
				cloth = "wwise/events/player/play_land_gen",
				cloth_chains = "wwise/events/player/play_land_gen",
				metal = "wwise/events/player/play_land_gen",
				leather_chains = "wwise/events/player/play_land_gen",
				nude = "wwise/events/player/play_land_gen",
				leather_plate = "wwise/events/player/play_land_gen",
				cloth_loose = "wwise/events/player/play_land_gen",
				leather_metal = "wwise/events/player/play_land_gen",
				leather = "wwise/events/player/play_land_gen"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_land_gen",
				cloth_metal = "wwise/events/player/play_ogryn_land_gen",
				cloth = "wwise/events/player/play_ogryn_land_gen",
				cloth_chains = "wwise/events/player/play_ogryn_land_gen",
				nude = "wwise/events/player/play_ogryn_land_gen",
				leather_chains = "wwise/events/player/play_ogryn_land_gen",
				metal = "wwise/events/player/play_ogryn_land_gen",
				cloth_loose = "wwise/events/player/play_ogryn_land_gen",
				leather_metal = "wwise/events/player/play_ogryn_land_gen",
				leather = "wwise/events/player/play_ogryn_land_gen"
			}
		}
	},
	sfx_player_extra_slot = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"sfx_player_extra_slot"
		},
		events = {
			skulls = "wwise/events/player/play_gear_skulls_med",
			backpack = "wwise/events/player/play_gear_backpack_fire_foley",
			chains = "wwise/events/player/play_gear_chain_med"
		}
	},
	sfx_foley_short = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_player_foley_arms"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_foley_arms_gen"
			}
		}
	},
	sfx_foley_subtle = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_player_foley_subtle"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_foley_subtle"
			}
		}
	},
	sfx_foley_arms_drastic = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_player_foley_arms_drastic"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_foley_arms_drastic"
			}
		}
	},
	sfx_foley_swing_light = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_swing_light_gen"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_swing_light_gen"
			}
		}
	},
	sfx_foley_swing_heavy = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_swing_heavy_gen"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_swing_heavy_gen"
			}
		}
	},
	ladder_climbing_hands = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_foley_hands_ladder_metal"
			},
			ogryn = {
				default = "wwise/events/player/play_foley_hands_ladder_metal"
			}
		}
	},
	ladder_climbing_feet = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_footstep_boots_medium_ladder"
			},
			ogryn = {
				default = "wwise/events/player/play_footstep_boots_medium_ladder"
			}
		}
	},
	sfx_hand_scratch = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_foley_hands_scratch_beard"
			},
			ogryn = {
				default = "wwise/events/player/play_foley_hands_scratch_beard"
			}
		}
	},
	sfx_hand_knuckle = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_foley_hands_knuckle"
			},
			ogryn = {
				default = "wwise/events/player/play_foley_hands_knuckle"
			}
		}
	},
	sfx_hand_snot = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_foley_hands_ogryn_snot"
			},
			ogryn = {
				default = "wwise/events/player/play_foley_hands_ogryn_snot"
			}
		}
	},
	sfx_hand_clap_soft = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_human_clap_soft"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_clap_soft"
			}
		}
	},
	sfx_hand_knife_scrape = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_human_knife_clean"
			},
			ogryn = {
				default = "wwise/events/player/play_human_knife_clean"
			}
		}
	},
	sfx_chest_hit = {
		has_husk_events = false,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_ogryn_hit_chest"
			},
			ogryn = {
				default = "wwise/events/player/play_ogryn_hit_chest"
			}
		}
	},
	sfx_servo_skull_deploy = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/player/play_servitor_scanning_deploy",
				breach_charge = "wwise/events/player/play_int_breach_charge_activate_human"
			},
			ogryn = {
				default = "wwise/events/player/play_servitor_scanning_deploy",
				breach_charge = "wwise/events/player/play_int_breach_charge_activate_ogryn"
			}
		}
	},
	sfx_share_ally = {
		has_husk_events = true,
		switch = {
			"archetype",
			"sfx_body_material"
		},
		events = {
			default = {
				default = "wwise/events/player/play_player_foley_give_item"
			},
			ogryn = {
				default = "wwise/events/player/play_player_foley_give_item"
			}
		}
	},
	footstep_left = {
		has_husk_events = true,
		switch = {
			"archetype",
			"footstep_type_left"
		},
		events = {
			default = {
				default = "wwise/events/player/play_footstep_boots_medium",
				mech = "wwise/events/player/play_footstep_prosthetic_mech",
				pegleg = "wwise/events/player/play_footstep_prosthetic"
			},
			ogryn = {
				default = "wwise/events/player/play_footstep_boots_heavy",
				pegleg = "wwise/events/player/play_footstep_prosthetic_heavy"
			}
		}
	},
	footstep_right = {
		has_husk_events = true,
		switch = {
			"archetype",
			"footstep_type_right"
		},
		events = {
			default = {
				default = "wwise/events/player/play_footstep_boots_medium",
				mech = "wwise/events/player/play_footstep_prosthetic_mech",
				pegleg = "wwise/events/player/play_footstep_prosthetic"
			},
			ogryn = {
				default = "wwise/events/player/play_footstep_boots_heavy",
				pegleg = "wwise/events/player/play_footstep_prosthetic_heavy"
			}
		}
	},
	footstep_jump = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_footstep_boots_medium_jump",
			ogryn = "wwise/events/player/play_footstep_ogryn_jump"
		}
	},
	footstep_land = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_footstep_boots_medium_land",
			ogryn = "wwise/events/player/play_footstep_ogryn_land"
		}
	},
	footstep_companion_left_front = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_front_left"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_footstep_metal_foot",
				organic = "wwise/events/player/play_npc_dog_footstep_normal_foot"
			}
		}
	},
	footstep_companion_right_front = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_front_right"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_footstep_metal_foot",
				organic = "wwise/events/player/play_npc_dog_footstep_normal_foot"
			}
		}
	},
	footstep_companion_left_rear = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_rear_left"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_footstep_metal_foot",
				organic = "wwise/events/player/play_npc_dog_footstep_normal_foot"
			}
		}
	},
	footstep_companion_right_rear = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_rear_right"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_footstep_metal_foot",
				organic = "wwise/events/player/play_npc_dog_footstep_normal_foot"
			}
		}
	},
	footstep_companion_scuff = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_rear_right"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_scuff_normal_foot",
				organic = "wwise/events/player/play_npc_dog_scuff_normal_foot"
			}
		}
	},
	footstep_companion_land = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_front_left"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_land_metal_foot",
				organic = "wwise/events/player/play_npc_dog_land_normal_foot"
			}
		}
	},
	footstep_companion_down = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"companion_footstep_type_front_left"
		},
		events = {
			adamant = {
				mech = "wwise/events/player/play_npc_dog_down_metal",
				organic = "wwise/events/player/play_npc_dog_down_normal"
			}
		}
	},
	companion_growl = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/play_adamant_dog_vce_growl_01",
				mix = "wwise/events/player/play_adamant_dog_vce_growl_01",
				normal = "wwise/events/player/play_adamant_dog_vce_growl_01"
			}
		}
	},
	companion_whimper = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/play_adamant_dog_vce_whimper_01",
				mix = "wwise/events/player/play_adamant_dog_vce_whimper_01",
				normal = "wwise/events/player/play_adamant_dog_vce_whimper_01"
			}
		}
	},
	companion_bark = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/play_adamant_dog_vce_bark_01",
				mix = "wwise/events/player/play_adamant_dog_vce_bark_01",
				normal = "wwise/events/player/play_adamant_dog_vce_bark_01"
			}
		}
	},
	companion_attack = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/play_adamant_dog_vce_attack_01",
				mix = "wwise/events/player/play_adamant_dog_vce_attack_01",
				normal = "wwise/events/player/play_adamant_dog_vce_attack_01"
			}
		}
	},
	companion_hurt = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/play_adamant_dog_vce_hurt_01",
				mix = "wwise/events/player/play_adamant_dog_vce_hurt_01",
				normal = "wwise/events/player/play_adamant_dog_vce_hurt_01"
			}
		}
	},
	sfx_ladder_foot = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_footstep_boots_medium_ladder",
			ogryn = "wwise/events/player/play_footstep_boots_medium_ladder"
		}
	},
	sfx_ladder_hand = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_foley_hands_ladder_metal",
			ogryn = "wwise/events/player/play_foley_hands_ladder_metal"
		}
	},
	netted_struggle = {
		has_husk_events = false,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_foley_player_netted_struggle",
			ogryn = "wwise/events/player/play_foley_player_netted_struggle"
		}
	},
	ground_hit = {
		has_husk_events = false,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_player_foley_body_impact_medium_ground",
			ogryn = "wwise/events/player/play_player_foley_body_impact_medium_ground"
		}
	},
	sfx_footstep_dodge = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_footsteps_boots_dodge",
			ogryn = "wwise/events/player/play_footstep_ogryn_dodge"
		}
	},
	player_vault = {
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			default = "wwise/events/player/play_vault"
		}
	},
	sfx_ability_foley_01 = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"archetype"
		},
		events = {
			zealot = "wwise/events/player/play_foley_melee_equip_gen_short",
			psyker = "wwise/events/player/play_psyker_warp_charge_overload_start"
		}
	},
	sfx_ability_foley_02 = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"archetype"
		},
		events = {
			zealot = "wwise/events/player/play_ability_zealot_preacher_book_close",
			psyker = "wwise/events/player/play_psyker_warp_charge_overload_stop"
		}
	},
	attack_long_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_attack_long",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_attack_long",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_attack_long",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_attack_long",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_attack_long",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_attack_long",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_attack_long",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_attack_long",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_attack_long",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_attack_long",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_attack_long",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_attack_long",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_attack_long",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_attack_long",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_attack_long",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_attack_long",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_attack_long",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_attack_long",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_attack_long",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_attack_long",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_attack_long",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_attack_long",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_attack_long",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_attack_long",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_attack_long",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_attack_long",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_attack_long",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_attack_long"
		}
	},
	attack_short_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_attack_short",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_attack_short",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_attack_short",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_attack_short",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_attack_short",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_attack_short",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_attack_short",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_attack_short",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_attack_short",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_attack_short",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_attack_short",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_attack_short",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_attack_short",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_attack_short",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_attack_short",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_attack_short",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_attack_short",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_attack_short",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_attack_short",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_attack_short",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_attack_short",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_attack_short",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_attack_short",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_attack_short",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_attack_short",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_attack_short",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_attack_short",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_attack_short"
		}
	},
	catapulted_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_catapulted",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_catapulted",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_catapulted",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_catapulted",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_catapulted",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_catapulted",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_catapulted",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_catapulted",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_catapulted",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_catapulted",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_catapulted",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_catapulted",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_catapulted",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_catapulted",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_catapulted",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_catapulted",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_catapulted",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_catapulted",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_catapulted",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_catapulted",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_catapulted",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_catapulted",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_catapulted",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_catapulted",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_catapulted",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_catapulted",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_catapulted",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_catapulted"
		}
	},
	catapulted_land_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_catapulted_land",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_catapulted_land",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_catapulted_land",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_catapulted_land",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_catapulted_land",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_catapulted_land",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_catapulted_land",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_catapulted_land",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_catapulted_land",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_catapulted_land",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_catapulted_land",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_catapulted_land",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_catapulted_land",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_catapulted_land",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_catapulted_land",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_catapulted_land",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_catapulted_land",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_catapulted_land",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_catapulted_land",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_catapulted_land",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_catapulted_land",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_catapulted_land",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_catapulted_land",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_catapulted_land",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_catapulted_land",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_catapulted_land",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_catapulted_land",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_catapulted_land"
		}
	},
	coughing_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_coughing",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_coughing",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_coughing",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_coughing",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_coughing",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_coughing",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_coughing",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_coughing",
			explicator_a = "wwise/events/player/play_veteran_female_b__vce_coughing",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_coughing",
			veteran_female_c = "wwise/events/player/play_veteran_female_b__vce_coughing",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_coughing",
			adamant_female_a = "wwise/events/player/play_adamant_female_c__vce_coughing",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_coughing",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_coughing",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_coughing",
			psyker_female_a = "wwise/events/player/play_psyker_female_c__vce_coughing",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_coughing",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_coughing",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_coughing",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_coughing",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_coughing",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_coughing",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_coughing",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_coughing",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_coughing",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_coughing",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_coughing"
		}
	},
	coughing_ends_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_coughing_ends",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_coughing_ends",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_coughing_ends",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_coughing_ends",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_coughing_ends",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_coughing_ends",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_coughing_ends",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_coughing_ends",
			explicator_a = "wwise/events/player/play_veteran_female_b__vce_coughing_ends",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_coughing_ends",
			veteran_female_c = "wwise/events/player/play_veteran_female_b__vce_coughing_ends",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_coughing_ends",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_coughing_ends",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_coughing_ends",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_coughing_ends",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_coughing_ends",
			psyker_female_a = "wwise/events/player/play_psyker_female_c__vce_coughing_ends",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_coughing_ends",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_coughing_ends",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_coughing_ends",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_coughing_ends",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_coughing_ends",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_coughing_ends",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_coughing_ends",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_coughing_ends",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_coughing_ends",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_coughing_ends",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_coughing_ends"
		}
	},
	getting_up_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_getting_up",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_getting_up",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_getting_up",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_getting_up",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_getting_up",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_getting_up",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_getting_up",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_getting_up",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_getting_up",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_getting_up",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_getting_up",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_getting_up",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_getting_up",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_getting_up",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_getting_up",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_getting_up",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_getting_up",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_getting_up",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_getting_up",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_getting_up",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_getting_up",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_getting_up",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_getting_up",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_getting_up",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_getting_up",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_getting_up",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_getting_up",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_getting_up"
		}
	},
	grunt_short_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_grunt_short",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_grunt_short",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_grunt_short",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_grunt_short",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_grunt_short",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_grunt_short",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_grunt_short",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_grunt_short",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_grunt_short",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_grunt_short",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_grunt_short",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_grunt_short",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_grunt_short",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_grunt_short",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_grunt_short",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_grunt_short",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_grunt_short",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_grunt_short",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_grunt_short",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_grunt_short",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_grunt_short",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_grunt_short",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_grunt_short",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_grunt_short",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_grunt_short",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_grunt_short",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_grunt_short",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_grunt_short"
		}
	},
	hurt_heavy_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_hurt_heavy",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_hurt_heavy",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_hurt_heavy",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_hurt_heavy",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_hurt_heavy",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_hurt_heavy",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_hurt_heavy",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_hurt_heavy",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_hurt_heavy",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_hurt_heavy",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_hurt_heavy",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_hurt_heavy",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_hurt_heavy",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_hurt_heavy",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_hurt_heavy",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_hurt_heavy",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_hurt_heavy",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_hurt_heavy",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_hurt_heavy",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_hurt_heavy",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_hurt_heavy",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_hurt_heavy",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_hurt_heavy",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_hurt_heavy",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_hurt_heavy",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_hurt_heavy",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_hurt_heavy",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_hurt_heavy"
		}
	},
	hurt_light_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_hurt_light",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_hurt_light",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_hurt_light",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_hurt_light",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_hurt_light",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_hurt_light",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_hurt_light",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_hurt_light",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_hurt_light",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_hurt_light",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_hurt_light",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_hurt_light",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_hurt_light",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_hurt_light",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_hurt_light",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_hurt_light",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_hurt_light",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_hurt_light",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_hurt_light",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_hurt_light",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_hurt_light",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_hurt_light",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_hurt_light",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_hurt_light",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_hurt_light",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_hurt_light",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_hurt_light",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_hurt_light"
		}
	},
	idle_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_idle",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_idle",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_idle",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_idle",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_idle",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_idle",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_idle",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_idle",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_idle",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_idle",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_idle",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_idle",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_idle",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_idle",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_idle",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_idle",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_idle",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_idle",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_idle",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_idle",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_idle",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_idle",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_idle",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_idle",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_idle",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_idle",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_idle",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_idle"
		}
	},
	jump_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_jump",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_jump",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_jump",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_jump",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_jump",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_jump",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_jump",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_jump",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_jump",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_jump",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_jump",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_jump",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_jump",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_jump",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_jump",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_jump",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_jump",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_jump",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_jump",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_jump",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_jump",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_jump",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_jump",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_jump",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_jump",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_jump",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_jump",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_jump"
		}
	},
	land_heavy_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_land_heavy",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_land_heavy",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_land_heavy",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_land_heavy",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_land_heavy",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_land_heavy",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_land_heavy",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_land_heavy",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_land_heavy",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_land_heavy",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_land_heavy",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_land_heavy",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_land_heavy",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_land_heavy",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_land_heavy",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_land_heavy",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_land_heavy",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_land_heavy",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_land_heavy",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_land_heavy",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_land_heavy",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_land_heavy",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_land_heavy",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_land_heavy",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_land_heavy",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_land_heavy",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_land_heavy",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_land_heavy"
		}
	},
	lifting_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_lifting",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_lifting",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_lifting",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_lifting",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_lifting",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_lifting",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_lifting",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_lifting",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_lifting",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_lifting",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_lifting",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_lifting",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_lifting",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_lifting",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_lifting",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_lifting",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_lifting",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_lifting",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_lifting",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_lifting",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_lifting",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_lifting",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_lifting",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_lifting",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_lifting",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_lifting",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_lifting",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_lifting"
		}
	},
	scream_long_vce = {
		has_husk_events = true,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b__vce_scream_long",
			zealot_female_c = "wwise/events/player/play_zealot_female_c__vce_scream_long",
			psyker_male_b = "wwise/events/player/play_psyker_male_b__vce_scream_long",
			ogryn_a = "wwise/events/player/play_ogryn_a__vce_scream_long",
			psyker_female_c = "wwise/events/player/play_psyker_female_c__vce_scream_long",
			ogryn_b = "wwise/events/player/play_ogryn_b__vce_scream_long",
			veteran_male_c = "wwise/events/player/play_veteran_male_c__vce_scream_long",
			veteran_male_a = "wwise/events/player/play_veteran_male_a__vce_scream_long",
			explicator_a = "wwise/events/player/play_veteran_female_c__vce_scream_long",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_scream_long",
			veteran_female_c = "wwise/events/player/play_veteran_female_c__vce_scream_long",
			zealot_female_b = "wwise/events/player/play_zealot_female_b__vce_scream_long",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_scream_long",
			psyker_male_c = "wwise/events/player/play_psyker_male_c__vce_scream_long",
			psyker_female_b = "wwise/events/player/play_psyker_female_b__vce_scream_long",
			zealot_male_a = "wwise/events/player/play_zealot_male_a__vce_scream_long",
			psyker_female_a = "wwise/events/player/play_psyker_female_a__vce_scream_long",
			zealot_male_b = "wwise/events/player/play_zealot_male_b__vce_scream_long",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_scream_long",
			zealot_male_c = "wwise/events/player/play_zealot_male_c__vce_scream_long",
			psyker_male_a = "wwise/events/player/play_psyker_male_a__vce_scream_long",
			zealot_female_a = "wwise/events/player/play_zealot_female_a__vce_scream_long",
			veteran_female_a = "wwise/events/player/play_veteran_female_a__vce_scream_long",
			ogryn_c = "wwise/events/player/play_ogryn_c__vce_scream_long",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_scream_long",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_scream_long",
			veteran_female_b = "wwise/events/player/play_veteran_female_b__vce_scream_long",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_scream_long"
		}
	},
	struggle_heavy_vce = {
		has_husk_events = false,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b_vce_struggle_heavy",
			zealot_female_c = "wwise/events/player/play_zealot_female_c_vce_struggle_heavy",
			psyker_male_b = "wwise/events/player/play_psyker_male_b_vce_struggle_heavy",
			ogryn_a = "wwise/events/player/play_ogryn_a_vce_struggle_heavy",
			psyker_female_c = "wwise/events/player/play_psyker_female_c_vce_struggle_heavy",
			ogryn_b = "wwise/events/player/play_ogryn_b_vce_struggle_heavy",
			veteran_male_c = "wwise/events/player/play_veteran_male_c_vce_struggle_heavy",
			veteran_male_a = "wwise/events/player/play_veteran_male_a_vce_struggle_heavy",
			explicator_a = "wwise/events/player/play_veteran_female_c_vce_struggle_heavy",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_struggle_heavy",
			veteran_female_c = "wwise/events/player/play_veteran_female_c_vce_struggle_heavy",
			zealot_female_b = "wwise/events/player/play_zealot_female_b_vce_struggle_heavy",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_struggle_heavy",
			psyker_male_c = "wwise/events/player/play_psyker_male_c_vce_struggle_heavy",
			psyker_female_b = "wwise/events/player/play_psyker_female_b_vce_struggle_heavy",
			zealot_male_a = "wwise/events/player/play_zealot_male_a_vce_struggle_heavy",
			psyker_female_a = "wwise/events/player/play_psyker_female_a_vce_struggle_heavy",
			zealot_male_b = "wwise/events/player/play_zealot_male_b_vce_struggle_heavy",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_struggle_heavy",
			zealot_male_c = "wwise/events/player/play_zealot_male_c_vce_struggle_heavy",
			psyker_male_a = "wwise/events/player/play_psyker_male_a_vce_struggle_heavy",
			zealot_female_a = "wwise/events/player/play_zealot_female_a_vce_struggle_heavy",
			veteran_female_a = "wwise/events/player/play_veteran_female_a_vce_struggle_heavy",
			ogryn_c = "wwise/events/player/play_ogryn_c_vce_struggle_heavy",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_struggle_heavy",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_struggle_heavy",
			veteran_female_b = "wwise/events/player/play_veteran_female_b_vce_struggle_heavy",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_struggle_heavy"
		}
	},
	struggle_light_vce = {
		has_husk_events = false,
		switch = {
			"selected_voice"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			veteran_male_b = "wwise/events/player/play_veteran_male_b_vce_struggle_heavy",
			zealot_female_c = "wwise/events/player/play_zealot_female_c_vce_struggle_heavy",
			psyker_male_b = "wwise/events/player/play_psyker_male_b_vce_struggle_heavy",
			ogryn_a = "wwise/events/player/play_ogryn_a_vce_struggle_heavy",
			psyker_female_c = "wwise/events/player/play_psyker_female_c_vce_struggle_heavy",
			ogryn_b = "wwise/events/player/play_ogryn_b_vce_struggle_heavy",
			veteran_male_c = "wwise/events/player/play_veteran_male_c_vce_struggle_heavy",
			veteran_male_a = "wwise/events/player/play_veteran_male_a_vce_struggle_heavy",
			explicator_a = "wwise/events/player/play_veteran_female_c_vce_struggle_heavy",
			adamant_male_b = "wwise/events/player/play_adamant_male_b__vce_struggle_heavy",
			veteran_female_c = "wwise/events/player/play_veteran_female_c_vce_struggle_heavy",
			zealot_female_b = "wwise/events/player/play_zealot_female_b_vce_struggle_heavy",
			adamant_female_a = "wwise/events/player/play_adamant_female_a__vce_struggle_heavy",
			psyker_male_c = "wwise/events/player/play_psyker_male_c_vce_struggle_heavy",
			psyker_female_b = "wwise/events/player/play_psyker_female_b_vce_struggle_heavy",
			zealot_male_a = "wwise/events/player/play_zealot_male_a_vce_struggle_heavy",
			psyker_female_a = "wwise/events/player/play_psyker_female_a_vce_struggle_heavy",
			zealot_male_b = "wwise/events/player/play_zealot_male_b_vce_struggle_heavy",
			adamant_female_b = "wwise/events/player/play_adamant_female_b__vce_struggle_heavy",
			zealot_male_c = "wwise/events/player/play_zealot_male_c_vce_struggle_heavy",
			psyker_male_a = "wwise/events/player/play_psyker_male_a_vce_struggle_heavy",
			zealot_female_a = "wwise/events/player/play_zealot_female_a_vce_struggle_heavy",
			veteran_female_a = "wwise/events/player/play_veteran_female_a_vce_struggle_heavy",
			ogryn_c = "wwise/events/player/play_ogryn_c_vce_struggle_heavy",
			adamant_female_c = "wwise/events/player/play_adamant_female_c__vce_struggle_heavy",
			adamant_male_c = "wwise/events/player/play_adamant_male_c__vce_struggle_heavy",
			veteran_female_b = "wwise/events/player/play_veteran_female_b_vce_struggle_heavy",
			adamant_male_a = "wwise/events/player/play_adamant_male_a__vce_struggle_heavy"
		}
	},
	sfx_grab_clip = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_grab_mag",
			bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			bot_zola_laspistol = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_grab_new",
			laspistol_p1_m1 = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			default = "wwise/events/player/play_foley_hands_grab_clip",
			laspistol_p1_m3 = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			bot_laspistol_killshot = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_grab_clip",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_reload_grab_clip"
		}
	},
	sfx_grab_weapon = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_foley_hands_grab_range_weapon",
			combatsword_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			forcesword_2h_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			forcesword_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p3_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			forcesword_p1_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			forcesword_2h_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p3_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			powermaul_2h_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_lever_grab",
			combataxe_p3_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_grab",
			combatknife_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			forcesword_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_pickaxe_2h_foley_grab_soft",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_pickaxe_2h_foley_grab_soft",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_ogryn_hand_on_weapon",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_grab",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_grab",
			powersword_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			powersword_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combataxe_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			thunderhammer_2h_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combataxe_p2_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_2h_sword_foley_grab",
			combataxe_p1_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p2_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_2h_sword_foley_grab",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_2h_sword_foley_grab",
			bot_combatsword_linesman_p1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p2_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			powersword_p1_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_pickaxe_2h_foley_grab_soft",
			bot_combatsword_linesman_p2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatknife_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_ogryn_hand_on_weapon",
			thunderhammer_2h_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p3_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p1_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p1_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combatsword_p2_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			combataxe_p2_m1 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			autopistol_p1_m1 = "wwise/events/weapon/play_autopistol_reload_end",
			combataxe_p1_m2 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_ogryn_hand_on_weapon",
			combataxe_p2_m3 = "wwise/events/player/play_foley_hands_grip_melee_handle",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_ogryn_hand_on_weapon",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_grab"
		}
	},
	sfx_pull_pin = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_grenade_pull_pin",
			krak_grenade = "wwise/events/weapon/play_grenade_pull_pin",
			ogryn_grenade_friend_rock = "wwise/events/weapon/play_weapon_silence",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_spin",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_charge",
			frag_grenade = "wwise/events/weapon/play_grenade_pull_pin",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_spin",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_spin",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_spin",
			fire_grenade = "wwise/events/weapon/play_grenade_pull_pin",
			ogryn_grenade_frag = "wwise/events/weapon/play_grenade_pull_pin"
		}
	},
	sfx_equip = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_ogryn_shovel_equip",
			shock_grenade = "wwise/events/weapon/play_grenade_equip",
			bot_zola_laspistol = "wwise/events/weapon/play_autopistol_equip",
			flamer_p1_m1 = "wwise/events/weapon/play_flametrower_equip_var_1",
			plasmagun_p1_m1 = "wwise/events/weapon/play_weapon_equip_plasma_gun",
			frag_grenade = "wwise/events/weapon/play_grenade_equip",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_equip",
			bot_laspistol_killshot = "wwise/events/weapon/play_autopistol_equip",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_powermaul_2h_equip",
			combatsword_p2_m2 = "wwise/events/weapon/play_sword_light_equip",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p2_equip",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_equip",
			forcestaff_p4_m1 = "wwise/events/weapon/play_force_staff_equip",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_weapon_equip_thunder_hammer",
			forcestaff_p1_m1 = "wwise/events/weapon/play_force_staff_equip",
			combataxe_p1_m1 = "wwise/events/weapon/play_pipe_club_equip",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_equip",
			combatsword_p2_m1 = "wwise/events/weapon/play_sword_light_equip",
			lasgun_p1_m1 = "wwise/events/weapon/play_weapon_lasgun_equip",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p3_equip",
			powersword_p1_m2 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_equip",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/thumper_shotgun_close",
			ogryn_club_p2_m3 = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_equip_var_1",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_2h_sword_foley_equip",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_ogryn_shovel_equip",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_shield_equip",
			combataxe_p3_m1 = "wwise/events/weapon/play_pipe_club_equip",
			fire_grenade = "wwise/events/weapon/play_grenade_equip",
			powersword_p1_m3 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_equip",
			powermaul_p1_m1 = "wwise/events/weapon/play_pipe_club_equip",
			combataxe_p2_m2 = "wwise/events/weapon/play_pipe_club_equip",
			lasgun_p1_m2 = "wwise/events/weapon/play_weapon_lasgun_equip",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_equip",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_ogryn_knife_equip",
			ogryn_club_p1_m1 = "wwise/events/weapon/play_ogryn_shovel_equip",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_2h_equip",
			powermaul_p2_m2 = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_ogryn_pickaxe_2h_equip",
			combatsword_p3_m3 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_sword_light_equip",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_equip",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_pipe_club_equip",
			combatsword_p3_m1 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			default = "wwise/events/weapon/play_autopistol_equip",
			luggable = "wwise/events/player/play_foley_melee_equip_gen_short",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_equip",
			combatsword_p1_m1 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_equip",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_equip",
			area_buff_drone = "wwise/events/player/play_buff_drone_equip",
			autopistol_p1_m1 = "wwise/events/weapon/play_autopistol_equip",
			combatknife_p1_m2 = "wwise/events/weapon/play_combat_knife_equip_var_1",
			powermaul_p2_m1 = "wwise/events/weapon/play_pipe_club_equip",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_equip",
			forcesword_p1_m1 = "wwise/events/weapon/play_sword_light_equip",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_pipe_club_equip",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_equip",
			powersword_p1_m1 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			ogryn_grenade_box_cluster = "wwise/events/weapon/play_ogryn_grenade_crate_equip",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_equip",
			forcesword_p1_m2 = "wwise/events/weapon/play_sword_light_equip",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_ogryn_knife_equip",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_equip",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_equip",
			forcesword_p1_m3 = "wwise/events/weapon/play_sword_light_equip",
			grimoire_pocketable = "wwise/events/player/play_foley_melee_equip_gen_short",
			forcestaff_p3_m1 = "wwise/events/weapon/play_force_staff_equip",
			shotgun_p1_m1 = "wwise/events/weapon/play_shotgun_equip",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_shield_equip",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_weapon_equip_thunder_hammer",
			combatsword_p1_m3 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_ogryn_powermaul_1h_equip",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_ogryn_knife_equip",
			ogryn_grenade_box = "wwise/events/weapon/play_ogryn_grenade_crate_equip",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_equip",
			combatsword_p1_m2 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_equip",
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_gunslinger_equip",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_equip",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p3_equip",
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_equip",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_ogryn_pickaxe_2h_equip",
			bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_equip",
			zealot_throwing_knives = "wwise/events/weapon/play_weapon_silence",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p3_equip",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_equip",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_equip",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_equip",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p2_equip",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_equip",
			combataxe_p1_m3 = "wwise/events/weapon/play_pipe_club_equip",
			combatsword_p2_m3 = "wwise/events/weapon/play_sword_light_equip",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p2_equip",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_ogryn_pickaxe_2h_equip",
			combatknife_p1_m1 = "wwise/events/weapon/play_combat_knife_equip_var_1",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			tome_pocketable = "wwise/events/player/play_foley_melee_equip_gen_short",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_equip",
			laspistol_p1_m1 = "wwise/events/weapon/play_autopistol_equip",
			combataxe_p2_m1 = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			combataxe_p2_m3 = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_equip",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_2h_equip",
			combatsword_p3_m2 = "wwise/events/weapon/play_weapon_equip_medium_sword",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/thumper_shotgun_close",
			forcestaff_p2_m1 = "wwise/events/weapon/play_force_staff_equip",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_2h_sword_foley_equip",
			combataxe_p3_m2 = "wwise/events/weapon/play_pipe_club_equip",
			combataxe_p3_m3 = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_grenade_friend_rock = "wwise/events/weapon/play_ogryn_grenade_rock_equip",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_pipe_club_equip",
			krak_grenade = "wwise/events/weapon/play_grenade_equip",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_2h_sword_foley_equip",
			laspistol_p1_m3 = "wwise/events/weapon/play_autopistol_equip",
			bot_combataxe_linesman = "wwise/events/weapon/play_pipe_club_equip",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_equip",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_equip",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_equip",
			auspex_scanner = "wwise/events/player/play_scanner_equip",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_equip",
			powermaul_p1_m2 = "wwise/events/weapon/play_pipe_club_equip",
			lasgun_p1_m3 = "wwise/events/weapon/play_weapon_lasgun_equip",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_equip",
			ammo_cache_pocketable = "wwise/events/player/play_foley_melee_equip_gen_short",
			combataxe_p1_m2 = "wwise/events/weapon/play_pipe_club_equip",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_equip"
		}
	},
	sfx_weapon_foley_01_right_hand = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_ogryn_shovel_fold_up",
			powermaul_p2_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_special",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_01",
			combataxe_p3_m2 = "wwise/events/weapon/play_shovel_fold_down",
			powermaul_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_special_attack",
			combataxe_p3_m3 = "wwise/events/weapon/play_shovel_fold_down",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_special",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_01",
			powermaul_p2_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_special",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_special",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_ogryn_shovel_fold_up",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_01",
			powermaul_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_special_attack"
		}
	},
	sfx_weapon_foley_02_right_hand = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_ogryn_shovel_fold_down",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_02",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_02",
			combataxe_p3_m2 = "wwise/events/weapon/play_shovel_fold_up",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_pickaxe_2h_foley_start_run_02",
			combataxe_p3_m3 = "wwise/events/weapon/play_shovel_fold_up",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_maul_special_attack",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_maul_special_attack",
			powermaul_p2_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_foley_idle_swing",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_ogryn_shovel_fold_down",
			powermaul_p2_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_foley_idle_swing"
		}
	},
	sfx_int_gen_finish = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_confirm",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_confirm",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_heal_husk_confirm",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_confirm",
			grimoire_pocketable = "wwise/events/player/play_grimoire_unequip_finish"
		}
	},
	sfx_equip_stop = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {}
	},
	sfx_equip_02 = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_equip_grab",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_activate_one",
			flamer_p1_m1 = "wwise/events/weapon/play_flametrower_equip_var_2",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_physical_swing",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p2_equip_lever",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_equip_grab",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_weapon_thunder_hammer_spin",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p2_equip_lever",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_equip_hit",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_2h_sword_foley_change_grip_start",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_p1_equip_start",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_equip_grab",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_equip_var_2",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_2h_sword_foley_change_grip_start",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p2_equip_lever",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_slabshield_equip",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_physical_swing",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_2h_sword_foley_change_grip_start",
			combatknife_p1_m1 = "wwise/events/weapon/play_combat_knife_equip_var_2",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_weapon_thunder_hammer_spin",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_p1_equip_start",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_equip_hit_lever",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_activate_one",
			combatknife_p1_m2 = "wwise/events/weapon/play_combat_knife_equip_var_2",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_p1_equip_start",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_equip_hit_lever"
		}
	},
	sfx_equip_03 = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_equip_lift",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_grab",
			combatknife_p1_m2 = "wwise/events/weapon/play_combat_knife_equip_var_3",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_grab",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_activate_two",
			combatknife_p1_m1 = "wwise/events/weapon/play_combat_knife_equip_var_3",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_activate_two",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_grab"
		}
	},
	sfx_equip_04 = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			psyker_chain_lightning = "wwise/events/weapon/play_psyker_chain_lightning_grenade_push",
			combatknife_p1_m2 = "wwise/events/weapon/play_combat_knife_equip_var_4",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_activate_three",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_activate_three",
			combatknife_p1_m1 = "wwise/events/weapon/play_combat_knife_equip_var_4"
		}
	},
	weapon_charge_level_1 = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_charge_1",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_charge_1"
		}
	},
	weapon_charge_level_2 = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_charge_2",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_charge_2"
		}
	},
	weapon_charge_level_3 = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_2h_forcesword_ability_charge_3",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_2h_forcesword_ability_charge_3"
		}
	},
	sfx_foley_equip = {
		has_husk_events = true,
		switch = {
			"sfx_body_material"
		},
		events = {
			default = "wwise/events/player/play_foley_melee_equip_gen_short"
		}
	},
	sfx_ads_up = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			stubrevolver_p1_m2 = "wwise/events/weapon/play_revolver_ads_up",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_revolver_ads_up",
			bot_zola_laspistol = "wwise/events/weapon/play_rifle_ads_up",
			bot_lasgun_killshot = "wwise/events/weapon/play_rifle_ads_up",
			shotgun_p4_m3 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			ogryn_grenade_friend_rock = "wwise/events/weapon/play_ogryn_grenade_rock_aim",
			shotgun_p1_m3 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_ads_up",
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_ads_up",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_ogryn_wpn_up",
			default = "wwise/events/weapon/play_rifle_ads_up",
			flamer_p1_m1 = "wwise/events/weapon/play_flametrower_alt_fire_on",
			shotgun_p1_m2 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_rifle_ads_up",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_throwing_knife_charge",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			bot_laspistol_killshot = "wwise/events/weapon/play_rifle_ads_up",
			lasgun_p1_m2 = "wwise/events/weapon/play_rifle_ads_up",
			shotgun_p4_m2 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_up",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_up",
			laspistol_p1_m3 = "wwise/events/weapon/play_rifle_ads_up",
			shotgun_p1_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			shotgun_p4_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			lasgun_p1_m3 = "wwise/events/weapon/play_rifle_ads_up",
			laspistol_p1_m1 = "wwise/events/weapon/play_rifle_ads_up",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			lasgun_p1_m1 = "wwise/events/weapon/play_rifle_ads_up",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			shotgun_p2_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun"
		}
	},
	sfx_ads_down = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			stubrevolver_p1_m2 = "wwise/events/weapon/play_revolver_ads_down",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_revolver_ads_down",
			bot_zola_laspistol = "wwise/events/weapon/play_rifle_ads_down",
			bot_lasgun_killshot = "wwise/events/weapon/play_rifle_ads_down",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_ads_down",
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_ads_down",
			shotgun_p1_m3 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			shotgun_p4_m3 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			bot_laspistol_killshot = "wwise/events/weapon/play_rifle_ads_down",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_ogryn_wpn_down",
			flamer_p1_m1 = "wwise/events/weapon/play_rifle_heavy_subtle",
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_throwing_knife_foley_subtle",
			shotgun_p1_m2 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_rifle_ads_down",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			default = "wwise/events/weapon/play_rifle_ads_down",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			lasgun_p1_m2 = "wwise/events/weapon/play_rifle_ads_down",
			shotgun_p4_m2 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_down",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_down",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_weapon_large_metal_shield_slam",
			laspistol_p1_m3 = "wwise/events/weapon/play_rifle_ads_down",
			shotgun_p1_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			shotgun_p4_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun",
			lasgun_p1_m3 = "wwise/events/weapon/play_rifle_ads_down",
			laspistol_p1_m1 = "wwise/events/weapon/play_rifle_ads_down",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			lasgun_p1_m1 = "wwise/events/weapon/play_rifle_ads_down",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			shotgun_p2_m1 = "wwise/events/weapon/play_weapon_ads_foley_autogun"
		}
	},
	sfx_weapon_down = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_ads_down",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			bot_zola_laspistol = "wwise/events/weapon/play_rifle_subtle",
			bot_lasgun_killshot = "wwise/events/weapon/play_rifle_subtle",
			shotgun_p4_m3 = "wwise/events/weapon/play_rifle_subtle",
			luggable = "wwise/events/player/play_item_luggable_throw",
			shotgun_p1_m3 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_placed",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_hand_to_barrel",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_rifle_heavy_subtle",
			shotgun_p1_m2 = "wwise/events/weapon/play_rifle_subtle",
			default = "wwise/events/weapon/play_rifle_subtle",
			bot_laspistol_killshot = "wwise/events/weapon/play_rifle_subtle",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_rifle_subtle",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			ogryn_grenade_box_cluster = "wwise/events/weapon/play_ogryn_grenade_crate_charge",
			bolter_p1_m1 = "wwise/events/weapon/play_rifle_heavy_subtle",
			lasgun_p1_m2 = "wwise/events/weapon/play_rifle_subtle",
			shotgun_p4_m2 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_rifle_heavy_subtle",
			laspistol_p1_m3 = "wwise/events/weapon/play_rifle_subtle",
			shotgun_p1_m1 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_placed",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_placed",
			shotgun_p4_m1 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_grenade_box = "wwise/events/weapon/play_ogryn_grenade_crate_charge",
			laspistol_p1_m1 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			lasgun_p1_m1 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_down",
			shotgun_p2_m1 = "wwise/events/weapon/play_rifle_subtle"
		}
	},
	sfx_weapon_up = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_rifle_wpn_up",
			autogun_p2_m2 = "wwise/events/weapon/play_rifle_subtle",
			bot_zola_laspistol = "wwise/events/weapon/play_rifle_wpn_up",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_lift",
			chainaxe_p1_m2 = "wwise/events/weapon/play_chainaxe_special_start",
			lasgun_p1_m2 = "wwise/events/weapon/play_rifle_wpn_up",
			shotgun_p1_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			bot_lasgun_killshot = "wwise/events/weapon/play_rifle_wpn_up",
			autogun_p2_m1 = "wwise/events/weapon/play_rifle_subtle",
			autogun_p3_m2 = "wwise/events/weapon/play_rifle_subtle",
			chainsword_p1_m1 = "wwise/events/weapon/play_combat_weapon_chainsword_special_start",
			lasgun_p3_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			bot_laspistol_killshot = "wwise/events/weapon/play_rifle_wpn_up",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_rifle_wpn_up",
			chainaxe_p1_m1 = "wwise/events/weapon/play_chainaxe_special_start",
			lasgun_p2_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_reload_lift",
			lasgun_p3_m2 = "wwise/events/weapon/play_rifle_wpn_up",
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_ads_up",
			autogun_p3_m1 = "wwise/events/weapon/play_rifle_subtle",
			shotgun_p1_m2 = "wwise/events/weapon/play_rifle_wpn_up",
			lasgun_p2_m2 = "wwise/events/weapon/play_rifle_wpn_up",
			shotgun_p4_m2 = "wwise/events/weapon/play_rifle_wpn_up",
			lasgun_p3_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			shotgun_p4_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			chainsword_p1_m2 = "wwise/events/weapon/play_combat_weapon_chainsword_special_start",
			shotgun_p4_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			lasgun_p2_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_lift",
			laspistol_p1_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_lift",
			shotgun_p1_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_lift",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_lift",
			autogun_p1_m1 = "wwise/events/weapon/play_rifle_subtle",
			lasgun_p1_m3 = "wwise/events/weapon/play_rifle_wpn_up",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_2h_chainsword_special_start",
			autogun_p1_m2 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_lift",
			laspistol_p1_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_2h_chainsword_special_start",
			autogun_p2_m3 = "wwise/events/weapon/play_rifle_subtle",
			autogun_p1_m3 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			lasgun_p1_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_wpn_up",
			shotgun_p2_m1 = "wwise/events/weapon/play_rifle_wpn_up",
			autogun_p3_m3 = "wwise/events/weapon/play_rifle_subtle"
		}
	},
	sfx_weapon_locomotion = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			plasmagun_p1_m1 = "wwise/events/weapon/play_weapon_plasma_gun_movement_foley",
			autogun_p2_m2 = "wwise/events/weapon/play_rifle_locomotion",
			bot_zola_laspistol = "wwise/events/weapon/play_rifle_locomotion",
			flamer_p1_m1 = "wwise/events/weapon/play_liquid_locomotion",
			autopistol_p3_m2 = "wwise/events/weapon/play_smg_locomotion",
			luggable = "wwise/events/weapon/play_item_luggable_foley",
			shotgun_p1_m3 = "wwise/events/weapon/play_heavy_locomotion",
			lasgun_p2_m2 = "wwise/events/weapon/play_rifle_locomotion",
			shotgun_p1_m2 = "wwise/events/weapon/play_heavy_locomotion",
			autogun_p3_m2 = "wwise/events/weapon/play_rifle_locomotion",
			bot_lasgun_killshot = "wwise/events/weapon/play_rifle_locomotion",
			autogun_p2_m1 = "wwise/events/weapon/play_rifle_locomotion",
			bot_laspistol_killshot = "wwise/events/weapon/play_rifle_locomotion",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_rifle_locomotion",
			autopistol_p3_m3 = "wwise/events/weapon/play_smg_locomotion",
			lasgun_p2_m3 = "wwise/events/weapon/play_rifle_locomotion",
			bolter_p1_m1 = "wwise/events/weapon/play_heavy_locomotion",
			shotgun_p4_m1 = "wwise/events/weapon/play_heavy_locomotion",
			shotgun_p4_m3 = "wwise/events/weapon/play_heavy_locomotion",
			autogun_p3_m1 = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_ammo_belt_locomotion",
			lasgun_p1_m2 = "wwise/events/weapon/play_rifle_locomotion",
			shotgun_p4_m2 = "wwise/events/weapon/play_heavy_locomotion",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_heavy_locomotion",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_heavy_locomotion",
			autopistol_p3_m1 = "wwise/events/weapon/play_smg_locomotion",
			lasgun_p2_m1 = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_heavy_locomotion",
			laspistol_p1_m3 = "wwise/events/weapon/play_rifle_locomotion",
			shotgun_p1_m1 = "wwise/events/weapon/play_heavy_locomotion",
			high_bot_autogun_killshot = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_heavy_locomotion",
			bot_autogun_killshot = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_heavy_locomotion",
			autogun_p1_m1 = "wwise/events/weapon/play_rifle_locomotion",
			lasgun_p1_m3 = "wwise/events/weapon/play_rifle_locomotion",
			autogun_p1_m2 = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_heavy_locomotion",
			laspistol_p1_m1 = "wwise/events/weapon/play_rifle_locomotion",
			autopistol_p1_m1 = "wwise/events/weapon/play_smg_locomotion",
			autogun_p2_m3 = "wwise/events/weapon/play_rifle_locomotion",
			autogun_p1_m3 = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_ammo_belt_locomotion",
			lasgun_p1_m1 = "wwise/events/weapon/play_rifle_locomotion",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_ammo_belt_locomotion",
			shotgun_p2_m1 = "wwise/events/weapon/play_heavy_locomotion",
			autogun_p3_m3 = "wwise/events/weapon/play_rifle_locomotion"
		}
	},
	sfx_inspect = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_player_foley_subtle",
			autogun_p2_m2 = "wwise/events/weapon/play_rifle_subtle",
			autogun_p3_m1 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_grenade_box_cluster = "wwise/events/weapon/play_ogryn_grenade_crate_shake",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_up",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_ogryn_wpn_up",
			autogun_p3_m2 = "wwise/events/weapon/play_rifle_subtle",
			forcestaff_p2_m1 = "wwise/events/player/play_player_foley_subtle",
			autogun_p2_m1 = "wwise/events/weapon/play_rifle_subtle",
			autogun_p1_m1 = "wwise/events/weapon/play_rifle_subtle",
			forcestaff_p4_m1 = "wwise/events/player/play_player_foley_subtle",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_ammo_belt_locomotion",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_ammo_belt_locomotion",
			autogun_p1_m2 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_grenade_box = "wwise/events/weapon/play_ogryn_grenade_crate_shake",
			autogun_p2_m3 = "wwise/events/weapon/play_rifle_subtle",
			autogun_p1_m3 = "wwise/events/weapon/play_rifle_subtle",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_wpn_up",
			forcestaff_p1_m1 = "wwise/events/player/play_player_foley_subtle",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_ammo_belt_locomotion",
			forcestaff_p3_m1 = "wwise/events/player/play_player_foley_subtle",
			autogun_p3_m3 = "wwise/events/weapon/play_rifle_subtle"
		}
	},
	sfx_inspect_special_01 = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_rippergun_inspect_up",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_shake_ogryn",
			ogryn_grenade_box = "wwise/events/weapon/play_ogryn_grenade_crate_open",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_rippergun_inspect_up",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_rippergun_inspect_up",
			ogryn_grenade_box_cluster = "wwise/events/weapon/play_ogryn_grenade_crate_open",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_shake_ogryn",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_shake_ogryn",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_shake_ogryn"
		}
	},
	sfx_inspect_special_02 = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_rippergun_inspect_down",
			ogryn_grenade_box_cluster = "wwise/events/weapon/play_ogryn_grenade_crate_close",
			ogryn_grenade_box = "wwise/events/weapon/play_ogryn_grenade_crate_close",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_rippergun_inspect_down",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_rippergun_inspect_down"
		}
	},
	sfx_weapon_foley_heavy = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_foley_plasma_rifle_heavy_movement",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_thumper_locomotion_metal_plate",
			plasmagun_p1_m1 = "wwise/events/weapon/play_foley_plasma_rifle_heavy_movement",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_push",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_hand",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_weapon_silence"
		}
	},
	sfx_weapon_foley_left_hand_01 = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_to_parry",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_slabshield_to_parry",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_to_parry",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_to_parry"
		}
	},
	sfx_weapon_foley_left_hand_02 = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_from_parry",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_slabshield_from_parry",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_to_parry",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_from_parry"
		}
	},
	sfx_hit_weapon = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_hit",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_hit",
			plasmagun_p1_m1 = "wwise/events/player/play_foley_hand_hit_weapon_plasma_rifle",
			flamer_p1_m1 = "wwise/events/weapon/play_flametrower_alt_fire_off",
			default = "wwise/events/player/play_foley_hand_hit_weapon_plasma_rifle",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_hand_hit",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_hand_hit",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_hand_hit",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_special_hit",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_hit"
		}
	},
	sfx_vent_rattle = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_plasmagun_vent_rattle",
			shock_grenade = "wwise/events/weapon/play_grenade_foley_pin_spin",
			plasmagun_p1_m1 = "wwise/events/weapon/play_weapon_plasmagun_vent_rattle",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_dodge",
			smoke_grenade = "wwise/events/weapon/play_grenade_foley_pin_spin",
			krak_grenade = "wwise/events/weapon/play_grenade_foley_pin_spin",
			fire_grenade = "wwise/events/weapon/play_grenade_foley_pin_spin",
			frag_grenade = "wwise/events/weapon/play_grenade_foley_pin_spin"
		}
	},
	sfx_about_to_explode = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_plasmagun_about_to_explode",
			plasmagun_p1_m1 = "wwise/events/weapon/play_weapon_plasmagun_about_to_explode"
		}
	},
	sfx_magazine_eject = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_mag_out",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			bot_zola_laspistol = "wwise/events/weapon/play_reload_foley_laspistol_clip_out",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_mag_out",
			bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_out",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p2_reload_mag_out",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			default = "wwise/events/weapon/play_weapon_silence",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_reload_eject",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_reload_eject",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_mag_out",
			bot_laspistol_killshot = "wwise/events/weapon/play_reload_foley_laspistol_clip_out",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_out",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p2_reload_mag_out",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_clip_out",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_mag_out",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_cocking",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_reload_clip_out",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_reload_eject",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_mag_out",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_cocking",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_mag_out",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p2_reload_mag_out",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_slabshield_push_foley",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/thumper_shotgun_open",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/thumper_shotgun_open",
			laspistol_p1_m3 = "wwise/events/weapon/play_reload_foley_laspistol_clip_out",
			plasmagun_p1_m1 = "wwise/events/weapon/play_weapon_plasma_vent",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_eject",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_eject",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_to_braced",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_reload_clip_out",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_reload_clip_out",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_reload_clip_out",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_eject",
			laspistol_p1_m1 = "wwise/events/weapon/play_reload_foley_laspistol_clip_out",
			autopistol_p1_m1 = "wwise/events/weapon/play_autopistol_mag_out",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_reload_clip_out",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_reload_clip_out",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_reload_clip_out",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_mag_out",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_reload_eject",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p2_reload_clip_out"
		}
	},
	sfx_magazine_insert = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_mag_in",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			bot_zola_laspistol = "wwise/events/weapon/play_reload_foley_laspistol_clip_in",
			bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_in",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p2_reload_mag_in",
			default = "wwise/events/weapon/play_weapon_silence",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_uncocking",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_mag_in",
			bot_laspistol_killshot = "wwise/events/weapon/play_reload_foley_laspistol_clip_in",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_in",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p2_reload_mag_in",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_clip_in",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_mag_in",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/thumper_shotgun_insert",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_reload_clip_in",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_uncocking",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_mag_in",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/thumper_shotgun_insert",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_mag_in",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p2_reload_mag_in",
			laspistol_p1_m3 = "wwise/events/weapon/play_reload_foley_laspistol_clip_in",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_insert",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_insert",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_insert",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_from_braced",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_reload_clip_in",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_reload_clip_in",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_reload_clip_in",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_insert",
			laspistol_p1_m1 = "wwise/events/weapon/play_reload_foley_laspistol_clip_in",
			autopistol_p1_m1 = "wwise/events/weapon/play_autopistol_mag_in",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_reload_clip_in",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_reload_clip_in",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_reload_clip_in",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_mag_in",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_reload_insert_ammo",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p2_reload_clip_in"
		}
	},
	sfx_reload_lever_pull = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_boltpistol_reload_lever_pull",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_reload_lever_pull",
			shotgun_p1_m1 = "wwise/events/weapon/play_shotgun_reload_pull",
			default = "wwise/events/weapon/play_weapon_silence",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_reload_lever_pull",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_reload_pull",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_reload_lever_pull",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_reload_pull",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_reload_pull",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p3_reload_lever_pull",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_reload_pull",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_reload_lever_pull",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_reload_lever_pull",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_reload_pull",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_lever_pull",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p2_reload_lever_pull",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_lever_pull",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_lever_pull",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_reload_lever_pull",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p3_reload_lever_pull",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_lever_pull",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p2_reload_lever_pull",
			autopistol_p1_m1 = "wwise/events/weapon/play_autopistol_lever",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_reload_lever_pull",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_reload_lever_pull",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_lever_pull",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p2_reload_lever_pull",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_reload_eject_single",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p3_reload_lever_pull"
		}
	},
	sfx_reload_lever_release = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_reload_lever_release",
			bot_zola_laspistol = "wwise/events/weapon/play_reload_foley_laspistol_recharge_on",
			bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_lever_release",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_reload_lever_release",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_reload_push",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_reload_push",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_lever_release",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_reload_release",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p3_reload_lever_release",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_reload_lever_release",
			bot_laspistol_killshot = "wwise/events/weapon/play_reload_foley_laspistol_recharge_on",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_lever_release",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/thumper_shotgun_close",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p3_reload_lever_release",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_reload_lever_release",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_reload_release",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/thumper_shotgun_close",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_reload_finish",
			laspistol_p1_m3 = "wwise/events/weapon/play_reload_foley_laspistol_recharge_on",
			shotgun_p1_m1 = "wwise/events/weapon/play_shotgun_reload_push",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_reload_lever_release",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_reload_lever_release",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_reload_release",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_reload_lever_release",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_reload_lever_release",
			laspistol_p1_m1 = "wwise/events/weapon/play_reload_foley_laspistol_recharge_on",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_reload_lever_release",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_reload_lever_release",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_reload_lever_release",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_lever_release",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_reload_close_barrels",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p3_reload_lever_release"
		}
	},
	sfx_magazine_fail = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_unarm",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_connect",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_pull",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_pull",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_reload_foley_rippergun_magazine_pull"
		}
	},
	sfx_mag_contact = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_contact",
			lasgun_p2_m2 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_screw",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_clip_contact",
			frag_grenade = "wwise/events/weapon/play_combat_knife_equip_var_4",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_speedloader_insert",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_lasgun_reload_clip_contact",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_mag_safety_button",
			lasgun_p2_m3 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_mag_safety_button",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			lasgun_p1_m2 = "wwise/events/weapon/play_lasgun_reload_clip_contact",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_mag_contact",
			lasgun_p2_m1 = "wwise/events/weapon/play_lasgun_p3_mag_contact",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_connect",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_rippergun_mag_contact",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_rippergun_mag_contact",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_speed_loader_insert",
			lasgun_p1_m3 = "wwise/events/weapon/play_lasgun_reload_clip_contact",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_rippergun_mag_contact",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_mag_safety_button",
			lasgun_p1_m1 = "wwise/events/weapon/play_lasgun_reload_clip_contact",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_mag_safety_button",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p2_reload_mag_contact"
		}
	},
	sfx_button = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo_special",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_mag_button",
			shotgun_p1_m1 = "wwise/events/weapon/play_shotgun_reload_insert_ammo_special",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo_special",
			bolter_p1_m1 = "wwise/events/weapon/play_bolter_reload_clip_button",
			default = "wwise/events/weapon/play_weapon_silence",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_reload_insert_ammo_special_03",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_mag_button",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo_special",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_mag_button",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_reload_insert_ammo_special_02"
		}
	},
	plasma_flask_remove = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_remove"
		}
	},
	plasma_flask_connect = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_connect"
		}
	},
	plasma_button = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_button"
		}
	},
	plasma_flask_screw = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_screw"
		}
	},
	plasma_flask_disconnect = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_disconnect"
		}
	},
	plasma_flask_insert = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/play_reload_foley_plasma_flask_insert"
		}
	},
	sfx_weapon_handle_out = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			default = "wwise/events/weapon/play_weapon_silence",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_eject_one",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_eject_one",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_heal_husk",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_heal_husk",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_heal_husk",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_out",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_heal_husk"
		}
	},
	sfx_weapon_handle_in = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			default = "wwise/events/weapon/play_weapon_silence",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_heal_self",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_stab_self",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_stab_self",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_weapon_rippergun_handle_in",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_stab_self",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_weapon_rippergun_handle_in"
		}
	},
	sfx_weapon_revolver_open = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_open",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_open",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_heal_husk_charge",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge",
			default = "wwise/events/weapon/play_weapon_silence",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_open",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge"
		}
	},
	sfx_weapon_revolver_close = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_close",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_cock",
			syringe_corruption_pocketable = "wwise/events/player/play_syringe_heal_husk_charge_cancel",
			syringe_ability_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge_cancel",
			default = "wwise/events/weapon/play_weapon_silence",
			syringe_power_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge_cancel",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_cock",
			syringe_speed_boost_pocketable = "wwise/events/player/play_syringe_heal_husk_charge_cancel"
		}
	},
	sfx_weapon_eject_ammo = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_eject_ammo",
			default = "wwise/events/weapon/play_weapon_silence",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_eject",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_reload_insert_ammo_single",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_eject"
		}
	},
	sfx_weapon_insert_ammo = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			shotgun_p1_m3 = "wwise/events/weapon/play_weapon_shotgun_human_reload_insert_ammo",
			shotgun_p1_m1 = "wwise/events/weapon/play_weapon_shotgun_human_reload_insert_ammo",
			shotgun_p1_m2 = "wwise/events/weapon/play_weapon_shotgun_human_reload_insert_ammo",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_insert_bullet",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_insert_bullet",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_reload_insert_ammo",
			shotgun_p2_m1 = "wwise/events/weapon/play_weapon_shotgun_human_reload_insert_ammo"
		}
	},
	sfx_weapon_twist = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_cylinder_twist",
			default = "wwise/events/weapon/play_weapon_silence",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_arm",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_screw",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver_cylinder_twist"
		}
	},
	sfx_weapon_untwist = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_reload_unscrew"
		}
	},
	flyby = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_shared_combat_weapon_bullet_flyby_small"
		}
	},
	sfx_swing = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_pipe_swing",
			combatknife_p1_m2 = "wwise/events/weapon/play_swing_knife",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			combatsword_p2_m1 = "wwise/events/weapon/play_sword_swing_medium",
			luggable = "wwise/events/player/play_swing_light_gen",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_power_sword_2h_swing",
			powermaul_p1_m2 = "wwise/events/weapon/play_powermaul_1h_swing",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_thunder_hammer_swing",
			chainaxe_p1_m2 = "wwise/events/weapon/play_chainaxe_swing_no_rev",
			chainsword_p1_m1 = "wwise/events/weapon/play_combat_weapon_chainsword_swing",
			combataxe_p1_m1 = "wwise/events/weapon/play_axe_swing_light",
			combatsword_p3_m2 = "wwise/events/weapon/play_sword_swing_falchion",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_thunder_hammer_swing",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_swing",
			combataxe_p2_m2 = "wwise/events/weapon/play_axe_swing_light",
			default = "wwise/events/player/play_swing_light_gen",
			combataxe_p3_m1 = "wwise/events/weapon/play_axe_swing_light",
			grimoire_pocketable = "wwise/events/player/play_swing_light_gen",
			combataxe_p1_m3 = "wwise/events/weapon/play_axe_swing_light",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_sword_swing_medium",
			powersword_p1_m2 = "wwise/events/weapon/play_power_sword_swing",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_swing",
			ogryn_club_p2_m3 = "wwise/events/weapon/play_pipe_swing",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_swing",
			combatsword_p2_m3 = "wwise/events/weapon/play_sword_swing_medium",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_sword_swing_medium",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			powersword_p1_m3 = "wwise/events/weapon/play_power_sword_swing",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			powermaul_p1_m1 = "wwise/events/weapon/play_powermaul_1h_swing",
			combatknife_p1_m1 = "wwise/events/weapon/play_swing_knife",
			ogryn_club_p1_m1 = "wwise/events/weapon/play_pipe_swing",
			powermaul_p2_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing",
			combatsword_p3_m3 = "wwise/events/weapon/play_sword_swing_falchion",
			tome_pocketable = "wwise/events/player/play_swing_light_gen",
			combatsword_p3_m1 = "wwise/events/weapon/play_sword_swing_falchion",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_2h_chainsword_swing",
			combatsword_p1_m1 = "wwise/events/weapon/play_sword_swing_medium",
			combatsword_p2_m2 = "wwise/events/weapon/play_sword_swing_medium",
			combataxe_p2_m1 = "wwise/events/weapon/play_axe_swing_light",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_2h_chainsword_swing",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_2h_swing",
			combataxe_p2_m3 = "wwise/events/weapon/play_axe_swing_light",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_pipe_swing",
			powermaul_p2_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_2h_swing",
			chainsword_p1_m2 = "wwise/events/weapon/play_combat_weapon_chainsword_swing",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_pipe_swing",
			powersword_p1_m1 = "wwise/events/weapon/play_power_sword_swing",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_ogryn_gauntlet_swing",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_swing",
			chainaxe_p1_m1 = "wwise/events/weapon/play_chainaxe_swing",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_throw_light",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_power_sword_2h_swing",
			combataxe_p3_m2 = "wwise/events/weapon/play_axe_swing_light",
			combataxe_p3_m3 = "wwise/events/weapon/play_axe_swing_light",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_swing",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_power_maul_swing",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_pipe_swing",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_power_sword_2h_swing",
			bot_combataxe_linesman = "wwise/events/weapon/play_axe_swing_light",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_thunder_hammer_swing",
			combatsword_p1_m3 = "wwise/events/weapon/play_sword_swing_medium",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_power_maul_swing",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			combataxe_p1_m2 = "wwise/events/weapon/play_axe_swing_light",
			combatsword_p1_m2 = "wwise/events/weapon/play_sword_swing_medium"
		}
	},
	sfx_swing_heavy = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_swing_heavy_gen",
			combatsword_p3_m1 = "wwise/events/weapon/play_sword_swing_falchion",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_2h_swing_heavy",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_swing",
			combatsword_p3_m2 = "wwise/events/weapon/play_sword_swing_falchion",
			combatsword_p1_m3 = "wwise/events/weapon/play_sword_swing_medium",
			combatknife_p1_m1 = "wwise/events/weapon/play_swing_knife",
			chainaxe_p1_m2 = "wwise/events/weapon/play_chainaxe_swing",
			powersword_p1_m1 = "wwise/events/weapon/play_power_sword_swing",
			chainsword_p1_m2 = "wwise/events/weapon/play_combat_weapon_chainsword_swing_heavy",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_2h_swing_heavy",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_thunder_hammer_swing",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_2h_sword_swing_heavy",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_swing",
			chainaxe_p1_m1 = "wwise/events/weapon/play_chainaxe_swing",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_throw_heavy",
			chainsword_p1_m1 = "wwise/events/weapon/play_combat_weapon_chainsword_swing_heavy",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_thunder_hammer_swing",
			ogryn_club_p1_m2 = "wwise/events/weapon/play_pipe_swing",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_pipe_swing",
			powersword_p1_m2 = "wwise/events/weapon/play_power_sword_swing",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_heavy",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_swing",
			ogryn_club_p2_m3 = "wwise/events/weapon/play_pipe_swing",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_swing",
			combatsword_p2_m3 = "wwise/events/weapon/play_sword_swing_medium",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_pipe_swing",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_power_maul_swing",
			combatsword_p2_m1 = "wwise/events/weapon/play_sword_swing_medium",
			powersword_p1_m3 = "wwise/events/weapon/play_power_sword_swing",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			bot_combataxe_linesman = "wwise/events/weapon/play_axe_swing_light",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_pipe_swing",
			powermaul_p1_m1 = "wwise/events/weapon/play_powermaul_1h_swing",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_heavy",
			ogryn_club_p1_m1 = "wwise/events/weapon/play_pipe_swing",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_thunder_hammer_swing",
			powermaul_p2_m2 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_heavy",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_power_maul_swing",
			combatsword_p3_m3 = "wwise/events/weapon/play_sword_swing_falchion",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_2h_sword_swing_heavy",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_ogryn_pickaxe_2h_swing",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_sword_swing_medium",
			powermaul_p1_m2 = "wwise/events/weapon/play_powermaul_1h_swing",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_sword_swing_medium",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_2h_chainsword_swing",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_combat_weapon_combat_knife_ogryn_swing",
			combatsword_p1_m1 = "wwise/events/weapon/play_sword_swing_medium",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_2h_sword_swing_heavy",
			combatsword_p2_m2 = "wwise/events/weapon/play_sword_swing_medium",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_2h_chainsword_swing",
			combatsword_p1_m2 = "wwise/events/weapon/play_sword_swing_medium",
			combatknife_p1_m2 = "wwise/events/weapon/play_swing_knife",
			powermaul_p2_m1 = "wwise/events/weapon/play_shockmaul_1h_p2_swing_heavy"
		}
	},
	sfx_swing_heavy_left_hand = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_swing_light_gen",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_swing",
			grimoire_pocketable = "wwise/events/player/play_ogryn_swing_light_gen",
			tome_pocketable = "wwise/events/player/play_ogryn_swing_light_gen",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_slabshield_swing",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_swing"
		}
	},
	sfx_swing_special = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_swing_light_gen",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_swing",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_pickaxe_2h_swing_special_hook",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_pickaxe_2h_swing_special_hook",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_pickaxe_2h_swing_special_hook"
		}
	},
	windup_start = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/player/play_melee_charge_grip_hands",
				powersword_2h_p1_m2 = "wwise/events/player/play_ogryn_foley_weapon_charge",
				forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_2h_charge",
				forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_charge_foley",
				grimoire_pocketable = "wwise/events/player/play_grimoire_unequip",
				shock_mine = "wwise/events/weapon/play_adamant_shockmine_foley_charge",
				forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_charge_foley",
				forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_2h_charge",
				powersword_2h_p1_m1 = "wwise/events/player/play_ogryn_foley_weapon_charge",
				forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_charge_foley",
				powersword_2h_p1_m3 = "wwise/events/player/play_ogryn_foley_weapon_charge"
			},
			ogryn = {
				default = "wwise/events/weapon/play_weapon_silence",
				ogryn_pickaxe_2h_p1_m3 = "wwise/events/player/play_ogryn_foley_weapon_charge",
				ogryn_pickaxe_2h_p1_m2 = "wwise/events/player/play_ogryn_foley_weapon_charge",
				ogryn_pickaxe_2h_p1_m1 = "wwise/events/player/play_ogryn_foley_weapon_charge",
				grimoire_pocketable = "wwise/events/player/play_grimoire_unequip"
			}
		}
	},
	windup_stop = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/player/stop_melee_charge_grip_hands",
				forcesword_2h_p1_m2 = "wwise/events/weapon/stop_force_sword_charge_foley",
				forcesword_2h_p1_m1 = "wwise/events/weapon/stop_force_sword_charge_foley",
				forcesword_p1_m1 = "wwise/events/weapon/stop_force_sword_charge_foley",
				grimoire_pocketable = "wwise/events/player/stop_grimoire_unequip",
				forcesword_p1_m2 = "wwise/events/weapon/stop_force_sword_charge_foley",
				forcesword_p1_m3 = "wwise/events/weapon/stop_force_sword_charge_foley"
			},
			ogryn = {
				default = "wwise/events/player/stop_ogryn_charge_grip_hands",
				grimoire_pocketable = "wwise/events/player/stop_grimoire_unequip"
			}
		}
	},
	sfx_swing_critical = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"is_critical_strike"
		},
		events = {
			["true"] = "wwise/events/weapon/play_indicator_crit_melee_swing"
		}
	},
	melee_blocked_attack = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatsword_p2_m2 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			combatsword_p2_m1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			powermaul_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_shield_block",
			powersword_p1_m2 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			combataxe_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatsword_p3_m2 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			chainaxe_p1_m2 = "wwise/events/weapon/play_chainsword_block",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			chainsword_p1_m2 = "wwise/events/weapon/play_chainsword_block",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			default = "wwise/events/weapon/play_weapon_silence",
			combataxe_p3_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_block_melee",
			ogryn_club_p2_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combataxe_p1_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatsword_p2_m3 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			powersword_p1_m3 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_wood_block",
			powermaul_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatknife_p1_m1 = "wwise/events/weapon/play_knife_block",
			ogryn_club_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			powermaul_p2_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatsword_p3_m3 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			combatsword_p3_m1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_chainsword_block",
			combatsword_p1_m1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combataxe_p2_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_chainsword_block",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_shield_block",
			combataxe_p2_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatknife_p1_m2 = "wwise/events/weapon/play_knife_block",
			powermaul_p2_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_shield_block",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_shield_block",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			powersword_p1_m1 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_shield_block",
			chainaxe_p1_m1 = "wwise/events/weapon/play_chainsword_block",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			chainsword_p1_m1 = "wwise/events/weapon/play_chainsword_block",
			combataxe_p3_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combataxe_p3_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combataxe_p2_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			unarmed = "wwise/events/weapon/play_combat_block_sword_on_sword",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_slabshield_block_melee",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_block_melee",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_block_melee",
			combatsword_p1_m3 = "wwise/events/weapon/play_combat_block_sword_on_sword",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_metal_pipe_block_gen",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combataxe_p1_m2 = "wwise/events/weapon/play_metal_pipe_block_gen",
			combatsword_p1_m2 = "wwise/events/weapon/play_combat_block_sword_on_sword"
		}
	},
	ranged_blocked_attack = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_shield_block",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_shield_block",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_shield_block",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_slabshield_block_ranged",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_block_ranged",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_block_ranged",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_shield_block",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_block_ranged",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_shield_block"
		}
	},
	melee_sweep_hit = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			combatsword_p3_m1 = "wwise/events/weapon/stop_sword_swing_medium",
			combatsword_p1_m2 = "wwise/events/weapon/stop_sword_swing_medium",
			forcesword_2h_p1_m1 = "wwise/events/weapon/stop_sword_swing_large",
			forcesword_p1_m1 = "wwise/events/weapon/stop_sword_swing_large",
			combatsword_p3_m2 = "wwise/events/weapon/stop_sword_swing_medium",
			combatknife_p1_m1 = "wwise/events/weapon/stop_swing_knife",
			combatknife_p1_m2 = "wwise/events/weapon/stop_swing_knife",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/stop_swing_2h_powerhammer",
			powersword_p1_m1 = "wwise/events/weapon/stop_sword_swing_large",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/stop_swing_2h_powerhammer",
			combatsword_p3_m3 = "wwise/events/weapon/stop_sword_swing_medium",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/stop_sword_swing_medium",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/stop_sword_swing_medium",
			forcesword_p1_m2 = "wwise/events/weapon/stop_sword_swing_large",
			combatsword_p1_m3 = "wwise/events/weapon/stop_sword_swing_medium",
			combatsword_p1_m1 = "wwise/events/weapon/stop_sword_swing_medium",
			combatsword_p2_m2 = "wwise/events/weapon/stop_sword_swing_medium",
			powersword_p1_m2 = "wwise/events/weapon/stop_sword_swing_large",
			forcesword_p1_m3 = "wwise/events/weapon/stop_sword_swing_large",
			forcesword_2h_p1_m2 = "wwise/events/weapon/stop_sword_swing_large",
			combatsword_p2_m3 = "wwise/events/weapon/stop_sword_swing_medium",
			combatsword_p2_m1 = "wwise/events/weapon/stop_sword_swing_medium",
			powersword_p1_m3 = "wwise/events/weapon/stop_sword_swing_large"
		}
	},
	melee_heavy_sweep_hit = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			ogryn_club_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			combataxe_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			forcesword_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			combatsword_p3_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			combatsword_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			chainsword_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			powersword_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			chainaxe_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			chainsword_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			forcesword_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			forcesword_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			chainaxe_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_club_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit",
			combataxe_p3_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_club_p2_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			ogryn_club_p2_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			powersword_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatsword_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combataxe_p2_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_club_p2_m3 = "wwise/events/weapon/play_heavy_swing_hit",
			combataxe_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatsword_p2_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			combatsword_p2_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			powersword_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatknife_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			ogryn_club_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit",
			combatsword_p3_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatsword_p3_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_chain",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatsword_p1_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatsword_p2_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combataxe_p2_m1 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_chain",
			combataxe_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit",
			combataxe_p2_m3 = "wwise/events/weapon/play_heavy_swing_hit_slashing",
			combatknife_p1_m2 = "wwise/events/weapon/play_heavy_swing_hit_slashing"
		}
	},
	melee_sweep_hit_crit = {
		has_husk_events = true,
		switch = {
			"is_critical_strike",
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			["true"] = {
				default = "wwise/events/weapon/play_indicator_crit_melee_hit",
				combataxe_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				forcesword_2h_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				forcesword_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p3_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatknife_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p3_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatknife_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				powersword_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				forcesword_p1_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p3_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				forcesword_2h_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				forcesword_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p1_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				powersword_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p3_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p2_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p2_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p1_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p2_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p1_m2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combataxe_p2_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p2_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				bot_combatsword_linesman_p1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				bot_combatsword_linesman_p2 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				combatsword_p2_m1 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing",
				powersword_p1_m3 = "wwise/events/weapon/play_indicator_crit_melee_hit_slashing"
			}
		}
	},
	melee_heavy_sweep_hit_crit = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"is_critical_strike"
		},
		events = {
			["true"] = "wwise/events/weapon/play_indicator_crit_melee_hit"
		}
	},
	flyby_stop = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/stop_shared_combat_weapon_bullet_flyby_small"
		}
	},
	sfx_push_follow_up_build_up = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_push_follow_up_build_up",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up_build_up",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up_build_up",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_push_follow_up_build_up",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_push_follow_up_build_up"
		}
	},
	sfx_push_follow_up = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			combatsword_p2_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			bot_zola_laspistol = "wwise/events/weapon/play_force_sword_push_follow_up",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up",
			chainaxe_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_2h_sword_swing_special",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_push_follow_up",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_2h_sword_swing_special",
			bot_combatsword_linesman_p2 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p3_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			chainsword_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up",
			bot_laspistol_killshot = "wwise/events/weapon/play_force_sword_push_follow_up",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_push_follow_up",
			chainaxe_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			lasgun_p2_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			bot_combatsword_linesman_p1 = "wwise/events/weapon/play_pushback_sword_stab",
			chainsword_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p1_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_force_sword_push_follow_up",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_adamant_shield_push_foley",
			lasgun_p2_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_push_follow_up",
			ogryn_combatblade_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_combatblade_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p2_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			lasgun_p2_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_pickaxe_2h_p1_m1 = "wwise/events/weapon/play_pickaxe_2h_swing_special",
			ogryn_pickaxe_2h_p1_m2 = "wwise/events/weapon/play_pickaxe_2h_swing_special",
			combatsword_p2_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_2h_sword_swing_special",
			laspistol_p1_m3 = "wwise/events/weapon/play_force_sword_push_follow_up",
			ogryn_pickaxe_2h_p1_m3 = "wwise/events/weapon/play_pickaxe_2h_swing_special",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_push_foley",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_adamant_shield_push_foley",
			combatsword_p3_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p3_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			chainsword_2h_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_combatblade_p1_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			laspistol_p1_m1 = "wwise/events/weapon/play_force_sword_push_follow_up",
			chainsword_2h_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			combatsword_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab"
		}
	},
	sfx_special_activate = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			powermaul_2h_p1_m1 = "wwise/events/weapon/play_ogryn_powermaul_1h_powered_button",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_on",
			flamer_p1_m1 = "wwise/events/weapon/play_flametrower_equip_var_1",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_on",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			powersword_p1_m1 = "wwise/events/weapon/play_power_sword_on",
			powersword_p1_m3 = "wwise/events/weapon/play_power_sword_on",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/play_thunder_hammer_power_start",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_on",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_power_sword_2h_on",
			powersword_p1_m2 = "wwise/events/weapon/play_power_sword_on",
			powermaul_shield_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_on",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_power_sword_2h_on",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/play_ogryn_powermaul_1h_powered_button",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_power_sword_2h_on",
			powermaul_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks",
			powermaul_shield_p1_m1 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/play_thunder_hammer_power_start",
			powermaul_p2_m2 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks",
			powermaul_p1_m2 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/play_ogryn_powermaul_1h_powered_button",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_on",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_pushback_sword_stab",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_pushback_sword_stab",
			powermaul_p2_m1 = "wwise/events/weapon/play_shockmaul_1h_electric_sparks"
		}
	},
	weapon_special_end = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			powersword_2h_p1_m2 = "wwise/events/weapon/play_power_sword_2h_off",
			forcesword_2h_p1_m1 = "wwise/events/weapon/play_force_sword_off",
			forcesword_p1_m1 = "wwise/events/weapon/play_force_sword_off",
			chainaxe_p1_m2 = "wwise/events/weapon/play_chainaxe_rev",
			powersword_p1_m2 = "wwise/events/weapon/play_power_sword_off",
			powersword_p1_m1 = "wwise/events/weapon/play_power_sword_off",
			forcesword_p1_m3 = "wwise/events/weapon/play_force_sword_off",
			forcesword_2h_p1_m2 = "wwise/events/weapon/play_force_sword_off",
			powersword_2h_p1_m3 = "wwise/events/weapon/play_power_sword_2h_off",
			powersword_2h_p1_m1 = "wwise/events/weapon/play_power_sword_2h_off",
			forcesword_p1_m2 = "wwise/events/weapon/play_force_sword_off",
			chainaxe_p1_m1 = "wwise/events/weapon/play_chainaxe_rev",
			powersword_p1_m3 = "wwise/events/weapon/play_power_sword_off"
		}
	},
	weapon_special_custom = {
		no_default = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence"
		}
	},
	wind_slash = {
		no_default = true,
		switch = {
			"wielded_weapon_template",
			"level"
		},
		events = {
			forcesword_2h_p1_m1 = {
				high = "wwise/events/weapon/play_2h_forcesword_special_attack",
				middle = "wwise/events/weapon/play_2h_forcesword_special_attack_medium",
				low = "wwise/events/weapon/play_2h_forcesword_special_attack_light"
			},
			forcesword_2h_p1_m2 = {
				high = "wwise/events/weapon/play_2h_forcesword_special_attack",
				middle = "wwise/events/weapon/play_2h_forcesword_special_attack_medium",
				low = "wwise/events/weapon/play_2h_forcesword_special_attack_light"
			}
		}
	},
	wind_slash_stage_interfacing = {
		no_default = true,
		switch = {
			"wielded_weapon_template",
			"stage"
		},
		events = {
			forcesword_2h_p1_m1 = {
				high = "wwise/events/weapon/play_force_sword_2h_special_charge_ready_rank_3",
				middle = "wwise/events/weapon/play_force_sword_2h_special_charge_ready_rank_2"
			},
			forcesword_2h_p1_m2 = {
				high = "wwise/events/weapon/play_force_sword_2h_special_charge_ready_rank_3",
				middle = "wwise/events/weapon/play_force_sword_2h_special_charge_ready_rank_2"
			}
		}
	},
	weapon_overload = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"wielded_weapon_template",
			"stage"
		},
		events = {
			plasmagun_p1_m1 = {
				high = "wwise/events/weapon/play_plasmagun_overheat_intensity_01",
				critical = "wwise/events/weapon/play_plasmagun_overheat_intensity_02"
			}
		}
	},
	flashlight_on = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			autogun_p1_m3 = "wwise/events/player/play_weapon_flashlight_medium_on",
			default = "wwise/events/player/play_weapon_flashlight_light_on",
			autogun_p1_m2 = "wwise/events/player/play_weapon_flashlight_medium_on",
			ogryn_heavystubber_p2_m1 = "wwise/events/player/play_weapon_flashlight_heavy_on",
			autogun_p1_m1 = "wwise/events/player/play_weapon_flashlight_medium_on",
			ogryn_heavystubber_p2_m2 = "wwise/events/player/play_weapon_flashlight_heavy_on",
			ogryn_heavystubber_p2_m3 = "wwise/events/player/play_weapon_flashlight_heavy_on"
		}
	},
	flashlight_off = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			autogun_p1_m3 = "wwise/events/player/play_weapon_flashlight_medium_off",
			default = "wwise/events/player/play_weapon_flashlight_light_off",
			autogun_p1_m2 = "wwise/events/player/play_weapon_flashlight_medium_off",
			ogryn_heavystubber_p2_m1 = "wwise/events/player/play_weapon_flashlight_heavy_off",
			autogun_p1_m1 = "wwise/events/player/play_weapon_flashlight_medium_off",
			ogryn_heavystubber_p2_m2 = "wwise/events/player/play_weapon_flashlight_heavy_off",
			ogryn_heavystubber_p2_m3 = "wwise/events/player/play_weapon_flashlight_heavy_off"
		}
	},
	flashlight_flicker = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/player/play_foley_gear_flashlight_flicker",
			ogryn_heavystubber_p2_m2 = "wwise/events/player/play_foley_gear_flashlight_flicker",
			ogryn_heavystubber_p2_m1 = "wwise/events/player/play_foley_gear_flashlight_flicker"
		}
	},
	sfx_device_start = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder = "wwise/events/player/play_servitor_hacking",
				breach_charge = "wwise/events/player/play_int_breach_charge_activate_human"
			},
			ogryn = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder = "wwise/events/player/play_servitor_hacking",
				breach_charge = "wwise/events/player/play_int_breach_charge_activate_ogryn"
			}
		}
	},
	sfx_device_start_01 = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_human_activate_servitor_01"
			},
			ogryn = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_ogryn_activate_servitor_01"
			}
		}
	},
	sfx_device_start_02 = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_human_activate_servitor_02"
			},
			ogryn = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_ogryn_activate_servitor_02"
			}
		}
	},
	sfx_device_start_03 = {
		has_husk_events = true,
		switch = {
			"archetype",
			"wielded_weapon_template"
		},
		events = {
			default = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_human_activate_servitor_03"
			},
			ogryn = {
				default = "wwise/events/weapon/play_weapon_silence",
				skull_decoder_02 = "wwise/events/player/play_event_poison_ogryn_activate_servitor_02"
			}
		}
	},
	sfx_device_stop = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			skull_decoder = "wwise/events/player/play_servitor_hacking_cancel",
			skull_decoder_02 = "wwise/events/player/play_event_poison_servitor_cancel",
			breach_charge = "wwise/events/player/stop_int_breach_charge_activate"
		}
	},
	sfx_minigame_success = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_progress",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_progress"
		}
	},
	sfx_minigame_success_last = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_progress_last",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_progress_last"
		}
	},
	sfx_minigame_fail = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_fail",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_fail"
		}
	},
	sfx_minigame_sinus_adjust_x = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_adjust_x",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_adjust_x"
		}
	},
	sfx_minigame_sinus_adjust_y = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_adjust_y",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_adjust_y"
		}
	},
	sfx_minigame_sinus_success_last = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_aligned",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_aligned"
		}
	},
	sfx_minigame_bio_selection = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_selection",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_selection"
		}
	},
	sfx_minigame_bio_selection_right = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_selection_right",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_selection_right"
		}
	},
	sfx_minigame_bio_selection_wrong = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_selection_wrong",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_selection_wrong"
		}
	},
	sfx_minigame_bio_progress = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_progress",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_progress"
		}
	},
	sfx_minigame_bio_progress_last = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_progress_last",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_progress_last"
		}
	},
	sfx_minigame_bio_fail = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_bio_minigame_fail",
			auspex_scanner = "wwise/events/player/play_device_auspex_bio_minigame_fail"
		}
	},
	sfx_scanning_sucess = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			scanner_equip = "wwise/events/player/play_scanner_collect_success"
		}
	},
	ranged_pre_loop_shot = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/play_autogun_p2_m2_first",
			lasgun_p3_m1 = "wwise/events/weapon/play_lasgun_p3_m1_fire_single",
			lasgun_p3_m3 = "wwise/events/weapon/play_lasgun_p3_m3_fire_single",
			autogun_p1_m3 = "wwise/events/weapon/play_autogun_p1_m3_first",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_p2_m3_punch_first",
			autogun_p2_m1 = "wwise/events/weapon/play_autogun_p2_m1_first",
			autogun_p1_m1 = "wwise/events/weapon/play_autogun_p1_m1_first",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_heavy_stubber_p1_m2_punch_first",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_heavy_stubber_punch_first",
			lasgun_p3_m2 = "wwise/events/weapon/play_lasgun_p3_m2_fire_single",
			autogun_p1_m2 = "wwise/events/weapon/play_autogun_p1_m2_single",
			autopistol_p1_m1 = "wwise/events/weapon/play_weapon_autopistol",
			autogun_p2_m3 = "wwise/events/weapon/play_autogun_p2_m3_first",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_p2_m2_punch_first",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_p2_m1_punch_first",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_heavy_stubber_p1_m3_punch_first"
		}
	},
	ranged_single_shot = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template",
			"charge_level"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			bot_zola_laspistol = "wwise/events/weapon/play_weapon_laspistol",
			psyker_smite = "wwise/events/weapon/play_psyker_smite_fire",
			zealot_throwing_knives = "wwise/events/weapon/play_zealot_throw_knife",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_p1_m3",
			bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_p1_m1",
			bot_laspistol_killshot = "wwise/events/weapon/play_weapon_laspistol",
			autogun_p3_m2 = "wwise/events/weapon/play_autogun_p3_m2_single",
			forcestaff_p2_m1 = "wwise/events/weapon/play_psyker_smite_fire",
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_throw_knife",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_p1_m2",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_p1_m1",
			boltpistol_p1_m1 = "wwise/events/weapon/play_bolt_pistol_p1_m1_single",
			bolter_p1_m1 = "wwise/events/weapon/play_weapon_bolter",
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_m1",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_stub_revolver",
			autogun_p3_m1 = "wwise/events/weapon/play_autogun_p3_m1_single",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_stub_revolver_p1_m2",
			lasgun_p1_m2 = "wwise/events/weapon/play_weapon_lasgun_p1_m2",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_m1",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_ogryn_thumper_p1_m1",
			stubrifle_p1_m1 = "wwise/events/weapon/play_stubrifle_p1_m1",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_ogryn_gauntlet_fire",
			forcestaff_p4_m1 = "wwise/events/weapon/play_psyker_smite_fire",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_ogryn_thumper_p1_m2",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_heavy_stubber_p2_m1_punch_first",
			forcestaff_p3_m1 = "wwise/events/weapon/play_psyker_smite_fire",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_heavy_stubber_p2_m2_punch_first",
			laspistol_p1_m3 = "wwise/events/weapon/play_laspistol_p1_m3",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_heavy_stubber_p2_m3_punch_first",
			shotgun_p1_m1 = "wwise/events/weapon/play_combat_weapon_shotgun",
			high_bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_m1_single",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_rippergun",
			bot_autogun_killshot = "wwise/events/weapon/play_autogun_p3_m1_single",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_rippergun",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_shotpistol_p1_m1",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_m1",
			lasgun_p1_m3 = "wwise/events/weapon/play_weapon_lasgun_p1_m3",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_rippergun",
			laspistol_p1_m1 = "wwise/events/weapon/play_weapon_laspistol",
			autopistol_p1_m1 = "wwise/events/weapon/play_weapon_autopistol",
			forcestaff_p1_m1 = "wwise/events/weapon/play_psyker_smite_fire",
			lasgun_p1_m1 = "wwise/events/weapon/play_weapon_lasgun_p1_m1",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_m1",
			autogun_p3_m3 = "wwise/events/weapon/play_autogun_p3_m3_single",
			lasgun_p2_m1 = {
				default = "wwise/events/weapon/play_lasgun_p2_m1",
				fully_charged = "wwise/events/weapon/play_lasgun_p2_m1_charged"
			},
			lasgun_p2_m2 = {
				default = "wwise/events/weapon/play_lasgun_p2_m2",
				fully_charged = "wwise/events/weapon/play_lasgun_p2_m2_charged"
			},
			lasgun_p2_m3 = {
				default = "wwise/events/weapon/play_lasgun_p2_m3",
				fully_charged = "wwise/events/weapon/play_lasgun_p2_m3_charged"
			},
			plasmagun_p1_m1 = {
				default = "wwise/events/weapon/play_weapon_plasmagun",
				fully_charged = "wwise/events/weapon/play_weapon_plasmagun_charged"
			},
			psyker_chain_lightning = {
				default = "wwise/events/weapon/play_psyker_lightning_bolt",
				fully_charged = "wwise/events/weapon/play_psyker_lightning_bolt_charged"
			}
		}
	},
	ranged_single_shot_special_extra = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			shotgun_p4_m3 = "wwise/events/weapon/play_shotgun_p4_m2_special",
			shotgun_p4_m2 = "wwise/events/weapon/play_shotgun_p4_m2_special",
			shotgun_p1_m1 = "wwise/events/weapon/play_shotgun_punch_special",
			shotgun_p4_m1 = "wwise/events/weapon/play_shotgun_p4_m1_special",
			default = "wwise/events/weapon/play_weapon_silence",
			shotgun_p1_m3 = "wwise/events/weapon/play_shotgun_p1_m3_special",
			psyker_chain_lightning = "wwise/events/weapon/play_psyker_chain_lightning_grenade_jump",
			shotgun_p1_m2 = "wwise/events/weapon/play_shotgun_p1_m2_special",
			shotgun_p2_m1 = "wwise/events/weapon/play_shotgun_p2_punch_special"
		}
	},
	ranged_shot_tail = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			boltpistol_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_bolter",
			autogun_p2_m2 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			bot_zola_laspistol = "wwise/events/weapon/play_player_wpn_refl_las_pistol",
			bot_lasgun_killshot = "wwise/events/weapon/play_player_wpn_refl_las",
			autogun_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			lasgun_p2_m2 = "wwise/events/weapon/play_player_wpn_refl_las",
			shotgun_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_shotgun",
			default = "wwise/events/weapon/play_weapon_silence",
			shotgun_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_shotgun",
			autogun_p3_m2 = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			shotgun_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_shotgun",
			lasgun_p3_m3 = "wwise/events/weapon/play_player_wpn_refl_las",
			bot_laspistol_killshot = "wwise/events/weapon/play_player_wpn_refl_las_pistol",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_player_wpn_refl_las",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_lmg",
			lasgun_p2_m3 = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			bolter_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_bolter",
			lasgun_p3_m2 = "wwise/events/weapon/play_player_wpn_refl_las",
			shotgun_p4_m1 = "wwise/events/weapon/play_player_wpn_refl_shotgun_db",
			autogun_p3_m1 = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			shotgun_p4_m3 = "wwise/events/weapon/play_player_wpn_refl_shotgun_db",
			lasgun_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_las",
			shotgun_p4_m2 = "wwise/events/weapon/play_player_wpn_refl_shotgun_db",
			lasgun_p3_m1 = "wwise/events/weapon/play_player_wpn_refl_las",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_revolver",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_weapon_silence",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_revolver",
			lasgun_p2_m1 = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_lmg",
			autogun_p2_m1 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_player_wpn_refl_heavy",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_player_wpn_refl_bolter",
			laspistol_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_las_pistol",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_rippergun",
			plasmagun_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_plasma",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_weapon_silence",
			high_bot_autogun_killshot = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_rippergun",
			bot_autogun_killshot = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_rippergun",
			shotpistol_shield_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_revolver",
			autogun_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			lasgun_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_las",
			autogun_p1_m2 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_rippergun",
			laspistol_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_las_pistol",
			autopistol_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_smg",
			autogun_p2_m3 = "wwise/events/weapon/play_player_wpn_refl_rifle",
			psyker_chain_lightning = "wwise/events/weapon/play_player_wpn_refl_plasma",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_player_wpn_refl_p2_stubber_m2",
			lasgun_p1_m1 = "wwise/events/weapon/play_player_wpn_refl_las",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_player_wpn_refl_lmg",
			shotgun_p2_m1 = "wwise/events/weapon/play_player_wpn_refl_shotgun_db",
			autogun_p3_m3 = "wwise/events/weapon/play_player_wpn_refl_rifle_heavy"
		}
	},
	ranged_no_ammo = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			autogun_p2_m2 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			bot_zola_laspistol = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			lasgun_p2_m2 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			autogun_p2_m1 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			shotgun_p1_m3 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			bot_laspistol_killshot = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			shotgun_p4_m1 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			autogun_p3_m2 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			shotgun_p4_m3 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			lasgun_p3_m3 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			shotgun_p1_m2 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			lasgun_p2_m3 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			bolter_p1_m1 = "wwise/events/weapon/play_weapon_bolter_no_ammo",
			lasgun_p3_m2 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			autogun_p3_m1 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			lasgun_p1_m2 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			shotgun_p4_m2 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			lasgun_p3_m1 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_gauntlet_p1_m1 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			lasgun_p2_m1 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			ogryn_thumper_p1_m1 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			ogryn_thumper_p1_m2 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			laspistol_p1_m3 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			shotgun_p1_m1 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			high_bot_autogun_killshot = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			bot_autogun_killshot = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			autogun_p1_m1 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			autogun_p1_m2 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			laspistol_p1_m1 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			autopistol_p1_m1 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			autogun_p2_m3 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			autogun_p1_m3 = "wwise/events/weapon/play_weapon_autogun_no_ammo",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			lasgun_p1_m1 = "wwise/events/weapon/play_weapon_lasgun_no_ammo",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_weapon_ogryn_shotgun_no_ammo",
			shotgun_p2_m1 = "wwise/events/weapon/play_combat_weapon_shotgun_no_ammo",
			autogun_p3_m3 = "wwise/events/weapon/play_weapon_autogun_no_ammo"
		}
	},
	ranged_out_of_ammo = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/play_last_bullet_autogun",
			bot_zola_laspistol = "wwise/events/weapon/play_last_bullet_lasgun",
			flamer_p1_m1 = "wwise/events/weapon/play_last_bullet_flamethrower",
			bot_lasgun_killshot = "wwise/events/weapon/play_last_bullet_lasgun",
			lasgun_p2_m2 = "wwise/events/weapon/play_last_bullet_lasgun",
			shotgun_p1_m3 = "wwise/events/weapon/play_last_bullet_shotgun",
			autogun_p2_m1 = "wwise/events/weapon/play_last_bullet_autogun",
			bot_laspistol_killshot = "wwise/events/weapon/play_last_bullet_lasgun",
			autogun_p3_m2 = "wwise/events/weapon/play_last_bullet_rifle_heavy",
			shotgun_p4_m1 = "wwise/events/weapon/play_last_bullet_shotgun",
			lasgun_p3_m3 = "wwise/events/weapon/play_last_bullet_lasgun",
			shotgun_p1_m2 = "wwise/events/weapon/play_last_bullet_shotgun",
			high_bot_lasgun_killshot = "wwise/events/weapon/play_last_bullet_lasgun",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/play_rippergun_last_bullet",
			lasgun_p2_m3 = "wwise/events/weapon/play_last_bullet_lasgun",
			bolter_p1_m1 = "wwise/events/weapon/play_last_bullet_bolter",
			lasgun_p3_m2 = "wwise/events/weapon/play_last_bullet_lasgun",
			stubrevolver_p1_m1 = "wwise/events/weapon/play_last_bullet_revolver",
			autogun_p3_m1 = "wwise/events/weapon/play_last_bullet_rifle_heavy",
			stubrevolver_p1_m2 = "wwise/events/weapon/play_last_bullet_revolver",
			lasgun_p1_m2 = "wwise/events/weapon/play_last_bullet_lasgun",
			shotgun_p4_m2 = "wwise/events/weapon/play_last_bullet_shotgun",
			lasgun_p3_m1 = "wwise/events/weapon/play_last_bullet_lasgun",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/play_rippergun_last_bullet",
			shotgun_p4_m3 = "wwise/events/weapon/play_last_bullet_shotgun",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/play_rippergun_last_bullet",
			lasgun_p2_m1 = "wwise/events/weapon/play_last_bullet_lasgun",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/play_rippergun_last_bullet",
			laspistol_p1_m3 = "wwise/events/weapon/play_last_bullet_lasgun",
			shotgun_p1_m1 = "wwise/events/weapon/play_last_bullet_shotgun",
			high_bot_autogun_killshot = "wwise/events/weapon/play_last_bullet_rifle_heavy",
			ogryn_rippergun_p1_m2 = "wwise/events/weapon/play_rippergun_last_bullet",
			bot_autogun_killshot = "wwise/events/weapon/play_last_bullet_rifle_heavy",
			ogryn_rippergun_p1_m3 = "wwise/events/weapon/play_rippergun_last_bullet",
			autogun_p1_m1 = "wwise/events/weapon/play_last_bullet_autogun",
			autogun_p1_m2 = "wwise/events/weapon/play_last_bullet_autogun",
			ogryn_rippergun_p1_m1 = "wwise/events/weapon/play_rippergun_last_bullet",
			laspistol_p1_m1 = "wwise/events/weapon/play_last_bullet_lasgun",
			autopistol_p1_m1 = "wwise/events/weapon/play_last_bullet_autopistol",
			autogun_p2_m3 = "wwise/events/weapon/play_last_bullet_autogun",
			autogun_p1_m3 = "wwise/events/weapon/play_last_bullet_autogun",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/play_rippergun_last_bullet",
			lasgun_p1_m1 = "wwise/events/weapon/play_last_bullet_lasgun",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/play_rippergun_last_bullet",
			shotgun_p2_m1 = "wwise/events/weapon/play_last_bullet_shotgun_p2",
			autogun_p3_m3 = "wwise/events/weapon/play_last_bullet_rifle_heavy"
		}
	},
	critical_shot_extra = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			laspistol_p1_m3 = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p2_m2 = "wwise/events/weapon/play_indicator_crit_weak",
			bot_zola_laspistol = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p1_m1 = "wwise/events/weapon/play_indicator_crit_weak",
			high_bot_autogun_killshot = "wwise/events/weapon/play_indicator_crit_weak",
			default = "wwise/events/weapon/play_indicator_crit",
			bot_autogun_killshot = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p2_m1 = "wwise/events/weapon/play_indicator_crit_weak",
			bot_laspistol_killshot = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p1_m2 = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p3_m1 = "wwise/events/weapon/play_indicator_crit_weak",
			laspistol_p1_m1 = "wwise/events/weapon/play_indicator_crit_weak",
			autopistol_p1_m1 = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p2_m3 = "wwise/events/weapon/play_indicator_crit_weak",
			autogun_p1_m3 = "wwise/events/weapon/play_indicator_crit_weak",
			psyker_throwing_knives = "wwise/events/weapon/play_indicator_crit_psyker",
			autogun_p3_m3 = "wwise/events/weapon/play_indicator_crit_weak"
		}
	},
	ranged_pre_shoot = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_pre_fire"
		}
	},
	ranged_abort = {
		has_husk_events = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			flamer_p1_m1 = "wwise/events/weapon/play_flamethrower_interrupt"
		}
	},
	sfx_catch_charge = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_throwing_knife_pre_fetch"
		}
	},
	sfx_catch = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_knife_fetch"
		}
	},
	sfx_catch_cancel = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_knife_fetch_cancel"
		}
	},
	backstab_interfacing = {
		has_stop_event = false,
		switch = {
			"attack_type"
		},
		events = {
			melee = "wwise/events/player/play_indicator_backstab_melee",
			default = "wwise/events/weapon/play_weapon_silence",
			ranged = "wwise/events/player/play_indicator_backstab_ranged"
		}
	},
	elite_special_killed_stinger = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"enemy_type"
		},
		events = {
			captain = "wwise/events/player/play_monster_killed",
			monster = "wwise/events/player/play_monster_killed",
			special = "wwise/events/player/play_special_killed",
			elite = "wwise/events/player/play_elite_killed"
		}
	},
	disabled_enter = {
		has_husk_events = true,
		switch = {
			"stinger_type"
		},
		events = {
			default = "wwise/events/weapon/play_weapon_silence",
			warp_grabbed = "wwise/events/player/play_enemy_daemonhost_grab_stinger",
			teammate_knocked_down = "wwise/events/player/play_teammate_knocked_down",
			mutant_charge = "wwise/events/player/play_hud_player_states_mutant_charger_downed",
			catapulted = "wwise/events/player/play_player_combat_experience_catapulted",
			hanging = "wwise/events/player/play_hud_player_hanging_stinger",
			netted = "wwise/events/player/play_hud_player_states_netgunner_downed",
			teammate_died = "wwise/events/player/play_teammate_died",
			pounced = "wwise/events/player/play_hud_player_states_chaos_hound_downed"
		}
	},
	disabled_exit = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"stinger_type"
		},
		events = {
			netted = "wwise/events/player/play_player_disabled_exit",
			hogtied = "wwise/events/player/play_player_disabled_exit",
			teammate_knocked_down = "wwise/events/player/play_player_disabled_exit",
			pounced = "wwise/events/player/play_player_disabled_exit",
			hanging = "wwise/events/player/play_player_disabled_exit"
		}
	},
	veteran_ranger_highlight = {
		switch = {},
		events = {
			default = "wwise/events/player/play_player_ability_veteran_highlight"
		}
	},
	ability_shout = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"ability_template"
		},
		events = {
			zealot_relic = "wwise/events/player/play_ability_zealot_bolstering_prayer",
			ogryn_taunt_shout = "wwise/events/player/play_ogryn_ability_taunt",
			psyker_shout = "wwise/events/player/play_psyker_ability_shout",
			veteran_combat_ability = "wwise/events/player/play_veteran_ability_shout"
		}
	},
	ability_bash = {
		has_husk_events = true,
		no_default = true,
		switch = {
			"ability_template"
		},
		events = {
			adamant_charge = "wwise/events/player/play_player_ability_adamant_charge_hit"
		}
	},
	recieve_gifted_item = {
		no_default = true,
		has_husk_events = false,
		switch = {
			"pocketable_name"
		},
		events = {
			default = "wwise/events/player/play_player_foley_receive_item_gen",
			tome = "wwise/events/player/play_player_foley_receive_item_book",
			syringe_corruption_pocketable = "wwise/events/player/play_player_foley_receive_item_gen",
			syringe_ability_boost_pocketable = "wwise/events/player/play_player_foley_receive_item_gen",
			ammo_cache_pocketable = "wwise/events/player/play_player_foley_receive_item_metal",
			syringe_power_boost_pocketable = "wwise/events/player/play_player_foley_receive_item_gen",
			syringe_speed_boost_pocketable = "wwise/events/player/play_player_foley_receive_item_gen",
			medical_crate_pocketable = "wwise/events/player/play_player_foley_receive_item_metal"
		}
	},
	charge_ready_indicator = {
		switch = {
			"indicator_type"
		},
		events = {
			default = "wwise/events/player/play_player_grenade_charge_restored_gen",
			psyker_throwing_knives_single = "wwise/events/weapon/play_psyker_gunslinger_equip_shard_single",
			riot_shield_block_charge = "wwise/events/weapon/play_electric_shield_fully_charged",
			psyker_throwing_knives = "wwise/events/weapon/play_psyker_restored_shard"
		}
	},
	zealot_preacher_cast_shield = {
		no_default = true,
		has_husk_events = true,
		switch = {
			"archetype"
		},
		events = {
			zealot = "wwise/events/player/play_ability_zealot_preacher_cast"
		}
	},
	play_ability_psyker_protectorate_shield_rotate = {
		no_default = true,
		switch = {
			"archetype"
		},
		events = {
			psyker = "wwise/events/player/play_ability_psyker_protectorate_shield_rotate"
		}
	},
	dodge_success_melee = {
		switch = {
			"enemy_type"
		},
		events = {
			default = "wwise/events/player/play_player_dodge_melee_success",
			elite = "wwise/events/player/play_player_dodge_melee_success",
			special = "wwise/events/player/play_player_dodge_melee_success_specials",
			captain = "wwise/events/player/play_player_dodge_melee_success_specials",
			monster = "wwise/events/player/play_player_dodge_melee_success_specials"
		}
	},
	rumble_generic = {
		has_husk_events = false,
		no_default = true,
		switch = {
			"rumble_type"
		},
		events = {
			rumble_1_00s = "wwise/events/player/play_2d_rumble_1s",
			rumble_0_25s = "wwise/events/player/play_2d_rumble_025s",
			rumble_0_15s = "wwise/events/player/play_2d_rumble_015s",
			rumble_0_50s = "wwise/events/player/play_2d_rumble_05s"
		}
	},
	rumble_push = {
		has_husk_events = false,
		switch = {
			"wielded_weapon_template",
			"hit_enemies"
		},
		events = {
			default = {
				default = "wwise/events/weapon/play_weapon_silence",
				["true"] = "wwise/events/player/play_2d_rumble_melee_shove"
			}
		}
	}
}
local looping_events = {
	ability_no_target_activating = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence"
		}
	},
	ability_target_activating = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence"
		}
	},
	catapulted = {
		has_stop_event = true,
		switch = {},
		events = {
			default = "wwise/events/player/%s_player_combat_experience_catapulted"
		}
	},
	knocked_down = {
		has_stop_event = true,
		switch = {},
		events = {
			default = "wwise/events/player/%s_player_state_knocked_down_loop"
		}
	},
	netted = {
		has_stop_event = true,
		switch = {},
		events = {
			default = "wwise/events/player/%s_player_get_netted_electric_loop"
		}
	},
	toughness_loop = {
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence"
		}
	},
	ranged_charging = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/%s_plasmagun_charge",
			psyker_smite = "wwise/events/weapon/%s_psyker_headpop_hands",
			lasgun_p2_m2 = "wwise/events/weapon/%s_lasgun_p2_m2_charge",
			psyker_chain_lightning = "wwise/events/weapon/%s_psyker_lightning_bolt_charge",
			forcestaff_p2_m1 = "wwise/events/weapon/%s_forcestaff_warp_fire_charge_loop",
			lasgun_p2_m1 = "wwise/events/weapon/%s_lasgun_p2_charge",
			forcestaff_p4_m1 = "wwise/events/weapon/%s_forcestaff_p4_charge_loop",
			forcestaff_p3_m1 = "wwise/events/weapon/%s_psyker_chain_lightning_charge",
			lasgun_p2_m3 = "wwise/events/weapon/%s_lasgun_p2_m3_charge"
		}
	},
	ranged_fast_charging = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/%s_weapon_plasmagun_charge_fast",
			lasgun_p2_m1 = "wwise/events/weapon/%s_lasgun_p2_charge",
			lasgun_p2_m2 = "wwise/events/weapon/%s_lasgun_p2_charge",
			lasgun_p2_m3 = "wwise/events/weapon/%s_lasgun_p2_charge"
		}
	},
	weapon_temperature = {
		has_husk_events = false,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p2_m3 = "wwise/events/weapon/%s_laspistol_heat_loop",
			bot_zola_laspistol = "wwise/events/weapon/%s_laspistol_heat_loop",
			flamer_p1_m1 = "wwise/events/weapon/%s_laspistol_heat_loop",
			bot_lasgun_killshot = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p1_m2 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p1_m1 = "wwise/events/weapon/%s_laspistol_heat_loop",
			laspistol_p1_m3 = "wwise/events/weapon/%s_laspistol_heat_loop",
			plasmagun_p1_m1 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p3_m3 = "wwise/events/weapon/%s_laspistol_heat_loop",
			bot_laspistol_killshot = "wwise/events/weapon/%s_laspistol_heat_loop",
			high_bot_lasgun_killshot = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p1_m3 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p3_m2 = "wwise/events/weapon/%s_laspistol_heat_loop",
			laspistol_p1_m1 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p2_m2 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p3_m1 = "wwise/events/weapon/%s_laspistol_heat_loop",
			lasgun_p2_m1 = "wwise/events/weapon/%s_laspistol_heat_loop"
		}
	},
	psyker_smite_charge = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {},
		events = {
			default = "wwise/events/weapon/%s_psyker_smite_charge"
		}
	},
	ranged_shooting = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/%s_autogun_p2_m2_auto",
			lasgun_p3_m1 = "wwise/events/weapon/%s_lasgun_p3_m1_fire_auto",
			flamer_p1_m1 = "wwise/events/weapon/%s_flamethrower_fire_loop",
			autogun_p1_m3 = "wwise/events/weapon/%s_autogun_p1_m3_auto",
			lasgun_p3_m3 = "wwise/events/weapon/%s_lasgun_p3_m3_fire_auto",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/%s_heavy_stubber_p2_m3_fire_auto",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/%s_heavy_stubber_p2_m2_fire_auto",
			forcestaff_p2_m1 = "wwise/events/weapon/%s_forcestaff_warp_fire",
			autogun_p2_m1 = "wwise/events/weapon/%s_autogun_p2_m1_auto",
			autogun_p1_m1 = "wwise/events/weapon/%s_autogun_p1_m1_auto",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/%s_heavy_stubber_p1_m2_auto",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/%s_heavy_stubber_auto",
			lasgun_p3_m2 = "wwise/events/weapon/%s_lasgun_p3_m2_fire_auto",
			autogun_p1_m2 = "wwise/events/weapon/%s_autogun_p1_m2_auto",
			autopistol_p1_m1 = "wwise/events/weapon/%s_weapon_autopistol_auto",
			autogun_p2_m3 = "wwise/events/weapon/%s_autogun_p2_m3_auto",
			psyker_chain_lightning = "wwise/events/weapon/%s_psyker_chain_lightning_grenade",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/%s_heavy_stubber_p2_m1_fire_auto",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/%s_heavy_stubber_p1_m3_auto",
			forcestaff_p3_m1 = "wwise/events/weapon/%s_psyker_chain_lightning",
			scanner_equip = "wwise/events/player/%s_device_scanning"
		}
	},
	ranged_braced_shooting = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			autogun_p2_m2 = "wwise/events/weapon/%s_autogun_p2_m2_auto",
			lasgun_p3_m1 = "wwise/events/weapon/%s_lasgun_p3_m1_fire_auto",
			lasgun_p3_m3 = "wwise/events/weapon/%s_lasgun_p3_m3_fire_auto",
			autogun_p1_m3 = "wwise/events/weapon/%s_autogun_p1_m3_auto",
			ogryn_heavystubber_p2_m2 = "wwise/events/weapon/%s_heavy_stubber_p2_m2_fire_auto",
			ogryn_heavystubber_p2_m3 = "wwise/events/weapon/%s_heavy_stubber_p2_m3_fire_auto",
			forcestaff_p2_m1 = "wwise/events/weapon/%s_forcestaff_warp_fire",
			autogun_p2_m1 = "wwise/events/weapon/%s_autogun_p2_m1_auto",
			autogun_p1_m1 = "wwise/events/weapon/%s_autogun_p1_m1_auto",
			ogryn_heavystubber_p1_m2 = "wwise/events/weapon/%s_heavy_stubber_p1_m2_auto",
			ogryn_heavystubber_p1_m1 = "wwise/events/weapon/%s_heavy_stubber_auto",
			lasgun_p3_m2 = "wwise/events/weapon/%s_lasgun_p3_m2_fire_auto",
			autogun_p1_m2 = "wwise/events/weapon/%s_autogun_p1_m2_auto",
			autopistol_p1_m1 = "wwise/events/weapon/%s_weapon_autopistol_auto",
			autogun_p2_m3 = "wwise/events/weapon/%s_autogun_p2_m3_auto",
			psyker_chain_lightning = "wwise/events/weapon/%s_psyker_chain_lightning_grenade_charged",
			ogryn_heavystubber_p2_m1 = "wwise/events/weapon/%s_heavy_stubber_p2_m1_fire_auto",
			ogryn_heavystubber_p1_m3 = "wwise/events/weapon/%s_heavy_stubber_p1_m3_auto",
			forcestaff_p3_m1 = "wwise/events/weapon/%s_psyker_chain_lightning_heavy",
			scanner_equip = "wwise/events/player/%s_scanner_collect_loop"
		}
	},
	melee_sticky_loop = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			chainaxe_p1_m2 = "wwise/events/weapon/%s_chainaxe_stuck_loop",
			forcesword_2h_p1_m1 = "wwise/events/weapon/%s_force_sword_stuck",
			forcesword_p1_m1 = "wwise/events/weapon/%s_force_sword_stuck",
			powermaul_p1_m1 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop",
			powermaul_shield_p1_m1 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop",
			powermaul_p1_m2 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop",
			chainsword_p1_m2 = "wwise/events/weapon/%s_combat_weapon_chainsword_stuck_loop",
			powermaul_p2_m2 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop",
			powermaul_shield_p1_m2 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop",
			forcesword_p1_m2 = "wwise/events/weapon/%s_force_sword_stuck",
			chainaxe_p1_m1 = "wwise/events/weapon/%s_chainaxe_stuck_loop",
			chainsword_2h_p1_m1 = "wwise/events/weapon/%s_2h_chainsword_stuck_loop",
			chainsword_p1_m1 = "wwise/events/weapon/%s_combat_weapon_chainsword_stuck_loop",
			chainsword_2h_p1_m2 = "wwise/events/weapon/%s_2h_chainsword_stuck_loop",
			forcesword_p1_m3 = "wwise/events/weapon/%s_force_sword_stuck",
			forcesword_2h_p1_m2 = "wwise/events/weapon/%s_force_sword_stuck",
			powermaul_p2_m1 = "wwise/events/weapon/%s_powermaul_1h_stuck_loop"
		}
	},
	ranged_plasma_venting = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			plasmagun_p1_m1 = "wwise/events/weapon/%s_weapon_plasma_mech_vent"
		}
	},
	player_slide_loop = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {},
		events = {
			default = "wwise/events/player/%s_player_slide"
		}
	},
	weapon_special_loop = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			powersword_p1_m3 = "wwise/events/weapon/%s_power_sword_loop",
			forcesword_2h_p1_m1 = "wwise/events/weapon/%s_force_2h_sword_loop",
			forcesword_p1_m1 = "wwise/events/weapon/%s_force_sword_loop",
			powersword_p1_m1 = "wwise/events/weapon/%s_power_sword_loop",
			powermaul_shield_p1_m1 = "wwise/events/weapon/%s_electric_mace_shield_charge_loop",
			powermaul_p2_m2 = "wwise/events/weapon/%s_shockmaul_1h_p2_special_loop",
			thunderhammer_2h_p1_m1 = "wwise/events/weapon/%s_thunder_hammer_powered_loop",
			powermaul_2h_p1_m1 = "wwise/events/weapon/%s_ogryn_power_maul_1h_loop",
			thunderhammer_2h_p1_m2 = "wwise/events/weapon/%s_thunder_hammer_powered_loop",
			forcesword_p1_m2 = "wwise/events/weapon/%s_force_sword_loop",
			ogryn_powermaul_p1_m1 = "wwise/events/weapon/%s_ogryn_power_maul_1h_loop",
			powersword_2h_p1_m2 = "wwise/events/weapon/%s_power_sword_loop",
			powersword_p1_m2 = "wwise/events/weapon/%s_power_sword_loop",
			powermaul_shield_p1_m2 = "wwise/events/weapon/%s_electric_mace_shield_charge_loop",
			forcesword_p1_m3 = "wwise/events/weapon/%s_force_sword_loop",
			forcesword_2h_p1_m2 = "wwise/events/weapon/%s_force_2h_sword_loop",
			powersword_2h_p1_m1 = "wwise/events/weapon/%s_power_sword_loop",
			ogryn_powermaul_slabshield_p1_m1 = "wwise/events/weapon/%s_ogryn_power_maul_1h_loop",
			powermaul_p2_m1 = "wwise/events/weapon/%s_shockmaul_1h_p2_special_loop",
			powersword_2h_p1_m3 = "wwise/events/weapon/%s_power_sword_loop"
		}
	},
	weapon_overload_loop = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template",
			"stage"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			plasmagun_p1_m1 = {
				default = "wwise/events/weapon/%s_plasmagun_overheat",
				critical = "wwise/events/weapon/%s_plasmagun_overheat_intensity_03"
			}
		}
	},
	force_weapon_block_loop = {
		no_default = true,
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			forcesword_2h_p1_m2 = "wwise/events/weapon/%s_psyker_smite_charge",
			forcesword_2h_p1_m1 = "wwise/events/weapon/%s_psyker_smite_charge",
			forcesword_p1_m1 = "wwise/events/weapon/%s_psyker_smite_charge",
			forcesword_p1_m2 = "wwise/events/weapon/%s_psyker_smite_charge",
			forcesword_p1_m3 = "wwise/events/weapon/%s_psyker_smite_charge"
		}
	},
	wind_slash_stage_loop = {
		no_default = true,
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			forcesword_2h_p1_m1 = "wwise/events/weapon/%s_2h_forcesword_special_charge_ready_loop",
			forcesword_2h_p1_m2 = "wwise/events/weapon/%s_2h_forcesword_special_charge_ready_loop"
		}
	},
	interact_loop = {
		has_husk_events = false,
		has_stop_event = true,
		switch = {
			"interaction_type"
		},
		events = {
			rescue = "wwise/events/player/%s_player_interact_gen_loop",
			default = "wwise/events/player/%s_player_interact_gen_loop",
			revive = "wwise/events/player/%s_player_interact_gen_loop"
		}
	},
	equipped_item_passive = {
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			chainsword_p1_m1 = "wwise/events/weapon/%s_combat_weapon_chainsword",
			chainaxe_p1_m2 = "wwise/events/weapon/%s_chainaxe",
			chainsword_p1_m2 = "wwise/events/weapon/%s_combat_weapon_chainsword",
			powermaul_p1_m1 = "wwise/events/weapon/%s_powermaul_1h_idle",
			powermaul_shield_p1_m1 = "wwise/events/weapon/%s_powermaul_1h_idle",
			chainsword_2h_p1_m2 = "wwise/events/weapon/%s_2h_chainsword",
			powermaul_p1_m2 = "wwise/events/weapon/%s_powermaul_1h_idle",
			powermaul_p2_m2 = "wwise/events/weapon/%s_powermaul_1h_idle",
			powermaul_p2_m1 = "wwise/events/weapon/%s_powermaul_1h_idle",
			chainsword_2h_p1_m1 = "wwise/events/weapon/%s_2h_chainsword",
			psyker_throwing_knives = "wwise/events/weapon/%s_psyker_throwing_knife_idle",
			powermaul_shield_p1_m2 = "wwise/events/weapon/%s_powermaul_1h_idle",
			grimoire_pocketable = "wwise/events/player/%s_grimoire_loop",
			chainaxe_p1_m1 = "wwise/events/weapon/%s_chainaxe",
			zealot_relic = "wwise/events/player/%s_ability_zealot_bolstering_prayer_idle"
		}
	},
	conditional_equipped_item_passive = {
		has_husk_events = false,
		has_stop_event = true,
		switch = {
			"wielded_weapon_template"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			powermaul_shield_p1_m1 = "wwise/events/weapon/%s_electric_shield_fully_charged_loop",
			powermaul_shield_p1_m2 = "wwise/events/weapon/%s_electric_shield_fully_charged_loop"
		}
	},
	sfx_minigame_loop = {
		has_stop_event = true,
		switch = {
			"wielded_weapon_template",
			"loop_type"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/%s_device_auspex_scanner_minigame_loop",
			auspex_scanner = "wwise/events/player/%s_device_auspex_scanner_minigame_loop"
		}
	},
	sfx_minigame_sinus_loop = {
		has_stop_event = true,
		switch = {
			"wielded_weapon_template",
			"loop_type"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_background_loop",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_background_loop"
		}
	},
	sfx_minigame_sinus_loop_a = {
		has_stop_event = true,
		switch = {
			"wielded_weapon_template",
			"loop_type"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_loop_a",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_loop_a"
		}
	},
	sfx_minigame_sinus_loop_b = {
		has_stop_event = true,
		switch = {
			"wielded_weapon_template",
			"loop_type"
		},
		events = {
			default = "wwise/events/weapon/%s_weapon_silence",
			communications_hack_device_pocketable = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_loop_b",
			auspex_scanner = "wwise/events/player/play_device_auspex_scanner_minigame_sinus_loop_b"
		}
	},
	companion_attack_loop = {
		no_default = true,
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/%s_adamant_dog_vce_attack_loop_01",
				mix = "wwise/events/player/%s_adamant_dog_vce_attack_loop_01",
				normal = "wwise/events/player/%s_adamant_dog_vce_attack_loop_01"
			}
		}
	},
	companion_breath_loop = {
		no_default = true,
		has_husk_events = true,
		has_stop_event = true,
		switch = {
			"archetype",
			"dog_voice_profile"
		},
		events = {
			adamant = {
				cyber = "wwise/events/player/%s_adamant_dog_vce_breath_loop_01",
				mix = "wwise/events/player/%s_adamant_dog_vce_breath_loop_01",
				normal = "wwise/events/player/%s_adamant_dog_vce_breath_loop_01"
			}
		}
	}
}

local function _replace_event_values(t, string_value)
	for key, value in pairs(t) do
		local value_type = type(value)

		if value_type == "table" then
			_replace_event_values(value, string_value)
		elseif value_type == "string" then
			t[key] = string.format(value, string_value)
		end
	end
end

for alias, data in pairs(looping_events) do
	local play_data = table.clone(data)

	_replace_event_values(play_data.events, "play")

	play_data.has_stop_event = nil
	local play_alias = "play_" .. alias
	events[play_alias] = play_data

	if data.has_stop_event then
		local stop_data = table.clone(data)

		_replace_event_values(stop_data.events, "stop")

		stop_data.has_stop_event = nil
		local stop_alias = "stop_" .. alias
		events[stop_alias] = stop_data
	end
end

return events
