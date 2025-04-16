local CompanionOutlineExtension = class("CompanionOutlineExtension")
local Missions = require("scripts/settings/mission/mission_templates")

function CompanionOutlineExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id, something)
	local is_server = extension_init_context.is_server
	self._is_server = is_server
	local mission_name = Managers.state.mission:mission_name()
	local mission_settings = Missions[mission_name]
	self._is_hub = mission_settings.is_hub

	if not is_server then
		self._game_session_id = game_object_data_or_game_session
		self._game_object_id = nil_or_game_object_id
	end

	self._world = extension_init_context.world
	self._unit = unit
	self._owner_player = extension_init_data.owner_player
end

function CompanionOutlineExtension:game_object_initialized(session, object_id)
	self._game_session_id = session
	self._game_object_id = object_id
end

function CompanionOutlineExtension:extensions_ready(world, unit)
	if self._is_hub then
		return
	end

	local local_player = Managers.player:local_player(1)
	local is_local_player = local_player == self._owner_player
	local outline_name = is_local_player and "owned_companion" or "allied_companion"
	local outline_id = NetworkLookup.outline_types[outline_name]
	local outline_system = Managers.state.extension:system("outline_system")

	outline_system:add_outline(unit, outline_name)
end

function CompanionOutlineExtension:hot_join_sync(unit, sender, channel_id)
	return
end

function CompanionOutlineExtension:destroy()
	return
end

function CompanionOutlineExtension:update(unit, dt, t)
	return
end

return CompanionOutlineExtension
