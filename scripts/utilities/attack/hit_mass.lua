local Armor = require("scripts/utilities/attack/armor")
local AttackSettings = require("scripts/settings/damage/attack_settings")
local Breed = require("scripts/utilities/breed")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local attack_types = AttackSettings.attack_types
local buff_keywords = BuffSettings.keywords
local HitMass = {}
local _target_breed, _hit_mass_from_breed, _hit_mass_from_object = nil

function HitMass.target_hit_mass(attacker_unit, target_unit, hit_weakspot, is_critical_strike, attack_type)
	local attacker_buff_extension = ScriptUnit.has_extension(attacker_unit, "buff_system")
	local use_reduced_hit_mass = attacker_buff_extension and attacker_buff_extension:has_keyword(buff_keywords.use_reduced_hit_mass)
	local hit_mass = nil
	local breed = _target_breed(target_unit)

	if breed then
		hit_mass = _hit_mass_from_breed(target_unit, breed, use_reduced_hit_mass, attacker_unit)
	else
		hit_mass = _hit_mass_from_object(target_unit)
	end

	if attacker_buff_extension then
		local stat_buffs = attacker_buff_extension:stat_buffs()
		local consumed_hit_mass_modifier = stat_buffs.consumed_hit_mass_modifier or 1
		local consumed_hit_mass_modifier_on_weakspot_hit = stat_buffs.consumed_hit_mass_modifier_on_weakspot_hit or 1
		local consumed_hit_mass_modifier_on_ranged_hit = stat_buffs.consumed_hit_mass_modifier_on_ranged_hit or 1
		local consumed_hit_mass_modifier_on_ranged_critical_hit = stat_buffs.consumed_hit_mass_modifier_on_ranged_critical_hit or 1
		hit_mass = hit_mass * consumed_hit_mass_modifier

		if hit_weakspot then
			hit_mass = hit_mass * consumed_hit_mass_modifier_on_weakspot_hit
		end

		if attack_type == attack_types.ranged then
			hit_mass = hit_mass * consumed_hit_mass_modifier_on_ranged_hit

			if is_critical_strike then
				hit_mass = hit_mass * consumed_hit_mass_modifier_on_ranged_critical_hit
			end
		end
	end

	return hit_mass
end

function HitMass.consume_hit_mass(attacker_unit, target_unit, hit_mass_budget_attack, hit_mass_budget_impact, hit_weakspot, is_critical_strike, attack_type, hit_mass_override)
	local new_hit_mass_budget_attack, new_hit_mass_budget_impact = nil

	if hit_mass_override then
		new_hit_mass_budget_attack = math.max(0, hit_mass_budget_attack - hit_mass_override)
		new_hit_mass_budget_impact = math.max(0, hit_mass_budget_impact - hit_mass_override)
	else
		local target_hit_mass = HitMass.target_hit_mass(attacker_unit, target_unit, hit_weakspot, is_critical_strike, attack_type)
		new_hit_mass_budget_attack = math.max(0, hit_mass_budget_attack - target_hit_mass)
		new_hit_mass_budget_impact = math.max(0, hit_mass_budget_impact - target_hit_mass)
	end

	return new_hit_mass_budget_attack, new_hit_mass_budget_impact
end

function HitMass.hit_mass_limit_reached(hit_mass_budget_attack, hit_mass_budget_impact)
	local attack_limit_reached = hit_mass_budget_attack <= 0
	local impact_limit_reached = hit_mass_budget_impact <= 0

	return attack_limit_reached and impact_limit_reached
end

function HitMass.stopped_attack(hit_unit, hit_zone_name_or_nil, hit_mass_budget_attack, hit_mass_budget_impact, impact_config)
	if impact_config.destroy_on_impact then
		return true
	end

	if not HEALTH_ALIVE[hit_unit] then
		return false
	end

	local max_hit_mass_reached = HitMass.hit_mass_limit_reached(hit_mass_budget_attack, hit_mass_budget_impact)

	if max_hit_mass_reached then
		return true
	end

	local unit_data_extension = ScriptUnit.has_extension(hit_unit, "unit_data_system")
	local breed_or_nil = unit_data_extension and unit_data_extension:breed()
	local armor_aborts_attack = Armor.aborts_attack(hit_unit, breed_or_nil, hit_zone_name_or_nil)

	if armor_aborts_attack then
		return true
	end

	return false
end

function _target_breed(unit)
	local unit_data_ext = ScriptUnit.has_extension(unit, "unit_data_system")

	if not unit_data_ext then
		return nil
	end

	return unit_data_ext:breed()
end

local REDUCED_HIT_MASS_MULTIPLIER = 0.25

function _hit_mass_from_breed(unit, breed, use_reduced_hit_mass, attacker_unit)
	if not HEALTH_ALIVE[unit] then
		return 0
	end

	local is_player_or_prop_character = Breed.is_player(breed) or Breed.is_prop(breed) or Breed.is_living_prop(breed)
	local hit_mass = nil

	if is_player_or_prop_character then
		hit_mass = breed.hit_mass

		if breed.friendly_hit_mass then
			local side_system = Managers.state.extension:system("side_system")
			local is_ally = side_system:is_ally(attacker_unit, unit)

			if is_ally then
				hit_mass = breed.friendly_hit_mass
			end
		end
	else
		local health_extension = ScriptUnit.extension(unit, "health_system")
		hit_mass = health_extension:hit_mass()

		if use_reduced_hit_mass then
			hit_mass = hit_mass * REDUCED_HIT_MASS_MULTIPLIER
		end
	end

	return hit_mass
end

function _hit_mass_from_object(unit)
	local health_extension = ScriptUnit.has_extension(unit, "health_system")

	if health_extension and not health_extension:is_alive() then
		return 0
	end

	local hit_mass = Unit.get_data(unit, "hit_mass") or 0

	return hit_mass
end

return HitMass
