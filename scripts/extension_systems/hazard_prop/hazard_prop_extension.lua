local Explosion = require("scripts/utilities/attack/explosion")
local HazardPropSettings = require("scripts/settings/hazard_prop/hazard_prop_settings")
local LiquidArea = require("scripts/extension_systems/liquid_area/utilities/liquid_area")
local explosion_settings = HazardPropSettings.explosion_settings
local fire_settings = HazardPropSettings.fire_settings
local hazard_content = HazardPropSettings.hazard_content
local hazard_material = HazardPropSettings.material
local hazard_state = HazardPropSettings.hazard_state
local TRIGGER_TIME = 3
local HazardPropExtension = class("HazardPropExtension")
HazardPropExtension.UPDATE_DISABLED_BY_DEFAULT = true

function HazardPropExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._unit = unit
	self._is_server = extension_init_context.is_server
	self._current_state = hazard_state.idle
	self._content = hazard_content.undefined
	self._trigger_timer = 0
	self._trigger_direction = Vector3Box()
	self._fuse_active = false
	self._running_update = false
	self._world = extension_init_context.world
	self._nav_world = extension_init_context.nav_world
	self._intact_colliders = {}
	self._broken_colliders = {}
	self._hazard_shape = nil
	self._broadphase_radius = 1
	self._owner_system = extension_init_context.owner_system
end

function HazardPropExtension:add_to_broadphase()
	if not self._broadphase_id then
		local unit = self._unit
		local broadphase = self._broadphase
		local broadphase_radius = self._broadphase_radius
		local broadphase_position = self._broadphase_position:unbox()
		self._broadphase_id = Broadphase.add(broadphase, unit, broadphase_position, broadphase_radius or 1, "destructibles")
	end

	return self._broadphase_id
end

function HazardPropExtension:remove_from_broadphase()
	if self._broadphase_id then
		Broadphase.remove(self._broadphase, self._broadphase_id)

		self._broadphase_id = nil
	end
end

function HazardPropExtension:setup_from_component(hazard_shape, broadphase_radius)
	local unit = self._unit
	self._hazard_shape = hazard_shape

	self:_sort_colliders()
	self:_update_mesh_visuals()

	local broadphase_system = Managers.state.extension:system("broadphase_system")
	local broadphase = broadphase_system.broadphase
	local destructible_actor_index = Unit.find_actor(unit, "c_destructible") or 1
	local destructible_actor = Unit.actor(unit, destructible_actor_index)
	local position = Actor.position(destructible_actor)
	self._broadphase = broadphase
	self._broadphase_system = broadphase_system
	self._broadphase_radius = broadphase_radius
	self._broadphase_position = Vector3Box(position)
end

function HazardPropExtension:_sort_colliders()
	local unit = self._unit
	local intact_colliders = self._intact_colliders
	local intact_collider_names = HazardPropSettings.intact_colliders[self._hazard_shape]

	for i = 1, #intact_collider_names do
		intact_colliders[#intact_colliders + 1] = Unit.actor(unit, intact_collider_names[i])
	end

	local broken_colliders = self._broken_colliders
	local broken_collider_names = HazardPropSettings.broken_colliders[self._hazard_shape]

	for i = 1, #broken_collider_names do
		broken_colliders[#broken_colliders + 1] = Unit.actor(unit, broken_collider_names[i])
	end
end

function HazardPropExtension:hot_join_sync(state, content)
	self:set_current_state(state)
	self:set_content(content)
end

function HazardPropExtension:content()
	return self._content
end

function HazardPropExtension:set_content(content)
	if self._content ~= hazard_content.undefined and self._is_server then
		Log.error("HazardPropExtension", "[set_content][Unit: %s] Hazard already has content: %s, changed to: %s", Unit.id_string(self._unit), self._content, content)
	end

	if content == hazard_content.none then
		Unit.set_material(self._unit, "hazard_paint", hazard_material.empty_paint)
		Unit.set_material(self._unit, "hazard_il", hazard_material.empty_il)
		Unit.flow_event(self._unit, "lua_content_set_none")
		self:remove_from_broadphase()
	elseif content == hazard_content.explosion then
		Unit.set_material(self._unit, "hazard_paint", hazard_material.explosion_paint)
		Unit.set_material(self._unit, "hazard_il", hazard_material.explosion_il)
		Unit.flow_event(self._unit, "lua_content_set_explosion")
		self:add_to_broadphase()
	elseif content == hazard_content.fire then
		Unit.set_material(self._unit, "hazard_paint", hazard_material.fire_paint)
		Unit.set_material(self._unit, "hazard_il", hazard_material.fire_il)
		Unit.flow_event(self._unit, "lua_content_set_fire")
		self:add_to_broadphase()
	elseif content == hazard_content.gas then
		Unit.set_material(self._unit, "hazard_paint", hazard_material.gas_paint)
		Unit.set_material(self._unit, "hazard_il", hazard_material.gas_il)
		Unit.flow_event(self._unit, "lua_content_set_gas")
		self:add_to_broadphase()
	else
		Log.error("HazardPropExtension", "[set_content][Unit: %s] set the hazard prop to unknown content: %s", Unit.id_string(self._unit), content)
	end

	self._content = content

	if self._is_server then
		local unit = self._unit
		local unit_level_index = Managers.state.unit_spawner:level_index(unit)
		local content_id = NetworkLookup.hazard_prop_content[content]
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_hazard_prop_set_content", unit_level_index, content_id)
	end
end

function HazardPropExtension:current_state()
	return self._current_state
end

function HazardPropExtension:set_current_state(state)
	local old_state = self._current_state
	local unit = self._unit
	self._current_state = state

	if state == hazard_state.triggered then
		if old_state == hazard_state.idle then
			if not self._fuse_active then
				Unit.flow_event(unit, "lua_fuse_start")

				self._fuse_active = true
			end

			if self._is_server then
				self:start_trigger_timer()
				self._owner_system:enable_update_function(self.__class_name, "update", unit, self)

				self._running_update = true
				local shape = "sphere"
				local size = explosion_settings.explosion_template.radius
				local rotation = Quaternion.identity()
				local duration = TRIGGER_TIME
				local position = POSITION_LOOKUP[unit]
				local side_system = Managers.state.extension:system("side_system")
				local sides = side_system:sides()
				local group_system = Managers.state.extension:system("group_system")
				local bot_groups = group_system:bot_groups_from_sides(sides)
				local num_bot_groups = #bot_groups

				for i = 1, num_bot_groups do
					local bot_group = bot_groups[i]

					bot_group:aoe_threat_created(position, shape, size, rotation, duration)
				end
			end
		end
	elseif state == hazard_state.broken then
		if self._fuse_active then
			Unit.flow_event(unit, "lua_fuse_stop")

			self._fuse_active = false
		end

		if self._is_server then
			self:_trigger_hazard()
			self._owner_system:disable_update_function(self.__class_name, "update", unit, self)

			self._running_update = false
		end

		self._content = hazard_content.none

		Unit.set_material(unit, "hazard_paint", hazard_material.empty_paint)
		self:remove_from_broadphase()
	elseif state == hazard_state.idle then
		if self._fuse_active then
			Unit.flow_event(unit, "lua_fuse_stop")

			self._fuse_active = false
		end

		if self._running_update then
			self._owner_system:disable_update_function(self.__class_name, "update", unit, self)

			self._running_update = false
		end
	end

	self:_update_mesh_visuals()

	if self._is_server then
		local unit_level_index = Managers.state.unit_spawner:level_index(unit)
		local state_id = NetworkLookup.hazard_prop_states[state]
		local game_session_manager = Managers.state.game_session

		game_session_manager:send_rpc_clients("rpc_hazard_prop_set_state", unit_level_index, state_id)
	end
end

function HazardPropExtension:_update_mesh_visuals()
	local intact = self._current_state ~= hazard_state.broken
	local unit = self._unit

	Unit.set_visibility(unit, "intact", intact)
	Unit.set_visibility(unit, "broken", not intact)

	local intact_colliders = self._intact_colliders

	for i = 1, #intact_colliders do
		Actor.set_scene_query_enabled(intact_colliders[i], intact)
	end

	local broken_colliders = self._broken_colliders

	for i = 1, #broken_colliders do
		Actor.set_scene_query_enabled(broken_colliders[i], not intact)
	end
end

function HazardPropExtension:add_damage(damage_amount, hit_actor, attack_direction)
	if not self._is_server or self._content == hazard_content.none then
		return
	end

	if self._trigger_timer == TRIGGER_TIME then
		return
	end

	if self._current_state == hazard_state.idle then
		Vector3Box.store(self._trigger_direction, attack_direction)
		self:set_current_state(hazard_state.triggered)
	elseif self._current_state == hazard_state.triggered then
		self:set_current_state(hazard_state.exploding)
	end
end

function HazardPropExtension:_trigger_hazard()
	local content = self._content
	local unit = self._unit

	if content == hazard_content.explosion then
		local world = Managers.world:world("level_world")
		local physics_world = World.physics_world(world)
		local explosion_position = Unit.world_position(unit, Unit.node(unit, "c_explosion"))
		local explosion_template = explosion_settings.explosion_template
		local power_level = explosion_settings.power_level
		local charge_level = explosion_settings.charge_level
		local attack_type = explosion_settings.explosion

		Explosion.create_explosion(self._world, physics_world, explosion_position, Vector3.up(), unit, explosion_template, power_level, charge_level, attack_type)
	elseif content == hazard_content.fire then
		local world = Managers.world:world("level_world")
		local physics_world = World.physics_world(world)
		local spawn_position = Unit.world_position(unit, Unit.node(unit, "c_explosion"))
		local explosion_position = Unit.world_position(unit, Unit.node(unit, "c_explosion"))
		local explosion_template = fire_settings.explosion_template
		local liquid_area_template = fire_settings.liquid_area_template
		local power_level = fire_settings.power_level
		local charge_level = fire_settings.charge_level
		local attack_type = fire_settings.explosion

		Explosion.create_explosion(self._world, physics_world, explosion_position, Vector3.up(), unit, explosion_template, power_level, charge_level, attack_type)

		local attack_direction = self._trigger_direction:unbox()
		attack_direction.z = 0
		spawn_position = spawn_position - attack_direction
		local los_hit, hit_position, _, _ = PhysicsWorld.raycast(physics_world, spawn_position, Vector3.down(), fire_settings.raycast_distance, "closest", "collision_filter", "filter_player_mover")

		if los_hit then
			spawn_position = hit_position
		end

		LiquidArea.try_create(spawn_position, Vector3.down(), self._nav_world, liquid_area_template, unit)
	end
end

function HazardPropExtension:trigger_timer()
	return self._trigger_timer
end

function HazardPropExtension:start_trigger_timer()
	self._trigger_timer = TRIGGER_TIME
end

function HazardPropExtension:broadphase_radius()
	return self._broadphase_radius
end

function HazardPropExtension:broadphase_position()
	return self._broadphase_position:unbox()
end

function HazardPropExtension:update(unit, dt, t)
	if self._current_state == hazard_state.triggered then
		if self._is_server and self._trigger_timer > 0 then
			self._trigger_timer = self._trigger_timer - dt

			if self._trigger_timer <= 0 then
				self:set_current_state(hazard_state.exploding)
			end
		end
	elseif self._current_state == hazard_state.exploding and self._is_server then
		self:set_current_state(hazard_state.broken)
	end
end

function HazardPropExtension:destroy()
	self:remove_from_broadphase()

	self._broadphase = nil
	self._broadphase_system = nil
	self._broadphase_position = nil
end

return HazardPropExtension
