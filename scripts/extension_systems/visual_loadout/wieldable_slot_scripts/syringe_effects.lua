local Component = require("scripts/utilities/component")
local SyringeEffects = class("SyringeEffects")
local LOOPING_PARTICLE_ALIAS = "equipped_item_passive"
local FX_SOURCE_NAME = "_passive"
local EXTERNAL_PROPERTIES = {}
local CONFIG = {
	syringe_corruption_pocketable = {
		decal_index = 1,
		glass_color = Vector3Box(0.3, 0.6, 0.4),
		liquid_color = Vector3Box(0.117, 0.6, 0.197)
	},
	syringe_ability_boost_pocketable = {
		decal_index = 4,
		glass_color = Vector3Box(1, 0.5, 0),
		liquid_color = Vector3Box(1, 0.5, 0)
	},
	syringe_power_boost_pocketable = {
		decal_index = 3,
		glass_color = Vector3Box(0.389, 0, 0),
		liquid_color = Vector3Box(0.389, 0, 0)
	},
	syringe_speed_boost_pocketable = {
		decal_index = 2,
		glass_color = Vector3Box(0.221, 0.49, 1),
		liquid_color = Vector3Box(0.221, 0.49, 1)
	}
}

function SyringeEffects:init(context, slot, weapon_template, fx_sources)
	self._world = context.world
	self._weapon_template = weapon_template
	local fx_extension = context.fx_extension
	local visual_loadout_extension = context.visual_loadout_extension
	self._fx_extension = fx_extension
	self._visual_loadout_extension = visual_loadout_extension
	local fx_source_name = fx_sources[FX_SOURCE_NAME]
	self._fx_source_name = fx_source_name
	self._vfx_link_unit, self._vfx_link_node = fx_extension:vfx_spawner_unit_and_node(fx_source_name)
	self._looping_effect_id = nil
	local unit_components = {}
	local unit_1p = slot.unit_1p

	if unit_1p then
		local components = Component.get_components_by_name(unit_1p, "SyringeInjectorColor")

		for _, component in ipairs(components) do
			unit_components[#unit_components + 1] = {
				unit = unit_1p,
				component = component
			}
		end
	end

	local unit_3p = slot.unit_3p

	if unit_3p then
		local components = Component.get_components_by_name(unit_3p, "SyringeInjectorColor")

		for _, component in ipairs(components) do
			unit_components[#unit_components + 1] = {
				unit = unit_3p,
				component = component
			}
		end
	end

	self._unit_components = unit_components
end

function SyringeEffects:fixed_update(unit, dt, t, frame)
	return
end

function SyringeEffects:update(unit, dt, t)
	return
end

function SyringeEffects:update_first_person_mode(first_person_mode)
	return
end

function SyringeEffects:wield()
	self:_create_effects()
	self:_set_color()
end

function SyringeEffects:unwield()
	self:_destroy_effects()
end

function SyringeEffects:destroy()
	self:_destroy_effects()
end

function SyringeEffects:_create_effects()
	local resolved, effect_name = self._visual_loadout_extension:resolve_gear_particle(LOOPING_PARTICLE_ALIAS, EXTERNAL_PROPERTIES)

	if resolved then
		local world = self._world
		local effect_id = World.create_particles(world, effect_name, Vector3.zero())

		World.link_particles(world, effect_id, self._vfx_link_unit, self._vfx_link_node, Matrix4x4.identity(), "stop")

		self._looping_effect_id = effect_id
	end
end

function SyringeEffects:_destroy_effects()
	if self._looping_effect_id then
		World.destroy_particles(self._world, self._looping_effect_id)

		self._looping_effect_id = nil
	end
end

function SyringeEffects:_set_color()
	local weapon_template_name = self._weapon_template.name
	local settings = CONFIG[weapon_template_name]
	local glass_color = settings.glass_color:unbox()
	local liquid_color = settings.liquid_color:unbox()
	local decal_index = settings.decal_index
	local unit_components = self._unit_components
	local num_components = #unit_components

	for ii = 1, num_components do
		local syringe_color = unit_components[ii]

		syringe_color.component:set_colors(syringe_color.unit, glass_color, liquid_color)
		syringe_color.component:set_decal(syringe_color.unit, decal_index)
	end
end

return SyringeEffects
