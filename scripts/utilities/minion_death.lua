local AttackSettings = require("scripts/settings/damage/attack_settings")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local Breed = require("scripts/utilities/breed")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local ImpactEffect = require("scripts/utilities/attack/impact_effect")
local RegionConstants = require("scripts/settings/region/region_constants")
local attack_results = AttackSettings.attack_results
local damage_efficiencies = AttackSettings.damage_efficiencies
local MinionDeath = {}
local _gib, _push_ragdoll, _check_damage_profile_override = nil

function MinionDeath.die(unit, attacking_unit_or_nil, attack_direction, hit_zone_name_or_nil, damage_profile, attack_type_or_nil, herding_template_or_nil, is_critical_strike_or_nil, damage_type_or_nil)
	Managers.state.minion_death:die(unit, attacking_unit_or_nil, attack_direction, hit_zone_name_or_nil, damage_profile, attack_type_or_nil, herding_template_or_nil, damage_type_or_nil)

	local override_damage_profile, override_hit_zone_name = _check_damage_profile_override(unit)
	damage_profile = override_damage_profile or damage_profile
	hit_zone_name_or_nil = override_hit_zone_name or hit_zone_name_or_nil

	_gib(unit, hit_zone_name_or_nil, attack_direction, damage_profile, is_critical_strike_or_nil)
end

function MinionDeath.set_dead(unit, attack_direction, hit_zone_name, damage_profile_name, do_ragdoll_push, herding_template_name_or_nil)
	local unit_id = Managers.state.unit_spawner:game_object_id(unit)
	local minion_death_manager = Managers.state.minion_death

	minion_death_manager:set_dead(unit, attack_direction, hit_zone_name, damage_profile_name, do_ragdoll_push, herding_template_name_or_nil)

	local hit_zone_id = hit_zone_name and NetworkLookup.hit_zones[hit_zone_name] or nil
	local damage_profile_id = NetworkLookup.damage_profile_templates[damage_profile_name]
	local herding_template_id = herding_template_name_or_nil and NetworkLookup.herding_templates[herding_template_name_or_nil] or nil

	Managers.state.game_session:send_rpc_clients("rpc_minion_set_dead", unit_id, attack_direction, hit_zone_id, damage_profile_id, do_ragdoll_push == true, herding_template_id)
end

local IMPACT_FX_DATA = {
	local_only = true
}

function MinionDeath.attack_ragdoll(ragdoll_unit, attack_direction, damage_profile, damage_type, hit_zone_name_or_nil, hit_world_position_or_nil, attacking_unit_or_nil, hit_actor_or_nil, herding_template_or_nil, critical_strike_or_nil)
	if not DEDICATED_SERVER then
		if Managers.account:region_has_restriction(RegionConstants.restrictions.ragdoll_interaction) then
			return
		end

		local attack_ragdolls_enabled_locally = Application.user_setting("gore_settings", "attack_ragdolls_enabled")

		if attack_ragdolls_enabled_locally == nil then
			attack_ragdolls_enabled_locally = GameParameters.attack_ragdolls_enabled
		end

		if not attack_ragdolls_enabled_locally then
			return
		end

		local hit_zone_name = hit_zone_name_or_nil or "center_mass"

		_push_ragdoll(ragdoll_unit, hit_zone_name, attack_direction, damage_profile, herding_template_or_nil)
		_gib(ragdoll_unit, hit_zone_name, attack_direction, damage_profile, critical_strike_or_nil)

		local damage = 1
		local attack_result = attack_results.damaged
		local hit_normal = nil
		local attack_was_stopped = false
		local damage_efficiency = damage_efficiencies.full

		ImpactEffect.play(ragdoll_unit, hit_actor_or_nil, damage, damage_type, hit_zone_name, attack_result, hit_world_position_or_nil, hit_normal, attack_direction, attacking_unit_or_nil, IMPACT_FX_DATA, attack_was_stopped, nil, damage_efficiency, nil)
	end
end

function _push_ragdoll(ragdoll_unit, hit_zone_name, attack_direction, damage_profile, herding_template_or_nil)
	local minion_death_manager = Managers.state.minion_death
	local minion_ragdoll = minion_death_manager:minion_ragdoll()
	local on_dead_ragdoll = true

	minion_ragdoll:push_ragdoll(ragdoll_unit, attack_direction, damage_profile, hit_zone_name, herding_template_or_nil, on_dead_ragdoll)
end

local VALID_HIT_ZONES = {
	lower_left_arm = true,
	upper_right_arm = true,
	torso = true,
	lower_right_arm = true,
	upper_tail = true,
	upper_left_leg = true,
	lower_right_leg = true,
	upper_right_leg = true,
	head = true,
	center_mass = true,
	upper_left_arm = true,
	lower_left_leg = true,
	lower_tail = true
}

local function _find_random_hitzone(ragdoll_unit, optional_is_critical_strike)
	local breed = Breed.unit_breed_or_nil(ragdoll_unit)
	local breed_hit_zones = breed.hit_zones
	local num_breed_hit_zones = #breed_hit_zones
	local hit_zone_name = nil
	local num_iterations = 0

	if not optional_is_critical_strike then
		repeat
			local random_hit_zone_name = breed_hit_zones[math.random(1, num_breed_hit_zones)].name

			if VALID_HIT_ZONES[random_hit_zone_name] then
				hit_zone_name = random_hit_zone_name
			end

			num_iterations = num_iterations + 1
		until hit_zone_name ~= nil or num_breed_hit_zones <= num_iterations
	end

	return hit_zone_name or "center_mass"
end

function _gib(ragdoll_unit, hit_zone_name_or_nil, attack_direction, damage_profile, is_critical_strike_or_nil)
	local should_gib = true

	if Managers.account and Managers.account:region_has_restriction(RegionConstants.restrictions.gibbing) then
		should_gib = false
	end

	if should_gib then
		if damage_profile.random_gib_hitzone then
			hit_zone_name_or_nil = _find_random_hitzone(ragdoll_unit, is_critical_strike_or_nil)
		end

		local visual_loadout_extension = ScriptUnit.extension(ragdoll_unit, "visual_loadout_system")

		if visual_loadout_extension:can_gib(hit_zone_name_or_nil) then
			visual_loadout_extension:gib(hit_zone_name_or_nil, attack_direction, damage_profile, is_critical_strike_or_nil)
		end
	end
end

function _check_damage_profile_override(unit)
	local blackboard = BLACKBOARDS[unit]
	local minion_have_gib_override = Blackboard.has_component(blackboard, "gib_override")

	if minion_have_gib_override then
		local gib_override_component = blackboard.gib_override
		local should_override = gib_override_component.should_override

		if should_override then
			local override_damage_profile = gib_override_component.target_template
			local damage_profile = DamageProfileTemplates[override_damage_profile]
			local override_hit_zone_name = gib_override_component.override_hit_zone_name

			return damage_profile, override_hit_zone_name
		end
	end
end

return MinionDeath
