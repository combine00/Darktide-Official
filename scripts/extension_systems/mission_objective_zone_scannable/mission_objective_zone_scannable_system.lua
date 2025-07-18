require("scripts/extension_systems/mission_objective_zone_scannable/mission_objective_zone_scannable_extension")

local MissionObjectiveZoneScannableSystem = class("MissionObjectiveZoneScannableSystem", "ExtensionSystemBase")
local CLIENT_RPCS = {
	"rpc_mission_objective_zone_scannable_hot_join_sync",
	"rpc_mission_objective_zone_scannable_set_active"
}

function MissionObjectiveZoneScannableSystem:init(context, system_init_data, ...)
	MissionObjectiveZoneScannableSystem.super.init(self, context, system_init_data, ...)

	local network_event_delegate = context.network_event_delegate
	self._network_event_delegate = network_event_delegate

	if not self._is_server then
		network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function MissionObjectiveZoneScannableSystem:on_gameplay_post_init(level)
	self:call_gameplay_post_init_on_extensions(level)
end

function MissionObjectiveZoneScannableSystem:destroy()
	if not self._is_server then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end

	MissionObjectiveZoneScannableSystem.super.destroy(self)
end

function MissionObjectiveZoneScannableSystem:rpc_mission_objective_zone_scannable_hot_join_sync(channel_id, level_unit_id, active)
	local is_level_unit = true
	local unit = Managers.state.unit_spawner:unit(level_unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	if active then
		extension:set_active(active)
	end
end

function MissionObjectiveZoneScannableSystem:rpc_mission_objective_zone_scannable_set_active(channel_id, level_unit_id, active)
	local is_level_unit = true
	local unit = Managers.state.unit_spawner:unit(level_unit_id, is_level_unit)
	local extension = self._unit_to_extension_map[unit]

	extension:set_active(active)
end

return MissionObjectiveZoneScannableSystem
