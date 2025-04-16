require("scripts/extension_systems/behavior/nodes/actions/bt_idle_action")

local NavQueries = require("scripts/utilities/nav_queries")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local SpawnPointQueries = require("scripts/managers/main_path/utilities/spawn_point_queries")
local BtCompanionUnstuckAction = class("BtCompanionUnstuckAction", "BtIdleAction")

function BtCompanionUnstuckAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	BtCompanionUnstuckAction.super:enter(unit, breed, blackboard, scratchpad, action_data, t)

	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	scratchpad.nav_world = navigation_extension:nav_world()
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	scratchpad.locomotion_extension = locomotion_extension
	local behavior_component = Blackboard.write_component(blackboard, "behavior")
	scratchpad.behavior_component = behavior_component
	scratchpad._initial_offset = 0

	self:_find_position_and_teleport(unit, breed, blackboard, scratchpad, action_data, t)
end

function BtCompanionUnstuckAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	BtCompanionUnstuckAction.super:run(unit, breed, blackboard, scratchpad, action_data, dt, t)

	if not scratchpad.waiting_time then
		self:_find_position_and_teleport(unit, breed, blackboard, scratchpad, action_data, t)
	elseif scratchpad.waiting_time < t then
		local unit_position = POSITION_LOOKUP[unit]
		local above = 1
		local below = 1
		local lateral = 1
		local nav_world = scratchpad.nav_world
		local traverse_logic = scratchpad.traverse_logic
		local valid_position = NavQueries.position_on_mesh_with_outside_position(nav_world, traverse_logic, unit_position, above, below, lateral)

		if valid_position then
			scratchpad.locomotion_extension:set_movement_type("snap_to_navmesh")
			scratchpad.locomotion_extension:set_affected_by_gravity(true)

			scratchpad.behavior_component.is_out_of_bound = false

			return "done"
		else
			scratchpad.waiting_time = nil

			self:_find_position_and_teleport(unit, breed, blackboard, scratchpad, action_data, t)
		end
	end

	return "running"
end

function BtCompanionUnstuckAction:init_values(blackboard)
	BtCompanionUnstuckAction.super:init_values(blackboard)

	local behavior_component = Blackboard.write_component(blackboard, "behavior")
	behavior_component.is_out_of_bound = false
end

local ABOVE = 1
local BELOW = 1
local LATERAL = 1

function BtCompanionUnstuckAction:_find_position_and_teleport(unit, breed, blackboard, scratchpad, action_data, t)
	local main_path_manager = Managers.state.main_path
	local nav_spawn_points = main_path_manager:nav_spawn_points()

	if not nav_spawn_points then
		Log.error("bt_companion_unstuck_action", "No Nav mesh points")

		local owner_unit = blackboard.behavior.owner_unit
		local owner_position = POSITION_LOOKUP[owner_unit]

		self:_teleport(unit, breed, blackboard, scratchpad, action_data, t, owner_position)

		return
	end

	local num_groups = GwNavSpawnPoints.get_count(nav_spawn_points)
	local unit_blackboard = BLACKBOARDS[unit]
	local owner_pos = POSITION_LOOKUP[unit_blackboard.behavior.owner_unit]
	local nav_mesh_position = NavQueries.position_on_mesh_with_outside_position(scratchpad.nav_world, nil, owner_pos, ABOVE, BELOW, LATERAL)
	local side = ScriptUnit.extension(unit, "side_system").side
	local valid_human_units_positions = side.valid_human_units_positions

	if nav_mesh_position then
		local offset_range = 1
		local max_distance = action_data.max_distance_from_players
		local occluded_positions, num_occluded_positions = SpawnPointQueries.get_occluded_positions(scratchpad.nav_world, nav_spawn_points, nav_mesh_position, valid_human_units_positions, offset_range, num_groups, action_data.min_distance_from_players, max_distance, scratchpad._initial_offset)

		if occluded_positions and num_occluded_positions > 0 then
			Managers.state.out_of_bounds:unregister_soft_oob_unit(unit, self)

			local random_occlude_position = math.random(1, num_occluded_positions)

			self:_teleport(unit, breed, blackboard, scratchpad, action_data, t, occluded_positions[random_occlude_position])

			return
		else
			scratchpad._initial_offset = scratchpad._initial_offset + 1
		end
	end
end

function BtCompanionUnstuckAction:_teleport(unit, breed, blackboard, scratchpad, action_data, t, teleport_position)
	local locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")

	locomotion_extension:set_affected_by_gravity(false)
	locomotion_extension:set_movement_type("script_driven")
	locomotion_extension:teleport_to(teleport_position)

	scratchpad.waiting_time = t + action_data.waiting_time
end

return BtCompanionUnstuckAction
