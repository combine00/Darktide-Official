require("scripts/extension_systems/player_spawner/player_spawner_extension")

local MainPathQueries = require("scripts/utilities/main_path_queries")
local NavQueries = require("scripts/utilities/nav_queries")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local PlayerSpawnerSystem = class("PlayerSpawnerSystem", "ExtensionSystemBase")
PlayerSpawnerSystem.DEFAULT_SPAWN_IDENTIFIER = "default"
PlayerSpawnerSystem.DEFAULT_SPAWN_SIDE = "heroes"
local MAX_DISTANCE_SQUARED_TO_SPAWN_POINT = 400

function PlayerSpawnerSystem:init(extension_init_context, system_init_data, ...)
	PlayerSpawnerSystem.super.init(self, extension_init_context, system_init_data, ...)

	if self._is_server then
		Managers.event:register(self, "in_safe_volume", "in_safe_volume")
	end

	self._physics_world = extension_init_context.physics_world
	self._spawn_points_by_identifier = {}
	self._next_spawn_point_index_by_identifier = {}
	self._in_safe_volume = true
	self._backup_progression_cooldown = 40
	self._backup_progression_spawn_point = {
		found = false
	}
end

function PlayerSpawnerSystem:destroy()
	if self._is_server then
		Managers.event:unregister(self, "in_safe_volume")
	end
end

function PlayerSpawnerSystem:update(system_context, dt, t)
	if self._is_server then
		self._backup_progression_cooldown = self._backup_progression_cooldown - dt

		if self._backup_progression_cooldown <= 0 then
			local wanted_spawn_point = nil
			local game_mode_manager = Managers.state.game_mode
			local game_mode = game_mode_manager:game_mode()

			if game_mode.next_spawn_point_identifier then
				wanted_spawn_point = game_mode:next_spawn_point_identifier()
			end

			local player_manager = Managers.player
			local players = player_manager:players()

			if not wanted_spawn_point and not table.is_empty(players) then
				local found, position, rotation, parent, side = self:_find_progression_spawn_point()

				if found then
					local backup = self._backup_progression_spawn_point
					backup.found = true
					backup.position = Vector3Box(position)
					backup.rotation = QuaternionBox(rotation)
					backup.parent = parent
					backup.side = side
				end
			end

			self._backup_progression_cooldown = self._backup_progression_cooldown + 10
		end
	end
end

function PlayerSpawnerSystem:in_safe_volume(in_volume)
	if not in_volume then
		self._in_safe_volume = false
	end
end

local function _sort_spawn_priority_func(a, b)
	local priority_a = a.spawn_priority
	local priority_b = b.spawn_priority

	return priority_a < priority_b
end

function PlayerSpawnerSystem:add_spawn_point(unit, side, spawn_identifier, spawn_priority, parent_spawned)
	local position, rotation = nil

	if Unit.has_node(unit, "spawn_location") then
		local node = Unit.node(unit, "spawn_location")
		rotation = Unit.world_rotation(unit, node)
		position = Unit.world_position(unit, node)
	else
		rotation = Unit.local_rotation(unit, 1)
		position = POSITION_LOOKUP[unit]
	end

	local spawn_point_data = {
		unit = unit,
		position = Vector3Box(position),
		rotation = QuaternionBox(rotation),
		parent = parent_spawned and unit or nil,
		spawn_priority = spawn_priority,
		side = side
	}
	local spawn_points = self._spawn_points_by_identifier[spawn_identifier]

	if spawn_points then
		spawn_points[#spawn_points + 1] = spawn_point_data

		table.sort(spawn_points, _sort_spawn_priority_func)
	else
		self._next_spawn_point_index_by_identifier[spawn_identifier] = 1
		self._spawn_points_by_identifier[spawn_identifier] = {
			spawn_point_data
		}
	end
end

function PlayerSpawnerSystem:remove_spawn_point(unit, spawn_identifier)
	local spawn_points = self._spawn_points_by_identifier[spawn_identifier]

	if spawn_points then
		for i = 1, #spawn_points do
			local spawn_point_data = spawn_points[i]

			if spawn_point_data.unit == unit then
				table.remove(spawn_points, i)

				return
			end
		end
	else
		Log.warning("PlayerSpawnerSystem", "[remove_spawn_point] Trying to remove spawner for unit: %s but there are no spawners for spawn_identifier %s\n%s", unit, spawn_identifier, Script.callstack())
	end
end

function PlayerSpawnerSystem:next_free_spawn_point(optional_spawn_identifier)
	local found, position, rotation, parent, side = nil

	if optional_spawn_identifier then
		found, position, rotation, parent, side = self:_find_spawner_spawn_point(optional_spawn_identifier)
	end

	local use_progression_spawn_point = not self._in_safe_volume or self:_use_progression_spawn_in_safe_zone()

	if not found and use_progression_spawn_point then
		found, position, rotation, parent, side = self:_find_progression_spawn_point()
	end

	if not found then
		local identifier = PlayerSpawnerSystem.DEFAULT_SPAWN_IDENTIFIER
		found, position, rotation, parent, side = self:_find_spawner_spawn_point(identifier)
	end

	if not found then
		Log.warning("PlayerSpawnerSystem", "[next_free_spawn_point] No spawner found.\n%s", Script.callstack())

		position = Vector3.zero()
		rotation = Quaternion.identity()
		side = PlayerSpawnerSystem.DEFAULT_SPAWN_SIDE
	end

	return position, rotation, parent, side
end

function PlayerSpawnerSystem:_use_progression_spawn_in_safe_zone()
	local game_mode_name = Managers.state.game_mode:game_mode_name()

	if game_mode_name == "hub" then
		return false
	end

	local player_manager = Managers.player
	local players = player_manager:human_players()
	local spawn_points_by_identifier = self._spawn_points_by_identifier

	for identifier, spawn_point_data in pairs(spawn_points_by_identifier) do
		local num_spawn_points = #spawn_point_data

		for ii = 1, num_spawn_points do
			local spawn_point = spawn_point_data[ii]
			local spawn_point_position = spawn_point.position:unbox()

			for _, player in pairs(players) do
				local player_unit = player.player_unit

				if ALIVE[player_unit] then
					local player_position = Unit.world_position(player_unit, 1)
					local distance_sq = Vector3.distance_squared(player_position, spawn_point_position)

					if MAX_DISTANCE_SQUARED_TO_SPAWN_POINT < distance_sq then
						return true
					end
				end
			end
		end
	end

	return false
end

function PlayerSpawnerSystem:_find_spawner_spawn_point(spawn_identifier)
	local spawn_points = self._spawn_points_by_identifier[spawn_identifier]

	if spawn_points == nil then
		return false
	end

	local next_spawn_point_index_by_identifier = self._next_spawn_point_index_by_identifier
	local spawn_point_index = next_spawn_point_index_by_identifier[spawn_identifier]
	local num_spawn_points = #spawn_points
	next_spawn_point_index_by_identifier[spawn_identifier] = spawn_point_index % num_spawn_points + 1
	local spawn_point = spawn_points[spawn_point_index]

	return true, spawn_point.position:unbox(), spawn_point.rotation:unbox(), spawn_point.parent, spawn_point.side
end

local progression_players = {}

function PlayerSpawnerSystem:_find_progression_spawn_point()
	table.clear(progression_players)

	local player_manager = Managers.player
	local players = player_manager:human_players()
	local num_players = 0

	for _, player in pairs(players) do
		self:_add_progression_player(player, false)

		num_players = num_players + 1
	end

	local bot_players = player_manager:bot_players()

	for _, bot_player in pairs(bot_players) do
		self:_add_progression_player(bot_player, true)

		num_players = num_players + 1
	end

	if #progression_players > 2 then
		local temp = progression_players[1]
		progression_players[1] = progression_players[2]
		progression_players[2] = temp
	end

	for i = 1, #progression_players do
		local player = progression_players[i]

		if not player.disabled and not player.bot then
			local found, position, rotation, parent, side = self:_player_spawn_point(player.unit)

			if found then
				return found, position, rotation, parent, side
			end
		end
	end

	for i = 1, #progression_players do
		local player = progression_players[i]

		if not player.disabled then
			local found, position, rotation, parent, side = self:_player_spawn_point(player.unit)

			if found then
				return found, position, rotation, parent, side
			end
		end
	end

	for i = 1, #progression_players do
		local player = progression_players[i]
		local found, position, rotation, parent, side = self:_player_spawn_point(player.unit)

		if found then
			return found, position, rotation, parent, side
		end
	end

	local backup = self._backup_progression_spawn_point

	if backup.found then
		local position = backup.position:unbox()

		Log.info("PlayerSpawnerSystem", "[_find_progression_spawn_point] Failed to find progression point, using backup position: %s", position)

		return backup.found, position, backup.rotation:unbox(), backup.parent, backup.side
	end

	Log.error("PlayerSpawnerSystem", "[_find_progression_spawn_point] Failed to find progression point, no backup. %s players with %s eligible units \n%s", num_players, #progression_players, Script.callstack())

	for i = 1, #progression_players do
		local info = progression_players[i]

		Log.info("PlayerSpawnerSystem", "[_find_progression_spawn_point] eligible unit: %s, distance: %s, disabled: %s, bot: %s", info.unit, info.distance, info.disabled, info.bot)
	end

	return false
end

function PlayerSpawnerSystem:_add_progression_player(player, bot)
	local player_unit = player.player_unit

	if player_unit then
		local player_pos = Unit.world_position(player_unit, 1)
		local main_path_manager = Managers.state.main_path
		local travel_distance = 0

		if main_path_manager:is_main_path_available() then
			local _, dist = MainPathQueries.closest_position(player_pos)
			travel_distance = dist
		end

		local unit_data_extension = ScriptUnit.has_extension(player_unit, "unit_data_system")

		if unit_data_extension then
			local character_state_component = unit_data_extension:read_component("character_state")

			if not PlayerUnitStatus.is_dead_for_mission_failure(character_state_component) then
				local index = #progression_players + 1

				for i = 1, #progression_players do
					if progression_players[i].distance < travel_distance then
						index = i

						break
					end
				end

				table.insert(progression_players, index, {
					unit = player_unit,
					distance = travel_distance,
					disabled = PlayerUnitStatus.requires_help(character_state_component),
					bot = bot
				})
			end
		end
	end
end

function PlayerSpawnerSystem:_player_spawn_point(unit)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local parent = locomotion_extension:get_parent_unit()
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	local nav_position = navigation_extension:latest_position_on_nav_mesh()

	if nav_position then
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local first_person_component = unit_data_extension:read_component("first_person")
		local look_at_position = first_person_component.position
		local spawn_direction = Vector3.normalize(Vector3.flat(look_at_position - nav_position))
		local spawn_rotation = Quaternion.look(spawn_direction)
		local player_yaw = Quaternion.yaw(first_person_component.rotation)
		local flat_player_rotation = Quaternion.from_yaw_pitch_roll(player_yaw, 0, 0)
		local query_direction = -Quaternion.forward(flat_player_rotation)
		local nav_world = navigation_extension:nav_world()
		local traverse_logic = navigation_extension:traverse_logic()
		local spawn_position = NavQueries.empty_space_near_nav_position(nav_position, query_direction, nav_world, traverse_logic, self._physics_world)

		return true, spawn_position, spawn_rotation, parent, PlayerSpawnerSystem.DEFAULT_SPAWN_SIDE
	elseif parent then
		return true, Unit.world_position(unit, 1), Unit.local_rotation(unit, 1), parent, PlayerSpawnerSystem.DEFAULT_SPAWN_SIDE
	end

	return false
end

return PlayerSpawnerSystem
