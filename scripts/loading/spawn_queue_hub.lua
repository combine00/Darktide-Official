local SpawnQueueInterface = require("scripts/loading/spawn_queue_interface")
local SpawnQueueHub = class("SpawnQueueHub")

function SpawnQueueHub:init(group_delay)
	self._delay = group_delay
	self._waiting = {}
	self._spawning = {}
	self._waiting_age = 0
	self._group_id_type_info = Network.type_info("spawn_group")
	self._group_id_counter = self._group_id_type_info.min
end

function SpawnQueueHub:reset()
	table.clear(self._waiting)
	table.clear(self._spawning)

	self._waiting_age = 0
end

function SpawnQueueHub:place_in_queue(peer_id, callback)
	if table.is_empty(self._waiting) then
		self._waiting_age = 0
	end

	self._waiting[peer_id] = callback
end

function SpawnQueueHub:remove_from_queue(peer_id)
	self._waiting[peer_id] = nil
	self._spawning[peer_id] = nil
end

function SpawnQueueHub:ready_group()
	if self._waiting_age < self._delay or table.size(self._waiting) == 0 then
		return nil
	end

	return self:_generate_group_id()
end

function SpawnQueueHub:trigger_group(group_id)
	local peer_id, callback = next(self._waiting)
	self._waiting[peer_id] = nil
	self._spawning[peer_id] = group_id

	callback(group_id)

	return {
		peer_id
	}
end

function SpawnQueueHub:retire_group(group_id)
	for peer_id, spawning_group_id in pairs(self._spawning) do
		if spawning_group_id == group_id then
			self._spawning[peer_id] = nil

			return
		end
	end
end

function SpawnQueueHub:set_delay_time(group_delay)
	self._delay = group_delay
end

function SpawnQueueHub:update(dt)
	if table.is_empty(self._waiting) then
		return
	end

	self._waiting_age = self._waiting_age + dt
end

function SpawnQueueHub:_generate_group_id()
	local id = self._group_id_counter
	self._group_id_counter = self._group_id_counter + 1

	if self._group_id_type_info.max < self._group_id_counter then
		self._group_id_counter = self._group_id_type_info.min
	end

	return id
end

implements(SpawnQueueHub, SpawnQueueInterface)

return SpawnQueueHub
