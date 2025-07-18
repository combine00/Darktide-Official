local Loader = require("scripts/loading/loader")
local MissionIntroView = require("scripts/ui/views/mission_intro_view/mission_intro_view")
local Missions = require("scripts/settings/mission/mission_templates")
local Views = require("scripts/ui/views/views")
local ViewLoader = class("ViewLoader")

function ViewLoader:init()
	self._load_done = false
end

function ViewLoader:destroy()
	self:cleanup()
end

function ViewLoader:start_loading(context)
	local mission_name = context.mission_name
	local ui_manager = Managers.ui

	if ui_manager then
		local mission_settings = Missions[mission_name]
		local is_hub = mission_settings.is_hub
		local loading_views = {}
		local view_loading_count = 0

		for view_name, view_settings in pairs(Views) do
			local load_always = view_settings.load_always
			local load_in_hub = view_settings.load_in_hub
			local should_load = load_always or is_hub and load_in_hub

			if should_load then
				loading_views[view_name] = view_settings
				view_loading_count = view_loading_count + 1
			end
		end

		self._loading_views = loading_views
		self._view_loading_count = view_loading_count

		for view_name, view_settings in pairs(loading_views) do
			local function callback()
				self:_load_done_callback()
			end

			local dynamic_package = nil
			dynamic_package = self._get_dynamic_package_for_view(view_name, mission_name)

			ui_manager:load_view(view_name, "ViewLoader", callback, dynamic_package)
		end

		if view_loading_count == 0 then
			self._load_done = true

			ui_manager:release_packages()
		end
	else
		self._load_done = true
	end
end

function ViewLoader:is_loading_done()
	return self._load_done
end

function ViewLoader:cleanup()
	local ui_manager = Managers.ui

	if ui_manager then
		local loading_views = self._loading_views

		if loading_views then
			for view_name, view_settings in pairs(loading_views) do
				ui_manager:unload_view(view_name, "ViewLoader", nil)

				loading_views[view_name] = nil
			end

			self._loading_views = nil
		end
	end

	self._load_done = false
end

function ViewLoader:_load_done_callback()
	self._view_loading_count = self._view_loading_count - 1

	if self._view_loading_count == 0 then
		self._load_done = true
		local ui_manager = Managers.ui

		if ui_manager then
			ui_manager:release_packages()
		end
	end
end

function ViewLoader._get_dynamic_package_for_view(view_name, mission_name)
	local dynamic_package = nil

	if view_name == "mission_intro_view" then
		local _, level_package = MissionIntroView.select_target_intro_level(mission_name)
		dynamic_package = level_package
	end

	return dynamic_package
end

function ViewLoader:dont_destroy()
	return false
end

implements(ViewLoader, Loader)

return ViewLoader
