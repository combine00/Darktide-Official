local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local PlayerHubHealthExtension = class("PlayerHubHealthExtension")

function PlayerHubHealthExtension:init(extension_init_context, unit, extension_init_data, game_object_data)
	self._health = extension_init_data.health
	self._base_max_wounds = extension_init_data.wounds
end

function PlayerHubHealthExtension:pre_update(unit, dt, t)
	return
end

function PlayerHubHealthExtension:fixed_update(unit, dt, t)
	return
end

function PlayerHubHealthExtension:is_alive()
	return true
end

function PlayerHubHealthExtension:is_unkillable()
	return true
end

function PlayerHubHealthExtension:is_invulnerable()
	return true
end

function PlayerHubHealthExtension:current_health()
	return self._health
end

function PlayerHubHealthExtension:current_health_percent()
	return 1
end

function PlayerHubHealthExtension:damage_taken()
	return 0
end

function PlayerHubHealthExtension:permanent_damage_taken()
	return 0
end

function PlayerHubHealthExtension:permanent_damage_taken_percent()
	return 0
end

function PlayerHubHealthExtension:total_damage_taken()
	return 0
end

function PlayerHubHealthExtension:max_health(force_knocked_down_health)
	return self._health
end

function PlayerHubHealthExtension:add_damage(damage_amount, permanent_damage, hit_actor, damage_profile, attack_type, attack_direction, attacking_unit)
	local actual_damage_dealt = 0

	return actual_damage_dealt
end

function PlayerHubHealthExtension:add_heal(heal_amount, heal_type)
	local actual_heal_amount = 0

	return actual_heal_amount
end

function PlayerHubHealthExtension:reduce_permanent_damage(amount)
	return
end

function PlayerHubHealthExtension:on_player_unit_spawn(spawn_health_percentage)
	return
end

function PlayerHubHealthExtension:on_player_unit_respawn(respawn_health_percentage)
	return
end

function PlayerHubHealthExtension:remove_wounds(num_wounds)
	return
end

function PlayerHubHealthExtension:entered_knocked_down()
	return
end

function PlayerHubHealthExtension:exited_knocked_down()
	return
end

function PlayerHubHealthExtension:health_depleted()
	return false
end

function PlayerHubHealthExtension:should_die()
	return false
end

function PlayerHubHealthExtension:set_unkillable(should_be_unkillable)
	return
end

function PlayerHubHealthExtension:set_invulnerable(should_be_invulnerable)
	return
end

function PlayerHubHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	return
end

function PlayerHubHealthExtension:last_damaging_unit()
	return nil
end

function PlayerHubHealthExtension:last_hit_zone_name()
	return nil
end

function PlayerHubHealthExtension:last_hit_was_critical()
	return false
end

function PlayerHubHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return false
end

function PlayerHubHealthExtension:kill()
	return
end

function PlayerHubHealthExtension:num_wounds()
	return self._base_max_wounds
end

function PlayerHubHealthExtension:max_wounds()
	return self._base_max_wounds
end

function PlayerHubHealthExtension:persistent_data()
	return
end

function PlayerHubHealthExtension:apply_persistent_data(damage_percent, permanent_damage_percent)
	return
end

implements(PlayerHubHealthExtension, HealthExtensionInterface)

return PlayerHubHealthExtension
