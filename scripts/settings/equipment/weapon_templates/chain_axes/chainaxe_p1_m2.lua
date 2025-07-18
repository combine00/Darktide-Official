local ActionSweepSettings = require("scripts/settings/equipment/action_sweep_settings")
local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local ChainSpeedTemplates = require("scripts/settings/equipment/chain_speed_templates")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HerdingTemplates = require("scripts/settings/damage/herding_templates")
local HitZone = require("scripts/utilities/attack/hit_zone")
local MeleeActionInputSetupMid = require("scripts/settings/equipment/weapon_templates/melee_action_input_setup_mid")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokeChainaxeP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_chainaxe_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local WoundsSettings = require("scripts/settings/wounds/wounds_settings")
local armor_types = ArmorSettings.types
local buff_stat_buffs = BuffSettings.stat_buffs
local buff_targets = WeaponTweakTemplateSettings.buff_targets
local damage_types = DamageSettings.damage_types
local default_hit_zone_priority = ActionSweepSettings.default_hit_zone_priority
local hit_zone_names = HitZone.hit_zone_names
local template_types = WeaponTweakTemplateSettings.template_types
local wield_inputs = PlayerCharacterConstants.wield_inputs
local wounds_shapes = WoundsSettings.shapes
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local stamina_trait_templates = WeaponTraitTemplates[template_types.stamina]
local toughness_trait_templates = WeaponTraitTemplates[template_types.toughness]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local weapon_template = {
	action_inputs = table.clone(MeleeActionInputSetupMid.action_inputs),
	action_input_hierarchy = table.clone(MeleeActionInputSetupMid.action_input_hierarchy)
}
local chain_axe_sweep_box = {
	0.15,
	0.15,
	1
}
local melee_sticky_disallowed_hit_zones = {}
local melee_sticky_heavy_attack_disallowed_armor_types = {}
local hit_zone_priority = {
	[hit_zone_names.head] = 1,
	[hit_zone_names.torso] = 2,
	[hit_zone_names.upper_left_arm] = 3,
	[hit_zone_names.upper_right_arm] = 3,
	[hit_zone_names.upper_left_leg] = 3,
	[hit_zone_names.upper_right_leg] = 3
}

table.add_missing(hit_zone_priority, default_hit_zone_priority)

local _force_abort_breed_tags_special_active = {
	"elite",
	"special",
	"monster",
	"captain"
}
local hit_stickyness_settings_heavy = {
	disable_vertical_force_view = true,
	start_anim_event = "attack_hit_stick",
	stop_anim_event = "yank_out",
	sensitivity_modifier = 0.3,
	disallow_chain_actions = true,
	duration = 0.35,
	always_sticky = true,
	damage = {
		instances = 3,
		damage_profile = DamageProfileTemplates.heavy_chainaxe_sticky,
		damage_type = damage_types.sawing_stuck,
		last_damage_profile = DamageProfileTemplates.heavy_chainaxe_sticky_last_quick
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
			modifier = 0.5,
			t = 0.6
		},
		{
			modifier = 0.6,
			t = 1
		},
		{
			modifier = 0.5,
			t = 1.3
		},
		start_modifier = 0.1
	}
}
local hit_stickyness_settings_heavy_special = {
	start_anim_event = "attack_hit_stick",
	stop_anim_event = "yank_out",
	sensitivity_modifier = 0.4,
	disallow_chain_actions = true,
	duration = 1.2,
	damage = {
		instances = 4,
		damage_profile = DamageProfileTemplates.heavy_chainaxe_active_sticky,
		damage_type = damage_types.sawing_stuck,
		last_damage_profile = DamageProfileTemplates.heavy_chainaxe_active_sticky_last,
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
			modifier = 0.5,
			t = 0.6
		},
		{
			modifier = 0.6,
			t = 1
		},
		{
			modifier = 0.5,
			t = 1.3
		},
		start_modifier = 0.1
	}
}
local hit_stickyness_settings_light = {
	disable_vertical_force_view = true,
	start_anim_event = "attack_hit_stick",
	stop_anim_event = "yank_out",
	sensitivity_modifier = 0.9,
	disallow_chain_actions = true,
	duration = 0.3,
	always_sticky = true,
	damage = {
		instances = 1,
		damage_profile = DamageProfileTemplates.light_chainaxe_sticky,
		damage_type = damage_types.sawing_stuck,
		last_damage_profile = DamageProfileTemplates.light_chainaxe_sticky_last_quick_m2
	},
	disallowed_hit_zones = melee_sticky_disallowed_hit_zones,
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
		start_modifier = 0.1
	}
}
local hit_stickyness_settings_light_special = {
	start_anim_event = "attack_hit_stick",
	stop_anim_event = "yank_out",
	sensitivity_modifier = 0.1,
	disallow_chain_actions = true,
	duration = 0.85,
	always_sticky = true,
	damage = {
		instances = 3,
		damage_profile = DamageProfileTemplates.light_chainaxe_active_sticky,
		damage_type = damage_types.sawing_stuck,
		last_damage_profile = DamageProfileTemplates.light_chainaxe_active_sticky_last,
		dodge_damage_profile = DamageProfileTemplates.sticky_dodge_push
	},
	disallowed_hit_zones = melee_sticky_disallowed_hit_zones,
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
		uninterruptible = true,
		kind = "wield",
		sprint_ready_up_time = 0,
		allowed_during_sprint = true,
		anim_event = "equip",
		total_time = 0.5,
		powered_weapon_intensity = {
			start_intensity = 0.1
		},
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.3
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
				action_name = "action_melee_start_left"
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_toggle_special"
			}
		}
	},
	action_melee_start_left = {
		kind = "windup",
		anim_event_3p = "attack_swing_charge_down",
		start_input = "start_attack",
		anim_end_event = "attack_finished",
		action_priority = 1,
		allowed_during_sprint = true,
		anim_event = "heavy_charge_down_v01",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.6,
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
				modifier = 0.9,
				t = 1.2
			},
			start_modifier = 1
		},
		powered_weapon_intensity = {
			start_intensity = 0.8
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
				action_name = "action_heavy_1",
				chain_time = 0.6
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_toggle_special"
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
		range_mod = 1.25,
		num_frames_before_process = 0,
		first_person_hit_anim = "hit_left_shake",
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.3,
		damage_window_end = 0.4,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_left_diagonal",
		anim_event = "attack_left_diagonal_down",
		weapon_handling_template = "time_scale_1",
		uninterruptible = true,
		hit_stop_anim = "hit_stop",
		total_time = 1.3,
		action_movement_curve = {
			{
				modifier = 1.25,
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
			start_modifier = 1.1
		},
		powered_weapon_intensity = {
			start_intensity = 0
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
				chain_time = 0.45,
				action_name = "action_block",
				chain_until = 0.1
			},
			special_action = {
				action_name = "action_toggle_special",
				chain_time = 0.45
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		weapon_box = chain_axe_sweep_box,
		hit_stickyness_settings_special_active = hit_stickyness_settings_light_special,
		hit_zone_priority = hit_zone_priority,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/chain_axe/attack_left_diagonal",
			anchor_point_offset = {
				0,
				0.2,
				-0.4
			}
		},
		damage_profile_on_abort = DamageProfileTemplates.light_chainaxe_tank,
		damage_type_on_abort = damage_types.sawing,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		damage_profile = DamageProfileTemplates.light_chainaxe_tank,
		damage_type = damage_types.blunt,
		wounds_shape = wounds_shapes.left_45_slash_coarse,
		wounds_shape_special_active = wounds_shapes.default,
		damage_profile_special_active = DamageProfileTemplates.light_chainaxe_active,
		damage_type_special_active = damage_types.sawing_stuck,
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active
	},
	action_heavy_1 = {
		allowed_during_sprint = true,
		kind = "sweep",
		max_num_saved_entries = 20,
		first_person_hit_anim = "hit_left_shake",
		num_frames_before_process = 0,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.18333333333333332,
		damage_window_end = 0.3,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_down",
		anim_event = "heavy_attack_down",
		range_mod = 1.25,
		weapon_handling_template = "time_scale_1_1",
		uninterruptible = true,
		hit_stop_anim = "hit_stop",
		total_time = 1,
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
		powered_weapon_intensity = {
			{
				intensity = 0,
				t = 0.25
			},
			start_intensity = 1
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
				chain_time = 0.54
			},
			block = {
				chain_time = 0.45,
				action_name = "action_block",
				chain_until = 0.1
			},
			special_action = {
				action_name = "action_toggle_special"
			}
		},
		hit_stickyness_settings = hit_stickyness_settings_heavy,
		hit_stickyness_settings_special_active = hit_stickyness_settings_heavy_special,
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = chain_axe_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/chain_axe/heavy_attack_down",
			anchor_point_offset = {
				-0,
				0,
				0
			}
		},
		damage_profile = DamageProfileTemplates.heavy_chainaxe_smiter,
		damage_type = damage_types.sawing,
		damage_profile_on_abort = DamageProfileTemplates.heavy_chainaxe_smiter,
		damage_type_on_abort = damage_types.sawing,
		damage_profile_special_active = DamageProfileTemplates.heavy_chainaxe_active,
		damage_type_special_active = damage_types.sawing_stuck,
		wounds_shape_special_active = wounds_shapes.default,
		wounds_shape = wounds_shapes.vertical_slash_coarse,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active
	},
	action_melee_start_right = {
		anim_event_3p = "attack_swing_charge_left",
		anim_end_event = "attack_finished",
		kind = "windup",
		allowed_during_sprint = true,
		anim_event = "heavy_charge_left_down",
		stop_input = "attack_cancel",
		total_time = 3,
		action_movement_curve = {
			{
				modifier = 0.75,
				t = 0.05
			},
			{
				modifier = 0.6,
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
				modifier = 0.9,
				t = 1.2
			},
			start_modifier = 1
		},
		powered_weapon_intensity = {
			start_intensity = 0.8
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
				action_name = "action_right_diagonal_light",
				chain_time = 0
			},
			heavy_attack = {
				action_name = "action_heavy_2",
				chain_time = 0.55
			},
			block = {
				action_name = "action_block"
			},
			special_action = {
				action_name = "action_toggle_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end
	},
	action_right_diagonal_light = {
		range_mod = 1.25,
		kind = "sweep",
		max_num_saved_entries = 20,
		allowed_during_sprint = true,
		num_frames_before_process = 0,
		first_person_hit_anim = "hit_left_shake",
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.4,
		damage_window_end = 0.5,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_right_diagonal",
		anim_event = "attack_right_diagonal_down",
		weapon_handling_template = "time_scale_1",
		uninterruptible = true,
		hit_stop_anim = "hit_stop",
		total_time = 1.5,
		action_movement_curve = {
			{
				modifier = 1.25,
				t = 0.2
			},
			{
				modifier = 0.8,
				t = 0.35
			},
			{
				modifier = 0.6,
				t = 0.5
			},
			{
				modifier = 0.55,
				t = 0.55
			},
			{
				modifier = 0.7,
				t = 0.6
			},
			{
				modifier = 0.75,
				t = 1
			},
			{
				modifier = 1,
				t = 1.3
			},
			start_modifier = 1.1
		},
		powered_weapon_intensity = {
			start_intensity = 0
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
				chain_time = 0.74
			},
			block = {
				action_name = "action_block",
				chain_time = 0.45
			},
			special_action = {
				action_name = "action_toggle_special"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings_special_active = hit_stickyness_settings_light_special,
		hit_zone_priority = hit_zone_priority,
		weapon_box = chain_axe_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/chain_axe/attack_right_diagonal_down",
			anchor_point_offset = {
				0,
				0,
				-0.1
			}
		},
		damage_profile = DamageProfileTemplates.light_chainaxe_tank,
		damage_type = damage_types.blunt,
		damage_profile_on_abort = DamageProfileTemplates.light_chainaxe_tank,
		damage_type_on_abort = damage_types.sawing,
		damage_profile_special_active = DamageProfileTemplates.light_chainaxe_active,
		damage_type_special_active = damage_types.sawing_stuck,
		wounds_shape_special_active = wounds_shapes.default,
		wounds_shape = wounds_shapes.horizontal_slash_coarse,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active
	},
	action_heavy_2 = {
		kind = "sweep",
		max_num_saved_entries = 20,
		first_person_hit_anim = "hit_left_shake",
		range_mod = 1.25,
		num_frames_before_process = 0,
		hit_armor_anim = "attack_hit_shield",
		damage_window_start = 0.23333333333333334,
		damage_window_end = 0.4,
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_heavy_down_left",
		anim_event = "heavy_attack_left_down",
		weapon_handling_template = "time_scale_1",
		uninterruptible = true,
		hit_stop_anim = "hit_stop",
		total_time = 1,
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
		powered_weapon_intensity = {
			{
				intensity = 0,
				t = 0.25
			},
			start_intensity = 1
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield",
				chain_time = 0.35
			},
			start_attack = {
				action_name = "action_melee_start_left",
				chain_time = 0.53
			},
			block = {
				chain_time = 0.4,
				action_name = "action_block",
				chain_until = 0.1
			},
			special_action = {
				action_name = "action_toggle_special",
				chain_time = 0.35
			}
		},
		hit_stickyness_settings = hit_stickyness_settings_heavy,
		hit_stickyness_settings_special_active = hit_stickyness_settings_heavy_special,
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_zone_priority = hit_zone_priority,
		weapon_box = chain_axe_sweep_box,
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/chain_axe/heavy_attack_left_down",
			anchor_point_offset = {
				0,
				0,
				-0.44
			}
		},
		damage_profile = DamageProfileTemplates.heavy_chainaxe_smiter,
		damage_type = damage_types.sawing,
		damage_profile_on_abort = DamageProfileTemplates.heavy_chainaxe_smiter,
		damage_type_on_abort = damage_types.sawing,
		damage_profile_special_active = DamageProfileTemplates.heavy_chainaxe_active,
		damage_type_special_active = damage_types.sawing_stuck,
		wounds_shape_special_active = wounds_shapes.default,
		wounds_shape = wounds_shapes.right_45_slash_coarse,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active
	},
	action_block = {
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
		powered_weapon_intensity = {
			{
				intensity = 0,
				t = 0.1
			},
			start_intensity = 0
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
				action_name = "action_toggle_special"
			}
		}
	},
	action_right_light_pushfollow = {
		damage_window_start = 0.28,
		hit_armor_anim = "attack_hit_shield",
		anim_end_event = "attack_finished",
		anim_event_3p = "attack_swing_stab",
		kind = "sweep",
		max_num_saved_entries = 20,
		range_mod = 1.35,
		weapon_handling_template = "time_scale_1",
		num_frames_before_process = 0,
		allowed_during_sprint = true,
		damage_window_end = 0.4,
		attack_direction_override = "push",
		uninterruptible = true,
		anim_event = "attack_stab_02",
		hit_stop_anim = "hit_stop",
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
				modifier = 0.45,
				t = 0.45
			},
			{
				modifier = 0.6,
				t = 0.65
			},
			{
				modifier = 1,
				t = 1
			},
			start_modifier = 1.4
		},
		powered_weapon_intensity = {
			start_intensity = 0
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
				chain_time = 0.49
			},
			special_action = {
				action_name = "action_toggle_special",
				chain_time = 0.4
			},
			block = {
				action_name = "action_block",
				chain_time = 0.5
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return end_reason ~= "new_interrupting_action" and end_reason ~= "action_complete"
		end,
		hit_stickyness_settings_special_active = hit_stickyness_settings_light_special,
		hit_zone_priority = hit_zone_priority,
		weapon_box = {
			0.3,
			0.3,
			0.9
		},
		spline_settings = {
			matrices_data_location = "content/characters/player/human/first_person/animations/axe/attack_stab",
			anchor_point_offset = {
				0.2,
				0,
				-0.125
			}
		},
		damage_profile = DamageProfileTemplates.chainaxe_light_stab,
		damage_type = damage_types.sawing,
		damage_profile_special_active = DamageProfileTemplates.light_chainaxe_active,
		damage_type_special_active = damage_types.sawing_stuck,
		wounds_shape_special_active = wounds_shapes.default,
		wounds_shape = wounds_shapes.default,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		force_abort_breed_tags_special_active = _force_abort_breed_tags_special_active
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
				chain_time = 0.3
			},
			block = {
				action_name = "action_block",
				chain_time = 0.7
			},
			special_action = {
				action_name = "action_toggle_special",
				chain_time = 0.4
			},
			start_attack = {
				action_name = "action_melee_start_right",
				chain_time = 0.5
			}
		},
		inner_push_rad = math.pi * 0.25,
		outer_push_rad = math.pi * 1,
		inner_damage_profile = DamageProfileTemplates.default_push,
		inner_damage_type = damage_types.physical,
		outer_damage_profile = DamageProfileTemplates.light_push,
		outer_damage_type = damage_types.physical,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.melee_attack_speed
		},
		haptic_trigger_template = HapticTriggerTemplates.melee.push
	},
	action_toggle_special = {
		deactivate_anim_event = "deactivate",
		total_time_deactivate = 0.45,
		activate_anim_event = "activate",
		activation_time = 0.3,
		kind = "toggle_special",
		start_input = "special_action",
		deactivation_time = 0.1,
		allowed_during_sprint = true,
		skip_3p_anims = false,
		total_time = 0.6
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

weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/power_sword"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/chain_axe"
weapon_template.weapon_box = chain_axe_sweep_box
weapon_template.chain_speed_template = ChainSpeedTemplates.chainaxe
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = false
}
weapon_template.sprint_ready_up_time = 0.1
weapon_template.max_first_person_anim_movement_speed = 5.8
weapon_template.damage_window_start_sweep_trail_offset = -0.2
weapon_template.damage_window_end_sweep_trail_offset = 0.2
weapon_template.ammo_template = "no_ammo"
weapon_template.weapon_special_class = "WeaponSpecialDeactivateAfterNumActivations"
weapon_template.weapon_special_tweak_data = {
	keep_active_on_sprint = true,
	keep_active_on_vault = true,
	num_activations = 1,
	keep_active_on_stun = true,
	active_duration = 4
}
weapon_template.fx_sources = {
	_sticky = "fx_sawing",
	_special_active = "fx_weapon_special",
	_melee_idling = "fx_engine",
	_block = "fx_block",
	_sweep = "fx_sweep"
}
weapon_template.crosshair = {
	crosshair_type = "dot"
}
weapon_template.hit_marker_type = "center"
weapon_template.keywords = {
	"melee",
	"chain_axe",
	"p1",
	"activated"
}
weapon_template.dodge_template = "smiter_plus"
weapon_template.sprint_template = "default"
weapon_template.stamina_template = "linesman"
weapon_template.toughness_template = "default"
weapon_template.movement_curve_modifier_template = "chainsword_p1_m1"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.default
weapon_template.smart_targeting_template = SmartTargetingTemplates.default_melee
weapon_template.haptic_trigger_template = HapticTriggerTemplates.melee.chainsword
weapon_template.overclocks = {
	armor_pierce_up_dps_down = {
		chainaxe_armor_pierce_stat = 0.1,
		chainaxe_dps_stat = -0.1
	},
	finesse_up_armor_pierce_down = {
		chainaxe_armor_pierce_stat = -0.2,
		chainaxe_finesse_stat = 0.2
	},
	first_target_up_armor_pierce_down = {
		chainaxe_first_target_stat = 0.1,
		chainaxe_armor_pierce_stat = -0.1
	},
	mobility_up_first_target_down = {
		chainaxe_mobility_stat = 0.1,
		chainaxe_first_target_stat = -0.1
	},
	dps_up_mobility_down = {
		chainaxe_dps_stat = 0.1,
		chainaxe_mobility_stat = -0.1
	}
}
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	chainaxe_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_left_down_light = {
				damage_trait_templates.default_melee_dps_stat,
				display_data = {
					prefix = "loc_weapon_action_title_light",
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
										display_name = "loc_weapon_stats_display_power"
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
			action_heavy_2 = {
				damage_trait_templates.default_melee_dps_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.default_melee_dps_stat
			}
		}
	},
	chainaxe_armor_pierce_stat = {
		display_name = "loc_stats_display_ap_stat",
		is_stat_trait = true,
		damage = {
			action_left_down_light = {
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
			action_right_diagonal_light = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_heavy_2 = {
				damage_trait_templates.default_armor_pierce_stat
			},
			action_right_light_pushfollow = {
				damage_trait_templates.default_armor_pierce_stat
			}
		}
	},
	chainaxe_defence_stat = {
		display_name = "loc_stats_display_defense_stat",
		is_stat_trait = true,
		stamina = {
			base = {
				stamina_trait_templates.thunderhammer_p1_m1_defence_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		}
	},
	chainaxe_sawing_stat = {
		display_name = "loc_stats_display_first_saw_damage",
		is_stat_trait = true,
		damage = {
			action_left_down_light = {
				overrides = {
					light_chainaxe_active_sticky = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_light",
							damage_profile_path = {
								"hit_stickyness_settings_special_active",
								"damage",
								"damage_profile"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_sawing",
												prefix = "loc_weapon_action_title_special"
											}
										}
									}
								}
							}
						}
					},
					light_chainaxe_active_sticky_last = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_light",
							damage_profile_path = {
								"hit_stickyness_settings_special_active",
								"damage",
								"last_damage_profile"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_sawing_final",
												prefix = "loc_weapon_action_title_special"
											}
										}
									}
								}
							}
						}
					},
					light_chainaxe_sticky = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_heavy_1 = {
				overrides = {
					heavy_chainaxe_active_sticky = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_heavy",
							damage_profile_path = {
								"hit_stickyness_settings_special_active",
								"damage",
								"damage_profile"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_sawing",
												prefix = "loc_weapon_action_title_special"
											}
										}
									}
								}
							}
						}
					},
					heavy_chainaxe_active_sticky_last = {
						damage_trait_templates.default_melee_dps_stat,
						display_data = {
							prefix = "loc_weapon_action_title_heavy",
							damage_profile_path = {
								"hit_stickyness_settings_special_active",
								"damage",
								"last_damage_profile"
							},
							display_stats = {
								targets = {
									{
										power_distribution = {
											attack = {
												display_name = "loc_weapon_stats_display_sawing_final",
												prefix = "loc_weapon_action_title_special"
											}
										}
									}
								}
							}
						}
					}
				}
			},
			action_right_diagonal_light = {
				overrides = {
					light_chainaxe_active_sticky = {
						damage_trait_templates.default_melee_dps_stat
					},
					light_chainaxe_active_sticky_last = {
						damage_trait_templates.default_melee_dps_stat
					},
					light_chainaxe_sticky = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_heavy_2 = {
				overrides = {
					heavy_chainaxe_active_sticky = {
						damage_trait_templates.default_melee_dps_stat
					},
					heavy_chainaxe_active_sticky_last = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			},
			action_right_light_pushfollow = {
				overrides = {
					light_chainaxe_active_sticky = {
						damage_trait_templates.default_melee_dps_stat
					},
					light_chainaxe_active_sticky_last = {
						damage_trait_templates.default_melee_dps_stat
					}
				}
			}
		}
	},
	chainaxe_mobility_stat = {
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
local bespoke_chainaxe_p1_traits = table.ukeys(WeaponTraitsBespokeChainaxeP1)

table.append(weapon_template.traits, bespoke_chainaxe_p1_traits)

weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_high_damage"
	},
	{
		display_name = "loc_weapon_keyword_sawing",
		description = "loc_weapon_stats_display_sawing_desc"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		display_name = "loc_gestalt_tank",
		type = "tank",
		attack_chain = {
			"tank",
			"tank"
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
		desc = "loc_stats_special_action_powerup_desc",
		display_name = "loc_weapon_special_activate",
		type = "activate"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			icon = "tank",
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

return weapon_template
