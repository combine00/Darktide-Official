local Animation = require("scripts/utilities/animation")
local Breed = require("scripts/utilities/breed")
local NavQueries = require("scripts/utilities/nav_queries")
local MinionMovement = {}
local RELATIVE_DIR_NAME_RIGHT = "right"
local RELATIVE_DIR_NAME_LEFT = "left"
local RELATIVE_DIR_NAME_FWD = "fwd"
local RELATIVE_DIR_NAME_BWD = "bwd"

function MinionMovement.get_relative_direction_name(right_vector, forward_vector, direction)
	local right_dot = Vector3.dot(right_vector, direction)
	local fwd_dot = Vector3.dot(forward_vector, direction)
	local abs_right = math.abs(right_dot)
	local abs_fwd = math.abs(fwd_dot)
	local relative_direction_name = nil

	if abs_fwd < abs_right and right_dot > 0 then
		relative_direction_name = RELATIVE_DIR_NAME_RIGHT
	elseif abs_fwd < abs_right then
		relative_direction_name = RELATIVE_DIR_NAME_LEFT
	elseif fwd_dot > 0 then
		relative_direction_name = RELATIVE_DIR_NAME_FWD
	else
		relative_direction_name = RELATIVE_DIR_NAME_BWD
	end

	return relative_direction_name
end

function MinionMovement.rotation_towards_unit_flat(unit, target_unit)
	local target_position = POSITION_LOOKUP[target_unit]
	local unit_position = POSITION_LOOKUP[unit]
	local flat_to_target_unit = Vector3.flat(target_position - unit_position)
	local direction = Vector3.normalize(flat_to_target_unit)
	local flat_rotation = Quaternion.look(direction)

	return flat_rotation
end

function MinionMovement.target_velocity(target_unit)
	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local target_current_velocity = nil
	local breed = target_unit_data_extension:breed()
	local is_player_character = Breed.is_player(breed)

	if is_player_character then
		local locomotion_component = target_unit_data_extension:read_component("locomotion")
		target_current_velocity = locomotion_component.velocity_current
	else
		local locomotion_extension = ScriptUnit.extension(target_unit, "locomotion_system")
		target_current_velocity = locomotion_extension:current_velocity()
	end

	return target_current_velocity
end

function MinionMovement.target_speed_away(unit, target_unit)
	local target_current_velocity = MinionMovement.target_velocity(target_unit)
	local position = POSITION_LOOKUP[unit]
	local target_position = POSITION_LOOKUP[target_unit]
	local target_direction = Vector3.normalize(target_position - position)
	local velocity_dot = Vector3.dot(target_direction, target_current_velocity)

	return velocity_dot
end

function MinionMovement.target_position_with_velocity(unit, target_unit, optional_destination)
	local target_current_velocity = MinionMovement.target_velocity(target_unit)
	local destination = optional_destination or POSITION_LOOKUP[target_unit]
	local target_position = destination + target_current_velocity

	return target_position, target_current_velocity
end

function MinionMovement.apply_animation_wanted_movement_speed(unit, navigation_extension, dt)
	local wanted_movement_speed = MinionMovement.get_animation_wanted_movement_speed(unit, dt)

	navigation_extension:set_max_speed(wanted_movement_speed)

	return wanted_movement_speed
end

function MinionMovement.get_animation_wanted_movement_speed(unit, dt, optional_max_speed)
	local self_position = POSITION_LOOKUP[unit]
	local wanted_root_pose = Unit.animation_wanted_root_pose(unit)
	local translation = Matrix4x4.translation(wanted_root_pose)
	local velocity = (translation - self_position) / dt
	local wanted_movement_speed = math.min(Vector3.length(velocity), optional_max_speed or math.huge)

	return wanted_movement_speed
end

function MinionMovement.set_anim_rotation_driven(scratchpad, anim_rotation_driven)
	local locomotion_extension = scratchpad.locomotion_extension

	if anim_rotation_driven then
		locomotion_extension:use_lerp_rotation(false)
	else
		locomotion_extension:use_lerp_rotation(true)
		locomotion_extension:set_anim_rotation_scale(1)
	end

	scratchpad.is_anim_rotation_driven = anim_rotation_driven
end

function MinionMovement.set_anim_rotation(unit, scratchpad)
	local wanted_root_pose = Unit.animation_wanted_root_pose(unit)
	local rotation = Matrix4x4.rotation(wanted_root_pose)
	local locomotion_extension = scratchpad.locomotion_extension

	locomotion_extension:set_wanted_rotation(rotation)
end

function MinionMovement.set_anim_driven(scratchpad, anim_driven, optional_script_driven_rotation, optional_affected_by_gravity)
	local locomotion_extension = scratchpad.locomotion_extension

	if anim_driven then
		local script_driven_rotation = optional_script_driven_rotation or false
		local affected_by_gravity = optional_affected_by_gravity or false

		locomotion_extension:use_lerp_rotation(false)
		locomotion_extension:set_anim_driven(true, affected_by_gravity, script_driven_rotation)
	else
		locomotion_extension:use_lerp_rotation(true)
		locomotion_extension:set_anim_driven(false)
		locomotion_extension:set_anim_rotation_scale(1)
	end

	scratchpad.is_anim_driven = anim_driven
end

function MinionMovement.update_anim_driven_start_rotation(unit, scratchpad, action_data, t, optional_destination, optional_ignore_set_anim_driven)
	if not scratchpad.rotation_duration then
		local destination = optional_destination

		if not destination then
			local navigation_extension = scratchpad.navigation_extension
			local current_node, next_node_in_path = navigation_extension:current_and_next_node_positions_in_path()
			destination = next_node_in_path or current_node
		end

		local start_move_event_name = scratchpad.move_start_anim_event_name
		local start_move_anim_data = action_data.start_move_anim_data[start_move_event_name]
		local rotation_sign = start_move_anim_data.sign
		local rotation_radians = start_move_anim_data.rad
		local rotation_scale = Animation.calculate_anim_rotation_scale(unit, destination, rotation_sign, rotation_radians)

		scratchpad.locomotion_extension:set_anim_rotation_scale(rotation_scale)

		local rotation_duration = action_data.start_rotation_durations[start_move_event_name]
		scratchpad.rotation_duration = t + rotation_duration
	elseif scratchpad.rotation_duration <= t then
		scratchpad.start_rotation_timing = nil
		scratchpad.rotation_duration = nil

		if not optional_ignore_set_anim_driven then
			MinionMovement.set_anim_driven(scratchpad, false)
		end
	end
end

function MinionMovement.get_moving_direction_name(unit, scratchpad, optional_destination, optional_rotation)
	local destination = optional_destination

	if not destination then
		local current_node, next_node_in_path = scratchpad.navigation_extension:current_and_next_node_positions_in_path()
		destination = next_node_in_path or current_node

		if not destination then
			local perception_component = scratchpad.perception_component

			if perception_component then
				local target_unit = perception_component.target_unit
				destination = POSITION_LOOKUP[target_unit]
			end

			if not destination then
				return "fwd"
			end
		end
	end

	local self_position = POSITION_LOOKUP[unit]
	local to_destination = destination - self_position
	local direction = Vector3.flat(Vector3.normalize(to_destination))
	local rotation = optional_rotation or Unit.local_rotation(unit, 1)
	local right = Quaternion.right(rotation)
	local forward = Quaternion.forward(rotation)
	local moving_direction_name = MinionMovement.get_relative_direction_name(right, forward, direction)

	return moving_direction_name
end

function MinionMovement.get_lean_animation_variable_value(unit, scratchpad, action_data, dt, optional_lean_towards_position)
	local wanted_position = optional_lean_towards_position

	if not wanted_position then
		local navigation_extension = scratchpad.navigation_extension
		local path_lean_node_offset = action_data.path_lean_node_offset

		for i = path_lean_node_offset, 1, -1 do
			local _, node = navigation_extension:current_and_wanted_node_position_in_path(i)

			if node then
				wanted_position = node

				break
			end
		end
	end

	if wanted_position then
		local position = POSITION_LOOKUP[unit]
		local flat_desired_velocity_normalized = Vector3.flat(Vector3.normalize(wanted_position - position))
		local unit_rotation = Unit.local_rotation(unit, 1)
		local flat_unit_direction = Vector3.flat(Quaternion.forward(unit_rotation))
		local max_dot_lean_value = action_data.max_dot_lean_value
		local dot = math.max(Vector3.dot(flat_unit_direction, flat_desired_velocity_normalized), max_dot_lean_value)
		local is_to_the_left = Vector3.cross(flat_unit_direction, flat_desired_velocity_normalized).z > 0
		local default_lean_value = action_data.default_lean_value
		local right_lean_value = action_data.right_lean_value
		local left_lean_value = action_data.left_lean_value
		local dot_diff = math.abs(1 - dot)
		local percentage = dot_diff / max_dot_lean_value
		local lean_variable = nil

		if is_to_the_left then
			lean_variable = math.lerp(default_lean_value, left_lean_value, percentage)
		else
			lean_variable = math.lerp(default_lean_value, right_lean_value, percentage)
		end

		local lean_speed = action_data.lean_speed

		if lean_speed then
			local current_lean_variable = scratchpad.current_lean_variable or default_lean_value
			lean_variable = math.lerp(current_lean_variable, lean_variable, dt * lean_speed)
			scratchpad.current_lean_variable = lean_variable
		end

		lean_variable = math.clamp(lean_variable, left_lean_value, right_lean_value)

		return lean_variable
	end
end

local IDLE_MOVE_STATE = "idle"

function MinionMovement.should_start_idle(scratchpad, behavior_component)
	local is_following_path = scratchpad.navigation_extension:is_following_path()

	if is_following_path then
		return false, false
	end

	local move_state = behavior_component.move_state
	local is_in_idle = move_state == IDLE_MOVE_STATE
	local should_start_idle = not is_in_idle

	return should_start_idle, is_in_idle
end

local DEFAULT_IDLE_ANIM_EVENT = "idle"

function MinionMovement.start_idle(scratchpad, behavior_component, action_data)
	local idle_event = Animation.random_event(action_data.idle_anim_events or DEFAULT_IDLE_ANIM_EVENT)

	scratchpad.animation_extension:anim_event(idle_event)

	if scratchpad.is_anim_driven then
		MinionMovement.set_anim_driven(scratchpad, false)

		scratchpad.rotation_duration = nil
		scratchpad.start_rotation_timing = nil
	end

	scratchpad.moving_direction_name = nil
	behavior_component.move_state = IDLE_MOVE_STATE
end

function MinionMovement.get_change_target_direction(unit, target_position)
	local current_position = POSITION_LOOKUP[unit]
	local target_vector_flat = Vector3.normalize(Vector3.flat(target_position - current_position))
	local rotation = Unit.local_rotation(unit, 1)
	local forward_vector_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(rotation)))
	local dot_product = Vector3.dot(forward_vector_flat, target_vector_flat)
	local inv_sqrt_2 = 0.707

	if dot_product >= inv_sqrt_2 then
		return RELATIVE_DIR_NAME_FWD
	elseif dot_product > -inv_sqrt_2 then
		local is_to_the_left = Vector3.cross(forward_vector_flat, target_vector_flat).z > 0

		return is_to_the_left and RELATIVE_DIR_NAME_LEFT or RELATIVE_DIR_NAME_RIGHT
	end

	return RELATIVE_DIR_NAME_BWD
end

function MinionMovement.update_anim_driven_change_target_rotation(unit, scratchpad, action_data, t, target_position)
	if not scratchpad.change_target_rotation_duration then
		local change_target_anim_data = action_data.change_target_anim_data
		local anim_event_name = scratchpad.change_target_anim_event_name
		local anim_data = change_target_anim_data[anim_event_name]
		local rotation_sign = anim_data.sign
		local rotation_radians = anim_data.rad
		local rotation_scale = Animation.calculate_anim_rotation_scale(unit, target_position, rotation_sign, rotation_radians)

		scratchpad.locomotion_extension:set_anim_rotation_scale(rotation_scale)

		local rotation_durations = action_data.change_target_rotation_durations
		local change_target_rotation_duration = rotation_durations[anim_event_name]
		scratchpad.change_target_rotation_duration = t + change_target_rotation_duration
	elseif scratchpad.change_target_rotation_duration <= t then
		scratchpad.change_target_start_rotation_timing = nil
		scratchpad.change_target_rotation_duration = nil

		MinionMovement.set_anim_driven(scratchpad, false)
	end
end

function MinionMovement.update_anim_driven_melee_attack_rotation(unit, scratchpad, action_data, t, target_position)
	if not scratchpad.melee_attack_rotation_duration then
		local melee_rotation_anim_data = action_data.melee_rotation_anim_data
		local anim_event_name = scratchpad.attack_event
		local anim_data = melee_rotation_anim_data[anim_event_name]
		local rotation_sign = anim_data.sign
		local rotation_radians = anim_data.rad
		local rotation_scale = Animation.calculate_anim_rotation_scale(unit, target_position, rotation_sign, rotation_radians)

		scratchpad.locomotion_extension:set_anim_rotation_scale(rotation_scale)

		local rotation_durations = action_data.melee_attack_rotation_durations
		local melee_attack_rotation_duration = rotation_durations[anim_event_name]
		scratchpad.melee_attack_rotation_duration = t + melee_attack_rotation_duration
	elseif scratchpad.melee_attack_rotation_duration <= t then
		scratchpad.melee_attack_rotation_duration = nil

		MinionMovement.set_anim_driven(scratchpad, false)
	end
end

function MinionMovement.update_running_stagger(unit, t, dt, scratchpad, action_data, optional_reset_stagger_immune_time)
	local stagger_component = scratchpad.stagger_component

	if stagger_component.controlled_stagger and not scratchpad.stagger_duration then
		if scratchpad.is_anim_driven then
			MinionMovement.set_anim_driven(scratchpad, false)
		end

		local unit_forward = Quaternion.forward(Unit.local_rotation(unit, 1))
		local stagger_direction = stagger_component.direction:unbox()
		local is_left_stagger = Vector3.cross(unit_forward, stagger_direction).z > 0
		local stagger_anims = is_left_stagger and action_data.running_stagger_anim_left or action_data.running_stagger_anim_right
		local stagger_anim = Animation.random_event(stagger_anims)

		scratchpad.animation_extension:anim_event(stagger_anim)

		local durations = action_data.running_stagger_duration

		if type(durations) == "table" then
			local duration = durations[stagger_anim]
			scratchpad.stagger_duration = t + duration
			local min_durations = action_data.running_stagger_min_duration
			local min_duration = min_durations and min_durations[stagger_anim]

			if min_duration then
				scratchpad.stagger_min_duration = t + min_duration
			end
		else
			scratchpad.stagger_duration = t + durations
		end

		scratchpad.original_movement_speed = scratchpad.navigation_extension:max_speed()

		if not action_data.ignore_running_stagger_combat_range_lock then
			scratchpad.behavior_component.lock_combat_range_switch = true
		end

		if optional_reset_stagger_immune_time then
			stagger_component.immune_time = 0
			stagger_component.controlled_stagger = false
		end
	end

	local running_stagger_min_duration = scratchpad.stagger_min_duration
	scratchpad.running_stagger_block_evaluate = running_stagger_min_duration and t < running_stagger_min_duration
	local done = false

	if scratchpad.stagger_duration and scratchpad.stagger_duration < t then
		MinionMovement.stop_running_stagger(scratchpad)

		done = true
	elseif scratchpad.stagger_duration then
		if action_data.use_animation_running_stagger_speed then
			MinionMovement.apply_animation_wanted_movement_speed(unit, scratchpad.navigation_extension, dt)
		else
			local wanted_animation_root_pose = Unit.animation_wanted_root_pose(unit)
			local root_pose_translation = Matrix4x4.translation(wanted_animation_root_pose)
			local root_pose_velocity = Vector3.normalize(root_pose_translation - POSITION_LOOKUP[unit])

			scratchpad.locomotion_extension:set_external_velocity(root_pose_velocity)
		end
	end

	return done
end

function MinionMovement.stop_running_stagger(scratchpad)
	scratchpad.animation_extension:anim_event("stagger_finished")

	scratchpad.stagger_duration = nil
	scratchpad.behavior_component.lock_combat_range_switch = false
	scratchpad.stagger_component.controlled_stagger = false

	scratchpad.navigation_extension:set_max_speed(scratchpad.original_movement_speed)
end

function MinionMovement.init_find_ranged_position(scratchpad, action_data)
	local degree_range = action_data.randomized_direction_degree_range
	local degree_per_direction = action_data.degree_per_direction
	local num_directions = degree_range / degree_per_direction
	local current_degree = -(degree_range / 2)
	local randomized_move_to_directions = {}

	for i = 1, num_directions do
		current_degree = current_degree + degree_per_direction
		local radians = math.degrees_to_radians(current_degree)
		local direction = Vector3(math.sin(radians), math.cos(radians), 0)
		randomized_move_to_directions[i] = Vector3Box(direction)
	end

	table.shuffle(randomized_move_to_directions)

	scratchpad.randomized_move_to_directions = randomized_move_to_directions
	scratchpad.move_to_cooldown = 0
	scratchpad.move_direction_index = 1
	scratchpad.find_move_position_attempts = 0
	scratchpad.max_distance_to_target_sq = action_data.max_distance_to_target^2
end

local NAV_MESH_ABOVE = 0.7
local NAV_MESH_ABOVE_INCREMENT = 0.2
local NAV_MESH_BELOW = 2
local NAV_MESH_BELOW_INCREMENT = 0.2
local NAV_MESH_LATERAL_INCREMENT = 0.5
local DISTANCE_FROM_NAV_MESH = 0
local MIN_DISTANCE_OFFSET_PER_ATTEMPT = 0.5

function MinionMovement.find_ranged_position(unit, t, scratchpad, action_data, target_unit, optional_above, optional_below, optional_distance_from_nav_mesh)
	local navigation_extension = scratchpad.navigation_extension
	local nav_world = navigation_extension:nav_world()
	local traverse_logic = navigation_extension:traverse_logic()
	local target_position = POSITION_LOOKUP[target_unit]
	local attempts = scratchpad.find_move_position_attempts
	local above = (optional_above or NAV_MESH_ABOVE) + attempts * NAV_MESH_ABOVE_INCREMENT
	local below = (optional_below or NAV_MESH_BELOW) + attempts * NAV_MESH_BELOW_INCREMENT
	local lateral = (attempts + 1) * NAV_MESH_LATERAL_INCREMENT
	local target_position_on_navmesh = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, target_position, above, below, lateral, optional_distance_from_nav_mesh or DISTANCE_FROM_NAV_MESH)
	local goal_position = nil

	if target_position_on_navmesh then
		local unit_position = POSITION_LOOKUP[unit]
		local to_unit = unit_position - target_position
		local to_unit_direction = Vector3.normalize(to_unit)
		local to_unit_rotation = Quaternion.look(to_unit_direction)
		local move_direction_index = scratchpad.move_direction_index
		local randomized_move_to_directions = scratchpad.randomized_move_to_directions
		local randomized_direction = randomized_move_to_directions[move_direction_index]:unbox()
		local randomized_rotation = Quaternion.look(randomized_direction)
		local wanted_rotation = Quaternion.multiply(to_unit_rotation, randomized_rotation)
		local wanted_direction = Quaternion.forward(wanted_rotation)
		local min_distance_to_target = action_data.min_distance_to_target
		local max_distance_to_target = action_data.max_distance_to_target
		local min_distance = math.max(min_distance_to_target - attempts * MIN_DISTANCE_OFFSET_PER_ATTEMPT, 0)
		local wanted_position = target_position_on_navmesh + wanted_direction * math.random_range(min_distance, max_distance_to_target)
		goal_position = NavQueries.position_on_mesh(nav_world, wanted_position, above, below, traverse_logic)

		if not goal_position or not scratchpad.perception_component.has_line_of_sight or action_data.move_to_navmesh_raycast then
			local _, hit_position = GwNavQueries.raycast(nav_world, target_position_on_navmesh, wanted_position, traverse_logic)
			local target_to_hit_position_distance = Vector3.distance(target_position_on_navmesh, hit_position)

			if min_distance <= target_to_hit_position_distance then
				goal_position = hit_position
			else
				goal_position = nil
			end
		end

		if not goal_position then
			if move_direction_index < #randomized_move_to_directions then
				scratchpad.move_direction_index = move_direction_index + 1
			else
				scratchpad.move_to_cooldown = t + action_data.move_to_fail_cooldown
				scratchpad.move_direction_index = 1

				table.shuffle(randomized_move_to_directions)

				scratchpad.find_move_position_attempts = attempts + 1
			end
		end
	else
		scratchpad.find_move_position_attempts = attempts + 1
	end

	if goal_position then
		scratchpad.find_move_position_attempts = 0
		local move_to_cooldown = action_data.move_to_cooldown

		if type(move_to_cooldown) == "table" then
			move_to_cooldown = math.random_range(move_to_cooldown[1], move_to_cooldown[2])
		end

		scratchpad.move_to_cooldown = t + move_to_cooldown
	end

	return goal_position
end

function MinionMovement.update_move_to_ranged_position(unit, t, scratchpad, action_data, target_unit, optional_above, optional_below, optional_distance_from_nav_mesh, optional_force_move)
	local navigation_extension = scratchpad.navigation_extension
	local destination = navigation_extension:destination()
	local target_position = POSITION_LOOKUP[target_unit]
	local distance_to_destination_sq = Vector3.distance_squared(destination, target_position)
	local move_state = scratchpad.behavior_component.move_state
	local is_in_idle = move_state == IDLE_MOVE_STATE
	local has_line_of_sight = nil
	local line_of_sight_id = action_data.line_of_sight_id

	if line_of_sight_id then
		local perception_extension = scratchpad.perception_extension
		has_line_of_sight = perception_extension:has_line_of_sight_by_id(target_unit, line_of_sight_id)
	else
		has_line_of_sight = scratchpad.perception_component.has_line_of_sight
	end

	local force_move_due_to_lost_los = optional_force_move or not has_line_of_sight and is_in_idle

	if scratchpad.move_to_cooldown <= t and (scratchpad.max_distance_to_target_sq < distance_to_destination_sq or force_move_due_to_lost_los) then
		if is_in_idle then
			table.shuffle(scratchpad.randomized_move_to_directions)
		end

		local wanted_position = MinionMovement.find_ranged_position(unit, t, scratchpad, action_data, target_unit, optional_above, optional_below, optional_distance_from_nav_mesh)

		if wanted_position then
			navigation_extension:move_to(wanted_position)
		end
	end
end

local GROUND_NORMAL_ABOVE = 1
local GROUND_NORMAL_BELOW = 3

function MinionMovement.update_ground_normal_rotation(unit, scratchpad, optional_direction, optional_rotation_threshold)
	if scratchpad.is_anim_driven then
		return
	end

	local nav_world = scratchpad.nav_world
	local self_position = POSITION_LOOKUP[unit]
	local self_rotation = Unit.local_rotation(unit, 1)
	local forward = Vector3.normalize(Quaternion.forward(self_rotation))
	local from_position_1 = self_position + forward
	local to_position_1 = from_position_1
	local navmesh_position_1 = NavQueries.position_on_mesh(nav_world, to_position_1, GROUND_NORMAL_ABOVE, GROUND_NORMAL_BELOW)
	local from_position_2 = self_position - forward
	local to_position_2 = from_position_2
	local navmesh_position_2 = NavQueries.position_on_mesh(nav_world, to_position_2, GROUND_NORMAL_ABOVE, GROUND_NORMAL_BELOW)

	if navmesh_position_1 and navmesh_position_2 then
		local locomotion_extension = scratchpad.locomotion_extension
		local fwd_direction = optional_direction
		local current_velocity = locomotion_extension:current_velocity()

		if Vector3.length(current_velocity) > 0.1 then
			fwd_direction = Vector3.normalize(current_velocity)
		end

		if not fwd_direction then
			return
		end

		local wanted_direction = Vector3.normalize(navmesh_position_1 - navmesh_position_2)
		wanted_direction[1] = fwd_direction[1]
		wanted_direction[2] = fwd_direction[2]
		local fwd_dot = Vector3.dot(wanted_direction, Vector3.up())
		local rotation_threshold = optional_rotation_threshold or 0.5

		if math.abs(fwd_dot) < rotation_threshold then
			local wanted_rotation = Quaternion.look(wanted_direction)

			locomotion_extension:set_wanted_rotation(wanted_rotation)
		end
	end
end

function MinionMovement.rotate_towards_target_unit(unit, scratchpad)
	local perception_component = scratchpad.perception_component
	local target_unit = perception_component.target_unit

	if not ALIVE[target_unit] then
		return
	end

	local flat_rotation = nil

	if perception_component.has_line_of_sight then
		flat_rotation = MinionMovement.rotation_towards_unit_flat(unit, target_unit)
	else
		local last_los_position = scratchpad.perception_extension:last_los_position(target_unit)

		if last_los_position then
			local position = POSITION_LOOKUP[unit]
			local to_last_los_position = Vector3.normalize(Vector3.flat(last_los_position - position))
			flat_rotation = Quaternion.look(to_last_los_position)
		end
	end

	if flat_rotation then
		local locomotion_extension = scratchpad.locomotion_extension

		locomotion_extension:set_wanted_rotation(flat_rotation)
	end
end

function MinionMovement.smooth_speed_based_on_distance(unit, scratchpad, dt, action_data, breed, use_slow_action_data, threshold, ignore_max_acc, ignore_max_dec)
	local self_position = POSITION_LOOKUP[unit]
	local move_to_position = scratchpad.move_to_position:unbox()
	local adapt_speed = action_data.adapt_speed
	local speed_timer = adapt_speed.speed_timer
	scratchpad.current_speed_timer = math.clamp(scratchpad.current_speed_timer + dt, 0, speed_timer)

	if speed_timer <= scratchpad.current_speed_timer then
		local current_speed = scratchpad.navigation_extension:max_speed()
		local max_deceleration = use_slow_action_data and adapt_speed.slow_max_deceleration or adapt_speed.max_acceleration
		local max_acceleration_per_second = not ignore_max_acc and adapt_speed.max_acceleration * dt or math.huge
		local max_deceleration_per_second = not ignore_max_dec and max_deceleration * dt or math.huge
		local distance = math.clamp(Vector3.length(move_to_position - self_position) - threshold, 0, math.huge)
		local epsilon = use_slow_action_data and adapt_speed.slow_epsilon or adapt_speed.epsilon
		local v_target = math.sqrt(2 * max_deceleration * distance) * distance / (distance + epsilon)
		v_target = math.clamp(v_target, breed.run_speed * adapt_speed.min_speed_multiplier, breed.run_speed * adapt_speed.max_speed_multiplier)
		local speed_diff = v_target - current_speed
		local delta_speed = nil

		if speed_diff > 0 then
			delta_speed = math.min(speed_diff, max_acceleration_per_second)
		else
			delta_speed = math.max(speed_diff, -max_deceleration_per_second)
		end

		local new_velocity = nil
		new_velocity = current_speed + delta_speed

		scratchpad.navigation_extension:set_max_speed(new_velocity)
	end
end

function MinionMovement.update_move_around_target(unit, t, scratchpad, action_data, target_unit, distance_sign, angle_sign, force_move_to_target)
	local navigation_extension = scratchpad.navigation_extension

	if HEALTH_ALIVE[target_unit] then
		local target_position = POSITION_LOOKUP[target_unit]
		local unit_position = POSITION_LOOKUP[unit]
		local direction = unit_position - target_position
		local direction_length = Vector3.length(direction)
		direction = Vector3.normalize(direction)
		local nav_world = navigation_extension:nav_world()
		local traverse_logic = navigation_extension:traverse_logic()
		local above = 2
		local below = 2
		local lateral = 0.1

		if force_move_to_target then
			local nav_wanted_position = NavQueries.position_on_mesh(nav_world, target_position, above, below, traverse_logic)

			if nav_wanted_position then
				navigation_extension:move_to(nav_wanted_position)

				return true
			end
		end

		local rotation = Quaternion.axis_angle(Vector3.up(), action_data.rotation_angle * angle_sign)
		local target_direction = Quaternion.rotate(rotation, direction)
		local current_distance_to_target = scratchpad.current_distance_to_target
		local min_distance_to_target = action_data.min_distance_to_target
		local max_distance_to_target = action_data.max_distance_to_target

		if not current_distance_to_target then
			scratchpad.current_distance_to_target = math.clamp(direction_length, min_distance_to_target, max_distance_to_target)
		end

		local offset_distance = action_data.offset_distance
		local max_attempts = (max_distance_to_target - min_distance_to_target) / offset_distance
		local initial_distance_to_target = scratchpad.current_distance_to_target
		local wanted_position = target_position + target_direction * initial_distance_to_target
		local nav_wanted_position = NavQueries.position_on_mesh(nav_world, wanted_position, above, below, traverse_logic)

		if nav_wanted_position then
			navigation_extension:move_to(nav_wanted_position)

			return true
		else
			local current_attempts = 0
			local current_multiplier = distance_sign

			while current_attempts < max_attempts do
				current_multiplier = (math.abs(current_multiplier) + 1) * distance_sign
				current_distance_to_target = initial_distance_to_target + offset_distance * current_multiplier
				local range = max_distance_to_target - min_distance_to_target + 1
				current_distance_to_target = current_distance_to_target % range + min_distance_to_target
				wanted_position = target_position + target_direction * current_distance_to_target
				nav_wanted_position = NavQueries.position_on_mesh(nav_world, wanted_position, above, below, traverse_logic)

				if nav_wanted_position then
					navigation_extension:move_to(nav_wanted_position)

					scratchpad.current_distance_to_target = current_distance_to_target

					return true
				end

				current_attempts = current_attempts + 1
			end
		end

		return false
	end
end

function MinionMovement.companion_select_movement_animation(unit, scratchpad, dt, action_data, breed)
	local animation_extension = scratchpad.animation_extension
	local current_speed = Vector3.length(scratchpad.locomotion_extension:current_velocity())
	local animation_speed_thresholds = breed.get_animation_speed_thresholds and breed.get_animation_speed_thresholds() or breed.animation_speed_thresholds
	local follow_component = scratchpad.follow_component
	local current_movement_animation = follow_component.current_movement_animation

	if current_movement_animation ~= "none" then
		local animation_speed_threshold = animation_speed_thresholds[current_movement_animation]
		local min_speed = animation_speed_threshold.min
		local max_speed = animation_speed_threshold.max
		local offset = animation_speed_threshold.offset

		if current_speed >= min_speed - offset and current_speed <= max_speed + offset then
			current_speed = math.clamp(current_speed, min_speed, max_speed)
			local movement_animation_speed = MinionMovement._companion_get_movement_animation_speed(action_data, animation_speed_threshold, current_speed, breed)

			animation_extension:set_variable(animation_speed_threshold.speed_variable, movement_animation_speed)

			return
		end
	end

	for key, values in pairs(animation_speed_thresholds) do
		local animation_speed_threshold = animation_speed_thresholds[key]
		local min_speed = animation_speed_threshold.min
		local max_speed = animation_speed_threshold.max
		local offset = animation_speed_threshold.offset

		if current_speed >= min_speed - offset and current_speed <= max_speed + offset then
			current_speed = math.clamp(current_speed, min_speed, max_speed)
			local movement_animation_speed = MinionMovement._companion_get_movement_animation_speed(action_data, animation_speed_threshold, current_speed, breed)

			animation_extension:anim_event_with_variable_float(animation_speed_threshold.event_name, animation_speed_threshold.speed_variable, movement_animation_speed)

			follow_component.current_movement_animation = key

			return
		end
	end
end

function MinionMovement._companion_get_movement_animation_speed(action_data, animation_speed_threshold, current_speed, breed)
	local speed_variable = animation_speed_threshold.speed_variable
	local animation_variable_bounds = breed.get_animation_variable_bounds and breed.get_animation_variable_bounds() or breed.animation_variable_bounds
	local animation_variable_bounds_speed_variable = animation_variable_bounds[speed_variable]
	local min_speed_rate = animation_variable_bounds_speed_variable[1]
	local max_speed_rate = animation_variable_bounds_speed_variable[2]
	local threshold_min_value = animation_speed_threshold.min
	local threshold_max_value = animation_speed_threshold.max
	local numerator = current_speed - threshold_min_value
	local denominator = threshold_max_value - threshold_min_value

	return min_speed_rate + numerator / denominator * (max_speed_rate - min_speed_rate)
end

return MinionMovement
