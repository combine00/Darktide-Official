local SpawnQueueInterface = require("scripts/loading/spawn_queue_interface")
local SpawnQueue = class("SpawnQueue")

function SpawnQueue:init(group_delay)
	self._delay = group_delay
	self._waiting = {
		peers = {}
	}
	self._waiting_group_id = nil
	self._spawning = {
		peers = {}
	}
	self._spawning_group_id = nil
	self._spawned = {}
	self._waiting_age = 0
	self._group_id_type_info = Network.type_info("spawn_group")
	self._group_id_counter = self._group_id_type_info.min
end

function SpawnQueue:reset()
	table.clear(self._waiting.peers)

	self._waiting_group_id = nil

	table.clear(self._spawning.peers)

	self._spawning_group_id = nil

	table.clear(self._spawned)

	self._waiting_age = 0
end

function SpawnQueue:place_in_queue(peer_id, callback)
	if table.is_empty(self._waiting.peers) then
		self._waiting_age = 0
	end

	self._waiting.peers[peer_id] = callback
end

function SpawnQueue:remove_from_queue(peer_id)
	self._waiting.peers[peer_id] = nil
	self._spawning.peers[peer_id] = nil
	local index = table.find(self._spawned, peer_id)

	if index then
		table.swap_delete(self._spawned, index)
	end
end

function SpawnQueue:ready_group()
	return self._waiting_group_id
end

function SpawnQueue:trigger_group(group_id)
	local peers = {}

	for peer, _ in pairs(self._waiting.peers) do
		peers[#peers + 1] = peer
	end

	table.sort(peers)

	self._spawning.peers = self._waiting.peers
	self._waiting.peers = self._spawning.peers
	self._spawning_group_id = self._waiting_group_id
	self._waiting_group_id = self._spawning_group_id

	for peer, callback in pairs(self._spawning.peers) do
		callback(self._spawning_group_id)
	end

	return peers
end

function SpawnQueue:retire_group(group_id)
	local peers = table.keys(self._spawning.peers)

	table.sort(peers)

	for peer_index = 1, #peers do
		local peer = peers[peer_index]
		self._spawned[#self._spawned + 1] = peer
	end

	table.clear(self._spawning.peers)

	self._spawning_group_id = nil
end

function SpawnQueue:set_delay_time(group_delay)
	self._delay = group_delay
end

function SpawnQueue:update(dt)
	if table.is_empty(self._waiting.peers) then
		return
	end

	self._waiting_age = self._waiting_age + dt

	if self._spawning_group_id == nil and self._waiting_group_id == nil then
		local wait_reached = self._delay <= self._waiting_age
		local is_everyone_waiting = self:_is_everyone_waiting()
		local is_game_filled = self:_is_game_filled()

		if wait_reached or is_everyone_waiting or is_game_filled then
			self._waiting_group_id = self:_generate_group_id()
		end
	end
end

function SpawnQueue:_is_everyone_waiting()
	return Managers.connection:num_members() < table.size(self._waiting.peers)
end

function SpawnQueue:_is_game_filled()
	local num_waiting_peers = table.size(self._waiting.peers)
	local num_spawned = #self._spawned
	local max_members = Managers.connection:max_members() or 0

	return num_waiting_peers + num_spawned == max_members + 1
end

function SpawnQueue:_generate_group_id()
	local id = self._group_id_counter
	self._group_id_counter = self._group_id_counter + 1

	if self._group_id_type_info.max < self._group_id_counter then
		self._group_id_counter = self._group_id_type_info.min
	end

	return id
end

implements(SpawnQueue, SpawnQueueInterface)

return SpawnQueue
