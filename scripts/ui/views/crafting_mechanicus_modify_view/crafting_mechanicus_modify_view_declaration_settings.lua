local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local view_settings = {
	state_bound = true,
	display_name = "loc_crafting_view_display_name",
	load_in_hub = true,
	path = "scripts/ui/views/crafting_mechanicus_modify_view/crafting_mechanicus_modify_view",
	package = "packages/ui/views/crafting_mechanicus_modify_view/crafting_mechanicus_modify_view",
	class = "CraftingModifyView",
	disable_game_world = true,
	levels = {
		"content/levels/ui/crafting_view_itemization/crafting_view_itemization"
	},
	enter_sound_events = {
		UISoundEvents.default_menu_enter
	},
	exit_sound_events = {
		UISoundEvents.default_menu_exit
	},
	testify_flags = {
		ui_views = false
	}
}

return settings("CraftingMechanicusModifyViewDeclarationSettings", view_settings)
