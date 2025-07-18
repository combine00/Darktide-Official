local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local view_settings = {
	state_bound = true,
	path = "scripts/ui/views/havoc_lore_view/havoc_lore_view",
	package = "packages/ui/views/havoc_lore_view/havoc_lore_view",
	class = "HavocLoreView",
	disable_game_world = true,
	load_in_hub = true,
	enter_sound_events = {
		UISoundEvents.story_mission_lore_screen_enter
	},
	exit_sound_events = {
		UISoundEvents.story_mission_lore_screen_exit
	},
	testify_flags = {
		ui_views = false
	}
}

return settings("HavocLoreViewDeclarationSettings", view_settings)
