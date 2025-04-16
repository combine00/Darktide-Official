require("scripts/extension_systems/behavior/nodes/bt_node")

local Attack = require("scripts/utilities/attack/attack")
local AttackSettings = require("scripts/settings/damage/attack_settings")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local Explosion = require("scripts/utilities/attack/explosion")
local BtCompanionTargetPouncedAction = class("BtCompanionTargetPouncedAction", "BtNode")

function BtCompanionTargetPouncedAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	local behavior_component = Blackboard.write_component(blackboard, "behavior")
	behavior_component.move_state = "attacking"
	local animation_extension = ScriptUnit.extension(unit, "animation_system")
	scratchpad.animation_extension = animation_extension
	local fx_system = Managers.state.extension:system("fx_system")
	scratchpad.fx_system = fx_system
	scratchpad.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
	scratchpad.navigation_extension = ScriptUnit.extension(unit, "navigation_system")
	scratchpad.start_position_boxed = Vector3Box(POSITION_LOOKUP[unit])
	scratchpad.lerp_position_duration = t + action_data.lerp_position_time
	local pounce_component = Blackboard.write_component(blackboard, "pounce")
	local pounce_target = pounce_component.pounce_target
	scratchpad.pounce_component = pounce_component
	local target_unit_data_extension = ScriptUnit.extension(pounce_target, "unit_data_system")
	local target_unit_breed = target_unit_data_extension:breed()
	local companion_pounce_setting = target_unit_breed.companion_pounce_setting
	scratchpad.companion_pounce_setting = companion_pounce_setting
	local pounce_anim_event = companion_pounce_setting.pounce_anim_event

	animation_extension:anim_event(pounce_anim_event)

	local perception_component = blackboard.perception
	scratchpad.perception_component = perception_component
	scratchpad.attempting_pounce = true

	self:_damage_target(unit, pounce_target, action_data, companion_pounce_setting.initial_damage_profile)

	local explosion_template = action_data.enter_explosion_template

	if explosion_template then
		local power_level = action_data.explosion_power_level
		local charge_level = 1
		local explosion_attack_type = AttackSettings.attack_types.explosion
		local up = Quaternion.up(Unit.local_rotation(unit, 1))
		local explosion_position = POSITION_LOOKUP[unit] + up * 0.1
		local spawn_component = blackboard.spawn
		local world = spawn_component.world
		local physics_world = spawn_component.physics_world

		Explosion.create_explosion(world, physics_world, explosion_position, up, unit, explosion_template, power_level, charge_level, explosion_attack_type)
	end

	local target_blackboard = BLACKBOARDS[pounce_target]
	scratchpad.target_blackboard = target_blackboard
	scratchpad.target_death_component = target_blackboard.death
	scratchpad.target_disable_component = Blackboard.write_component(target_blackboard, "disable")
	local looping_sound_event_start = companion_pounce_setting.looping_sound_event_start

	if looping_sound_event_start then
		local fx_node_name = "fx_jaw"
		local fx_node = Unit.node(unit, fx_node_name)

		scratchpad.fx_system:trigger_wwise_event(looping_sound_event_start, nil, unit, fx_node)
	end
end

function BtCompanionTargetPouncedAction:init_values(blackboard)
	local pounce_component = Blackboard.write_component(blackboard, "pounce")
	pounce_component.pounce_target = nil
	pounce_component.pounce_cooldown = 0
	pounce_component.started_leap = false
	pounce_component.has_pounce_target = false
end

function BtCompanionTargetPouncedAction:leave(unit, breed, blackboard, scratchpad, action_data, t, reason, destroy)
	local pounce_component = scratchpad.pounce_component
	local pounce_target = pounce_component.pounce_target

	if pounce_target and HEALTH_ALIVE[pounce_target] then
		local token_extension = ScriptUnit.has_extension(pounce_target, "token_system")

		if token_extension then
			local required_token = scratchpad.companion_pounce_setting.required_token

			token_extension:free_token(required_token.name)
		end
	end

	pounce_component.pounce_target = nil

	scratchpad.locomotion_extension:set_movement_type("snap_to_navmesh")

	local looping_sound_event_stop = scratchpad.companion_pounce_setting.looping_sound_event_stop

	if looping_sound_event_stop then
		local fx_node_name = "fx_jaw"
		local fx_node = Unit.node(unit, fx_node_name)

		scratchpad.fx_system:trigger_wwise_event(looping_sound_event_stop, nil, unit, fx_node)
	end
end

function BtCompanionTargetPouncedAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	local pounce_target = scratchpad.pounce_component.pounce_target

	if scratchpad.attempting_pounce then
		scratchpad.attempting_pounce = false
		scratchpad.target_disable_component.type = "pounced"
		scratchpad.target_disable_component.is_disabled = true
		scratchpad.target_disable_component.attacker_unit = unit
		scratchpad.next_damage_t = t + action_data.damage_start_time
	end

	if scratchpad.next_damage_t < t then
		local companion_pounce_setting = scratchpad.companion_pounce_setting

		self:_damage_target(unit, pounce_target, action_data, companion_pounce_setting.damage_profile)

		scratchpad.next_damage_t = t + action_data.damage_frequency
	end

	self:_position_companion(unit, scratchpad, action_data, t, pounce_target)

	local target_is_dead = scratchpad.target_death_component.is_dead

	if target_is_dead then
		scratchpad.pounce_component.has_pounce_target = false

		return "done"
	end

	local target_unit = scratchpad.perception_component.target_unit

	if scratchpad.lerp_position_duration < t and pounce_target ~= target_unit then
		local companion_pounce_setting = scratchpad.companion_pounce_setting

		Attack.execute(pounce_target, companion_pounce_setting.damage_profile, "instakill", true)

		scratchpad.pounce_component.has_pounce_target = false

		return "done"
	end

	return "running"
end

local POWER_LEVEL = 500

function BtCompanionTargetPouncedAction:_damage_target(unit, pounce_target, action_data, damage_profile)
	local jaw_node = Unit.node(unit, action_data.hit_position_node)
	local hit_position = Unit.world_position(unit, jaw_node)
	local attack_type = AttackSettings.attack_types.companion_dog
	local damage_type = action_data.damage_type

	Attack.execute(pounce_target, damage_profile, "power_level", POWER_LEVEL, "hit_world_position", hit_position, "attack_type", attack_type, "attacking_unit", unit, "damage_type", damage_type)
end

function BtCompanionTargetPouncedAction:_position_companion(unit, scratchpad, action_data, t, pounce_target)
	local pounce_target_position = POSITION_LOOKUP[pounce_target]

	if t < scratchpad.lerp_position_duration then
		local lerp_position_time = action_data.lerp_position_time
		local start_position = scratchpad.start_position_boxed:unbox()
		local time_left = scratchpad.lerp_position_duration - t
		local percentage = 1 - time_left / lerp_position_time
		local new_position = Vector3.lerp(start_position, pounce_target_position, percentage)

		Unit.set_local_position(unit, 1, new_position)
	else
		Unit.set_local_position(unit, 1, pounce_target_position)
	end
end

return BtCompanionTargetPouncedAction
