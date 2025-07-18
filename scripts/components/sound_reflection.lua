local SoundReflection = component("SoundReflection")

function SoundReflection:init(unit)
	if rawget(_G, "AnimationEditor") then
		return
	end

	self._unit = unit

	if not Unit.has_node(unit, "j_head") then
		return false
	end

	local first_person_extension = ScriptUnit.has_extension(self._unit, "first_person_system")

	if not first_person_extension then
		return false
	end

	self._first_person_extension = first_person_extension
	local world = Unit.world(unit)
	self._world = world
	self._wwise_world = Wwise.wwise_world(world)
	self._physics_world = World.physics_world(world)
	self._node_index = Unit.node(unit, "j_head")
	self._max_distance = 15
	self._t = 0
	self._update_time = 0
	self._update_interval = 1
	self._directions = {
		QuaternionBox(Quaternion.axis_angle(Vector3.up(), 45)),
		QuaternionBox(Quaternion.axis_angle(Vector3.up(), -45)),
		QuaternionBox(Quaternion.axis_angle(Vector3.up(), 90)),
		QuaternionBox(Quaternion.axis_angle(Vector3.up(), -90))
	}
	self._distances = {}
	self._positions = {}
	self._materials = {}
	self._use_material_reactions = true
	self._last_position = Vector3Box(0, 0, 0)
	self._material_reaction_event = "wwise/events/weapon/play_weapon_material_reaction_rattle"
	local MaterialQuerySettings = require("scripts/settings/material_query_settings")
	self._surface_materials_lookup = MaterialQuerySettings.surface_materials_lookup
	self._event_time = 0
	self._event_limit = 0.3

	return true
end

function SoundReflection:editor_init(unit)
	return
end

function SoundReflection:editor_validate(unit)
	return true, ""
end

function SoundReflection.events:update_sound_reflection()
	if self._event_time <= self._t then
		self._event_time = self._t + self._event_limit

		self:_set_reflection(true)
	end
end

function SoundReflection:enable(unit)
	return
end

function SoundReflection:disable(unit)
	return
end

function SoundReflection:destroy(unit)
	return
end

function SoundReflection:editor_update(unit, dt, t)
	return
end

function SoundReflection:update(unit, dt, t)
	self._t = t

	if self._update_time <= t then
		self._update_time = t + self._update_interval

		self:_set_reflection()
	end

	return true
end

function SoundReflection:_set_reflection(from_event)
	local distances = self._distances
	local positions = self._positions
	local directions = self._directions
	local materials = self._materials
	local max_distance = self._max_distance
	local position = Unit.world_position(self._unit, self._node_index)
	local rotation = self._first_person_extension:extrapolated_rotation()
	local query_material = self._use_material_reactions and from_event and Vector3.distance(position, self._last_position:unbox()) > 0.1

	self._last_position:store(position)

	for ii = 1, #directions do
		local current_rotation = Quaternion.multiply(rotation, directions[ii]:unbox())
		local distance, reflection_position, material = self:_reflection_distance(position, Quaternion.forward(current_rotation), max_distance, query_material)
		distance = math.clamp(distance or max_distance, 0, max_distance)
		distances[ii] = distance
		positions[ii] = reflection_position
		materials[ii] = material
	end

	local index = #directions + 1
	distances[index], positions[index], materials[index] = self:_reflection_distance(position, Quaternion.up(rotation), max_distance, query_material)

	self:_set_wwise_reflection_parameters()

	if self._use_material_reactions and from_event then
		self:_play_material_reaction()
	end
end

local INDEX_POSITION = 1
local INDEX_ACTOR = 4
local QUERY_MATERIAL_CONTEXTS = {
	"surface_material"
}
local _query_material_buffer = {}

function SoundReflection:_reflection_distance(position, direction, max_distance, query_material)
	local results = PhysicsWorld.raycast(self._physics_world, position, direction, max_distance, "all", "types", "both", "collision_filter", "filter_player_character_shooting_raycast_statics")

	if results then
		local surface_materials_lookup = self._surface_materials_lookup

		for ii = 1, #results do
			local result = results[ii]
			local actor = result[INDEX_ACTOR]
			local unit = Actor.unit(actor)

			if unit ~= nil and unit ~= self._unit then
				local hit_pos = result[INDEX_POSITION]
				local hit_distance = Vector3.distance(hit_pos, position)
				local material = nil

				if query_material then
					local material_ids = Unit.query_material(unit, hit_pos - direction * 0.2, hit_pos + direction * 0.2, QUERY_MATERIAL_CONTEXTS, _query_material_buffer)
					local material_id = material_ids[1]

					if material_id then
						material = surface_materials_lookup[material_id]
					end
				end

				return hit_distance, hit_pos, material
			end
		end
	end
end

function SoundReflection:_set_wwise_reflection_parameters()
	local wwise_world = self._wwise_world
	local distances = self._distances
	local reflection_avg = math.abs(distances[1]) * math.abs(distances[2]) * math.abs(distances[3]) * math.abs(distances[4]) / 4

	WwiseWorld.set_global_parameter(wwise_world, "reflection_lf", distances[1])
	WwiseWorld.set_global_parameter(wwise_world, "reflection_rf", distances[2])
	WwiseWorld.set_global_parameter(wwise_world, "reflection_lb", distances[3])
	WwiseWorld.set_global_parameter(wwise_world, "reflection_rb", distances[4])
	WwiseWorld.set_global_parameter(wwise_world, "reflection_avg", reflection_avg)
end

function SoundReflection:_play_material_reaction()
	local wwise_world = self._wwise_world
	local material_reaction_event = self._material_reaction_event
	local positions = self._positions
	local materials = self._materials

	for ii = 1, #positions do
		if positions[ii] ~= nil then
			local auto_source_id = WwiseWorld.make_auto_source(wwise_world, positions[ii])

			if materials[ii] ~= nil then
				WwiseWorld.set_switch(wwise_world, "surface_material", materials[ii], auto_source_id)
			else
				WwiseWorld.set_switch(wwise_world, "surface_material", "default", auto_source_id)
			end

			WwiseWorld.trigger_resource_event(wwise_world, material_reaction_event, auto_source_id)
		end
	end
end

SoundReflection.component_config = {
	disable_event_public = false,
	enable_event_public = false,
	starts_enabled_default = true
}
SoundReflection.component_data = {}

return SoundReflection
