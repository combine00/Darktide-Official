local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local ForceFieldHuskHealthExtension = class("ForceFieldHuskHealthExtension")

local function _health_and_damage(game_session, game_object_id)
	local health = GameSession.game_object_field(game_session, game_object_id, "health")
	local damage = GameSession.game_object_field(game_session, game_object_id, "damage")

	return health, damage
end

function ForceFieldHuskHealthExtension:init(extension_init_context, unit, extension_init_data, game_session, game_object_id, owner_id)
	self.game_session = game_session
	self.game_object_id = game_object_id
	self.is_dead = false
end

function ForceFieldHuskHealthExtension:pre_update(unit, dt, t)
	self._was_hit_by_critical_hit_this_render_frame = false
end

function ForceFieldHuskHealthExtension:is_alive()
	return not self.is_dead
end

function ForceFieldHuskHealthExtension:is_unkillable()
	return false
end

function ForceFieldHuskHealthExtension:is_invulnerable()
	return false
end

function ForceFieldHuskHealthExtension:current_health()
	local health, damage = _health_and_damage(self.game_session, self.game_object_id)

	return math.max(0, health - damage)
end

function ForceFieldHuskHealthExtension:current_health_percent()
	local health, damage = _health_and_damage(self.game_session, self.game_object_id)

	if health <= 0 then
		return 0
	end

	return math.max(0, 1 - damage / health)
end

function ForceFieldHuskHealthExtension:damage_taken()
	return GameSession.game_object_field(self.game_session, self.game_object_id, "damage")
end

function ForceFieldHuskHealthExtension:permanent_damage_taken()
	return GameSession.game_object_field(self.game_session, self.game_object_id, "damage")
end

function ForceFieldHuskHealthExtension:permanent_damage_taken_percent()
	local health, damage = _health_and_damage(self.game_session, self.game_object_id)

	if health <= 0 then
		return 0
	end

	return damage / health
end

function ForceFieldHuskHealthExtension:total_damage_taken()
	local health, damage = _health_and_damage(self.game_session, self.game_object_id)

	return math.min(health, damage)
end

function ForceFieldHuskHealthExtension:max_health()
	return GameSession.game_object_field(self.game_session, self.game_object_id, "health")
end

function ForceFieldHuskHealthExtension:add_damage()
	return
end

function ForceFieldHuskHealthExtension:add_heal()
	return
end

function ForceFieldHuskHealthExtension:health_depleted()
	return
end

function ForceFieldHuskHealthExtension:set_unkillable()
	return
end

function ForceFieldHuskHealthExtension:set_invulnerable()
	return
end

function ForceFieldHuskHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	self._last_damaging_unit = last_damaging_unit
	self._last_hit_zone_name = hit_zone_name
	self._last_hit_was_critical = last_hit_was_critical
	self._was_hit_by_critical_hit_this_render_frame = self._was_hit_by_critical_hit_this_render_frame or last_hit_was_critical
end

function ForceFieldHuskHealthExtension:last_damaging_unit()
	return self._last_damaging_unit
end

function ForceFieldHuskHealthExtension:last_hit_zone_name()
	return self._last_hit_zone_name
end

function ForceFieldHuskHealthExtension:last_hit_was_critical()
	return self._last_hit_was_critical
end

function ForceFieldHuskHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return self._was_hit_by_critical_hit_this_render_frame
end

function ForceFieldHuskHealthExtension:num_wounds()
	return 1
end

function ForceFieldHuskHealthExtension:max_wounds()
	return 1
end

implements(ForceFieldHuskHealthExtension, HealthExtensionInterface)

return ForceFieldHuskHealthExtension
