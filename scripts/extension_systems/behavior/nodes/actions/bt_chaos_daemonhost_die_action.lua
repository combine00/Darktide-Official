require("scripts/extension_systems/behavior/nodes/bt_node")

local Animation = require("scripts/utilities/animation")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local ChaosDaemonhostSettings = require("scripts/settings/monster/chaos_daemonhost_settings")
local MinionDeath = require("scripts/utilities/minion_death")
local MinionMovement = require("scripts/utilities/minion_movement")
local Vo = require("scripts/utilities/vo")
local STAGES = ChaosDaemonhostSettings.stages
local BtChaosDaemonhostDieAction = class("BtChaosDaemonhostDieAction", "BtNode")

function BtChaosDaemonhostDieAction:enter(unit, breed, blackboard, scratchpad, action_data, t)
	local death_component = Blackboard.write_component(blackboard, "death")
	scratchpad.death_component = death_component
	local death_type_stage = action_data.death_type_stage or STAGES.death_normal
	local spawn_component = blackboard.spawn
	local game_session = spawn_component.game_session
	local game_object_id = spawn_component.game_object_id

	GameSession.set_game_object_field(game_session, game_object_id, "stage", death_type_stage)

	local death_anim_events = action_data.anim_events
	local anim_event = Animation.random_event(death_anim_events)
	local anim_extension = ScriptUnit.extension(unit, "animation_system")

	anim_extension:anim_event(anim_event)

	local anim_durations = action_data.durations
	local duration = anim_durations[anim_event]
	scratchpad.duration = t + duration
	local anim_driven_until = action_data.anim_driven_until and action_data.anim_driven_until[anim_event]

	if anim_driven_until then
		scratchpad.locomotion_extension = ScriptUnit.extension(unit, "locomotion_system")
		scratchpad.anim_driven_duration = t + anim_driven_until

		MinionMovement.set_anim_driven(scratchpad, true)
	end

	local vo_event = action_data.vo_event

	if vo_event then
		Vo.enemy_generic_vo_event(unit, vo_event, breed.name)
	end
end

function BtChaosDaemonhostDieAction:init_values(blackboard)
	local death_component = Blackboard.write_component(blackboard, "death")

	death_component.attack_direction:store(0, 0, 0)

	death_component.hit_zone_name = ""
	death_component.is_dead = false
	death_component.hit_during_death = false
	death_component.damage_profile_name = ""
	death_component.herding_template_name = ""
	death_component.killing_damage_type = ""
	death_component.force_instant_ragdoll = false
end

function BtChaosDaemonhostDieAction:_set_dead(unit, scratchpad, action_data)
	if action_data.despawn_on_done then
		local minion_spawn_manager = Managers.state.minion_spawn

		minion_spawn_manager:despawn_minion(unit)
	else
		local death_component = scratchpad.death_component
		local attack_direction = death_component.attack_direction:unbox()
		local hit_zone_name = death_component.hit_zone_name
		local damage_profile_name = death_component.damage_profile_name
		local herding_template_name = string.value_or_nil(death_component.herding_template_name)
		local do_ragdoll_push = false

		MinionDeath.set_dead(unit, attack_direction, hit_zone_name, damage_profile_name, do_ragdoll_push, herding_template_name)
	end
end

function BtChaosDaemonhostDieAction:_set_death_component(scratchpad, action_data)
	local death_component = scratchpad.death_component
	local values = action_data.death_component_values
	local attack_direction = values.attack_direction:unbox()

	death_component.attack_direction:store(attack_direction)

	death_component.hit_zone_name = values.hit_zone_name
	death_component.damage_profile_name = values.damage_profile_name
end

function BtChaosDaemonhostDieAction:run(unit, breed, blackboard, scratchpad, action_data, dt, t)
	local anim_driven_duration = scratchpad.anim_driven_duration

	if anim_driven_duration and anim_driven_duration <= t then
		scratchpad.anim_driven_duration = nil

		MinionMovement.set_anim_driven(scratchpad, false)
	end

	local duration = scratchpad.duration

	if duration <= t then
		if HEALTH_ALIVE[unit] then
			self:_set_death_component(scratchpad, action_data)
		end

		self:_set_dead(unit, scratchpad, action_data)
	end

	return "running"
end

return BtChaosDaemonhostDieAction
