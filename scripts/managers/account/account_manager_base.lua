local AccountManagerBase = class("AccountManagerBase")

function AccountManagerBase:init()
	return
end

function AccountManagerBase:destroy()
	return
end

function AccountManagerBase:reset()
	return
end

function AccountManagerBase:update(dt, t)
	return
end

function AccountManagerBase:wanted_transition()
	return
end

function AccountManagerBase:do_re_signin()
	return false
end

function AccountManagerBase:signin_profile()
	return
end

function AccountManagerBase:user_detached()
	return false
end

function AccountManagerBase:leaving_game()
	return false
end

function AccountManagerBase:user_id()
	return nil
end

function AccountManagerBase:platform_user_id()
	return nil
end

function AccountManagerBase:user_display_name()
	return "n/a"
end

function AccountManagerBase:is_guest()
	return false
end

function AccountManagerBase:signin_state()
	return ""
end

function AccountManagerBase:get_privilege()
	return
end

function AccountManagerBase:show_profile_picker()
	return
end

function AccountManagerBase:get_friends()
	return
end

function AccountManagerBase:friends_list_has_changes()
	return
end

function AccountManagerBase:refresh_communication_restrictions()
	return
end

function AccountManagerBase:is_muted()
	return false
end

function AccountManagerBase:is_blocked()
	return false
end

function AccountManagerBase:fetch_crossplay_restrictions()
	return
end

function AccountManagerBase:set_crossplay_restriction()
	return
end

function AccountManagerBase:has_crossplay_restriction()
	return false
end

function AccountManagerBase:verify_user_restriction()
	return
end

function AccountManagerBase:verify_user_restriction_batched()
	return
end

function AccountManagerBase:user_has_restriction()
	return false
end

function AccountManagerBase:user_restriction_verified()
	return true
end

function AccountManagerBase:verify_connection()
	return true
end

function AccountManagerBase:communication_restriction_iteration()
	return nil
end

function AccountManagerBase:return_to_title_screen()
	return
end

function AccountManagerBase:region_has_restriction(restriction)
	return false
end

return AccountManagerBase
