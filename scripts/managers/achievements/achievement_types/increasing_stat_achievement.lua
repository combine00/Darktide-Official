local StatDefinitions = require("scripts/managers/stats/stat_definitions")
local IncreasingStatAchievement = {
	trigger_type = "stat",
	trigger = function (achievement_definition, scratch_pad, player_id, stat_name, stat_value)
		return achievement_definition.target <= stat_value
	end,
	setup = function (achievement_definition, scratch_pad, player_id)
		local stat_value = Managers.stats:read_user_stat(player_id, achievement_definition.stat_name)

		return stat_value and achievement_definition.target <= stat_value
	end,
	verifier = function (achievement_definition)
		if type(achievement_definition.stat_name) ~= "string" then
			return false, "missing stat"
		end

		if type(achievement_definition.target) ~= "number" then
			return false, "missing target"
		end

		if not StatDefinitions[achievement_definition.stat_name] then
			return false, "stat does not exist"
		end

		return true
	end,
	get_triggers = function (achievement_definition)
		return achievement_definition.stat_name
	end
}

function IncreasingStatAchievement.get_progress(achievement_definition, player, prioritize_running)
	local player_id = player.remote and player.stat_id or player:local_player_id()
	local stat_name = achievement_definition.stat_name
	local prefer_running = achievement_definition.flags.prioritize_running or prioritize_running

	if prefer_running and StatDefinitions[stat_name].running_stat then
		stat_name = StatDefinitions[stat_name].running_stat
	end

	return Managers.stats:read_user_stat(player_id, stat_name), achievement_definition.target
end

return IncreasingStatAchievement
