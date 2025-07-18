local Danger = require("scripts/utilities/danger")
local InputUtils = require("scripts/managers/input/input_utils")
local MissionTemplates = require("scripts/settings/mission/mission_templates")
local PartyConstants = require("scripts/settings/network/party_constants")
local MatchmakingNotificationHandler = class("MatchmakingNotificationHandler")
local INPUT_SERVICE_TYPE = "View"
local CANCEL_INPUT_ALIAS = "cancel_matchmaking"

local function _get_havoc_rank(mission_data)
	local min_havoc_rank = 1
	local max_havoc_rank = 100
	local havoc_rank_string = "havoc-rank-"

	for i = min_havoc_rank, max_havoc_rank do
		if mission_data.mission.flags[havoc_rank_string .. tostring(i)] then
			return i
		end
	end

	Log.error("Matchmaking Notification Handler", "Unable to get havoc rank")

	return nil
end

local function _get_quick_play_values(qp_code)
	local danger_settings = Danger.danger_by_qp_code(qp_code)
	local danger_string = danger_settings and danger_settings.display_name

	return Localize("loc_mission_board_quickplay_header"), danger_string and Localize(danger_string)
end

local function _mission_name(mission_data)
	local mission_key = mission_data.mission.map
	local mission_template = MissionTemplates[mission_key]
	local mission_name = mission_template and mission_template.mission_name

	return mission_name and Localize(mission_name)
end

local function _get_havoc_values(mission_data)
	local mission_name = _mission_name(mission_data)
	local havoc_rank = _get_havoc_rank(mission_data)
	local havoc_string = Localize("loc_havoc_order_info_overlay")

	if havoc_rank then
		havoc_string = string.format("%s %s", havoc_string, havoc_rank)
	end

	return mission_name, havoc_string
end

local function _get_mission_values(mission_data)
	local mission_name = _mission_name(mission_data)
	local danger_settings = Danger.danger_by_mission(mission_data.mission)
	local danger_string = danger_settings and danger_settings.display_name

	return mission_name, danger_string and Localize(danger_string)
end

local function _try_get_mission_text()
	local game_state = Managers.party_immaterium:party_game_state()
	local quickplay = game_state.params.qp == "true"
	local first_value, second_value = nil

	if quickplay then
		local mission_id = game_state.params.backend_mission_id
		first_value, second_value = _get_quick_play_values(mission_id)
	elseif game_state.params.mission_data then
		local mission_data_json = game_state.params.mission_data
		local mission_data = cjson.decode(mission_data_json)
		local is_havoc = mission_data.mission.category == "havoc"

		if is_havoc then
			first_value, second_value = _get_havoc_values(mission_data)
		else
			first_value, second_value = _get_mission_values(mission_data)
		end
	end

	if not first_value then
		first_value = second_value
		second_value = nil
	end

	if second_value then
		return string.format("%s - %s", first_value, second_value)
	end

	return first_value or ""
end

local function _cancel_matchmaking_text()
	local color_tint_text = true
	local input_text = InputUtils.input_text_for_current_input_device(INPUT_SERVICE_TYPE, CANCEL_INPUT_ALIAS, color_tint_text)
	local loc_context = {
		input = input_text
	}

	return Localize("loc_matchmaking_cancel_search", true, loc_context)
end

function MatchmakingNotificationHandler:init()
	self._state = nil

	Managers.event:register(self, "event_multiplayer_session_joined_host", "event_multiplayer_session_joined_host")
	Managers.event:register(self, "event_multiplayer_session_failed_to_boot", "event_multiplayer_session_failed_to_boot")
	Managers.event:register(self, "event_multiplayer_session_disconnected_from_host", "event_multiplayer_session_disconnected_from_host")
end

function MatchmakingNotificationHandler:destroy()
	Managers.event:unregister(self, "event_multiplayer_session_joined_host")
	Managers.event:unregister(self, "event_multiplayer_session_failed_to_boot")
	Managers.event:unregister(self, "event_multiplayer_session_disconnected_from_host")
	self:_remove_notification_if_active()
end

function MatchmakingNotificationHandler:state_changed(last_state, new_state)
	self._state = new_state

	Log.info("MatchmakingNotificationHandler", "State changed %s -> %s", last_state, new_state)

	if new_state == PartyConstants.State.none then
		self:_remove_notification_if_active()
	elseif new_state == PartyConstants.State.matchmaking then
		local mission_text = _try_get_mission_text()
		self._mission_text = mission_text
		self._matchmaking_time = 0
		self._matchmaking_time_update = 1
		self._canceled = false

		self:_create_or_update_notification({
			Localize("loc_matchmaking_looking_for_team"),
			mission_text or "???",
			_cancel_matchmaking_text()
		})
	elseif new_state == PartyConstants.State.matchmaking_acceptance_vote then
		self:_remove_notification_if_active()
	elseif new_state == PartyConstants.State.in_mission then
		if last_state == PartyConstants.State.matchmaking or last_state == PartyConstants.State.matchmaking_acceptance_vote then
			local mission_text = _try_get_mission_text()
			self._mission_text = mission_text

			self:_create_or_update_notification({
				Localize("loc_matchmaking_connecting_to_mission"),
				mission_text or "???",
				[3.0] = ""
			})
		else
			self:_remove_notification_if_active()
		end
	end
end

function MatchmakingNotificationHandler:event_multiplayer_session_joined_host()
	Log.info("MatchmakingNotificationHandler", "Joined host")
	self:_remove_notification_if_active()
end

function MatchmakingNotificationHandler:event_multiplayer_session_failed_to_boot()
	Log.info("MatchmakingNotificationHandler", "Failed to boot")
	self:_remove_notification_if_active()
end

function MatchmakingNotificationHandler:event_multiplayer_session_disconnected_from_host()
	Log.info("MatchmakingNotificationHandler", "Disconnected from host")
	self:_remove_notification_if_active()
end

function MatchmakingNotificationHandler:update(dt)
	if not self._notification_id then
		return
	end

	local state = self._state

	if state == PartyConstants.State.matchmaking then
		local t = self._matchmaking_time + dt
		self._matchmaking_time = t

		if self._matchmaking_time_update <= t then
			self._matchmaking_time_update = math.floor(t) + 1

			self:_create_or_update_notification({
				Localize("loc_matchmaking_looking_for_team"),
				self._mission_text or "???",
				_cancel_matchmaking_text()
			})
		end

		if not self._canceled then
			local input_service = Managers.ui:input_service()

			if input_service:get(CANCEL_INPUT_ALIAS) then
				Managers.party_immaterium:cancel_matchmaking()

				self._canceled = true
			end
		end
	end
end

function MatchmakingNotificationHandler:_create_or_update_notification(texts)
	if self._notification_id then
		Managers.event:trigger("event_update_notification_message", self._notification_id, texts)
	else
		Managers.event:trigger("event_add_notification_message", "matchmaking", {
			texts = texts
		}, function (id)
			self._notification_id = id
		end)
	end
end

function MatchmakingNotificationHandler:_remove_notification_if_active()
	if self._notification_id then
		Managers.event:trigger("event_remove_notification", self._notification_id)

		self._notification_id = nil
	end
end

return MatchmakingNotificationHandler
