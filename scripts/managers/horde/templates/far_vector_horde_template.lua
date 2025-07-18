local MainPathQueries = require("scripts/utilities/main_path_queries")
local HordeUtilities = require("scripts/managers/horde/utilities/horde_utilities")
local NavQueries = require("scripts/utilities/nav_queries")
local PerceptionSettings = require("scripts/settings/perception/perception_settings")
local aggro_states = PerceptionSettings.aggro_states
local horde_template = {
	euclidean_distance_from_targets = 20,
	name = "far_vector_horde",
	requires_main_path = true,
	chance_spawning_ahead = 0.67,
	main_path_distance_from_targets = {
		60,
		80
	}
}
local breeds_to_spawn = {}

local function _compose_spawn_list(composition)
	local Math_random = math.random

	table.clear_array(breeds_to_spawn, #breeds_to_spawn)

	local breeds = composition.breeds

	for i = 1, #breeds do
		local breed_data = breeds[i]
		local breed_name = breed_data.name
		local amount = breed_data.amount
		local num_to_spawn = Math_random(amount[1], amount[2])

		for j = 1, num_to_spawn do
			breeds_to_spawn[#breeds_to_spawn + 1] = breed_name
		end
	end

	table.shuffle(breeds_to_spawn)

	return breeds_to_spawn, #breeds_to_spawn
end

local function _check_spawn_is_hidden(physics_world, wanted_position, side)
	local collision_filter = "filter_minion_line_of_sight_check"
	local in_line_of_sight = HordeUtilities.position_has_line_of_sight_to_any_enemy_player(physics_world, wanted_position, side, collision_filter)

	if in_line_of_sight then
		Log.info("FarVectorHorde", "\t\tSpawn position in line of sight of enemy player(s).")

		return false
	end

	return true
end

local function _find_nav_position(nav_world, traverse_logic, wanted_position)
	local nav_position, _ = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, wanted_position)

	if not nav_position then
		Log.info("FarVectorHorde", "\t\tCouldn't find path position at position: %s", wanted_position)
	end

	return nav_position
end

local function _try_find_position_ahead_or_behind_target_on_main_path(physics_world, nav_world, traverse_logic, check_ahead, travel_distance, euclidean_distance, side, target_side)
	local main_path_manager = Managers.state.main_path
	local target_unit, target_travel_distance, target_path_position = nil
	local target_side_id = target_side.side_id

	if check_ahead then
		target_unit, target_travel_distance, target_path_position = main_path_manager:ahead_unit(target_side_id)
	else
		target_unit, target_travel_distance, target_path_position = main_path_manager:behind_unit(target_side_id)
	end

	if not target_unit then
		Log.info("FarVectorHorde", "\t\tNo main path tracked unit for target side %q.", target_side:name())

		return false
	end

	local check_travel_distance = target_travel_distance + travel_distance * (check_ahead and 1 or -1)

	if check_travel_distance < 0 then
		Log.info("FarVectorHorde", "\t\tCouldn't find path position at travel distance %.2f.", check_travel_distance)

		return false
	end

	local wanted_position, _ = MainPathQueries.position_from_distance(check_travel_distance)

	if not wanted_position then
		Log.info("FarVectorHorde", "\t\tCouldn't find path position at travel distance %.2f.", check_travel_distance)

		return false
	end

	local position_on_allowed_navmesh = NavQueries.position_on_mesh(nav_world, wanted_position, 1, 1, traverse_logic)

	if not position_on_allowed_navmesh then
		Log.info("FarVectorHorde", "\t\tPath position was on disallowed navmesh %s.", wanted_position)

		return false
	end

	if not _check_spawn_is_hidden(physics_world, wanted_position, side) then
		return false
	end

	local to_target = target_path_position - wanted_position
	local distance_sq = Vector3.length_squared(to_target)

	if distance_sq >= euclidean_distance * euclidean_distance then
		local target_direction = Vector3.normalize(to_target)

		return true, wanted_position, target_direction, target_unit
	else
		Log.info("FarVectorHorde", "\t\tSpawn position's euclidean distance is closer than %.2f.", euclidean_distance)

		return false
	end
end

local function _try_find_position_on_main_path(physics_world, nav_world, traverse_logic, chance_spawning_ahead, main_path_distances, euclidean_distance, side, target_side)
	local random_roll = math.random()
	local spawn_horde_ahead = random_roll <= chance_spawning_ahead
	local min_main_path_distance = main_path_distances[1]

	Log.info("FarVectorHorde", "Attempting to spawn %s within %.2f m.", spawn_horde_ahead and "ahead" or "behind", min_main_path_distance)

	local success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target_on_main_path(physics_world, nav_world, traverse_logic, spawn_horde_ahead, min_main_path_distance, euclidean_distance, side, target_side)

	if not success then
		Log.info("FarVectorHorde", "\tNo position found, will try to spawn %s.", not spawn_horde_ahead and "ahead" or "behind")

		spawn_horde_ahead = not spawn_horde_ahead
		success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target_on_main_path(physics_world, nav_world, traverse_logic, spawn_horde_ahead, min_main_path_distance, euclidean_distance, side, target_side)

		if not success then
			local max_main_path_distance = main_path_distances[2]

			Log.info("FarVectorHorde", "\tNo position found, will try a final time to spawn %s within %.2f m.", spawn_horde_ahead and "ahead" or "behind", max_main_path_distance)

			spawn_horde_ahead = not spawn_horde_ahead
			success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target_on_main_path(physics_world, nav_world, traverse_logic, spawn_horde_ahead, max_main_path_distance, euclidean_distance, side, target_side)
		end
	end

	return horde_position, target_direction, target_unit, spawn_horde_ahead
end

local function _try_find_position_ahead_or_behind_target(physics_world, nav_world, traverse_logic, check_ahead, travel_distance, min_distance, side, target_side)
	local main_path_manager = Managers.state.main_path
	local target_unit = nil
	local target_side_id = target_side.side_id

	if check_ahead then
		target_unit = main_path_manager:ahead_unit(target_side_id)
	else
		target_unit = main_path_manager:behind_unit(target_side_id)
	end

	if not target_unit then
		Log.info("FarVectorHorde", "\t\tNo tracked unit for target side %q.", target_side:name())

		return false
	end

	local target_position = POSITION_LOOKUP[target_unit]
	local angle = math.random_range(0, math.pi)

	for i = 1, 2 do
		local wanted_position = target_position + Vector3(math.cos(angle), math.sin(angle), 0) * travel_distance
		local nav_position = _find_nav_position(nav_world, traverse_logic, wanted_position)

		if nav_position and _check_spawn_is_hidden(physics_world, nav_position, side) then
			local to_target = target_position - nav_position
			local distance_sq = Vector3.length_squared(to_target)

			if distance_sq >= min_distance * min_distance then
				local target_direction = Vector3.normalize(to_target)

				return true, nav_position, target_direction, target_unit
			else
				Log.info("FarVectorHorde", "\t\tSpawn posisiton is closer than %.2f.", min_distance)
			end
		end

		angle = angle + math.pi
	end

	return false
end

local function _try_find_position_on_nav_world(physics_world, nav_world, traverse_logic, chance_spawning_ahead, distances, euclidean_distance, side, target_side)
	local random_roll = math.random()
	local spawn_horde_ahead = random_roll <= chance_spawning_ahead
	local distance = distances[1]

	Log.info("FarVectorHorde", "Attempting to spawn %s within %.2f m.", spawn_horde_ahead and "ahead" or "behind", distance)

	local success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target(physics_world, nav_world, traverse_logic, spawn_horde_ahead, distance, euclidean_distance, side, target_side)

	if not success then
		Log.info("FarVectorHorde", "\tNo position found, will try to spawn %s.", not spawn_horde_ahead and "ahead" or "behind")

		spawn_horde_ahead = not spawn_horde_ahead
		success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target(physics_world, nav_world, traverse_logic, spawn_horde_ahead, distance, euclidean_distance, side, target_side)

		if not success then
			local long_distance = distances[2]

			Log.info("FarVectorHorde", "\tNo position found, will try a final time to spawn %s within %.2f m.", spawn_horde_ahead and "ahead" or "behind", long_distance)

			spawn_horde_ahead = not spawn_horde_ahead
			success, horde_position, target_direction, target_unit = _try_find_position_ahead_or_behind_target(physics_world, nav_world, traverse_logic, spawn_horde_ahead, long_distance, euclidean_distance, side, target_side)
		end
	end

	return horde_position, target_direction, target_unit, spawn_horde_ahead
end

local NUM_COLUMNS = 6
local MAX_SPAWN_POSITION_ATTEMPTS = 8

function horde_template.execute(physics_world, nav_world, side, target_side, composition, towards_combat_vector, optional_main_path_offset, optional_num_tries, optional_disallowed_positions, optional_spawn_max_health_modifier, optional_prefered_direction)
	local target_side_id = target_side.side_id
	local _, ahead_travel_distance = Managers.state.main_path:ahead_unit(target_side_id)

	if not ahead_travel_distance then
		Log.info("FarVectorHorde", "Couldn't find a ahead unit, failing horde.")

		return
	end

	local chance_spawning_ahead = nil

	if optional_prefered_direction then
		if optional_prefered_direction == "ahead" then
			chance_spawning_ahead = 1
		else
			chance_spawning_ahead = 0
		end
	elseif towards_combat_vector then
		local combat_vector_system = Managers.state.extension:system("combat_vector_system")
		local combat_vector_to_position = combat_vector_system:get_to_position()
		local _, combat_vector_travel_distance = MainPathQueries.closest_position(combat_vector_to_position)

		if combat_vector_travel_distance < ahead_travel_distance then
			chance_spawning_ahead = 0
		else
			chance_spawning_ahead = 1
		end
	else
		chance_spawning_ahead = horde_template.chance_spawning_ahead
	end

	local main_path_distance_from_targets = horde_template.main_path_distance_from_targets
	local euclidean_distance_from_targets = horde_template.euclidean_distance_from_targets
	local traverse_logic = Managers.state.pacing:roamer_traverse_logic()
	local main_path_manager = Managers.state.main_path
	local horde_position, horde_direction, target_unit, spawn_horde_ahead = nil

	if main_path_manager:path_type() == "linear" then
		horde_position, horde_direction, target_unit, spawn_horde_ahead = _try_find_position_on_main_path(physics_world, nav_world, traverse_logic, chance_spawning_ahead, main_path_distance_from_targets, euclidean_distance_from_targets, side, target_side)
	else
		horde_position, horde_direction, target_unit, spawn_horde_ahead = _try_find_position_on_nav_world(physics_world, nav_world, traverse_logic, chance_spawning_ahead, main_path_distance_from_targets, euclidean_distance_from_targets, side, target_side)
	end

	if not horde_position then
		Log.info("FarVectorHorde", "Couldn't find a spawn position, failing horde.")

		return
	end

	local group_system = Managers.state.extension:system("group_system")
	local group_id = group_system:generate_group_id()
	local spawn_list, num_to_spawn = _compose_spawn_list(composition)
	local horde = {
		template_name = horde_template.name,
		side = side,
		target_side = target_side,
		group_id = group_id
	}
	local spawn_rotation = Quaternion.look(Vector3(horde_direction.x, horde_direction.y, 0))
	local side_id = side.side_id
	local minion_spawn_manager = Managers.state.minion_spawn
	local num_spawned = 0

	for i = 1, num_to_spawn do
		local spawn_position = HordeUtilities.try_find_spawn_position(nav_world, horde_position, i, NUM_COLUMNS, MAX_SPAWN_POSITION_ATTEMPTS, traverse_logic)

		if spawn_position then
			local breed_name = spawn_list[i]
			local queue_parameters = minion_spawn_manager:queue_minion_to_spawn(breed_name, spawn_position, spawn_rotation, side_id)
			queue_parameters.optional_aggro_state = aggro_states.aggroed
			queue_parameters.optional_target_unit = target_unit
			queue_parameters.optional_group_id = group_id
			num_spawned = num_spawned + 1
		end
	end

	Log.info("FarVectorHorde", "Managed to spawn %d/%d horde enemies.", num_spawned, num_to_spawn)

	local spawned_direction = spawn_horde_ahead and "ahead" or "behind"

	return horde, horde_position, target_unit, spawned_direction
end

return horde_template
