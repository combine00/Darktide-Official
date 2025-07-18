local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local view_settings = {
	parent_transition_view = "inventory_background_view",
	state_bound = true,
	path = "scripts/ui/views/masteries_overview_view/masteries_overview_view",
	package = "packages/ui/views/masteries_overview_view/masteries_overview_view",
	class = "MasteriesOverviewView",
	disable_game_world = true,
	load_in_hub = true,
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

return settings("MasteriesOverviewViewDeclarationSettings", view_settings)
