local Effect = require("scripts/extension_systems/fx/utilities/effect")
local MinionPerception = require("scripts/utilities/minion_perception")
local APPROACH_SOUND_EVENT = "wwise/events/minions/play_cultist_flamer_proximity_warning"
local TARGET_NODE_NAME = "j_spine"
local TRIGGER_DISTANCE = 25
local RESTART_TRIGGER_DISTANCE = 28
local TIME_BETWEEN_TRIGGERS = 15
local resources = {
	approach_sound_event = APPROACH_SOUND_EVENT
}
local _trigger_sound = nil
local effect_template = {
	name = "renegade_flamer_approach",
	resources = resources,
	start = function (template_data, template_context)
		template_data.next_trigger_t = 0
	end,
	update = function (template_data, template_context, dt, t)
		local unit = template_data.unit
		local game_session = template_context.game_session
		local game_object_id = Managers.state.unit_spawner:game_object_id(unit)
		local target_unit = MinionPerception.target_unit(game_session, game_object_id)

		if not ALIVE[target_unit] then
			return
		end

		local target_position = POSITION_LOOKUP[target_unit]
		local unit_position = POSITION_LOOKUP[unit]
		local distance_to_target_unit = Vector3.distance(unit_position, target_position)

		if not template_data.triggered then
			local can_trigger = template_data.next_trigger_t < t and distance_to_target_unit <= TRIGGER_DISTANCE

			if can_trigger then
				_trigger_sound(unit, target_unit, template_data, template_context, t)
			end
		elseif RESTART_TRIGGER_DISTANCE <= distance_to_target_unit then
			template_data.triggered = false
		end
	end,
	stop = function (template_data, template_context)
		return
	end
}

function _trigger_sound(unit, target_unit, template_data, template_context, t)
	local wwise_world = template_context.wwise_world
	local node_index = Unit.node(unit, TARGET_NODE_NAME)
	local auto_source_id = WwiseWorld.make_auto_source(wwise_world, unit, node_index)

	WwiseWorld.trigger_resource_event(wwise_world, APPROACH_SOUND_EVENT, auto_source_id)

	local was_camera_follow_target = false

	Effect.update_targeted_by_special_wwise_parameters(target_unit, wwise_world, auto_source_id, was_camera_follow_target, unit)

	template_data.triggered = true
	template_data.next_trigger_t = t + TIME_BETWEEN_TRIGGERS
end

return effect_template
