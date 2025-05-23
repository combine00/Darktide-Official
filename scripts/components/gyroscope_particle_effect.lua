local GyroscopeParticleEffect = component("GyroscopeParticleEffect")

function GyroscopeParticleEffect:init(unit)
	self._unit = unit
	self._world = Unit.world(unit)
	self._particle_name = self:get_data(unit, "particle")
	self._particle_id = nil

	return true
end

function GyroscopeParticleEffect:editor_validate(unit)
	local success = true
	local error_message = ""

	return success, error_message
end

function GyroscopeParticleEffect:enable(unit)
	return
end

function GyroscopeParticleEffect:disable(unit)
	return
end

function GyroscopeParticleEffect:destroy(unit)
	self:_destroy_particle()
end

function GyroscopeParticleEffect:update(unit, dt, t)
	local world = self._world
	local particle_id = self._particle_id

	if particle_id then
		local alive = World.are_particles_playing(world, particle_id)

		if alive then
			local world_position = Unit.world_position(unit, 1)

			World.move_particles(world, particle_id, world_position, Quaternion.identity())

			return true
		end
	end

	self._particle_id = nil

	return true
end

function GyroscopeParticleEffect:_create_particle()
	local world_position = Unit.world_position(self._unit, 1)
	self._particle_id = World.create_particles(self._world, self._particle_name, world_position, Quaternion.identity())
end

function GyroscopeParticleEffect:_destroy_particle()
	local world = self._world
	local particle_id = self._particle_id

	if particle_id then
		local alive = World.are_particles_playing(world, particle_id)

		if alive then
			World.destroy_particles(world, particle_id)
		end

		self._particle_id = nil
	end
end

function GyroscopeParticleEffect.events:create_particle(unit)
	self:_create_particle()
end

function GyroscopeParticleEffect.events:destroy_particle(unit)
	self:_destroy_particle()
end

function GyroscopeParticleEffect:create_particle()
	self:_create_particle()
end

function GyroscopeParticleEffect:destroy_particle()
	self:_destroy_particle()
end

GyroscopeParticleEffect.component_data = {
	particle = {
		ui_type = "resource",
		preview = false,
		value = "",
		ui_name = "Particle",
		filter = "particles"
	},
	inputs = {
		create_particle = {
			accessibility = "public",
			type = "event"
		},
		destroy_particle = {
			accessibility = "public",
			type = "event"
		}
	}
}

return GyroscopeParticleEffect
