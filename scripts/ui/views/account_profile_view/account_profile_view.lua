local TabbedMenuViewBase = require("scripts/ui/views/tabbed_menu_view_base")
local Definitions = require("scripts/ui/views/account_profile_view/account_profile_view_definitions")
local AccountProfileView = class("AccountProfileView", "TabbedMenuViewBase")

function AccountProfileView:init(settings, context)
	AccountProfileView.super.init(self, Definitions, settings, context)

	self._pass_draw = false
end

return AccountProfileView
