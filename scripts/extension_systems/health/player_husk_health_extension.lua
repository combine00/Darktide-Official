local Health = require("scripts/utilities/health")
local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local PlayerHuskHealthExtension = class("PlayerHuskHealthExtension")

function PlayerHuskHealthExtension:init(extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id)
	self._game_session = game_session
	self._game_object_id = game_object_id
	self._world = extension_init_context.world
	self._wwise_world = Wwise.wwise_world(self._world)
	self._is_dead = false
	self._is_knocked_down = false
	self._health = 0
	self._damage = 0
	self._permanent_damage = 0
	self._knocked_down_health = 0
	self._knocked_down_damage = 0
	self._unit = unit
	self._is_local_unit = extension_init_data.is_local_unit
	self._max_wounds = extension_init_data.wounds
	local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
	self._character_state_read_component = unit_data_extension:read_component("character_state")
end

function PlayerHuskHealthExtension:pre_update(unit, dt, t)
	self._was_hit_by_critical_hit_this_render_frame = false
end

function PlayerHuskHealthExtension:fixed_update(unit, dt, t)
	self._is_knocked_down = PlayerUnitStatus.is_knocked_down(self._character_state_read_component)
	local game_session = self._game_session
	local game_object_id = self._game_object_id
	self._health = GameSession.game_object_field(game_session, game_object_id, "health")
	self._damage = GameSession.game_object_field(game_session, game_object_id, "damage")
	self._permanent_damage = GameSession.game_object_field(game_session, game_object_id, "permanent_damage")
	self._knocked_down_health = GameSession.game_object_field(game_session, game_object_id, "knocked_down_health")
	self._knocked_down_damage = GameSession.game_object_field(game_session, game_object_id, "knocked_down_damage")
	self._max_wounds = GameSession.game_object_field(game_session, game_object_id, "max_wounds")
end

function PlayerHuskHealthExtension:is_alive()
	return not self._is_dead
end

function PlayerHuskHealthExtension:is_unkillable()
	return false
end

function PlayerHuskHealthExtension:is_invulnerable()
	return false
end

function PlayerHuskHealthExtension:current_health()
	local max_health = self:max_health()
	local damage_taken = self:damage_taken()

	return math.max(0, max_health - damage_taken)
end

function PlayerHuskHealthExtension:current_health_percent()
	local max_health = self:max_health()
	local damage_taken = self:damage_taken()

	if max_health <= 0 then
		return 0
	end

	return math.max(0, 1 - damage_taken / max_health)
end

function PlayerHuskHealthExtension:damage_taken()
	if self._is_knocked_down then
		return self._knocked_down_damage
	else
		return self._damage
	end
end

function PlayerHuskHealthExtension:permanent_damage_taken()
	if self._is_knocked_down then
		return 0
	else
		return self._permanent_damage
	end
end

function PlayerHuskHealthExtension:permanent_damage_taken_percent()
	local max_health = self:max_health()
	local permanent_damage = self:permanent_damage_taken()

	if max_health <= 0 then
		return 0
	end

	return permanent_damage / max_health
end

function PlayerHuskHealthExtension:total_damage_taken()
	local max_health = self:max_health()
	local damage_taken = self:damage_taken()

	return math.min(max_health, damage_taken)
end

function PlayerHuskHealthExtension:max_health()
	if self._is_knocked_down then
		return self._knocked_down_health
	else
		return self._health
	end
end

function PlayerHuskHealthExtension:add_damage()
	return
end

function PlayerHuskHealthExtension:add_heal()
	return
end

function PlayerHuskHealthExtension:remove_wounds()
	return
end

function PlayerHuskHealthExtension:entered_knocked_down()
	return
end

function PlayerHuskHealthExtension:exited_knocked_down()
	return
end

function PlayerHuskHealthExtension:health_depleted()
	local max_health = self:max_health()
	local damage = self:damage_taken()

	return max_health <= damage
end

function PlayerHuskHealthExtension:should_die()
	local num_wounds = self:num_wounds()

	if num_wounds <= 0 then
		return true
	end

	local max_health = self:max_health()
	local permanent_damage = self:permanent_damage_taken()

	if max_health <= 0 then
		return true
	end

	return permanent_damage / max_health > 1 / num_wounds
end

function PlayerHuskHealthExtension:set_unkillable(should_be_unkillable)
	return
end

function PlayerHuskHealthExtension:set_invulnerable(should_be_invulnerable)
	return
end

function PlayerHuskHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	self._last_damaging_unit = last_damaging_unit
	self._last_hit_zone_name = hit_zone_name
	self._last_hit_was_critical = last_hit_was_critical
	self._was_hit_by_critical_hit_this_render_frame = self._was_hit_by_critical_hit_this_render_frame or last_hit_was_critical
end

function PlayerHuskHealthExtension:last_damaging_unit()
	return self._last_damaging_unit
end

function PlayerHuskHealthExtension:last_hit_zone_name()
	return self._last_hit_zone_name
end

function PlayerHuskHealthExtension:last_hit_was_critical()
	return self._last_hit_was_critical
end

function PlayerHuskHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return self._was_hit_by_critical_hit_this_render_frame
end

function PlayerHuskHealthExtension:kill()
	Managers.event:trigger("unit_died", self._unit)

	HEALTH_ALIVE[self._unit] = nil
	self._is_dead = true
end

function PlayerHuskHealthExtension:num_wounds()
	local permanent_damage = self:permanent_damage_taken()
	local max_wounds = self:max_wounds()
	local max_health = self:max_health()
	local num_wounds = Health.calculate_num_segments(permanent_damage, max_health, max_wounds)

	return num_wounds
end

function PlayerHuskHealthExtension:max_wounds()
	return self._max_wounds
end

implements(PlayerHuskHealthExtension, HealthExtensionInterface)

return PlayerHuskHealthExtension
