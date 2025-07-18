require("scripts/managers/wwise_game_sync/wwise_state_groups/wwise_state_group_base")

local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local STATES = WwiseGameSyncSettings.state_groups.minion_aggro_intensity
local WwiseStateGroupMinionAggroIntensity = class("WwiseStateGroupMinionAggroIntensity", "WwiseStateGroupBase")

function WwiseStateGroupMinionAggroIntensity:init(wwise_world, wwise_state_group_name)
	WwiseStateGroupMinionAggroIntensity.super.init(self, wwise_world, wwise_state_group_name)

	self._state_settings = WwiseGameSyncSettings.minion_aggro_intensity_settings
end

function WwiseStateGroupMinionAggroIntensity:update(dt, t)
	WwiseStateGroupMinionAggroIntensity.super.update(self)

	local wwise_state = WwiseGameSyncSettings.default_group_state
	local player_unit = self._player_unit

	if player_unit and ALIVE[player_unit] then
		wwise_state = self:_wwise_state()
	end

	self:_set_wwise_state(wwise_state)
end

function WwiseStateGroupMinionAggroIntensity:set_followed_player_unit(player_unit)
	local music_parameter_extension = player_unit and ScriptUnit.has_extension(player_unit, "music_parameter_system")

	if music_parameter_extension then
		self._player_unit = player_unit
		self._music_parameter_extension = music_parameter_extension
	else
		self._player_unit = nil
		self._music_parameter_extension = nil
	end
end

function WwiseStateGroupMinionAggroIntensity:_wwise_state()
	local music_parameter_extension = self._music_parameter_extension
	local num_aggroed_minions = music_parameter_extension:num_aggroed_minions_near() or 0
	local state_settings = self._state_settings

	if state_settings.num_threshold_low < num_aggroed_minions and num_aggroed_minions < state_settings.num_threshold_medium then
		return STATES.low
	elseif num_aggroed_minions <= state_settings.num_threshold_low then
		return STATES.none
	elseif num_aggroed_minions < state_settings.num_threshold_high then
		return STATES.medium
	elseif state_settings.num_threshold_high <= num_aggroed_minions then
		return STATES.high
	end
end

return WwiseStateGroupMinionAggroIntensity
