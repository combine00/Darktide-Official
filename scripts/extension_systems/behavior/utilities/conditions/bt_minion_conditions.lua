local AttackIntensity = require("scripts/utilities/attack_intensity")
local NavQueries = require("scripts/utilities/nav_queries")
local CompanionFollowUtility = require("scripts/utilities/companion_follow_utility")
local conditions = {
	has_target_unit = function (unit, blackboard, scratchpad, condition_args, action_data, is_running)
		local perception_component = blackboard.perception

		if not is_running and perception_component.lock_target then
			return false
		end

		local target_unit = perception_component.target_unit

		return HEALTH_ALIVE[target_unit]
	end,
	is_dead = function (unit, blackboard, scratchpad, condition_args, action_data, is_running)
		local death_component = blackboard.death
		local is_dead = death_component.is_dead

		return is_dead
	end,
	is_in_cover = function (unit, blackboard, scratchpad, condition_args, action_data, is_running)
		local cover_component = blackboard.cover
		local is_in_cover = cover_component.is_in_cover

		return is_in_cover
	end
}

function conditions.is_alerted(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local has_target_unit = conditions.has_target_unit(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not has_target_unit then
		return false
	end

	local perception_component = blackboard.perception
	local is_alerted_aggro_state = perception_component.aggro_state == "alerted"

	return is_alerted_aggro_state
end

function conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local has_target_unit = conditions.has_target_unit(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not has_target_unit then
		return false
	end

	local perception_component = blackboard.perception
	local is_aggroed = perception_component.aggro_state == "aggroed"

	return is_aggroed
end

function conditions.has_cover(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior
	local combat_range = behavior_component.combat_range
	local combat_ranges = condition_args.combat_ranges

	if not combat_ranges[combat_range] then
		return false
	end

	local cover_component = blackboard.cover
	local has_cover = cover_component.has_cover

	return has_cover
end

function conditions.has_cover_no_aggro_requirement(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local combat_range = behavior_component.combat_range
	local combat_ranges = condition_args.combat_ranges

	if not combat_ranges[combat_range] then
		return false
	end

	local cover_component = blackboard.cover
	local has_cover = cover_component.has_cover

	return has_cover
end

function conditions.is_aggroed_in_combat_range(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior
	local combat_range = behavior_component.combat_range
	local condition_combat_ranges = condition_args.combat_ranges

	return condition_combat_ranges[combat_range]
end

function conditions.should_switch_weapon(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local weapon_switch_component = blackboard.weapon_switch
	local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
	local wanted_weapon_slot = weapon_switch_component.wanted_weapon_slot
	local wielded_slot_name = visual_loadout_extension:wielded_slot_name()

	if scratchpad.is_switching_weapons or wanted_weapon_slot ~= "unarmed" and wanted_weapon_slot ~= wielded_slot_name then
		return true
	end
end

function conditions.is_exiting_spawner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local spawn_component = blackboard.spawn

	return spawn_component.is_exiting_spawner
end

function conditions.at_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_id = nav_smart_object_component.id
	local smart_object_is_next = smart_object_id ~= -1

	if not smart_object_is_next then
		return false
	end

	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	local is_smart_objecting = navigation_extension:is_using_smart_object()

	if is_smart_objecting then
		return true
	end

	local smart_object_unit = nav_smart_object_component.unit

	if not ALIVE[smart_object_unit] then
		return false
	end

	local nav_graph_extension = ScriptUnit.extension(smart_object_unit, "nav_graph_system")
	local nav_graph_added = nav_graph_extension:nav_graph_added(smart_object_id)

	if not nav_graph_added then
		return false
	end

	local behavior_component = blackboard.behavior
	local is_in_moving_state = behavior_component.move_state == "moving"
	local entrance_is_at_bot_progress_on_path = nav_smart_object_component.entrance_is_at_bot_progress_on_path

	return is_in_moving_state and entrance_is_at_bot_progress_on_path
end

function conditions.at_teleport_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_type = nav_smart_object_component.type
	local is_smart_object_teleporter = smart_object_type == "teleporters"

	return is_smart_object_teleporter
end

function conditions.at_jump_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_type = nav_smart_object_component.type
	local is_smart_object_jump = smart_object_type == "jumps" or smart_object_type == "cover_vaults"

	return is_smart_object_jump
end

function conditions.at_smashable_obstacle_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_type = nav_smart_object_component.type

	if smart_object_type == "monster_walls" then
		local wall_unit = nav_smart_object_component.unit

		return HEALTH_ALIVE[wall_unit]
	elseif smart_object_type == "doors" then
		local door_unit = nav_smart_object_component.unit
		local door_extension = ScriptUnit.extension(door_unit, "door_system")

		if not door_extension:can_attack() then
			return false
		end

		local health_extension = ScriptUnit.has_extension(door_unit, "health_system")

		return health_extension ~= nil
	else
		return false
	end
end

function conditions.at_door_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_type = nav_smart_object_component.type
	local is_smart_object_door = smart_object_type == "doors"

	if not is_smart_object_door then
		return false
	end

	local door_unit = nav_smart_object_component.unit
	local door_extension = ScriptUnit.extension(door_unit, "door_system")
	local num_attackers = door_extension:num_attackers()

	return num_attackers <= 0
end

function conditions.at_climb_smart_object(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local nav_smart_object_component = blackboard.nav_smart_object
	local smart_object_type = nav_smart_object_component.type
	local is_smart_object_ledge = smart_object_type == "ledges" or smart_object_type == "ledges_with_fence" or smart_object_type == "cover_ledges"

	return is_smart_object_ledge
end

function conditions.attack_allowed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	if is_running then
		return true
	end

	local target_unit = perception_component.target_unit
	local attack_allowed = AttackIntensity.minion_can_attack(unit, condition_args.attack_type, target_unit)

	return attack_allowed
end

function conditions.attack_not_allowed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	local target_unit = perception_component.target_unit
	local attack_allowed = AttackIntensity.minion_can_attack(unit, condition_args.attack_type, target_unit)

	return not attack_allowed
end

function conditions.moving_attack_allowed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	local has_path = navigation_extension:has_path()

	if not has_path then
		return false
	end

	local min_needed_path_distance = 5
	local has_upcoming_smart_object, _ = navigation_extension:path_distance_to_next_smart_object(min_needed_path_distance)

	if has_upcoming_smart_object then
		return false
	end

	if is_running then
		return true
	end

	local slot_component = blackboard.slot
	local has_slot = slot_component.has_slot and not slot_component.has_ghost_slot

	if not has_slot then
		return false
	end

	local behavior_component = blackboard.behavior
	local move_state = behavior_component.move_state
	local is_following_path = navigation_extension:is_following_path()

	if move_state ~= "moving" or not is_following_path then
		return false
	end

	if condition_args and condition_args.attack_type then
		local target_unit = perception_component.target_unit
		local attack_allowed = AttackIntensity.minion_can_attack(unit, condition_args.attack_type, target_unit)

		return attack_allowed
	else
		return true
	end
end

function conditions.not_assaulting(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if scratchpad.is_assaulting then
		return false
	end

	return true
end

function conditions.should_run_stop_and_shoot(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	if not is_running or not scratchpad.is_anim_driven then
		local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
		local is_following_path = navigation_extension:is_following_path()

		if not is_following_path then
			return false
		end

		local min_needed_path_distance = action_data.move_distance
		local has_upcoming_smart_object, _ = navigation_extension:path_distance_to_next_smart_object(min_needed_path_distance)

		if has_upcoming_smart_object then
			return false
		end

		local remaining_path_distance = navigation_extension:remaining_distance_from_progress_to_end_of_path()

		if remaining_path_distance <= min_needed_path_distance then
			return false
		end
	end

	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local move_state = behavior_component.move_state

	if move_state ~= "moving" then
		return false
	end

	local target_unit = perception_component.target_unit
	local attack_allowed = AttackIntensity.minion_can_attack(unit, "ranged", target_unit)

	if not attack_allowed then
		return false
	end

	local enter_combat_range_flag = behavior_component.enter_combat_range_flag

	return enter_combat_range_flag
end

function conditions.should_strafe_shoot(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	local is_following_path = navigation_extension:is_following_path()

	if not is_following_path then
		return false
	end

	local min_needed_path_distance = 5
	local has_upcoming_smart_object, _ = navigation_extension:path_distance_to_next_smart_object(min_needed_path_distance)

	if has_upcoming_smart_object then
		return false
	end

	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local move_state = behavior_component.move_state

	return move_state == "moving"
end

function conditions.should_step_shoot(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	local is_on_wait_time = navigation_extension:is_on_wait_time()

	if is_on_wait_time then
		return false
	end

	if is_running then
		return true
	end

	local target_unit = perception_component.target_unit
	local attack_allowed = AttackIntensity.minion_can_attack(unit, condition_args.attack_type, target_unit)

	return attack_allowed
end

function conditions.is_suppressed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local suppression_component = blackboard.suppression
	local is_suppressed = suppression_component.is_suppressed

	return is_suppressed
end

function conditions.is_not_suppressed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local suppression_component = blackboard.suppression
	local is_suppressed = suppression_component.is_suppressed

	return not is_suppressed
end

function conditions.is_staggered(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local stagger_component = blackboard.stagger
	local is_staggered = stagger_component.num_triggered_staggers > 0

	return is_staggered
end

function conditions.is_blocked(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local blocked_component = blackboard.blocked
	local is_blocked = blocked_component.is_blocked

	return is_blocked
end

function conditions.should_use_combat_idle(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local slot_component = blackboard.slot
	local is_waiting_on_slot = slot_component.is_waiting_on_slot

	if is_waiting_on_slot then
		local navigation_extension = ScriptUnit.extension(unit, "navigation_system")
		local has_reached_destination = navigation_extension:has_reached_destination()

		return has_reached_destination
	end
end

function conditions.has_pounce_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local has_pounce_target = ALIVE[pounce_component.pounce_target]

	return has_pounce_target
end

function conditions.has_clear_shot(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local line_of_sight_id = action_data.clear_shot_line_of_sight_id
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local has_clear_shot = perception_extension:has_line_of_sight_by_id(target_unit, line_of_sight_id)

	return has_clear_shot
end

function conditions.dont_have_clear_shot(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local line_of_sight_id = action_data.line_of_sight_id
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local has_clear_shot = perception_extension:has_line_of_sight_by_id(target_unit, line_of_sight_id)

	return not has_clear_shot
end

function conditions.can_shoot_net(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local shoot_net_cooldown = behavior_component.shoot_net_cooldown
	local t = Managers.time:time("gameplay")

	if t < shoot_net_cooldown then
		return false
	end

	return behavior_component.net_is_ready
end

function conditions.netgunner_is_on_cooldown(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local shoot_net_cooldown = behavior_component.shoot_net_cooldown
	local t = Managers.time:time("gameplay")

	return t < shoot_net_cooldown
end

function conditions.netgunner_hit_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local hit_target = behavior_component.hit_target

	return hit_target
end

function conditions.daemonhost_can_warp_grab(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return
	end

	if is_running then
		return true
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local target_breed = target_unit_data_extension:breed()
	local Breed = require("scripts/utilities/breed")

	if not Breed.is_player(target_breed) then
		return false
	end

	local unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local character_state_component = unit_data_extension:read_component("character_state")
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local is_knocked_down = PlayerUnitStatus.is_knocked_down(character_state_component)
	local hit_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local disabled_state_input = hit_unit_data_extension:read_component("disabled_state_input")
	local is_disabled_by_this_deamonhost = disabled_state_input.disabling_unit == unit

	return is_knocked_down or is_disabled_by_this_deamonhost
end

function conditions.chaos_hound_is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce

	return is_aggroed or pounce_component.started_leap
end

function conditions.chaos_hound_can_pounce(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local pounce_cooldown = pounce_component.pounce_cooldown
	local t = Managers.time:time("gameplay")

	return pounce_cooldown <= t
end

function conditions.chaos_hound_pounce_is_on_cooldown(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local pounce_cooldown = pounce_component.pounce_cooldown
	local t = Managers.time:time("gameplay")

	return t <= pounce_cooldown
end

function conditions.can_throw_grenade(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.throw_grenade
	local next_throw_at_t = behavior_component.next_throw_at_t
	local t = Managers.time:time("gameplay")

	return next_throw_at_t <= t
end

function conditions.slot_not_wielded(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
	local wielded_slot_name = visual_loadout_extension:wielded_slot_name()
	local wanted_slot_name = condition_args.slot_name

	return wielded_slot_name ~= wanted_slot_name
end

function conditions.slot_wielded(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
	local wielded_slot_name = visual_loadout_extension:wielded_slot_name()
	local wanted_slot_name = condition_args.slot_name

	return wielded_slot_name == wanted_slot_name
end

function conditions.daemonhost_wants_to_leave(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local statistics_component = blackboard.statistics
	local player_deaths = statistics_component.player_deaths
	local ChaosDaemonhostSettings = require("scripts/settings/monster/chaos_daemonhost_settings")
	local num_player_kills_for_despawn = Managers.state.difficulty:get_table_entry_by_challenge(ChaosDaemonhostSettings.num_player_kills_for_despawn)
	local wants_to_leave = num_player_kills_for_despawn <= player_deaths

	return wants_to_leave
end

local MUTATOR_DAEMONHOST_NUM_FOR_DESPAWN = {
	1,
	1,
	1,
	2,
	3
}

function conditions.mutator_daemonhost_wants_to_leave(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local statistics_component = blackboard.statistics
	local player_deaths = statistics_component.player_deaths
	local ChaosDaemonhostSettings = require("scripts/settings/monster/chaos_daemonhost_settings")
	local num_player_kills_for_despawn = Managers.state.difficulty:get_table_entry_by_challenge(ChaosDaemonhostSettings.mutator_num_player_kills_for_despawn)
	local wants_to_leave = num_player_kills_for_despawn <= player_deaths

	return wants_to_leave
end

function conditions.daemonhost_is_passive(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception
	local aggro_state = perception_component.aggro_state
	local should_be_passive = aggro_state == "alerted" or aggro_state == "passive"

	return should_be_passive
end

function conditions.daemonhost_can_warp_sweep(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local t = Managers.time:time("gameplay")

	if t < behavior_component.warp_sweep_cooldown then
		return false
	end

	local num_nearby_units_threshold = action_data.num_nearby_units_threshold
	local broadphase_component = blackboard.nearby_units_broadphase
	local num_broadphase_units = broadphase_component.num_units

	return num_nearby_units_threshold <= num_broadphase_units
end

function conditions.target_changed_and_valid(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local perception_component = blackboard.perception

	if perception_component.target_changed then
		local new_target_unit = perception_component.target_unit

		return new_target_unit and ALIVE[new_target_unit]
	end

	return false
end

function conditions.is_aggroed_in_combat_range_or_running(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local combat_range = behavior_component.combat_range
	local condition_combat_ranges = condition_args.combat_ranges

	return condition_combat_ranges[combat_range]
end

function conditions.should_patrol(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local has_target_unit = conditions.has_target_unit(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if has_target_unit then
		return false
	end

	local patrol_component = blackboard.patrol
	local should_patrol = patrol_component.should_patrol
	local perception_component = blackboard.perception
	local aggro_state = perception_component.aggro_state
	local is_passive = aggro_state == "passive"

	return is_passive and should_patrol
end

function conditions.is_passive(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception
	local aggro_state = perception_component.aggro_state
	local is_passive = aggro_state == "passive"

	return is_passive
end

function conditions.can_summon_minions(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local summoned_minions_extension = ScriptUnit.extension(unit, "summon_minions_system")
	local result = summoned_minions_extension:can_summon_minions(action_data, is_running)

	return result
end

function conditions.can_summon_timer_only(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local summon_component = blackboard.summon
	local next_summon_t = summon_component.next_summon_t
	local t = Managers.time:time("gameplay")

	if next_summon_t < t then
		return true
	else
		return false
	end
end

function conditions.captain_can_use_special_actions(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local captain_can_use_special_action = not scratchpad.is_blocking_captain_special_actions

	return captain_can_use_special_action
end

function conditions.beast_of_nurgle_has_consume_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local has_target_unit = conditions.has_target_unit(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not has_target_unit then
		return false
	end

	local behavior_component = blackboard.behavior
	local scratchpad_consumed_unit = scratchpad.consumed_unit

	if HEALTH_ALIVE[scratchpad_consumed_unit] then
		return true
	end

	local consumed_unit = behavior_component.consumed_unit

	if HEALTH_ALIVE[consumed_unit] then
		return false
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local target_breed = target_unit_data_extension:breed()
	local Breed = require("scripts/utilities/breed")

	if not Breed.is_player(target_breed) then
		return false
	end

	local character_state_component = target_unit_data_extension:read_component("character_state")
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local is_disabled = PlayerUnitStatus.is_disabled(character_state_component)

	if is_disabled then
		return false
	end

	local buff_extension = ScriptUnit.extension(target_unit, "buff_system")
	local vomit_buff_name = "chaos_beast_of_nurgle_hit_by_vomit"
	local current_stacks = buff_extension:current_stacks(vomit_buff_name)
	local wants_to_eat = behavior_component.wants_to_eat

	return current_stacks == 3 or wants_to_eat
end

function conditions.beast_of_nurgle_can_consume_minion(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local t = Managers.time:time("gameplay")

	if t < behavior_component.consume_minion_cooldown then
		return false
	end

	local health_extension = ScriptUnit.extension(unit, "health_system")
	local current_health_percent = health_extension:current_health_percent()

	if action_data.health_percent_threshold < current_health_percent then
		return false
	end

	local num_nearby_units_threshold = action_data.num_nearby_units_threshold
	local broadphase_component = blackboard.nearby_units_broadphase
	local num_broadphase_units = broadphase_component.num_units

	return num_nearby_units_threshold <= num_broadphase_units
end

function conditions.beast_of_nurgle_should_vomit(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local vomit_cooldown = behavior_component.vomit_cooldown
	local t = Managers.time:time("gameplay")

	if t < vomit_cooldown then
		return false
	end

	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local perception_component = blackboard.perception

	if not perception_component.has_line_of_sight then
		return false
	end

	local target_unit = perception_component.target_unit
	local line_of_sight_id = "vomit"
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local has_clear_shot = perception_extension:has_line_of_sight_by_id(target_unit, line_of_sight_id)

	if not has_clear_shot then
		return false
	end

	local target_distance_z = perception_component.target_distance_z

	if target_distance_z >= 3 then
		return false
	end

	local target_distance = perception_component.target_distance
	local wanted_distance = condition_args.wanted_distance

	if wanted_distance < target_distance then
		return false
	end

	local consumed_unit = behavior_component.consumed_unit

	if HEALTH_ALIVE[consumed_unit] and target_unit == consumed_unit then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_has_spit_out_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior
	local consumed_unit = behavior_component.consumed_unit

	if not HEALTH_ALIVE[consumed_unit] then
		return false
	end

	if is_running then
		return true
	end

	if behavior_component.force_spit_out then
		return true
	end

	local health_extension = ScriptUnit.extension(consumed_unit, "health_system")
	local permanent_damage_taken_percent = health_extension:permanent_damage_taken_percent()
	local required_permanent_damage_taken_percent = Managers.state.difficulty:get_table_entry_by_challenge(action_data.required_permanent_damage_taken_percent)

	if permanent_damage_taken_percent < required_permanent_damage_taken_percent then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_can_melee(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local melee_cooldown = behavior_component.melee_cooldown
	local t = Managers.time:time("gameplay")

	if t < melee_cooldown then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_can_aoe_melee(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local melee_aoe_cooldown = behavior_component.melee_aoe_cooldown
	local t = Managers.time:time("gameplay")

	if t < melee_aoe_cooldown then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_can_vomit(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local vomit_cooldown = behavior_component.vomit_cooldown
	local t = Managers.time:time("gameplay")

	if t < vomit_cooldown then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_melee_tail_whip(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local side_system = Managers.state.extension:system("side_system")
	local side = side_system.side_by_unit[unit]
	local target_units = side.ai_target_units
	local num_valid_target_units = #target_units
	local position = POSITION_LOOKUP[unit]
	local fwd = Quaternion.forward(Unit.local_rotation(unit, 1))
	local radius = action_data.radius
	local has_valid_target = false
	local behavior_component = blackboard.behavior
	local consumed_unit = behavior_component.consumed_unit
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local Breed = require("scripts/utilities/breed")
	local target_unit = blackboard.perception.target_unit

	for i = 1, num_valid_target_units do
		local player_unit = target_units[i]

		if HEALTH_ALIVE[player_unit] and player_unit ~= consumed_unit and (ALIVE[consumed_unit] or player_unit ~= target_unit) then
			local has_line_of_sight_to_target = perception_extension:has_line_of_sight(player_unit)

			if has_line_of_sight_to_target then
				local target_unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
				local character_state_component = Breed.is_player(target_unit_data_extension:breed()) and target_unit_data_extension:read_component("character_state")
				local is_disabled = character_state_component and PlayerUnitStatus.is_disabled(character_state_component)

				if not is_disabled then
					local player_position = POSITION_LOOKUP[player_unit]
					local distance = Vector3.distance(position, player_position)

					if distance <= radius then
						local to_player = Vector3.normalize(Vector3.flat(player_position - position))
						local dot = Vector3.dot(fwd, to_player)
						local is_to_the_left = Vector3.cross(fwd, to_player).z > 0

						if condition_args.check_fwd_left then
							if dot >= 0.6 and dot < 0.9 and is_to_the_left then
								has_valid_target = true

								break
							end
						elseif condition_args.check_fwd_right then
							if dot >= 0.6 and dot < 0.9 and not is_to_the_left then
								has_valid_target = true

								break
							end
						elseif condition_args.check_bwd then
							if dot < -0.8 then
								has_valid_target = true

								break
							end
						elseif condition_args.check_right then
							if dot < 0.6 and not is_to_the_left then
								has_valid_target = true

								break
							end
						elseif condition_args.check_left and dot < 0.6 and is_to_the_left then
							has_valid_target = true

							break
						end
					end
				end
			end
		end
	end

	return has_valid_target
end

function conditions.beast_of_nurgle_wants_to_run_away(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior
	local consumed_unit = behavior_component.consumed_unit

	if not HEALTH_ALIVE[consumed_unit] then
		return false
	end

	local health_extension = ScriptUnit.extension(consumed_unit, "health_system")
	local permanent_damage_taken_percent = health_extension:permanent_damage_taken_percent()
	local required_permanent_damage_taken_percent = Managers.state.difficulty:get_table_entry_by_challenge(action_data.required_permanent_damage_taken_percent)

	if required_permanent_damage_taken_percent <= permanent_damage_taken_percent then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_melee_body_slam_aoe(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local melee_aoe_cooldown = behavior_component.melee_aoe_cooldown
	local t = Managers.time:time("gameplay")

	if t < melee_aoe_cooldown then
		return false
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local buff_extension = ScriptUnit.extension(target_unit, "buff_system")
	local vomit_buff_name = "chaos_beast_of_nurgle_hit_by_vomit"
	local target_is_vomited = buff_extension:current_stacks(vomit_buff_name) > 0

	if target_is_vomited then
		return false
	end

	local target_side_id = 1
	local side_system = Managers.state.extension:system("side_system")
	local side = side_system:get_side(target_side_id)
	local target_units = side.valid_player_units
	local num_valid_target_units = #target_units
	local position = POSITION_LOOKUP[unit]
	local radius = action_data.radius
	local consumed_unit = behavior_component.consumed_unit
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local num_close_players = 0
	local has_very_close_player = false

	for i = 1, num_valid_target_units do
		local player_unit = target_units[i]

		if HEALTH_ALIVE[player_unit] and player_unit ~= consumed_unit then
			local has_line_of_sight_to_target = perception_extension:has_line_of_sight(player_unit)

			if has_line_of_sight_to_target then
				local target_unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
				local character_state_component = target_unit_data_extension:read_component("character_state")
				local is_disabled = PlayerUnitStatus.is_disabled(character_state_component)

				if not is_disabled then
					local player_position = POSITION_LOOKUP[player_unit]
					local distance = Vector3.distance(position, player_position)

					if player_unit ~= target_unit and distance < action_data.very_close_distance then
						has_very_close_player = true

						break
					end

					if distance <= radius then
						num_close_players = num_close_players + 1
					end
				end
			end
		end
	end

	return has_very_close_player or num_close_players >= 2
end

function conditions.beast_of_nurgle_should_eat(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local perception_component = blackboard.perception
	local target_is_close = perception_component.target_distance < 5

	if not target_is_close then
		return false
	end

	local behavior_component = blackboard.behavior
	local cooldown = behavior_component.consume_cooldown
	local t = Managers.time:time("gameplay")

	if t < cooldown then
		return false
	end

	local target_unit = perception_component.target_unit
	local buff_extension = ScriptUnit.extension(target_unit, "buff_system")
	local vomit_buff_name = "chaos_beast_of_nurgle_hit_by_vomit"
	local current_stacks = buff_extension:current_stacks(vomit_buff_name)

	if current_stacks == 0 then
		return false
	end

	return true
end

function conditions.beast_of_nurgle_wants_to_play_change_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local perception_component = blackboard.perception

	if perception_component.target_changed then
		local new_target_unit = perception_component.target_unit
		local target_is_close = perception_component.target_distance < 5.25

		return new_target_unit and ALIVE[new_target_unit] and not target_is_close
	end

	return false
end

function conditions.beast_of_nurgle_wants_to_play_alerted(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local perception_component = blackboard.perception
	local behavior_component = blackboard.behavior
	local target_is_close = perception_component.target_distance < 5.25

	return behavior_component.wants_to_play_alerted and not target_is_close
end

function conditions.beast_of_nurgle_normal_stagger(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local stagger_component = blackboard.stagger
	local is_staggered = stagger_component.num_triggered_staggers > 0 and stagger_component.type == "explosion"

	return is_staggered
end

function conditions.beast_of_nurgle_weakspot_stagger(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local consumed_unit = behavior_component.consumed_unit

	if not HEALTH_ALIVE[consumed_unit] or ALIVE[scratchpad.consumed_unit] then
		return false
	end

	local stagger_component = blackboard.stagger
	local is_staggered = stagger_component.num_triggered_staggers > 0 and stagger_component.type == "heavy"

	return is_staggered
end

function conditions.beast_of_nurgle_movement(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local perception_component = blackboard.perception
	local target_is_far_away = perception_component.target_distance > 3.5

	if target_is_far_away then
		return true
	end

	local target_unit = perception_component.target_unit
	local buff_extension = ScriptUnit.extension(target_unit, "buff_system")
	local vomit_buff_name = "chaos_beast_of_nurgle_hit_by_vomit"
	local target_is_vomited = buff_extension:current_stacks(vomit_buff_name) > 0

	if target_is_vomited then
		return true
	end

	return false
end

function conditions.chaos_spawn_should_leap(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit

	if not is_running and (behavior_component.move_state == "attacking" or not HEALTH_ALIVE[target_unit]) then
		return false
	end

	return behavior_component.should_leap
end

function conditions.chaos_spawn_should_grab(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local t = Managers.time:time("gameplay")
	local behavior_component = blackboard.behavior

	if t < behavior_component.grab_cooldown then
		return false
	end

	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local target_breed = target_unit_data_extension:breed()
	local Breed = require("scripts/utilities/breed")

	if not Breed.is_player(target_breed) then
		return false
	end

	local character_state_component = target_unit_data_extension:read_component("character_state")
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local is_knocked_down = PlayerUnitStatus.is_knocked_down(character_state_component)

	if is_knocked_down then
		return false
	end

	if is_running then
		return true
	end

	local is_disabled = PlayerUnitStatus.is_disabled(character_state_component)

	if is_disabled then
		local disabled_state_input = target_unit_data_extension:read_component("disabled_state_input")
		local disabled_by_this_chaos_spawn = disabled_state_input.disabling_unit and disabled_state_input.disabling_unit == unit

		if disabled_by_this_chaos_spawn then
			return true
		else
			return false
		end
	end

	return true
end

function conditions.chaos_spawn_target_changed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	if is_running then
		return true
	end

	local perception_component = blackboard.perception

	return perception_component.target_changed
end

function conditions.chaos_spawn_target_changed_close(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local perception_component = blackboard.perception

	if perception_component.target_changed then
		local new_target_unit = perception_component.target_unit

		return new_target_unit and ALIVE[new_target_unit] and perception_component.target_distance < 8
	end

	return false
end

function conditions.poxwalker_bomber_is_dead(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local death_component = blackboard.death
	local is_dead = death_component.is_dead

	if is_dead then
		return true
	end

	local fuse_timer = death_component.fuse_timer
	local t = Managers.time:time("gameplay")

	if fuse_timer > 0 and fuse_timer <= t then
		return true
	end

	return false
end

function conditions.has_move_to_position(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior
	local has_move_to_position = behavior_component.has_move_to_position

	return has_move_to_position
end

function conditions.renegade_twin_captain_shield_down_recharge(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	if is_running then
		return true
	end

	local behavior_component = blackboard.behavior
	local toughness_broke = behavior_component.toughness_broke

	return toughness_broke
end

function conditions.twin_captain_void_shield_explosion(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local toughness_extension = ScriptUnit.has_extension(unit, "toughness_system")

	return toughness_extension:current_toughness_percent() > 0
end

function conditions.twin_captain_disappear_idle(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local behavior_component = blackboard.behavior

	return behavior_component.disappear_idle
end

function conditions.renegade_twin_captain_should_disappear(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local should_disappear = behavior_component.should_disappear

	return should_disappear
end

function conditions.renegade_twin_captain_should_disappear_instant(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local should_disappear_instant = behavior_component.should_disappear_instant

	return should_disappear_instant
end

function conditions.is_empowered(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

	if buff_extension and buff_extension:has_keyword("empowered") then
		return true
	end

	return false
end

function conditions.has_combat_vector_position(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local combat_vector_component = blackboard.combat_vector
	local has_combat_vector_position = combat_vector_component.has_position

	return has_combat_vector_position
end

function conditions.has_last_los_pos(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local perception_component = blackboard.perception
	local target_unit = perception_component.target_unit
	local perception_extension = ScriptUnit.extension(unit, "perception_system")
	local last_los_postion = perception_extension:last_los_position(target_unit)

	return last_los_postion ~= nil
end

function conditions.berzerker_leap_attack_allowed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not is_aggroed then
		return false
	end

	local perception_component = blackboard.perception

	if not is_running and perception_component.lock_target then
		return false
	end

	if is_running then
		return true
	end

	local AttackIntensity = require("scripts/utilities/attack_intensity")
	local target_unit = perception_component.target_unit
	local attack_allowed = AttackIntensity.minion_can_attack(unit, condition_args.attack_type, target_unit)

	return attack_allowed
end

function conditions.is_minion_disabled(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local disable_component = blackboard.disable

	return disable_component.is_disabled
end

function conditions.has_manual_teleport(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local teleport_component = blackboard.teleport

	return teleport_component.has_teleport_position
end

function conditions.owner_is_moving(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
	local owner_speed = Vector3.length(Vector3.flat(owner_locomotion_extension:current_velocity()))

	return owner_speed > 0.05
end

function conditions.should_companion_moving(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_position = POSITION_LOOKUP[owner_unit]
	local current_state = behavior_component.current_state
	local outer_circle_distance = action_data.idle_circle_distances.outer_circle_distance
	local inner_circle_distance = action_data.idle_circle_distances.inner_circle_distance
	local companion_position = POSITION_LOOKUP[unit]
	local companion_owner_vector = Vector3.flat(companion_position - owner_position)
	local distance_from_owner = Vector3.length(companion_owner_vector)
	local is_owner_moving = conditions.owner_is_moving(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
	local owner_speed_normalized = Vector3.normalize(Vector3.flat(owner_locomotion_extension:current_velocity()))
	local companion_owner_vector_normalized = Vector3.normalize(companion_owner_vector)
	local cos = Vector3.dot(companion_owner_vector_normalized, owner_speed_normalized)
	local far_distance = action_data.far_distance
	local cone_cos = action_data.cone_angle and math.cos(action_data.cone_angle * 0.5) or math.huge
	local far_distance_check = not far_distance or far_distance < distance_from_owner or cos < cone_cos

	return is_owner_moving and (current_state == "follow" or outer_circle_distance < distance_from_owner and far_distance_check)
end

function conditions.should_companion_idle(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_position = POSITION_LOOKUP[owner_unit]
	local inner_circle_distance = action_data.inner_circle_distance
	local outer_circle_distance = action_data.outer_circle_distance
	local companion_position = POSITION_LOOKUP[unit]
	local companion_owner_vector = Vector3.flat(companion_position - owner_position)
	local distance_from_owner = Vector3.length(companion_owner_vector)

	return inner_circle_distance <= distance_from_owner and distance_from_owner <= outer_circle_distance
end

function conditions.should_move_close_to_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_position = POSITION_LOOKUP[owner_unit]
	local far_distance = action_data.far_distance
	local close_distance = action_data.close_distance
	local companion_position = POSITION_LOOKUP[unit]
	local companion_owner_vector = Vector3.flat(companion_position - owner_position)
	local distance_from_owner = Vector3.length(companion_owner_vector)

	if not behavior_component.has_move_to_position and (distance_from_owner < close_distance or far_distance < distance_from_owner) then
		local companion_cone_check = action_data.companion_cone_check
		local is_inside_cone = true

		if companion_cone_check then
			local owner_locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")
			local owner_velocity = Vector3.normalize(Vector3.flat(owner_locomotion_extension:current_velocity()))
			companion_owner_vector = Vector3.normalize(companion_owner_vector)
			local dot_product = Vector3.dot(owner_velocity, companion_owner_vector)
			local cone_cos = math.cos(math.degrees_to_radians(companion_cone_check.angle * 0.5))
			is_inside_cone = cone_cos <= dot_product
		end

		local companion_has_position_around_owner = false

		if is_inside_cone then
			local CompanionFollowUtility = require("scripts/utilities/companion_follow_utility")
			companion_has_position_around_owner = CompanionFollowUtility.companion_has_position_around_owner(unit, blackboard, scratchpad, condition_args, action_data, is_running)
		end

		return companion_has_position_around_owner
	end

	return behavior_component.has_move_to_position
end

function conditions.companion_has_move_position(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local CompanionFollowUtility = require("scripts/utilities/companion_follow_utility")
	local companion_has_found_follow_position = CompanionFollowUtility.companion_has_follow_position(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	if not companion_has_found_follow_position and is_running then
		local behavior_component = blackboard.behavior
		local has_move_to_position = behavior_component.has_move_to_position

		return has_move_to_position
	end

	return companion_has_found_follow_position
end

function conditions.should_reposition_for_hub_interaction(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local hub_interaction_component = blackboard.hub_interaction_with_player

	return hub_interaction_component.has_owner_started_interaction
end

function conditions.is_correct_pounce_action(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local pounce_target = pounce_component.pounce_target

	if not pounce_target or not HEALTH_ALIVE[pounce_target] then
		return false
	end

	local target_unit_data_extension = ScriptUnit.extension(pounce_target, "unit_data_system")
	local target_unit_breed = target_unit_data_extension:breed()
	local companion_pounce_setting = target_unit_breed.companion_pounce_setting

	return companion_pounce_setting.companion_pounce_action == condition_args.pounce_action
end

function conditions.companion_has_pounce_target(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce

	return pounce_component.has_pounce_target
end

function conditions.companion_can_pounce(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local pounce_cooldown = pounce_component.pounce_cooldown
	local t = Managers.time:time("gameplay")

	return pounce_cooldown <= t
end

function conditions.companion_has_jump_off_direction(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce

	return pounce_component.has_jump_off_direction
end

function conditions.companion_has_pounce_target_and_alive(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local pounce_component = blackboard.pounce
	local is_pounce_target_alive = HEALTH_ALIVE[pounce_component.pounce_target]
	local has_blackboard_target = true

	if is_pounce_target_alive then
		local target_blackboard = BLACKBOARDS[pounce_component.pounce_target]
		has_blackboard_target = target_blackboard ~= nil
	end

	local companion_has_jump_off_direction = conditions.companion_has_jump_off_direction(unit, blackboard, scratchpad, condition_args, action_data, is_running)

	return companion_has_jump_off_direction and (is_pounce_target_alive and has_blackboard_target or pounce_component.has_pounce_started)
end

function conditions.companion_is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local is_aggroed = conditions.is_aggroed(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	local behavior_component = blackboard.behavior
	local owner_unit = behavior_component.owner_unit
	local owner_attack_intensity_extension = ScriptUnit.has_extension(owner_unit, "attack_intensity_system")
	local in_combat = not owner_attack_intensity_extension or owner_attack_intensity_extension:in_combat_for_companion()
	local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
	local owner_unit_data_extension = ScriptUnit.has_extension(owner_unit, "unit_data_system")
	local character_state = owner_unit_data_extension and owner_unit_data_extension:read_component("character_state")
	local owner_unit_is_disabled = character_state and PlayerUnitStatus.is_disabled(character_state)
	in_combat = in_combat or owner_unit_is_disabled
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

	return is_aggroed and (in_combat or force_combat) or pounce_component.started_leap or pounce_component.has_pounce_target
end

function conditions.companion_is_on_platform(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	return blackboard.movable_platform.unit_reference ~= nil
end

function conditions.companion_is_out_of_bound(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	return blackboard.behavior.is_out_of_bound
end

function conditions.companion_has_owner_unit(unit, blackboard, scratchpad, condition_args, action_data, is_running)
	return blackboard.behavior.is_owner_despawned
end

return conditions
