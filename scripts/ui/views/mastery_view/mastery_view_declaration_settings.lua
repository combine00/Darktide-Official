local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local view_settings = {
	load_in_hub = true,
	state_bound = true,
	use_transition_ui = true,
	path = "scripts/ui/views/mastery_view/mastery_view",
	package = "packages/ui/views/mastery_view/mastery_view",
	class = "MasteryView",
	disable_game_world = false,
	levels = {
		"content/levels/ui/cosmetics_preview/cosmetics_preview"
	},
	enter_sound_events = {
		UISoundEvents.default_menu_enter
	},
	exit_sound_events = {
		UISoundEvents.default_menu_exit
	},
	wwise_states = {
		options = WwiseGameSyncSettings.state_groups.options.ingame_menu
	},
	testify_flags = {
		ui_views = false
	}
}

return settings("MasteryViewDeclarationSettings", view_settings)
