local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")
local view_settings = {
	killswitch = "show_group_finder",
	display_name = "loc_crafting_view_display_name",
	use_transition_ui = true,
	killswitch_unavailable_header = "loc_action_interaction_unavailable",
	killswitch_unavailable_description = "loc_popup_unavailable_view_group_finder_description",
	path = "scripts/ui/views/group_finder_view/group_finder_view",
	package = "packages/ui/views/group_finder_view/group_finder_view",
	state_bound = true,
	class = "GroupFinderView",
	disable_game_world = true,
	load_in_hub = true,
	levels = {
		"content/levels/ui/group_finder/group_finder"
	},
	enter_sound_events = {
		UISoundEvents.group_finder_enter
	},
	exit_sound_events = {
		UISoundEvents.group_finder_exit
	},
	wwise_states = {
		options = WwiseGameSyncSettings.state_groups.options.ingame_menu
	},
	testify_flags = {
		ui_views = false
	}
}

return settings("GroupFinderViewDeclarationSettings", view_settings)
