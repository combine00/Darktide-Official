local MetaAchievement = {
	trigger_type = "meta"
}

function MetaAchievement.trigger(achievement_definition, scratch_pad, player_id, achievement_id)
	local _scratch_pad = scratch_pad[achievement_definition.id]
	_scratch_pad.__size = _scratch_pad.__size + 1
	scratch_pad[achievement_definition.id] = _scratch_pad

	return achievement_definition.target <= _scratch_pad.__size
end

function MetaAchievement.setup(achievement_definition, scratch_pad, player_id)
	local _scratch_pad = {
		__size = 0
	}
	local achievements = achievement_definition.achievements

	for achievement_id, _ in pairs(achievements) do
		if Managers.achievements:_achievement_completed(player_id, achievement_id) then
			_scratch_pad[achievement_id] = true
			_scratch_pad.__size = _scratch_pad.__size + 1
		end
	end

	scratch_pad[achievement_definition.id] = _scratch_pad

	return achievement_definition.target <= _scratch_pad.__size
end

function MetaAchievement.verifier(achievement_definition)
	local target = achievement_definition.target
	local achievements = achievement_definition.achievements
	local has_target = type(target) == "number"
	local has_achievements = type(achievements) == "table"

	if not has_target or not has_achievements then
		return false
	end

	if table.size(achievements) < target then
		return false
	end

	return true
end

function MetaAchievement.get_triggers(achievement_definition)
	return achievement_definition.achievements
end

function MetaAchievement.get_progress(achievement_definition, player)
	local player_id = player.remote and player.stat_id or player:local_player_id()
	local result = 0
	local achievements = achievement_definition.achievements

	for achievement_id, _ in pairs(achievements) do
		local is_done = Managers.achievements:_achievement_completed(player_id, achievement_id)

		if is_done then
			result = result + 1
		end
	end

	local target = achievement_definition.target

	return result, target
end

return MetaAchievement
