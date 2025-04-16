local Action = require("scripts/utilities/action/action")
local AilmentSettings = require("scripts/settings/ailments/ailment_settings")
local Ammo = require("scripts/utilities/ammo")
local Attack = require("scripts/utilities/attack/attack")
local AttackSettings = require("scripts/settings/damage/attack_settings")
local Breeds = require("scripts/settings/breed/breeds")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local CheckProcFunctions = require("scripts/settings/buff/helper_functions/check_proc_functions")
local CoherencyUtils = require("scripts/extension_systems/coherency/coherency_utils")
local ConditionalFunctions = require("scripts/settings/buff/helper_functions/conditional_functions")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local EffectTemplates = require("scripts/settings/fx/effect_templates")
local FixedFrame = require("scripts/utilities/fixed_frame")
local Health = require("scripts/utilities/health")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local PlayerUnitVisualLoadout = require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
local PowerLevelSettings = require("scripts/settings/damage/power_level_settings")
local PushAttack = require("scripts/utilities/attack/push_attack")
local ReloadStates = require("scripts/extension_systems/weapon/utilities/reload_states")
local SpecialRulesSettings = require("scripts/settings/ability/special_rules_settings")
local Sprint = require("scripts/extension_systems/character_state_machine/character_states/utilities/sprint")
local Stamina = require("scripts/utilities/attack/stamina")
local Suppression = require("scripts/utilities/attack/suppression")
local Sway = require("scripts/utilities/sway")
local TalentSettings = require("scripts/settings/talent/talent_settings")
local Toughness = require("scripts/utilities/toughness/toughness")
local WeaponTemplate = require("scripts/utilities/weapon/weapon_template")
local ailment_effects = AilmentSettings.effects
local attack_results = AttackSettings.attack_results
local attack_types = AttackSettings.attack_types
local stagger_results = AttackSettings.stagger_results
local buff_categories = BuffSettings.buff_categories
local damage_efficiencies = AttackSettings.damage_efficiencies
local damage_types = DamageSettings.damage_types
local special_rules = SpecialRulesSettings.special_rules
local keywords = BuffSettings.keywords
local proc_events = BuffSettings.proc_events
local stat_buffs = BuffSettings.stat_buffs
local talent_settings = TalentSettings.adamant
local templates = {}

table.make_unique(templates)

local function _penance_start_func(buff_name)
	return function (template_data, template_context)
		local unit = template_context.unit
		local t = FixedFrame.get_latest_fixed_time()
		local buff_extension = ScriptUnit.extension(unit, "buff_system")

		buff_extension:add_internally_controlled_buff(buff_name, t)
	end
end

templates.adamant_companion_damage_per_level = {
	predicted = false,
	class_name = "buff",
	lerped_stat_buffs = {
		[stat_buffs.companion_damage_modifier] = {
			max = 1.5,
			min = 0
		}
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local player = unit and Managers.state.player_unit_spawn:owner(unit)
		local profile = player:profile()
		local level = profile and profile.current_level or 1
		local fifth_level = math.floor(level / 5)
		local lerp_value = fifth_level / 6
		template_data.lerp_value = lerp_value
	end,
	lerp_t_func = function (t, start_time, duration, template_data, template_context)
		return template_data.lerp_value
	end
}
templates.adamant_charge_passive_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_lunge_end] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.ability_extension = ScriptUnit.extension(unit, "ability_system")
	end,
	proc_func = function (params, template_data, template_context, t)
		local buff_extension = template_context.buff_extension

		buff_extension:add_internally_controlled_buff("adamant_post_charge_buff", t)
	end
}
templates.adamant_post_charge_buff = {
	max_stacks = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_ability",
	predicted = false,
	class_name = "buff",
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_adamant_charge"
	},
	duration = talent_settings.combat_ability.charge.duration,
	stat_buffs = {
		[stat_buffs.impact_modifier] = talent_settings.combat_ability.charge.impact,
		[stat_buffs.damage] = talent_settings.combat_ability.charge.damage
	}
}
templates.adamant_charge_cooldown_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_hit] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.ability_extension = ScriptUnit.extension(unit, "ability_system")
	end,
	proc_func = function (params, template_data, template_context, t)
		local damage_profile_name = params.damage_profile and params.damage_profile.name

		if damage_profile_name ~= "adamant_charge_damage" then
			return
		end

		local cooldown_time = talent_settings.combat_ability.charge.cooldown_reduction

		template_data.ability_extension:reduce_ability_cooldown_time("combat_ability", cooldown_time)
	end
}
templates.adamant_charge_toughness_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_lunge_start] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.ability_extension = ScriptUnit.extension(unit, "ability_system")
	end,
	proc_func = function (params, template_data, template_context, t)
		local toughness = talent_settings.combat_ability.charge.toughness

		Toughness.replenish_percentage(template_context.unit, toughness)

		local stamina = talent_settings.combat_ability.charge.stamina

		Stamina.add_stamina_percent(template_context.unit, stamina)
	end
}
templates.adamant_shout_allies_buff = {
	max_stacks = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_ability",
	predicted = false,
	duration = 5,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.ranged_attack_speed] = 0.05,
		[stat_buffs.toughness_damage_taken_modifier] = -0.15
	},
	keywords = {
		keywords.suppression_immune
	}
}
templates.adamant_grenade_improved = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.explosion_radius_modifier_frag] = talent_settings.blitz_ability.grenade.radius_increase
	}
}
local external_properties = {}
templates.adamant_whistle_replenishment = {
	predicted = false,
	hud_priority = 4,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_blitz",
	class_name = "buff",
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.ability_extension = ScriptUnit.has_extension(unit, "ability_system")
		template_data.fx_extension = ScriptUnit.extension(unit, "fx_system")
		template_data.first_person_extension = ScriptUnit.extension(unit, "first_person_system")
		template_data.missing_charges = 0
	end,
	update_func = function (template_data, template_context, dt, t, template)
		if not template_data.ability_extension then
			local unit = template_context.unit
			local ability_extension = ScriptUnit.has_extension(unit, "ability_system")

			if not ability_extension then
				return
			end

			template_data.ability_extension = ability_extension
		end

		local ability_extension = template_data.ability_extension

		if not ability_extension or not ability_extension:has_ability_type("grenade_ability") then
			template_data.next_charge_t = nil
			template_data.missing_charges = 0

			return
		end

		local missing_charges = ability_extension and ability_extension:missing_ability_charges("grenade_ability")

		if missing_charges == 0 then
			template_data.next_charge_t = nil
			template_data.missing_charges = 0

			return
		end

		template_data.missing_charges = missing_charges
		local next_charge_t = template_data.next_charge_t

		if not next_charge_t then
			local cooldown = ability_extension:max_ability_cooldown("grenade_ability")
			template_data.next_charge_t = t + cooldown
			template_data.cooldown = cooldown

			return
		end

		if next_charge_t < t then
			template_data.next_charge_t = nil
			local first_person_extension = template_data.first_person_extension

			if first_person_extension and first_person_extension:is_in_first_person_mode() and missing_charges == 1 then
				external_properties.indicator_type = "psyker_throwing_knives"

				template_data.fx_extension:trigger_gear_wwise_event("charge_ready_indicator", external_properties)
			end
		end
	end,
	check_active_func = function (template_data, template_context)
		local is_missing_charges = template_data.missing_charges > 0

		return is_missing_charges
	end,
	duration_func = function (template_data, template_context)
		local next_charge_t = template_data.next_charge_t

		if not next_charge_t then
			return 1
		end

		local t = FixedFrame.get_latest_fixed_time()
		local time_until_next = next_charge_t - t
		local percentage_left = time_until_next / template_data.cooldown

		return 1 - percentage_left
	end,
	related_talents = {
		"adamant_whistle"
	}
}
templates.adamant_drone_base_buff = {
	max_stacks = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_ability",
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.suppression_dealt] = talent_settings.blitz_ability.drone.suppression,
		[stat_buffs.impact_modifier] = talent_settings.blitz_ability.drone.impact
	},
	update_func = function (template_data, template_context, dt, t)
		local toughness = talent_settings.blitz_ability.drone.toughness * dt

		Toughness.replenish_percentage(template_context.unit, toughness)
	end,
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_zealot_preacher_defense"
	}
}
templates.adamant_drone_enemy_debuff = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.damage_taken_multiplier] = talent_settings.blitz_ability.drone.damage_taken
	}
}
templates.adamant_wield_speed_aura = {
	coherency_id = "adamant_wield_speed_coherency",
	predicted = false,
	hud_priority = 5,
	coherency_priority = 2,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_aura",
	max_stacks = 1,
	class_name = "buff",
	buff_category = buff_categories.aura,
	stat_buffs = {
		[stat_buffs.wield_speed] = talent_settings.coherency.adamant_wield_speed_aura.wield_speed
	},
	start_func = _penance_start_func("adamant_wield_speed_aura_tracking_buff"),
	related_talents = {
		"adamant_wield_speed_aura"
	}
}
templates.adamant_wield_speed_aura_tracking_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_kill] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.coherency_extension = ScriptUnit.extension(unit, "coherency_system")
		template_data.last_num_in_coherency = 0
		template_data.hook_name = "hook_adamant_wield_speed_aura_kill"
		template_data.parent_buff_name = "adamant_wield_speed_aura"
	end,
	proc_func = function (params, template_data, template_context)
		if not template_context.is_server then
			return
		end

		template_data.last_num_in_coherency = template_data.coherency_extension:evaluate_and_send_achievement_data(template_data.parent_buff_name, template_data.hook_name)
	end
}
templates.adamant_damage_vs_staggered_aura = {
	coherency_id = "adamant_damage_vs_staggered_coherency",
	predicted = false,
	hud_priority = 5,
	coherency_priority = 2,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_aura",
	max_stacks = 1,
	class_name = "buff",
	buff_category = buff_categories.aura,
	stat_buffs = {
		[stat_buffs.damage_vs_staggered] = talent_settings.coherency.adamant_damage_vs_staggered_aura.damage_vs_staggered
	},
	start_func = _penance_start_func("adamant_damage_vs_staggered_aura_tracking_buff"),
	related_talents = {
		"adamant_damage_vs_staggered_aura"
	}
}
templates.adamant_damage_vs_staggered_aura_tracking_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_kill] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.coherency_extension = ScriptUnit.extension(unit, "coherency_system")
		template_data.last_num_in_coherency = 0
		template_data.hook_name = "hook_adamant_staggered_enemy_aura_kill"
		template_data.parent_buff_name = "adamant_damage_vs_staggered_aura"
	end,
	check_proc_func = function (params, template_data, template_context, t)
		if not template_context.is_server then
			return false
		end

		return CheckProcFunctions.on_staggered_kill(params, template_data, template_context, t)
	end,
	proc_func = function (params, template_data, template_context)
		if not template_context.is_server then
			return
		end

		template_data.last_num_in_coherency = template_data.coherency_extension:evaluate_and_send_achievement_data(template_data.parent_buff_name, template_data.hook_name)
	end
}
templates.adamant_companion_counts_for_coherency = {
	predicted = false,
	max_stacks_cap = 1,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_player_companion_spawn] = 1
	},
	start_func = function (template_data, template_context)
		if not template_context.is_server then
			return
		end

		template_data.coherency_system = Managers.state.extension:system("coherency_system")
	end,
	check_proc_func = function (params, template_data, template_context)
		local is_companion_ours = params.owner_unit and params.owner_unit == template_context.unit
		local is_arbites_companion_dog = params.companion_breed == "companion_dog"

		return is_companion_ours and is_arbites_companion_dog
	end,
	proc_func = function (params, template_data, template_context)
		if not template_context.is_server then
			return
		end

		local spawned_companion_unit = params.companion_unit
		template_data.coherency_buff_index = template_data.coherency_system:add_external_buff(spawned_companion_unit, "adamant_companion_coherency_tracking_buff")
		template_data.companion_unit = params.companion_unit
	end,
	stop_func = function (template_data, template_context)
		local companion_unit = template_data.companion_unit

		if ALIVE[companion_unit] and template_data.coherency_buff_index then
			template_data.coherency_system:remove_external_buff(companion_unit, template_data.coherency_buff_index)
		end
	end,
	related_talents = {
		"adamant_companion_coherency"
	}
}
templates.adamant_companion_coherency_tracking_buff = {
	max_stacks_cap = 1,
	coherency_id = "adamant_companion_coherency_tracking_buff",
	predicted = false,
	coherency_priority = 2,
	max_stacks = 1,
	class_name = "proc_buff",
	buff_category = buff_categories.aura,
	proc_events = {
		[proc_events.on_kill] = 1
	},
	start_func = function (template_data, template_context)
		if not template_context.is_server then
			return
		end

		local unit = template_context.unit
		template_data.coherency_extension = ScriptUnit.extension(unit, "coherency_system")
		template_data.last_num_in_coherency = 0
		template_data.hook_name = "hook_adamant_companion_coherency_aura_kill"
		template_data.parent_talent_name = "adamant_companion_coherency"
	end,
	proc_func = function (params, template_data, template_context)
		if not template_context.is_server then
			return
		end

		local units_in_coherency = template_data.coherency_extension:in_coherence_units()

		for coherency_unit, coherency_extension in pairs(units_in_coherency) do
			local unit_data_extension = ScriptUnit.extension(coherency_unit, "unit_data_system")
			local breed = unit_data_extension and unit_data_extension:breed()

			if breed.name == "companion_dog" then
				local owner_player = Managers.state.player_unit_spawn:owner(coherency_unit)
				local player_unit = owner_player and owner_player.player_unit
				local talent_extension = player_unit and ScriptUnit.has_extension(player_unit, "talent_system")
				local player_current_talents = talent_extension and talent_extension:talents()

				if player_current_talents and player_current_talents[template_data.parent_talent_name] then
					Managers.stats:record_private(template_data.hook_name, owner_player)
				end
			end
		end
	end
}
templates.adamant_hunt_stance = {
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_ability",
	max_stacks = 1,
	class_name = "proc_buff",
	duration = talent_settings.combat_ability.stance.duration,
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_adamant_ability_stance"
	},
	stat_buffs = {
		[stat_buffs.damage] = talent_settings.combat_ability.stance.damage,
		[stat_buffs.movement_speed] = talent_settings.combat_ability.stance.movement_speed,
		[stat_buffs.companion_damage_modifier] = talent_settings.combat_ability.stance.companion_damage,
		[stat_buffs.sprinting_cost_multiplier] = talent_settings.combat_ability.stance.sprint_cost
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_elite_or_special_kill,
	start_func = function (template_data, template_context)
		local ability_extension = ScriptUnit.has_extension(template_context.unit, "ability_system")
		template_data.ability_extension = ability_extension
	end,
	proc_func = function (params, template_data, template_context, t)
		local player_kill = params.attacking_unit == template_context.unit
		local companion_kill = CheckProcFunctions.attacker_is_my_companion(params, template_data, template_context, t)
		local ability_type = "combat_ability"
		local cooldown_reduction = talent_settings.combat_ability.stance.cooldown_reduction

		template_data.ability_extension:reduce_ability_cooldown_percentage(ability_type, cooldown_reduction)
	end,
	stop_func = function (template_data, template_context)
		return
	end
}
templates.adamant_forceful = {
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_hit] = 1,
		[proc_events.on_combat_ability] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		local refresh_on_ability = special_rules.adamant_forceful_refresh_on_ability
		template_data.refresh_on_ability = talent_extension:has_special_rule(refresh_on_ability)
	end,
	specific_proc_func = {
		on_hit = function (params, template_data, template_context, t)
			if params.target_number > 1 then
				return
			end

			local already_active = template_context.buff_extension:has_buff_using_buff_template("adamant_forceful_active")

			if already_active then
				return
			end

			if CheckProcFunctions.on_staggering_hit(params, template_data, template_context, t) then
				template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_stacks", t)
			end
		end,
		on_combat_ability = function (params, template_data, template_context, t)
			if template_data.refresh_on_ability then
				local has_forceful_buff = template_context.buff_extension:has_buff_using_buff_template("adamant_forceful_active")

				if has_forceful_buff then
					template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_active", t)
				end
			end
		end
	}
}
templates.adamant_forceful_stacks = {
	refresh_duration_on_stack = true,
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	class_name = "buff",
	duration = talent_settings.forceful.stack_duration,
	max_stacks = talent_settings.forceful.max_stacks,
	on_reached_max_stack_func = function (template_data, template_context)
		template_data.finish = true
		local t = FixedFrame.get_latest_fixed_time()

		template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_active", t)
	end,
	conditional_exit_func = function (template_data, template_context)
		return template_data.finish
	end
}
templates.adamant_forceful_active = {
	refresh_duration_on_stack = true,
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	max_stacks = 1,
	class_name = "buff",
	duration = talent_settings.forceful.duration,
	stat_buffs = {
		[stat_buffs.power_level_modifier] = talent_settings.forceful.power_level_modifier,
		[stat_buffs.toughness_damage_taken_multiplier] = talent_settings.forceful.tdr
	},
	keywords = {
		keywords.stun_immune
	},
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_zealot_preacher_rage"
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		local melee_buff = talent_extension:has_special_rule(special_rules.adamant_forceful_melee)
		local ranged_buff = talent_extension:has_special_rule(special_rules.adamant_forceful_ranged)
		local companion_buff = talent_extension:has_special_rule(special_rules.adamant_forceful_companion)
		local toughness_talent = special_rules.adamant_forceful_toughness_regen
		template_data.toughness_talent = talent_extension:has_special_rule(toughness_talent)

		if toughness_talent then
			local toughness = talent_settings.forceful_toughness_regen.instant_toughness

			Toughness.replenish_percentage(unit, toughness)
		end

		local t = FixedFrame.get_latest_fixed_time()

		if melee_buff then
			template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_melee_buff", t)
		end

		if ranged_buff then
			template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_ranged_buff", t)
		end

		if companion_buff then
			template_context.buff_extension:add_internally_controlled_buff("adamant_forceful_companion_buff", t)
		end
	end,
	refresh_func = function (template_data, template_context)
		if template_data.toughness_talent then
			local unit = template_context.unit
			local toughness = talent_settings.forceful_toughness_regen.instant_toughness

			Toughness.replenish_percentage(unit, toughness)
		end
	end,
	update_func = function (template_data, template_context, dt)
		if template_data.toughness_talent then
			local unit = template_context.unit
			local toughness = talent_settings.forceful_toughness_regen.toughness_per_second * dt

			Toughness.replenish_percentage(unit, toughness)
		end
	end,
	stop_func = function (template_data, template_context)
		local has_melee_buff = template_context.buff_extension:has_buff_using_buff_template("adamant_forceful_melee_buff")

		if has_melee_buff then
			template_context.buff_extension:remove_internally_controlled_buff_stack("adamant_forceful_melee_buff")
		end

		local has_ranged_buff = template_context.buff_extension:has_buff_using_buff_template("adamant_forceful_ranged_buff")

		if has_ranged_buff then
			template_context.buff_extension:remove_internally_controlled_buff_stack("adamant_forceful_ranged_buff")
		end

		local has_companion_buff = template_context.buff_extension:has_buff_using_buff_template("adamant_forceful_companion_buff")

		if has_companion_buff then
			template_context.buff_extension:remove_internally_controlled_buff_stack("adamant_forceful_companion_buff")
		end
	end
}
templates.adamant_forceful_melee_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.melee_attack_speed] = talent_settings.forceful_melee.melee_attack_speed,
		[stat_buffs.max_melee_hit_mass_attack_modifier] = talent_settings.forceful_melee.cleave
	}
}
templates.adamant_forceful_ranged_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.ranged_attack_speed] = talent_settings.forceful_ranged.ranged_attack_speed,
		[stat_buffs.reload_speed] = talent_settings.forceful_ranged.reload_speed
	}
}
templates.adamant_forceful_companion_buff = {
	predicted = false,
	max_stacks = 1,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.companion_damage_modifier] = talent_settings.forceful_companion.companion_damage_modifier
	}
}
templates.adamant_exterminator = {
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_minion_death] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.stack_talent = talent_extension:has_special_rule(special_rules.adamant_exterminator_stack_during_activation)
	end,
	proc_func = function (params, template_data, template_context, t)
		local is_active = template_context.buff_extension:has_buff_using_buff_template("adamant_exterminator_active")

		if is_active and not template_data.stack_talent then
			return
		end

		local elite_or_special = params.tags and (params.tags.elite or params.tags.special)

		if elite_or_special then
			template_context.buff_extension:add_internally_controlled_buff("adamant_exterminator_stacks", t)
		end
	end
}
templates.adamant_exterminator_stacks = {
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	class_name = "proc_buff",
	always_show_in_hud = true,
	max_stacks = talent_settings.exterminator.max_stacks,
	proc_events = {
		[proc_events.on_combat_ability] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.toughness_talent = talent_extension:has_special_rule(special_rules.adamant_exterminator_toughness)
		template_data.ability_cooldown_talent = talent_extension:has_special_rule(special_rules.adamant_exterminator_ability_cooldown)
	end,
	proc_func = function (params, template_data, template_context, t)
		local stacks = template_context.stack_count

		template_context.buff_extension:add_internally_controlled_buff_with_stacks("adamant_exterminator_active", stacks, t)

		local unit = template_context.unit

		if template_data.toughness_talent then
			local toughness = talent_settings.exterminator.toughness * stacks

			Toughness.replenish_percentage(unit, toughness)
		end

		if template_data.ability_cooldown_talent then
			local cooldown = talent_settings.exterminator.cooldown
			local ability_extension = ScriptUnit.has_extension(unit, "ability_system")

			if ability_extension then
				ability_extension:reduce_ability_cooldown_percentage("combat_ability", cooldown)
			end
		end

		template_data.finish = true
	end,
	conditional_exit_func = function (template_data, template_context)
		return template_data.finish
	end
}
templates.adamant_exterminator_active = {
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	class_name = "proc_buff",
	always_show_in_hud = true,
	refresh_duration_on_stack = true,
	duration = talent_settings.exterminator.duration,
	max_stacks = talent_settings.exterminator.max_stacks,
	stat_buffs = {
		[stat_buffs.damage] = talent_settings.exterminator.damage,
		[stat_buffs.companion_damage_modifier] = talent_settings.exterminator.companion_damage
	},
	conditional_stat_buffs = {
		[stat_buffs.damage_vs_ogryn_and_monsters] = talent_settings.exterminator.boss_damage
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	keywords = {},
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_zealot_preacher_rage"
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.stamina_ammo_talent = talent_extension:has_special_rule(special_rules.adamant_exterminator_stamina_ammo)
		template_data.boss_damage_talent = talent_extension:has_special_rule(special_rules.adamant_exterminator_boss_damage)
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
		template_data.inventory_slot_secondary_component = unit_data_extension:write_component("slot_secondary")
		template_data.visual_loadout_extension = visual_loadout_extension
	end,
	proc_func = function (params, template_data, template_context, t)
		if not CheckProcFunctions.on_elite_or_special_kill(params) then
			return
		end

		if template_data.stamina_ammo_talent then
			local unit = template_context.unit
			local stamina_replenish = talent_settings.exterminator.stamina
			local ammo_replenish_percent = talent_settings.exterminator.ammo

			Stamina.add_stamina_percent(unit, stamina_replenish)

			local inventory_slot_secondary_component = template_data.inventory_slot_secondary_component
			local max_ammo_in_clip = inventory_slot_secondary_component.max_ammunition_clip
			local current_ammo_in_clip = inventory_slot_secondary_component.current_ammunition_clip
			local missing_ammo_in_clip = max_ammo_in_clip - current_ammo_in_clip
			local amount = math.ceil(missing_ammo_in_clip * ammo_replenish_percent)

			Ammo.transfer_from_reserve_to_clip(inventory_slot_secondary_component, amount)

			local weapon_template = template_data.visual_loadout_extension:weapon_template_from_slot("slot_secondary")
			local reload_template = weapon_template.reload_template

			if reload_template then
				ReloadStates.reset(reload_template, inventory_slot_secondary_component)
			end
		end
	end,
	conditional_stat_buffs_func = function (template_data, template_context)
		return template_data.boss_damage_talent
	end
}
templates.adamant_bullet_rain = {
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_hit] = 1,
		[proc_events.on_combat_ability] = 1
	},
	conditional_lerped_stat_buffs = {
		[stat_buffs.toughness_damage_taken_multiplier] = {
			min = 1,
			max = 1 - talent_settings.bullet_rain.tdr_per_stack * talent_settings.bullet_rain.max_stacks
		}
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.ability_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_ability)
		template_data.tdr_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_tdr)
	end,
	specific_proc_func = {
		on_hit = function (params, template_data, template_context, t)
			local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack
			local is_melee_attack = params.attack_type == attack_types.melee or params.attack_type == attack_types.push

			if not is_ranged_attack and not is_melee_attack then
				return
			end

			local already_active = template_context.buff_extension:has_buff_using_buff_template("adamant_bullet_rain_buff")

			if already_active then
				return
			end

			template_context.buff_extension:add_internally_controlled_buff("adamant_bullet_rain_stacks", t)
		end,
		on_combat_ability = function (params, template_data, template_context, t)
			if template_data.ability_talent then
				template_context.buff_extension:add_internally_controlled_buff("adamant_bullet_rain_buff", t)
			end
		end
	},
	conditional_stat_buffs_func = function (template_data, template_context)
		local already_active = template_context.buff_extension:has_buff_using_buff_template("adamant_bullet_rain_buff")

		return template_data.tdr_talent and not already_active
	end,
	lerp_t_func = function (t, start_time, duration, template_data, template_context)
		local current_stacks = template_context.buff_extension:current_stacks("adamant_bullet_rain_stacks")

		return math.clamp01(current_stacks / talent_settings.bullet_rain.max_stacks)
	end
}
templates.adamant_bullet_rain_stacks = {
	predicted = false,
	refresh_duration_on_stack = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	class_name = "proc_buff",
	always_show_in_hud = true,
	proc_events = {
		[proc_events.on_shoot] = 1,
		[proc_events.on_combat_ability] = 1
	},
	max_stacks = talent_settings.bullet_rain.max_stacks,
	max_stacks_cap = talent_settings.bullet_rain.max_stacks,
	duration = talent_settings.bullet_rain.stack_duration,
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.ability_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_ability)
		template_data.previous_count = 0
	end,
	specific_proc_func = {
		on_shoot = function (params, template_data, template_context, t)
			if talent_settings.bullet_rain.max_stacks <= template_data.previous_count then
				template_context.buff_extension:add_internally_controlled_buff("adamant_bullet_rain_buff", t)

				template_data.finish = true
			end

			template_data.previous_count = template_context.stack_count
		end,
		on_combat_ability = function (params, template_data, template_context, t)
			if template_data.ability_talent then
				template_data.finish = true
			end
		end
	},
	conditional_exit_func = function (template_data, template_context)
		return template_data.finish
	end
}
templates.adamant_bullet_rain_buff = {
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_keystone",
	predicted = false,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	always_active = true,
	class_name = "proc_buff",
	proc_events = {},
	duration = talent_settings.bullet_rain.duration,
	player_effects = {
		on_screen_effect = "content/fx/particles/screenspace/screen_zealot_preacher_rage"
	},
	stat_buffs = {
		[stat_buffs.ranged_damage] = talent_settings.bullet_rain.ranged_damage,
		[stat_buffs.suppression_dealt] = talent_settings.bullet_rain.suppression_dealt
	},
	keywords = {
		keywords.no_ammo_consumption
	},
	conditional_stat_buffs = {
		[stat_buffs.toughness_damage_taken_multiplier] = talent_settings.bullet_rain.tdr
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local talent_extension = ScriptUnit.extension(unit, "talent_system")
		template_data.tdr_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_tdr)
		local toughness_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_tdr)

		if toughness_talent then
			local toughness_replenish = talent_settings.bullet_rain.toughness_replenish

			Toughness.replenish_percentage(unit, toughness_replenish)
		end

		local t = FixedFrame.get_latest_fixed_time()
		local fire_rate_talent = talent_extension:has_special_rule(special_rules.adamant_bullet_rain_fire_rate)

		if fire_rate_talent then
			template_context.buff_extension:add_internally_controlled_buff("adamant_bullet_rain_fire_rate_buff", t)
		end
	end,
	conditional_stat_buffs_func = function (template_data, template_context)
		return template_data.tdr_talent
	end,
	proc_func = function (params, template_data, template_context, t)
		return
	end
}
templates.adamant_bullet_rain_fire_rate_buff = {
	predicted = false,
	class_name = "buff",
	duration = talent_settings.bullet_rain.duration,
	stat_buffs = {
		[stat_buffs.ranged_attack_speed] = talent_settings.bullet_rain.fire_rate
	}
}
templates.adamant_movement_speed_on_block = {
	predicted = true,
	hud_priority = 4,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.movement_speed_on_block.duration,
	proc_events = {
		[proc_events.on_block] = 1
	},
	proc_stat_buffs = {
		[stat_buffs.movement_speed] = talent_settings.movement_speed_on_block.movement_speed
	},
	related_talents = {
		"adamant_movement_speed_on_block"
	}
}
templates.adamant_damage_vs_suppressed = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.damage_vs_suppressed] = talent_settings.damage_vs_suppressed.damage_vs_suppressed
	}
}
templates.adamant_clip_size = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.clip_size_modifier] = talent_settings.clip_size.clip_size_modifier
	}
}
templates.adamant_suppression_immunity = {
	predicted = false,
	class_name = "buff",
	keywords = {
		keywords.suppression_immune
	}
}
templates.adamant_disable_companion_buff = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.damage] = talent_settings.disable_companion.damage,
		[stat_buffs.toughness_damage_taken_modifier] = talent_settings.disable_companion.tdr
	}
}
templates.adamant_elite_special_kills_replenish_toughness = {
	max_stacks = 1,
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_kill] = 1
	},
	check_proc_func = CheckProcFunctions.on_elite_or_special_kill,
	proc_func = function (params, template_data, template_context, t)
		local buff_extension = ScriptUnit.extension(template_context.unit, "buff_system")

		buff_extension:add_internally_controlled_buff("adamant_toughness_on_elite_kill_effect", t)
		Toughness.replenish_percentage(template_context.unit, talent_settings.elite_special_kills_replenish_toughness.instant_toughness, false)
	end
}
templates.adamant_toughness_on_elite_kill_effect = {
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	predicted = false,
	hud_priority = 3,
	class_name = "buff",
	duration = talent_settings.elite_special_kills_replenish_toughness.duration,
	update_func = function (template_data, template_context, dt, t)
		if not template_context.is_server then
			return
		end

		Toughness.replenish_percentage(template_context.unit, talent_settings.elite_special_kills_replenish_toughness.toughness * dt, false)

		template_data.next_regen_t = nil
	end
}
templates.adamant_close_kills_restore_toughness = {
	max_stacks = 1,
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_kill] = 1
	},
	check_proc_func = CheckProcFunctions.on_close_kill,
	proc_func = function (params, template_data, template_context, t)
		local toughness = talent_settings.close_kills_restore_toughness.toughness

		Toughness.replenish_percentage(template_context.unit, toughness)
	end
}
templates.adamant_staggers_replenish_toughness = {
	max_stacks = 1,
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_staggering_hit,
	proc_func = function (params, template_data, template_context, t)
		local first = params.target_number and params.target_number == 1

		if not first then
			return
		end

		local toughness = talent_settings.staggers_replenish_toughness.toughness

		Toughness.replenish_percentage(template_context.unit, toughness)
	end
}
templates.adamant_limit_dmg_taken_from_hits = {
	predicted = false,
	max_stacks = 1,
	class_name = "buff",
	keywords = {
		keywords.limit_health_damage_taken
	},
	stat_buffs = {
		[stat_buffs.max_health_damage_taken_per_hit] = talent_settings.limit_dmg_taken_from_hits.limit
	}
}
templates.adamant_increased_damage_vs_horde = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.damage_vs_horde] = talent_settings.increased_damage_vs_horde.damage
	}
}
templates.adamant_armor = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.toughness] = talent_settings.armor.toughness
	}
}
templates.adamant_mag_strips = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.wield_speed] = talent_settings.mag_strips.wield_speed
	}
}
templates.adamant_plasteel_plates = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.toughness] = talent_settings.plasteel_plates.toughness
	}
}
templates.adamant_ammo_belt = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.ammo_reserve_capacity] = talent_settings.ammo_belt.ammo_reserve_capacity
	}
}
templates.adamant_gutter_forged = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.toughness_damage_taken_modifier] = talent_settings.gutter_forged.tdr,
		[stat_buffs.movement_speed] = talent_settings.gutter_forged.movement_speed
	}
}
templates.adamant_riot_pads_child = {
	predicted = false,
	refresh_start_time_on_stack = true,
	stack_offset = -1,
	class_name = "buff",
	max_stacks = talent_settings.riot_pads.stacks,
	keywords = {
		keywords.stun_immune
	}
}
templates.adamant_riot_pads = {
	restore_child_duration = 3,
	child_buff_template = "adamant_riot_pads_child",
	predicted = false,
	hud_priority = 3,
	start_at_max = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "parent_proc_buff",
	always_show_in_hud = true,
	proc_events = {
		[proc_events.on_player_hit_received] = 1
	},
	remove_child_proc_events = {
		[proc_events.on_player_hit_received] = 1
	},
	specific_check_proc_funcs = {
		[proc_events.on_player_hit_received] = function (params, template_data, template_context, t)
			if t < template_data.internal_cd_t then
				return false
			end

			if params.damage <= 0 and params.damage_absorbed <= 0 then
				return false
			end

			if not params.attack_result or params.attack_result == "blocked" then
				return
			end

			local attacking_unit = params.attacking_unit

			if attacking_unit then
				local unit_data_extension = ScriptUnit.has_extension(attacking_unit, "unit_data_system")
				local breed_name = unit_data_extension and unit_data_extension:breed_name()
				local breed = breed_name and Breeds[breed_name]
				local faction_name = breed and breed.faction_name

				if faction_name and faction_name == "imperium" then
					return
				end
			end

			template_data.internal_cd_t = t + 1

			return true
		end
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.max_stacks = templates.adamant_riot_pads_child.max_stacks
		template_data.num_child_stacks = templates.adamant_riot_pads_child.max_stacks
		template_data.internal_cd_t = 0
	end,
	on_stacks_removed_func = function (num_child_stacks, num_child_stacks_removed, t, template_data, template_context)
		template_data.num_child_stacks = num_child_stacks
	end
}
templates.adamant_rebreather = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.corruption_taken_multiplier] = talent_settings.rebreather.corruption_taken_multiplier,
		[stat_buffs.damage_taken_from_toxic_gas_multiplier] = talent_settings.rebreather.damage_taken_from_toxic_gas_multiplier
	}
}
local OUTLINE_NAME = "special_target"
local distance_verispex_sq = talent_settings.verispex.range * talent_settings.verispex.range
templates.adamant_verispex = {
	max_stacks = 1,
	predicted = false,
	class_name = "buff",
	start_func = function (template_data, template_context)
		local is_local_unit = template_context.is_local_unit
		local player = template_context.player
		local is_human_controlled = player:is_human_controlled()
		local local_player = Managers.player:local_player(1)
		local camera_handler = local_player and local_player.camera_handler
		local is_observing = camera_handler and camera_handler:is_observing()
		template_data.valid_player = is_local_unit and is_human_controlled or is_observing

		if not template_data.valid_player then
			return
		end

		template_data.outlined_units = {}
		template_data.next_update_t = 0
	end,
	update_func = function (template_data, template_context, dt, t)
		if not template_data.valid_player then
			return
		end

		if t < template_data.next_update_t then
			return
		end

		local unit = template_context.unit
		local side_system = Managers.state.extension:system("side_system")
		local side = side_system and side_system.side_by_unit[unit]
		local enemy_units = side and side.enemy_units_lookup or {}
		local player_position = Unit.world_position(unit, 1)
		local outline_system = Managers.state.extension:system("outline_system")

		for enemy_unit, _ in pairs(enemy_units) do
			local is_outlined = template_data.outlined_units[enemy_unit]

			if not is_outlined then
				local enemy_unit_data_extension = ScriptUnit.has_extension(enemy_unit, "unit_data_system")
				local breed = enemy_unit_data_extension and enemy_unit_data_extension:breed()
				local breed_tags = breed and breed.tags
				local is_special = breed_tags and breed_tags.special

				if is_special then
					local special_position = Unit.world_position(enemy_unit, 1)
					local from_player = special_position - player_position
					local distance_squared = Vector3.length_squared(from_player)
					local distance_score_low_enough = distance_squared < distance_verispex_sq

					if distance_squared < distance_verispex_sq then
						outline_system:add_outline(enemy_unit, OUTLINE_NAME)

						template_data.outlined_units[enemy_unit] = true
					end
				end
			end
		end

		template_data.next_update_t = t + 1
	end
}
templates.adamant_shield_plates = {
	max_stacks = 1,
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_block] = 1
	},
	proc_func = function (params, template_data, template_context, t)
		local toughness = talent_settings.shield_plates.toughness

		Toughness.replenish_percentage(template_context.unit, toughness)
	end
}
templates.adamant_dog_kills_replenish_toughness = {
	max_stacks = 1,
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_kill] = 1
	},
	check_proc_func = CheckProcFunctions.attacker_is_my_companion,
	proc_func = function (params, template_data, template_context, t)
		local buff_extension = ScriptUnit.extension(template_context.unit, "buff_system")

		buff_extension:add_internally_controlled_buff("adamant_dog_kills_replenish_toughness_effect", t)
	end
}
templates.adamant_dog_kills_replenish_toughness_effect = {
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	predicted = false,
	hud_priority = 3,
	class_name = "buff",
	duration = talent_settings.dog_kills_replenish_toughness.duration,
	update_func = function (template_data, template_context, dt, t)
		if not template_context.is_server then
			return
		end

		Toughness.replenish_percentage(template_context.unit, talent_settings.dog_kills_replenish_toughness.toughness * dt, false)

		template_data.next_regen_t = nil
	end
}
templates.adamant_damage_after_reloading = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.damage_after_reloading.duration,
	proc_events = {
		[proc_events.on_reload] = 1
	},
	proc_stat_buffs = {
		[stat_buffs.ranged_damage] = talent_settings.damage_after_reloading.ranged_damage
	}
}
templates.adamant_cleave_after_push = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.cleave_after_push.duration,
	proc_events = {
		[proc_events.on_push_finish] = 1
	},
	check_proc_func = function (params, template_data, template_context)
		return params.num_hit_units > 0
	end,
	proc_stat_buffs = {
		[stat_buffs.max_melee_hit_mass_attack_modifier] = talent_settings.cleave_after_push.cleave
	}
}
templates.adamant_dog_damage_after_ability = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.dog_damage_after_ability.duration,
	proc_events = {
		[proc_events.on_combat_ability] = 1
	},
	proc_stat_buffs = {
		[stat_buffs.companion_damage_modifier] = talent_settings.dog_damage_after_ability.damage
	}
}
templates.adamant_heavy_attacks_increase_damage = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.heavy_attacks_increase_damage.duration,
	proc_events = {
		[proc_events.on_sweep_finish] = 1
	},
	check_proc_func = function (params, template_data, template_context)
		local is_heavy = params.is_heavy or params.melee_attack_strength == "heavy"

		if not params.is_heavy then
			return false
		end

		return params.num_hit_units > 0
	end,
	proc_stat_buffs = {
		[stat_buffs.damage] = talent_settings.heavy_attacks_increase_damage.damage
	}
}
templates.adamant_wield_speed_on_melee_kill = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_melee_kill,
	proc_func = function (params, template_data, template_context, t)
		template_context.buff_extension:add_internally_controlled_buff("adamant_wield_speed_on_melee_kill_buff", t)
	end
}
templates.adamant_wield_speed_on_melee_kill_buff = {
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	predicted = false,
	hud_priority = 3,
	class_name = "buff",
	duration = talent_settings.wield_speed_on_melee_kill.duration,
	max_stacks = talent_settings.wield_speed_on_melee_kill.max_stacks,
	stat_buffs = {
		[stat_buffs.wield_speed] = talent_settings.wield_speed_on_melee_kill.wield_speed_per_stack
	}
}
templates.adamant_elite_special_kills_offensive_boost = {
	predicted = true,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.elite_special_kills_offensive_boost.duration,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_elite_or_special_kill,
	proc_stat_buffs = {
		[stat_buffs.damage] = talent_settings.elite_special_kills_offensive_boost.damage,
		[stat_buffs.movement_speed] = talent_settings.elite_special_kills_offensive_boost.movement_speed
	}
}
templates.adamant_melee_attacks_on_staggered_rend = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.rending_vs_staggered_multiplier] = talent_settings.melee_attacks_on_staggered_rend.rending_multiplier
	}
}
templates.adamant_hitting_multiple_gives_tdr = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.hitting_multiple_gives_tdr.duration,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = function (params, template_data, template_context)
		local min = talent_settings.hitting_multiple_gives_tdr.num_hits
		local hit = params.target_number

		return min == hit
	end,
	proc_stat_buffs = {
		[stat_buffs.toughness_damage_taken_multiplier] = talent_settings.hitting_multiple_gives_tdr.tdr
	}
}
templates.adamant_multiple_hits_attack_speed = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.multiple_hits_attack_speed.duration,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = function (params, template_data, template_context)
		local min = talent_settings.multiple_hits_attack_speed.num_hits
		local hit = params.target_number

		return min == hit
	end,
	proc_stat_buffs = {
		[stat_buffs.melee_attack_speed] = talent_settings.multiple_hits_attack_speed.melee_attack_speed
	}
}
templates.adamant_restore_toughness_to_allies_on_combat_ability = {
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_combat_ability] = 1
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local coherency_extension = ScriptUnit.extension(unit, "coherency_system")
		template_data.coherency_extension = coherency_extension
	end,
	proc_func = function (params, template_data, template_context)
		local coherency_extension = template_data.coherency_extension
		local units_in_coherence = coherency_extension:in_coherence_units()
		local toughness = talent_settings.restore_toughness_to_allies_on_combat_ability.toughness_percent

		for coherency_unit, _ in pairs(units_in_coherence) do
			Toughness.replenish_percentage(coherency_unit, toughness)
		end
	end
}
templates.adamant_dog_pounces_bleed_nearby = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.attacker_is_my_companion,
	proc_func = function (params, template_data, template_context, t)
		local pounce = params.damage_profile and params.damage_profile.name == "cyber_mastiff_push"

		if pounce then
			local victim_unit = params.attacked_unit

			if HEALTH_ALIVE[victim_unit] then
				local buff_extension = ScriptUnit.has_extension(victim_unit, "buff_system")

				if buff_extension then
					local stacks = talent_settings.dog_pounces_bleed_nearby.bleed_stacks

					buff_extension:add_internally_controlled_buff_with_stacks("bleed", stacks, t)
				end
			end
		end
	end
}
templates.adamant_dog_applies_brittleness = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.attacker_is_my_companion,
	proc_func = function (params, template_data, template_context, t)
		local initial_pounce = params.damage_profile and params.damage_profile.initial_pounce

		if initial_pounce then
			local victim_unit = params.attacked_unit

			if HEALTH_ALIVE[victim_unit] then
				local buff_extension = ScriptUnit.has_extension(victim_unit, "buff_system")

				if buff_extension then
					local stacks = talent_settings.dog_applies_brittleness.stacks

					buff_extension:add_internally_controlled_buff_with_stacks("rending_debuff", stacks, t)
				end
			end
		end
	end
}
templates.adamant_no_movement_penalty = {
	predicted = false,
	max_stacks = 1,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_wield_ranged] = 1,
		[proc_events.on_wield_melee] = 1
	},
	conditional_stat_buffs = {
		[stat_buffs.alternate_fire_movement_speed_reduction_modifier] = talent_settings.no_movement_penalty.reduced_move_penalty,
		[stat_buffs.weapon_action_movespeed_reduction_multiplier] = talent_settings.no_movement_penalty.reduced_move_penalty
	},
	start_func = function (template_data, template_context)
		template_data.wielding_ranged = false
	end,
	specific_proc_func = {
		on_wield_ranged = function (params, template_data, template_context)
			template_data.wielding_ranged = true
		end,
		on_wield_melee = function (params, template_data, template_context)
			template_data.wielding_ranged = false
		end
	},
	conditional_stat_buffs_func = function (template_data, template_context)
		return template_data.wielding_ranged
	end
}
templates.adamant_dog_attacks_electrocute = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.attacker_is_my_companion,
	proc_func = function (params, template_data, template_context, t)
		local pounce = params.damage_profile and params.damage_profile.companion_pounce

		if pounce then
			local victim_unit = params.attacked_unit

			if HEALTH_ALIVE[victim_unit] then
				local buff_extension = ScriptUnit.has_extension(victim_unit, "buff_system")

				if buff_extension then
					buff_extension:add_internally_controlled_buff("dog_attacks_electrocute_electrocute_buff", t)
				end
			end
		end
	end
}
local PI = math.pi
local PI_2 = PI * 2
templates.dog_attacks_electrocute_electrocute_buff = {
	start_with_frame_offset = true,
	start_interval_on_apply = true,
	max_stacks_cap = 1,
	predicted = false,
	refresh_duration_on_stack = true,
	max_stacks = 1,
	class_name = "interval_buff",
	keywords = {
		keywords.electrocuted
	},
	interval = {
		0.3,
		0.8
	},
	duration = talent_settings.dog_attacks_electrocute.duration,
	interval_func = function (template_data, template_context, template, dt, t)
		local is_server = template_context.is_server

		if not is_server then
			return
		end

		local unit = template_context.unit

		if HEALTH_ALIVE[unit] then
			local damage_template = DamageProfileTemplates.shockmaul_stun_interval_damage
			local owner_unit = template_context.owner_unit
			local power_level = talent_settings.dog_attacks_electrocute.power_level
			local random_radians = math.random_range(0, PI_2)
			local attack_direction = Vector3(math.sin(random_radians), math.cos(random_radians), 0)
			attack_direction = Vector3.normalize(attack_direction)

			Attack.execute(unit, damage_template, "power_level", power_level, "damage_type", damage_types.electrocution, "attack_type", attack_types.buff, "attacking_unit", HEALTH_ALIVE[owner_unit] and owner_unit, "attack_direction", attack_direction)
		end
	end,
	minion_effects = {
		ailment_effect = ailment_effects.electrocution
	}
}
templates.adamant_damage_reduction_after_elite_kill = {
	predicted = false,
	hud_priority = 3,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.damage_reduction_after_elite_kill.duration,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	proc_stat_buffs = {
		[stat_buffs.damage_taken_multiplier] = talent_settings.damage_reduction_after_elite_kill.damage_taken_multiplier
	},
	check_proc_func = CheckProcFunctions.on_elite_or_special_kill,
	related_talents = {
		"adamant_damage_reduction_after_elite_kill"
	}
}
local toughness_range_sq = talent_settings.toughness_regen_near_companion.range * talent_settings.toughness_regen_near_companion.range
templates.adamant_toughness_regen_near_companion = {
	predicted = false,
	hud_priority = 3,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_utility_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "buff",
	always_show_in_hud = true,
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local character_state_component = unit_data_extension:read_component("character_state")
		template_data.character_state_component = character_state_component
		template_data.check_t = 0
	end,
	update_func = function (template_data, template_context, dt, t, template)
		if template_data.is_active and template_context.is_server then
			local percent_toughness = talent_settings.toughness_regen_near_companion.toughness_percentage_per_second * dt

			Toughness.replenish_percentage(template_context.unit, percent_toughness, false, "near_companion_toughness")
		end

		local check_t = template_data.check_t

		if t < check_t then
			return
		end

		template_data.check_t = t + 0.1
		local is_disabled = PlayerUnitStatus.is_disabled(template_data.character_state_component)

		if is_disabled then
			template_data.is_active = false

			return
		end

		local player_unit = template_context.unit
		local player_position = POSITION_LOOKUP[player_unit]
		local companion_spawner_extension = ScriptUnit.has_extension(player_unit, "companion_spawner_system")

		if companion_spawner_extension then
			local companion_unit = companion_spawner_extension:companion_unit()
			local companion_position = POSITION_LOOKUP[companion_unit]
			local distance = Vector3.distance_squared(player_position, companion_position)
			local is_active = distance <= toughness_range_sq
			template_data.is_active = is_active
		end
	end,
	conditional_stat_buffs_func = function (template_data, template_context)
		return template_data.is_active
	end,
	related_talents = {
		"zealot_toughness_in_melee"
	}
}
templates.adamant_perfect_block_damage_boost = {
	predicted = false,
	class_name = "proc_buff",
	proc_events = {
		[proc_events.on_perfect_block] = 1
	},
	proc_func = function (params, template_data, template_context, t)
		template_context.buff_extension:add_internally_controlled_buff("adamant_perfect_block_damage_boost_buff", t)
	end
}
templates.adamant_perfect_block_damage_boost_buff = {
	refresh_duration_on_stack = true,
	predicted = false,
	hud_priority = 3,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	max_stacks = 1,
	class_name = "buff",
	duration = talent_settings.perfect_block_damage_boost.duration,
	stat_buffs = {
		[stat_buffs.damage] = talent_settings.perfect_block_damage_boost.damage,
		[stat_buffs.attack_speed] = talent_settings.perfect_block_damage_boost.attack_speed
	},
	related_talents = {
		"adamant_perfect_block_damage_boost"
	}
}
templates.adamant_staggers_reduce_damage_taken = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_staggering_hit,
	proc_func = function (params, template_data, template_context, t)
		local tags = params.tags
		local is_ogryn = tags and tags.ogryn or tags.monster
		local stacks = is_ogryn and talent_settings.staggers_reduce_damage_taken.ogryn_stacks or talent_settings.staggers_reduce_damage_taken.normal_stacks

		template_context.buff_extension:add_internally_controlled_buff_with_stacks("adamant_staggers_reduce_damage_taken_buff", stacks, t)
	end
}
templates.adamant_staggers_reduce_damage_taken_buff = {
	refresh_duration_on_stack = true,
	predicted = false,
	hud_priority = 3,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_defensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	max_stacks = talent_settings.staggers_reduce_damage_taken.max_stacks,
	duration = talent_settings.staggers_reduce_damage_taken.duration,
	stat_buffs = {
		[stat_buffs.damage_taken_multiplier] = talent_settings.staggers_reduce_damage_taken.damage_taken_multiplier
	},
	proc_events = {
		[proc_events.on_player_hit_received] = 1
	},
	proc_func = function (params, template_data, template_context)
		template_data.finish = true
	end,
	conditional_exit_func = function (template_data, template_context)
		return template_data.finish
	end,
	related_talents = {
		"adamant_staggers_reduce_damage_taken"
	}
}
templates.adamant_crit_chance_on_kill = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	proc_func = function (params, template_data, template_context)
		local unit = template_context.unit
		local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

		if buff_extension then
			local t = FixedFrame.get_latest_fixed_time()

			buff_extension:add_internally_controlled_buff("adamant_crit_chance_on_kill_effect", t)
		end
	end,
	check_proc_func = CheckProcFunctions.on_kill
}
templates.adamant_crit_chance_on_kill_effect = {
	predicted = false,
	refresh_duration_on_stack = true,
	hud_priority = 4,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "buff",
	duration = talent_settings.crit_chance_on_kill.duration,
	max_stacks = talent_settings.crit_chance_on_kill.max_stacks,
	max_stacks_cap = talent_settings.crit_chance_on_kill.max_stacks,
	stat_buffs = {
		[stat_buffs.critical_strike_chance] = talent_settings.crit_chance_on_kill.crit_chance
	},
	related_talents = {
		"adamant_kills_grant_crit_chance"
	}
}
templates.adamant_crits_rend = {
	predicted = false,
	class_name = "buff",
	stat_buffs = {
		[stat_buffs.critical_strike_rending_multiplier] = talent_settings.crits_rend.rending
	}
}
templates.adamant_elite_special_kills_reload_speed = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_elite_or_special_kill,
	proc_func = function (params, template_data, template_context, t)
		local player_unit = template_context.unit
		local buff_extension = ScriptUnit.extension(player_unit, "buff_system")
		local reload_buff = "adamant_increased_reload_speed_on_multiple_hits_effect"

		buff_extension:add_internally_controlled_buff(reload_buff, t)
	end
}
templates.adamant_increased_reload_speed_on_multiple_hits_effect = {
	predicted = false,
	hud_priority = 1,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	max_stacks = 1,
	class_name = "proc_buff",
	always_show_in_hud = true,
	proc_events = {
		[proc_events.on_reload] = 1
	},
	stat_buffs = {
		[stat_buffs.reload_speed] = talent_settings.elite_special_kills_reload_speed.reload_speed
	},
	start_func = function (template_data, template_context)
		local unit = template_context.unit
		template_data.visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
		local unit_data_extension = ScriptUnit.extension(template_context.unit, "unit_data_system")
		template_data.weapon_action_component = unit_data_extension:read_component("weapon_action")
		template_data.inventory_component = unit_data_extension:read_component("inventory")
	end,
	proc_func = function (params, template_data, template_context, t)
		template_data.done = true
	end,
	conditional_exit_func = function (template_data, template_context)
		local inventory_component = template_data.inventory_component
		local visual_loadout_extension = template_data.visual_loadout_extension
		local wielded_slot_id = inventory_component.wielded_slot
		local weapon_template = visual_loadout_extension:weapon_template_from_slot(wielded_slot_id)
		local _, current_action = Action.current_action(template_data.weapon_action_component, weapon_template)
		local action_kind = current_action and current_action.kind
		local is_reloading = action_kind and (action_kind == "reload_shotgun" or action_kind == "reload_state" or action_kind == "ranged_load_special")

		return template_data.done and not is_reloading
	end,
	related_talents = {
		"adamant_elite_special_kills_reload_speed"
	}
}
templates.adamant_dodge_grants_damage = {
	predicted = false,
	hud_priority = 4,
	allow_proc_while_active = true,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	class_name = "proc_buff",
	active_duration = talent_settings.dodge_grants_damage.duration,
	proc_events = {
		[proc_events.on_successful_dodge] = 1
	},
	proc_stat_buffs = {
		[stat_buffs.damage] = talent_settings.dodge_grants_damage.damage
	},
	related_talents = {
		"adamant_dodge_grants_damage"
	}
}
templates.adamant_stacking_weakspot_strength = {
	class_name = "proc_buff",
	predicted = false,
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_non_weakspot_hit,
	proc_func = function (params, template_data, template_context, t)
		template_context.buff_extension:add_internally_controlled_buff("adamant_stacking_weakspot_strength_buff", t)
	end
}
templates.adamant_stacking_weakspot_strength_buff = {
	class_name = "proc_buff",
	predicted = false,
	hud_priority = 4,
	hud_icon = "content/ui/textures/icons/buffs/hud/psyker/psyker_default_offensive_talent",
	hud_icon_gradient_map = "content/ui/textures/color_ramps/talent_default",
	max_stacks = talent_settings.stacking_weakspot_strength.max_stacks,
	max_stacks_cap = talent_settings.stacking_weakspot_strength.max_stacks,
	stat_buffs = {
		[stat_buffs.weakspot_power_level_modifier] = talent_settings.stacking_weakspot_strength.strength
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_weakspot_hit,
	proc_func = function (params, template_data, template_context, t)
		template_data.finish = true
	end,
	conditional_exit_func = function (template_data, template_context)
		return template_data.finish
	end
}
templates.adamant_temp_judge_dredd = {
	class_name = "proc_buff",
	predicted = false,
	stat_buffs = {
		[stat_buffs.toughness] = 75,
		[stat_buffs.ranged_toughness_damage_taken_multiplier] = 0.5,
		[stat_buffs.reload_speed] = 0.5,
		[stat_buffs.power_level_modifier] = 0.5,
		[stat_buffs.suppression_dealt] = 1,
		[stat_buffs.ranged_damage] = 0.25
	},
	keywords = {
		keywords.suppression_immune
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.025, false, "adamant_temp_judge_dredd")
	end
}
templates.adamant_temp_riot_control = {
	class_name = "proc_buff",
	predicted = false,
	stat_buffs = {
		[stat_buffs.toughness] = 100,
		[stat_buffs.toughness_damage_taken_multiplier] = 0.5,
		[stat_buffs.impact_modifier] = 1,
		[stat_buffs.max_melee_hit_mass_attack_modifier] = 0.5,
		[stat_buffs.melee_damage] = 0.25,
		[stat_buffs.toughness_melee_replenish] = 0.5
	},
	keywords = {
		keywords.stun_immune
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.025, false, "adamant_temp_riot_control")
	end
}
templates.adamant_temp_enforcer = {
	predicted = false,
	class_name = "proc_buff",
	stat_buffs = {
		[stat_buffs.toughness] = 50,
		[stat_buffs.toughness_damage_taken_multiplier] = 0.6,
		[stat_buffs.impact_modifier] = 0.5,
		[stat_buffs.max_melee_hit_mass_attack_modifier] = 1,
		[stat_buffs.melee_damage] = 0.5,
		[stat_buffs.melee_attack_speed] = 0.3,
		[stat_buffs.movement_speed] = 0.25
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.025, false, "adamant_temp_enforcer")
	end
}
templates.adamant_temp_handler = {
	predicted = false,
	class_name = "proc_buff",
	stat_buffs = {
		[stat_buffs.toughness] = 25,
		[stat_buffs.ranged_toughness_damage_taken_multiplier] = 0.6,
		[stat_buffs.ranged_damage] = 0.5,
		[stat_buffs.companion_damage_modifier] = 0.5,
		[stat_buffs.suppression_dealt] = 0.75,
		[stat_buffs.movement_speed] = 0.25
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.025, false, "adamant_temp_handler")
	end
}
templates.adamant_temp_beast_master = {
	predicted = false,
	class_name = "proc_buff",
	stat_buffs = {
		[stat_buffs.toughness] = 50,
		[stat_buffs.toughness_damage_taken_multiplier] = 0.6,
		[stat_buffs.melee_attack_speed] = 0.25,
		[stat_buffs.companion_damage_modifier] = 0.5,
		[stat_buffs.melee_damage] = 0.5,
		[stat_buffs.movement_speed] = 0.25
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.025, false, "adamant_temp_beast_master")
	end
}
templates.adamant_temp_investigator = {
	predicted = false,
	class_name = "proc_buff",
	stat_buffs = {
		[stat_buffs.damage] = 0.5,
		[stat_buffs.toughness] = 25,
		[stat_buffs.wield_speed] = 0.3,
		[stat_buffs.weakspot_damage] = 0.5,
		[stat_buffs.toughness_damage_taken_multiplier] = 0.75,
		[stat_buffs.toughness_replenish_modifier] = 0.5,
		[stat_buffs.reload_speed] = 0.25,
		[stat_buffs.movement_speed] = 0.25
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.075, false, "adamant_temp_investigator")
	end
}
templates.adamant_temp_supportive_fire = {
	class_name = "proc_buff",
	predicted = false,
	stat_buffs = {
		[stat_buffs.ranged_damage] = 0.3,
		[stat_buffs.suppression_dealt] = 1,
		[stat_buffs.ranged_toughness_damage_taken_multiplier] = 0.5,
		[stat_buffs.toughness_replenish_modifier] = 0.5,
		[stat_buffs.spread_modifier] = -0.3,
		[stat_buffs.recoil_modifier] = -0.2,
		[stat_buffs.sway_modifier] = 0.4
	},
	keywords = {
		keywords.suppression_immune
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.05, false, "adamant_temp_supportive_fire")
	end
}
templates.adamant_temp_fire_wall = {
	predicted = false,
	class_name = "proc_buff",
	stat_buffs = {
		[stat_buffs.toughness] = 50,
		[stat_buffs.movement_speed] = 0.2,
		[stat_buffs.stamina_cost_multiplier] = 0.75,
		[stat_buffs.toughness_replenish_modifier] = 0.75,
		[stat_buffs.wield_speed] = 0.25,
		[stat_buffs.damage] = 0.25,
		[stat_buffs.suppression_dealt] = 0.5,
		[stat_buffs.toughness_damage_taken_multiplier] = 0.7
	},
	proc_events = {
		[proc_events.on_hit] = 1
	},
	check_proc_func = CheckProcFunctions.on_kill,
	proc_func = function (params, template_data, template_context)
		Toughness.replenish_percentage(template_context.unit, 0.075, false, "adamant_temp_fire_wall")
	end
}

return templates
