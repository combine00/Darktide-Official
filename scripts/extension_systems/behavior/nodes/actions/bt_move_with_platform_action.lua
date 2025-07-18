require("scripts/extension_systems/behavior/nodes/bt_node")

local NavQueries = require("scripts/utilities/nav_queries")
local Animation = require("scripts/utilities/animation")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local MinionMovement = require("scripts/utilities/minion_movement")
local BtMoveWithPlatformAction = class("BtMoveWithPlatformAction", "BtNode")

function BtMoveWithPlatformAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	local behavior_component = Blackboard.write_component(blackboard, "behavior")

	if behavior_component.move_state ~= "idle" then
		local events = action_data.anim_events
		local event = Animation.random_event(events)
		local animation_extension = ScriptUnit.extension(unit, "animation_system")

		animation_extension:anim_event(event)

		behavior_component.move_state = "idle"
	end

	scratchpad.behavior_component = behavior_component
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension:set_movement_type("script_driven")

	scratchpad.locomotion_extension = locomotion_extension
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	scratchpad.nav_world = navigation_extension:nav_world()
	scratchpad.traverse_logic = navigation_extension:traverse_logic()
	local platform_unit = blackboard.movable_platform.unit_reference
	scratchpad.platform_unit = platform_unit
	local moveable_platform_extension = ScriptUnit.has_extension(scratchpad.platform_unit, "moveable_platform_system")
	scratchpad.moveable_platform_extension = moveable_platform_extension
	local platform_node = blackboard.movable_platform.node
	scratchpad.platform_node = platform_node
	local platform_position = Unit.world_position(scratchpad.platform_unit, scratchpad.platform_node)
	scratchpad._last_platform_position = Vector3Box(platform_position)
	local movable_platform_component = Blackboard.write_component(blackboard, "movable_platform")
	scratchpad.movable_platform_component = movable_platform_component
end

function BtMoveWithPlatformAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	if scratchpad.movable_platform_component.has_leave_teleport_position then
		local leave_teleport_position = scratchpad.movable_platform_component.leave_teleport_position

		Unit.set_local_position(unit, 1, leave_teleport_position:unbox())

		scratchpad.movable_platform_component.has_leave_teleport_position = false
		scratchpad.set_fall = true

		return "running"
	elseif scratchpad.set_fall then
		local unit_position = POSITION_LOOKUP[unit]
		local above = 1
		local below = 30
		local lateral = 1
		local nav_world = scratchpad.nav_world
		local traverse_logic = scratchpad.traverse_logic
		local landing_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, unit_position, above, below, lateral)

		if not landing_position then
			scratchpad.movable_platform_component.unit_reference = nil
			scratchpad.behavior_component.is_out_of_bound = true

			return "failed"
		end

		scratchpad.locomotion_extension:set_movement_type("constrained_by_mover", nil, true)
		scratchpad.locomotion_extension:set_affected_by_gravity(true)

		scratchpad.set_fall = false
		scratchpad.fall = true

		return "running"
	elseif scratchpad.fall then
		local unit_position = POSITION_LOOKUP[unit]
		local above = 0.1
		local below = 0.01
		local lateral = 0.3
		local nav_world = scratchpad.nav_world
		local traverse_logic = scratchpad.traverse_logic
		local landing_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, unit_position, above, below, lateral)

		if landing_position then
			scratchpad.locomotion_extension:set_affected_by_gravity(false)
			scratchpad.locomotion_extension:set_movement_type("snap_to_navmesh")

			scratchpad.movable_platform_component.unit_reference = nil

			return "done"
		else
			return "running"
		end
	end

	self:_move_towards_platform(unit, breed, blackboard, scratchpad)

	return "running"
end

function BtMoveWithPlatformAction:leave(unit, breed, blackboard, scratchpad, action_data, t, reason, destroy)
	if not scratchpad.fall then
		self:_move_towards_platform(unit, breed, blackboard, scratchpad)
	end

	MinionMovement.set_anim_driven(scratchpad, false)
	scratchpad.locomotion_extension:set_movement_type("snap_to_navmesh")
end

function BtMoveWithPlatformAction:init_values(blackboard)
	local movable_platform_component = Blackboard.write_component(blackboard, "movable_platform")
	movable_platform_component.unit_reference = nil
	movable_platform_component.node = ""
	movable_platform_component.has_leave_teleport_position = false

	movable_platform_component.leave_teleport_position:store(Vector3.zero())
end

function BtMoveWithPlatformAction:_move_towards_platform(unit, breed, blackboard, scratchpad)
	local platform_position = Unit.world_position(scratchpad.platform_unit, scratchpad.platform_node)
	local platform_offset = platform_position - scratchpad._last_platform_position:unbox()

	Unit.set_local_position(unit, 1, platform_position + platform_offset)

	scratchpad._last_platform_position = Vector3Box(platform_position)
end

return BtMoveWithPlatformAction
