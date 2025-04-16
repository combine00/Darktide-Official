require("scripts/extension_systems/behavior/nodes/bt_node")

local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local CompanionDogSettings = require("scripts/utilities/companion/companion_dog_settings")
local MinionMovement = require("scripts/utilities/minion_movement")
local NavQueries = require("scripts/utilities/nav_queries")
local Trajectory = require("scripts/utilities/trajectory")
local DogLeapSettings = CompanionDogSettings.dog_leap_settings
local lean_settings = CompanionDogSettings.leaning
local BtCompanionApproachAction = class("BtCompanionApproachAction", "BtNode")

function BtCompanionApproachAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	scratchpad.animation_extension = ScriptUnit.extension(unit, "animation_system")
	scratchpad.locomotion_extension = locomotion_extension
	scratchpad.navigation_extension = navigation_extension
	scratchpad.pounce_component = Blackboard.write_component(blackboard, "pounce")
	scratchpad.behavior_component = Blackboard.write_component(blackboard, "behavior")
	scratchpad.perception_component = Blackboard.write_component(blackboard, "perception")
	local speed = action_data.speed

	navigation_extension:set_enabled(true, speed)

	scratchpad.original_rotation_speed = locomotion_extension:rotation_speed()

	locomotion_extension:set_rotation_speed(action_data.rotation_speed)

	scratchpad.side_system = Managers.state.extension:system("side_system")
	local follow_component = Blackboard.write_component(blackboard, "follow")
	scratchpad.follow_component = follow_component
	local spawn_component = blackboard.spawn
	scratchpad.physics_world = spawn_component.physics_world
	scratchpad.check_leap_t = 0
	scratchpad.num_failed_leap_checks = 0
	scratchpad.trigger_player_alert_vo_t = 0
	local nav_world = navigation_extension:nav_world()
	scratchpad.nav_world = nav_world

	MinionMovement.init_find_ranged_position(scratchpad, action_data)
end

function BtCompanionApproachAction:leave(unit, breed, blackboard, scratchpad, action_data, t, reason, destroy)
	if scratchpad.is_anim_driven then
		MinionMovement.set_anim_driven(scratchpad, false)
	end

	scratchpad.locomotion_extension:set_rotation_speed(scratchpad.original_rotation_speed)
	scratchpad.navigation_extension:set_enabled(false)
end

local IDLE_DURATION = 2
local NUM_FAILED_ATTEMPTS_TO_MANUAL_MOVE = 3
local UPDATE_TARGET_DISTANCE_SQ = 1

function BtCompanionApproachAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	local behavior_component = scratchpad.behavior_component
	local perception_component = scratchpad.perception_component
	local move_state = behavior_component.move_state
	local target_unit = perception_component.target_unit
	local target_distance = perception_component.target_distance
	local too_close_distance = action_data.too_close_distance

	if target_distance <= too_close_distance then
		if move_state == "moving" then
			behavior_component.move_state = ""
		end

		scratchpad.pounce_component.pounce_cooldown = t + action_data.leap_cooldown

		return "failed"
	end

	local navigation_extension = scratchpad.navigation_extension

	if scratchpad.check_leap_t < t then
		local can_start_leap, is_long_leap = self:_can_start_leap(unit, scratchpad, action_data, perception_component, t)

		if can_start_leap then
			if not is_long_leap then
				navigation_extension:set_enabled(false)
			end

			return "done"
		end
	end

	local find_move_position_attempts = scratchpad.find_move_position_attempts

	if NUM_FAILED_ATTEMPTS_TO_MANUAL_MOVE <= find_move_position_attempts then
		self:_move_to_target(scratchpad)
	else
		local target_position = POSITION_LOOKUP[target_unit]
		local destination = navigation_extension:destination()
		local target_to_destination_distance_sq = Vector3.distance_squared(target_position, destination)
		local force_move = UPDATE_TARGET_DISTANCE_SQ < target_to_destination_distance_sq

		MinionMovement.update_move_to_ranged_position(unit, t, scratchpad, action_data, target_unit, nil, nil, nil, force_move)
	end

	local should_start_idle, should_be_idling = MinionMovement.should_start_idle(scratchpad, behavior_component)

	if should_start_idle or should_be_idling then
		if should_start_idle then
			MinionMovement.start_idle(scratchpad, behavior_component, action_data)

			scratchpad.idle_duration = t + IDLE_DURATION
		elseif scratchpad.idle_duration and scratchpad.idle_duration <= t then
			return "failed"
		end

		return "running"
	end

	if move_state ~= "moving" then
		self:_start_move_anim(unit, scratchpad, action_data, t)
	end

	if scratchpad.is_anim_driven and scratchpad.start_rotation_timing and scratchpad.start_rotation_timing <= t then
		MinionMovement.update_anim_driven_start_rotation(unit, scratchpad, action_data, t)
	end

	if scratchpad.start_move_event_anim_speed_duration then
		if t < scratchpad.start_move_event_anim_speed_duration then
			MinionMovement.apply_animation_wanted_movement_speed(unit, navigation_extension, dt)
		else
			navigation_extension:set_max_speed(action_data.speed)

			scratchpad.start_move_event_anim_speed_duration = nil
		end
	end

	if not scratchpad.is_anim_driven and not scratchpad.start_move_event_anim_speed_duration and breed.animation_speed_thresholds then
		MinionMovement.companion_select_movement_animation(unit, scratchpad, dt, action_data, breed)
	end

	local is_following_path = scratchpad.navigation_extension:is_following_path()

	if is_following_path then
		self:_update_anim_lean_variable(unit, scratchpad, action_data, dt)
	end

	MinionMovement.update_ground_normal_rotation(unit, scratchpad)

	return "running"
end

local ABOVE = 1
local BELOW = 2
local NAV_Z_CORRECTION = 0.1
local TRAJECTORY_FAILED_COOLDOWN = 0.25

function BtCompanionApproachAction:_can_start_leap(unit, scratchpad, action_data, perception_component, t)
	if not perception_component.has_line_of_sight then
		return false, false
	end

	local leave_distance = action_data.leave_distance
	local target_distance = perception_component.target_distance

	if leave_distance <= target_distance then
		return false, false
	end

	local target_unit = perception_component.target_unit
	local target_position = POSITION_LOOKUP[target_unit]
	local navigation_extension = scratchpad.navigation_extension
	local nav_world = navigation_extension:nav_world()
	local traverse_logic = navigation_extension:traverse_logic()
	local target_position_on_nav_mesh = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, target_position, ABOVE, BELOW)

	if not target_position_on_nav_mesh then
		return false, false
	end

	local position = POSITION_LOOKUP[unit]
	local raycango = GwNavQueries.raycango(nav_world, position, target_position_on_nav_mesh, traverse_logic)

	if not raycango then
		return false, false
	end

	local leap_start_position = nil
	local current_speed = Vector3.length(scratchpad.locomotion_extension:current_velocity())
	local use_long_leap = DogLeapSettings.long_leap_min_speed <= current_speed and DogLeapSettings.short_distance <= target_distance

	if use_long_leap then
		local target_direction = Vector3.normalize(target_position - position)
		local offset_position = position + target_direction * DogLeapSettings.long_leap_start_offset_distance
		local offset_position_on_nav_mesh = NavQueries.position_on_mesh(nav_world, offset_position, 1, 1, traverse_logic)

		if not offset_position_on_nav_mesh then
			return false, false
		end

		local can_reach_start_position = GwNavQueries.raycango(nav_world, position, offset_position_on_nav_mesh, traverse_logic)

		if not can_reach_start_position then
			return false, false
		end

		leap_start_position = offset_position_on_nav_mesh + Vector3(0, 0, NAV_Z_CORRECTION)
	else
		leap_start_position = position + Vector3(0, 0, NAV_Z_CORRECTION)
	end

	local target_node_name = DogLeapSettings.leap_target_node_name
	local target_node = Unit.node(target_unit, target_node_name)
	local leap_target_position = Unit.world_position(target_unit, target_node) + Vector3(0, 0, DogLeapSettings.leap_target_z_offset)
	local target_locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local target_velocity = target_locomotion_extension:current_velocity()
	local success = self:_check_leap(scratchpad.physics_world, leap_start_position, leap_target_position, target_velocity)

	if not success then
		scratchpad.check_leap_t = t + TRAJECTORY_FAILED_COOLDOWN
		scratchpad.num_failed_leap_checks = scratchpad.num_failed_leap_checks + 1

		return false, false
	end

	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local target_unit_breed = target_unit_data_extension:breed()
	local companion_pounce_setting = target_unit_breed.companion_pounce_setting
	local required_token = companion_pounce_setting.required_token

	if required_token then
		local required_token_name = required_token.name
		local token_extension = ScriptUnit.has_extension(target_unit, "token_system")

		if token_extension and token_extension:is_token_free_or_mine(unit, required_token_name) then
			token_extension:assign_token(unit, required_token_name)
		else
			return false, false
		end
	end

	return true, use_long_leap
end

function BtCompanionApproachAction:_check_leap(physics_world, start_position, target_position, target_velocity)
	local speed = DogLeapSettings.leap_speed
	local gravity = DogLeapSettings.leap_gravity
	local acceptable_accuracy = DogLeapSettings.leap_acceptable_accuracy
	local angle_to_hit_target, est_pos = Trajectory.angle_to_hit_moving_target(start_position, target_position, speed, target_velocity, gravity, acceptable_accuracy)

	if not angle_to_hit_target then
		return false
	end

	local _, time_in_flight = Trajectory.get_trajectory_velocity(start_position, est_pos, gravity, speed, angle_to_hit_target)
	time_in_flight = math.min(time_in_flight, DogLeapSettings.leap_max_time_in_flight)
	local debug = nil
	local num_sections = DogLeapSettings.leap_num_sections
	local collision_filter = DogLeapSettings.leap_collision_filter
	local radius = DogLeapSettings.leap_radius
	local relax_distance = DogLeapSettings.collision_radius
	local trajectory_is_ok = Trajectory.check_trajectory_collisions(physics_world, start_position, est_pos, gravity, speed, angle_to_hit_target, num_sections, collision_filter, time_in_flight, debug, radius, relax_distance)

	return trajectory_is_ok
end

function BtCompanionApproachAction:_start_move_anim(unit, scratchpad, action_data, t)
	local moving_direction_name = MinionMovement.get_moving_direction_name(unit, scratchpad)
	local start_move_anim_events = action_data.start_move_anim_events
	local start_move_event = start_move_anim_events[moving_direction_name]

	scratchpad.animation_extension:anim_event(start_move_event)

	if moving_direction_name ~= "fwd" then
		MinionMovement.set_anim_driven(scratchpad, true)

		local start_rotation_timing = action_data.start_move_rotation_timings[start_move_event]
		scratchpad.start_rotation_timing = t + start_rotation_timing
		scratchpad.move_start_anim_event_name = start_move_event
	else
		scratchpad.start_rotation_timing = nil
		scratchpad.move_start_anim_event_name = nil
	end

	local start_move_event_anim_speed_duration = action_data.start_move_event_anim_speed_durations and action_data.start_move_event_anim_speed_durations[start_move_event]

	if start_move_event_anim_speed_duration then
		scratchpad.start_move_event_anim_speed_duration = t + start_move_event_anim_speed_duration
	end

	scratchpad.behavior_component.move_state = "moving"
end

local LATERAL = 2

function BtCompanionApproachAction:_move_to_target(scratchpad)
	local navigation_extension = scratchpad.navigation_extension
	local nav_world = navigation_extension:nav_world()
	local traverse_logic = navigation_extension:traverse_logic()
	local target_unit = scratchpad.perception_component.target_unit
	local wanted_position = POSITION_LOOKUP[target_unit]
	local goal_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, wanted_position, ABOVE, BELOW, LATERAL)

	if goal_position then
		navigation_extension:move_to(goal_position)
	end
end

function BtCompanionApproachAction:_update_anim_lean_variable(unit, scratchpad, action_data, dt)
	local lean_value = MinionMovement.get_lean_animation_variable_value(unit, scratchpad, lean_settings, dt)

	if lean_value then
		local lean_variable_name = lean_settings.lean_variable_name

		scratchpad.animation_extension:set_variable(lean_variable_name, lean_value)
	end
end

return BtCompanionApproachAction
