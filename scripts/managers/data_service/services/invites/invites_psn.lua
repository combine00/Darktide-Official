local InvitesPSN = class("InvitesPSN")

function InvitesPSN:init()
	self._has_invite = false
	self._invites = {}
end

function InvitesPSN:update()
	return
end

function InvitesPSN:has_invite()
	return false
end

function InvitesPSN:get_invite()
	return nil
end

function InvitesPSN:send_invite()
	return
end

function InvitesPSN:reset()
	table.clear(self._invites)

	self._has_invite = false
end

function InvitesPSN:on_profile_signed_in(account_id)
	return
end

function InvitesPSN:destroy()
	return
end

return InvitesPSN
