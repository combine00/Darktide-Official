require("scripts/foundation/managers/extension/extension_system_base")
require("scripts/extension_systems/health/force_field_health_extension")
require("scripts/extension_systems/health/force_field_husk_health_extension")
require("scripts/extension_systems/health/health_extension")
require("scripts/extension_systems/health/husk_health_extension")
require("scripts/extension_systems/health/player_hub_health_extension")
require("scripts/extension_systems/health/player_husk_health_extension")
require("scripts/extension_systems/health/player_unit_health_extension")
require("scripts/extension_systems/health/prop_health_extension")

local CLIENT_RPCS = {
	"rpc_kill_unit_health"
}
local HealthSystem = class("HealthSystem", "ExtensionSystemBase")

function HealthSystem:init(...)
	HealthSystem.super.init(self, ...)

	self._husk_health_extensions = {}

	if not self._is_server then
		self._network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function HealthSystem:destroy()
	if not self._is_server then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end

	table.clear(HEALTH_ALIVE)
end

function HealthSystem:register_extension_update(unit, extension_name, extension)
	HealthSystem.super.register_extension_update(self, unit, extension_name, extension)

	if extension_name == "HuskHealthExtension" then
		self._husk_health_extensions[unit] = extension
	end
end

function HealthSystem:on_add_extension(world, unit, extension_name, extension_init_data, ...)
	HEALTH_ALIVE[unit] = true

	return HealthSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data, ...)
end

function HealthSystem:on_remove_extension(unit, extension_name)
	if extension_name == "HuskHealthExtension" then
		self._husk_health_extensions[unit] = nil
	end

	HEALTH_ALIVE[unit] = nil

	HealthSystem.super.on_remove_extension(self, unit, extension_name)
end

function HealthSystem:update(context, dt, t, ...)
	HealthSystem.super.update(self, context, dt, t, ...)
	self:_update_is_dead_status_husk(dt, t)
end

local _game_object_field = GameSession.game_object_field
local IS_DEAD_FIELD_NAME = "is_dead"

function HealthSystem:_update_is_dead_status_husk(dt, t)
	for unit, extension in pairs(self._husk_health_extensions) do
		local game_session = extension.game_session
		local game_object_id = extension.game_object_id
		local is_dead = _game_object_field(game_session, game_object_id, IS_DEAD_FIELD_NAME)

		if extension.is_dead ~= is_dead then
			Managers.event:trigger("unit_died", unit)

			HEALTH_ALIVE[unit] = nil
			extension.is_dead = is_dead
		end
	end
end

function HealthSystem:rpc_kill_unit_health(channel_id, target_unit_id)
	local target_unit = Managers.state.unit_spawner:unit(target_unit_id, false)
	local extension = self._unit_to_extension_map[target_unit]

	extension:kill()
end

return HealthSystem
