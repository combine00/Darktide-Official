local MultiplayerSessionManagerTestify = {}

function MultiplayerSessionManagerTestify.exit_to_main_menu(multiplayer_session_manager)
	multiplayer_session_manager:leave("exit_to_main_menu")
end

return MultiplayerSessionManagerTestify
