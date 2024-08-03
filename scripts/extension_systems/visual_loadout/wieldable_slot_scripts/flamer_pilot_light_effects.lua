local FlamerPilotLightEffects = class("FlamerPilotLightEffects")
local LOOPING_PARTICLE_ALIAS = "equipped_item_passive"
local FX_SOURCE_NAME = "_pilot"
local EXTERNAL_PROPERTIES = {}

function FlamerPilotLightEffects:init(context, slot, weapon_template, fx_sources)
	self._world = context.world
	local fx_extension = context.fx_extension
	local visual_loadout_extension = context.visual_loadout_extension
	self._fx_extension = fx_extension
	self._visual_loadout_extension = visual_loadout_extension
	local fx_source_name = fx_sources[FX_SOURCE_NAME]
	self._fx_source_name = fx_source_name
	self._vfx_link_unit, self._vfx_link_node = fx_extension:vfx_spawner_unit_and_node(fx_source_name)
	self._looping_effect_id = nil
end

function FlamerPilotLightEffects:fixed_update(unit, dt, t, frame)
	return
end

function FlamerPilotLightEffects:update(unit, dt, t)
	return
end

function FlamerPilotLightEffects:update_first_person_mode(first_person_mode)
	return
end

function FlamerPilotLightEffects:wield()
	self:_create_effects()
end

function FlamerPilotLightEffects:unwield()
	self:_destroy_effects()
end

function FlamerPilotLightEffects:destroy()
	self:_destroy_effects()
end

function FlamerPilotLightEffects:_create_effects()
	local resolved, effect_name = self._visual_loadout_extension:resolve_gear_particle(LOOPING_PARTICLE_ALIAS, EXTERNAL_PROPERTIES)

	if resolved then
		local world = self._world
		local effect_id = World.create_particles(world, effect_name, Vector3.zero())

		World.link_particles(world, effect_id, self._vfx_link_unit, self._vfx_link_node, Matrix4x4.identity(), "stop")

		self._looping_effect_id = effect_id
	end
end

function FlamerPilotLightEffects:_destroy_effects()
	if self._looping_effect_id then
		World.destroy_particles(self._world, self._looping_effect_id)

		self._looping_effect_id = nil
	end
end

return FlamerPilotLightEffects
