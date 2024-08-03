local GameModeManagerTestify = {}

function GameModeManagerTestify.complete_game_mode(game_mode_manager)
	game_mode_manager:complete_game_mode()
end

function GameModeManagerTestify.end_conditions_met(game_mode_manager)
	return game_mode_manager:end_conditions_met()
end

function GameModeManagerTestify.end_conditions_met_outcome(game_mode_manager)
	return game_mode_manager:end_conditions_met_outcome()
end

return GameModeManagerTestify
