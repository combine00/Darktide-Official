local LobbyViewTestify = {}

function LobbyViewTestify.lobby_set_ready_status(lobby_view, is_ready)
	Log.info("Testify", "Setting local player ready status to %s", is_ready)
	lobby_view:set_own_player_ready_status(is_ready)

	if lobby_view:_own_player_ready_status() ~= true then
		return Testify.RETRY
	end
end

function LobbyViewTestify.accept_mission_board_vote()
	if GameParameters.network_wan then
		return Testify.RETRY
	end
end

return LobbyViewTestify
