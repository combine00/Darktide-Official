local ActionSweepSettings = require("scripts/settings/equipment/action_sweep_settings")
local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HitZone = require("scripts/utilities/attack/hit_zone")
local MeleeActionInputSetupFast = require("scripts/settings/equipment/weapon_templates/melee_action_input_setup_fast")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokeCombatswordP3 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_combatsword_p3")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local WoundsSettings = require("scripts/settings/wounds/wounds_settings")
local damage_types = DamageSettings.damage_types
local armor_types = ArmorSettings.types
local buff_stat_buffs = BuffSettings.stat_buffs
local hit_zone_names = HitZone.hit_zone_names
local buff_stat_buffs = BuffSettings.stat_buffs
local buff_targets = WeaponTweakTemplateSettings.buff_targets
local damage_types = DamageSettings.damage_types
local default_hit_zone_priority = ActionSweepSettings.default_hit_zone_priority
local template_types = WeaponTweakTemplateSettings.template_types
local wield_inputs = PlayerCharacterConstants.wield_inputs
local wounds_shapes = WoundsSettings.shapes
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local recoil_trait_templates = WeaponTraitTemplates[template_types.recoil]
local spread_trait_templates = WeaponTraitTemplates[template_types.spread]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local stamina_trait_templates = WeaponTraitTemplates[template_types.stamina]
local ammo_trait_templates = WeaponTraitTemplates[template_types.ammo]
local sway_trait_templates = WeaponTraitTemplates[template_types.sway]
local toughness_trait_templates = WeaponTraitTemplates[template_types.toughness]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local weapon_template = {}
local action_inputs = table.clone(MeleeActionInputSetupFast.action_inputs)
action_inputs.parry = {
	buffer_time = 0
}
local action_input_hierarchy = table.clone(MeleeActionInputSetupFast.action_input_hierarchy)
action_input_hierarchy[#action_input_hierarchy + 1] = {
	transition = "base",
	input = "parry"
}
weapon_template.action_inputs = action_inputs
weapon_template.action_input_hierarchy = action_input_hierarchy
local default_weapon_box = {
	0.15,
	0.15,
	1.15
}
local hit_zone_priority = {
	[hit_zone_names.head] = 1,
	[hit_zone_names.torso] = 2,
	[hit_zone_names.upper_left_arm] = 3,
	[hit_zone_names.upper_right_arm] = 3,
	[hit_zone_names.upper_left_leg] = 3,
	[hit_zone_names.upper_right_leg] = 3
}

table.add_missing(hit_zone_priority, default_hit_zone_priority)

weapon_template.actions = {
	action_unwield = {
		allowed_during_sprint = true,
		start_input = "wield",
		uninterruptible = true,
		kind = "unwield",
		total_time = 0,
		allowed_chain_actions = {}
	},
	action_wield = {
		kind = "wield",
		allowed_during_sprint = true,
		uninterruptible = true,
		anim_event = "equip",
		sprint_ready_up_time = 0,
		total_time = 0.1,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left"
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_attack_special"
			}
		}
	},
	action_melee_start_left = {
		anim_event_3p = "heavy_charge_stab_left",
		anim_end_event = "attack_finished",
		start_input = "start_attack",
		kind = "windup",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_stab_left",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.65,
				t = 0.05
			},
			{
				modifier = 0.7,
				t = 0.1
			},
			{
				modifier = 0.9,
				t = 0.25
			},
			{
				modifier = 0.75,
				t = 0.4
			},
			{
				modifier = 0.78,
				t = 0.5
			},
			{
				modifier = 0.835,
				t = 0.55
			},
			{
				modifier = 0.95,
				t = 3
			},
			start_modifier = 0.75
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			light_attack = {
				action_name = "action_left_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.5
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_attack_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_left_light = {
		damage_window_start = 0.16666666666666666,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		weapon_handling_template = "time_scale_1",
		max_num_saved_entries = 20,
		range_mod = 1.25,
		num_frames_before_process = 2,
		allowed_during_sprint = true,
		damage_window_end = 0.23333333333333334,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_up_left",
		anim_event = "attack_left_diagonal_up",
		hit_stop_anim = "attack_hit",
		total_time = 1,
		action_movement_curve = {
			{
				modifier = 0.7,
				t = 0.05
			},
			{
				modifier = 1.3,
				t = 0.1
			},
			{
				modifier = 1.5,
				t = 0.25
			},
			{
				modifier = 1.5,
				t = 0.3
			},
			{
				modifier = 1.25,
				t = 0.35
			},
			{
				modifier = 0.8,
				t = 0.5
			},
			{
				modifier = 0.65,
				t = 0.6
			},
			{
				modifier = 0.8,
				t = 0.7
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.5
		},
		allowed_chain_actions = {
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.34
			},
			block = {
				action_name = "action_block",
				chain_time = 0
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.34
			},
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions()
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/attack_left_diagonal_up",
			anchor_point_offset = {
				-0.075,
				0,
				-0.075
			}
		},
		damage_profile = DamageProfileTemplates.light_combatsword_linesman_p3,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		wounds_shape = wounds_shapes.left_45_slash_clean
	},
	action_left_heavy = {
		damage_window_start = 0.04,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		first_person_hit_anim = "hit_stop",
		range_mod = 1.25,
		allowed_during_sprint = true,
		attack_direction_override = "push",
		power_level = 500,
		damage_window_end = 0.12,
		anim_end_event = "attack_finished",
		anim_event_3p = "heavy_attack_stab_left",
		anim_event = "heavy_attack_stab_left",
		hit_stop_anim = "attack_hit_stab",
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.3,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.4
			},
			{
				modifier = 0.5,
				t = 0.6
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 1.5
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.24
			},
			block = {
				chain_time = 0.4,
				action_name = "action_block",
				chain_until = 0.1
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.24
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/heavy_attack_stab_01",
			anchor_point_offset = {
				0.15,
				0,
				-0.075
			}
		},
		damage_profile = DamageProfileTemplates.heavy_combatsword_smiter_stab,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		wounds_shape = wounds_shapes.default
	},
	action_melee_start_right = {
		allowed_during_sprint = true,
		anim_end_event = "attack_finished",
		kind = "windup",
		anim_event_3p = "heavy_charge_stab_right",
		anim_event = "heavy_charge_stab_right",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.65,
				t = 0.05
			},
			{
				modifier = 0.7,
				t = 0.1
			},
			{
				modifier = 0.9,
				t = 0.25
			},
			{
				modifier = 0.85,
				t = 0.4
			},
			{
				modifier = 0.85,
				t = 0.5
			},
			{
				modifier = 0.835,
				t = 0.55
			},
			{
				modifier = 0.95,
				t = 3
			},
			start_modifier = 0.75
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			light_attack = {
				action_name = "action_right_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_right_heavy",
				chain_time = 0.375
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_attack_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_right_light = {
		damage_window_start = 0.20833333333333334,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		max_num_saved_entries = 20,
		range_mod = 1.25,
		num_frames_before_process = 2,
		allowed_during_sprint = true,
		damage_window_end = 0.2833333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_right_diagonal",
		anim_event = "attack_right_diagonal_down",
		hit_stop_anim = "attack_hit",
		total_time = 1,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.2
			},
			{
				modifier = 1.05,
				t = 0.35
			},
			{
				modifier = 0.7,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 0.55,
				t = 0.6
			},
			{
				modifier = 0.7,
				t = 0.8
			},
			{
				modifier = 0.975,
				t = 0.85
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.9
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.33
			},
			block = {
				action_name = "action_block",
				chain_time = 0
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.33
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/attack_right_diagonal_down_baked_sweep",
			anchor_point_offset = {
				-0.05,
				0,
				-0.075
			}
		},
		damage_profile = DamageProfileTemplates.light_combatsword_linesman_p3,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		wounds_shape = wounds_shapes.right_45_slash_clean
	},
	action_right_heavy = {
		damage_window_start = 0.1,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		first_person_hit_anim = "hit_stop",
		range_mod = 1.25,
		allowed_during_sprint = true,
		power_level = 500,
		attack_direction_override = "push",
		damage_window_end = 0.3,
		anim_end_event = "attack_finished",
		anim_event_3p = "heavy_attack_stab_right",
		anim_event = "heavy_attack_stab_right",
		hit_stop_anim = "attack_hit_stab",
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.3,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.4
			},
			{
				modifier = 0.5,
				t = 0.6
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 1.5
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.3
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.4
			},
			block = {
				chain_time = 0.45,
				action_name = "action_block",
				chain_until = 0.05
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.3
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/heavy_attack_stab_02",
			anchor_point_offset = {
				0.05,
				0,
				-0.05
			}
		},
		damage_profile = DamageProfileTemplates.heavy_combatsword_smiter_stab,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		wounds_shape = wounds_shapes.default
	},
	action_melee_start_left_2 = {
		allowed_during_sprint = true,
		hit_armor_anim = "attack_hit_shield",
		kind = "windup",
		anim_end_event = "attack_finished",
		anim_event_3p = "heavy_charge_stab_left",
		anim_event = "heavy_charge_stab_left",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.65,
				t = 0.05
			},
			{
				modifier = 0.7,
				t = 0.1
			},
			{
				modifier = 0.9,
				t = 0.25
			},
			{
				modifier = 0.85,
				t = 0.4
			},
			{
				modifier = 0.85,
				t = 0.5
			},
			{
				modifier = 0.835,
				t = 0.55
			},
			{
				modifier = 0.95,
				t = 3
			},
			start_modifier = 0.75
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			light_attack = {
				action_name = "action_left_light_2",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.46
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.35
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_left_light_2 = {
		damage_window_start = 0.24166666666666667,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.25,
		kind = "sweep",
		max_num_saved_entries = 20,
		weapon_handling_template = "time_scale_1",
		num_frames_before_process = 2,
		allowed_during_sprint = true,
		damage_window_end = 0.31666666666666665,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left_diagonal",
		anim_event = "attack_left_diagonal_down",
		hit_stop_anim = "attack_hit",
		total_time = 1,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.2
			},
			{
				modifier = 1.05,
				t = 0.35
			},
			{
				modifier = 0.7,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 0.55,
				t = 0.6
			},
			{
				modifier = 0.7,
				t = 0.8
			},
			{
				modifier = 0.975,
				t = 0.85
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.9
		},
		allowed_chain_actions = {
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.52
			},
			block = {
				action_name = "action_block",
				chain_time = 0
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.4
			},
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions()
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/attack_left_diagonal_down_baked_sweep",
			anchor_point_offset = {
				0.05,
				0,
				-0.025
			}
		},
		damage_profile = DamageProfileTemplates.light_combatsword_linesman_p3,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		wounds_shape = wounds_shapes.left_45_slash_clean
	},
	action_block = {
		anim_event = "parry_pose",
		start_input = "block",
		anim_end_event = "parry_finished",
		kind = "block",
		stop_input = "block_release",
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.2
			},
			{
				modifier = 0.82,
				t = 0.3
			},
			{
				modifier = 0.8,
				t = 0.325
			},
			{
				modifier = 0.81,
				t = 0.35
			},
			{
				modifier = 0.85,
				t = 0.5
			},
			{
				modifier = 0.85,
				t = 1
			},
			{
				modifier = 0.8,
				t = 2
			},
			start_modifier = 1
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			wield = {
				action_name = "action_unwield"
			},
			push = {
				action_name = "action_push"
			},
			special_action = {
				action_name = "action_attack_special"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions()
		}
	},
	action_attack_special = {
		damage_window_start = 0.13333333333333333,
		hit_armor_anim = "attack_hit_shield",
		start_input = "special_action",
		kind = "sweep",
		first_person_hit_anim = "hit_stop",
		range_mod = 1.25,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "push",
		allowed_during_sprint = true,
		damage_window_end = 0.18333333333333332,
		power_level = 500,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_stab",
		anim_event = "attack_special_stab",
		hit_stop_anim = "attack_hit_stab",
		total_time = 1,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.15
			},
			start_modifier = 1
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.3
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.2
			},
			block = {
				action_name = "action_block",
				chain_time = 0.65
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.7
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/attack_stab_special_01",
			anchor_point_offset = {
				0,
				0,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.light_combatsword_p3_stab,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_right_light_pushfollow = {
		damage_window_start = 0.19166666666666668,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		max_num_saved_entries = 20,
		range_mod = 1.25,
		num_frames_before_process = 2,
		allowed_during_sprint = true,
		damage_window_end = 0.26666666666666666,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_up_right",
		anim_event = "attack_right_diagonal_up",
		hit_stop_anim = "attack_hit",
		total_time = 2,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.2
			},
			start_modifier = 1
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block",
				chain_time = 0.55
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.4
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = default_weapon_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/sabre/attack_right_diagonal_up",
			anchor_point_offset = {
				0.3,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.light_combatsword_pushfollowup_linesman_p3,
		damage_type = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_push = {
		push_radius = 2.5,
		block_duration = 0.5,
		kind = "push",
		anim_event = "attack_push",
		total_time = 1,
		action_movement_curve = {
			{
				modifier = 1.4,
				t = 0.1
			},
			{
				modifier = 0.5,
				t = 0.25
			},
			{
				modifier = 0.5,
				t = 0.4
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 1.4
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			push_follow_up = {
				action_name = "action_right_light_pushfollow",
				chain_time = 0.25
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.5
			},
			block = {
				action_name = "action_block",
				chain_time = 0.3
			},
			special_action = {
				action_name = "action_attack_special",
				chain_time = 0.3
			}
		},
		inner_push_rad = math.pi * 0.1,
		outer_push_rad = math.pi * 1,
		inner_damage_profile = DamageProfileTemplates.ninja_push,
		inner_damage_type = damage_types.physical,
		outer_damage_profile = DamageProfileTemplates.light_push,
		outer_damage_type = damage_types.physical,
		haptic_trigger_template = HapticTriggerTemplates.melee.push
	},
	action_inspect = {
		skip_3p_anims = false,
		lock_view = true,
		start_input = "inspect_start",
		anim_end_event = "inspect_end",
		kind = "inspect",
		anim_event = "inspect_start",
		stop_input = "inspect_stop",
		total_time = math.huge,
		crosshair = {
			crosshair_type = "inspect"
		}
	}
}

table.add_missing(weapon_template.actions, BaseTemplateSettings.actions)

weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/sabre"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/sabre"
weapon_template.weapon_box = {
	0.1,
	0.7,
	0.02
}
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = false
}
weapon_template.sprint_ready_up_time = 0.3
weapon_template.max_first_person_anim_movement_speed = 5.8
weapon_template.damage_window_start_sweep_trail_offset = -0.65
weapon_template.damage_window_end_sweep_trail_offset = 0.65
weapon_template.ammo_template = "no_ammo"
weapon_template.fx_sources = {
	_block = "fx_block",
	_sweep = "fx_sweep"
}
weapon_template.crosshair = {
	crosshair_type = "dot"
}
weapon_template.hit_marker_type = "center"
weapon_template.keywords = {
	"melee",
	"combat_sword",
	"p3"
}
weapon_template.dodge_template = "ninjafencer"
weapon_template.sprint_template = "ninja_l"
weapon_template.stamina_template = "ninjafencer"
weapon_template.toughness_template = "default"
weapon_template.movement_curve_modifier_template = "combataxe_p1_m1"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.default
weapon_template.smart_targeting_template = SmartTargetingTemplates.default_melee
weapon_template.haptic_trigger_template = HapticTriggerTemplates.melee.light
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	combatsword_p3_m2_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_left_light = {
				damage_trait_templates.combatsword_dps_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								power_distribution = {
									attack = {
										display_name = "loc_weapon_stats_display_base_damage"
									}
								}
							}
						}
					}
				}
			},
			action_left_heavy = {
				damage_trait_templates.combatsword_dps_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								power_distribution = {
									attack = {
										display_name = "loc_weapon_stats_display_base_damage"
									}
								}
							}
						}
					}
				}
			},
			action_right_light = {
				damage_trait_templates.combatsword_dps_stat
			},
			action_right_heavy = {
				damage_trait_templates.combatsword_dps_stat
			},
			action_left_light_2 = {
				damage_trait_templates.combatsword_dps_stat
			},
			action_attack_special = {
				damage_trait_templates.combatsword_dps_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.combatsword_dps_stat
			}
		}
	},
	combatsword_p3_m2_finesse_stat = {
		display_name = "loc_stats_display_finesse_stat",
		is_stat_trait = true,
		damage = {
			action_left_light = {
				damage_trait_templates.combatsword_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								boost_curve_multiplier_finesse = {}
							}
						}
					}
				}
			},
			action_left_heavy = {
				damage_trait_templates.combatsword_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								boost_curve_multiplier_finesse = {}
							}
						}
					}
				}
			},
			action_right_light = {
				damage_trait_templates.combatsword_finesse_stat
			},
			action_right_heavy = {
				damage_trait_templates.combatsword_finesse_stat
			},
			action_left_light_2 = {
				damage_trait_templates.combatsword_finesse_stat
			},
			action_attack_special = {
				damage_trait_templates.combatsword_finesse_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.combatsword_finesse_stat
			}
		},
		weapon_handling = {
			action_left_light = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						__all_basic_stats = true
					}
				}
			},
			action_left_heavy = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						__all_basic_stats = true
					}
				}
			},
			action_right_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_right_heavy = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_light_2 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_attack_special = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_right_light_pushfollow = {
				weapon_handling_trait_templates.default_finesse_stat
			}
		}
	},
	combatsword_p3_m2_armor_pierce_stat = {
		display_name = "loc_stats_display_ap_stat",
		is_stat_trait = true,
		damage = {
			action_left_light = {
				damage_trait_templates.default_armor_pierce_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								armor_damage_modifier = {
									attack = WeaponBarUIDescriptionTemplates.armor_damage_modifiers
								}
							}
						}
					}
				}
			},
			action_left_heavy = {
				damage_trait_templates.default_armor_pierce_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								armor_damage_modifier = {
									attack = WeaponBarUIDescriptionTemplates.armor_damage_modifiers
								}
							}
						}
					}
				}
			},
			action_right_light = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_right_heavy = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_left_light_2 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_attack_special = {
				damage_trait_templates.default_armor_pierce_stat
			}
		}
	},
	combatsword_p3_m2_cleave_damage_stat = {
		display_name = "loc_stats_display_cleave_damage_stat",
		is_stat_trait = true,
		damage = {
			action_left_light = {
				damage_trait_templates.combatsword_cleave_damage_stat,
				display_data = {
					display_stats = {
						armor_damage_modifier = {
							attack = {
								[armor_types.armored] = {
									display_name = "loc_weapon_stats_display_cleave_armored"
								},
								[armor_types.unarmored] = {
									display_name = "loc_weapon_stats_display_cleave_unarmored"
								},
								[armor_types.disgustingly_resilient] = {
									display_name = "loc_weapon_stats_display_cleave_disgustingly_resilient"
								}
							}
						}
					}
				}
			},
			action_left_heavy = {
				damage_trait_templates.combatsword_cleave_damage_stat
			},
			action_right_light = {
				damage_trait_templates.combatsword_cleave_damage_stat
			},
			action_right_heavy = {
				damage_trait_templates.combatsword_cleave_damage_stat
			},
			action_left_light_2 = {
				damage_trait_templates.combatsword_cleave_damage_stat
			},
			action_attack_special = {
				damage_trait_templates.combatsword_cleave_damage_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.combatsword_cleave_damage_stat
			}
		}
	},
	combatsword_p3_m2_mobility_stat = {
		display_name = "loc_stats_display_mobility_stat",
		is_stat_trait = true,
		dodge = {
			base = {
				dodge_trait_templates.default_dodge_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		},
		sprint = {
			base = {
				sprint_trait_templates.default_sprint_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		},
		movement_curve_modifier = {
			base = {
				movement_curve_modifier_trait_templates.default_movement_curve_modifier_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		}
	}
}
weapon_template.traits = {}
local bespoke_combatsword_p3_traits = table.ukeys(WeaponTraitsBespokeCombatswordP3)

table.append(weapon_template.traits, bespoke_combatsword_p3_traits)

weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_very_fast_attack",
		description = "loc_weapon_stats_display_very_fast_attack_desc"
	},
	{
		display_name = "loc_weapon_keyword_ninja_fencer",
		description = "loc_weapon_stats_display_ninja_fencer_desc"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		display_name = "loc_gestalt_ninja_fencer",
		type = "ninja_fencer",
		attack_chain = {
			"ninja_fencer",
			"ninja_fencer",
			"ninja_fencer"
		}
	},
	secondary = {
		display_name = "loc_gestalt_smiter",
		type = "smiter",
		attack_chain = {
			"smiter",
			"smiter"
		}
	},
	special = {
		desc = "loc_stats_special_action_special_attack_combatsword_p3m1_desc",
		display_name = "loc_weapon_special_special_attack",
		type = "special_attack"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			icon = "ninja_fencer",
			value_func = "primary_attack",
			header = "light"
		},
		{
			icon = "smiter",
			value_func = "secondary_attack",
			header = "heavy"
		}
	},
	weapon_special = {
		icon = "special_attack",
		header = "special_attack"
	}
}
weapon_template.special_action_name = "action_attack_special"

return weapon_template
