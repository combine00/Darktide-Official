require("scripts/extension_systems/behavior/nodes/bt_node")

local BtCompanionDogSelectorNode = class("BtCompanionDogSelectorNode", "BtNode")

function BtCompanionDogSelectorNode:init(...)
	BtCompanionDogSelectorNode.super.init(self, ...)

	self._children = {}
end

function BtCompanionDogSelectorNode:init_values(blackboard, action_data, node_data)
	BtCompanionDogSelectorNode.super.init_values(self, blackboard, action_data, node_data)

	local children = self._children

	for i = 1, #children do
		local child_node = children[i]
		local child_tree_node = child_node.tree_node
		local child_action_data = child_tree_node.action_data

		child_node:init_values(blackboard, child_action_data, node_data)
	end
end

function BtCompanionDogSelectorNode:add_child(node)
	self._children[#self._children + 1] = node
end

function BtCompanionDogSelectorNode:evaluate(unit, blackboard, scratchpad, dt, t, evaluate_utility, node_data, old_running_child_nodes, new_running_child_nodes, last_leaf_node_running)
	local node_identifier = self.identifier
	local last_running_node = old_running_child_nodes[node_identifier]
	local children = self._children
	local node_companion_unstuck = children[1]
	local condition_result = blackboard.behavior.is_out_of_bound

	if condition_result then
		new_running_child_nodes[node_identifier] = node_companion_unstuck

		return node_companion_unstuck
	end

	local node_move_with_platform = children[2]
	local condition_result = blackboard.movable_platform.unit_reference ~= nil

	if condition_result then
		new_running_child_nodes[node_identifier] = node_move_with_platform

		return node_move_with_platform
	end

	local node_smart_object = children[3]
	local condition_result = nil

	repeat
		local nav_smart_object_component = blackboard.nav_smart_object
		local smart_object_id = nav_smart_object_component.id
		local smart_object_is_next = smart_object_id ~= -1

		if not smart_object_is_next then
			condition_result = false
		else
			local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
			local is_smart_objecting = navigation_extension:is_using_smart_object()

			if is_smart_objecting then
				condition_result = true
			else
				local smart_object_unit = nav_smart_object_component.unit

				if not ALIVE[smart_object_unit] then
					condition_result = false
				else
					local nav_graph_extension = ScriptUnit.extension(smart_object_unit, "nav_graph_system")
					local nav_graph_added = nav_graph_extension:nav_graph_added(smart_object_id)

					if not nav_graph_added then
						condition_result = false
					else
						local behavior_component = blackboard.behavior
						local is_in_moving_state = behavior_component.move_state == "moving"
						local entrance_is_at_bot_progress_on_path = nav_smart_object_component.entrance_is_at_bot_progress_on_path
						condition_result = is_in_moving_state and entrance_is_at_bot_progress_on_path
					end
				end
			end
		end
	until true

	if condition_result then
		local leaf_node = node_smart_object:evaluate(unit, blackboard, scratchpad, dt, t, evaluate_utility, node_data, old_running_child_nodes, new_running_child_nodes, last_leaf_node_running)

		if leaf_node then
			new_running_child_nodes[node_identifier] = node_smart_object

			return leaf_node
		end
	end

	local node_combat = children[4]
	local is_running = last_leaf_node_running and last_running_node == node_combat
	local sub_condition_result_01, condition_result = nil

	repeat
		local sub_condition_result_01, condition_result = nil

		repeat
			local perception_component = blackboard.perception

			if not is_running and perception_component.lock_target then
				condition_result = false
			else
				local target_unit = perception_component.target_unit
				condition_result = HEALTH_ALIVE[target_unit]
			end
		until true

		sub_condition_result_01 = condition_result
		local has_target_unit = sub_condition_result_01

		if not has_target_unit then
			condition_result = false
		else
			local perception_component = blackboard.perception
			local is_aggroed = perception_component.aggro_state == "aggroed"
			condition_result = is_aggroed
		end
	until true

	sub_condition_result_01 = condition_result
	local is_aggroed = sub_condition_result_01
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_attack_intensity_extension = ScriptUnit.has_extension(owner_unit, "attack_intensity_system")
	local in_combat = not owner_attack_intensity_extension or owner_attack_intensity_extension:in_combat_for_companion()
	local companion_whistle_target = nil
	local smart_tag_system = Managers.state.extension:system("smart_tag_system")
	local tag_target, tag = smart_tag_system:unit_tagged_by_player_unit(owner_unit)
	local tag_template = tag and tag:template()
	local tag_type = tag_template and tag_template.marker_type

	if tag_target and tag_type == "unit_threat_adamant" then
		local unit_data_extension = ScriptUnit.has_extension(tag_target, "unit_data_system")
		local breed = unit_data_extension and unit_data_extension:breed()
		local daemonhost = breed and breed.tags.witch

		if daemonhost then
			local daemonhost_blackboard = BLACKBOARDS[tag_target]
			local daemonhost_perception_component = daemonhost_blackboard.perception
			local host_is_aggroed = daemonhost_perception_component.aggro_state == "aggroed"

			if host_is_aggroed then
				companion_whistle_target = tag_target
			end
		else
			companion_whistle_target = tag_target
		end
	end

	local force_combat = HEALTH_ALIVE[companion_whistle_target]
	local pounce_component = blackboard.pounce
	local condition_result = is_aggroed and (in_combat or force_combat) or pounce_component.started_leap or pounce_component.has_pounce_target

	if condition_result then
		local leaf_node = node_combat:evaluate(unit, blackboard, scratchpad, dt, t, evaluate_utility, node_data, old_running_child_nodes, new_running_child_nodes, last_leaf_node_running)

		if leaf_node then
			new_running_child_nodes[node_identifier] = node_combat

			return leaf_node
		end
	end

	local node_follow = children[5]
	local tree_node = node_follow.tree_node
	local condition_args = tree_node.condition_args
	local action_data = tree_node.action_data
	local is_running = last_leaf_node_running and last_running_node == node_follow
	local condition_result = nil

	repeat
		local behavior_component = blackboard.behavior
		local owner_unit = behavior_component.owner_unit
		local owner_position = POSITION_LOOKUP[owner_unit]
		local current_state = behavior_component.current_state
		local outer_circle_distance = action_data.idle_circle_distances.outer_circle_distance
		local inner_circle_distance = action_data.idle_circle_distances.inner_circle_distance
		local companion_position = POSITION_LOOKUP[unit]
		local distance_from_owner = Vector3.length(companion_position - owner_position)
		local sub_condition_result_01 = nil
		local behavior_component = blackboard.behavior
		local owner_unit = behavior_component.owner_unit
		local owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
		local owner_speed = Vector3.length(Vector3.flat(owner_locomotion_extension:current_velocity()))
		local condition_result = owner_speed > 0.05
		sub_condition_result_01 = condition_result
		local is_owner_moving = sub_condition_result_01

		if is_owner_moving and (current_state == "follow" or outer_circle_distance < distance_from_owner) then
			local CompanionFollowUtility = require("scripts/utilities/companion_follow_utility")
			local companion_has_follow_position = CompanionFollowUtility.companion_has_follow_position(unit, blackboard, scratchpad, condition_args, action_data, is_running)
			condition_result = companion_has_follow_position
		else
			condition_result = false
		end
	until true

	if condition_result then
		local leaf_node = node_follow:evaluate(unit, blackboard, scratchpad, dt, t, evaluate_utility, node_data, old_running_child_nodes, new_running_child_nodes, last_leaf_node_running)

		if leaf_node then
			new_running_child_nodes[node_identifier] = node_follow

			return leaf_node
		end
	end

	local node_rest = children[6]
	local leaf_node = node_rest:evaluate(unit, blackboard, scratchpad, dt, t, evaluate_utility, node_data, old_running_child_nodes, new_running_child_nodes, last_leaf_node_running)

	if leaf_node then
		new_running_child_nodes[node_identifier] = node_rest

		return leaf_node
	end
end

function BtCompanionDogSelectorNode:run(unit, breed, blackboard, scratchpad, action_data, dt, t, node_data, running_child_nodes)
	local node_identifier = self.identifier
	local running_node = running_child_nodes[node_identifier]
	local running_tree_node = running_node.tree_node
	local running_action_data = running_tree_node.action_data
	local result, evaluate_utility_next_frame = running_node:run(unit, breed, blackboard, scratchpad, running_action_data, dt, t, node_data, running_child_nodes)

	return result, evaluate_utility_next_frame
end

return BtCompanionDogSelectorNode
