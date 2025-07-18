local ActionSweepSettings = require("scripts/settings/equipment/action_sweep_settings")
local AimAssistTemplates = require("scripts/settings/equipment/aim_assist_templates")
local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HerdingTemplates = require("scripts/settings/damage/herding_templates")
local HitZone = require("scripts/utilities/attack/hit_zone")
local MeleeActionInputSetupSlow = require("scripts/settings/equipment/weapon_templates/melee_action_input_setup_slow")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local PushSettings = require("scripts/settings/damage/push_settings")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokePowesword2hP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_powersword_2h_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local WoundsSettings = require("scripts/settings/wounds/wounds_settings")
local damage_types = DamageSettings.damage_types
local default_hit_zone_priority = ActionSweepSettings.default_hit_zone_priority
local hit_zone_names = HitZone.hit_zone_names
local template_types = WeaponTweakTemplateSettings.template_types
local armor_types = ArmorSettings.types
local buff_stat_buffs = BuffSettings.stat_buffs
local push_templates = PushSettings.push_templates
local buff_targets = WeaponTweakTemplateSettings.buff_targets
local wield_inputs = PlayerCharacterConstants.wield_inputs
local wounds_shapes = WoundsSettings.shapes
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local stamina_trait_templates = WeaponTraitTemplates[template_types.stamina]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local charge_trait_templates = WeaponTraitTemplates[template_types.charge]
local weapon_template = {
	action_inputs = table.clone(MeleeActionInputSetupSlow.action_inputs)
}
weapon_template.action_inputs.special_action.buffer_time = 0.5
weapon_template.action_input_hierarchy = table.clone(MeleeActionInputSetupSlow.action_input_hierarchy)
local hit_zone_priority_torso = {
	[hit_zone_names.head] = 1,
	[hit_zone_names.torso] = 2,
	[hit_zone_names.weakspot] = 1,
	[hit_zone_names.upper_left_arm] = 3,
	[hit_zone_names.upper_right_arm] = 3,
	[hit_zone_names.upper_left_leg] = 3,
	[hit_zone_names.upper_right_leg] = 3
}

table.add_missing(hit_zone_priority_torso, default_hit_zone_priority)

local light_hitbox = {
	0.2,
	0.15,
	1.15
}
local heavy_hitbox = {
	0.4,
	0.15,
	1.15
}
weapon_template.allowed_inputs_in_sprint = {
	special_action = true,
	wield = true,
	combat_ability = true,
	start_attack = true
}
weapon_template.actions = {
	action_unwield = {
		allowed_during_sprint = true,
		start_input = "wield",
		uninterruptible = true,
		kind = "unwield",
		total_time = 0,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			}
		}
	},
	action_wield = {
		kind = "wield",
		allowed_during_sprint = true,
		uninterruptible = true,
		anim_event = "equip",
		total_time = 0.3,
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
				action_name = "action_weapon_special_left"
			}
		}
	},
	action_melee_start_left = {
		chain_anim_event_3p = "heavy_charge_down_left",
		chain_anim_event = "heavy_charge_down_left",
		start_input = "start_attack",
		kind = "windup",
		anim_end_event = "attack_finished",
		action_priority = 1,
		allowed_during_sprint = true,
		anim_event = "heavy_charge_down_left",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.05
			},
			{
				modifier = 0.95,
				t = 0.1
			},
			{
				modifier = 0.68,
				t = 0.25
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.65,
				t = 0.5
			},
			{
				modifier = 0.635,
				t = 0.55
			},
			{
				modifier = 0.3,
				t = 1.2
			},
			{
				modifier = 0.1,
				t = 3
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
			light_attack = {
				action_name = "action_light_1"
			},
			heavy_attack = {
				action_name = "action_heavy_1",
				chain_time = 0.62
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_weapon_special_left"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_melee_start_sprint = {
		anim_event_3p = "heavy_charge_stab",
		chain_anim_event = "heavy_charge_stab",
		start_input = "start_attack",
		kind = "windup",
		sprint_requires_press_to_interrupt = true,
		action_priority = 2,
		invalid_start_action_for_stat_calculation = true,
		allowed_during_sprint = true,
		chain_anim_event_3p = "heavy_charge_stab",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_charge_stab_01",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.1
			},
			{
				modifier = 0.9,
				t = 0.25
			},
			{
				modifier = 1.25,
				t = 0.5
			},
			{
				modifier = 1.15,
				t = 0.9
			},
			{
				modifier = 1.05,
				t = 1.5
			},
			{
				modifier = 1,
				t = 2
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
			light_attack = {
				action_name = "action_sprint_light",
				chain_time = 0.15
			},
			heavy_attack = {
				action_name = "action_sprint_heavy_stab",
				chain_time = 0.62
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.sprint_character_state_component.is_sprinting
		end
	},
	action_melee_start_slide = {
		anim_event_3p = "heavy_charge_stab",
		chain_anim_event = "heavy_charge_down_left_pose",
		start_input = "start_attack",
		kind = "windup",
		sprint_requires_press_to_interrupt = true,
		action_priority = 3,
		invalid_start_action_for_stat_calculation = true,
		allowed_during_sprint = true,
		chain_anim_event_3p = "heavy_charge_left",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_charge_stab_01",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 1.1,
				t = 0.1
			},
			{
				modifier = 1.3,
				t = 0.25
			},
			{
				modifier = 1,
				t = 3
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
			light_attack = {
				action_name = "action_sprint_light",
				chain_time = 0.15
			},
			heavy_attack = {
				action_name = "action_sprint_heavy_stab",
				chain_time = 0.62
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_weapon_special_sprint"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.movement_state_component.method == "sliding"
		end
	},
	action_light_1 = {
		damage_window_start = 0.31666666666666665,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_0_9",
		kind = "sweep",
		attack_direction_override = "left",
		allowed_during_sprint = true,
		damage_window_end = 0.43333333333333335,
		special_active_hit_stop_anim = "attack_hit",
		first_person_hit_anim = "hit_left_shake",
		anim_end_event = "attack_finished",
		range_mod = 1.2,
		anim_event_3p = "attack_left",
		anim_event = "attack_left",
		hit_stop_anim = "attack_hit",
		total_time = 1.3,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 1.05,
				t = 0.35
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.6,
				t = 0.45
			},
			{
				modifier = 0.6,
				t = 0.6
			},
			{
				modifier = 1,
				t = 0.7
			},
			{
				modifier = 1.05,
				t = 0.75
			},
			{
				modifier = 1.04,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
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
				action_name = "action_melee_start_right",
				chain_time = 0.68
			},
			block = {
				chain_time = 0.55,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_right",
				chain_time = 0.55
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority_torso,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/attack_left",
			anchor_point_offset = {
				0,
				0.2,
				-0.25
			}
		},
		damage_profile = DamageProfileTemplates.light_powersword_2h,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.light_powersword_2h_active,
		herding_template = HerdingTemplates.thunder_hammer_left_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing,
		wounds_shape = wounds_shapes.horizontal_slash_clean,
		wounds_shape_special_active = wounds_shapes.horizontal_slash
	},
	action_heavy_1 = {
		damage_window_start = 0.2,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.3,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "push",
		anim_event_3p = "heavy_attack_down",
		allowed_during_sprint = true,
		kind = "sweep",
		damage_window_end = 0.2833333333333333,
		first_person_hit_anim = "hit_left_shake",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_attack_left_down",
		hit_stop_anim = "attack_hit",
		total_time = 1.75,
		action_movement_curve = {
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.25
			},
			{
				modifier = 1.3,
				t = 0.35
			},
			{
				modifier = 1.25,
				t = 0.45
			},
			{
				modifier = 0.5,
				t = 0.47
			},
			{
				modifier = 0.45,
				t = 0.6
			},
			{
				modifier = 0.45,
				t = 0.65
			},
			{
				modifier = 0.9,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.4
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
				chain_time = 0.68
			},
			block = {
				chain_time = 0.68,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_right",
				chain_time = 0.68
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/heavy_attack_left_down",
			anchor_point_offset = {
				0.2,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.powersword_2h_heavy_smiter,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.powersword_2h_heavy_smiter_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing_heavy,
		wounds_shape = wounds_shapes.vertical_slash_clean,
		wounds_shape_special_active = wounds_shapes.vertical_slash
	},
	action_sprint_light = {
		damage_window_start = 0.3,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1_2",
		kind = "sweep",
		attack_direction_override = "left",
		allowed_during_sprint = true,
		range_mod = 1.25,
		first_person_hit_anim = "hit_left_shake",
		damage_window_end = 0.5333333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_left_diagonal_up",
		anim_event = "attack_left_diagonal_up",
		hit_stop_anim = "attack_hit",
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 1.05,
				t = 0.35
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.6,
				t = 0.45
			},
			{
				modifier = 0.6,
				t = 0.6
			},
			{
				modifier = 0.9,
				t = 0.7
			},
			{
				modifier = 0.95,
				t = 0.75
			},
			{
				modifier = 0.94,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
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
				action_name = "action_melee_start_right",
				chain_time = 0.59
			},
			block = {
				chain_time = 0.54,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_right",
				chain_time = 0.54
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/attack_left_diagonal_up",
			anchor_point_offset = {
				0,
				0.1,
				-0.5
			}
		},
		damage_profile = DamageProfileTemplates.light_powersword_2h,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.light_powersword_2h_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing,
		wounds_shape = wounds_shapes.right_45_slash_clean,
		wounds_shape_special_active = wounds_shapes.horizontal_slash
	},
	action_sprint_heavy_stab = {
		damage_window_start = 0.1,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.35,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "push",
		anim_event_3p = "heavy_attack_stab",
		allowed_during_sprint = true,
		kind = "sweep",
		damage_window_end = 0.23333333333333334,
		first_person_hit_anim = "hit_left_shake",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_attack_stab",
		hit_stop_anim = "attack_hit",
		total_time = 1.75,
		action_movement_curve = {
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.25
			},
			{
				modifier = 1.3,
				t = 0.35
			},
			{
				modifier = 1.25,
				t = 0.45
			},
			{
				modifier = 0.5,
				t = 0.47
			},
			{
				modifier = 0.45,
				t = 0.6
			},
			{
				modifier = 0.45,
				t = 0.65
			},
			{
				modifier = 0.9,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.4
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
				action_name = "action_melee_start_left",
				chain_time = 0.68
			},
			block = {
				chain_time = 0.68,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_stab",
				chain_time = 0.68
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.22,
			0.17,
			1.22
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/heavy_attack_stab",
			anchor_point_offset = {
				0.15,
				0.1,
				-0.15
			}
		},
		damage_profile = DamageProfileTemplates.powersword_2h_heavy_stab,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.powersword_2h_heavy_stab_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing_heavy
	},
	action_melee_start_right = {
		anim_end_event = "attack_finished",
		kind = "windup",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_down_right",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.05
			},
			{
				modifier = 0.95,
				t = 0.1
			},
			{
				modifier = 0.68,
				t = 0.25
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.65,
				t = 0.5
			},
			{
				modifier = 0.635,
				t = 0.55
			},
			{
				modifier = 0.3,
				t = 1.2
			},
			{
				modifier = 0.3,
				t = 3
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
			light_attack = {
				action_name = "action_light_2",
				chain_time = 0.15
			},
			heavy_attack = {
				action_name = "action_heavy_2",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_weapon_special_right"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_2 = {
		damage_window_start = 0.3,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1_1",
		kind = "sweep",
		attack_direction_override = "right",
		allowed_during_sprint = true,
		range_mod = 1.28,
		damage_window_end = 0.43333333333333335,
		first_person_hit_anim = "hit_right_shake",
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_right",
		anim_event = "attack_right",
		hit_stop_anim = "attack_hit",
		total_time = 1.3,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 1.05,
				t = 0.35
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.6,
				t = 0.45
			},
			{
				modifier = 0.6,
				t = 0.6
			},
			{
				modifier = 0.9,
				t = 0.7
			},
			{
				modifier = 0.95,
				t = 0.75
			},
			{
				modifier = 0.94,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
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
				chain_time = 0.59
			},
			block = {
				chain_time = 0.54,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_left_2",
				chain_time = 0.54
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/attack_right",
			anchor_point_offset = {
				-0,
				0,
				-0.25
			}
		},
		damage_profile = DamageProfileTemplates.light_powersword_2h,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.light_powersword_2h_active,
		herding_template = HerdingTemplates.thunder_hammer_right_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing,
		wounds_shape = wounds_shapes.horizontal_slash_clean,
		wounds_shape_special_active = wounds_shapes.horizontal_slash
	},
	action_heavy_2 = {
		damage_window_start = 0.21666666666666667,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.28,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "push",
		allowed_during_sprint = true,
		kind = "sweep",
		damage_window_end = 0.3,
		first_person_hit_anim = "hit_right_shake",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_attack_right_down",
		hit_stop_anim = "attack_hit",
		total_time = 1.75,
		action_movement_curve = {
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.25
			},
			{
				modifier = 1.3,
				t = 0.35
			},
			{
				modifier = 1.25,
				t = 0.45
			},
			{
				modifier = 0.5,
				t = 0.47
			},
			{
				modifier = 0.45,
				t = 0.6
			},
			{
				modifier = 0.45,
				t = 0.65
			},
			{
				modifier = 0.9,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.4
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.75
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.53
			},
			block = {
				chain_time = 0.58,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_left_2",
				chain_time = 0.58
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority_torso,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/heavy_attack_right_down",
			anchor_point_offset = {
				-0.1,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.powersword_2h_heavy_smiter,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.powersword_2h_heavy_smiter_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing_heavy,
		wounds_shape = wounds_shapes.vertical_slash_clean,
		wounds_shape_special_active = wounds_shapes.vertical_slash
	},
	action_melee_start_left_2 = {
		allowed_during_sprint = true,
		chain_anim_event = "heavy_charge_left_pose",
		chain_anim_event_3p = "heavy_charge_left",
		kind = "windup",
		anim_end_event = "attack_finished",
		anim_event_3p = "heavy_charge_left",
		anim_event = "heavy_charge_left",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.05
			},
			{
				modifier = 0.95,
				t = 0.1
			},
			{
				modifier = 0.68,
				t = 0.25
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.65,
				t = 0.5
			},
			{
				modifier = 0.635,
				t = 0.55
			},
			{
				modifier = 0.3,
				t = 1.2
			},
			{
				modifier = 0.3,
				t = 3
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
			light_attack = {
				action_name = "action_light_3",
				chain_time = 0.24
			},
			heavy_attack = {
				action_name = "action_heavy_3",
				chain_time = 0.63
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_weapon_special_left_2"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_3 = {
		damage_window_start = 0.23333333333333334,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		attack_direction_override = "push",
		allowed_during_sprint = true,
		range_mod = 1.4,
		first_person_hit_anim = "hit_left_shake",
		damage_window_end = 0.3,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_stab_01",
		anim_event = "attack_stab_01",
		hit_stop_anim = "attack_hit",
		total_time = 1.3,
		action_movement_curve = {
			{
				modifier = 1.2,
				t = 0.2
			},
			{
				modifier = 1.15,
				t = 0.4
			},
			{
				modifier = 0.55,
				t = 0.45
			},
			{
				modifier = 0.7,
				t = 0.65
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
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.55
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			},
			special_action = {
				action_name = "action_weapon_special_left_3",
				chain_time = 0.5
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.2,
			0.3,
			1.15
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/attack_stab",
			anchor_point_offset = {
				0.1,
				0,
				-0.18
			}
		},
		damage_profile = DamageProfileTemplates.light_powersword_2h_stab,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.light_powersword_2h_stab_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing
	},
	action_heavy_3 = {
		damage_window_start = 0.23333333333333334,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.28,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "left",
		allowed_during_sprint = true,
		kind = "sweep",
		damage_window_end = 0.3333333333333333,
		first_person_hit_anim = "hit_left_shake",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_attack_left",
		hit_stop_anim = "attack_hit",
		total_time = 1.75,
		action_movement_curve = {
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.25
			},
			{
				modifier = 1.3,
				t = 0.35
			},
			{
				modifier = 1.25,
				t = 0.45
			},
			{
				modifier = 0.5,
				t = 0.47
			},
			{
				modifier = 0.45,
				t = 0.6
			},
			{
				modifier = 0.45,
				t = 0.65
			},
			{
				modifier = 0.9,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.4
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.75
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.53
			},
			block = {
				chain_time = 0.58,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_right_2",
				chain_time = 0.58
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority_torso,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/heavy_attack_left",
			anchor_point_offset = {
				0,
				0,
				-0.15
			}
		},
		damage_profile = DamageProfileTemplates.powersword_2h_heavy_linesman,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.powersword_2h_heavy_linesman_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing_heavy,
		wounds_shape = wounds_shapes.horizontal_slash_clean,
		wounds_shape_special_active = wounds_shapes.horizontal_slash
	},
	action_melee_start_right_2 = {
		anim_end_event = "attack_finished",
		kind = "windup",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_right",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.05
			},
			{
				modifier = 0.95,
				t = 0.1
			},
			{
				modifier = 0.68,
				t = 0.25
			},
			{
				modifier = 0.65,
				t = 0.4
			},
			{
				modifier = 0.65,
				t = 0.5
			},
			{
				modifier = 0.635,
				t = 0.55
			},
			{
				modifier = 0.3,
				t = 1.2
			},
			{
				modifier = 0.3,
				t = 3
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
			light_attack = {
				action_name = "action_light_2",
				chain_time = 0.15
			},
			heavy_attack = {
				action_name = "action_heavy_4",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_weapon_special_right_2"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_heavy_4 = {
		damage_window_start = 0.21666666666666667,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.3,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "right",
		allowed_during_sprint = true,
		kind = "sweep",
		damage_window_end = 0.3333333333333333,
		first_person_hit_anim = "hit_right_shake",
		anim_end_event = "attack_finished",
		uninterruptible = true,
		anim_event = "heavy_attack_right",
		hit_stop_anim = "attack_hit",
		total_time = 1.75,
		action_movement_curve = {
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.15
			},
			{
				modifier = 1.25,
				t = 0.25
			},
			{
				modifier = 1.3,
				t = 0.35
			},
			{
				modifier = 1.25,
				t = 0.45
			},
			{
				modifier = 0.5,
				t = 0.47
			},
			{
				modifier = 0.45,
				t = 0.6
			},
			{
				modifier = 0.45,
				t = 0.65
			},
			{
				modifier = 0.9,
				t = 0.8
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.4
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.75
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.53
			},
			block = {
				chain_time = 0.58,
				action_name = "action_block",
				chain_until = 0.2
			},
			special_action = {
				action_name = "action_weapon_special_left_2",
				chain_time = 0.58
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority_torso,
		weapon_box = {
			0.15,
			0.3,
			1.3
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/heavy_attack_right",
			anchor_point_offset = {
				0,
				0,
				-0.15
			}
		},
		damage_profile = DamageProfileTemplates.powersword_2h_heavy_linesman,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.powersword_2h_heavy_linesman_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing_heavy,
		wounds_shape = wounds_shapes.horizontal_slash_clean,
		wounds_shape_special_active = wounds_shapes.horizontal_slash
	},
	action_block = {
		start_input = "block",
		kind = "block",
		anim_event = "parry_pose",
		stop_input = "block_release",
		minimum_hold_time = 0.3,
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.2
			},
			{
				modifier = 0.32,
				t = 0.3
			},
			{
				modifier = 0.3,
				t = 0.325
			},
			{
				modifier = 0.31,
				t = 0.35
			},
			{
				modifier = 0.55,
				t = 0.5
			},
			{
				modifier = 0.75,
				t = 1
			},
			{
				modifier = 0.7,
				t = 2
			},
			start_modifier = 1
		},
		anim_end_event_func = function (action_settings, condition_func_params)
			local character_state_component = condition_func_params and condition_func_params.character_state_component
			local state_name = character_state_component and character_state_component.state_name or "none"
			local is_sliding = state_name == "sliding"

			return is_sliding and "parry_finished_01" or "parry_finished"
		end,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			push = {
				action_name = "action_push",
				chain_time = 0.15
			},
			special_action = {
				action_name = "action_weapon_special_right",
				chain_time = 0.35
			}
		}
	},
	action_push = {
		push_radius = 2.75,
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
				action_name = "action_pushfollow",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.4
			},
			special_action = {
				action_name = "action_weapon_special_right_2",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block",
				chain_time = 0.45
			}
		},
		inner_push_rad = math.pi * 0.35,
		outer_push_rad = math.pi * 1,
		inner_damage_profile = DamageProfileTemplates.default_push,
		inner_damage_type = damage_types.physical,
		outer_damage_profile = DamageProfileTemplates.light_push,
		outer_damage_type = damage_types.physical,
		haptic_trigger_template = HapticTriggerTemplates.melee.push
	},
	action_pushfollow = {
		damage_window_start = 0.23333333333333334,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_1",
		kind = "sweep",
		attack_direction_override = "push",
		allowed_during_sprint = true,
		range_mod = 1.4,
		first_person_hit_anim = "hit_left_shake",
		damage_window_end = 0.3,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_stab_01",
		anim_event = "attack_stab_01",
		hit_stop_anim = "attack_hit",
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.2,
				t = 0.2
			},
			{
				modifier = 1.15,
				t = 0.4
			},
			{
				modifier = 0.55,
				t = 0.45
			},
			{
				modifier = 0.7,
				t = 0.65
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
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.55
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			},
			special_action = {
				action_name = "action_weapon_special_right",
				chain_time = 0.5
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.2,
			0.3,
			1.15
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/2h_power_sword/attack_stab",
			anchor_point_offset = {
				0.1,
				0,
				-0.18
			}
		},
		damage_profile = DamageProfileTemplates.light_powersword_2h_stab,
		damage_type = damage_types.metal_slashing_heavy,
		damage_type_special_active = damage_types.power_sword_2h,
		damage_profile_special_active = DamageProfileTemplates.light_powersword_2h_stab_active,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		aim_assist_ramp_template = AimAssistTemplates.tank_swing
	},
	action_weapon_special_left = {
		deactivate_anim_event = "deactivate",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate",
		block_duration = 0.6,
		activation_time = 0.45,
		start_input = "special_action",
		action_priority = 1,
		kind = "toggle_special_with_block",
		activate_anim_event_3p = "activate",
		deactivation_time = 0.37,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_weapon_special_right = {
		deactivate_anim_event = "deactivate_right",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate_right",
		block_duration = 0.6,
		kind = "toggle_special_with_block",
		activate_anim_event_3p = "activate",
		activation_time = 0.45,
		deactivation_time = 0.37,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
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
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_weapon_special_left_2 = {
		deactivate_anim_event = "deactivate_left",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate_left",
		block_duration = 0.6,
		kind = "toggle_special_with_block",
		activate_anim_event_3p = "activate",
		activation_time = 0.45,
		deactivation_time = 0.4,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
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
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_weapon_special_left_3 = {
		deactivate_anim_event = "deactivate_left",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate_left",
		block_duration = 0.5,
		kind = "toggle_special_with_block",
		activate_anim_event_3p = "activate",
		activation_time = 0.45,
		deactivation_time = 0.4,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block",
				chain_time = 0.5
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_weapon_special_right_2 = {
		deactivate_anim_event = "deactivate_right",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate_right",
		block_duration = 0.6,
		kind = "toggle_special_with_block",
		activate_anim_event_3p = "activate",
		activation_time = 0.45,
		deactivation_time = 0.37,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_weapon_special_sprint = {
		deactivate_anim_event = "deactivate_sprint",
		total_time_deactivate = 1.5,
		start_input = "special_action",
		sprint_requires_press_to_interrupt = true,
		activate_anim_event = "activate_sprint",
		action_priority = 2,
		activate_anim_event_3p = "activate",
		activation_time = 0.45,
		deactivation_time = 0.37,
		kind = "toggle_special",
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_sprint",
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.6
			},
			special_action = {
				action_name = "action_weapon_special_sprint",
				chain_time = 1.2
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout" and (condition_func_params.sprint_character_state_component.is_sprinting or condition_func_params.movement_state_component.method == "sliding")
		end
	},
	action_weapon_special_stab = {
		deactivate_anim_event = "deactivate_sprint",
		total_time_deactivate = 1.5,
		activate_anim_event = "activate_sprint",
		block_duration = 0.5,
		sprint_requires_press_to_interrupt = true,
		activation_time = 0.45,
		activate_anim_event_3p = "activate",
		kind = "toggle_special_with_block",
		deactivation_time = 0.4,
		allowed_during_sprint = true,
		deactivate_anim_event_3p = "activate",
		skip_3p_anims = false,
		total_time = 1.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block",
				chain_time = 0.5
			}
		},
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.inventory_slot_component.overheat_state ~= "lockout"
		end
	},
	action_inspect = {
		skip_3p_anims = false,
		start_input = "inspect_start",
		anim_end_event = "inspect_end",
		kind = "inspect",
		lock_view = true,
		stop_input = "inspect_stop",
		total_time = math.huge,
		anim_event_func = function (action_settings, condition_func_params, is_chain_action, previous_action)
			local inventory_slot_component = condition_func_params.inventory_slot_component
			local special_active = inventory_slot_component.special_active
			local anim_event = special_active and "inspect_start_active" or "inspect_start"

			return anim_event, "inspect_start"
		end,
		crosshair = {
			crosshair_type = "inspect"
		}
	}
}

table.add_missing(weapon_template.actions, BaseTemplateSettings.actions)

weapon_template.character_state_anim_events = {
	sprinting = {
		lunging = "move_fwd_sprint_to_lunge"
	}
}
weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/2h_power_sword"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/2h_power_sword"
weapon_template.weapon_box = {
	0.2,
	1,
	0.25
}
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = false
}
weapon_template.fx_sources = {
	_sweep = "fx_sweep",
	_special_active = "fx_blade",
	_block = "fx_block"
}
weapon_template.crosshair = {
	crosshair_type = "dot"
}
weapon_template.hit_marker_type = "center"
weapon_template.weapon_counter = {
	weapon_counter_type = "overheat_lockout",
	show_when_unwielded = false
}
weapon_template.keywords = {
	"melee",
	"power_sword_2h",
	"p1",
	"activated"
}
weapon_template.dodge_template = "smiter"
weapon_template.sprint_template = "support"
weapon_template.stamina_template = "linesman"
weapon_template.toughness_template = "default"
weapon_template.movement_curve_modifier_template = "default"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.powermaul_2h
weapon_template.smart_targeting_template = SmartTargetingTemplates.tank
weapon_template.haptic_trigger_template = HapticTriggerTemplates.melee.heavy
weapon_template.damage_window_start_sweep_trail_offset = -0.45
weapon_template.damage_window_end_sweep_trail_offset = 0.45
weapon_template.ammo_template = "no_ammo"
weapon_template.sprint_ready_up_time = 0.3
weapon_template.max_first_person_anim_movement_speed = 4.8
weapon_template.special_charge_template = "powersword_2h_p1_m1_weapon_special"
weapon_template.use_special_charge_template_for_overheat_decay = true
weapon_template.weapon_special_class = "WeaponSpecialCharging"
weapon_template.weapon_special_tweak_data = {
	keep_active_on_vault = true,
	keep_active_on_stun = true,
	keep_active_on_sprint = true
}
weapon_template.overheat_configuration = {
	explode_at_high_overheat = false,
	overheat_icon_text = "",
	overheat_lockout_icon_text = "",
	lockout_enabled = true,
	fx = {
		on_screen_effect = "content/fx/particles/screenspace/screen_plasma_rifle_warning",
		sfx_source_name = "_overheat",
		on_screen_cloud_name = "plasma",
		vfx_source_name = "_overheat",
		looping_sound_parameter_name = "overheat_plasma_gun",
		on_screen_variable_name = "plasma_radius"
	}
}
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	powersword_2h_p1_m1_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_light_1 = {
				damage_trait_templates.powersword_dps_stat,
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
			action_heavy_1 = {
				damage_trait_templates.powersword_dps_stat,
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
			action_light_2 = {
				damage_trait_templates.powersword_dps_stat
			},
			action_heavy_2 = {
				damage_trait_templates.powersword_dps_stat
			},
			action_light_3 = {
				damage_trait_templates.powersword_dps_stat
			},
			action_heavy_3 = {
				damage_trait_templates.powersword_dps_stat
			},
			action_heavy_4 = {
				damage_trait_templates.powersword_dps_stat
			},
			action_pushfollow = {
				damage_trait_templates.powersword_dps_stat
			},
			action_sprint_light = {
				damage_trait_templates.powersword_dps_stat
			},
			action_sprint_heavy_stab = {
				damage_trait_templates.powersword_dps_stat
			}
		}
	},
	powersword_2h_p1_m1_power_output_stat = {
		display_name = "loc_stats_display_power_output",
		is_stat_trait = true,
		damage = {
			action_light_1 = {
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_light",
							damage_profile_path = {
								"damage_profile_special_active"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_power"
											}
										}
									}
								}
							}
						}
					}
				}
			},
			action_heavy_1 = {
				overrides = {
					powersword_2h_heavy_smiter_active = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_heavy",
							damage_profile_path = {
								"damage_profile_special_active"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_power"
											}
										}
									}
								}
							}
						}
					}
				}
			},
			action_sprint_light = {
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_sprint_heavy_stab = {
				overrides = {
					powersword_2h_heavy_stab_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_light_2 = {
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_heavy_2 = {
				overrides = {
					powersword_2h_heavy_smiter_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_light_3 = {
				overrides = {
					light_powersword_2h_stab_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_heavy_3 = {
				overrides = {
					powersword_2h_heavy_linesman_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_pushfollow = {
				overrides = {
					light_powersword_2h_stab_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_heavy_4 = {
				overrides = {
					powersword_2h_heavy_linesman_active = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			}
		}
	},
	powersword_2h_p1_m1_heat_stat = {
		display_name = "loc_stats_display_heat_management_powersword_2h",
		is_stat_trait = true,
		charge = {
			base_special = {
				charge_trait_templates.powersword_2h_p1_heat_stat,
				display_data = {
					display_stats = {
						overheat_overtime = {
							overheat_percent = {}
						},
						overheat_swing = {
							overheat_percent = {}
						},
						overheat_decay = {
							auto_vent_duration = {}
						}
					}
				}
			}
		}
	},
	powersword_2h_p1_m1_finesse_stat = {
		display_name = "loc_stats_display_finesse_stat",
		is_stat_trait = true,
		damage = {
			action_light_1 = {
				damage_trait_templates.powersword_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								boost_curve_multiplier_finesse = {}
							}
						}
					}
				},
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_heavy_1 = {
				damage_trait_templates.powersword_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								boost_curve_multiplier_finesse = {}
							}
						}
					}
				},
				overrides = {
					powersword_2h_heavy_smiter_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_light_2 = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_heavy_2 = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					powersword_2h_heavy_smiter_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_light_3 = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					light_powersword_2h_stab_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_heavy_3 = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					powersword_2h_heavy_linesman_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_heavy_4 = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					powersword_2h_heavy_linesman_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_pushfollow = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					light_powersword_2h_stab_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_sprint_light = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					light_powersword_2h_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			},
			action_sprint_heavy_stab = {
				damage_trait_templates.powersword_finesse_stat,
				overrides = {
					powersword_2h_heavy_stab_active = {
						damage_trait_templates.powersword_finesse_stat
					}
				}
			}
		},
		weapon_handling = {
			action_light_1 = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						__all_basic_stats = true
					}
				}
			},
			action_heavy_1 = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						__all_basic_stats = true
					}
				}
			},
			action_light_2 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_heavy_2 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_light_3 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_heavy_3 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_heavy_4 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_pushfollow = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_sprint_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_sprint_heavy_stab = {
				weapon_handling_trait_templates.default_finesse_stat
			}
		}
	},
	powersword_2h_p1_m1_mobility_stat = {
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
local weapon_traits_bespoke_powersword_2h_p1 = table.ukeys(WeaponTraitsBespokePowesword2hP1)

table.append(weapon_template.traits, weapon_traits_bespoke_powersword_2h_p1)

weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_power_weapon"
	},
	{
		display_name = "loc_weapon_keyword_high_cleave",
		description = "loc_weapon_stats_display_high_cleave_desc"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		display_name = "loc_gestalt_linesman",
		type = "linesman",
		attack_chain = {
			"linesman",
			"linesman",
			"smiter"
		}
	},
	secondary = {
		display_name = "loc_gestalt_smiter",
		type = "smiter",
		attack_chain = {
			"smiter",
			"smiter",
			"linesman",
			"linesman"
		}
	},
	special = {
		desc = "loc_stats_special_action_powerup_desc",
		display_name = "loc_weapon_special_activate",
		type = "activate"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			icon = "linesman",
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
		icon = "activate",
		header = "activate"
	}
}
weapon_template.resources = {
	trait_explosion_vfx = "content/fx/particles/weapons/power_maul/power_maul_push_shockwave"
}

return weapon_template
