require("scripts/extension_systems/servo_skull/servo_skull_extension")
require("scripts/extension_systems/servo_skull/servo_skull_activator_extension")

local ServoSkullSystem = class("ServoSkullSystem", "ExtensionSystemBase")
local CLIENT_RPCS = {
	"rpc_servo_skull_do_pulse_fx",
	"rpc_servo_skull_player_nearby",
	"rpc_servo_skull_activator_set_visibility",
	"rpc_servo_skull_set_scanning_active"
}

function ServoSkullSystem:init(context, system_init_data, ...)
	ServoSkullSystem.super.init(self, context, system_init_data, ...)

	self._network_event_delegate = context.network_event_delegate

	if not self._is_server then
		self._network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function ServoSkullSystem:on_gameplay_post_init(level)
	self:call_gameplay_post_init_on_extensions(level)
end

function ServoSkullSystem:hot_join_sync(sender, channel)
	local unit_to_extension_map = self._unit_to_extension_map

	for unit, extension in pairs(unit_to_extension_map) do
		if extension.hidden and extension:hidden() then
			local hidden = extension:hidden()
			local level_unit_id = Managers.state.unit_spawner:level_index(unit)

			RPC.rpc_servo_skull_activator_set_visibility(channel, level_unit_id, not hidden)
		end

		if extension.get_scanning_active and extension:get_scanning_active() then
			local game_object_id = Managers.state.unit_spawner:game_object_id(unit)

			RPC.rpc_servo_skull_set_scanning_active(channel, game_object_id, true)
		end
	end
end

function ServoSkullSystem:destroy()
	if not self._is_server then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end
end

function ServoSkullSystem:rpc_servo_skull_do_pulse_fx(channel_id, game_object_id)
	local is_level_unit = false
	local unit = Managers.state.unit_spawner:unit(game_object_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:do_pulse_fx()
end

function ServoSkullSystem:rpc_servo_skull_player_nearby(channel_id, game_object_id, player_nearby)
	local is_level_unit = false
	local unit = Managers.state.unit_spawner:unit(game_object_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:player_nearby(player_nearby)
end

function ServoSkullSystem:rpc_servo_skull_activator_set_visibility(channel_id, level_unit_id, value)
	local is_level_unit = true
	local unit = Managers.state.unit_spawner:unit(level_unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:set_visibility(value)
end

function ServoSkullSystem:rpc_servo_skull_set_scanning_active(channel_id, game_object_id, active)
	local is_level_unit = false
	local unit = Managers.state.unit_spawner:unit(game_object_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:set_scanning_active(active)
end

return ServoSkullSystem
