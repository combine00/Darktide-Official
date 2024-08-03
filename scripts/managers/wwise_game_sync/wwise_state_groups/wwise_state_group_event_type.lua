require("scripts/managers/wwise_game_sync/wwise_state_groups/wwise_state_group_base")

local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local WwiseStateGroupEventType = class("WwiseStateGroupEventType", "WwiseStateGroupBase")

function WwiseStateGroupEventType:init(wwise_world, wwise_state_group_name)
	WwiseStateGroupEventType.super.init(self, wwise_world, wwise_state_group_name)

	self._mission_objective_system = nil
end

function WwiseStateGroupEventType:on_gameplay_post_init(level)
	WwiseStateGroupEventType.super.on_gameplay_post_init(self, level)

	local mission_objective_system = Managers.state.extension:system("mission_objective_system")
	self._mission_objective_system = mission_objective_system
end

function WwiseStateGroupEventType:on_gameplay_shutdown()
	WwiseStateGroupEventType.super.on_gameplay_shutdown(self)

	self._mission_objective_system = nil
end

function WwiseStateGroupEventType:update(dt, t)
	WwiseStateGroupEventType.super.update(self, dt, t)

	local wwise_state = WwiseGameSyncSettings.default_group_state

	if self._mission_objective_system then
		local objective_event_type = self._mission_objective_system:objective_event_type()
		wwise_state = objective_event_type or wwise_state
	end

	self:_set_wwise_state(wwise_state)
end

return WwiseStateGroupEventType
