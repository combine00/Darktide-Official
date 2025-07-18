local InputUtils = require("scripts/managers/input/input_utils")
local PartyImmateriumInviteNotificationHandler = class("PartyImmateriumInviteNotificationHandler")
local INPUT_SERVICE_TYPE = "View"
local ACCEPT_INPUT_ALIAS = "accept_invite_notification"
local ACCEPT_INPUT_HOLD_TIME = 1
local AUTO_DECLINE_TIME = 10

function PartyImmateriumInviteNotificationHandler:init()
	self._active_invite = nil
	self._invite_queue = {}
end

function PartyImmateriumInviteNotificationHandler:destroy()
	local active_invite = self._active_invite

	if active_invite then
		Managers.event:trigger("event_remove_notification", active_invite.notification_id)

		if Managers.ui then
			Managers.ui:stop_tracking_input_hold(active_invite.input_id)
		end

		self._active_invite = nil
	end

	self._invite_queue = nil
end

function PartyImmateriumInviteNotificationHandler:add_invite(party_id, invite_token, inviter_name)
	self._invite_queue[#self._invite_queue + 1] = {
		party_id = party_id,
		invite_token = invite_token,
		inviter_name = inviter_name
	}

	if not self._active_invite then
		self:_activate_next_invite()
	end
end

function PartyImmateriumInviteNotificationHandler:clear_invite_by_party_id(party_id)
	local queue = self._invite_queue

	for i = #queue, 1, -1 do
		local invite = queue[i]

		if invite.party_id == party_id then
			table.remove(queue, i)
		end
	end

	local active_invite = self._active_invite

	if active_invite and active_invite.party_id == party_id then
		self:_clear_active_invite()
	end
end

function PartyImmateriumInviteNotificationHandler:update(dt, t)
	local active_invite = self._active_invite

	if not active_invite then
		return
	end

	if active_invite.auto_decline_at <= t then
		local answer_code = nil

		Managers.grpc:cancel_invite_to_party(active_invite.party_id, active_invite.invite_token, answer_code):catch(function (error)
			Log.warning("PartyImmateriumInviteNotificationHandler", "Could not cancel invite, error: %s", table.tostring(error, 3))
		end)
		self:_clear_active_invite()
	end
end

function PartyImmateriumInviteNotificationHandler:_clear_active_invite()
	Managers.event:trigger("event_remove_notification", self._active_invite.notification_id)
	Managers.ui:stop_tracking_input_hold(self._active_invite.input_id)

	self._active_invite = nil

	if #self._invite_queue > 0 then
		self:_activate_next_invite()
	end
end

function PartyImmateriumInviteNotificationHandler:_activate_next_invite()
	local invite = table.remove(self._invite_queue, 1)
	self._active_invite = invite
	local description = nil
	local inviter_name = invite.inviter_name

	if inviter_name and inviter_name ~= "" then
		description = Localize("loc_social_party_invite_received_description", true, {
			player_name = inviter_name
		})
	else
		description = Localize("loc_social_party_invite_received_description_no_player_name")
	end

	local color_tint_text = true
	local input_text = InputUtils.input_text_for_current_input_device(INPUT_SERVICE_TYPE, ACCEPT_INPUT_ALIAS, color_tint_text)
	local texts = {
		Localize("loc_social_party_invite_received_header"),
		description,
		Localize("loc_social_party_invite_accept", true, {
			input = input_text
		})
	}

	Managers.event:trigger("event_add_notification_message", "matchmaking", {
		texts = texts
	}, function (notification_id)
		invite.notification_id = notification_id
	end)

	invite.auto_decline_at = Managers.time:time("main") + AUTO_DECLINE_TIME
	invite.input_id = Managers.ui:start_tracking_input_hold("accept_invite_notification", ACCEPT_INPUT_HOLD_TIME, callback(self, "_cb_invite_accepted"))
end

function PartyImmateriumInviteNotificationHandler:_cb_invite_accepted()
	local active_invite = self._active_invite

	if active_invite then
		Managers.party_immaterium:join_party({
			party_id = active_invite.party_id,
			invite_token = active_invite.invite_token
		})
		self:_clear_active_invite()
	end
end

return PartyImmateriumInviteNotificationHandler
