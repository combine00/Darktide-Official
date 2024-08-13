local CircumstanceTemplates = require("scripts/settings/circumstance/circumstance_templates")
local CircumstanceManager = class("CircumstanceManager")
CircumstanceManager.DEBUG_TAG = "Circumstance"

function CircumstanceManager:init(circumstance_name)
	local template = CircumstanceTemplates[circumstance_name]
	self._circumstance_name = circumstance_name
end

function CircumstanceManager:destroy()
	return
end

function CircumstanceManager:active_theme_tag()
	return CircumstanceTemplates[self._circumstance_name].theme_tag
end

function CircumstanceManager:circumstance_name()
	return self._circumstance_name
end

function CircumstanceManager:template()
	return CircumstanceTemplates[self._circumstance_name]
end

return CircumstanceManager
