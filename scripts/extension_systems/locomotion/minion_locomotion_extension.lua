local Attack = require("scripts/utilities/attack/attack")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local Breed = require("scripts/utilities/breed")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local LOCOMOTION_GRAVITY = 20
local MinionLocomotionExtension = class("MinionLocomotionExtension")

function MinionLocomotionExtension:init(extension_init_context, unit, extension_init_data, game_object_data)
	self._unit = unit
	self._breed = extension_init_data.breed
	local game_object_type = self._breed.game_object_type
	local sync_full_rotation = Network.object_has_field(game_object_type, "rotation")
	self._engine_extension_id = MinionLocomotion.register_extension(unit, LOCOMOTION_GRAVITY, sync_full_rotation)
	self.movement_type = "snap_to_navmesh"

	Unit._set_mover(unit, nil)
end

function MinionLocomotionExtension:game_object_initialized(game_session, game_object_id)
	MinionLocomotion.game_object_initialized(self._engine_extension_id, game_object_id)

	self._game_object_id = game_object_id
end

function MinionLocomotionExtension:destroy()
	MinionLocomotion.destroy_extension(self._engine_extension_id)
end

function MinionLocomotionExtension:set_mover_displacement(displacement, duration)
	MinionLocomotion.set_mover_displacement(self._engine_extension_id, displacement, duration)
end

function MinionLocomotionExtension:teleport_to(position, rotation)
	MinionLocomotion.teleport_to(self._engine_extension_id, position, rotation)
end

function MinionLocomotionExtension:set_anim_driven(animation_driven, optional_affected_by_gravity, optional_script_driven_rotation, optional_override_velocity_z)
	MinionLocomotion.set_animation_driven(self._engine_extension_id, animation_driven, optional_affected_by_gravity, optional_script_driven_rotation, optional_override_velocity_z)
end

function MinionLocomotionExtension:set_anim_translation_scale(scale)
	MinionLocomotion.set_animation_translation_scale(self._engine_extension_id, scale)
end

function MinionLocomotionExtension:set_anim_rotation_scale(scale)
	MinionLocomotion.set_animation_rotation_scale(self._engine_extension_id, scale)
end

function MinionLocomotionExtension:set_wanted_velocity_flat(velocity)
	MinionLocomotion.set_wanted_velocity_flat(self._engine_extension_id, velocity)
end

function MinionLocomotionExtension:set_wanted_velocity(velocity)
	MinionLocomotion.set_wanted_velocity(self._engine_extension_id, velocity)
end

function MinionLocomotionExtension:set_external_velocity(velocity)
	MinionLocomotion.set_external_velocity(self._engine_extension_id, velocity)
end

function MinionLocomotionExtension:set_wanted_rotation(rotation)
	MinionLocomotion.set_wanted_rotation(self._engine_extension_id, rotation)
end

function MinionLocomotionExtension:use_lerp_rotation(active)
	MinionLocomotion.use_lerp_rotation(self._engine_extension_id, active)
end

function MinionLocomotionExtension:set_rotation_speed(rotation_speed)
	MinionLocomotion.set_rotation_speed(self._engine_extension_id, rotation_speed)
end

function MinionLocomotionExtension:set_rotation_speed_modifier(rotation_speed_modifier, rotation_speed_modifier_lerp_time, start_time)
	MinionLocomotion.set_rotation_speed_modifier(self._engine_extension_id, rotation_speed_modifier, rotation_speed_modifier_lerp_time, start_time)
end

function MinionLocomotionExtension:set_affected_by_gravity(affected_by_gravity, optional_override_velocity_z)
	MinionLocomotion.set_affected_by_gravity(self._engine_extension_id, affected_by_gravity, optional_override_velocity_z)
end

function MinionLocomotionExtension:set_gravity(gravity)
	MinionLocomotion.set_gravity(self._engine_extension_id, gravity)
end

function MinionLocomotionExtension:set_check_falling(state)
	MinionLocomotion.set_check_falling(self._engine_extension_id, state)
end

local movement_types = {
	script_driven = 0,
	snap_to_navmesh = 1,
	constrained_by_mover = 2
}

function MinionLocomotionExtension:set_movement_type(movement_type, override_mover_separate_distance, ignore_forced_mover_kill)
	if movement_type == self.movement_type then
		return true
	end

	self.movement_type = movement_type
	local unit = self._unit

	if movement_type == "constrained_by_mover" then
		Unit._set_mover(unit, "mover")
	else
		Unit._set_mover(unit, nil)
	end

	local kill = MinionLocomotion.set_movement_type(self._engine_extension_id, movement_types[movement_type], override_mover_separate_distance)

	if kill and not ignore_forced_mover_kill then
		if Breed.is_companion(self._breed) then
			local blackboard = BLACKBOARDS[unit]
			local behavior_component = blackboard and Blackboard.write_component(blackboard, "behavior")

			if behavior_component then
				behavior_component.is_out_of_bound = true
			end
		else
			local damage_profile = DamageProfileTemplates.default

			Attack.execute(unit, damage_profile, "instakill", true)
		end
	end

	return not kill
end

function MinionLocomotionExtension:current_velocity()
	return MinionLocomotion.velocity(self._engine_extension_id)
end

function MinionLocomotionExtension:is_falling()
	return MinionLocomotion.is_falling(self._engine_extension_id)
end

function MinionLocomotionExtension:rotation_speed()
	return MinionLocomotion.rotation_speed(self._engine_extension_id)
end

function MinionLocomotionExtension:rotation_speed_modifier()
	return MinionLocomotion.rotation_speed_modifier(self._engine_extension_id)
end

function MinionLocomotionExtension:anim_rotation_scale()
	return MinionLocomotion.animation_rotation_scale(self._engine_extension_id)
end

function MinionLocomotionExtension:anim_translation_scale()
	return MinionLocomotion.animation_translation_scale(self._engine_extension_id)
end

function MinionLocomotionExtension:set_traverse_logic(traverse_logic)
	MinionLocomotion.set_traverse_logic(self._engine_extension_id, traverse_logic)
end

function MinionLocomotionExtension:is_getting_back_to_nav_mesh()
	return MinionLocomotion.is_in_get_to_nav_mesh(self._engine_extension_id)
end

return MinionLocomotionExtension
