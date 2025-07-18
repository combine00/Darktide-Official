local ActionInputHierarchy = require("scripts/utilities/action/action_input_hierarchy")
local ActionSweepSettings = require("scripts/settings/equipment/action_sweep_settings")
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
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokeOgrynPickaxe2hP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_ogryn_pickaxe_2h_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local WoundsSettings = require("scripts/settings/wounds/wounds_settings")
local damage_types = DamageSettings.damage_types
local default_hit_zone_priority = ActionSweepSettings.default_hit_zone_priority
local buff_stat_buffs = BuffSettings.stat_buffs
local template_types = WeaponTweakTemplateSettings.template_types
local wounds_shapes = WoundsSettings.shapes
local armor_types = ArmorSettings.types
local hit_zone_names = HitZone.hit_zone_names
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local stamina_trait_templates = WeaponTraitTemplates[template_types.stamina]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local weapon_template = {}
local melee_sticky_disallowed_hit_zones = {
	hit_zone_names.lower_left_arm,
	hit_zone_names.lower_right_arm,
	hit_zone_names.lower_left_leg,
	hit_zone_names.lower_right_leg
}
local default_weapon_box = {
	0.2,
	0.15,
	1.1
}
weapon_template.action_inputs = table.clone(MeleeActionInputSetupSlow.action_inputs)
weapon_template.action_inputs.heavy_attack.input_sequence[2].time_window = 1.5
weapon_template.action_input_hierarchy = table.clone(MeleeActionInputSetupSlow.action_input_hierarchy)
local new_start_attack_action_transition = {
	{
		transition = "base",
		input = "attack_cancel"
	},
	{
		transition = "base",
		input = "light_attack"
	},
	{
		transition = "base",
		input = "heavy_attack"
	},
	{
		transition = "base",
		input = "wield"
	},
	{
		transition = "base",
		input = "grenade_ability"
	},
	{
		transition = "base",
		input = "block"
	}
}

ActionInputHierarchy.update_hierarchy_entry(weapon_template.action_input_hierarchy, "start_attack", new_start_attack_action_transition)

local hit_zone_priority = {
	[hit_zone_names.head] = 1,
	[hit_zone_names.torso] = 2,
	[hit_zone_names.weakspot] = 1,
	[hit_zone_names.upper_left_arm] = 3,
	[hit_zone_names.upper_right_arm] = 3,
	[hit_zone_names.upper_left_leg] = 3,
	[hit_zone_names.upper_right_leg] = 3
}

table.add_missing(hit_zone_priority, default_hit_zone_priority)

weapon_template.action_inputs.block.buffer_time = 0.3
weapon_template.action_inputs.start_attack.buffer_time = 0.5
weapon_template.action_inputs.push_follow_up.buffer_time = 0.5
weapon_template.action_inputs.push.buffer_time = 0.8
weapon_template.action_inputs.special_action.buffer_time = 0.5
weapon_template.actions = {
	action_unwield = {
		start_input = "wield",
		allowed_during_sprint = true,
		kind = "unwield",
		total_time = 0,
		allowed_chain_actions = {}
	},
	action_wield = {
		kind = "wield",
		allowed_during_sprint = true,
		anim_event = "equip",
		sprint_ready_up_time = 0,
		total_time = 0.5,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			block = {
				action_name = "action_block"
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.2
			},
			special_action = {
				action_name = "action_special"
			},
			wield = {
				action_name = "action_unwield"
			}
		}
	},
	action_melee_start_slide = {
		chain_anim_event = "heavy_charge_left_diagonal_pose",
		proc_time_interval = 0.2,
		start_input = "start_attack",
		kind = "windup",
		action_priority = 2,
		invalid_start_action_for_stat_calculation = true,
		allowed_during_sprint = true,
		chain_anim_event_3p = "attack_swing_charge_down_left",
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_charge_down_left",
		anim_event = "heavy_charge_left_diagonal",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_1_slide"
			},
			heavy_attack = {
				action_name = "action_heavy_1",
				chain_time = 0.85
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.movement_state_component.method == "sliding"
		end
	},
	action_melee_start_left = {
		anim_event_3p = "attack_swing_charge_down_left",
		chain_anim_event = "heavy_charge_left_diagonal_pose",
		start_input = "start_attack",
		kind = "windup",
		chain_anim_event_3p = "attack_swing_charge_down_left",
		action_priority = 1,
		anim_end_event = "attack_finished",
		proc_time_interval = 0.2,
		allowed_during_sprint = true,
		anim_event = "heavy_charge_left_diagonal",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_1"
			},
			heavy_attack = {
				action_name = "action_heavy_1",
				chain_time = 0.68
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_1 = {
		damage_window_start = 0.4,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_left_shake",
		range_mod = 1.45,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		damage_window_end = 0.5333333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left_diagonal",
		anim_event = "attack_left_diagonal",
		power_level = 440,
		total_time = 1.4,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.11
			},
			{
				modifier = 0.8,
				t = 0.15
			},
			{
				modifier = 1.5,
				t = 0.19
			},
			{
				modifier = 1.4,
				t = 0.31
			},
			{
				modifier = 1,
				t = 0.38
			},
			{
				modifier = 0.5,
				t = 0.46
			},
			{
				modifier = 1,
				t = 0.77
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.7
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.6
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1.2
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_left_diagonal",
			anchor_point_offset = {
				0.08,
				-0.2,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_linesman,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.linesman_left_heavy,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_light_1_slide = {
		damage_window_start = 0.3,
		hit_armor_anim = "attack_hit_shield",
		weapon_handling_template = "time_scale_0_9",
		kind = "sweep",
		first_person_hit_anim = "hit_left_shake",
		range_mod = 1.25,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		attack_direction_override = "up",
		damage_window_end = 0.43333333333333335,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_up_left",
		anim_event = "attack_up_left",
		power_level = 520,
		total_time = 1.4,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.11
			},
			{
				modifier = 0.8,
				t = 0.15
			},
			{
				modifier = 1.5,
				t = 0.19
			},
			{
				modifier = 1.4,
				t = 0.31
			},
			{
				modifier = 1,
				t = 0.38
			},
			{
				modifier = 0.5,
				t = 0.46
			},
			{
				modifier = 1,
				t = 0.77
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.65
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.6
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1.4
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_up_left",
			anchor_point_offset = {
				0,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_smiter,
		damage_type = damage_types.piercing_heavy,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_melee_start_cool = {
		allowed_during_sprint = true,
		chain_anim_event = "heavy_charge_down",
		proc_time_interval = 0.2,
		kind = "windup",
		anim_end_event = "attack_finished",
		chain_anim_event_3p = "attack_swing_charge_down_left",
		anim_event_3p = "attack_swing_charge_down",
		anim_event = "heavy_charge_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_5"
			},
			heavy_attack = {
				action_name = "action_heavy_3",
				chain_time = 0.73
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_5 = {
		damage_window_start = 0.5666666666666667,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_left_shake",
		range_mod = 1.35,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1_1",
		damage_window_end = 0.7333333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_down_left",
		anim_event = "attack_down",
		power_level = 480,
		total_time = 1.4,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.11
			},
			{
				modifier = 0.8,
				t = 0.15
			},
			{
				modifier = 1.5,
				t = 0.19
			},
			{
				modifier = 1.4,
				t = 0.31
			},
			{
				modifier = 1,
				t = 0.38
			},
			{
				modifier = 0.5,
				t = 0.46
			},
			{
				modifier = 1,
				t = 0.77
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.7
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.6
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.25,
			0.15,
			1.1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_down",
			anchor_point_offset = {
				0,
				0.5,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_smiter,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.smiter_down_pickaxe,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_heavy_3 = {
		damage_window_start = 0.1,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.5,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		damage_window_end = 0.2,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_down",
		anim_event = "heavy_attack_down",
		power_level = 480,
		total_time = 2,
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
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions({
				chain_time = 0.5
			}),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.55
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.3
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.9
			},
			block = {
				action_name = "action_block",
				chain_time = 0.61
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/heavy_attack_down",
			anchor_point_offset = {
				0,
				-0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_heavy_smiter,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.smiter_down_pickaxe,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_heavy_1 = {
		damage_window_start = 0.2,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.6,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		damage_window_end = 0.3333333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_down_left",
		anim_event = "heavy_attack_left_diagonal",
		power_level = 500,
		total_time = 2,
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
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions({
				chain_time = 0.5
			}),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.51
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.49
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.75
			},
			block = {
				action_name = "action_block",
				chain_time = 0.61
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/heavy_attack_left_diagonal",
			anchor_point_offset = {
				0,
				-0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_heavy_linesman,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.smiter_down_pickaxe,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_melee_start_right = {
		allowed_during_sprint = true,
		anim_end_event = "attack_finished",
		proc_time_interval = 0.2,
		kind = "windup",
		first_person_hit_anim = "hit_right_shake",
		first_person_hit_stop_anim = "attack_hit",
		anim_event_3p = "attack_swing_charge_up_right",
		anim_event = "heavy_charge_right_diagonal_up",
		hit_stop_anim = "attack_hit_shield",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_2"
			},
			heavy_attack = {
				action_name = "action_heavy_2",
				chain_time = 0.63
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_2 = {
		damage_window_start = 0.4666666666666667,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.4,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1_1",
		damage_window_end = 0.6,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_right_diagonal",
		anim_event = "attack_right_diagonal",
		power_level = 440,
		total_time = 1.4,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.15
			},
			{
				modifier = 0.8,
				t = 0.2
			},
			{
				modifier = 1.5,
				t = 0.25
			},
			{
				modifier = 1.4,
				t = 0.4
			},
			{
				modifier = 1,
				t = 0.5
			},
			{
				modifier = 0.5,
				t = 0.6
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.85
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.64
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1.2
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_right_diagonal",
			anchor_point_offset = {
				-0.05,
				-0.2,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_linesman,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.linesman_right_heavy,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_heavy_2 = {
		damage_window_start = 0.2,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.67,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = "true",
		weapon_handling_template = "time_scale_0_9",
		damage_window_end = 0.31666666666666665,
		anim_end_event = "attack_finished",
		attack_direction_override = "up",
		ragdoll_push_force = 1200,
		anim_event_3p = "attack_swing_heavy_up_right",
		anim_event = "heavy_attack_right_up",
		power_level = 500,
		total_time = 2,
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
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions({
				chain_time = 0.5
			}),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.55
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.55
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block",
				chain_time = 0.55
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.2,
			0.15,
			1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/heavy_attack_right_diagonal_up",
			anchor_point_offset = {
				0,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_heavy_linesman,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.linesman_right_heavy,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_melee_start_left_2 = {
		first_person_hit_stop_anim = "hit_left_shake",
		chain_anim_event = "heavy_charge_left_diagonal_pose",
		proc_time_interval = 0.2,
		kind = "windup",
		weapon_handling_template = "time_scale_1",
		first_person_hit_anim = "hit_left_shake",
		allowed_during_sprint = true,
		chain_anim_event_3p = "attack_swing_charge_down_left",
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_charge_down_left",
		anim_event = "heavy_charge_left_diagonal",
		hit_stop_anim = "attack_hit_shield",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_3"
			},
			heavy_attack = {
				action_name = "action_heavy_1",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_3 = {
		damage_window_start = 0.36666666666666664,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.38,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		damage_window_end = 0.5,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left",
		anim_event = "attack_left",
		power_level = 440,
		total_time = 1.4,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.15
			},
			{
				modifier = 0.8,
				t = 0.2
			},
			{
				modifier = 1.5,
				t = 0.25
			},
			{
				modifier = 1.4,
				t = 0.4
			},
			{
				modifier = 1,
				t = 0.5
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right_2",
				chain_time = 0.8
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.6
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.25,
			0.25,
			1.1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_left",
			anchor_point_offset = {
				0,
				0,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_linesman,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.stab,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_melee_start_right_2 = {
		allowed_during_sprint = true,
		anim_end_event = "attack_finished",
		proc_time_interval = 0.2,
		kind = "windup",
		first_person_hit_anim = "hit_right_shake",
		first_person_hit_stop_anim = "attack_hit",
		anim_event_3p = "attack_swing_charge_up_right",
		anim_event = "heavy_charge_right_diagonal_up",
		hit_stop_anim = "attack_hit_shield",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.8,
				t = 0.05
			},
			{
				modifier = 0.25,
				t = 0.1
			},
			{
				modifier = 0.2,
				t = 0.25
			},
			{
				modifier = 0.35,
				t = 0.4
			},
			{
				modifier = 0.8,
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
			light_attack = {
				action_name = "action_light_4"
			},
			heavy_attack = {
				action_name = "action_heavy_2",
				chain_time = 0.87
			},
			block = {
				action_name = "action_block"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_light_4 = {
		damage_window_start = 0.38333333333333336,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 1.45,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		damage_window_end = 0.48333333333333334,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_down_left",
		anim_event = "attack_down_right",
		power_level = 480,
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.15
			},
			{
				modifier = 0.8,
				t = 0.2
			},
			{
				modifier = 1.5,
				t = 0.25
			},
			{
				modifier = 1.4,
				t = 0.4
			},
			{
				modifier = 1,
				t = 0.5
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.86
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.7
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.25,
			0.25,
			1.1
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_down_right",
			anchor_point_offset = {
				0,
				0,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_light_smiter,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.smiter_down_pickaxe,
		wounds_shape = wounds_shapes.sphere,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_block = {
		minimum_hold_time = 0.15,
		start_input = "block",
		anim_end_event = "parry_finished",
		kind = "block",
		anim_event = "parry_pose",
		stop_input = "block_release",
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
				chain_time = 0.25
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.25
			}
		}
	},
	action_right_light_pushfollow = {
		damage_window_start = 0.23333333333333334,
		hit_armor_anim = "attack_hit_shield",
		kind = "sweep",
		first_person_hit_anim = "hit_right_shake",
		range_mod = 2.6,
		first_person_hit_stop_anim = "attack_hit",
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1_1",
		damage_window_end = 0.4,
		anim_end_event = "attack_finished",
		attack_direction_override = "push",
		anim_event_3p = "attack_pushfollow_stab",
		anim_event = "pushfollow_stab",
		power_level = 500,
		total_time = 1.42,
		action_movement_curve = {
			{
				modifier = 1.2,
				t = 0.1
			},
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 0.45,
				t = 0.24
			},
			{
				modifier = 0.6,
				t = 0.32
			},
			{
				modifier = 1,
				t = 0.6
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
				action_name = "action_melee_start_cool",
				chain_time = 0.48
			},
			block = {
				action_name = "action_block",
				chain_time = 0.52
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.43
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.3,
			0.3,
			0.7
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_stab",
			anchor_point_offset = {
				-0.1,
				2.2,
				0.1
			}
		},
		damage_profile = DamageProfileTemplates.ogryn_pickaxe_blunt_m3,
		damage_type = damage_types.piercing_heavy,
		herding_template = HerdingTemplates.uppercut,
		wounds_shape = wounds_shapes.default,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
	},
	action_push = {
		push_radius = 3,
		weapon_handling_template = "time_scale_1",
		block_duration = 0.5,
		kind = "push",
		activation_cooldown = 0.2,
		anim_event = "attack_push",
		power_level = 500,
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
				chain_time = 0.45
			},
			block = {
				action_name = "action_block",
				chain_time = 0.45
			},
			special_action = {
				action_name = "action_special",
				chain_time = 0.45
			},
			start_attack = {
				action_name = "action_melee_start_left_2",
				chain_time = 0.47
			}
		},
		inner_push_rad = math.pi * 0.25,
		outer_push_rad = math.pi * 1,
		inner_damage_profile = DamageProfileTemplates.ogryn_push,
		inner_damage_type = damage_types.ogryn_physical,
		outer_damage_profile = DamageProfileTemplates.default_push,
		outer_damage_type = damage_types.ogryn_physical,
		haptic_trigger_template = HapticTriggerTemplates.melee.push
	},
	action_special = {
		damage_window_start = 0.5,
		hit_armor_anim = "attack_hit_shield",
		start_input = "special_action",
		kind = "sweep",
		max_num_saved_entries = 20,
		invalid_start_action_for_stat_calculation = true,
		range_mod = 1.25,
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "pull",
		damage_window_end = 0.5333333333333333,
		anim_end_event = "attack_finished",
		first_person_hit_anim = "hit_right_shake",
		anim_event = "attack_special_hook",
		power_level = 500,
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.32,
				t = 0.2
			},
			{
				modifier = 1.3,
				t = 0.225
			},
			{
				modifier = 0.5,
				t = 0.35
			},
			{
				modifier = 0.4,
				t = 0.6
			},
			{
				modifier = 0.85,
				t = 1.1
			},
			{
				modifier = 0.98,
				t = 1.4
			},
			start_modifier = 0.2
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.55
			},
			start_attack = {
				action_name = "action_melee_start_cool",
				chain_time = 0.72
			},
			block = {
				action_name = "action_block",
				chain_time = 0.53
			},
			special_action = {
				action_name = "action_special",
				chain_time = 1.1
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = {
			0.4,
			0.35,
			1.4
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/ogryn/first_person/animations/2h_axe/attack_special_hook",
			anchor_point_offset = {
				0.2,
				0.5,
				0
			}
		},
		damage_profile = DamageProfileTemplates.special_pull,
		damage_type = damage_types.ogryn_hook,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		}
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

weapon_template.anim_state_machine_3p = "content/characters/player/ogryn/third_person/animations/2h_axe"
weapon_template.anim_state_machine_1p = "content/characters/player/ogryn/first_person/animations/2h_axe"
weapon_template.weapon_box = {
	0.1,
	0.7,
	0.02
}
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = false
}
weapon_template.sprint_ready_up_time = 0.2
weapon_template.max_first_person_anim_movement_speed = 4.8
weapon_template.damage_window_start_sweep_trail_offset = -0.45
weapon_template.damage_window_end_sweep_trail_offset = 0.45
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
	"combat_blade",
	"p1"
}
weapon_template.damage_trait_templates = "ogryn"
weapon_template.dodge_template = "ogryn"
weapon_template.sprint_template = "ogryn_sprint_fast"
weapon_template.stamina_template = "tank_pickaxe_m3"
weapon_template.toughness_template = "default"
weapon_template.movement_curve_modifier_template = "default"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.ogryn_combat_pickaxe
weapon_template.smart_targeting_template = SmartTargetingTemplates.default_melee
weapon_template.haptic_trigger_template = HapticTriggerTemplates.melee.heavy
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	ogryn_pickaxe_p1_m3_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_heavy_2 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_heavy_1 = {
				damage_trait_templates.default_melee_dps_stat,
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
			action_heavy_3 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_light_1 = {
				damage_trait_templates.default_melee_dps_stat,
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
			action_light_2 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_light_3 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_light_4 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_light_5 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_light_1_slide = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_special = {
				damage_trait_templates.default_melee_dps_stat
			}
		}
	},
	ogryn_pickaxe_p1_m3_armor_pierce_stat = {
		display_name = "loc_stats_display_ap_stat",
		is_stat_trait = true,
		damage = {
			action_heavy_2 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_heavy_3 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_heavy_1 = {
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
			action_light_1 = {
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
			action_light_2 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_light_3 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_light_4 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_light_5 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_light_1_slide = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_special = {
				damage_trait_templates.default_armor_pierce_stat
			}
		}
	},
	ogryn_pickaxe_p1_m3_control_stat = {
		description = "loc_stats_display_control_stat_melee_mouseover",
		display_name = "loc_stats_display_control_stat_melee",
		is_stat_trait = true,
		damage = {
			action_light_1 = {
				damage_trait_templates.pickaxe_cleave_targets_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								power_distribution = {
									impact = {
										display_name = "loc_weapon_stats_display_stagger"
									}
								}
							}
						},
						cleave_distribution = {
							attack = {},
							impact = {}
						}
					}
				}
			},
			action_heavy_1 = {
				damage_trait_templates.pickaxe_cleave_targets_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								power_distribution = {
									impact = {
										display_name = "loc_weapon_stats_display_stagger"
									}
								}
							}
						},
						cleave_distribution = {
							attack = {},
							impact = {}
						}
					}
				}
			},
			action_light_2 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_light_3 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_heavy_2 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_heavy_3 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_light_4 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_light_5 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_light_1_slide = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_special = {
				damage_trait_templates.pickaxe_cleave_targets_stat
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
			action_light_3 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_heavy_2 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_heavy_3 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_light_4 = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_light_5 = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_light_1_slide = {
				damage_trait_templates.pickaxe_cleave_targets_stat
			},
			action_right_light_pushfollow = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_special = {
				weapon_handling_trait_templates.default_finesse_stat
			}
		}
	},
	ogryn_pickaxe_p1_m3_defence_stat = {
		display_name = "loc_stats_display_defense_stat",
		is_stat_trait = true,
		stamina = {
			base = {
				stamina_trait_templates.thunderhammer_p1_m1_defence_stat,
				display_data = {
					display_stats = {
						sprint_cost_per_second = {},
						block_cost = {},
						push_cost = {}
					}
				}
			}
		},
		dodge = {
			base = {
				dodge_trait_templates.default_dodge_stat,
				display_data = {
					display_stats = {
						distance_scale = {},
						diminishing_return_distance_modifier = {},
						diminishing_return_start = {},
						diminishing_return_limit = {},
						speed_modifier = {}
					}
				}
			}
		}
	},
	ogryn_pickaxe_p1_m3_cleave_damage_stat = {
		display_name = "loc_stats_display_cleave_damage_stat",
		is_stat_trait = true,
		damage = {
			action_heavy_2 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_heavy_3 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_heavy_1 = {
				damage_trait_templates.powermaul_cleave_damage_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						armor_damage_modifier = {
							attack = WeaponBarUIDescriptionTemplates.armor_damage_modifiers
						}
					}
				}
			},
			action_light_1 = {
				damage_trait_templates.powermaul_cleave_damage_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						armor_damage_modifier = {
							attack = WeaponBarUIDescriptionTemplates.armor_damage_modifiers
						}
					}
				}
			},
			action_light_2 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_light_3 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_light_4 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_light_5 = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_light_1_slide = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.powermaul_cleave_damage_stat
			},
			action_special = {
				damage_trait_templates.powermaul_cleave_damage_stat
			}
		}
	}
}
weapon_template.traits = {}
local bespoke_ogryn_pickaxe_2h_p1 = table.ukeys(WeaponTraitsBespokeOgrynPickaxe2hP1)

table.append(weapon_template.traits, bespoke_ogryn_pickaxe_2h_p1)

weapon_template.buffs = {
	on_equip = {
		"ogryn_pick_axe_weapon_special_debuff"
	}
}
weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_crowd_control"
	},
	{
		display_name = "loc_weapon_keyword_high_damage"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		display_name = "loc_gestalt_smiter",
		type = "smiter",
		attack_chain = {
			"linesman",
			"linesman",
			"linesman",
			"smiter"
		}
	},
	secondary = {
		display_name = "loc_gestalt_linesman",
		type = "linesman",
		attack_chain = {
			"linesman",
			"linesman"
		}
	},
	special = {
		desc = "loc_weapon_special_hook_pull_desc",
		display_name = "loc_weapon_special_hook_pull",
		type = "special_attack"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			icon = "smiter",
			value_func = "primary_attack",
			header = "light"
		},
		{
			icon = "linesman",
			value_func = "secondary_attack",
			header = "heavy"
		}
	},
	weapon_special = {
		icon = "special_attack",
		header = "special_attack"
	}
}

function weapon_template.weapon_special_action_none_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")
	local correct_scenario = scenario_system:get_current_scenario_name() == "weapon_special"
	local player_unit = player.player_unit
	local unit_data_ext = ScriptUnit.extension(player_unit, "unit_data_system")
	local inventory_slot_component = unit_data_ext:read_component(wielded_slot_id)
	local special_active = inventory_slot_component.special_active

	return correct_scenario and not special_active and (not current_action_name or current_action_name == "none")
end

weapon_template.special_action_name = "action_special"

return weapon_template
