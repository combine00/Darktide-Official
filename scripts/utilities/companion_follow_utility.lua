local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local CompanionDogSettings = require("scripts/utilities/companion/companion_dog_settings")
local NavQueries = require("scripts/utilities/nav_queries")
local CompanionFollowUtility = {}
local MOVEMENT_DIRECTION = table.enum("none", "right", "left")
CompanionFollowUtility.buffer_velocities = {}

function CompanionFollowUtility.companion_has_follow_position(unit, blackboard, scratchpad, condition_args, action_data, is_running, dt)
	local follow_component = Blackboard.write_component(blackboard, "follow")
	local behavior_component = Blackboard.write_component(blackboard, "behavior")

	if follow_component.current_movement_type == "forward" then
		CompanionFollowUtility.store_velocity(unit, blackboard, scratchpad, action_data)
	else
		CompanionFollowUtility.reset_buffer_velocities(unit, blackboard, scratchpad, action_data)
	end

	local movement_vector = nil

	if follow_component.current_position_cooldown ~= -1 then
		local t = Managers.time:time("gameplay")

		if t <= follow_component.current_position_cooldown then
			return true
		else
			follow_component.current_position_cooldown = -1
		end
	end

	local current_owner_cooldown = blackboard.follow.current_owner_cooldown
	local found_position = false
	local current_scratchpad = nil

	if current_owner_cooldown == -1 then
		current_scratchpad = CompanionFollowUtility._create_scratchpad_follow_flrb(unit, blackboard, scratchpad, condition_args, action_data, is_running, dt)

		if CompanionFollowUtility._owner_has_forward_velocity(unit, blackboard, scratchpad, condition_args, action_data, is_running) then
			behavior_component.should_skip_start_anim = false
			current_scratchpad.follow_config = CompanionDogSettings.dog_forward_follow_config
			movement_vector = CompanionFollowUtility.calculate_average_velocity(unit, blackboard, scratchpad, action_data)

			if follow_component.current_movement_type ~= "forward" then
				follow_component.last_referenced_vector:store(movement_vector)
			end

			follow_component.current_movement_type = "forward"
		else
			behavior_component.should_skip_start_anim = true
			current_scratchpad.follow_config = CompanionDogSettings.dog_lrb_follow_config
			local owner_unit_data_extension = ScriptUnit.extension(behavior_component.owner_unit, "unit_data_system")
			local first_person = owner_unit_data_extension:read_component("first_person")
			local look_rotation = first_person.rotation
			movement_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(look_rotation)))

			if follow_component.current_movement_type ~= "lrb" then
				follow_component.last_referenced_vector:store(movement_vector)
			end

			follow_component.current_movement_type = "lrb"
		end

		current_scratchpad.max_angle_per_check = current_scratchpad.follow_config.max_angle_per_second * action_data.reset_position_timer
		found_position = CompanionFollowUtility.calculate_flrb_position(unit, current_scratchpad, dt, movement_vector, action_data)

		if not found_position then
			follow_component.current_owner_cooldown = 0
		end
	end

	if not found_position then
		current_scratchpad = CompanionFollowUtility._create_scratchpad_follow_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
		current_scratchpad.follow_config = CompanionDogSettings.dog_owner_follow_config
		found_position = CompanionFollowUtility.calculate_follow_owner_position(unit, blackboard, current_scratchpad, condition_args, action_data, is_running, dt)

		if found_position then
			follow_component.current_movement_type = "owner"
		else
			follow_component.current_movement_type = "none"
		end
	end

	local t = Managers.time:time("gameplay")
	follow_component.current_position_cooldown = t + action_data.reset_position_timer

	return found_position
end

function CompanionFollowUtility.companion_has_position_around_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local current_scratchpad = CompanionFollowUtility._create_scratchpad_follow_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	return CompanionFollowUtility._calculate_position_around_owner(unit, current_scratchpad, action_data) ~= nil
end

function CompanionFollowUtility.calculate_flrb_position(unit, scratchpad, dt, velocity, action_data)
	local behavior_component = scratchpad.behavior_component
	local follow_component = scratchpad.follow_component
	local self_position = POSITION_LOOKUP[unit]
	local move_to_position = behavior_component.move_to_position:unbox()
	local current_direction, new_position_calculated = nil
	local owner_unit = behavior_component.owner_unit
	local last_referenced_vector = follow_component.last_referenced_vector:unbox()
	local angle_between_velocities = Vector3.angle(last_referenced_vector, velocity, true)

	if scratchpad.max_angle_per_check < math.radians_to_degrees(angle_between_velocities) then
		if CompanionFollowUtility._is_inside_inner_cone(owner_unit, self_position, velocity, scratchpad.follow_config) then
			move_to_position, current_direction, new_position_calculated = CompanionFollowUtility._calculate_new_flrb_position(owner_unit, unit, velocity, scratchpad.follow_config, scratchpad.locomotion_extension:current_velocity(), scratchpad.last_direction, scratchpad, action_data)

			follow_component.last_referenced_vector:store(velocity)
		else
			local rotation = CompanionFollowUtility._calculate_rotation_given_velocities(scratchpad, velocity)
			local new_stored_velocity = Quaternion.rotate(rotation, last_referenced_vector)

			follow_component.last_referenced_vector:store(new_stored_velocity)

			move_to_position, current_direction, new_position_calculated = CompanionFollowUtility._calculate_new_flrb_position(owner_unit, unit, new_stored_velocity, scratchpad.follow_config, scratchpad.locomotion_extension:current_velocity(), scratchpad.last_direction, scratchpad, action_data)
		end
	else
		follow_component.last_referenced_vector:store(velocity)

		move_to_position, current_direction, new_position_calculated = CompanionFollowUtility._calculate_new_flrb_position(owner_unit, unit, velocity, scratchpad.follow_config, scratchpad.locomotion_extension:current_velocity(), scratchpad.last_direction, scratchpad, action_data)
	end

	if move_to_position then
		behavior_component.move_to_position:store(move_to_position)
		scratchpad.aim_component.controlled_aim_position:store(move_to_position)
	end

	return new_position_calculated
end

function CompanionFollowUtility._calculate_new_flrb_position(owner_unit, companion_unit, current_velocity, follow_config, companion_velocity, current_movement_direction, scratchpad, action_data)
	local initial_position = POSITION_LOOKUP[owner_unit]
	local normalized_velocity = Vector3.normalize(current_velocity)
	local speed_length = Vector3.length(current_velocity)
	local speed_length_normalized = math.normalize_01(speed_length, follow_config.min_owner_speed, follow_config.max_owner_speed)
	local speed_length_normalized_for_angle = 1 - speed_length_normalized
	local min_angle = follow_config.front_angle
	local max_angle = 90 - follow_config.side_angle
	local movement_angle = math.degrees_to_radians(math.lerp(min_angle, max_angle, speed_length_normalized_for_angle))
	local left_rotation = Quaternion(Vector3.up(), movement_angle)
	local right_rotation = Quaternion(Vector3.up(), -movement_angle)
	local inner_circle_distance = math.lerp(follow_config.inner_circle_min_distance, follow_config.inner_circle_max_distance, speed_length_normalized)
	local outer_circle_distance = math.lerp(follow_config.outer_circle_min_distance, follow_config.outer_circle_max_distance, speed_length_normalized)
	local distance_offset = (outer_circle_distance - inner_circle_distance) * 0.5
	local distance = inner_circle_distance + distance_offset
	local left_vector = Vector3.normalize(Quaternion.rotate(left_rotation, normalized_velocity)) * distance
	local left_position = left_vector + initial_position
	local right_vector = Vector3.normalize(Quaternion.rotate(right_rotation, normalized_velocity)) * distance
	local right_position = right_vector + initial_position
	local current_move_to_position = scratchpad.behavior_component.move_to_position:unbox()
	local companion_position = current_move_to_position + companion_velocity * follow_config.seconds_for_movement_prediction
	local nav_distances = {
		2,
		2,
		0.25,
		0
	}
	local has_left_hit, has_right_hit = CompanionFollowUtility._ray_trace_movement_check(scratchpad, initial_position, left_position, right_position)

	if has_left_hit and has_right_hit then
		return nil, nil, false
	end

	local is_left_valid = true
	local is_right_valid = true
	is_left_valid = is_left_valid and not has_left_hit
	is_right_valid = is_right_valid and not has_right_hit
	local new_positions_after_check = CompanionFollowUtility._look_for_valid_position(owner_unit, action_data, scratchpad, is_left_valid, is_right_valid, left_position, right_position, nav_distances)
	local follow_left_direction = nil
	local size = table.size(new_positions_after_check)

	if size > 0 then
		if size > 1 then
			local companion_distance_left_position = Vector3.length(new_positions_after_check.first_position - companion_position)
			local companion_distance_right_position = Vector3.length(new_positions_after_check.second_position - companion_position)
			follow_left_direction = current_movement_direction == MOVEMENT_DIRECTION.left or companion_distance_left_position <= companion_distance_right_position and current_movement_direction == MOVEMENT_DIRECTION.none
		else
			follow_left_direction = new_positions_after_check.first_position or false
		end

		local nav_new_position = follow_left_direction and new_positions_after_check.first_position or new_positions_after_check.second_position

		return nav_new_position, follow_left_direction and MOVEMENT_DIRECTION.left or MOVEMENT_DIRECTION.right, true
	else
		return nil, nil, false
	end
end

function CompanionFollowUtility.calculate_follow_owner_position(unit, blackboard, scratchpad, condition_args, action_data, is_running, dt)
	local behavior_component = scratchpad.behavior_component
	local follow_component = scratchpad.follow_component
	local owner_unit = behavior_component.owner_unit
	local player_position = POSITION_LOOKUP[owner_unit]
	local companion_position = POSITION_LOOKUP[unit]
	local flat_direction = Vector3.normalize(Vector3.flat(scratchpad.owner_locomotion_extension:current_velocity()))
	local front_offset = 5
	local back_offset = 2
	local front_position = player_position + front_offset * flat_direction
	local back_position = player_position - back_offset * flat_direction
	local has_front_hit, has_back_hit = CompanionFollowUtility._ray_trace_movement_check(scratchpad, player_position, front_position, back_position)

	if has_front_hit and has_back_hit then
		return false
	end

	local nav_distances = {
		2,
		2,
		0.25,
		0
	}
	local new_positions_after_check = CompanionFollowUtility._look_for_valid_position(owner_unit, action_data, scratchpad, not has_front_hit, not has_back_hit, front_position, back_position, nav_distances)
	local size = table.size(new_positions_after_check)

	if size > 0 then
		local new_position = nil

		if size > 1 then
			local companion_vector = Vector3.normalize(Vector3.flat(companion_position - player_position))
			local dot_product = Vector3.dot(flat_direction, companion_vector, false)

			if dot_product > 0 then
				new_position = new_positions_after_check.first_position
			else
				new_position = new_positions_after_check.second_position
			end
		elseif not new_positions_after_check.first_position then
			new_position = new_positions_after_check.second_position
		end

		behavior_component.move_to_position:store(new_position)
		scratchpad.aim_component.controlled_aim_position:store(new_position)
	else
		return false
	end

	local current_owner_cooldown = follow_component.current_owner_cooldown

	if current_owner_cooldown == -1 then
		return true
	end

	local t = Managers.time:time("gameplay")
	local last_owner_cooldown_time = follow_component.last_owner_cooldown_time

	if last_owner_cooldown_time == -1 then
		last_owner_cooldown_time = t or last_owner_cooldown_time
	end

	local follow_owner_cooldown = action_data.follow_owner_cooldown
	current_owner_cooldown = math.clamp(current_owner_cooldown + t - last_owner_cooldown_time, 0, follow_owner_cooldown)
	follow_component.current_owner_cooldown = follow_owner_cooldown <= current_owner_cooldown and -1 or current_owner_cooldown
	follow_component.last_owner_cooldown_time = follow_owner_cooldown <= current_owner_cooldown and -1 or t

	return true
end

function CompanionFollowUtility._calculate_position_around_owner(unit, scratchpad, action_data)
	local owner_position = POSITION_LOOKUP[scratchpad.owner_unit]
	local outer_circle_distance = action_data.idle_circle_distances.outer_circle_distance
	local inner_circle_distance = action_data.idle_circle_distances.inner_circle_distance
	local distance_from_owner = inner_circle_distance + (outer_circle_distance - inner_circle_distance) * 0.5
	local nav_distances = {
		0.25,
		0.25,
		0.25,
		0
	}
	local valid_positions = CompanionFollowUtility.select_points_around_center_with_owner_forward(unit, scratchpad, action_data, owner_position, distance_from_owner, nav_distances, false, 1)
	local behavior_component = scratchpad.behavior_component
	local num_valid_positions = #valid_positions
	local new_position = nil

	if num_valid_positions > 0 then
		new_position = valid_positions[1]

		if num_valid_positions ~= 1 then
			local owner_velocity = Vector3.flat(ScriptUnit.extension(scratchpad.owner_unit, "locomotion_system"):current_velocity())

			if not Vector3.equal(owner_velocity, Vector3.zero()) then
				owner_velocity = Vector3.normalize(owner_velocity) * distance_from_owner
				local position_to_avoid = owner_position + owner_velocity
				local index_point_to_avoid = CompanionFollowUtility._calculate_index_of_closest_point_to_reference_point(valid_positions, position_to_avoid)

				table.remove(valid_positions, index_point_to_avoid)
			end

			local index_new_position = CompanionFollowUtility._calculate_index_of_closest_point_to_reference_point(valid_positions, POSITION_LOOKUP[unit])
			new_position = valid_positions[index_new_position]
		end

		behavior_component.has_move_to_position = true
		behavior_component.should_skip_start_anim = true

		behavior_component.move_to_position:store(new_position)
	end

	return new_position
end

function CompanionFollowUtility.manage_direction_timer(scratchpad, dt, action_data)
	local direction_timer = scratchpad.follow_config.direction_timer
	scratchpad.current_direction_timer = math.clamp(scratchpad.current_direction_timer + dt, 0, direction_timer)

	if direction_timer <= scratchpad.current_direction_timer then
		scratchpad.last_direction = MOVEMENT_DIRECTION.none
		scratchpad.current_direction_timer = 0
	end
end

function CompanionFollowUtility.select_points_around_another_center(unit, scratchpad, action_data, center, forward_vector, nav_distances, stop_at_first, debug_draw_timer)
	local valid_positions = {}
	local angle_checks = 360 / (action_data.angle_rotation_for_check or scratchpad.follow_config.angle_rotation_for_check)
	local angle_radians = math.degrees_to_radians(action_data.angle_rotation_for_check or scratchpad.follow_config.angle_rotation_for_check)

	for i = 1, angle_checks do
		local rotation = Quaternion(Vector3.up(), angle_radians * i)
		local pos_before_nav_check = center + Quaternion.rotate(rotation, forward_vector)
		local nav_world = scratchpad.navigation_extension:nav_world()
		local traverse_logic = scratchpad.navigation_extension:traverse_logic()
		local new_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, pos_before_nav_check, nav_distances[1], nav_distances[2], nav_distances[3], nav_distances[4])

		if new_position then
			table.insert(valid_positions, new_position)
		end

		if stop_at_first and new_position then
			return valid_positions
		end
	end

	return valid_positions
end

function CompanionFollowUtility.select_points_around_center_with_owner_forward(unit, scratchpad, action_data, center, distance, nav_distances, stop_at_first, draw_debug_timer)
	local owner_unit_data_extension = ScriptUnit.extension(scratchpad.owner_unit, "unit_data_system")
	local first_person = owner_unit_data_extension:read_component("first_person")
	local look_rotation = first_person.rotation
	local forward_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(look_rotation))) * distance

	return CompanionFollowUtility.select_points_around_another_center(unit, scratchpad, action_data, center, forward_vector, nav_distances, stop_at_first, draw_debug_timer)
end

function CompanionFollowUtility._look_for_valid_position(owner_unit, action_data, scratchpad, is_first_valid, is_second_valid, first_position, second_position, nav_distances)
	local is_both_valid = is_first_valid and is_second_valid
	local new_positions = {}

	if is_both_valid then
		new_positions.first_position = first_position
		new_positions.second_position = second_position
	elseif is_first_valid then
		new_positions.first_position = first_position
	else
		new_positions.second_position = second_position
	end

	local new_positions_after_check = {}

	for key, position in pairs(new_positions) do
		local new_position = new_positions[key]
		local nav_world = scratchpad.navigation_extension:nav_world()
		local traverse_logic = scratchpad.navigation_extension:traverse_logic()
		local nav_new_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, new_position, nav_distances[1], nav_distances[2], nav_distances[3], nav_distances[4])

		if not nav_new_position then
			local distance_from_point = 1
			local valid_positions = CompanionFollowUtility.select_points_around_center_with_owner_forward(owner_unit, scratchpad, action_data, new_position, distance_from_point, nav_distances, true, 1)
			nav_new_position = #valid_positions > 0 and valid_positions[1] or nil
		end

		if nav_new_position then
			new_positions_after_check[key] = nav_new_position
		end
	end

	return new_positions_after_check
end

function CompanionFollowUtility.store_velocity(unit, blackboard, scratchpad, action_data)
	local owner_velocity = ScriptUnit.extension(blackboard.behavior.owner_unit, "locomotion_system"):current_velocity()

	table.insert(CompanionFollowUtility.buffer_velocities, 1, Vector3Box(owner_velocity))

	if #CompanionFollowUtility.buffer_velocities > 50 then
		table.remove(CompanionFollowUtility.buffer_velocities, 51)
	end
end

function CompanionFollowUtility.reset_buffer_velocities(unit, blackboard, scratchpad, action_data)
	CompanionFollowUtility.buffer_velocities = {}
end

function CompanionFollowUtility.calculate_average_velocity(unit, blackboard, scratchpad, action_data)
	local average_vector = Vector3.zero()

	for i = 1, #CompanionFollowUtility.buffer_velocities do
		local vector = Vector3Box.unbox(CompanionFollowUtility.buffer_velocities[i])
		average_vector = average_vector + vector
	end

	local num_velocities = #CompanionFollowUtility.buffer_velocities

	if num_velocities > 0 then
		average_vector = average_vector / num_velocities
	end

	if Vector3.equal(average_vector, Vector3.zero()) then
		average_vector = ScriptUnit.extension(blackboard.behavior.owner_unit, "locomotion_system"):current_velocity()
	end

	return average_vector
end

function CompanionFollowUtility._ray_trace_movement_check(scratchpad, initial_position, first_position, second_position)
	local position_offset = Vector3(0, 0, 1.5)
	local trace_position = initial_position + position_offset
	local first_trace_position = first_position + position_offset
	local second_trace_position = second_position + position_offset
	local spawn_component = scratchpad.spawn_component
	local physics_world = spawn_component.physics_world
	local first_trace_direction = first_trace_position - trace_position
	local second_trace_direction = second_trace_position - trace_position
	local has_first_hit = PhysicsWorld.raycast(physics_world, trace_position, first_trace_direction, Vector3.length(first_trace_direction), "closest", "collision_filter", "filter_simple_geometry")
	local has_second_hit = PhysicsWorld.raycast(physics_world, trace_position, second_trace_direction, Vector3.length(second_trace_direction), "closest", "collision_filter", "filter_simple_geometry")

	return has_first_hit, has_second_hit
end

function CompanionFollowUtility._calculate_index_of_closest_point_to_reference_point(valid_positions, reference_point)
	local index = 1
	local current_distance = Vector3.length(valid_positions[index] - reference_point)

	for i = 2, #valid_positions do
		local new_distance = Vector3.length(valid_positions[i] - reference_point)

		if new_distance < current_distance then
			current_distance = new_distance
			index = i
		end
	end

	return index
end

function CompanionFollowUtility._calculate_rotation_given_velocities(scratchpad, velocity)
	local follow_component = scratchpad.follow_component
	local last_referenced_vector = follow_component.last_referenced_vector:unbox()
	local velocity_quaternion = Quaternion.look(Vector3.flat(velocity), Vector3.up())
	local velocity_right_vector = Quaternion.right(velocity_quaternion)
	local dot_product = Vector3.dot(last_referenced_vector, velocity_right_vector, true)

	if dot_product > 0 then
		return Quaternion(Vector3.up(), math.degrees_to_radians(scratchpad.max_angle_per_check))
	else
		return Quaternion(Vector3.up(), math.degrees_to_radians(-scratchpad.max_angle_per_check))
	end
end

function CompanionFollowUtility._is_inside_inner_cone(owner, position, current_velocity, follow_config)
	local initial_position = POSITION_LOOKUP[owner]
	local min_angle = math.degrees_to_radians(follow_config.front_angle)
	local min_angle_rotation = Quaternion(Vector3.up(), min_angle)
	local opposite_min_angle_rotation = Quaternion(Vector3.up(), -min_angle)
	local opposite_direction_right = Vector3.normalize(Quaternion.rotate(min_angle_rotation, current_velocity))
	local opposite_direction_left = Vector3.normalize(Quaternion.rotate(opposite_min_angle_rotation, current_velocity))
	local current_vector = Vector3.normalize(position - initial_position)
	local cross_product1 = Vector3.cross(opposite_direction_left, current_vector)
	local cross_product2 = Vector3.cross(current_vector, opposite_direction_right)
	local is_inside_cone = Vector3.dot(cross_product1, cross_product2) >= 0

	return is_inside_cone
end

function CompanionFollowUtility._get_forward_direction(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
	local owner_unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
	local first_person = owner_unit_data_extension:read_component("first_person")
	local look_rotation = first_person.rotation
	local owner_forward_vector = Vector3.normalize(Vector3.flat(Quaternion.forward(look_rotation)))

	return owner_forward_vector, owner_locomotion_extension
end

function CompanionFollowUtility._owner_has_forward_velocity(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local owner_forward_vector, owner_locomotion_extension = CompanionFollowUtility._get_forward_direction(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local dot_product = Vector3.dot(owner_forward_vector, Vector3.normalize(owner_locomotion_extension:current_velocity()))

	return dot_product > 0.05
end

function CompanionFollowUtility._owner_has_backward_velocity(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local owner_forward_vector, owner_locomotion_extension = CompanionFollowUtility._get_forward_direction(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local dot_product = Vector3.dot(-owner_forward_vector, Vector3.normalize(owner_locomotion_extension:current_velocity()))

	return dot_product > 0.05
end

function CompanionFollowUtility._create_scratchpad_follow_flrb(unit, blackboard, scratchpad, condition_args, action_data, is_running, dt)
	local current_scratchpad = {}
	local behavior_component = Blackboard.write_component(blackboard, "behavior")
	current_scratchpad.behavior_component = behavior_component
	local follow_component = Blackboard.write_component(blackboard, "follow")
	current_scratchpad.follow_component = follow_component
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	current_scratchpad.animation_extension = ScriptUnit.extension(unit, "animation_system")
	current_scratchpad.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	current_scratchpad.navigation_extension = navigation_extension
	local aim_component = Blackboard.write_component(blackboard, "aim")
	current_scratchpad.aim_component = aim_component
	local spawn_component = Blackboard.write_component(blackboard, "spawn")
	current_scratchpad.spawn_component = spawn_component
	local owner_unit = behavior_component.owner_unit
	current_scratchpad.owner_unit = owner_unit
	current_scratchpad.owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
	current_scratchpad.current_direction_timer = 0
	current_scratchpad.last_direction = MOVEMENT_DIRECTION.none
	current_scratchpad.last_referenced_vector = Vector3Box(Vector3.zero())

	return current_scratchpad
end

function CompanionFollowUtility._create_scratchpad_follow_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local current_scratchpad = {}
	local behavior_component = Blackboard.write_component(blackboard, "behavior")
	current_scratchpad.behavior_component = behavior_component
	local follow_component = Blackboard.write_component(blackboard, "follow")
	current_scratchpad.follow_component = follow_component
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	current_scratchpad.animation_extension = ScriptUnit.extension(unit, "animation_system")
	current_scratchpad.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	current_scratchpad.navigation_extension = navigation_extension
	local owner_unit = behavior_component.owner_unit
	current_scratchpad.owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
	local spawn_component = Blackboard.write_component(blackboard, "spawn")
	current_scratchpad.spawn_component = spawn_component
	local aim_component = Blackboard.write_component(blackboard, "aim")
	current_scratchpad.aim_component = aim_component
	current_scratchpad.owner_unit = owner_unit

	return current_scratchpad
end

return CompanionFollowUtility
