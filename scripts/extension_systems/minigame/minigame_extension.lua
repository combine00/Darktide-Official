local LevelProps = require("scripts/settings/level_prop/level_props")
local MinigameSettings = require("scripts/settings/minigame/minigame_settings")
local MinigameClasses = require("scripts/settings/minigame/minigame_classes")
local MinigameExtension = class("MinigameExtension")
MinigameExtension.UPDATE_DISABLED_BY_DEFAULT = true
local STATES = MinigameSettings.states

function MinigameExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_session, prop_settings_or_game_object_id)
	self._unit = unit
	self._is_server = extension_init_context.is_server
	self._seed = nil
	self._minigame_type = MinigameSettings.types.none
	self._minigame = nil
	self._current_state = STATES.none
	self._owner_system = extension_init_context.owner_system
	self._action_held = nil
	self._is_game_object = game_object_data_or_session ~= nil
	self._is_side_mission = false
	self._mutator_on_minigame_complete = nil
	self._minigame_angle_check = true
	local wwise_world = extension_init_context.wwise_world
	self._wwise_world = wwise_world

	if self._is_server and prop_settings_or_game_object_id then
		local prop_settings = prop_settings_or_game_object_id

		if prop_settings.is_side_mission_prop then
			self._is_side_mission = true
		end

		if prop_settings.minigame_angle_check ~= nil then
			self._minigame_angle_check = prop_settings.minigame_angle_check
		end

		if prop_settings.mutator_on_minigame_complete then
			self._mutator_on_minigame_complete = prop_settings.mutator_on_minigame_complete
		end
	elseif not self._is_server and prop_settings_or_game_object_id then
		local game_object_id = prop_settings_or_game_object_id
		local session = game_object_data_or_session
		local prop_id = GameSession.game_object_field(session, game_object_id, "prop_id")
		local prop_name = NetworkLookup.level_props_names[prop_id]
		local prop_settings = LevelProps[prop_name]

		if prop_settings.is_side_mission_prop then
			self._is_side_mission = true
		end

		if prop_settings.minigame_angle_check ~= nil then
			self._minigame_angle_check = prop_settings.minigame_angle_check
		end
	end
end

function MinigameExtension:hot_join_sync(unit, sender, channel)
	self._minigame:hot_join_sync(sender, channel)

	local unit_spawner_manager = Managers.state.unit_spawner
	local is_level_unit, unit_id = unit_spawner_manager:game_object_id_or_level_index(unit)
	local state_id = NetworkLookup.minigame_states[self._current_state]

	RPC.rpc_minigame_hot_join(channel, unit_id, is_level_unit, state_id)
end

function MinigameExtension:on_add_extension(seed)
	self._seed = seed
end

function MinigameExtension:setup_from_component(minigame_type)
	if minigame_type == "default" then
		minigame_type = self._owner_system:default_minigame_type()
	end

	self._minigame_type = minigame_type

	if not self._is_game_object then
		self:setup_minigame()
	end
end

function MinigameExtension:game_object_initialized(session, object_id)
	if self._is_game_object then
		self:setup_minigame()
	end
end

function MinigameExtension:on_game_object_created(game_object_id)
	self:setup_minigame()
end

function MinigameExtension:setup_minigame()
	local minigame_class = MinigameClasses[self._minigame_type]
	self._minigame = minigame_class:new(self._unit, self._is_server, self._seed, self._wwise_world)
end

function MinigameExtension:update(unit, dt, t)
	if self._current_state == STATES.active then
		self._minigame:update(dt, t)

		if self._is_server and self._minigame:should_exit() and self._minigame:is_completed() then
			self:completed()
		end
	end
end

function MinigameExtension:minigame_type()
	return self._minigame_type
end

function MinigameExtension:minigame(type)
	return self._minigame
end

function MinigameExtension:current_state()
	return self._current_state
end

function MinigameExtension:unit()
	return self._unit
end

function MinigameExtension:angle_check()
	return self._minigame_angle_check
end

function MinigameExtension:decode_interrupt()
	self._minigame:decode_interrupt()
end

function MinigameExtension:start(player)
	self:_set_state(STATES.active)
	self._minigame:start(player)

	if self._is_server then
		local unit_spawner_manager = Managers.state.unit_spawner
		local is_level_unit, unit_id = unit_spawner_manager:game_object_id_or_level_index(self._unit)

		Managers.state.game_session:send_rpc_clients_except("rpc_minigame_sync_start", player:channel_id(), unit_id, is_level_unit)
	end
end

function MinigameExtension:stop(player)
	self:_set_state(STATES.none)
	self._minigame:stop()

	if self._is_server then
		local unit_spawner_manager = Managers.state.unit_spawner
		local is_level_unit, unit_id = unit_spawner_manager:game_object_id_or_level_index(self._unit)

		if player then
			Managers.state.game_session:send_rpc_clients_except("rpc_minigame_sync_stop", player:channel_id(), unit_id, is_level_unit)
		else
			Managers.state.game_session:send_rpc_clients("rpc_minigame_sync_stop", unit_id, is_level_unit)
		end
	end

	self._action_held = nil
end

function MinigameExtension:is_completable()
	return self._current_state == STATES.active and self._minigame:is_completed()
end

function MinigameExtension:completed()
	self:_set_state(STATES.completed)
	self._minigame:complete()

	if self._is_server then
		local unit_spawner_manager = Managers.state.unit_spawner
		local is_level_unit, unit_id = unit_spawner_manager:game_object_id_or_level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_minigame_sync_completed", unit_id, is_level_unit)

		if self._is_side_mission then
			self:_update_side_mission_progression()
		end

		local mutator_on_minigame_complete = self._mutator_on_minigame_complete

		if mutator_on_minigame_complete then
			local mutator_manager = Managers.state.mutator
			local communication_hack_mutator = mutator_manager:mutator(mutator_on_minigame_complete)

			if communication_hack_mutator then
				local player_unit = nil
				local player_session_id = self._minigame:player_session_id()

				if player_session_id then
					local player = Managers.player:player_from_session_id(self._minigame._player_session_id)
					player_unit = player.player_unit
				end

				communication_hack_mutator:spawn_random_from_template(player_unit)
			end
		end
	end
end

function MinigameExtension:_update_side_mission_progression()
	local mission_objective_target_extension = ScriptUnit.extension(self._unit, "mission_objective_target_system")
	local objective_name = mission_objective_target_extension:objective_name()
	local mission_objective_system = Managers.state.extension:system("mission_objective_system")

	if mission_objective_system:is_current_active_objective(objective_name) then
		local synchronizer_unit = mission_objective_system:objective_synchronizer_unit(objective_name)
		local synchronizer_extension = ScriptUnit.extension(synchronizer_unit, "event_synchronizer_system")
		local increment_value = 1

		synchronizer_extension:add_progression(increment_value)
	end
end

function MinigameExtension:setup_game()
	self._minigame:setup_game()
end

function MinigameExtension:action(held, t)
	if self._action_held == nil then
		if not held then
			self._action_held = false
		else
			return false
		end
	end

	if self._action_held ~= held then
		self._action_held = held

		if self._is_server and self._current_state == STATES.active then
			if held then
				self._minigame:on_action_pressed(t)
			else
				self._minigame:on_action_released(t)
			end
		end

		return true
	end

	return false
end

function MinigameExtension:uses_action()
	if self._current_state == STATES.active then
		return self._minigame:uses_action()
	end

	return false
end

function MinigameExtension:uses_joystick()
	if self._current_state == STATES.active then
		return self._minigame:uses_joystick()
	end

	return false
end

function MinigameExtension:on_axis_set(t, x, y)
	if self._current_state == STATES.active then
		self._minigame:on_axis_set(t, x, y)
	end
end

function MinigameExtension:rpc_set_minigame_state(state)
	self:_set_state(state)
end

function MinigameExtension:_set_state(state)
	if self._current_state ~= state then
		if state == STATES.active then
			self._owner_system:enable_update_function(self.__class_name, "update", self._unit, self)
		else
			self._owner_system:disable_update_function(self.__class_name, "update", self._unit, self)
		end
	end

	self._current_state = state
end

return MinigameExtension
