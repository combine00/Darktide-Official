local MinionSpawnManagerTestify = {}

function MinionSpawnManagerTestify.spawn_minion(minion_spawn_manager, minion_data)
	local spawn_position = Vector3(minion_data.spawn_position.x, minion_data.spawn_position.y, minion_data.spawn_position.z)
	local target_spawn = minion_spawn_manager:spawn_minion(minion_data.breed_name, spawn_position, Quaternion.identity(), minion_data.breed_side)

	return target_spawn
end

function MinionSpawnManagerTestify.spawned_minions(minion_spawn_manager)
	local spawned_minions = minion_spawn_manager:spawned_minions()

	return spawned_minions
end

return MinionSpawnManagerTestify
