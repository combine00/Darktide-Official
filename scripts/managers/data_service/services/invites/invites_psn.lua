local InvitesPSN = class("InvitesPSN")

function InvitesPSN:init()
	self._invite_code_promise = nil
	self._invite = nil
end

function InvitesPSN:update()
	if self._invite_code_promise then
		return
	end

	local session_id = NpPlayerSession.check_for_invite()

	if session_id then
		self._invite_code_promise = Managers.account:get_immaterium_invite_code_from_psn_session(session_id)

		self._invite_code_promise:next(function (invite_code)
			self._invite = {
				code = invite_code,
				recipient_account_id = Managers.account:platform_user_id()
			}
			self._invite_code_promise = nil
		end):catch(function (err)
			self._invite = nil
			self._invite_code_promise = nil
		end)
	end
end

function InvitesPSN:has_invite()
	return self._invite ~= nil
end

function InvitesPSN:get_invite()
	if self._invite then
		local code = self._invite.code
		self._invite = nil

		return code
	end

	return nil
end

function InvitesPSN:send_invite(invitee_psn_account_id, invite_code)
	Managers.account:send_psn_session_invite(invitee_psn_account_id)
end

function InvitesPSN:reset()
	if self._invite_code_promise then
		self._invite_code_promise:cancel()

		self._invite_code_promise = nil
	end

	self._invite = nil
end

function InvitesPSN:on_profile_signed_in(account_id)
	if self._invite and self._invite.recipient_account_id ~= account_id then
		self._invite = nil
	end
end

function InvitesPSN:destroy()
	return
end

return InvitesPSN
