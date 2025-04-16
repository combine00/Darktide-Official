require("scripts/extension_systems/behavior/nodes/bt_node")

local MinionMovement = require("scripts/utilities/minion_movement")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local CompanionDogSettings = require("scripts/utilities/companion/companion_dog_settings")
local BtCompanionMoveAroundEnemyAction = class("BtCompanionMoveAroundEnemyAction", "BtNode")
local lean_settings = CompanionDogSettings.leaning

function BtCompanionMoveAroundEnemyAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	scratchpad.animation_extension = ScriptUnit.extension(unit, "animation_system")
	scratchpad.locomotion_extension = locomotion_extension
	scratchpad.navigation_extension = navigation_extension
	scratchpad.behavior_component = Blackboard.write_component(blackboard, "behavior")
	scratchpad.perception_component = Blackboard.write_component(blackboard, "perception")
	local speed = action_data.speed

	navigation_extension:set_enabled(true, speed)

	scratchpad.original_rotation_speed = locomotion_extension:rotation_speed()

	locomotion_extension:set_rotation_speed(action_data.rotation_speed)

	local follow_component = Blackboard.write_component(blackboard, "follow")
	scratchpad.follow_component = follow_component
	scratchpad.move_to_cooldown = 0
	scratchpad.force_idle = false
	local nav_world = navigation_extension:nav_world()
	scratchpad.nav_world = nav_world

	MinionMovement.init_find_ranged_position(scratchpad, action_data)
end

function BtCompanionMoveAroundEnemyAction:leave(unit, breed, blackboard, scratchpad, action_data, t, reason, destroy)
	if scratchpad.is_anim_driven then
		MinionMovement.set_anim_driven(scratchpad, false)
	end

	scratchpad.locomotion_extension:set_rotation_speed(scratchpad.original_rotation_speed)
	scratchpad.navigation_extension:set_enabled(false)
end

local IDLE_DURATION = 2

function BtCompanionMoveAroundEnemyAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	local behavior_component = scratchpad.behavior_component
	local perception_component = scratchpad.perception_component
	local move_state = behavior_component.move_state
	local target_unit = perception_component.target_unit
	local navigation_extension = scratchpad.navigation_extension
	local find_move_position_attempts = scratchpad.find_move_position_attempts

	if scratchpad.move_to_cooldown < t then
		local force_move = true

		MinionMovement.update_move_to_ranged_position(unit, t, scratchpad, action_data, target_unit, nil, nil, nil, force_move)

		if find_move_position_attempts == 0 then
			if behavior_component.move_state ~= "moving" then
				behavior_component.move_state = ""
				scratchpad.force_idle = false
			end
		else
			scratchpad.force_idle = true
		end
	end

	local should_start_idle, should_be_idling = MinionMovement.should_start_idle(scratchpad, behavior_component)

	if scratchpad.force_idle or should_start_idle or should_be_idling then
		if should_start_idle then
			MinionMovement.start_idle(scratchpad, behavior_component, action_data)

			scratchpad.idle_duration = t + IDLE_DURATION
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

function BtCompanionMoveAroundEnemyAction:_start_move_anim(unit, scratchpad, action_data, t)
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

function BtCompanionMoveAroundEnemyAction:_update_anim_lean_variable(unit, scratchpad, action_data, dt)
	local lean_value = MinionMovement.get_lean_animation_variable_value(unit, scratchpad, lean_settings, dt)

	if lean_value then
		local lean_variable_name = lean_settings.lean_variable_name

		scratchpad.animation_extension:set_variable(lean_variable_name, lean_value)
	end
end

return BtCompanionMoveAroundEnemyAction
