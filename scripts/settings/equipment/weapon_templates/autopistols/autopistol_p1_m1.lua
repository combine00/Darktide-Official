local ActionInputHierarchy = require("scripts/utilities/action/action_input_hierarchy")
local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local FlashlightTemplates = require("scripts/settings/equipment/flashlight_templates")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HitScanTemplates = require("scripts/settings/projectile/hit_scan_templates")
local LineEffects = require("scripts/settings/effects/line_effects")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local ReloadTemplates = require("scripts/settings/equipment/reload_templates/reload_templates")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokeAutopistolP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_autopistol_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local armor_types = ArmorSettings.types
local buff_keywords = BuffSettings.keywords
local buff_stat_buffs = BuffSettings.stat_buffs
local damage_types = DamageSettings.damage_types
local template_types = WeaponTweakTemplateSettings.template_types
local wield_inputs = PlayerCharacterConstants.wield_inputs
local ammo_trait_templates = WeaponTraitTemplates[template_types.ammo]
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local dodge_trait_templates = WeaponTraitTemplates[template_types.dodge]
local movement_curve_modifier_trait_templates = WeaponTraitTemplates[template_types.movement_curve_modifier]
local recoil_trait_templates = WeaponTraitTemplates[template_types.recoil]
local spread_trait_templates = WeaponTraitTemplates[template_types.spread]
local sprint_trait_templates = WeaponTraitTemplates[template_types.sprint]
local stamina_trait_templates = WeaponTraitTemplates[template_types.stamina]
local sway_trait_templates = WeaponTraitTemplates[template_types.sway]
local toughness_trait_templates = WeaponTraitTemplates[template_types.toughness]
local weapon_handling_trait_templates = WeaponTraitTemplates[template_types.weapon_handling]
local weapon_template = {
	action_inputs = {
		shoot = {
			buffer_time = 0.25,
			input_sequence = {
				{
					value = true,
					input = "action_one_hold"
				}
			}
		},
		shoot_release = {
			buffer_time = 0.22,
			input_sequence = {
				{
					value = false,
					input = "action_one_hold",
					time_window = math.huge
				}
			}
		},
		zoom_shoot = {
			buffer_time = 0.26,
			input_sequence = {
				{
					value = true,
					input = "action_one_hold"
				}
			}
		},
		zoom = {
			buffer_time = 0.4,
			input_sequence = {
				{
					value = true,
					input = "action_two_hold",
					input_setting = {
						value = true,
						input = "action_two_pressed",
						setting_value = true,
						setting = "toggle_ads"
					}
				}
			}
		},
		zoom_release = {
			buffer_time = 0.3,
			input_sequence = {
				{
					value = false,
					input = "action_two_hold",
					time_window = math.huge,
					input_setting = {
						setting_value = true,
						setting = "toggle_ads",
						value = true,
						input = "action_two_pressed",
						time_window = math.huge
					}
				}
			}
		},
		reload = {
			buffer_time = 0,
			clear_input_queue = true,
			input_sequence = {
				{
					value = true,
					input = "weapon_reload"
				}
			}
		},
		wield = {
			buffer_time = 0.2,
			clear_input_queue = true,
			input_sequence = {
				{
					inputs = wield_inputs
				}
			}
		},
		weapon_special = {
			buffer_time = 0.4,
			input_sequence = {
				{
					value = true,
					input = "weapon_extra_pressed"
				}
			}
		},
		zoom_weapon_special = {
			buffer_time = 0.26,
			max_queue = 2,
			input_sequence = {
				{
					value = true,
					input = "weapon_extra_pressed"
				}
			}
		}
	}
}

table.add_missing(weapon_template.action_inputs, BaseTemplateSettings.action_inputs)

weapon_template.action_input_hierarchy = {
	{
		input = "shoot",
		transition = {
			{
				transition = "base",
				input = "shoot_release"
			},
			{
				transition = "base",
				input = "reload"
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
			},
			{
				transition = "base",
				input = "zoom"
			}
		}
	},
	{
		input = "zoom",
		transition = {
			{
				transition = "base",
				input = "zoom_release"
			},
			{
				input = "zoom_shoot",
				transition = {
					{
						transition = "base",
						input = "zoom_release"
					},
					{
						transition = "previous",
						input = "shoot_release"
					},
					{
						transition = "base",
						input = "reload"
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
				}
			},
			{
				transition = "base",
				input = "reload"
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
			},
			{
				transition = "stay",
				input = "zoom_weapon_special"
			}
		}
	},
	{
		transition = "stay",
		input = "wield"
	},
	{
		transition = "stay",
		input = "reload"
	},
	{
		transition = "stay",
		input = "weapon_special"
	}
}

ActionInputHierarchy.add_missing(weapon_template.action_input_hierarchy, BaseTemplateSettings.action_input_hierarchy)

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
		wield_reload_anim_event = "equip_reload",
		allowed_during_sprint = true,
		wield_anim_event = "equip",
		uninterruptible = true,
		kind = "ranged_wield",
		total_time = 0.4,
		conditional_state_to_action_input = {
			started_reload = {
				input_name = "reload"
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
			reload = {
				action_name = "action_reload",
				chain_time = 0.175
			},
			zoom = {
				action_name = "action_zoom",
				chain_time = 0.1
			},
			shoot = {
				action_name = "action_shoot_hip",
				chain_time = 0.2
			}
		}
	},
	action_shoot_hip = {
		kind = "shoot_hit_scan",
		start_input = "shoot",
		recoil_template = "default_autopistol_assault",
		weapon_handling_template = "autogun_full_auto_fast",
		sprint_ready_up_time = 0,
		allowed_during_sprint = true,
		ammunition_usage = 1,
		anim_end_event = "attack_finished",
		spread_template = "default_autopistol_assault",
		stop_input = "shoot_release",
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 1.05,
				t = 0.25
			},
			{
				modifier = 1,
				t = 0.4
			},
			{
				modifier = 0.8,
				t = 1
			},
			start_modifier = 1.1
		},
		fx = {
			pre_loop_shoot_sfx_alias = "ranged_pre_loop_shot",
			crit_shoot_sfx_alias = "critical_shot_extra",
			looping_shoot_sfx_alias = "ranged_shooting",
			muzzle_flash_effect = "content/fx/particles/weapons/rifles/autopistol/autopistol_muzzle",
			num_pre_loop_events = 1,
			spread_rotated_muzzle_flash = false,
			auto_fire_time_parameter_name = "wpn_fire_interval",
			shell_casing_effect = "content/fx/particles/weapons/shells/shell_casing_autopistol_01",
			post_loop_shoot_tail_sfx_alias = "ranged_shot_tail",
			out_of_ammo_sfx_alias = "ranged_out_of_ammo",
			no_ammo_shoot_sfx_alias = "ranged_no_ammo",
			pre_loop_shoot_tail_sfx_alias = "ranged_shot_tail",
			line_effect = LineEffects.autogun_bullet
		},
		fire_configuration = {
			anim_event = "attack_shoot",
			same_side_suppression_enabled = false,
			hit_scan_template = HitScanTemplates.default_autopistol_bullet,
			damage_type = damage_types.auto_bullet
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			reload = {
				action_name = "action_reload"
			},
			zoom = {
				action_name = "action_zoom"
			},
			shoot = {
				action_name = "action_shoot_hip",
				chain_time = 0.45
			}
		},
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.ranged_attack_speed
		},
		buff_keywords = {
			buff_keywords.allow_hipfire_during_sprint
		}
	},
	action_shoot_zoomed = {
		ammunition_usage = 1,
		kind = "shoot_hit_scan",
		start_input = "zoom_shoot",
		recoil_template = "default_autopistol_spraynpray",
		weapon_handling_template = "autogun_full_auto_fast",
		sprint_ready_up_time = 0,
		minimum_hold_time = 0.05,
		anim_end_event = "attack_finished",
		spread_template = "default_autopistol_spraynpray",
		stop_input = "shoot_release",
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 1,
				t = 0.05
			},
			{
				modifier = 0.5,
				t = 0.1
			},
			{
				modifier = 0.51,
				t = 0.3
			},
			{
				modifier = 0.54,
				t = 0.5
			},
			{
				modifier = 0.57,
				t = 0.7
			},
			{
				modifier = 0.62,
				t = 0.9
			},
			{
				modifier = 0.68,
				t = 1.1
			},
			{
				modifier = 0.75,
				t = 1.3
			},
			{
				modifier = 0.79,
				t = 1.4
			},
			{
				modifier = 0.84,
				t = 1.5
			},
			{
				modifier = 0.88,
				t = 1.6
			},
			{
				modifier = 0.93,
				t = 1.7
			},
			{
				modifier = 1,
				t = 1.8
			},
			start_modifier = 1
		},
		fx = {
			pre_loop_shoot_sfx_alias = "ranged_pre_loop_shot",
			crit_shoot_sfx_alias = "critical_shot_extra",
			looping_shoot_sfx_alias = "ranged_shooting",
			muzzle_flash_effect = "content/fx/particles/weapons/rifles/autopistol/autopistol_muzzle",
			num_pre_loop_events = 1,
			spread_rotated_muzzle_flash = false,
			auto_fire_time_parameter_name = "wpn_fire_interval",
			shell_casing_effect = "content/fx/particles/weapons/shells/shell_casing_autopistol_01",
			post_loop_shoot_tail_sfx_alias = "ranged_shot_tail",
			out_of_ammo_sfx_alias = "ranged_out_of_ammo",
			no_ammo_shoot_sfx_alias = "ranged_no_ammo",
			pre_loop_shoot_tail_sfx_alias = "ranged_shot_tail",
			line_effect = LineEffects.autogun_bullet
		},
		fire_configuration = {
			anim_event = "attack_shoot",
			same_side_suppression_enabled = false,
			hit_scan_template = HitScanTemplates.snp_autopistol_bullet,
			damage_type = damage_types.auto_bullet
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			zoom_release = {
				action_name = "action_unzoom"
			},
			wield = {
				action_name = "action_unwield"
			},
			reload = {
				action_name = "action_reload"
			}
		},
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.ranged_attack_speed
		},
		action_keywords = {
			"braced",
			"braced_shooting"
		}
	},
	action_zoom = {
		start_input = "zoom",
		kind = "aim",
		total_time = 0.5,
		smart_targeting_template = SmartTargetingTemplates.alternate_fire_assault,
		crosshair = {
			crosshair_type = "assault"
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			reload = {
				action_name = "action_reload"
			},
			zoom_shoot = {
				action_name = "action_shoot_zoomed",
				chain_time = 0.1
			},
			zoom_release = {
				action_name = "action_unzoom"
			}
		},
		action_keywords = {
			"braced"
		}
	},
	action_unzoom = {
		start_input = "zoom_release",
		kind = "unaim",
		total_time = 0.2,
		crosshair = {
			crosshair_type = "assault"
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			zoom = {
				action_name = "action_zoom"
			},
			shoot = {
				action_name = "action_shoot_hip"
			},
			reload = {
				action_name = "action_reload"
			}
		}
	},
	action_reload = {
		stop_alternate_fire = true,
		start_input = "reload",
		kind = "reload_state",
		sprint_requires_press_to_interrupt = true,
		abort_sprint = true,
		allowed_during_sprint = true,
		total_time = 2.15,
		crosshair = {
			crosshair_type = "none"
		},
		action_movement_curve = {
			{
				modifier = 0.775,
				t = 0.05
			},
			{
				modifier = 0.75,
				t = 0.075
			},
			{
				modifier = 1.05,
				t = 0.25
			},
			{
				modifier = 1.4,
				t = 0.3
			},
			{
				modifier = 0.85,
				t = 0.8
			},
			{
				modifier = 0.9,
				t = 0.9
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
			shoot = {
				action_name = "action_shoot_hip",
				chain_time = 1.9
			},
			zoom = {
				action_name = "action_zoom",
				chain_time = 1.9
			}
		},
		time_scale_stat_buffs = {
			buff_stat_buffs.reload_speed
		},
		haptic_trigger_template = HapticTriggerTemplates.ranged.none
	},
	action_toggle_flashlight = {
		kind = "toggle_special",
		anim_event = "toggle_flashlight",
		start_input = "weapon_special",
		allowed_during_sprint = true,
		activation_time = 0,
		skip_3p_anims = true,
		total_time = 0.2,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			reload = {
				action_name = "action_reload"
			},
			zoom_shoot = {
				action_name = "action_shoot_zoomed"
			}
		}
	},
	action_toggle_flashlight_zoom = {
		kind = "toggle_special",
		anim_event = "toggle_flashlight",
		start_input = "zoom_weapon_special",
		activation_time = 0,
		skip_3p_anims = true,
		total_time = 0.2,
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			reload = {
				action_name = "action_reload"
			},
			zoom_shoot = {
				action_name = "action_shoot_zoomed"
			}
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
		},
		haptic_trigger_template = HapticTriggerTemplates.ranged.none
	}
}

table.add_missing(weapon_template.actions, BaseTemplateSettings.actions)

weapon_template.entry_actions = {
	primary_action = "action_shoot_hip",
	secondary_action = "action_zoom"
}
weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/autogun_pistol"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/autogun_pistol"
weapon_template.can_use_while_vaulting = false
weapon_template.reload_template = ReloadTemplates.autopistol
weapon_template.spread_template = "default_autopistol_assault"
weapon_template.recoil_template = "default_autopistol_assault"
weapon_template.look_delta_template = "autopistol"
weapon_template.conditional_state_to_action_input = {
	{
		conditional_state = "no_ammo_and_started_reload",
		input_name = "reload"
	},
	{
		conditional_state = "no_ammo_with_delay",
		input_name = "reload"
	}
}
weapon_template.no_ammo_delay = 0.15
weapon_template.ammo_template = "autopistol_p1_m1"
weapon_template.hud_configuration = {
	uses_overheat = false,
	uses_ammunition = true
}
weapon_template.weapon_special_tweak_data = {
	manual_toggle_only = true
}
weapon_template.flashlight_template = FlashlightTemplates.autopistol_p1
weapon_template.sprint_ready_up_time = 0.1
weapon_template.max_first_person_anim_movement_speed = 5.8
weapon_template.fx_sources = {
	_muzzle = "fx_muzzle_01",
	_eject = "fx_eject"
}
weapon_template.crosshair = {
	crosshair_type = "assault"
}
weapon_template.hit_marker_type = "center"
weapon_template.alternate_fire_settings = {
	stop_anim_event = "to_unaim_braced",
	recoil_template = "default_autopistol_spraynpray",
	spread_template = "default_autopistol_spraynpray",
	start_anim_event_3p = "to_braced",
	stop_anim_event_3p = "to_unaim_braced",
	start_anim_event = "to_braced",
	crosshair = {
		crosshair_type = "assault"
	},
	camera = {
		custom_vertical_fov = 45,
		vertical_fov = 60,
		near_range = 0.025
	},
	movement_speed_modifier = {
		{
			modifier = 0.5,
			t = 0.1
		},
		{
			modifier = 0.52,
			t = 0.2
		},
		{
			modifier = 0.55,
			t = 0.3
		},
		{
			modifier = 0.58,
			t = 0.4
		},
		{
			modifier = 0.63,
			t = 0.5
		},
		{
			modifier = 0.68,
			t = 0.6
		},
		{
			modifier = 0.75,
			t = 0.7
		}
	}
}
weapon_template.keywords = {
	"ranged",
	"autopistol",
	"p1"
}
weapon_template.dodge_template = "assault"
weapon_template.sprint_template = "assault"
weapon_template.stamina_template = "default"
weapon_template.toughness_template = "assault"
weapon_template.movement_curve_modifier_template = "autopistol_p1_m1"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.default
weapon_template.smart_targeting_template = SmartTargetingTemplates.assault
weapon_template.haptic_trigger_template = HapticTriggerTemplates.ranged.spray_n_pray
local WeaponBarUIDescriptionTemplates = require("scripts/settings/equipment/weapon_bar_ui_description_templates")
weapon_template.base_stats = {
	autopistol_p1_m1_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_shoot_hip = {
				damage_trait_templates.default_dps_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			},
			action_shoot_zoomed = {
				damage_trait_templates.default_dps_stat
			}
		}
	},
	autopistol_p1_m1_mobility_stat = {
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
	},
	autopistol_p1_m1_power_stat = {
		display_name = "loc_stats_display_power_stat",
		is_stat_trait = true,
		damage = {
			action_shoot_hip = {
				damage_trait_templates.autopistol_power_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			},
			action_shoot_zoomed = {
				damage_trait_templates.autopistol_power_stat
			}
		}
	},
	autopistol_p1_m1_control_stat = {
		display_name = "loc_stats_display_control_stat_ranged",
		is_stat_trait = true,
		damage = {
			action_shoot_hip = {
				damage_trait_templates.autopistol_control_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			},
			action_shoot_zoomed = {
				damage_trait_templates.autopistol_control_stat
			}
		}
	},
	autopistol_p1_m1_ammo_stat = {
		display_name = "loc_stats_display_ammo_stat",
		is_stat_trait = true,
		ammo = {
			base = {
				ammo_trait_templates.default_ammo_stat,
				display_data = WeaponBarUIDescriptionTemplates.all_basic_stats
			}
		}
	}
}
weapon_template.traits = {}
local bespoke_autogun_p1_traits = table.ukeys(WeaponTraitsBespokeAutopistolP1)

table.append(weapon_template.traits, bespoke_autogun_p1_traits)

weapon_template.weapon_temperature_settings = {
	increase_rate = 0.075,
	decay_rate = 0.075,
	grace_time = 0.4,
	use_charge = false,
	barrel_threshold = 0.4
}
weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_mobile"
	},
	{
		display_name = "loc_weapon_keyword_spray_n_pray"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		fire_mode = "full_auto",
		display_name = "loc_ranged_attack_primary",
		type = "hipfire"
	},
	secondary = {
		fire_mode = "full_auto",
		display_name = "loc_ranged_attack_secondary_braced",
		type = "brace"
	},
	special = {
		desc = "loc_stats_special_action_flashlight_desc",
		display_name = "loc_weapon_special_flashlight",
		type = "flashlight"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			value_func = "primary_attack",
			icon = "hipfire",
			sub_icon = "full_auto",
			header = "hipfire"
		},
		{
			value_func = "secondary_attack",
			icon = "brace",
			sub_icon = "full_auto",
			header = "brace"
		},
		{
			value_func = "ammo",
			header = "ammo"
		}
	},
	weapon_special = {
		icon = "flashlight",
		header = "flashlight"
	}
}
weapon_template.explicit_combo = {
	{
		"action_shoot_hip"
	},
	{
		"action_shoot_zoomed"
	}
}

return weapon_template
