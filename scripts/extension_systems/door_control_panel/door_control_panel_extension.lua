local DoorControlPanelExtension = class("DoorControlPanelExtension")
local STATES = table.enum("active", "inactive")

function DoorControlPanelExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_server = extension_init_context.is_server
	self._unit = unit
	self._state = STATES.inactive
	self._door_unit = nil
	self._door_extension = nil
	self._animation_extension = nil
	self._light_active = nil
	self._interaction_interlude = 0
end

function DoorControlPanelExtension:setup_from_component(start_active, interaction_interlude)
	if start_active then
		self._state = STATES.active
	else
		self._state = STATES.inactive
	end

	self._interaction_interlude = interaction_interlude
end

function DoorControlPanelExtension:extensions_ready(world, unit)
	self._animation_extension = ScriptUnit.extension(unit, "animation_system")
end

function DoorControlPanelExtension:on_gameplay_post_init(unit)
	if not self._is_server then
		return
	end

	local interactee_extension = ScriptUnit.extension(unit, "interactee_system")

	if self:is_active() then
		interactee_extension:set_active(true)
		self:_play_anim("activate")
	else
		interactee_extension:set_active(false)
		self:_play_anim("deactivate")
	end

	self:_update_appearance()
end

function DoorControlPanelExtension:hot_join_sync(unit, sender)
	self:_sync_server_state(sender, self._state)

	local object_id = Managers.state.unit_spawner:game_object_id(unit)
	local door_level_index = Managers.state.unit_spawner:level_index(self._door_unit)
	local channel = Managers.state.game_session:peer_to_channel(sender)

	RPC.rpc_door_panel_register_door(channel, object_id, door_level_index)
end

function DoorControlPanelExtension:is_active()
	local is_active = self._state == STATES.active

	return is_active
end

function DoorControlPanelExtension:is_on_hold()
	if not self._door_extension then
		return false
	end

	return Managers.time:time("gameplay") < self._door_extension:get_last_state_change_time() + self._interaction_interlude
end

function DoorControlPanelExtension:set_active(active)
	if active and not self:is_active() then
		self:_activate()
	elseif not active and self:is_active() then
		self:_deactivate()
	end
end

function DoorControlPanelExtension:_activate()
	local unit = self._unit
	local interactee_extension = ScriptUnit.extension(unit, "interactee_system")

	interactee_extension:set_active(true)
	self:_play_anim("activate")

	self._state = STATES.active

	self:_sync_server_state(nil, self._state)
	self:_update_appearance()
end

function DoorControlPanelExtension:_deactivate()
	local unit = self._unit
	local interactee_extension = ScriptUnit.extension(unit, "interactee_system")

	interactee_extension:set_active(false)
	self:_play_anim("deactivate")

	self._state = STATES.inactive

	self:_sync_server_state(nil, self._state)
	self:_update_appearance()
end

function DoorControlPanelExtension:register_door(door_unit)
	self._door_unit = door_unit
	self._door_extension = ScriptUnit.extension(door_unit, "door_system")

	if self._is_server then
		local object_id = Managers.state.unit_spawner:game_object_id(self._unit)
		local door_level_index = Managers.state.unit_spawner:level_index(door_unit)
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_door_panel_register_door", object_id, door_level_index)
	end
end

function DoorControlPanelExtension:toggle_door_state(interactor_unit)
	local door_extension = self._door_extension

	if door_extension:can_open(interactor_unit) then
		door_extension:open("open", interactor_unit)
	elseif door_extension:can_close() then
		door_extension:close()
	end

	self:_play_anim("handle_push")
end

function DoorControlPanelExtension:_activate_lightbulbs(val)
	if self._light_active == val then
		return
	end

	if val then
		Unit.flow_event(self._unit, "lua_lightbulb_on")
	else
		Unit.flow_event(self._unit, "lua_lightbulb_off")
	end

	self._light_active = val
end

function DoorControlPanelExtension:_play_anim(anim_event)
	self._animation_extension:anim_event(anim_event)
end

function DoorControlPanelExtension:_update_appearance()
	local is_active = self._state == STATES.active

	if is_active then
		self:_activate_lightbulbs(true)
	else
		self:_activate_lightbulbs(false)
	end
end

function DoorControlPanelExtension:_sync_server_state(peer_id, state)
	local unit = self._unit
	local object_id = Managers.state.unit_spawner:game_object_id(unit)
	local state_lookup_id = NetworkLookup.door_control_panel_states[state]

	if peer_id then
		local channel = Managers.state.game_session:peer_to_channel(peer_id)

		RPC.rpc_sync_door_control_panel_state(channel, object_id, state_lookup_id)
	else
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_sync_door_control_panel_state", object_id, state_lookup_id)
	end
end

function DoorControlPanelExtension:rpc_sync_door_control_panel_state(new_state)
	self._state = new_state

	self:_update_appearance()
end

return DoorControlPanelExtension
