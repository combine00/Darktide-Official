local InvitesDummy = class("InvitesDummy")

function InvitesDummy:init()
	return
end

function InvitesDummy:update()
	return
end

function InvitesDummy:has_invite()
	return false
end

function InvitesDummy:get_invite()
	return nil
end

function InvitesDummy:send_invite()
	return
end

function InvitesDummy:reset()
	return
end

function InvitesDummy:destroy()
	return
end

function InvitesDummy:on_profile_signed_in()
	return
end

return InvitesDummy
