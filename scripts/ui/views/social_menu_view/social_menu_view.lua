local TabbedMenuViewBase = require("scripts/ui/views/tabbed_menu_view_base")
local Definitions = require("scripts/ui/views/social_menu_view/social_menu_view_definitions")
local SocialMenuView = class("SocialMenuView", "TabbedMenuViewBase")

function SocialMenuView:init(settings, context)
	SocialMenuView.super.init(self, Definitions, settings, context)

	self._pass_draw = false
end

function SocialMenuView:on_enter()
	SocialMenuView.super.on_enter(self)
end

function SocialMenuView:on_exit()
	SocialMenuView.super.on_exit(self)
end

function SocialMenuView:cb_find_player_pressed()
	local active_view_instance = self._active_view_instance

	if active_view_instance and active_view_instance.handle_find_player then
		active_view_instance:handle_find_player()
	end
end

function SocialMenuView:_handle_input()
	return
end

return SocialMenuView
