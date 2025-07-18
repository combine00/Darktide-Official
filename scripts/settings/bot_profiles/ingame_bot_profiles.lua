local BotSettings = require("scripts/settings/bot/bot_settings")
local behavior_gestalts = BotSettings.behavior_gestalts

local function ingame_bot_profiles(all_profiles)
	all_profiles.bot_1 = {
		gender = "male",
		selected_voice = "veteran_male_a",
		planet = "option_1",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_blonde_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_b_mustache_sideburns",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_green_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_04",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_23",
			slot_body_face = "content/items/characters/player/human/faces/male_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.075
		}
	}
	all_profiles.bot_2 = {
		gender = "male",
		selected_voice = "veteran_male_b",
		planet = "option_2",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_a_03",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_c_goattee_mustache",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_28",
			slot_body_face = "content/items/characters/player/human/faces/male_african_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_09"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.04
		}
	}
	all_profiles.bot_3 = {
		gender = "male",
		selected_voice = "veteran_male_c",
		planet = "option_3",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_buzzcut_c",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_a_goattee",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_01_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_hispanic_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_25",
			slot_body_face = "content/items/characters/player/human/faces/male_south_american_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.02
		}
	}
	all_profiles.bot_4 = {
		gender = "female",
		selected_voice = "veteran_female_a",
		planet = "option_4",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_e",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_c",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_01",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.97
		}
	}
	all_profiles.bot_5 = {
		gender = "female",
		selected_voice = "veteran_female_b",
		planet = "option_5",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_gray_03",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_a",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_22",
			slot_body_face = "content/items/characters/player/human/faces/female_african_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_04"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.95
		}
	}
	all_profiles.bot_6 = {
		gender = "female",
		selected_voice = "veteran_female_c",
		planet = "option_6",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_b",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_red_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_d",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.09
		}
	}
	all_profiles.low_bot_1 = {
		gender = "male",
		selected_voice = "veteran_male_a",
		planet = "option_1",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_blonde_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_b_mustache_sideburns",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_green_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_04",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_23",
			slot_body_face = "content/items/characters/player/human/faces/male_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.075
		}
	}
	all_profiles.low_bot_2 = {
		gender = "male",
		selected_voice = "veteran_male_b",
		planet = "option_2",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_a_03",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_c_goattee_mustache",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_28",
			slot_body_face = "content/items/characters/player/human/faces/male_african_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_09"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.04
		}
	}
	all_profiles.low_bot_3 = {
		gender = "male",
		selected_voice = "veteran_male_c",
		planet = "option_3",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_buzzcut_c",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_a_goattee",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_01_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_hispanic_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_25",
			slot_body_face = "content/items/characters/player/human/faces/male_south_american_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.02
		}
	}
	all_profiles.low_bot_4 = {
		gender = "female",
		selected_voice = "veteran_female_a",
		planet = "option_4",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_e",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_c",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_01",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.97
		}
	}
	all_profiles.low_bot_5 = {
		gender = "female",
		selected_voice = "veteran_female_b",
		planet = "option_5",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_gray_03",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_a",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_22",
			slot_body_face = "content/items/characters/player/human/faces/female_african_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_04"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.95
		}
	}
	all_profiles.low_bot_6 = {
		gender = "female",
		selected_voice = "veteran_female_c",
		planet = "option_6",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_b",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_red_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_d",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.09
		}
	}
	all_profiles.medium_bot_1 = {
		gender = "male",
		selected_voice = "veteran_male_a",
		planet = "option_1",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_blonde_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_b_mustache_sideburns",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_green_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_01",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_04",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_23",
			slot_body_face = "content/items/characters/player/human/faces/male_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_01",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.075
		}
	}
	all_profiles.medium_bot_2 = {
		gender = "male",
		selected_voice = "veteran_male_b",
		planet = "option_2",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_a_03",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_c_goattee_mustache",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_03",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_28",
			slot_body_face = "content/items/characters/player/human/faces/male_african_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_03",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_09"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.04
		}
	}
	all_profiles.medium_bot_3 = {
		gender = "male",
		selected_voice = "veteran_male_c",
		planet = "option_3",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_buzzcut_c",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_a_goattee",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_01_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_02",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_hispanic_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_25",
			slot_body_face = "content/items/characters/player/human/faces/male_south_american_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_02",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.02
		}
	}
	all_profiles.medium_bot_4 = {
		gender = "female",
		selected_voice = "veteran_female_a",
		planet = "option_4",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_e",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_c",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_04",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_01",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_04",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.97
		}
	}
	all_profiles.medium_bot_5 = {
		gender = "female",
		selected_voice = "veteran_female_b",
		planet = "option_5",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_gray_03",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_a",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_05",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_22",
			slot_body_face = "content/items/characters/player/human/faces/female_african_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_05",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_04"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.95
		}
	}
	all_profiles.medium_bot_6 = {
		gender = "female",
		selected_voice = "veteran_female_c",
		planet = "option_6",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_b",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_red_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_d",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_01_lvl_01_set_01",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_01_lvl_01_set_01",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.09
		}
	}
	all_profiles.high_bot_1 = {
		gender = "male",
		selected_voice = "veteran_male_a",
		planet = "option_1",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_blonde_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_b_mustache_sideburns",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_01_lvl_03_headgear_set_03",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_green_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_01",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_04",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_23",
			slot_body_face = "content/items/characters/player/human/faces/male_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_01",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.075
		}
	}
	all_profiles.high_bot_2 = {
		gender = "male",
		selected_voice = "veteran_male_b",
		planet = "option_2",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_a_03",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_c_goattee_mustache",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_01_lvl_03_headgear_set_03",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_03",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_28",
			slot_body_face = "content/items/characters/player/human/faces/male_african_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_03",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_09"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.04
		}
	}
	all_profiles.high_bot_3 = {
		gender = "male",
		selected_voice = "veteran_male_c",
		planet = "option_3",
		archetype = "veteran",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_buzzcut_c",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_a_goattee",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_02_lvl_03_headgear_set_02",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_01_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_02",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_hispanic_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_25",
			slot_body_face = "content/items/characters/player/human/faces/male_south_american_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_02",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.02
		}
	}
	all_profiles.high_bot_4 = {
		gender = "female",
		selected_voice = "veteran_female_a",
		planet = "option_4",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_e",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_c",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_01_lvl_04_headgear_set_01",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_04",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_01",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_04",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.97
		}
	}
	all_profiles.high_bot_5 = {
		gender = "female",
		selected_voice = "veteran_female_b",
		planet = "option_5",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_gray_03",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_a",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_01_lvl_03_headgear_set_03",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_05",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_22",
			slot_body_face = "content/items/characters/player/human/faces/female_african_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_05",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_04"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.95
		}
	}
	all_profiles.high_bot_6 = {
		gender = "female",
		selected_voice = "veteran_female_c",
		planet = "option_6",
		archetype = "veteran",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_b",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_red_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_d",
			slot_gear_head = "content/items/characters/player/human/gear_head/veteran_career_01_lvl_03_headgear_set_02",
			slot_secondary = "content/items/weapons/player/ranged/high_bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/veteran_upperbody_career_02_lvl_02_set_01",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/veteran_lowerbody_career_02_lvl_02_set_01",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.09
		}
	}
	all_profiles.bot_adamant_ma = {
		gender = "male",
		selected_voice = "adamant_male_a",
		planet = "option_1",
		archetype = "adamant",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_blonde_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_b_mustache_sideburns",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_green_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_04",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_23",
			slot_body_face = "content/items/characters/player/human/faces/male_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.075
		}
	}
	all_profiles.bot_adamant_mb = {
		gender = "male",
		selected_voice = "adamant_male_b",
		planet = "option_2",
		archetype = "adamant",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_a_03",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_c_goattee_mustache",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p1",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_28",
			slot_body_face = "content/items/characters/player/human/faces/male_african_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_09"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.04
		}
	}
	all_profiles.bot_adamant_mc = {
		gender = "male",
		selected_voice = "adamant_male_c",
		planet = "option_3",
		archetype = "adamant",
		name_list_id = "male_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_buzzcut_c",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_black_01",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/facial_hair_a_goattee",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_autogun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_01_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_hispanic_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_10",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_25",
			slot_body_face = "content/items/characters/player/human/faces/male_south_american_face_02",
			slot_body_arms = "content/items/characters/player/human/attachment_base/male_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.02
		}
	}
	all_profiles.bot_adamant_fa = {
		gender = "female",
		selected_voice = "adamant_female_a",
		planet = "option_4",
		archetype = "adamant",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_e",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_brown_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_c",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combatsword_linesman_p2",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_caucasian_01",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/body_tattoo_01",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_01",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_01"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.97
		}
	}
	all_profiles.bot_adamant_fb = {
		gender = "female",
		selected_voice = "adamant_female_b",
		planet = "option_5",
		archetype = "adamant",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_c_02",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_gray_03",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_a",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_laspistol_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_brown_02_blind_left",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_d",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_african_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/scar_face_22",
			slot_body_face = "content/items/characters/player/human/faces/female_african_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_d",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_04"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 0.95
		}
	}
	all_profiles.bot_adamant_fc = {
		gender = "female",
		selected_voice = "adamant_female_c",
		planet = "option_6",
		archetype = "adamant",
		name_list_id = "female_names_1",
		current_level = 1,
		loadout = {
			slot_body_hair = "content/items/characters/player/human/hair/hair_short_modular_b",
			slot_body_hair_color = "content/items/characters/player/hair_colors/hair_color_red_02",
			slot_body_face_hair = "content/items/characters/player/human/face_hair/female_facial_hair_d",
			slot_gear_head = "content/items/characters/player/human/gear_head/empty_headgear",
			slot_secondary = "content/items/weapons/player/ranged/bot_lasgun_killshot",
			slot_body_eye_color = "content/items/characters/player/eye_colors/eye_color_blue_01",
			slot_body_torso = "content/items/characters/player/human/gear_torso/empty_torso",
			slot_primary = "content/items/weapons/player/melee/bot_combataxe_linesman",
			slot_gear_upperbody = "content/items/characters/player/human/gear_upperbody/prisoner_upperbody_c",
			slot_body_skin_color = "content/items/characters/player/skin_colors/skin_color_pale_02",
			slot_body_legs = "content/items/characters/player/human/gear_legs/empty_legs",
			slot_body_tattoo = "content/items/characters/player/human/body_tattoo/empty_body_tattoo",
			slot_body_face_scar = "content/items/characters/player/human/face_scars/empty_face_scar",
			slot_body_face = "content/items/characters/player/human/faces/female_caucasian_face_04",
			slot_body_arms = "content/items/characters/player/human/attachment_base/female_arms",
			slot_gear_lowerbody = "content/items/characters/player/human/gear_lowerbody/prisoner_lowerbody_c",
			slot_body_face_tattoo = "content/items/characters/player/human/face_tattoo/face_tattoo_05"
		},
		bot_gestalts = {
			melee = behavior_gestalts.linesman,
			ranged = behavior_gestalts.killshot
		},
		talents = {},
		personal = {
			character_height = 1.09
		}
	}
end

return ingame_bot_profiles
