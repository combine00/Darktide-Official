local Action = require("scripts/utilities/action/action")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local ChargeEffects = class("ChargeEffects")

function ChargeEffects:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	self._wwise_world = context.wwise_world
	self._weapon_actions = weapon_template.actions
	self._fx_sources = fx_sources
	local owner_unit = context.owner_unit
	self._fx_extension = ScriptUnit.extension(owner_unit, "fx_system")
	self._weapon_template = weapon_template
	self._weapon_template_charge_effects = weapon_template.charge_effects
	local unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
	self._weapon_action_component = unit_data_extension:read_component("weapon_action")
	self._action_module_charge_component = unit_data_extension:read_component("action_module_charge")
	self._is_charge_done_sound_played = true
end

function ChargeEffects:fixed_update(unit, dt, t, frame)
	local charge_level = self:_charge_level(t)
	local have_charge = charge_level > 0

	if not self._effects_running and have_charge then
		self:_start_effects(t)

		self._effects_running = true
		self._is_charge_done_sound_played = false
	elseif self._effects_running and not have_charge then
		self:_stop_effects(t)

		self._effects_running = false
		self._is_charge_done_sound_played = false
	elseif self._effects_running then
		self:_run_looping_sfx(frame)
	end

	self:_play_charged_done_effects()
end

function ChargeEffects:update(unit, dt, t)
	self:_update_sfx_parameter(t)
end

function ChargeEffects:update_first_person_mode(first_person_mode)
	return
end

function ChargeEffects:wield()
	self._is_charge_done_sound_played = true
end

function ChargeEffects:unwield()
	self._is_charge_done_sound_played = true

	self:_stop_effects()
end

function ChargeEffects:destroy()
	self:_stop_effects()
end

function ChargeEffects:_run_looping_sfx(frame)
	local charge_effects = self._charge_effects

	if not charge_effects then
		return
	end

	local action_settings = Action.current_action_settings_from_component(self._weapon_action_component, self._weapon_actions)
	self._looping_sound_alias = charge_effects.looping_sound_alias

	if self._looping_sound_alias then
		local fx_sources = self._fx_sources
		local sfx_source_name = charge_effects.sfx_source_name
		local sfx_source = fx_sources[sfx_source_name]

		self._fx_extension:run_looping_sound(self._looping_sound_alias, sfx_source, nil, frame)
	end
end

function ChargeEffects:_start_effects(t)
	local fx_extension = self._fx_extension
	local action_settings = Action.current_action_settings_from_component(self._weapon_action_component, self._weapon_actions)
	local charge_effects = action_settings and action_settings.charge_effects or self._weapon_template_charge_effects

	if charge_effects then
		self._charge_effects = charge_effects
		local fx_sources = self._fx_sources
		local looping_effect_alias = charge_effects.looping_effect_alias
		local looping_effect_is_playing = looping_effect_alias and fx_extension:is_looping_particles_playing(looping_effect_alias)

		if looping_effect_alias and not looping_effect_is_playing then
			local vfx_source_name = charge_effects.vfx_source_name
			local vfx_source = fx_sources[vfx_source_name]

			fx_extension:spawn_looping_particles(looping_effect_alias, vfx_source)

			self._looping_effect_alias = looping_effect_alias
			self._should_fade_kill = not not charge_effects.should_fade_kill
		end

		self._effects_running = true
	end

	return true
end

function ChargeEffects:_stop_effects()
	local fx_extension = self._fx_extension
	local looping_effect_alias = self._looping_effect_alias
	local looping_effect_is_playing = looping_effect_alias and fx_extension:is_looping_particles_playing(looping_effect_alias)

	if looping_effect_alias and looping_effect_is_playing then
		fx_extension:stop_looping_particles(looping_effect_alias, self._should_fade_kill)

		self._looping_effect_alias = nil
	end

	self._looping_sound_alias = nil
	self._effects_running = false
	self._is_charge_done_sound_played = false
end

function ChargeEffects:_play_charged_done_effects()
	local fx_extension = self._fx_extension
	local action_settings = Action.current_action_settings_from_component(self._weapon_action_component, self._weapon_actions)
	local charge_effects = action_settings and action_settings.charge_effects or self._weapon_template_charge_effects
	local fx_sources = self._fx_sources

	if not charge_effects then
		return
	end

	local charge_done_source_name = charge_effects.charge_done_source_name

	if charge_done_source_name and not self._is_charge_done_sound_played then
		local action_module_charge_component = self._action_module_charge_component
		local charge_done = action_module_charge_component.max_charge <= action_module_charge_component.charge_level

		if charge_done then
			local sync_to_clients = false
			local external_properties = nil
			local charge_done_source = fx_sources[charge_done_source_name]
			local charge_done_sound_alias = charge_effects.charge_done_sound_alias

			if charge_done_sound_alias then
				fx_extension:trigger_gear_wwise_event_with_source(charge_done_sound_alias, external_properties, charge_done_source, sync_to_clients)
			end

			local charge_done_effect_alias = charge_effects.charge_done_effect_alias

			if charge_done_effect_alias then
				local link = true
				local orphaned_policy = "destroy"

				fx_extension:spawn_gear_particle_effect_with_source(charge_done_effect_alias, external_properties, charge_done_source, link, orphaned_policy)
			end

			self._is_charge_done_sound_played = true
		end
	end
end

function ChargeEffects:_charge_level(t)
	local action_module_charge_component = self._action_module_charge_component
	local charge_level = action_module_charge_component.charge_level

	return charge_level
end

function ChargeEffects:_update_sfx_parameter(t)
	local action_settings = Action.current_action_settings_from_component(self._weapon_action_component, self._weapon_actions)
	local charge_effects = action_settings and action_settings.charge_effects or self._weapon_template_charge_effects
	local charge_sfx_parameter = charge_effects and charge_effects.sfx_parameter

	if charge_sfx_parameter == nil then
		return
	end

	local fx_source_name = charge_effects.sfx_source_name
	local source_name = self._fx_sources[fx_source_name]
	local wwise_world = self._wwise_world
	local source = self._fx_extension:sound_source(source_name)
	local charge_level = self:_charge_level(t)

	WwiseWorld.set_source_parameter(wwise_world, source, charge_sfx_parameter, charge_level)
end

implements(ChargeEffects, WieldableSlotScriptInterface)

return ChargeEffects
