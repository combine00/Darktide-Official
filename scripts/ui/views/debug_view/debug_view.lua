local definition_path = "scripts/ui/views/debug_view/debug_view_definitions"
local DebugView = class("DebugView", "BaseView")

function DebugView:init(settings, context)
	local definitions = require(definition_path)

	DebugView.super.init(self, definitions, settings, context)

	self._pass_draw = false
end

return DebugView
