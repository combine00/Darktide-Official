local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local PlayerUnitOutlineExtension = class("PlayerUnitOutlineExtension")
local IGNORED_DISABLED_OUTLINE_STATES = {
	grabbed = true,
	catapulted = true,
	consumed = true
}
local UPDATE_WAITING_PERIOD = 0.5

function PlayerUnitOutlineExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id)
	local is_server = extension_init_context.is_server
	self._is_server = is_server
	self._is_local_human = extension_init_data.is_local_unit and extension_init_data.is_human_controlled

	if not is_server then
		self._game_session_id = game_object_data_or_game_session
		self._game_object_id = nil_or_game_object_id
	end

	self._world = extension_init_context.world
	self._unit = unit
	self._next_update_t = 0
	self._player_outlines_enabled = nil
end

function PlayerUnitOutlineExtension:game_object_initialized(session, object_id)
	self._game_session_id = session
	self._game_object_id = object_id
end

function PlayerUnitOutlineExtension:extensions_ready(world, unit)
	local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
	local outline_system = Managers.state.extension:system("outline_system")
	local smart_tag_system = Managers.state.extension:system("smart_tag_system")
	self._character_state_component = unit_data_extension:read_component("character_state")
	self._outline_system = outline_system
	self._smart_tag_system = smart_tag_system
	local save_data = Managers.save:account_data()
	local interface_settings = save_data.interface_settings
	local player_outlines_enabled = interface_settings.player_outlines and not Managers.state.game_mode:disable_hologram()

	if player_outlines_enabled and not self._is_local_human then
		local new_outline = "default_both_skeleton"

		self._outline_system:add_outline(unit, new_outline)
	end

	self._player_outlines_enabled = player_outlines_enabled
end

function PlayerUnitOutlineExtension:destroy()
	return
end

return PlayerUnitOutlineExtension
