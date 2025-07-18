local CircumstanceTemplates = require("scripts/settings/circumstance/circumstance_templates")

require("scripts/extension_systems/light_controller/light_controller_extension")

local LightControllerSystem = class("LightControllerSystem", "ExtensionSystemBase")
local CLIENT_RPCS = {
	"rpc_light_controller_hot_join",
	"rpc_light_controller_set_enabled",
	"rpc_light_controller_set_flicker_state"
}

function LightControllerSystem:init(extension_init_context, system_init_data, ...)
	LightControllerSystem.super.init(self, extension_init_context, system_init_data, ...)

	self._is_server = extension_init_context.is_server
	self._network_event_delegate = nil
	self._light_group_extensions = {}
	local themes = system_init_data.themes or {}

	self:setup_light_groups(themes)

	if not self._is_server and self._extension_init_context.network_event_delegate ~= nil then
		self._network_event_delegate = self._extension_init_context.network_event_delegate

		self._network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function LightControllerSystem:setup_light_groups(themes)
	self._mission_settings_light_groups = self:_extract_light_groups(themes) or {}
end

function LightControllerSystem:_extract_light_groups(themes)
	local Theme_light_groups = Theme.light_groups
	local light_groups = {}

	if themes then
		for _, theme in ipairs(themes) do
			local theme_groups = Theme_light_groups(theme)

			if theme_groups ~= nil then
				for group_name, setting in pairs(theme_groups) do
					light_groups[group_name] = setting ~= "OFF"
				end

				return light_groups
			end
		end
	end

	return light_groups
end

function LightControllerSystem:_fetch_settings(mission, circumstance_name)
	local original_settings = mission.light_groups_enabled or {}
	local circumstance_template = CircumstanceTemplates[circumstance_name]
	local mission_overrides = circumstance_template.mission_overrides
	local circumstance_settings = mission_overrides and mission_overrides.light_groups_enabled or nil

	return circumstance_settings or original_settings
end

function LightControllerSystem:destroy()
	if self._network_event_delegate ~= nil then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end
end

function LightControllerSystem:extensions_ready(world, unit, extension_name)
	self:_add_light_groups(unit)
	self:_connect_to_destructible_extension(unit)
end

function LightControllerSystem:on_remove_extension(unit, extension_name)
	self:_remove_light_groups(unit)
	LightControllerSystem.super.on_remove_extension(self, unit, extension_name)
end

function LightControllerSystem:on_gameplay_post_init(level)
	for light_group_name, is_enabled in pairs(self._mission_settings_light_groups) do
		self:_set_light_group_enabled(light_group_name, is_enabled, true)
	end
end

function LightControllerSystem:on_theme_changed(themes)
	if self._mission_settings_light_groups then
		for light_group_name, is_enabled in pairs(self._mission_settings_light_groups) do
			self:_set_light_group_enabled(light_group_name, false, true)
		end
	end

	self:setup_light_groups(themes)

	for light_group_name, is_enabled in pairs(self._mission_settings_light_groups) do
		self:_set_light_group_enabled(light_group_name, is_enabled, true)
	end
end

function LightControllerSystem:_add_light_groups(unit)
	local extension = self._unit_to_extension_map[unit]
	local light_group_extensions = self._light_group_extensions
	local light_groups = extension:light_groups()

	for i = 1, #light_groups do
		local light_group_name = light_groups[i]
		local extensions = light_group_extensions[light_group_name] or {}
		extensions[#extensions + 1] = extension
		light_group_extensions[light_group_name] = extensions
	end
end

function LightControllerSystem:_remove_light_groups(unit)
	local extension = self._unit_to_extension_map[unit]

	for _, extensions in pairs(self._light_group_extensions) do
		for i = #extensions, 1, -1 do
			if extensions[i] == extension then
				table.remove(extensions, i)

				break
			end
		end
	end
end

function LightControllerSystem:_set_light_group_enabled(light_group_name, is_enabled, is_deterministic)
	local extensions = self._light_group_extensions[light_group_name]

	if extensions ~= nil then
		for i = 1, #extensions do
			extensions[i]:set_enabled(is_enabled, is_deterministic)
		end
	end
end

function LightControllerSystem:_connect_to_destructible_extension(unit)
	local extension = self._unit_to_extension_map[unit]

	extension:connect_to_destructible_extension()
end

function LightControllerSystem:hot_join_sync(sender, channel_id)
	local unit_to_extension_map = self._unit_to_extension_map

	for unit, extension in pairs(unit_to_extension_map) do
		extension:hot_join_sync(sender, channel_id)
	end
end

function LightControllerSystem:rpc_light_controller_set_enabled(channel_id, level_unit_id, is_enabled)
	local unit = Managers.state.unit_spawner:unit(level_unit_id, true)
	local extension = self._unit_to_extension_map[unit]
	local deterministic_update = false

	extension:set_enabled(is_enabled, deterministic_update)
end

function LightControllerSystem:rpc_light_controller_set_flicker_state(channel_id, level_unit_id, flicker_enabled, configuration_id)
	local unit = Managers.state.unit_spawner:unit(level_unit_id, true)
	local extension = self._unit_to_extension_map[unit]
	local deterministic_update = false
	local configuration = NetworkLookup.light_controller_flicker_settings[configuration_id]

	extension:set_flicker_state(flicker_enabled, configuration, deterministic_update)
end

function LightControllerSystem:rpc_light_controller_hot_join(channel_id, level_unit_id, is_enabled, flicker_enabled, configuration_id)
	local unit = Managers.state.unit_spawner:unit(level_unit_id, true)
	local extension = self._unit_to_extension_map[unit]
	local configuration = NetworkLookup.light_controller_flicker_settings[configuration_id]

	extension:apply_hot_join_sync(is_enabled, flicker_enabled, configuration)
end

return LightControllerSystem
