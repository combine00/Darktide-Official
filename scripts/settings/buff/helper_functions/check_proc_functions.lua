local AttackSettings = require("scripts/settings/damage/attack_settings")
local Breed = require("scripts/utilities/breed")
local Breeds = require("scripts/settings/breed/breeds")
local ConditionalFunctions = require("scripts/settings/buff/helper_functions/conditional_functions")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local MinionState = require("scripts/utilities/minion_state")
local attack_results = AttackSettings.attack_results
local stagger_results = AttackSettings.stagger_results
local attack_types = AttackSettings.attack_types
local damage_types = DamageSettings.damage_types
local CLOSE_RANGE_RANGED = DamageSettings.ranged_close
local CLOSE_RANGE_RANGED_SQUARED = CLOSE_RANGE_RANGED * CLOSE_RANGE_RANGED
local CheckProcFunctions = {}
local _is_within_close_distance = nil

function CheckProcFunctions.all(...)
	local conditions = {
		...
	}

	return function (...)
		for i = 1, #conditions do
			if not conditions[i](...) then
				return false
			end
		end

		return true
	end
end

function CheckProcFunctions.any(...)
	local conditions = {
		...
	}

	return function (...)
		for i = 1, #conditions do
			if conditions[i](...) then
				return true
			end
		end

		return false
	end
end

function CheckProcFunctions.always(params, template_data, template_context, t)
	return true
end

function CheckProcFunctions.never(params, template_data, template_context, t)
	return false
end

function CheckProcFunctions.on_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	return true
end

function CheckProcFunctions.on_one_hit_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	return params.one_hit_kill
end

function CheckProcFunctions.on_non_kill(params, template_data, template_context, t)
	if params.attack_result == attack_results.died then
		return false
	end

	return true
end

function CheckProcFunctions.on_weakspot_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if not params.hit_weakspot then
		return false
	end

	return true
end

function CheckProcFunctions.on_elite_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if not params.tags or not params.tags.elite then
		return false
	end

	return true
end

function CheckProcFunctions.on_special_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if not params.tags or not params.tags.special then
		return false
	end

	return true
end

function CheckProcFunctions.on_elite_or_special_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if not params.tags then
		return false
	end

	if not params.tags.elite and not params.tags.special then
		return false
	end

	return true
end

function CheckProcFunctions.on_elite_or_special_or_monster_hit(params, template_data, template_context, t)
	if not params.tags then
		return false
	end

	if not params.tags.elite and not params.tags.special and not params.tags.monster then
		return false
	end

	return true
end

function CheckProcFunctions.on_ranged_enemy_killed(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if not params.tags then
		return false
	end

	if not params.tags.far then
		return false
	end

	return true
end

function CheckProcFunctions.on_elite_or_special_minion_death(params, template_data, template_context, t)
	if not params.tags then
		return false
	end

	if not params.tags.elite and not params.tags.special then
		return false
	end

	return true
end

function CheckProcFunctions.on_elite_or_special_melee_kill(params, template_data, template_context, t)
	return CheckProcFunctions.on_melee_kill(params, template_data, template_context, t) and CheckProcFunctions.on_elite_or_special_kill(params, template_data, template_context, t)
end

function CheckProcFunctions.on_elite_or_special_ranged_kill(params, template_data, template_context, t)
	return CheckProcFunctions.on_ranged_kill(params, template_data, template_context, t) and CheckProcFunctions.on_elite_or_special_kill(params, template_data, template_context, t)
end

function CheckProcFunctions.on_ranged_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return is_ranged_attack
end

function CheckProcFunctions.on_melee_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if params.attack_type ~= attack_types.melee then
		return false
	end

	return true
end

function CheckProcFunctions.on_sticky_kill(params, template_data, template_context, t)
	local sticky = params.sticky_attack

	if not sticky then
		return false
	end

	if params.attack_result ~= attack_results.died then
		return false
	end

	return true
end

function CheckProcFunctions.on_special_smite_kill(params, template_data, template_context, t)
	local killed = params.attack_result == attack_results.died

	if not killed then
		return false
	end

	local sticky = params.sticky_attack
	local smite = params.damage_type == damage_types.smite

	if not smite and not sticky then
		return false
	end

	local is_melee = params.attack_type == attack_types.melee

	if not is_melee then
		return false
	end

	return true
end

function CheckProcFunctions.on_smite_attack(params, template_data, template_context, t)
	return params.damage_type == damage_types.smite
end

function CheckProcFunctions.on_smite_kill(params, template_data, template_context, t)
	if params.damage_type ~= damage_types.smite then
		return false
	end

	if params.attack_result ~= attack_results.died then
		return false
	end

	return true
end

local warp_damage_types = DamageSettings.warp_damage_types

function CheckProcFunctions.on_warp_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	local damage_type = params.damage_type

	if warp_damage_types[damage_type] then
		return true
	end

	return false
end

function CheckProcFunctions.on_non_warp_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	local damage_type = params.damage_type

	if warp_damage_types[damage_type] then
		return false
	end

	return true
end

function CheckProcFunctions.on_ranged_close_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	if not is_ranged_attack then
		return false
	end

	return _is_within_close_distance(params, template_data, template_context, t)
end

function CheckProcFunctions.on_explosion_close_kill(params, template_data, template_context, t)
	if params.attack_result ~= attack_results.died then
		return false
	end

	if params.attack_type ~= attack_types.explosion then
		return false
	end

	return _is_within_close_distance(params, template_data, template_context, t)
end

function CheckProcFunctions.on_block_broken(params, template_data, template_context, t)
	return params.block_broken
end

function CheckProcFunctions.on_crit(params, template_data, template_context, t)
	return params.is_critical_strike
end

function CheckProcFunctions.on_crit_ranged(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return params.is_critical_strike and is_ranged_attack
end

function CheckProcFunctions.on_crit_kills(params, template_data, template_context, t)
	return params.is_critical_strike and params.attack_result == attack_results.died
end

function CheckProcFunctions.on_ranged_hit(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return is_ranged_attack
end

function CheckProcFunctions.on_melee_hit(params, template_data, template_context, t)
	return params.attack_type == attack_types.melee
end

function CheckProcFunctions.on_push_hit(params, template_data, template_context, t)
	return params.attack_type == attack_types.push
end

function CheckProcFunctions.on_buff_hit(params, template_data, template_context, t)
	return params.attack_type == attack_types.buff
end

function CheckProcFunctions.on_non_buff_hit(params, template_data, template_context, t)
	return not CheckProcFunctions.on_buff_hit(params, template_data, template_context, t)
end

function CheckProcFunctions.on_melee_weapon_special_hit(params, template_data, template_context, t)
	return params.weapon_special and params.attack_type == attack_types.melee
end

function CheckProcFunctions.on_melee_crit_hit(params, template_data, template_context, t)
	return params.is_critical_strike and params.attack_type == attack_types.melee
end

function CheckProcFunctions.on_shout_hit(params, template_data, template_context, t)
	return params.attack_type == attack_types.shout
end

function CheckProcFunctions.on_shout_crit_hit(params, template_data, template_context, t)
	return params.is_critical_strike and params.attack_type == attack_types.shout
end

function CheckProcFunctions.on_first_target_melee_hit(params, template_data, template_context, t)
	if not CheckProcFunctions.on_melee_hit(params, template_data, template_context, t) then
		return false
	end

	local target_number = params.target_number

	return target_number == 1
end

function CheckProcFunctions.on_multiple_melee_hit(params, template_data, template_context, t)
	if not CheckProcFunctions.on_melee_hit(params, template_data, template_context, t) then
		return false
	end

	local template_override_data = template_context.template_override_data
	local template = template_context.template
	local buff_data = template_override_data and template_override_data.buff_data or template_data.buff_data or template.buff_data
	local required_num_hits = buff_data.required_num_hits
	local target_number = params.target_number

	return target_number and required_num_hits <= target_number
end

function CheckProcFunctions.on_ranged_crit_hit(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return params.is_critical_strike and is_ranged_attack
end

function CheckProcFunctions.on_explosion_hit(params, template_data, template_context, t)
	return params.attack_type == attack_types.explosion
end

function CheckProcFunctions.on_heavy_hit(params, template_data, template_context, t)
	if params.is_heavy then
		return true
	end

	local melee_attack_strength = params.melee_attack_strength

	return melee_attack_strength and melee_attack_strength == "heavy"
end

function CheckProcFunctions.on_damaging_hit(params, template_data, template_context, t)
	return params.damage > 0
end

function CheckProcFunctions.on_weakspot_hit(params, template_data, template_context, t)
	return params.hit_weakspot
end

function CheckProcFunctions.on_non_weakspot_hit(params, template_data, template_context, t)
	return not params.hit_weakspot
end

function CheckProcFunctions.on_non_weakspot_hit_melee(params, template_data, template_context, t)
	return not params.hit_weakspot and params.attack_type == attack_types.melee
end

function CheckProcFunctions.on_non_weakspot_hit_ranged(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return not params.hit_weakspot and is_ranged_attack
end

function CheckProcFunctions.on_weakspot_hit_melee(params, template_data, template_context, t)
	return params.hit_weakspot and params.attack_type == attack_types.melee
end

function CheckProcFunctions.on_weakspot_hit_ranged(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return params.hit_weakspot and is_ranged_attack
end

function CheckProcFunctions.on_weakspot_crit(params, template_data, template_context, t)
	return params.hit_weakspot and params.is_critical_strike
end

function CheckProcFunctions.on_ranged_weakspot_kills(params, template_data, template_context, t)
	return CheckProcFunctions.on_weakspot_hit(params, template_data, template_context, t) and CheckProcFunctions.on_ranged_kill(params, template_data, template_context, t)
end

function CheckProcFunctions.on_melee_weakspot_kills(params, template_data, template_context, t)
	return CheckProcFunctions.on_weakspot_hit(params, template_data, template_context, t) and CheckProcFunctions.on_melee_kill(params, template_data, template_context, t)
end

function CheckProcFunctions.on_alternative_fire_hit(params, template_data, template_context, t)
	return params.alternative_fire
end

function CheckProcFunctions.on_ranged_hit_weakspot(params, template_data, template_context, t)
	local is_ranged_attack = params.attack_type == attack_types.ranged or params.damage_profile and params.damage_profile.count_as_ranged_attack

	return params.hit_weakspot and is_ranged_attack
end

function CheckProcFunctions.on_stagger_hit(params, template_data, template_context, t)
	local attacked_unit = params.attacked_unit

	return MinionState.is_minion(attacked_unit) and MinionState.is_staggered(attacked_unit)
end

function CheckProcFunctions.on_staggering_hit(params, template_data, template_context, t)
	local stagger_result = params.stagger_result

	return stagger_result == stagger_results.stagger
end

function CheckProcFunctions.on_melee_stagger_hit(params, template_data, template_context, t)
	return CheckProcFunctions.on_melee_hit(params, template_data, template_context, t) and CheckProcFunctions.on_stagger_hit(params, template_data, template_context, t)
end

function CheckProcFunctions.on_weapon_special_kill(params, template_data, template_context, t)
	return params.weapon_special and params.attack_result == attack_results.died
end

function CheckProcFunctions.on_weapon_special_melee_stagger_hit(params, template_data, template_context, t)
	return CheckProcFunctions.on_melee_weapon_special_hit(params, template_data, template_context, t) and CheckProcFunctions.on_stagger_hit(params, template_data, template_context, t)
end

function CheckProcFunctions.on_ranged_stagger_hit(params, template_data, template_context, t)
	return CheckProcFunctions.on_ranged_hit(params, template_data, template_context, t) and CheckProcFunctions.on_stagger_hit(params, template_data, template_context, t)
end

function CheckProcFunctions.on_chain_lightning_hit(params, template_data, template_context, t)
	return params.damage_type == damage_types.electrocution
end

function CheckProcFunctions.on_shoot_hit_multiple(params, template_data, template_context, t)
	local template_override_data = template_context.template_override_data
	local template = template_context.template
	local buff_data = template_override_data and template_override_data.buff_data or template_data.buff_data or template.buff_data
	local required_num_hits = buff_data.required_num_hits

	return required_num_hits <= params.num_hit_units
end

function CheckProcFunctions.on_explosion_hit_multiple(params, template_data, template_context, t)
	local template_override_data = template_context.template_override_data
	local template = template_context.template
	local buff_data = template_override_data and template_override_data.buff_data or template_data.buff_data or template.buff_data
	local required_num_hits = buff_data.required_num_hits

	return required_num_hits <= params.number_of_hit_units
end

function CheckProcFunctions.on_hit_all_pellets_on_same(params, template_data, template_context, t)
	return params.hit_all_pellets_on_same
end

function CheckProcFunctions.attacked_unit_is_minion(params, template_data, template_context, t)
	return MinionState.is_minion(params.attacked_unit)
end

function CheckProcFunctions.is_weapon_special(params, template_data, template_context, t)
	return params.weapon_special
end

function CheckProcFunctions.on_elite_hit(params, template_data, template_context, t)
	if not params.tags or not params.tags.elite then
		return false
	end

	return true
end

function CheckProcFunctions.hit_has_charge_level(params, template_data, template_context, t)
	return params.charge_level ~= nil
end

function CheckProcFunctions.would_die(params, template_data, template_context, t)
	local unit = template_context.unit
	local attacked_unit = params.attacked_unit

	if unit ~= attacked_unit then
		return false
	end

	local health_extension = ScriptUnit.extension(unit, "health_system")
	local current_health = health_extension:current_health()
	local is_going_to_die = current_health <= 1

	return is_going_to_die
end

function CheckProcFunctions.check_item_slot(params, template_data, template_context, t)
	local item_slot_name = template_context.item_slot_name

	if not item_slot_name then
		return true
	end

	local attack_item_slot_origin = params.item_slot_origin

	if attack_item_slot_origin then
		local is_slot_active = attack_item_slot_origin == item_slot_name

		return is_slot_active
	end

	local attack_instigator_unit = params.attack_instigator_unit
	local is_instegator_alive = attack_instigator_unit and ALIVE[attack_instigator_unit]
	local projectile_damage_extension = is_instegator_alive and ScriptUnit.has_extension(attack_instigator_unit, "projectile_damage_system")

	if not projectile_damage_extension then
		return ConditionalFunctions.is_item_slot_wielded(template_data, template_context)
	end

	local projectile_origin_item_slot = projectile_damage_extension:origin_item_slot()
	local is_slot_active = projectile_origin_item_slot == item_slot_name

	return is_slot_active
end

function CheckProcFunctions.on_melee_and_check_item_slot(params, template_data, template_context, t)
	return CheckProcFunctions.on_melee_hit(params, template_data, template_context, t) and CheckProcFunctions.check_item_slot(params, template_data, template_context, t)
end

function CheckProcFunctions.on_ranged_and_check_item_slot(params, template_data, template_context, t)
	return CheckProcFunctions.on_ranged_hit(params, template_data, template_context, t) and CheckProcFunctions.check_item_slot(params, template_data, template_context, t)
end

function CheckProcFunctions.on_explosion_and_check_item_slot(params, template_data, template_context, t)
	return CheckProcFunctions.on_explosion_hit(params, template_data, template_context, t) and CheckProcFunctions.check_item_slot(params, template_data, template_context, t)
end

function CheckProcFunctions.is_weapon_special_active(params, template_data, template_context, t)
	return params.is_weapon_special_active
end

function CheckProcFunctions.on_continues_fire_full_auto(params, template_data, template_context, t)
	return params.num_shots_fired > 1
end

function CheckProcFunctions.on_continues_fire_semi_automatic(params, template_data, template_context, t)
	return params.combo_count > 1
end

function CheckProcFunctions.on_melee_parry_kill(params, template_data, template_context, t)
	return params.attack_type == attack_types.melee and params.weapon_special
end

function CheckProcFunctions.on_item_match(params, template_data, template_context, t)
	local attacking_item_name = params.attacking_item and params.attacking_item.name
	local buff_item_name = template_context.item and template_context.item.name
	local is_match = attacking_item_name == buff_item_name

	return is_match
end

function _is_within_close_distance(params, template_data, template_context, t)
	local hit_world_position_box = params.hit_world_position
	local hit_world_position = hit_world_position_box and hit_world_position_box:unbox()

	if not hit_world_position then
		return false
	end

	local attacking_unit = params.attacking_unit
	local close_range_squared = CLOSE_RANGE_RANGED_SQUARED
	local attacking_pos = POSITION_LOOKUP[attacking_unit] or Unit.world_position(attacking_unit, 1)
	local distance_squared = Vector3.distance_squared(hit_world_position, attacking_pos)
	local is_within_distance = distance_squared <= close_range_squared

	return is_within_distance
end

return CheckProcFunctions
