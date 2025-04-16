local RESOURCES = {
	vfx = {},
	sfx = {
		idle_loop = {
			stop = "wwise/events/player/stop_buff_drone_engine_loop",
			start = "wwise/events/player/play_buff_drone_engine_loop"
		},
		deployed_loop = {
			stop = "wwise/events/player/stop_buff_drone_buff_loop",
			start = "wwise/events/player/play_buff_drone_buff_loop"
		}
	}
}
local CENTER_NODE_NAME = "fx_center"
local AreaBuffDrone = component("AreaBuffDrone")

function AreaBuffDrone:init(unit)
	self._unit = unit
	self._has_setup = false
end

function AreaBuffDrone:editor_validate(unit)
	local success = true
	local error_message = ""

	return success, error_message
end

function AreaBuffDrone:enable(unit)
	return
end

function AreaBuffDrone:disable(unit)
	return
end

function AreaBuffDrone:destroy(unit)
	if self._arming_playing_id then
		self:_stop_looping_sound(nil, self._arming_playing_id, nil)

		self._arming_playing_id = nil
	end

	if self._idle_playing_id then
		self:_stop_looping_sound(nil, self._idle_playing_id, RESOURCES.sfx.deployed_loop.stop)

		self._idle_playing_id = nil
	end

	if self._source_id then
		WwiseWorld.destroy_manual_source(self._wwise_world, self._source_id)
	end
end

function AreaBuffDrone:update(unit, dt, t)
	return
end

function AreaBuffDrone:_setup()
	if self._has_setup then
		return
	end

	local unit = self._unit
	local world = Unit.world(unit)
	local wwise_world = Wwise.wwise_world(world)
	self._world = world
	self._wwise_world = wwise_world
	local source_id = WwiseWorld.make_manual_source(wwise_world, unit, Unit.node(unit, CENTER_NODE_NAME))
	self._source_id = source_id
	self._has_setup = true
end

function AreaBuffDrone:_set_active()
	self:_setup()

	local playing_id = self:_start_looping_sound(self._source_id, RESOURCES.sfx.idle_loop.start)
	self._arming_playing_id = playing_id
end

function AreaBuffDrone:_deploy()
	self:_setup()

	local source_id = self._source_id

	if self._arming_playing_id then
		self:_stop_looping_sound(source_id, self._arming_playing_id, RESOURCES.sfx.idle_loop.stop)

		self._arming_playing_id = nil
	end

	local playing_id = self:_start_looping_sound(source_id, RESOURCES.sfx.deployed_loop.start)
	self._idle_playing_id = playing_id
end

function AreaBuffDrone:_start_looping_sound(source_id, event_name)
	local wwise_world = self._wwise_world
	local playing_id = WwiseWorld.trigger_resource_event(wwise_world, event_name, source_id)

	return playing_id
end

function AreaBuffDrone:_stop_looping_sound(source_id, playing_id, event_name)
	local wwise_world = self._wwise_world

	if event_name and source_id and WwiseWorld.has_source(wwise_world, source_id) then
		WwiseWorld.trigger_resource_event(wwise_world, event_name, source_id)
	elseif playing_id then
		WwiseWorld.stop_event(wwise_world, playing_id)
	end
end

function AreaBuffDrone:_stop_idle_vfx_loop()
	local world = self._world
	local idle_particle_ids = self._idle_particle_ids

	if self._idle_particle_ids then
		for ii = 1, #idle_particle_ids do
			World.destroy_particles(world, idle_particle_ids[ii])
		end

		table.clear(idle_particle_ids)
	end
end

function AreaBuffDrone.events:area_buff_drone_set_active()
	self:_set_active()
end

function AreaBuffDrone.events:area_buff_drone_deploy()
	self:_deploy()
end

AreaBuffDrone.component_data = {}

return AreaBuffDrone
