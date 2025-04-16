local Action = require("scripts/utilities/action/action")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local SPECIAL_CHARGING_LOOPING_SFX_ALIAS = "weapon_special_loop"
local SPECIAL_CHARGING_LOOPING_VFX_ALIAS = "weapon_special_loop"
local SPECIAL_ACTIVATE_SFX_ALIAS = "sfx_special_activate"
local SPECIAL_ACTIVATE_VFX_ALIAS = "vfx_weapon_special_start"
local SOURCE_TO_NAME = "_special_active"
local SOURCE_FROM_NAME = "_shield_special_active"
local PARTICLE_VARIABLE_NAME = "length"
local _sfx_external_properties = {}
local _vfx_external_properties = {}
local RiotShieldEffects = class("RiotShieldEffects")

function RiotShieldEffects:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	self._is_husk = context.is_husk
	self._world = context.world
	self._wwise_world = context.wwise_world
	self._weapon_actions = weapon_template.actions
	self._slot = slot
	self._is_husk = context.is_husk
	self._is_local_unit = context.is_local_unit
	local unit_data_extension = context.unit_data_extension
	local fx_extension = context.fx_extension
	local visual_loadout_extension = context.visual_loadout_extension
	self._fx_extension = fx_extension
	self._visual_loadout_extension = visual_loadout_extension
	self._action_sweep_component = unit_data_extension:read_component("action_sweep")
	self._weapon_action_component = unit_data_extension:read_component("weapon_action")
	self._first_person_component = unit_data_extension:read_component("first_person")
	self._fx_source_from_name = fx_sources[SOURCE_FROM_NAME]
	self._fx_source_to_name = fx_sources[SOURCE_TO_NAME]
	self._waiting_for_activation_fx = false
	self._has_triggered_activation_fx = false
end

function RiotShieldEffects:fixed_update(unit, dt, t, frame)
	return
end

function RiotShieldEffects:update(unit, dt, t)
	local weapon_action_component = self._weapon_action_component
	local action_settings = Action.current_action_settings_from_component(weapon_action_component, self._weapon_actions)
	local start_t = weapon_action_component.start_t
	local time_in_action = t - start_t

	self:_update_windup(dt, t, action_settings, time_in_action)
	self:_update_activation(dt, t, action_settings, time_in_action)
end

function RiotShieldEffects:update_first_person_mode(first_person_mode)
	return
end

function RiotShieldEffects:wield()
	return
end

function RiotShieldEffects:unwield()
	self:_stop_windup_sfx_loop()
	self:_stop_windup_vfx_loop()
end

function RiotShieldEffects:destroy()
	self:_stop_windup_sfx_loop(true)
	self:_stop_windup_vfx_loop(true)
end

function RiotShieldEffects:_update_windup(dt, t, action_settings, time_in_action)
	if not action_settings then
		self:_stop_windup_sfx_loop()
		self:_stop_windup_vfx_loop()

		return
	end

	local action_kind = action_settings.kind
	local tweak_data = action_settings.wieldable_slot_script_tweak_data

	if not tweak_data then
		self:_stop_windup_sfx_loop()
		self:_stop_windup_vfx_loop()

		return
	end

	local play_windup_effects = tweak_data.play_windup_effects

	if not play_windup_effects then
		self:_stop_windup_sfx_loop()
		self:_stop_windup_vfx_loop()

		return
	end

	local start_time = tweak_data.start_time
	local is_windup = action_kind == "windup" or action_kind == "block_windup"

	if is_windup and not self._looping_windup_effect_id and start_time < time_in_action then
		self:_start_windup_sfx_loop()
		self:_start_windup_vfx_loop()
	elseif not is_windup and self._looping_windup_effect_id then
		self:_stop_windup_sfx_loop()
		self:_stop_windup_vfx_loop()
	end

	if is_windup then
		self._has_triggered_activation_fx = false
	end

	if self._looping_windup_effect_id then
		self:_update_windup_vfx_loop()
	end
end

function RiotShieldEffects:_update_activation(dt, t, action_settings, time_in_action)
	if not action_settings then
		return
	end

	local action_kind = action_settings.kind
	local is_weapon_shout = action_kind == "weapon_shout"
	local shout_at_time = action_settings.shout_at_time
	local waiting_for_shout = is_weapon_shout and time_in_action < shout_at_time

	if waiting_for_shout and self._has_triggered_activation_fx then
		return
	end

	local ready_for_shout = is_weapon_shout and shout_at_time < time_in_action

	if ready_for_shout and not self._has_triggered_activation_fx then
		self._has_triggered_activation_fx = true

		self:_trigger_activation_sfx()
		self:_trigger_activation_vfx()
	end
end

function RiotShieldEffects:_start_windup_sfx_loop()
	local visual_loadout_extension = self._visual_loadout_extension
	local should_play_husk_effect = self._fx_extension:should_play_husk_effect()
	local resolved, event_name, resolved_stop, stop_event_name = visual_loadout_extension:resolve_looping_gear_sound(SPECIAL_CHARGING_LOOPING_SFX_ALIAS, should_play_husk_effect, _sfx_external_properties)

	if resolved and not self._looping_windup_playing_id then
		local sfx_source_id = self._fx_extension:sound_source(self._fx_source_from_name)
		local playing_id = WwiseWorld.trigger_resource_event(self._wwise_world, event_name, sfx_source_id)
		self._looping_windup_playing_id = playing_id

		if resolved_stop then
			self._looping_windup_stop_event_name = stop_event_name
		end
	end
end

function RiotShieldEffects:_stop_windup_sfx_loop(force_stop)
	local looping_playing_id = self._looping_windup_playing_id
	local looping_stop_event_name = self._looping_windup_stop_event_name
	local sfx_source_id = self._fx_extension:sound_source(self._fx_source_from_name)

	if not force_stop and looping_stop_event_name and sfx_source_id then
		WwiseWorld.trigger_resource_event(self._wwise_world, looping_stop_event_name, sfx_source_id)
	elseif self._looping_windup_playing_id then
		WwiseWorld.stop_event(self._wwise_world, looping_playing_id)
	end

	self._looping_windup_playing_id = nil
	self._looping_windup_stop_event_name = nil
end

function RiotShieldEffects:_start_windup_vfx_loop()
	local resolved, effect_name = self._visual_loadout_extension:resolve_gear_particle(SPECIAL_CHARGING_LOOPING_VFX_ALIAS, _vfx_external_properties)

	if resolved then
		local world = self._world
		local new_effect_id = World.create_particles(world, effect_name, Vector3.zero())
		local from_unit, from_node = self._fx_extension:vfx_spawner_unit_and_node(self._fx_source_from_name)
		local to_unit, to_node = self._fx_extension:vfx_spawner_unit_and_node(self._fx_source_to_name)
		local from_pos = Unit.world_position(from_unit, from_node)
		local to_pos = Unit.world_position(to_unit, to_node)
		local line = to_pos - from_pos
		local direction, length = Vector3.direction_length(line)
		local rotation = Quaternion.look(direction)
		local particle_length = Vector3(length, length, length)
		local length_variable_index = World.find_particles_variable(world, effect_name, PARTICLE_VARIABLE_NAME)

		World.set_particles_variable(world, new_effect_id, length_variable_index, particle_length)
		World.move_particles(world, new_effect_id, from_pos, rotation)

		self._looping_windup_effect_id = new_effect_id
	end
end

function RiotShieldEffects:_stop_windup_vfx_loop(destroy)
	local current_effect_id = self._looping_windup_effect_id

	if current_effect_id then
		if destroy then
			World.destroy_particles(self._world, current_effect_id)
		else
			World.stop_spawning_particles(self._world, current_effect_id)
		end
	end

	self._looping_windup_effect_id = nil
end

function RiotShieldEffects:_update_windup_vfx_loop()
	local resolved, effect_name = self._visual_loadout_extension:resolve_gear_particle(SPECIAL_CHARGING_LOOPING_VFX_ALIAS, _vfx_external_properties)

	if resolved then
		local world = self._world
		local looping_effect_id = self._looping_windup_effect_id
		local from_unit, from_node = self._fx_extension:vfx_spawner_unit_and_node(self._fx_source_from_name)
		local to_unit, to_node = self._fx_extension:vfx_spawner_unit_and_node(self._fx_source_to_name)
		local from_pos = Unit.world_position(from_unit, from_node)
		local to_pos = Unit.world_position(to_unit, to_node)
		local line = to_pos - from_pos
		local direction, length = Vector3.direction_length(line)
		local rotation = Quaternion.look(direction)
		local particle_length = Vector3(length, length, length)
		local length_variable_index = World.find_particles_variable(world, effect_name, PARTICLE_VARIABLE_NAME)

		World.set_particles_variable(world, looping_effect_id, length_variable_index, particle_length)
		World.move_particles(world, looping_effect_id, from_pos, rotation)
	end
end

function RiotShieldEffects:_trigger_activation_sfx()
	local resolved, event_name, has_husk_events = self._visual_loadout_extension:resolve_gear_sound(SPECIAL_ACTIVATE_SFX_ALIAS, _sfx_external_properties)

	if resolved then
		local should_play_husk_effect = self._fx_extension:should_play_husk_effect()

		if has_husk_events and should_play_husk_effect then
			event_name = event_name .. "_husk"
		end

		local sfx_source_id = self._fx_extension:sound_source(self._fx_source_from_name)

		WwiseWorld.trigger_resource_event(self._wwise_world, event_name, sfx_source_id)
	end
end

function RiotShieldEffects:_trigger_activation_vfx()
	local resolved, effect_name = self._visual_loadout_extension:resolve_gear_particle(SPECIAL_ACTIVATE_VFX_ALIAS, _vfx_external_properties)

	if resolved then
		local world = self._world
		local rotation = self._first_person_component.rotation
		local spawn_rot = Quaternion.look(Vector3.normalize(Vector3.flat(Quaternion.forward(rotation))))
		local from_unit, from_node = self._fx_extension:vfx_spawner_unit_and_node(self._fx_source_from_name)
		local spawn_pos = Unit.world_position(from_unit, from_node)
		local new_effect_id = World.create_particles(world, effect_name, spawn_pos, spawn_rot)
	end
end

implements(RiotShieldEffects, WieldableSlotScriptInterface)

return RiotShieldEffects
