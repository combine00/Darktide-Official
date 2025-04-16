local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local MinionMovement = require("scripts/utilities/minion_movement")
local MinionTargetSelection = require("scripts/utilities/minion_target_selection")
local PerceptionSettings = require("scripts/settings/perception/perception_settings")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")

local function _calculate_score(breed, unit, target_unit, distance_sq, is_new_target, threat_units, debug_target_weighting_or_nil)
	return 0
end

local function _is_target_aggroed(target_unit)
	local target_blackboard = BLACKBOARDS[target_unit]

	return target_blackboard.perception.aggro_state == PerceptionSettings.aggro_states.aggroed
end

local function _calculate_distances(target_unit, companion_position, owner_unit_position)
	local distance_sq_companion_target = Vector3.distance_squared(companion_position, POSITION_LOOKUP[target_unit])
	local distance_sq_owner_target = Vector3.distance_squared(owner_unit_position, POSITION_LOOKUP[target_unit])
	local distance_sq = distance_sq_companion_target + distance_sq_owner_target

	return distance_sq_companion_target, distance_sq_owner_target, distance_sq
end

local function _set_up_selected_target(unit, target_unit, companion_position, line_of_sight_lookup, perception_component, distance_sq_companion_target)
	local has_line_of_sight = line_of_sight_lookup[target_unit]
	perception_component.has_line_of_sight = has_line_of_sight
	local target_position = POSITION_LOOKUP[target_unit]
	local z_distance = math.abs(companion_position.z - target_position.z)
	perception_component.target_distance = math.sqrt(distance_sq_companion_target)
	perception_component.target_distance_z = z_distance
	perception_component.target_speed_away = MinionMovement.target_speed_away(unit, target_unit)
end

local BAD_DISTANCE = 400
local CLOSE_DISTANCE = 81
local GOOD_DISTANCE = 36
local targeting_owner_weight = 3
local special_weight = 2
local elite_weight = 2
local close_melee_weight = 3
local dot_check = 0.5
local in_dot_weight = 5

local function _get_token(target)
	local unit_data_extension = ScriptUnit.has_extension(target, "unit_data_system")
	local possible_unit_breed = unit_data_extension:breed()
	local companion_pounce_setting = possible_unit_breed.companion_pounce_setting

	return companion_pounce_setting.required_token
end

local function _check_for_token(unit, target, optional_assign_token)
	local required_token = _get_token(target)

	if required_token then
		local required_token_name = required_token.name
		local token_extension = ScriptUnit.has_extension(target, "token_system")

		if token_extension then
			if token_extension:is_token_free_or_mine(unit, required_token_name) then
				if optional_assign_token then
					token_extension:assign_token(unit, required_token_name)
				end

				return true
			else
				return not required_token.free_target_on_assigned_token
			end
		end
	end

	return true
end

local target_selection_template = {}

function target_selection_template.companion_dog(unit, side, perception_component, buff_extension, breed, target_units, line_of_sight_lookup, t, threat_units, force_new_target_attempt, force_new_target_attempt_config_or_nil, debug_target_weighting_or_nil)
	local target_unit = perception_component.target_unit
	local companion_blackboard = BLACKBOARDS[unit]
	local companion_position = POSITION_LOOKUP[unit]
	local owner_unit = companion_blackboard.behavior.owner_unit
	local owner_unit_position = POSITION_LOOKUP[owner_unit]
	local companion_whistle_component = Blackboard.write_component(companion_blackboard, "whistle")
	local smart_tag_system = Managers.state.extension:system("smart_tag_system")
	local companion_whistle_target, tag = smart_tag_system:unit_tagged_by_player_unit(owner_unit)
	local tag_template = tag and tag:template()
	local tag_type = tag_template and tag_template.marker_type

	if tag_type == "unit_threat_adamant" then
		local invalid_target = false
		local unit_data_extension = ScriptUnit.has_extension(companion_whistle_target, "unit_data_system")
		local breed = unit_data_extension and unit_data_extension:breed()
		local daemonhost = breed and breed.tags.witch

		if daemonhost then
			local daemonhost_blackboard = BLACKBOARDS[companion_whistle_target]
			local daemonhost_perception_component = daemonhost_blackboard.perception
			local is_aggroed = daemonhost_perception_component.aggro_state == "aggroed"
			invalid_target = not is_aggroed
		end

		if not invalid_target then
			companion_whistle_component.current_target = companion_whistle_target
		end
	end

	local distance_sq_companion_target = math.huge
	local distance_sq_owner_target = math.huge
	local distance_sq = math.huge

	if companion_whistle_target then
		local optional_assign_token = false

		if HEALTH_ALIVE[companion_whistle_target] and _check_for_token(unit, companion_whistle_target, optional_assign_token) then
			distance_sq_companion_target = _calculate_distances(companion_whistle_target, companion_position, owner_unit_position)

			_set_up_selected_target(unit, companion_whistle_target, companion_position, line_of_sight_lookup, perception_component, distance_sq_companion_target)

			return companion_whistle_target
		else
			companion_whistle_component = Blackboard.write_component(companion_blackboard, "whistle")
			companion_whistle_component.current_target = nil
		end
	end

	local owner_attack_intensity_extension = ScriptUnit.has_extension(owner_unit, "attack_intensity_system")
	local in_combat = not owner_attack_intensity_extension or owner_attack_intensity_extension:in_combat_for_companion()

	if not in_combat then
		return
	end

	local lock_target = perception_component.lock_target
	local pounce_target = companion_blackboard.pounce.pounce_target

	if not lock_target and not pounce_target then
		local disabling_unit = nil
		local owner_unit_data_extension = ScriptUnit.has_extension(owner_unit, "unit_data_system")

		if not owner_unit_data_extension then
			return nil
		end

		local disabled_character_state = owner_unit_data_extension:read_component("disabled_character_state")

		if PlayerUnitStatus.is_pounced(disabled_character_state) then
			disabling_unit = disabled_character_state.disabling_unit
		elseif PlayerUnitStatus.is_warp_grabbed(disabled_character_state) then
			disabling_unit = disabled_character_state.disabling_unit
		elseif PlayerUnitStatus.is_mutant_charged(disabled_character_state) then
			disabling_unit = disabled_character_state.disabling_unit
		elseif PlayerUnitStatus.is_consumed(disabled_character_state) then
			disabling_unit = disabled_character_state.disabling_unit
		elseif PlayerUnitStatus.is_grabbed(disabled_character_state) then
			disabling_unit = disabled_character_state.disabling_unit
		end

		if disabling_unit then
			distance_sq_companion_target, distance_sq_owner_target, distance_sq = _calculate_distances(disabling_unit, companion_position, owner_unit_position)

			_set_up_selected_target(unit, disabling_unit, companion_position, line_of_sight_lookup, perception_component, distance_sq_companion_target)

			return disabling_unit
		end

		local first_person_component = owner_unit_data_extension:read_component("first_person")
		local owner_rotation = first_person_component.rotation
		local owner_look_direction = Vector3.normalize(Vector3.flat(Quaternion.forward(owner_rotation)))
		local chosen_unit = nil
		local chosen_unit_weight = 0

		for i = 1, #target_units do
			repeat
				local possible_unit = target_units[i]
				local is_aggroed = _is_target_aggroed(possible_unit)
				local is_alive = HEALTH_ALIVE[possible_unit]
				local tags = possible_unit_breed.tags
				local check_dist_sq_companion_target, check_dist_sq_owner_target, check_dist_sq = _calculate_distances(possible_unit, companion_position, owner_unit_position)
				local close = check_dist_sq_owner_target < CLOSE_DISTANCE

				if tags then
					local is_special = tags.special
					local is_elite = tags.elite
					local is_melee = tags.melee
					local possible_unit_weight = possible_unit_weight * (is_special and special_weight or 1) * (is_elite and elite_weight or 1) * (is_melee and close and close_melee_weight or 1)
				end

				local possible_unit_blackboard = BLACKBOARDS[possible_unit]
				local possible_unit_perception_component = possible_unit_blackboard.perception
				local possible_unit_target_unit = possible_unit_perception_component.target_unit
				local targeting_owner = possible_unit_target_unit == owner_unit

				if targeting_owner then
					possible_unit_weight = possible_unit_weight * targeting_owner_weight
				end

				local possible_unit_position = POSITION_LOOKUP[possible_unit]
				local direction_to_possible_unit = Vector3.normalize(possible_unit_position - owner_unit_position)
				local dot = Vector3.dot(direction_to_possible_unit, owner_look_direction)
				local in_dot = dot_check < dot
				possible_unit_weight = possible_unit_weight * (in_dot and in_dot_weight or 1)
				local distance_multiplier = 1

				if BAD_DISTANCE < check_dist_sq_owner_target then
					distance_multiplier = 0
				elseif check_dist_sq_owner_target <= GOOD_DISTANCE then
					distance_multiplier = 1
				else
					distance_multiplier = math.clamp((BAD_DISTANCE - (check_dist_sq_owner_target - GOOD_DISTANCE)) / BAD_DISTANCE, 0, 1)
				end

				possible_unit_weight = possible_unit_weight * distance_multiplier
				possible_unit_weight = math.round(possible_unit_weight / 27)
				possible_unit_weight = math.max(0, possible_unit_weight)

				if chosen_unit_weight < possible_unit_weight then
					local perception_extension = ScriptUnit.has_extension(possible_unit, "perception_system")
					local has_line_of_sight = perception_extension and perception_extension:immediate_line_of_sight_check(owner_unit)

					if has_line_of_sight then
						chosen_unit = possible_unit
						chosen_unit_weight = possible_unit_weight
					elseif possible_unit == target_unit then
						local new_weight = possible_unit_weight * 0.66

						if chosen_unit_weight < new_weight then
							chosen_unit = possible_unit
							chosen_unit_weight = new_weight
						end
					end
				end
			until true
		end

		if chosen_unit then
			distance_sq_companion_target, distance_sq_owner_target, distance_sq = _calculate_distances(chosen_unit, companion_position, owner_unit_position)

			_set_up_selected_target(unit, chosen_unit, companion_position, line_of_sight_lookup, perception_component, distance_sq_companion_target)

			return chosen_unit
		end

		if target_unit and HEALTH_ALIVE[target_unit] then
			local required_token = _get_token(target_unit)
			local optional_assign_token = false

			if not _check_for_token(unit, target_unit, optional_assign_token) and required_token.free_target_on_assigned_token then
				target_unit = nil
			else
				distance_sq_companion_target = _calculate_distances(target_unit, companion_position, owner_unit_position)

				_set_up_selected_target(unit, target_unit, companion_position, line_of_sight_lookup, perception_component, distance_sq_companion_target)
			end
		end
	end

	return target_unit
end

return target_selection_template
