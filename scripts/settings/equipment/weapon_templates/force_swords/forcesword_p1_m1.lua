local ActionInputHierarchy = require("scripts/utilities/action/action_input_hierarchy")
local ActionSweepSettings = require("scripts/settings/equipment/action_sweep_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local ForceswordMeleeActionInputSetup = require("scripts/settings/equipment/weapon_templates/forcesword_melee_action_input_setup")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HerdingTemplates = require("scripts/settings/damage/herding_templates")
local HitZone = require("scripts/utilities/attack/hit_zone")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokeForceswordP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_forcesword_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local WoundsSettings = require("scripts/settings/wounds/wounds_settings")
local buff_stat_buffs = BuffSettings.stat_buffs
local damage_types = DamageSettings.damage_types
local default_hit_zone_priority = ActionSweepSettings.default_hit_zone_priority
local hit_zone_names = HitZone.hit_zone_names
local template_types = WeaponTweakTemplateSettings.template_types
local wounds_shapes = WoundsSettings.shapes
local charge_trait_templates = WeaponTraitTemplates[template_types.charge]
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local weapon_template = {}
local action_inputs = table.clone(ForceswordMeleeActionInputSetup.action_inputs)
action_inputs.vent = {
	buffer_time = 0,
	clear_input_queue = true,
	input_sequence = {
		{
			value = true,
			input = "weapon_reload_hold"
		}
	}
}
action_inputs.vent_release = {
	buffer_time = 0.1,
	input_sequence = {
		{
			value = false,
			input = "weapon_reload_hold",
			time_window = math.huge
		}
	}
}
action_inputs.block.buffer_time = 0.1
action_inputs.block_release.buffer_time = 0.35
local action_input_hierarchy = table.clone(ForceswordMeleeActionInputSetup.action_input_hierarchy)

ActionInputHierarchy.update_hierarchy_entry(action_input_hierarchy, "vent", {
	{
		transition = "base",
		input = "vent_release"
	},
	{
		transition = "base",
		input = "wield"
	},
	{
		transition = "base",
		input = "combat_ability"
	},
	{
		transition = "base",
		input = "grenade_ability"
	}
})

weapon_template.action_inputs = action_inputs
weapon_template.action_input_hierarchy = action_input_hierarchy
local base_sweep_box = {
	0.15,
	0.15,
	1.2
}
local stab_sweep_box = {
	0.15,
	0.15,
	1.2
}
local melee_sticky_disallowed_hit_zones = {}
local force_sword_disallowed_armor_types = {}
local melee_sticky_heavy_attack_disallowed_armor_types = {}
local hit_zone_priority = {
	[hit_zone_names.head] = 1,
	[hit_zone_names.torso] = 2,
	[hit_zone_names.upper_left_arm] = 3,
	[hit_zone_names.upper_right_arm] = 3,
	[hit_zone_names.upper_left_leg] = 3,
	[hit_zone_names.upper_right_leg] = 3
}
local _force_abort_breed_tags_special_active = {
	"elite",
	"special",
	"monster",
	"captain"
}

table.add_missing(hit_zone_priority, default_hit_zone_priority)

local light_sticky = {
	start_anim_event = "attack_hit",
	stop_anim_event = "hit_damage",
	stop_anim_event_3p = "yank_out",
	abort_anim_event = "yank_out",
	sensitivity_modifier = 1,
	damage_override_anim = "hit_damage",
	disallow_chain_actions = true,
	extra_duration = 0.4,
	abort_anim_event_3p = "yank_out",
	duration = 0.6,
	damage = {
		instances = 3,
		attack_direction_override = "push",
		damage_profile = DamageProfileTemplates.light_force_sword_sticky,
		damage_type = damage_types.warp,
		last_damage_profile = DamageProfileTemplates.light_force_sword_sticky_last,
		herding_template = HerdingTemplates.shot,
		dodge_damage_profile = DamageProfileTemplates.sticky_dodge_push
	},
	disallowed_hit_zones = melee_sticky_disallowed_hit_zones,
	disallowed_armor_types = force_sword_disallowed_armor_types,
	movement_curve = {
		{
			modifier = 0.3,
			t = 0.5
		},
		{
			modifier = 0.45,
			t = 0.55
		},
		{
			modifier = 0.35,
			t = 0.6
		},
		{
			modifier = 0.7,
			t = 1
		},
		{
			modifier = 1,
			t = 1.3
		},
		start_modifier = 0.1
	}
}
local heavy_sticky = {
	start_anim_event = "attack_hit",
	stop_anim_event = "hit_damage",
	stop_anim_event_3p = "yank_out",
	abort_anim_event = "yank_out",
	sensitivity_modifier = 1,
	damage_override_anim = "hit_damage",
	disallow_chain_actions = true,
	extra_duration = 0.4,
	abort_anim_event_3p = "yank_out",
	duration = 1,
	damage = {
		instances = 3,
		attack_direction_override = "push",
		damage_profile = DamageProfileTemplates.heavy_force_sword_sticky,
		damage_type = damage_types.warp,
		last_damage_profile = DamageProfileTemplates.heavy_force_sword_sticky_last,
		herding_template = HerdingTemplates.shot,
		dodge_damage_profile = DamageProfileTemplates.sticky_dodge_push
	},
	disallowed_hit_zones = melee_sticky_disallowed_hit_zones,
	disallowed_armor_types = melee_sticky_heavy_attack_disallowed_armor_types,
	movement_curve = {
		{
			modifier = 0.3,
			t = 0.5
		},
		{
			modifier = 0.45,
			t = 0.55
		},
		{
			modifier = 0.35,
			t = 0.6
		},
		{
			modifier = 0.5,
			t = 1
		},
		{
			modifier = 0.7,
			t = 1.4
		},
		{
			modifier = 1,
			t = 1.75
		},
		start_modifier = 0.1
	}
}
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
		total_time = 0.3,
		action_movement_curve = {
			{
				modifier = 1.2,
				t = 0.3
			},
			{
				modifier = 1,
				t = 0.4
			},
			start_modifier = 0.8
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
				action_name = "action_melee_start_left"
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_activate_special"
			},
			vent = {
				action_name = "action_vent"
			}
		}
	},
	action_melee_start_left = {
		sprint_enabled_time = 0.5,
		chain_anim_event = "heavy_charge_left_diagonal_down",
		start_input = "start_attack",
		kind = "windup",
		sprint_ready_up_time = 0,
		action_priority = 1,
		weapon_handling_template = "time_scale_1",
		allowed_during_sprint = true,
		chain_anim_event_3p = "attack_swing_charge_left_down",
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_charge_left_down",
		anim_event = "heavy_charge_left_diagonal_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.65,
				t = 0.1
			},
			{
				modifier = 0.5,
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
				modifier = 1.2,
				t = 1.2
			},
			{
				modifier = 1.3,
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
				action_name = "action_left_diagonal_light"
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block"
			},
			vent = {
				action_name = "action_vent"
			},
			special_action = {
				action_name = "action_activate_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_left_diagonal_light = {
		range_mod = 1.25,
		kind = "sweep",
		max_num_saved_entries = 20,
		first_person_hit_stop_anim = "hit_stop",
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.15,
		damage_window_end = 0.25,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left_diagonal",
		anim_event = "attack_left_diagonal_down",
		weapon_handling_template = "time_scale_1",
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		uninterruptible = true,
		total_time = 0.9,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 0.8,
				t = 0.35
			},
			{
				modifier = 0.5,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 0.65,
				t = 0.6
			},
			{
				modifier = 0.7,
				t = 1
			},
			{
				modifier = 1,
				t = 1.3
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
				chain_time = 0.45
			},
			block = {
				action_name = "action_block",
				chain_time = 0.33
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.33
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.33
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings = light_sticky,
		weapon_box = base_sweep_box,
		hit_zone_priority = hit_zone_priority,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/attack_left_diagonal_down",
			anchor_point_offset = {
				0,
				0,
				-0.125
			}
		},
		damage_profile = DamageProfileTemplates.light_force_sword,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.light_force_sword,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.left_45_slash_clean,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_left_heavy = {
		first_person_hit_stop_anim = "hit_stop",
		kind = "sweep",
		max_num_saved_entries = 20,
		range_mod = 1.25,
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.21666666666666667,
		damage_window_end = 0.2833333333333333,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_left_down",
		anim_event = "heavy_attack_left_down",
		weapon_handling_template = "time_scale_1",
		attack_direction_override = "down",
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		total_time = 0.8,
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
				chain_time = 0.5
			},
			block = {
				action_name = "action_block",
				chain_time = 0.3
			},
			special_action = {
				action_name = "action_activate_special"
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.3
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings = heavy_sticky,
		hit_zone_priority = hit_zone_priority,
		weapon_box = base_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/heavy_attack_down_left",
			anchor_point_offset = {
				0,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.heavy_force_sword_smiter,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.heavy_force_sword_smiter,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.vertical_slash_clean,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_melee_start_right = {
		kind = "windup",
		anim_event_3p = "attack_swing_charge_right",
		anim_end_event = "attack_finished",
		weapon_handling_template = "time_scale_1",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_right_diagonal_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.65,
				t = 0.1
			},
			{
				modifier = 0.5,
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
				modifier = 1.2,
				t = 1.2
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
				action_name = "action_right_diagonal_light"
			},
			heavy_attack = {
				action_name = "action_right_heavy",
				chain_time = 0.45
			},
			block = {
				action_name = "action_block"
			},
			vent = {
				action_name = "action_vent"
			},
			special_action = {
				action_name = "action_activate_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_right_diagonal_light = {
		allowed_during_sprint = true,
		kind = "sweep",
		max_num_saved_entries = 20,
		first_person_hit_stop_anim = "hit_stop",
		num_frames_before_process = 0,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.2,
		damage_window_end = 0.26666666666666666,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_up",
		anim_event = "attack_right_up",
		range_mod = 1.25,
		weapon_handling_template = "time_scale_1",
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		uninterruptible = true,
		power_level = 400,
		total_time = 0.9,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 0.8,
				t = 0.35
			},
			{
				modifier = 0.5,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 0.65,
				t = 0.6
			},
			{
				modifier = 0.7,
				t = 1
			},
			{
				modifier = 1,
				t = 1.3
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
				chain_time = 0.33
			},
			block = {
				action_name = "action_block",
				chain_time = 0.18
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.18
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.18
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings = light_sticky,
		hit_zone_priority = hit_zone_priority,
		weapon_box = base_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/attack_right_up",
			anchor_point_offset = {
				0,
				0,
				0
			}
		},
		herding_template = HerdingTemplates.uppercut,
		damage_profile = DamageProfileTemplates.light_force_sword_uppercut,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.light_force_sword_uppercut,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.left_45_slash_clean,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_right_heavy = {
		damage_window_start = 0.16666666666666666,
		hit_armor_anim = "attack_hit_shield",
		range_mod = 1.25,
		kind = "sweep",
		weapon_handling_template = "time_scale_1",
		max_num_saved_entries = 20,
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		first_person_hit_stop_anim = "hit_stop",
		damage_window_end = 0.25,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_right",
		anim_event = "heavy_attack_right_diagonal_down",
		total_time = 0.7,
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
				chain_time = 0.2
			},
			start_attack = {
				action_name = "action_melee_start_left_3",
				chain_time = 0.43
			},
			block = {
				action_name = "action_block",
				chain_time = 0.2
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.2
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.2
			}
		},
		hit_stickyness_settings = heavy_sticky,
		hit_zone_priority = hit_zone_priority,
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = base_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/heavy_attack_right_diagonal_down",
			anchor_point_offset = {
				0,
				0,
				-0.075
			}
		},
		damage_profile = DamageProfileTemplates.heavy_force_sword,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.heavy_force_sword,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.right_45_slash_clean,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_melee_start_left_2 = {
		sprint_enabled_time = 0.5,
		chain_anim_event = "heavy_charge_left_diagonal_down",
		anim_event_3p = "attack_swing_charge_left_down",
		kind = "windup",
		sprint_ready_up_time = 0,
		chain_anim_event_3p = "attack_swing_charge_left_down",
		anim_end_event = "attack_finished",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_left_diagonal_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.65,
				t = 0.1
			},
			{
				modifier = 0.5,
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
				modifier = 1.2,
				t = 1.2
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
				action_name = "action_left_down_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block"
			},
			vent = {
				action_name = "action_vent"
			},
			special_action = {
				action_name = "action_activate_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_left_down_light = {
		allowed_during_sprint = true,
		kind = "sweep",
		max_num_saved_entries = 20,
		first_person_hit_stop_anim = "hit_stop",
		num_frames_before_process = 0,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.2,
		damage_window_end = 0.26666666666666666,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_stab_01",
		anim_event = "attack_stab_01",
		range_mod = 1.25,
		weapon_handling_template = "time_scale_1",
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		uninterruptible = true,
		total_time = 0.75,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 0.8,
				t = 0.35
			},
			{
				modifier = 0.5,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 1,
				t = 0.6
			},
			{
				modifier = 1,
				t = 1
			},
			{
				modifier = 1.6,
				t = 1.3
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
				action_name = "action_melee_start_left",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block",
				chain_time = 0.33
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.33
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.33
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings = light_sticky,
		weapon_box = stab_sweep_box,
		hit_zone_priority = hit_zone_priority,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/attack_stab",
			anchor_point_offset = {
				0,
				0,
				-0.05
			}
		},
		herding_template = HerdingTemplates.stab,
		damage_profile = DamageProfileTemplates.light_force_sword_stab,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.light_force_sword_stab,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.default,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_melee_start_left_3 = {
		sprint_enabled_time = 0.5,
		chain_anim_event = "heavy_charge_left_diagonal_down",
		anim_event_3p = "attack_swing_charge_left_down",
		kind = "windup",
		sprint_ready_up_time = 0,
		chain_anim_event_3p = "attack_swing_charge_left_down",
		anim_end_event = "attack_finished",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_left_diagonal_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.65,
				t = 0.1
			},
			{
				modifier = 0.5,
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
				modifier = 1.2,
				t = 1.2
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
				action_name = "action_left_slide_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block"
			},
			vent = {
				action_name = "action_vent"
			},
			special_action = {
				action_name = "action_activate_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_melee_start_slide = {
		anim_event_3p = "attack_swing_charge_left_down",
		chain_anim_event = "heavy_charge_left_diagonal_down",
		start_input = "start_attack",
		kind = "windup",
		sprint_ready_up_time = 0,
		action_priority = 2,
		invalid_start_action_for_stat_calculation = true,
		sprint_requires_press_to_interrupt = true,
		sprint_enabled_time = 0.5,
		anim_end_event = "attack_finished",
		allowed_during_sprint = true,
		chain_anim_event_3p = "attack_swing_charge_left_down",
		uninterruptible = true,
		anim_event = "heavy_charge_left_diagonal_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.65,
				t = 0.1
			},
			{
				modifier = 0.5,
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
				modifier = 1.2,
				t = 1.2
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
				action_name = "action_left_slide_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_left_heavy",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block"
			},
			vent = {
				action_name = "action_vent"
			},
			special_action = {
				action_name = "action_activate_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		action_condition_func = function (action_settings, condition_func_params, used_input)
			return condition_func_params.movement_state_component.method == "sliding"
		end
	},
	action_left_slide_light = {
		first_person_hit_stop_anim = "hit_stop",
		kind = "sweep",
		max_num_saved_entries = 20,
		range_mod = 1.25,
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.2,
		damage_window_end = 0.26666666666666666,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left_diagonal",
		anim_event = "attack_left_diagonal_up",
		weapon_handling_template = "time_scale_1",
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		total_time = 0.75,
		action_movement_curve = {
			{
				modifier = 1.15,
				t = 0.2
			},
			{
				modifier = 0.8,
				t = 0.35
			},
			{
				modifier = 0.5,
				t = 0.5
			},
			{
				modifier = 0.45,
				t = 0.55
			},
			{
				modifier = 1,
				t = 0.6
			},
			{
				modifier = 1,
				t = 1
			},
			{
				modifier = 1.6,
				t = 1.3
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
				chain_time = 0.6
			},
			block = {
				action_name = "action_block",
				chain_time = 0.33
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.33
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.33
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings = light_sticky,
		weapon_box = stab_sweep_box,
		hit_zone_priority = hit_zone_priority,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/force_sword/attack_left_diagonal_up",
			anchor_point_offset = {
				0,
				0,
				-0.1
			}
		},
		herding_template = HerdingTemplates.uppercut,
		damage_profile = DamageProfileTemplates.light_force_sword,
		damage_profile_special_active = DamageProfileTemplates.heavy_force_sword_flat,
		damage_profile_on_abort = DamageProfileTemplates.light_force_sword,
		damage_type = damage_types.metal_slashing_light,
		damage_type_special_active = damage_types.slashing_force,
		damage_type_on_abort = damage_types.metal_slashing_light,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active,
		wounds_shape = wounds_shapes.default,
		wounds_shape_special_active = wounds_shapes.default
	},
	action_block = {
		weapon_handling_template = "time_scale_1_65",
		minimum_hold_time = 0.3,
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
				modifier = 0.62,
				t = 0.3
			},
			{
				modifier = 0.6,
				t = 0.325
			},
			{
				modifier = 0.61,
				t = 0.35
			},
			{
				modifier = 0.75,
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
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			push = {
				action_name = "action_push"
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.3
			}
		}
	},
	action_push = {
		block_duration = 0.5,
		push_radius = 2.75,
		kind = "push",
		weapon_handling_template = "time_scale_1",
		anim_event = "attack_push",
		total_time = 0.4,
		action_movement_curve = {
			{
				modifier = 1.2,
				t = 0.1
			},
			{
				modifier = 0.8,
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
				action_name = "action_find_target",
				chain_time = 0.1
			},
			block = {
				action_name = "action_block",
				chain_time = 0.4
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.4
			},
			special_action = {
				action_name = "action_activate_special",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.45
			}
		},
		inner_push_rad = math.pi * 0.25,
		outer_push_rad = math.pi * 1,
		inner_damage_profile = DamageProfileTemplates.default_push,
		inner_damage_type = damage_types.warp,
		outer_damage_profile = DamageProfileTemplates.light_push,
		outer_damage_type = damage_types.warp,
		fx = {
			fx_source = "fx_left_hand_offset_fwd",
			vfx_effect = "content/fx/particles/weapons/swords/forcesword/psyker_parry"
		},
		haptic_trigger_template = HapticTriggerTemplates.melee.push
	},
	action_find_target = {
		prevent_sprint = true,
		charge_template = "forcesword_p1_m1_charge_single_target",
		target_finder_module_class_name = "smart_target_targeting",
		kind = "target_finder",
		sprint_ready_up_time = 0.25,
		allowed_during_sprint = false,
		stop_input = "find_target_release",
		total_time = 0.15,
		action_movement_curve = {
			{
				modifier = 0.4,
				t = 0.1
			},
			{
				modifier = 0.4,
				t = 0.15
			},
			{
				modifier = 0.6,
				t = 0.2
			},
			{
				modifier = 0.4,
				t = 1
			},
			start_modifier = 1
		},
		targeting_fx = {
			wwise_parameter_name = "charge_level",
			wwise_event_stop = "wwise/events/weapon/stop_force_staff_single_target",
			has_husk_events = false,
			wwise_event_start = "wwise/events/weapon/play_force_staff_single_target",
			husk_effect_name = "content/fx/particles/weapons/force_staff/force_staff_channel_charge_husk",
			effect_name = "content/fx/particles/weapons/force_staff/force_staff_channel_charge"
		},
		smart_targeting_template = SmartTargetingTemplates.force_sword_single_target,
		conditional_state_to_action_input = {
			auto_chain = {
				input_name = "fling_target"
			}
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			fling_target = {
				action_name = "action_fling_target",
				chain_time = 0.1
			},
			block = {
				action_name = "action_block"
			}
		}
	},
	action_fling_target = {
		pay_warp_charge_time = 0.15,
		use_charge_level = false,
		kind = "damage_target",
		charge_template = "forcesword_p1_m1_fling",
		anim_event = "parry_push_finish",
		prevent_sprint = true,
		total_time = 0.4,
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
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.65
			},
			block = {
				action_name = "action_block",
				chain_time = 0.25
			}
		},
		damage_profile = DamageProfileTemplates.force_sword_push_followup_fling,
		damage_type = damage_types.warp,
		herding_template = HerdingTemplates.force_push,
		fx = {
			fx_source = "fx_left_hand_offset_fwd",
			vfx_effect = "content/fx/particles/weapons/swords/forcesword/psyker_push"
		}
	},
	action_vent = {
		weapon_handling_template = "time_scale_1",
		start_input = "vent",
		vent_source_name = "fx_left_hand",
		kind = "vent_warp_charge",
		allowed_during_sprint = true,
		prevent_sprint = true,
		vent_vfx = "content/fx/particles/abilities/psyker_venting",
		anim_end_event = "vent_end",
		vo_tag = "ability_venting",
		abort_sprint = true,
		uninterruptible = true,
		anim_event = "vent_start",
		stop_input = "vent_release",
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 0.4,
				t = 0.1
			},
			{
				modifier = 0.3,
				t = 0.15
			},
			{
				modifier = 0.5,
				t = 0.4
			},
			{
				modifier = 0.85,
				t = 5
			},
			start_modifier = 1
		},
		running_action_state_to_action_input = {
			fully_vented = {
				input_name = "vent_release"
			}
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.15
			}
		},
		haptic_trigger_template = HapticTriggerTemplates.melee.none
	},
	action_activate_special = {
		kind = "activate_special",
		activation_cooldown = 3,
		start_input = "special_action",
		pre_activation_vfx_node = "slot_primary_block",
		activation_time = 0.4,
		charge_template = "forcesword_p1_m1_weapon_special_hit",
		pre_activation_vfx_name = "content/fx/particles/weapons/swords/forcesword/psyker_activate_forcesword",
		allowed_during_sprint = true,
		anim_event = "activate",
		skip_3p_anims = false,
		total_time = 0.7
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

weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/force_sword"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/force_sword"
weapon_template.weapon_box = base_sweep_box
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = false
}
weapon_template.sprint_ready_up_time = 0.1
weapon_template.max_first_person_anim_movement_speed = 5.8
weapon_template.weapon_special_class = "WeaponSpecialWarpChargedAttacks"
weapon_template.weapon_special_tweak_data = {
	keep_active_on_vault = true,
	keep_active_on_sprint = true,
	keep_active_on_stun = true,
	active_duration = 3
}
weapon_template.damage_window_start_sweep_trail_offset = -0.45
weapon_template.damage_window_end_sweep_trail_offset = 0.45
weapon_template.ammo_template = "no_ammo"
weapon_template.fx_sources = {
	_sticky = "fx_sticky_force",
	_sweep = "fx_sweep",
	_special_active = "fx_special_active",
	_block = "fx_block"
}
weapon_template.crosshair = {
	crosshair_type = "dot"
}
weapon_template.hit_marker_type = "center"
weapon_template.keywords = {
	"melee",
	"force_sword",
	"p1",
	"activated"
}
weapon_template.dodge_template = "psyker_ninja"
weapon_template.sprint_template = "default"
weapon_template.stamina_template = "forcesword_p1_m1"
weapon_template.toughness_template = "default"
weapon_template.warp_charge_template = "forcesword_p1_m1"
weapon_template.movement_curve_modifier_template = "forcesword_p1_m1"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.forcesword
weapon_template.smart_targeting_template = SmartTargetingTemplates.default_melee
weapon_template.haptic_trigger_template = HapticTriggerTemplates.melee.light
weapon_template.overclocks = {
	warp_charge_cost_up_dps_down = {
		forcesword_p1_m1_dps_stat = -0.1,
		forcesword_p1_m1_warp_charge_cost_stat = 0.1
	},
	finesse_up_warp_charge_cost_down = {
		forcesword_p1_m1_finesse_stat = 0.2,
		forcesword_p1_m1_warp_charge_cost_stat = -0.2
	},
	first_target_up_warp_charge_cost_down = {
		forcesword_p1_m1_first_target_stat = 0.1,
		forcesword_p1_m1_warp_charge_cost_stat = -0.1
	},
	mobility_up_first_target_down = {
		forcesword_p1_m1_first_target_stat = -0.1,
		forcesword_p1_m1_mobility_stat = 0.1
	},
	dps_up_mobility_down = {
		forcesword_p1_m1_mobility_stat = -0.1,
		forcesword_p1_m1_dps_stat = 0.1
	}
}
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	forcesword_p1_m1_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_left_diagonal_light = {
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
			action_left_heavy = {
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
			action_right_diagonal_light = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_right_heavy = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_left_down_light = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_left_slide_light = {
				damage_trait_templates.default_melee_dps_stat
			}
		}
	},
	forcesword_p1_m1_finesse_stat = {
		display_name = "loc_stats_display_finesse_stat",
		is_stat_trait = true,
		damage = {
			action_left_diagonal_light = {
				damage_trait_templates.default_melee_finesse_stat,
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
				damage_trait_templates.default_melee_finesse_stat,
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
			action_right_diagonal_light = {
				damage_trait_templates.default_melee_finesse_stat
			},
			action_right_heavy = {
				damage_trait_templates.default_melee_finesse_stat
			},
			action_left_down_light = {
				damage_trait_templates.default_melee_finesse_stat
			},
			action_left_slide_light = {
				damage_trait_templates.default_melee_finesse_stat
			}
		},
		weapon_handling = {
			action_left_diagonal_light = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						time_scale = {}
					}
				}
			},
			action_left_heavy = {
				weapon_handling_trait_templates.default_finesse_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						time_scale = {}
					}
				}
			},
			action_right_diagonal_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_right_heavy = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_down_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_slide_light = {
				weapon_handling_trait_templates.default_finesse_stat
			}
		}
	},
	forcesword_p1_m1_first_target_stat = {
		display_name = "loc_stats_display_first_target_stat",
		is_stat_trait = true,
		damage = {
			action_left_diagonal_light = {
				damage_trait_templates.default_first_target_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
					display_stats = {
						targets = {
							{
								power_level_multiplier = {}
							}
						}
					}
				}
			},
			action_left_heavy = {
				damage_trait_templates.default_first_target_stat,
				display_data = {
					prefix = "loc_weapon_action_title_heavy",
					display_stats = {
						targets = {
							{
								power_level_multiplier = {}
							}
						}
					}
				}
			},
			action_right_diagonal_light = {
				damage_trait_templates.default_first_target_stat
			},
			action_right_heavy = {
				damage_trait_templates.default_first_target_stat
			},
			action_left_down_light = {
				damage_trait_templates.default_first_target_stat
			},
			action_left_slide_light = {
				damage_trait_templates.default_first_target_stat
			}
		}
	},
	forcesword_p1_m1_weapon_special_warp_charge_cost = {
		display_name = "loc_stats_display_warp_resist_stat",
		is_stat_trait = true,
		charge = {
			action_activate_special = {
				charge_trait_templates.forcesword_p1_m1_weapon_special_warp_charge_cost,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		}
	},
	forcesword_p1_m1_mobility_stat = {
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
local bespoke_forcesword_p1_traits = table.ukeys(WeaponTraitsBespokeForceswordP1)

table.append(weapon_template.traits, bespoke_forcesword_p1_traits)

weapon_template.perks = {
	forcesword_p1_m1_dps_perk = {
		display_name = "loc_trait_display_forcesword_p1_m1_dps_perk",
		damage = {
			action_left_diagonal_light = {
				damage_trait_templates.default_melee_dps_perk
			},
			action_left_heavy = {
				damage_trait_templates.default_melee_dps_perk
			},
			action_right_diagonal_light = {
				damage_trait_templates.default_melee_dps_perk
			},
			action_right_heavy = {
				damage_trait_templates.default_melee_dps_perk
			},
			action_left_down_light = {
				damage_trait_templates.default_melee_dps_perk
			},
			action_left_slide_light = {
				damage_trait_templates.default_melee_dps_perk
			}
		}
	},
	forcesword_p1_m1_finesse_perk = {
		display_name = "loc_trait_display_forcesword_p1_m1_finesse_perk",
		damage = {
			action_left_diagonal_light = {
				damage_trait_templates.default_melee_finesse_perk
			},
			action_left_heavy = {
				damage_trait_templates.default_melee_finesse_perk
			},
			action_right_diagonal_light = {
				damage_trait_templates.default_melee_finesse_perk
			},
			action_right_heavy = {
				damage_trait_templates.default_melee_finesse_perk
			},
			action_left_down_light = {
				damage_trait_templates.default_melee_finesse_perk
			},
			action_left_slide_light = {
				damage_trait_templates.default_melee_finesse_perk
			}
		},
		weapon_handling = {
			action_left_diagonal_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_heavy = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_right_diagonal_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_right_heavy = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_down_light = {
				weapon_handling_trait_templates.default_finesse_stat
			},
			action_left_slide_light = {
				weapon_handling_trait_templates.default_finesse_stat
			}
		}
	},
	forcesword_p1_m1_first_target_perk = {
		display_name = "loc_trait_display_forcesword_p1_m1_first_target_perk",
		damage = {
			action_left_diagonal_light = {
				damage_trait_templates.default_melee_first_target_perk
			},
			action_left_heavy = {
				damage_trait_templates.default_melee_first_target_perk
			},
			action_right_diagonal_light = {
				damage_trait_templates.default_melee_first_target_perk
			},
			action_right_heavy = {
				damage_trait_templates.default_melee_first_target_perk
			},
			action_left_down_light = {
				damage_trait_templates.default_melee_first_target_perk
			},
			action_left_slide_light = {
				damage_trait_templates.default_melee_first_target_perk
			}
		}
	},
	forcesword_p1_m1_warp_charge_cost_perk = {
		display_name = "loc_trait_display_forcesword_p1_m1_warp_charge_cost_perk",
		damage = {
			action_fling_target = {
				charge_trait_templates.forcesword_p1_m1_warp_charge_cost_perk
			},
			action_find_target = {
				charge_trait_templates.forcesword_p1_m1_warp_charge_cost_perk
			}
		}
	},
	forcesword_p1_m1_mobility_perk = {
		display_name = "loc_trait_display_forcesword_p1_m1_mobility_perk",
		dodge = {
			base = {
				dodge_trait_templates.default_dodge_perk
			}
		},
		sprint = {
			base = {
				sprint_trait_templates.default_sprint_perk
			}
		},
		movement_curve_modifier = {
			base = {
				movement_curve_modifier_trait_templates.default_movement_curve_modifier_perk
			}
		}
	}
}
weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_fast_attack"
	},
	{
		display_name = "loc_weapon_keyword_warp_weapon"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		display_name = "loc_gestalt_ninja_fencer",
		type = "ninja_fencer",
		attack_chain = {
			"ninja_fencer",
			"ninja_fencer",
			"smiter"
		}
	},
	secondary = {
		display_name = "loc_gestalt_smiter",
		type = "smiter",
		attack_chain = {
			"smiter",
			"linesman"
		}
	},
	special = {
		desc = "loc_stats_special_action_powerup_desc",
		display_name = "loc_forcesword_p1_m1_attack_special",
		type = "activate"
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
		icon = "activate",
		header = "activate_warp"
	}
}

function weapon_template.weapon_special_action_none_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")
	local correct_scenario = scenario_system:get_current_scenario_name() == "weapon_special"
	local player_unit = player.player_unit
	local unit_data_ext = ScriptUnit.extension(player_unit, "unit_data_system")
	local inventory_slot_component = unit_data_ext:read_component(wielded_slot_id)
	local special_active = inventory_slot_component.special_active

	return correct_scenario and not special_active
end

function weapon_template.weapon_special_action_revved_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")
	local correct_scenario = scenario_system:get_current_scenario_name() == "weapon_special"
	local player_unit = player.player_unit
	local unit_data_ext = ScriptUnit.extension(player_unit, "unit_data_system")
	local inventory_slot_component = unit_data_ext:read_component(wielded_slot_id)
	local special_active = inventory_slot_component.special_active

	return correct_scenario and special_active
end

return weapon_template
