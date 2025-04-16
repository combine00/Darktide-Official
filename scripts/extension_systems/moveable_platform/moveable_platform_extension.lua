local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local BreedSettings = require("scripts/settings/breed/breed_settings")
local PlayerMovement = require("scripts/utilities/player_movement")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local MoveablePlatformExtension = class("MoveablePlatformExtension")
local MINION_BREED_TYPE = BreedSettings.types.minion
local MOVEABLE_PLATFORM_DIRECTION = table.enum("none", "forward", "backward")
local OPEN_WALL_FILTER = "filter_platform_wall"

function MoveablePlatformExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_server = extension_init_context.is_server
	self._owner_system = extension_init_context.owner_system
	self._network_story_manager = Managers.state.network_story
	self._unit = unit
	self._level = Unit.level(unit)
	local extension_manager = Managers.state.extension
	local broadphase_system = extension_manager:system("broadphase_system")
	self._broadphase = broadphase_system.broadphase
	self._side_system = extension_manager:system("side_system")
	self._story_name = nil
	self._story_changed = false
	self._story_direction = MOVEABLE_PLATFORM_DIRECTION.none
	self._story_speed_forward = 1
	self._story_speed_backward = 1
	self._box = nil
	self._walls = {}
	self._player_side = nil
	self._require_all_players_onboard = false
	self._all_players_inside = false
	self._wall_collision_enabled = true
	self._passenger_units = {}
	self._overlap_result = {}
	self._interactables = {}
	self._units_locked = false
	self._teleport_node_index = 1
	self._teleport_nodes = {}
	self._block_text = nil
	local initial_position = Unit.local_position(unit, 1)
	self._previous_update_position = Vector3Box(initial_position)
	self._movement_this_render_frame = Vector3.zero()
	self._movement_since_last_fixed_update = Vector3.zero()
	self._last_fixed_frame_position = Vector3Box(Vector3.zero())
	self._end_sound_time = 0
	self._play_end_sound = false
	self._unit_spawner = Managers.state.unit_spawner
	self._chunk_lod_manager = Managers.state.chunk_lod
	self._locked_chunk_lod = false

	self:_update_broadphase()

	local node_count = 0

	while true do
		local node_name = string.format("teleport_location_%02d", node_count + 1)

		if Unit.has_node(unit, node_name) then
			node_count = node_count + 1
			self._teleport_nodes[node_count] = Unit.node(unit, node_name)
		else
			break
		end
	end

	self._teleport_node_count = node_count
	local interactable_count = 1
	local interactable_prefix = "c_interactable_"
	local interactable_name = interactable_prefix .. tostring(interactable_count)
	local interactable_id = Unit.find_actor(unit, interactable_name)

	if interactable_id then
		while interactable_id ~= nil do
			self._interactables[interactable_count] = {
				name = interactable_name,
				node_id = interactable_id
			}
			interactable_count = interactable_count + 1
			interactable_name = interactable_prefix .. tostring(interactable_count)
			interactable_id = Unit.find_actor(unit, interactable_name)
		end
	end

	local wall_count = 1
	local wall_prefix = "c_wall_"
	local wall_actor = Unit.actor(unit, wall_prefix .. tostring(wall_count))

	while wall_actor ~= nil do
		self._walls[wall_count] = wall_actor
		wall_count = wall_count + 1
		wall_actor = Unit.actor(unit, wall_prefix .. tostring(wall_count))
	end

	local overlap_manager = Managers.state.player_overlap_manager

	for _, wall in pairs(self._walls) do
		self:_enable_wall_collision(wall, false)

		self._overlap_result[wall] = overlap_manager:add_listening_actor(wall)
	end

	self._wall_enabled = false
	self._box = Unit.actor(unit, "c_box_center")

	self:_enable_wall_collision(self._box, false)

	self._overlap_result[self._box] = overlap_manager:add_listening_actor(self._box)
end

function MoveablePlatformExtension:setup_from_component(story_name, story_loop_mode, story_start_immediately, story_speed_forward, story_speed_backward, player_side, wall_collision_enabled, wall_collision_filter, require_all_players_onboard, end_sound_time, interactable_story_actions, interactable_hud_descriptions, nav_handling_enabled, stop_position)
	local unit = self._unit
	local level = self._level
	local network_story_manager = self._network_story_manager
	self._story_name = story_name
	self._story_loop_mode = story_loop_mode

	network_story_manager:register_story(story_name, level)
	self:play_story()

	self._story_speed_forward = story_speed_forward
	self._story_speed_backward = story_speed_backward
	self._player_side = player_side
	self._wall_collision_enabled = wall_collision_enabled
	self._wall_collision_filter = wall_collision_filter
	self._require_all_players_onboard = require_all_players_onboard
	self._end_sound_time = end_sound_time
	self._nav_handling_enabled = nav_handling_enabled
	self._stop_position = stop_position

	if nav_handling_enabled then
		self:_setup_nav_gates(unit)
	end

	local interactables = self._interactables

	for i = 1, #interactables do
		local interactable = interactables[i]

		if interactable_story_actions[i] then
			interactable.action = interactable_story_actions[i]
		else
			interactable.action = "none"
		end

		if interactable_hud_descriptions[i] then
			interactable.hud_description = interactable_hud_descriptions[i]
		end
	end

	if self._is_server and story_start_immediately then
		self:_set_direction(MOVEABLE_PLATFORM_DIRECTION.forward)
	end
end

function MoveablePlatformExtension:play_story(speed)
	speed = speed or 0

	self._network_story_manager:play_story(self._story_name, self._level, speed, self._story_loop_mode)
end

function MoveablePlatformExtension:get_interactables()
	return self._interactables
end

function MoveablePlatformExtension:can_move()
	local all_on_board = not self._require_all_players_onboard or self._require_all_players_onboard and self._all_players_inside
	local can_activate_wall_collision_enabled = not self._wall_collision_enabled or self._wall_collision_enabled and not self:_passengers_inside_walls()

	if not all_on_board or not can_activate_wall_collision_enabled then
		self:_set_block_text("loc_action_interaction_inactive_platform_missing_players")

		return false
	end

	local hostiles_onboard = self:_check_hostile_onboard()

	if hostiles_onboard and self._require_all_players_onboard then
		self:_set_block_text("loc_action_interaction_inactive_platform_hostiles_onboard")

		return false
	end

	self:_set_block_text(nil)

	return true
end

function MoveablePlatformExtension:_set_block_text(text)
	self._block_text = text
end

function MoveablePlatformExtension:block_text()
	return self._block_text
end

function MoveablePlatformExtension:_set_direction(direction)
	local story_state = self._network_story_manager:get_story_state(self._story_name, self._level)
	local story_states = self._network_story_manager.NETWORK_STORY_STATES
	local can_move = self:can_move()

	if can_move and direction == MOVEABLE_PLATFORM_DIRECTION.forward and story_state == story_states.pause_at_start then
		if self._all_players_inside then
			self:_handle_friendly_bots_on_set_direction()
		end

		self:_lock_units_on_platform()

		self._story_direction = MOVEABLE_PLATFORM_DIRECTION.forward
		local play_direction = self._story_speed_forward

		Unit.flow_event(self._unit, "lua_story_move_forward")

		self._play_end_sound = true

		self:play_story(play_direction)
		self:_set_nav_layer_allowed(self._layer_name_start, false)
		self:_send_direction_to_clients()
	elseif can_move and direction == MOVEABLE_PLATFORM_DIRECTION.backward and story_state == story_states.pause_at_end then
		if self._all_players_inside then
			self:_handle_friendly_bots_on_set_direction()
		end

		self:_lock_units_on_platform()

		self._story_direction = MOVEABLE_PLATFORM_DIRECTION.backward
		local play_direction = -self._story_speed_backward

		Unit.flow_event(self._unit, "lua_story_move_backward")

		self._play_end_sound = true

		self:play_story(play_direction)
		self:_set_nav_layer_allowed(self._layer_name_stop, false)
		self:_send_direction_to_clients()
	elseif direction == MOVEABLE_PLATFORM_DIRECTION.none then
		if self._story_direction ~= direction then
			Unit.flow_event(self._unit, "lua_moveable_platform_end_move")
		end

		self._story_direction = direction

		self:_send_direction_to_clients()
	end
end

function MoveablePlatformExtension:_send_direction_to_clients()
	local unit = self._unit
	local unit_level_index = Managers.state.unit_spawner:level_index(unit)
	local direction_id = NetworkLookup.moveable_platform_direction[self._story_direction]
	local game_session_manager = Managers.state.game_session

	game_session_manager:send_rpc_clients("rpc_moveable_platform_set_direction", unit_level_index, direction_id)
end

function MoveablePlatformExtension:story_direction()
	return self._story_direction
end

function MoveablePlatformExtension:set_direction_husk(direction)
	if direction == MOVEABLE_PLATFORM_DIRECTION.forward then
		self._play_end_sound = true

		Unit.flow_event(self._unit, "lua_story_move_forward")
	elseif direction == MOVEABLE_PLATFORM_DIRECTION.backward then
		self._play_end_sound = true

		Unit.flow_event(self._unit, "lua_story_move_backward")
	elseif direction == MOVEABLE_PLATFORM_DIRECTION.none and self._story_direction ~= direction then
		Unit.flow_event(self._unit, "lua_moveable_platform_end_move")
	end

	self._story_direction = direction
end

function MoveablePlatformExtension:wall_active()
	return self._wall_enabled
end

function MoveablePlatformExtension:set_wall_collision(activate)
	if not self._wall_collision_enabled then
		return
	end

	if activate == self._wall_enabled then
		return
	end

	self._wall_enabled = activate

	for _, wall in pairs(self._walls) do
		self:_enable_wall_collision(wall, activate)
	end

	if activate then
		local camera_player = self._chunk_lod_manager:player()

		if camera_player then
			local camera_player_unit = camera_player.player_unit

			if self._passenger_units[camera_player_unit] then
				self._locked_chunk_lod = self._chunk_lod_manager:set_level_unit(self._unit)
			end
		end
	elseif self._locked_chunk_lod then
		self._chunk_lod_manager:clear_level_unit(self._unit)

		self._locked_chunk_lod = false
	end

	if self._is_server then
		local unit = self._unit
		local unit_level_index = Managers.state.unit_spawner:level_index(unit)
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_moveable_platform_set_wall_collision", unit_level_index, activate)
	end
end

function MoveablePlatformExtension:_enable_wall_collision(actor, activate)
	local filter = OPEN_WALL_FILTER

	if activate then
		filter = self._wall_collision_filter
	end

	Actor.set_collision_filter(actor, filter)
end

function MoveablePlatformExtension:_set_bot_onboard(bot_player_unit, node_index)
	local blackboard = BLACKBOARDS[bot_player_unit]
	local follow_component = Blackboard.write_component(blackboard, "follow")
	follow_component.level_forced_teleport = true
	local node = self._teleport_nodes[node_index]
	local node_position = Unit.world_position(self._unit, node)

	follow_component.level_forced_teleport_position:store(node_position)
end

local TEMP_BOT_PLAYER_UNITS = {}

function MoveablePlatformExtension:_handle_friendly_bots_on_set_direction()
	table.clear(TEMP_BOT_PLAYER_UNITS)

	local has_valid_bots_that_should_be_passengers = false
	local side = self._side_system:get_side_from_name(self._player_side)

	if side then
		local player_unit_spawn_manager = Managers.state.player_unit_spawn
		local player_units = side.player_units
		local num_player_units = #player_units

		for i = 1, num_player_units do
			local player_unit = player_units[i]
			local player = player_unit_spawn_manager:owner(player_unit)

			if not player:is_human_controlled() and self:_valid_passenger_player_unit(player_unit) then
				TEMP_BOT_PLAYER_UNITS[player_unit] = true
				has_valid_bots_that_should_be_passengers = true
			end
		end
	end

	if has_valid_bots_that_should_be_passengers then
		self:_add_bots_to_passengers(TEMP_BOT_PLAYER_UNITS)
	end
end

function MoveablePlatformExtension:update(unit, dt, t)
	if self._is_server then
		if self._story_direction == MOVEABLE_PLATFORM_DIRECTION.forward then
			local story_states = self._network_story_manager.NETWORK_STORY_STATES
			local story_state = self._network_story_manager:get_story_state(self._story_name, self._level)

			self:_check_for_end_flow_events()

			if story_state == story_states.pause_at_end then
				self:_set_direction(MOVEABLE_PLATFORM_DIRECTION.none)
				self:_unlock_units_on_platform()
				self:_set_nav_layer_allowed(self._layer_name_stop, true)
				self:_update_broadphase()
			end
		elseif self._story_direction == MOVEABLE_PLATFORM_DIRECTION.backward then
			local story_states = self._network_story_manager.NETWORK_STORY_STATES
			local story_state = self._network_story_manager:get_story_state(self._story_name, self._level)

			self:_check_for_end_flow_events()

			if story_state == story_states.pause_at_start then
				self:_set_direction(MOVEABLE_PLATFORM_DIRECTION.none)
				self:_unlock_units_on_platform()
				self:_set_nav_layer_allowed(self._layer_name_start, true)
				self:_update_broadphase()
			end
		end
	else
		self:_check_for_end_flow_events()
	end
end

function MoveablePlatformExtension:_check_for_end_flow_events()
	local story_name = self._story_name
	local level = self._level
	local network_story_manager = self._network_story_manager
	local story_states = network_story_manager.NETWORK_STORY_STATES
	local story_state = network_story_manager:get_story_state(story_name, level)

	if story_state == story_states.playing then
		local story_time = network_story_manager:get_story_time(story_name, level)
		local story_length = self._network_story_manager:get_story_length(story_name, level)
		local remaining_time = story_length - story_time

		if self._story_direction == MOVEABLE_PLATFORM_DIRECTION.backward then
			remaining_time = story_time
		end

		if self._play_end_sound then
			local story_speed = self._story_speed_forward

			if self._story_direction == MOVEABLE_PLATFORM_DIRECTION.backward then
				story_speed = self._story_speed_backward
			end

			if remaining_time <= self._end_sound_time * story_speed then
				Unit.flow_event(self._unit, "lua_moveable_platform_end_sound")

				self._play_end_sound = false
			end
		end
	end
end

function MoveablePlatformExtension:fixed_update(unit, dt, t)
	self:_update_passengers()

	self._all_players_inside = self:_get_passengers_onboard_info()

	self:_set_flow_all_players_onboard(self._all_players_inside)
	self._last_fixed_frame_position:store(Unit.local_position(unit, 1))
end

function MoveablePlatformExtension:post_update(unit, dt, t)
	self:_update_velocity(unit, dt)
end

function MoveablePlatformExtension:_update_passengers()
	if self._units_locked then
		local overlapping_units = self._overlap_result[self._box]

		if overlapping_units then
			local passenger_units = self._passenger_units
			local bounding_box, half_size = Unit.box(self._unit)

			for passenger_unit, _ in pairs(passenger_units) do
				if ALIVE[passenger_unit] then
					local player = Managers.state.player_unit_spawn:owner(passenger_unit)
					local is_bot = not player:is_human_controlled()
					local unit_position = Unit.world_position(passenger_unit, 1)
					local is_inside = not is_bot and overlapping_units[passenger_unit] or is_bot and math.point_in_box(unit_position, bounding_box, half_size)

					if not is_inside then
						if self._wall_collision_enabled then
							self:_teleport_player_onboard(passenger_unit)

							local locomotion_extension = ScriptUnit.has_extension(passenger_unit, "locomotion_system")

							if locomotion_extension and locomotion_extension:get_parent_unit() == nil then
								locomotion_extension:set_parent_unit(self._unit)
							end

							Log.warning("MoveablePlatformExtension", "%s considered outside of platform, teleported back", is_bot and "Bot" or "Player")
						else
							self:_unparent_passenger(passenger_unit)
						end
					end
				else
					self._passenger_units[passenger_unit] = nil
				end
			end

			for overlap_unit, _ in pairs(overlapping_units) do
				if not passenger_units[overlap_unit] then
					self:add_passenger(overlap_unit)
				end
			end
		end
	else
		table.clear(self._passenger_units)

		local overlapping_units = self._overlap_result[self._box]

		if overlapping_units then
			local passenger_units = self._passenger_units

			for passenger_unit, _ in pairs(overlapping_units) do
				passenger_units[passenger_unit] = true
			end
		end
	end
end

function MoveablePlatformExtension:teleport_bots_to_node(node_name)
	local unit = self._unit
	local current_node_name = node_name
	local has_node = Unit.has_node(unit, current_node_name)

	if not has_node then
		return
	end

	local bot_players = Managers.player:bot_players()
	local node = Unit.node(unit, current_node_name)
	local node_position = Unit.world_position(unit, node)

	for _, bot_player in pairs(bot_players) do
		local bot_unit = bot_player.player_unit

		if bot_unit then
			local blackboard = BLACKBOARDS[bot_unit]
			local follow_component = Blackboard.write_component(blackboard, "follow")
			follow_component.level_forced_teleport = true

			follow_component.level_forced_teleport_position:store(node_position)
			self:_unparent_passenger(bot_unit)
		end
	end
end

function MoveablePlatformExtension:_add_bots_to_passengers(bot_player_units_to_teleport)
	local passenger_units = self._passenger_units

	for bot_player_unit, _ in pairs(bot_player_units_to_teleport) do
		if not passenger_units[bot_player_unit] then
			passenger_units[bot_player_unit] = true
		end
	end
end

function MoveablePlatformExtension:_update_velocity(unit, dt)
	local previous_position = self._previous_update_position:unbox()
	local current_position = Unit.local_position(unit, 1)
	local delta_pos = current_position - previous_position

	self._previous_update_position:store(current_position)

	self._movement_since_last_fixed_update = current_position - self._last_fixed_frame_position:unbox()
	self._movement_this_render_frame = delta_pos
end

function MoveablePlatformExtension:movement_this_render_frame()
	return self._movement_this_render_frame
end

function MoveablePlatformExtension:movement_since_last_fixed_update()
	return self._movement_since_last_fixed_update
end

function MoveablePlatformExtension:_lock_units_on_platform()
	self:set_wall_collision(true)
	self:_set_platform_as_parent_for_all_passengers()
end

function MoveablePlatformExtension:block_bot_movement()
	return self._units_locked and self._all_players_inside
end

function MoveablePlatformExtension:_passengers_inside_walls()
	for _, wall in pairs(self._walls) do
		if self._overlap_result[wall] then
			local results = self._overlap_result[wall]

			if next(results) ~= nil then
				return true
			end
		end
	end

	return false
end

function MoveablePlatformExtension:_update_broadphase()
	local tm, half_size = Unit.box(self._unit)
	local bottom_center_position = Matrix4x4.translation(tm) + Vector3.down() * half_size.z
	self._broadphase_check_position = Vector3Box(bottom_center_position)
	local radius = math.max(half_size.x, half_size.y)
	self._broadphase_check_radius = radius
	self._bounding_box = Matrix4x4Box(tm)
	self._bounding_box_half_extents = Vector3Box(half_size)
end

local broadphase_results = {}

function MoveablePlatformExtension:_check_hostile_onboard()
	local check_radius = self._broadphase_check_radius
	local check_position = self._broadphase_check_position:unbox()
	local broadphase = self._broadphase
	local bounding_box = self._bounding_box:unbox()
	local half_extents = self._bounding_box_half_extents:unbox()
	local num_results = Broadphase.query(broadphase, check_position, check_radius, broadphase_results, MINION_BREED_TYPE)

	for i = 1, num_results do
		local unit = broadphase_results[i]
		local unit_position = Unit.world_position(unit, 1)
		local offsetted_unit_position = unit_position + Vector3.up() * 0.25

		if math.point_in_box(offsetted_unit_position, bounding_box, half_extents) then
			return true
		end
	end
end

function MoveablePlatformExtension:_teleport_player_onboard(unit)
	local moveable_platform_unit = self._unit
	local node_index = self._teleport_node_index
	local node = self._teleport_nodes[node_index]
	local node_position = Unit.world_position(moveable_platform_unit, node)
	local player = Managers.player:player_by_unit(unit)

	if player then
		if Managers.state.extension:is_in_fixed_update() then
			PlayerMovement.teleport_fixed_update(unit, node_position)
		else
			PlayerMovement.teleport(player, node_position)
		end
	end

	self._teleport_node_index = node_index % self._teleport_node_count + 1
end

function MoveablePlatformExtension:_unlock_units_on_platform()
	self:set_wall_collision(false)

	self._units_locked = false

	self:_unparent_all_passengers()
end

function MoveablePlatformExtension:add_passenger(unit, place_on_platform)
	self._passenger_units[unit] = true

	if self._units_locked then
		local player = Managers.state.player_unit_spawn:owner(unit)

		if not player:is_human_controlled() then
			self:_set_bot_onboard(unit, self._teleport_node_index)
		end

		self:_set_platform_as_parent(unit)

		if place_on_platform then
			self:_teleport_player_onboard(unit)
		end
	end
end

function MoveablePlatformExtension:_set_platform_as_parent(passenger_unit)
	if not ALIVE[passenger_unit] then
		return
	end

	local is_husk_unit = self._unit_spawner:is_husk(passenger_unit)

	if not is_husk_unit then
		local locomotion_extension = ScriptUnit.has_extension(passenger_unit, "locomotion_system")

		if locomotion_extension then
			locomotion_extension:set_parent_unit(self._unit)
		end
	end
end

function MoveablePlatformExtension:_set_platform_as_parent_for_all_passengers()
	for passenger_unit, _ in pairs(self._passenger_units) do
		self:_set_platform_as_parent(passenger_unit)
	end

	self._units_locked = true
end

function MoveablePlatformExtension:_unparent_all_passengers()
	local ALIVE = ALIVE

	for passenger_unit, _ in pairs(self._passenger_units) do
		if ALIVE[passenger_unit] then
			local game_object = self._unit_spawner:game_object_id(passenger_unit)

			if game_object then
				local is_husk_unit = self._unit_spawner:is_husk(passenger_unit)

				if not is_husk_unit then
					local locomotion_extension = ScriptUnit.has_extension(passenger_unit, "locomotion_system")

					if locomotion_extension then
						locomotion_extension:set_parent_unit()
					end
				end
			end
		end
	end

	table.clear(self._passenger_units)
end

function MoveablePlatformExtension:_unparent_passenger(passenger_unit)
	if not self._passenger_units[passenger_unit] then
		return
	end

	if ALIVE[passenger_unit] then
		local game_object = self._unit_spawner:game_object_id(passenger_unit)

		if game_object then
			local is_husk_unit = self._unit_spawner:is_husk(passenger_unit)

			if not is_husk_unit then
				local locomotion_extension = ScriptUnit.has_extension(passenger_unit, "locomotion_system")

				if locomotion_extension then
					locomotion_extension:set_parent_unit()
				end
			end
		end
	end

	self._passenger_units[passenger_unit] = nil
end

function MoveablePlatformExtension:set_story(story_name)
	if story_name == self._story_name then
		return
	end

	self._network_story_manager:unregister_story(self._story_name, self._level)

	self._story_name = story_name

	self._network_story_manager:register_story(story_name, self._level)

	if self._is_server then
		local unit = self._unit
		local unit_level_index = Managers.state.unit_spawner:level_index(unit)
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_moveable_platform_set_story", unit_level_index, story_name)
	end

	self:play_story()

	self._story_changed = true
end

function MoveablePlatformExtension:get_story()
	return self._story_name
end

function MoveablePlatformExtension:should_sync_story_name()
	return self._story_changed
end

function MoveablePlatformExtension:move_forward()
	self:_set_direction(MOVEABLE_PLATFORM_DIRECTION.forward)
end

function MoveablePlatformExtension:move_backward()
	self:_set_direction(MOVEABLE_PLATFORM_DIRECTION.backward)
end

function MoveablePlatformExtension:platform_toggle_loop()
	if not self._is_server then
		return
	end

	if self._story_loop_mode ~= Storyteller.LOOP then
		self._story_loop_mode = Storyteller.LOOP
	else
		self._story_loop_mode = Storyteller.NONE
	end

	self._network_story_manager:set_story_loop_mode(self._story_name, self._level, self._story_loop_mode)
end

function MoveablePlatformExtension:toggle_require_all_players_onboard()
	self._require_all_players_onboard = not self._require_all_players_onboard
end

function MoveablePlatformExtension:_set_flow_all_players_onboard(val)
	if ALIVE[self._unit] then
		Unit.set_flow_variable(self._unit, "lua_all_players_onboard", val)
	end
end

function MoveablePlatformExtension:destroy()
	if self._story_name then
		self._network_story_manager:unregister_story(self._story_name, self._level)

		self._story_name = nil
	end

	self:_unparent_all_passengers()

	local overlap_manager = Managers.state.player_overlap_manager

	for actor, _ in pairs(self._overlap_result) do
		self._overlap_result[actor] = overlap_manager:remove_listening_actor(actor)
	end

	self._walls = nil
	self._box = nil
	self._overlap_result = nil

	if self._locked_chunk_lod then
		self._chunk_lod_manager:clear_level_unit(self._unit)
	end

	self._unit = nil
	self._story_name = nil
	self._passenger_units = nil

	if self._is_server and self._nav_handling_enabled then
		local nav_mesh_manager = Managers.state.nav_mesh
		local layer_name_start = self._layer_name_start

		if not nav_mesh_manager:is_nav_tag_volume_layer_allowed(layer_name_start) then
			nav_mesh_manager:set_allowed_nav_tag_layer(layer_name_start, true)
		end

		local layer_name_stop = self._layer_name_stop

		if not nav_mesh_manager:is_nav_tag_volume_layer_allowed(layer_name_stop) then
			nav_mesh_manager:set_allowed_nav_tag_layer(layer_name_stop, true)
		end
	end
end

function MoveablePlatformExtension:_valid_passenger_player_unit(player_unit)
	local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
	local character_state_component = unit_data_extension:read_component("character_state")

	return HEALTH_ALIVE[player_unit] and not PlayerUnitStatus.is_hogtied(character_state_component)
end

function MoveablePlatformExtension:_get_passengers_onboard_info()
	local side_name = self._player_side
	local side_system = self._side_system
	local side = side_system:get_side_from_name(side_name)
	local player_unit_spawn_manager = Managers.state.player_unit_spawn

	if side then
		local player_units = side.player_units
		local passenger_units = self._overlap_result[self._box]
		local all_valid_players_inside = true
		local at_least_one_player_inside = false

		for i = 1, #player_units do
			local player_unit = player_units[i]
			local player = player_unit_spawn_manager:owner(player_unit)
			local is_human = player:is_human_controlled()

			if is_human and self:_valid_passenger_player_unit(player_unit) then
				local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
				local character_state_component = unit_data_extension:read_component("character_state")

				if not passenger_units[player_unit] or PlayerUnitStatus.is_disabled(character_state_component) then
					all_valid_players_inside = false

					break
				end

				at_least_one_player_inside = true
			end
		end

		return all_valid_players_inside and at_least_one_player_inside
	else
		return false
	end
end

function MoveablePlatformExtension:player_side()
	return self._player_side
end

function MoveablePlatformExtension:_get_volume_alt_min_max(volume_points, volume_height)
	local alt_min, alt_max = nil

	for i = 1, #volume_points do
		local alt = volume_points[i].z

		if not alt_min or alt < alt_min then
			alt_min = alt
		end

		if not alt_max or alt_max < alt + volume_height then
			alt_max = alt + volume_height
		end
	end

	return alt_min, alt_max
end

function MoveablePlatformExtension:_setup_nav_gates(unit)
	local unit_level_index = Managers.state.unit_spawner:level_index(unit)
	local layer_name_start = "nav_elevator_volume_" .. tostring(unit_level_index) .. "_start"
	local layer_name_stop = "nav_elevator_volume_" .. tostring(unit_level_index) .. "_stop"
	local volume_points = Unit.volume_points(unit, "g_volume_block")
	local volume_height = Unit.volume_height(unit, "g_volume_block")
	local volume_alt_min, volume_alt_max = self:_get_volume_alt_min_max(volume_points, volume_height)

	Managers.state.nav_mesh:add_nav_tag_volume(volume_points, volume_alt_min, volume_alt_max, layer_name_start, true)

	self._layer_name_start = layer_name_start
	local offset_position = self._stop_position:unbox() - Unit.world_position(unit, 1)

	for i = 1, #volume_points do
		local volume_point = volume_points[i]
		volume_points[i] = volume_point + offset_position
	end

	volume_alt_min, volume_alt_max = self:_get_volume_alt_min_max(volume_points, volume_height)

	Managers.state.nav_mesh:add_nav_tag_volume(volume_points, volume_alt_min, volume_alt_max, layer_name_stop, false)

	self._layer_name_stop = layer_name_stop
end

function MoveablePlatformExtension:_set_nav_layer_allowed(layer_name, is_allowed)
	if not self._nav_handling_enabled then
		return
	end

	local nav_mesh_manager = Managers.state.nav_mesh

	nav_mesh_manager:set_allowed_nav_tag_layer(layer_name, is_allowed)
end

return MoveablePlatformExtension
