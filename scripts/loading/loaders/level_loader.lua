local Havoc = require("scripts/utilities/havoc")
local CircumstanceTemplates = require("scripts/settings/circumstance/circumstance_templates")
local ItemPackage = require("scripts/foundation/managers/package/utilities/item_package")
local Loader = require("scripts/loading/loader")
local Missions = require("scripts/settings/mission/mission_templates")
local ThemePackage = require("scripts/foundation/managers/package/utilities/theme_package")
local MasterItems = require("scripts/backend/master_items")
local LevelLoader = class("LevelLoader")
local LOAD_STATES = table.enum("none", "level_load", "packages_load", "done")

function LevelLoader:init()
	self._level_name = nil
	self._theme_tag = nil
	self._packages_to_load = {}
	self._package_ids = {}
	self._level_package_id = nil
	self._level_loaded = false
	self._load_state = LOAD_STATES.none
end

function LevelLoader:destroy()
	self:cleanup()
end

function LevelLoader:start_loading(context)
	local mission_name = context.mission_name
	local level_editor_level = context.level_name
	local circumstance_name = context.circumstance_name
	local level_name = Missions[mission_name].level or level_editor_level
	self._level_name = level_name
	local circumstance_template = CircumstanceTemplates[circumstance_name]
	self._theme_tag = circumstance_template.theme_tag
	local item_definitions = MasterItems.get_cached()
	self._load_state = LOAD_STATES.level_load

	local function callback(_pkg_name)
		self:_level_load_done_callback(item_definitions)
	end

	self._reference_name = "LevelLoader (" .. tostring(mission_name) .. ")"
	self._level_package_id = Managers.package:load(level_name, self._reference_name, callback)
end

function LevelLoader:start_loading(context)
	local mission_name = context.mission_name
	local level_editor_level = context.level_name
	local circumstance_name = context.circumstance_name
	local havoc_data = context.havoc_data
	local level_name = Missions[mission_name].level or level_editor_level
	self._level_name = level_name

	if havoc_data then
		local parsed_data = Havoc.parse_data(havoc_data)
		self._theme_tag = parsed_data.theme
	else
		local circumstance_template = CircumstanceTemplates[circumstance_name]
		self._theme_tag = circumstance_template.theme_tag
	end

	local item_definitions = MasterItems.get_cached()
	self._load_state = LOAD_STATES.level_load

	local function callback(_pkg_name)
		self:_level_load_done_callback(item_definitions)
	end

	self._reference_name = "LevelLoader (" .. tostring(mission_name) .. ")"
	self._level_package_id = Managers.package:load(level_name, self._reference_name, callback)
end

function LevelLoader:_level_load_done_callback(item_definitions)
	self._level_loaded = true
	local level_name = self._level_name
	local theme_tag = self._theme_tag
	local item_packages_to_load = ItemPackage.level_resource_dependency_packages(item_definitions, level_name)
	local theme_packages_to_load = ThemePackage.level_resource_dependency_packages(level_name, theme_tag)

	if table.is_empty(item_packages_to_load) and table.is_empty(theme_packages_to_load) then
		self._load_state = LOAD_STATES.done
	else
		self._load_state = LOAD_STATES.packages_load

		local function callback(_pkg_name)
			self:_load_done_callback(_pkg_name)
		end

		local packages_to_load = self._packages_to_load

		for package_name, _ in pairs(item_packages_to_load) do
			packages_to_load[package_name] = false
		end

		for _, package_name in pairs(theme_packages_to_load) do
			packages_to_load[package_name] = false
		end

		local package_manager = Managers.package
		local package_ids = self._package_ids
		local reference_name = self._reference_name

		for package_name, _ in pairs(packages_to_load) do
			local id = package_manager:load(package_name, reference_name, callback)
			package_ids[id] = package_name
		end
	end
end

function LevelLoader:_load_done_callback(package_id)
	local package_name = self._package_ids[package_id]
	local packages_to_load = self._packages_to_load
	packages_to_load[package_name] = true
	local all_packages_finished_loading = true

	for name, loaded in pairs(packages_to_load) do
		if loaded == false then
			all_packages_finished_loading = false

			break
		end
	end

	if all_packages_finished_loading then
		self._load_state = LOAD_STATES.done
	end
end

function LevelLoader:is_loading_done()
	return self._load_state == LOAD_STATES.done
end

function LevelLoader:cleanup()
	Managers.world_level_despawn:flush()

	local package_manager = Managers.package
	local packages = self._package_ids

	for key, value in pairs(packages) do
		package_manager:release(key)
	end

	table.clear(self._package_ids)
	table.clear(self._packages_to_load)

	if self._level_package_id then
		package_manager:release(self._level_package_id)

		self._level_loaded = false
		self._level_package_id = nil
		self._level_name = nil
	end

	self._theme_tag = nil
	self._load_state = LOAD_STATES.none
end

function LevelLoader:dont_destroy()
	return false
end

implements(LevelLoader, Loader)

return LevelLoader
