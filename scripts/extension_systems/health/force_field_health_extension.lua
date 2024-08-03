local SpecialRulesSetting = require("scripts/settings/ability/special_rules_settings")
local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local TalentSettings = require("scripts/settings/talent/talent_settings")
local ForceFieldHealthExtension = class("ForceFieldHealthExtension")
local special_rules = SpecialRulesSetting.special_rules
local talent_settings = TalentSettings.psyker_3.combat_ability

function ForceFieldHealthExtension:init(extension_init_context, unit, extension_init_data)
	local owner_unit = extension_init_data.owner_unit
	self._unit = unit
	self._owner_unit = owner_unit
	self._talent_extension = ScriptUnit.extension(owner_unit, "talent_system")
	local sphere_shield = self._talent_extension:has_special_rule(special_rules.psyker_sphere_shield)
	self._sphere_shield = sphere_shield
	local max_health = talent_settings.health
	local max_sphere_health = talent_settings.sphere_health
	self._next_allowed_t = 0
	self._max_health = sphere_shield and max_sphere_health or max_health
	self._health = self._max_health
	self._is_dead = false
	self._damage_taken_total = 0
end

function ForceFieldHealthExtension:game_object_initialized(session, object_id)
	self._game_session = session
	self._game_object_id = object_id
	local owner_unit = self._owner_unit
	self._talent_extension = ScriptUnit.extension(owner_unit, "talent_system")
	local sphere_shield = self._talent_extension:has_special_rule(special_rules.psyker_sphere_shield)
	self._sphere_shield = sphere_shield
	local max_health = talent_settings.health
	local max_sphere_health = talent_settings.sphere_health
	self._damage_cooldown = talent_settings.damage_cooldown
	self._max_health = sphere_shield and max_sphere_health or max_health
	self._health = self._max_health
	self._local_damage = 1

	GameSession.set_game_object_field(self._game_session, self._game_object_id, "health", self._max_health)
	GameSession.set_game_object_field(self._game_session, self._game_object_id, "damage", 0)

	self._health_extension = ScriptUnit.extension(self._unit, "health_system")
end

function ForceFieldHealthExtension:pre_update(unit, dt, t)
	self._was_hit_by_critical_hit_this_render_frame = false
end

function ForceFieldHealthExtension:add_damage(damage_amount, permanent_damage, hit_actor, damage_profile, attack_type, attack_direction, attacking_unit)
	self:_add_damage(damage_amount)
end

function ForceFieldHealthExtension:tried_adding_damage(damage_amount, permanent_damage, hit_actor, damage_profile, attack_type, attack_direction, attacking_unit)
	self:_add_damage(damage_amount)
end

function ForceFieldHealthExtension:_add_damage(damage)
	if damage then
		self._damage_taken_total = self._damage_taken_total + damage
	end

	local t = Managers.time:time("gameplay")

	if t < self._next_allowed_t then
		return
	end

	local game_session = self._game_session
	local game_object_id = self._game_object_id
	self._next_allowed_t = t + self._damage_cooldown
	self._health = math.max(0, self._health - self._local_damage)

	GameSession.set_game_object_field(game_session, game_object_id, "damage", self._max_health - self._health)
	GameSession.set_game_object_field(game_session, game_object_id, "health", self._health)

	if self._health <= 0 then
		self:_set_dead()
		self:send_stat_data()
	end
end

function ForceFieldHealthExtension:send_stat_data()
	local player_unit_spawn_manager = Managers.state.player_unit_spawn
	local owner = player_unit_spawn_manager:owner(self._owner_unit)

	Managers.stats:record_private("hook_psyker_shield_damage_taken", owner, self._damage_taken_total)
end

function ForceFieldHealthExtension:_set_dead()
	self._is_dead = true
end

function ForceFieldHealthExtension:is_dead()
	return self._is_dead
end

function ForceFieldHealthExtension:add_heal(heal_amount, heal_type)
	return
end

function ForceFieldHealthExtension:max_health()
	return self._max_health
end

function ForceFieldHealthExtension:current_health()
	return self._health
end

function ForceFieldHealthExtension:current_health_percent()
	if self._max_health <= 0 then
		return 0
	end

	return self._health / self._max_health
end

function ForceFieldHealthExtension:damage_taken()
	return 0
end

function ForceFieldHealthExtension:permanent_damage_taken()
	return 0
end

function ForceFieldHealthExtension:permanent_damage_taken_percent()
	return 0
end

function ForceFieldHealthExtension:total_damage_taken()
	return 0
end

function ForceFieldHealthExtension:health_depleted()
	return self._health <= 0
end

function ForceFieldHealthExtension:is_alive()
	return not self._is_dead
end

function ForceFieldHealthExtension:is_unkillable()
	return false
end

function ForceFieldHealthExtension:is_invulnerable()
	return false
end

function ForceFieldHealthExtension:set_unkillable(should_be_unkillable)
	self._is_unkillable = should_be_unkillable
end

function ForceFieldHealthExtension:set_invulnerable(should_be_invulnerable)
	self._is_invulnerable = should_be_invulnerable
end

function ForceFieldHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	self._last_damaging_unit = last_damaging_unit
	self._last_hit_zone_name = hit_zone_name
	self._last_hit_was_critical = last_hit_was_critical
	self._was_hit_by_critical_hit_this_render_frame = self._was_hit_by_critical_hit_this_render_frame or last_hit_was_critical
end

function ForceFieldHealthExtension:last_damaging_unit()
	return self._last_damaging_unit
end

function ForceFieldHealthExtension:last_hit_zone_name()
	return self._last_hit_zone_name
end

function ForceFieldHealthExtension:last_hit_was_critical()
	return self._last_hit_was_critical
end

function ForceFieldHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return self._was_hit_by_critical_hit_this_render_frame
end

function ForceFieldHealthExtension:num_wounds()
	return 1
end

function ForceFieldHealthExtension:max_wounds()
	return 1
end

implements(ForceFieldHealthExtension, HealthExtensionInterface)

return ForceFieldHealthExtension
