local Loader = require("scripts/loading/loader")
local Missions = require("scripts/settings/mission/mission_templates")
local HudLoader = class("HudLoader")

function HudLoader:init()
	self._load_done = false
end

function HudLoader:destroy()
	self:cleanup()
end

function HudLoader:start_loading(context)
	local ui_manager = Managers.ui
	local mission_name = context.mission_name

	if ui_manager then
		local mission_settings = Missions[mission_name]
		local hud_elements_to_load = mission_settings.hud_elements and require(mission_settings.hud_elements)

		if not hud_elements_to_load then
			hud_elements_to_load = {}
			local hud_elements = require("scripts/ui/hud/hud_elements_player")

			for i = 1, #hud_elements do
				local hud_element = hud_elements[i]
				hud_elements_to_load[#hud_elements_to_load + 1] = hud_element
			end

			local hud_spectator_elements = require("scripts/ui/hud/hud_elements_spectator")

			if hud_spectator_elements then
				for i = 1, #hud_spectator_elements do
					local spectator_element = hud_spectator_elements[i]
					local add = true

					for j = 1, #hud_elements_to_load do
						local hud_element = hud_elements_to_load[j]

						if hud_element.class_name == spectator_element.class_name then
							add = false

							break
						end
					end

					if add then
						hud_elements_to_load[#hud_elements_to_load + 1] = spectator_element
					end
				end
			end
		end

		local function callback()
			self:_load_done_callback()
		end

		ui_manager:load_hud_packages(hud_elements_to_load, callback)
	else
		self:_load_done_callback()
	end
end

function HudLoader:is_loading_done()
	return self._load_done
end

function HudLoader:cleanup()
	local ui_manager = Managers.ui

	if ui_manager and (ui_manager:hud_loaded() or ui_manager:hud_loading()) then
		ui_manager:unload_hud()
	end

	self._load_done = false
end

function HudLoader:_load_done_callback()
	self._load_done = true
end

function HudLoader:dont_destroy()
	return false
end

implements(HudLoader, Loader)

return HudLoader
