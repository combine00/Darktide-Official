local HudElementNameplatesSettings = require("scripts/ui/hud/elements/nameplates/hud_element_nameplates_settings")
local HudElementNameplates = class("HudElementNameplates")
local Missions = require("scripts/settings/mission/mission_templates")
local PlayerCompositions = require("scripts/utilities/players/player_compositions")

function HudElementNameplates:init(parent, draw_layer, start_scale)
	self._parent = parent
	self._nameplate_units = {}
	self._companion_nameplates = {}
	self._scan_delay = HudElementNameplatesSettings.scan_delay
	self._scan_delay_duration = 0
	local mission_name = Managers.state.mission:mission_name()
	local mission_settings = Missions[mission_name]
	self._is_mission_hub = mission_settings.is_hub
	local save_manager = Managers.save

	if save_manager then
		local save_data = save_manager:account_data()
		local interface_settings = save_data.interface_settings
		local my_title_in_hub = interface_settings.my_title_in_hub
		self._my_title_in_hub = my_title_in_hub
	end

	Managers.event:register(self, "event_titles_my_title_in_hub_setting_changed", "_cb_event_titles_my_title_in_hub_setting_changed")
end

function HudElementNameplates:_cb_event_titles_my_title_in_hub_setting_changed(value)
	self._my_title_in_hub = value
	self._reset_nameplates = true
end

function HudElementNameplates:update(dt, t)
	if self._scan_delay_duration > 0 then
		self._scan_delay_duration = self._scan_delay_duration - dt
	else
		self:_nameplate_extension_scan()
		self:_companion_nameplate_extension_scan()

		self._scan_delay_duration = self._scan_delay
	end
end

function HudElementNameplates:_nameplate_extension_scan()
	local parent = self._parent
	local my_player = parent:player()
	local marker_type = nil
	local event_manager = Managers.event
	local nameplate_units = self._nameplate_units
	local extensions = self:_player_extensions(my_player)
	local has_disable_nameplates_buff = false

	if extensions then
		local buff_extension = extensions.buff
		has_disable_nameplates_buff = buff_extension and buff_extension:has_keyword("hud_nameplates_disabled")
	end

	local player_manager = Managers.player
	local players = player_manager:players()
	local ALIVE = ALIVE

	for _, player in pairs(players) do
		repeat
			local unit = player.player_unit

			if self._reset_nameplates and nameplate_units[unit] then
				nameplate_units[unit].synced = false
			end

			if (not self._is_mission_hub or not self._my_title_in_hub) and player == my_player then
				if nameplate_units[unit] then
					nameplate_units[unit].synced = false
				end
			else
				if self._is_mission_hub then
					local peer_id = player:peer_id()
					local is_player_party_member = player:is_human_controlled() and PlayerCompositions.party_member_by_peer_id(peer_id)

					if is_player_party_member then
						marker_type = "nameplate_party_hud"
					else
						marker_type = "nameplate"
					end
				else
					marker_type = "nameplate_party"
				end

				local active = ALIVE[unit]

				if active and not has_disable_nameplates_buff then
					if nameplate_units[unit] and has_disable_nameplates_buff then
						nameplate_units[unit].synced = false
					elseif not nameplate_units[unit] then
						nameplate_units[unit] = {
							synced = true
						}
						local marker_callback = callback(self, "_on_nameplate_marker_spawned", unit)

						event_manager:trigger("add_world_marker_unit", marker_type, unit, marker_callback, player)
					elseif nameplate_units[unit] == marker_type then
						nameplate_units[unit].synced = true
					end
				elseif nameplate_units[unit] and has_disable_nameplates_buff then
					nameplate_units[unit].synced = false
				end
			end
		until true
	end

	if self._reset_nameplates then
		self._reset_nameplates = nil
	end

	for unit, data in pairs(nameplate_units) do
		if not data.synced then
			local marker_id = data.marker_id

			if marker_id then
				event_manager:trigger("remove_world_marker", marker_id)

				nameplate_units[unit] = nil
			end
		end
	end
end

function HudElementNameplates:_companion_nameplate_extension_scan()
	local parent = self._parent
	local local_player = parent:player()
	local marker_type = self._is_mission_hub and "nameplate_companion_hub" or "nameplate_companion"
	local player_manager = Managers.player
	local players = player_manager:players()
	local ALIVE = ALIVE

	for _, player in pairs(players) do
		local player_unit = player.player_unit

		if ALIVE[player_unit] then
			self:_handle_player_companion_nameplate(player, marker_type)
		end
	end

	local companion_nameplates = self._companion_nameplates

	for companion_unit, marker_data in pairs(companion_nameplates) do
		if not marker_data.synced then
			self:_remove_companion_nameplate(companion_unit)

			companion_nameplates[companion_unit] = nil
		end
	end
end

function HudElementNameplates:_handle_player_companion_nameplate(player, marker_type)
	local player_owned_units = player.owned_units

	for _, owned_unit in pairs(player_owned_units) do
		local unit_data = ScriptUnit.has_extension(owned_unit, "unit_data_system")
		local breed = unit_data and unit_data:breed()
		local is_companion = breed and breed.tags and breed.tags.companion

		if is_companion then
			self:_handle_companion_namplate(player, owned_unit, marker_type)
		end
	end
end

function HudElementNameplates:_handle_companion_namplate(player, companion_unit, marker_type)
	local companion_nameplates = self._companion_nameplates
	local existing_companion_maker = companion_nameplates[companion_unit]

	if ALIVE[companion_unit] and not existing_companion_maker then
		self:_add_companion_nameplate(marker_type, companion_unit, player)
	elseif not ALIVE[companion_unit] and existing_companion_maker then
		self:_remove_companion_nameplate(companion_unit)
	end
end

function HudElementNameplates:_player_extensions(player)
	local player_unit = player.player_unit

	if Unit.alive(player_unit) then
		if not self._extensions then
			self._extensions = self._parent:get_all_player_extensions(player, {})
		end
	elseif self._extensions then
		self._extensions = nil
	end

	return self._extensions
end

function HudElementNameplates:_on_nameplate_marker_spawned(unit, id)
	self._nameplate_units[unit].marker_id = id
end

function HudElementNameplates:_on_companion_nameplate_marker_spawned(unit, id)
	self._companion_nameplates[unit].marker_id = id
end

function HudElementNameplates:_add_companion_nameplate(marker_type, companion_unit, player)
	local event_manager = Managers.event
	local companion_nameplates = self._companion_nameplates
	companion_nameplates[companion_unit] = {
		synced = true
	}
	local marker_callback = callback(self, "_on_companion_nameplate_marker_spawned", companion_unit)

	event_manager:trigger("add_world_marker_unit", marker_type, companion_unit, marker_callback, player)
end

function HudElementNameplates:_remove_companion_nameplate(companion_unit)
	local event_manager = Managers.event
	local companion_nameplates = self._companion_nameplates
	local companion_marker_id = companion_nameplates[companion_unit] and companion_nameplates[companion_unit].marker_id

	if companion_marker_id then
		companion_nameplates[companion_unit].synced = false

		event_manager:trigger("remove_world_marker", companion_marker_id)
	end
end

function HudElementNameplates:destroy()
	local event_manager = Managers.event
	local nameplate_units = self._nameplate_units

	for _, data in pairs(nameplate_units) do
		local marker_id = data.marker_id

		if marker_id then
			event_manager:trigger("remove_world_marker", marker_id)
		end
	end

	local companion_nameplates = self._companion_nameplates

	for companion_unit, _ in pairs(companion_nameplates) do
		self:_remove_companion_nameplate(companion_unit)
	end

	self._nameplate_units = nil
	self._companion_nameplate = nil

	Managers.event:unregister(self, "event_titles_my_title_in_hub_setting_changed")
end

return HudElementNameplates
