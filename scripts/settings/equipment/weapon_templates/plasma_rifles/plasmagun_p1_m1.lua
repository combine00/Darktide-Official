local ActionInputHierarchy = require("scripts/utilities/action/action_input_hierarchy")
local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BaseTemplateSettings = require("scripts/settings/equipment/weapon_templates/base_template_settings")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local ExplosionTemplates = require("scripts/settings/damage/explosion_templates")
local FootstepIntervalsTemplates = require("scripts/settings/equipment/footstep/footstep_intervals_templates")
local HapticTriggerTemplates = require("scripts/settings/equipment/haptic_trigger_templates")
local HitScanTemplates = require("scripts/settings/projectile/hit_scan_templates")
local LineEffects = require("scripts/settings/effects/line_effects")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local ReloadTemplates = require("scripts/settings/equipment/reload_templates/reload_templates")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local WeaponTraitsBespokePlasmagunP1 = require("scripts/settings/equipment/weapon_traits/weapon_traits_bespoke_plasmagun_p1")
local WeaponTraitTemplates = require("scripts/settings/equipment/weapon_templates/weapon_trait_templates/weapon_trait_templates")
local WeaponTweakTemplateSettings = require("scripts/settings/equipment/weapon_templates/weapon_tweak_template_settings")
local armor_types = ArmorSettings.types
local buff_stat_buffs = BuffSettings.stat_buffs
local damage_types = DamageSettings.damage_types
local wield_inputs = PlayerCharacterConstants.wield_inputs
local template_types = WeaponTweakTemplateSettings.template_types
local damage_trait_templates = WeaponTraitTemplates[template_types.damage]
local ammo_trait_templates = WeaponTraitTemplates[template_types.ammo]
local charge_trait_templates = WeaponTraitTemplates[template_types.charge]
local weapon_template = {
	action_inputs = {
		shoot_charge = {
			buffer_time = 0.5,
			input_sequence = {
				{
					value = true,
					input = "action_one_pressed"
				}
			}
		},
		charged_enough = {
			buffer_time = 0.3
		},
		shoot_cancel = {
			buffer_time = 0.1,
			input_sequence = {
				{
					value = true,
					input = "action_two_pressed"
				}
			}
		},
		brace = {
			buffer_time = 0,
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
		brace_release = {
			buffer_time = 0.1,
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
		shoot_braced = {
			buffer_time = 0.1,
			input_sequence = {
				{
					value = true,
					input = "action_one_pressed"
				}
			}
		},
		reload = {
			buffer_time = 0.2,
			input_sequence = {
				{
					value = true,
					input = "weapon_reload"
				}
			}
		},
		vent = {
			buffer_time = 0,
			clear_input_queue = true,
			input_sequence = {
				{
					value = true,
					input = "weapon_extra_hold"
				}
			}
		},
		vent_override = {
			clear_input_queue = true,
			buffer_time = 0
		},
		vent_release = {
			buffer_time = 1.51,
			input_sequence = {
				{
					value = false,
					input = "weapon_extra_hold",
					time_window = math.huge
				}
			}
		},
		wield = {
			buffer_time = 0,
			clear_input_queue = true,
			input_sequence = {
				{
					inputs = wield_inputs
				}
			}
		}
	}
}

table.add_missing(weapon_template.action_inputs, BaseTemplateSettings.action_inputs)

weapon_template.action_input_hierarchy = {
	{
		input = "shoot_charge",
		transition = {
			{
				transition = "base",
				input = "charged_enough"
			},
			{
				transition = "base",
				input = "shoot_cancel"
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
				input = "reload"
			},
			{
				transition = "base",
				input = "vent"
			},
			{
				transition = "base",
				input = "vent_override"
			}
		}
	},
	{
		input = "brace",
		transition = {
			{
				transition = "base",
				input = "brace_release"
			},
			{
				transition = "base",
				input = "shoot_braced"
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
				input = "reload"
			}
		}
	},
	{
		input = "vent",
		transition = {
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
		}
	},
	{
		input = "vent_override",
		transition = {
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
		}
	},
	{
		transition = "base",
		input = "reload"
	},
	{
		transition = "stay",
		input = "wield"
	}
}

ActionInputHierarchy.add_missing(weapon_template.action_input_hierarchy, BaseTemplateSettings.action_input_hierarchy)

weapon_template.actions = {
	action_unwield = {
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
		total_time = 0.5,
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
			}
		}
	},
	action_charge_direct = {
		overload_module_class_name = "overheat",
		hold_combo = true,
		start_input = "shoot_charge",
		kind = "overload_charge",
		sprint_ready_up_time = 0.4,
		prevent_sprint = true,
		anim_end_event = "attack_charge_cancel",
		allowed_during_sprint = false,
		charge_template = "plasmagun_p1_m1_charge_direct",
		abort_sprint = true,
		anim_event = "attack_charge",
		stop_input = "shoot_cancel",
		total_time = math.huge,
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
		charge_effects = {
			sfx_parameter = "charge_level",
			looping_sound_alias = "ranged_fast_charging",
			looping_effect_alias = "ranged_charging",
			vfx_source_name = "_muzzle",
			sfx_source_name = "_overheat"
		},
		running_action_state_to_action_input = {
			overheating = {
				input_name = "vent_override"
			},
			fully_charged = {
				input_name = "charged_enough"
			}
		},
		finish_reason_to_action_input = {
			stunned = {
				input_name = "charged_enough"
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
				action_name = "action_reload"
			},
			charged_enough = {
				action_name = "action_shoot"
			},
			vent = {
				action_name = "action_vent"
			},
			vent_override = {
				action_name = "action_vent_override"
			},
			brace = {
				action_name = "action_charge"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			if end_reason == "hold_input_released" or end_reason == "stunned" then
				return true
			end

			return false
		end
	},
	action_shoot = {
		ammunition_usage_max = 3,
		kind = "shoot_hit_scan",
		weapon_handling_template = "immediate_single_shot",
		sprint_ready_up_time = 0.6,
		charge_template = "plasmagun_p1_m1_shoot",
		ammunition_usage_min = 3,
		use_charge = true,
		recoil_template = "default_plasma_rifle_bfg",
		spread_template = "default_plasma_rifle_bfg",
		prevent_sprint = true,
		total_time = 0.5,
		action_movement_curve = {
			{
				modifier = 0.25,
				t = 0.2
			},
			{
				modifier = 0.4,
				t = 0.3
			},
			{
				modifier = 1,
				t = 0.5
			},
			start_modifier = 0.15
		},
		fx = {
			crit_shoot_sfx_alias = "critical_shot_extra",
			shoot_tail_sfx_alias = "ranged_shot_tail",
			shoot_sfx_alias = "ranged_single_shot",
			muzzle_flash_effect = "content/fx/particles/weapons/rifles/plasma_gun/plasma_muzzle_ks",
			line_effect = LineEffects.plasma_beam
		},
		fire_configuration = {
			anim_event = "attack_charge_shoot",
			use_charge = true,
			hit_scan_template = HitScanTemplates.default_plasma_rifle_bfg,
			damage_type = damage_types.plasma
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			vent = {
				action_name = "action_vent"
			},
			brace = {
				action_name = "action_charge"
			},
			reload = {
				action_name = "action_reload"
			},
			shoot_charge = {
				action_name = "action_charge_direct",
				chain_time = 0.45
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			return false
		end,
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.ranged_attack_speed
		}
	},
	action_shoot_charged = {
		use_charge = true,
		ammunition_usage_max = 9,
		weapon_handling_template = "immediate_single_shot",
		sprint_ready_up_time = 0,
		recoil_template = "default_plasma_rifle_demolitions",
		spread_template = "default_plasma_rifle_demolitions",
		kind = "shoot_hit_scan",
		ammunition_usage_min = 5,
		allowed_during_sprint = true,
		charge_template = "plasmagun_p1_m1_shoot_charged",
		total_time = 0.75,
		action_movement_curve = {
			{
				modifier = 0.1,
				t = 0.35
			},
			{
				modifier = 0.1,
				t = 0.55
			},
			{
				modifier = 1,
				t = 0.75
			},
			start_modifier = 0.1
		},
		fx = {
			crit_shoot_sfx_alias = "critical_shot_extra",
			shoot_tail_sfx_alias = "ranged_shot_tail",
			shoot_sfx_alias = "ranged_single_shot",
			muzzle_flash_effect = "content/fx/particles/weapons/rifles/plasma_gun/plasma_muzzle_bfg",
			line_effect = LineEffects.plasma_beam
		},
		fire_configuration = {
			anim_event = "heavy_charge_shoot",
			use_charge = true,
			hit_scan_template = HitScanTemplates.default_plasma_rifle_demolition,
			damage_type = damage_types.plasma
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			vent = {
				action_name = "action_vent"
			},
			reload = {
				action_name = "action_reload"
			},
			brace = {
				action_name = "action_charge",
				chain_time = 0.6
			}
		},
		time_scale_stat_buffs = {
			buff_stat_buffs.attack_speed,
			buff_stat_buffs.ranged_attack_speed
		}
	},
	action_charge = {
		start_input = "brace",
		prevent_sprint = true,
		hold_combo = true,
		overload_module_class_name = "overheat",
		kind = "overload_charge",
		sprint_ready_up_time = 0.25,
		anim_end_event = "attack_charge_cancel",
		allowed_during_sprint = false,
		recoil_template = "default_plasma_rifle_demolitions",
		charge_template = "plasmagun_p1_m1_charge",
		spread_template = "default_plasma_rifle_demolitions",
		abort_sprint = true,
		anim_event = "heavy_charge",
		stop_input = "brace_release",
		total_time = math.huge,
		action_movement_curve = {
			{
				modifier = 0.3,
				t = 0.1
			},
			{
				modifier = 0.3,
				t = 0.15
			},
			{
				modifier = 0.6,
				t = 0.25
			},
			{
				modifier = 0.6,
				t = 0.5
			},
			{
				modifier = 0.4,
				t = 1
			},
			{
				modifier = 0.3,
				t = 2
			},
			start_modifier = 1
		},
		charge_effects = {
			sfx_parameter = "charge_level",
			looping_sound_alias = "ranged_charging",
			looping_effect_alias = "ranged_charging",
			vfx_source_name = "_muzzle",
			sfx_source_name = "_overheat"
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			},
			vent = {
				action_name = "action_vent"
			},
			reload = {
				action_name = "action_reload"
			},
			shoot_braced = {
				action_name = "action_shoot_charged",
				chain_time = 0.75
			}
		},
		finish_reason_to_action_input = {
			stunned = {
				input_name = "shoot_braced"
			}
		},
		anim_end_event_condition_func = function (unit, data, end_reason)
			if end_reason == "hold_input_released" or end_reason == "stunned" then
				return true
			end

			return false
		end,
		timed_smart_targeting_template = {
			{
				t = 0.7,
				template = SmartTargetingTemplates.alternate_fire_bfg
			},
			default = SmartTargetingTemplates.assault
		}
	},
	action_vent = {
		allowed_during_sprint = true,
		start_input = "vent",
		anim_end_event = "vent_end",
		kind = "vent_overheat",
		minimum_hold_time = 1,
		prevent_sprint = true,
		abort_sprint = true,
		uninterruptible = true,
		anim_event = "vent",
		stop_input = "vent_release",
		total_time = math.huge,
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
		venting_fx = {
			looping_vfx_alias = "plasma_venting",
			looping_sound_alias = "ranged_plasma_venting"
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
		}
	},
	action_vent_override = {
		prevent_sprint = true,
		anim_end_event = "vent_end",
		kind = "vent_overheat",
		anim_event_3p = "vent",
		allowed_during_sprint = true,
		minimum_hold_time = 1,
		abort_sprint = true,
		uninterruptible = true,
		anim_event = "vent_override",
		stop_input = "vent_release",
		total_time = math.huge,
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
		venting_fx = {
			looping_vfx_alias = "plasma_venting",
			looping_sound_alias = "ranged_plasma_venting"
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
			},
			vent = {
				action_name = "action_vent",
				chain_time = 0.5
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
		total_time = 9.4,
		crosshair = {
			crosshair_type = "none"
		},
		allowed_chain_actions = {
			combat_ability = {
				action_name = "combat_ability"
			},
			grenade_ability = BaseTemplateSettings.generate_grenade_ability_chain_actions(),
			wield = {
				action_name = "action_unwield"
			}
		},
		time_scale_stat_buffs = {
			buff_stat_buffs.reload_speed
		},
		haptic_trigger_template = HapticTriggerTemplates.ranged.none
	},
	action_overheat_explode = {
		death_on_explosion = true,
		overload_type = "plasma",
		anim_end_event = "charge_explode_finished",
		kind = "overload_explosion",
		first_person_shake_anim = "shake_medium",
		anim_event = "charge_explode",
		total_time = 3,
		timeline_anims = {
			[0.933] = {
				anim_event_3p = "explode_end",
				anim_event_1p = "explode_end"
			}
		},
		explosion_template = ExplosionTemplates.plasma_rifle_overheat,
		death_damage_profile = DamageProfileTemplates.overheat_exploding_tick,
		death_damage_type = damage_types.laser,
		dot_settings = {
			power_level = 1000,
			damage_frequency = 0.8,
			damage_profile = DamageProfileTemplates.overheat_exploding_tick,
			damage_type = damage_types.laser
		},
		sfx = {
			on_start = "weapon_about_to_explode"
		},
		haptic_trigger_template = HapticTriggerTemplates.ranged.none
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
weapon_template.base_stats = {
	plasmagun_p1_m1_dps_stat = {
		display_name = "loc_stats_display_damage_stat",
		is_stat_trait = true,
		damage = {
			action_shoot = {
				damage_trait_templates.default_dps_stat,
				display_data = {
					display_stats = {
						armor_damage_modifier_ranged = {
							near = {
								attack = {
									[armor_types.unarmored] = {},
									[armor_types.disgustingly_resilient] = {}
								}
							},
							far = {
								attack = {
									[armor_types.unarmored] = {},
									[armor_types.disgustingly_resilient] = {}
								}
							}
						},
						power_distribution = {
							attack = {}
						}
					}
				}
			},
			action_shoot_charged = {
				damage_trait_templates.default_dps_stat
			}
		}
	},
	plasmagun_p1_m1_power_stat = {
		display_name = "loc_stats_display_power_stat",
		is_stat_trait = true,
		damage = {
			action_shoot = {
				damage_trait_templates.default_power_stat,
				display_data = {
					display_stats = {
						armor_damage_modifier_ranged = {
							near = {
								attack = {
									[armor_types.armored] = {},
									[armor_types.super_armor] = {},
									[armor_types.resistant] = {},
									[armor_types.berserker] = {}
								}
							},
							far = {
								attack = {
									[armor_types.armored] = {},
									[armor_types.super_armor] = {},
									[armor_types.resistant] = {},
									[armor_types.berserker] = {}
								}
							}
						},
						power_distribution = {
							impact = {}
						}
					}
				}
			},
			action_shoot_charged = {
				damage_trait_templates.default_power_stat
			}
		}
	},
	plasmagun_charge_cost_stat = {
		display_name = "loc_stats_display_heat_management",
		is_stat_trait = true,
		charge = {
			action_charge_direct = {
				charge_trait_templates.plasmagun_charge_cost_stat
			},
			action_charge = {
				charge_trait_templates.plasmagun_charge_cost_stat
			},
			action_shoot = {
				charge_trait_templates.plasmagun_charge_cost_stat,
				display_data = {
					prefix = "loc_ranged_attack_primary",
					display_stats = {
						overheat_percent = {
							display_name = "loc_weapon_stats_display_heat_generation"
						}
					}
				}
			},
			action_shoot_charged = {
				charge_trait_templates.plasmagun_charge_cost_stat,
				display_data = {
					prefix = "loc_ranged_attack_secondary_braced",
					display_stats = {
						overheat_percent = {
							display_name = "loc_weapon_stats_display_heat_generation"
						}
					}
				}
			}
		}
	},
	plasmagun_charge_speed_stat = {
		display_name = "loc_stats_display_charge_speed",
		is_stat_trait = true,
		charge = {
			action_charge_direct = {
				charge_trait_templates.plasmagun_charge_speed_stat,
				display_data = {
					prefix = "loc_ranged_attack_primary",
					display_stats = {
						charge_duration = {}
					}
				}
			},
			action_charge = {
				charge_trait_templates.plasmagun_charge_speed_stat,
				display_data = {
					prefix = "loc_ranged_attack_secondary_braced",
					display_stats = {
						charge_duration = {}
					}
				}
			},
			action_shoot = {
				charge_trait_templates.plasmagun_charge_speed_stat
			},
			action_shoot_charged = {
				charge_trait_templates.plasmagun_charge_speed_stat
			}
		}
	},
	plasmagun_p1_m1_ammo_stat = {
		display_name = "loc_stats_display_ammo_stat",
		is_stat_trait = true,
		ammo = {
			base = {
				ammo_trait_templates.default_ammo_stat,
				display_data = {
					display_stats = {
						ammunition_clip = {},
						ammunition_reserve = {}
					}
				}
			}
		}
	}
}

table.add_missing(weapon_template.actions, BaseTemplateSettings.actions)

weapon_template.anim_state_machine_3p = "content/characters/player/human/third_person/animations/plasma_rifle"
weapon_template.anim_state_machine_1p = "content/characters/player/human/first_person/animations/plasma_rifle"
weapon_template.reload_template = ReloadTemplates.plasma_rifle
weapon_template.spread_template = "default_plasma_rifle_bfg"
weapon_template.combo_reset_duration = 0.5
weapon_template.ammo_template = "plasmagun_p1_m1"
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
weapon_template.no_ammo_delay = 0.45
weapon_template.hud_configuration = {
	uses_overheat = true,
	uses_ammunition = true
}
weapon_template.sprint_ready_up_time = 0.1
weapon_template.max_first_person_anim_movement_speed = 5.8
weapon_template.fx_sources = {
	_overheat = "fx_overheat",
	_vent = "fx_stock_01",
	_muzzle = "fx_muzzle",
	_mag_well = "fx_reload"
}
weapon_template.crosshair = {
	crosshair_type = "bfg"
}
weapon_template.hit_marker_type = "center"
weapon_template.overheat_configuration = {
	auto_vent_delay = 1,
	overheat_icon_text = "",
	vent_duration = 3,
	explode_action = "action_overheat_explode",
	high_threshold_decay_rate_modifier = 0.5,
	auto_vent_duration = 15,
	low_threshold_decay_rate_modifier = 0.8,
	vent_interval = 0.6,
	critical_threshold_decay_rate_modifier = 0.25,
	thresholds = {
		high = 0.6,
		critical = 0.9,
		low = 0.3
	},
	reload_state_overrides = {
		remove_canister = 1
	},
	vent_power_level = {
		250,
		1000
	},
	vent_damage_profile = DamageProfileTemplates.plasma_vent_damage,
	vent_damage_type = damage_types.overheat,
	proficiency_keyword = BuffSettings.keywords.plasma_proficiency,
	proficiency_vent_power_level = {
		125,
		250
	},
	proficiency_vent_damage_profile = DamageProfileTemplates.plasma_vent_damage_proficiency,
	explosion_template = ExplosionTemplates.plasma_rifle_overheat,
	fx = {
		on_screen_effect = "content/fx/particles/screenspace/screen_plasma_rifle_warning",
		sfx_source_name = "_overheat",
		on_screen_cloud_name = "plasma",
		vfx_source_name = "_overheat",
		looping_sound_parameter_name = "overheat_plasma_gun",
		on_screen_variable_name = "plasma_radius"
	}
}
weapon_template.weapon_temperature_settings = {
	increase_rate = 0.075,
	use_charge = true,
	grace_time = 0.4,
	charge_increase_rate = 0.15,
	barrel_threshold = 0.4,
	decay_rate = 0.025
}
weapon_template.displayed_keywords = {
	{
		display_name = "loc_weapon_keyword_high_damage"
	},
	{
		display_name = "loc_weapon_keyword_charged_attack"
	}
}
weapon_template.displayed_attacks = {
	primary = {
		fire_mode = "projectile",
		display_name = "loc_ranged_attack_primary",
		type = "hipfire"
	},
	secondary = {
		fire_mode = "projectile",
		display_name = "loc_ranged_attack_secondary_braced",
		type = "charge"
	},
	special = {
		desc = "loc_stats_special_action_venting_desc",
		display_name = "loc_weapon_special_weapon_vent",
		type = "vent"
	}
}
weapon_template.weapon_card_data = {
	main = {
		{
			value_func = "primary_attack",
			icon = "charge",
			sub_icon = "semi_auto",
			header = "hipfire"
		},
		{
			value_func = "secondary_attack",
			icon = "charge",
			sub_icon = "semi_auto",
			header = "brace"
		},
		{
			value_func = "ammo",
			header = "ammo"
		}
	},
	weapon_special = {
		icon = "vent",
		header = "vent"
	}
}
weapon_template.displayed_attack_ranges = {
	max = 0,
	min = 0
}
weapon_template.keywords = {
	"ranged",
	"plasma_rifle",
	"p1"
}
weapon_template.can_use_while_vaulting = false
weapon_template.dodge_template = "plasma_rifle"
weapon_template.sprint_template = "support"
weapon_template.stamina_template = "default"
weapon_template.toughness_template = "default"
weapon_template.footstep_intervals = FootstepIntervalsTemplates.plasmagun
weapon_template.smart_targeting_template = SmartTargetingTemplates.assault
weapon_template.haptic_trigger_template = HapticTriggerTemplates.ranged.plasmagun
weapon_template.traits = {}
local bespoke_plasmagun_p1_traits = table.ukeys(WeaponTraitsBespokePlasmagunP1)

table.append(weapon_template.traits, bespoke_plasmagun_p1_traits)

weapon_template.displayed_weapon_stats = "plasmagun_p1_m1"

return weapon_template
