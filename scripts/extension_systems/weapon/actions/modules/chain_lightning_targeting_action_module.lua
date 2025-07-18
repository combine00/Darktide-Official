local ChainLightning = require("scripts/utilities/action/chain_lightning")
local ChainLightningTargetingActionModule = class("ChainLightningTargetingActionModule")
local Vector3_flat = Vector3.flat
local Vector3_normalize = Vector3.normalize
local Vector3_up = Vector3.up

function ChainLightningTargetingActionModule:init(is_server, physics_world, player_unit, component, action_settings)
	self._is_server = is_server
	self._physics_world = physics_world
	self._player_unit = player_unit
	self._component = component
	self._action_settings = action_settings
	local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
	self._first_person_component = unit_data_extension:read_component("first_person")
	self._weapon_action_component = unit_data_extension:read_component("weapon_action")
	self._buff_extension = ScriptUnit.extension(player_unit, "buff_system")
end

function ChainLightningTargetingActionModule:start(action_settings, t)
	local component = self._component
	component.target_unit_1 = nil
	component.target_unit_2 = nil
	component.target_unit_3 = nil
end

local DEFAULT_RADIUS = 4
local DEFAULT_MAX_Z_DIFF = 10
local DEFAULT_MAX_ANGLE = math.pi * 0.25
local broadphase_results = {}
local hit_units = {}

function ChainLightningTargetingActionModule:fixed_update(dt, t)
	local broadphase_system = Managers.state.extension:system("broadphase_system")
	local side_system = Managers.state.extension:system("side_system")
	local player_unit = self._player_unit
	local side = side_system.side_by_unit[player_unit]
	local enemy_side_names = side:relation_side_names("enemy")
	local broadphase = broadphase_system.broadphase
	local query_position = POSITION_LOOKUP[player_unit]
	local rotation = self._first_person_component.rotation
	local forward_direction = Vector3_normalize(Vector3_flat(Quaternion.forward(rotation)))
	local stat_buffs = self._buff_extension:stat_buffs()
	local action_settings = self._action_settings
	local chain_settings = action_settings and action_settings.chain_settings_targeting or action_settings.chain_settings
	local time_in_action = t - self._weapon_action_component.start_t
	local max_angle, close_max_angle, vertical_max_angle, max_z_diff, max_jumps, radius, jump_time, max_targets = ChainLightning.targeting_parameters(time_in_action, chain_settings, stat_buffs)

	table.clear(broadphase_results)
	table.clear(hit_units)

	local num_results = broadphase:query(query_position, radius, broadphase_results, enemy_side_names)
	local physics_world = self._physics_world
	local component = self._component
	local num_targets = 0
	local precision_angle = math.pi * 0.001
	local test_angle = precision_angle

	for i = 1, 2 do
		for j = 1, num_results do
			local target_unit = broadphase_results[j]

			if not hit_units[target_unit] then
				local min_distance = 1
				local valid_target, debug_reason = ChainLightning.is_valid_target(physics_world, player_unit, target_unit, query_position, -forward_direction, test_angle, close_max_angle, nil, nil, nil, min_distance)

				if valid_target then
					num_targets = num_targets + 1
					hit_units[target_unit] = true

					if num_targets == 1 then
						component.target_unit_1 = target_unit
					elseif num_targets == 2 then
						component.target_unit_2 = target_unit
					elseif num_targets == 3 then
						component.target_unit_3 = target_unit
					end

					if max_targets and num_targets == max_targets then
						break
					elseif num_targets >= 3 then
						break
					end
				end
			end
		end

		if num_targets >= 3 then
			break
		end

		test_angle = max_angle
	end
end

function ChainLightningTargetingActionModule:finish(reason, data, t)
	if reason == "hold_input_released" or reason == "stunned" then
		local component = self._component
		component.target_unit_1 = nil
		component.target_unit_2 = nil
		component.target_unit_3 = nil
	end
end

return ChainLightningTargetingActionModule
