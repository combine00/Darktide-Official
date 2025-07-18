local view_settings = {
	display_name = "loc_crafting_view_display_name",
	state_bound = true,
	path = "scripts/ui/views/crafting_mechanicus_replace_trait_view/crafting_mechanicus_replace_trait_view",
	package = "packages/ui/views/crafting_mechanicus_replace_trait_view/crafting_mechanicus_replace_trait_view",
	class = "CraftingReplaceTraitView",
	disable_game_world = true,
	load_in_hub = true,
	levels = {
		"content/levels/ui/crafting_view_itemization/crafting_view_itemization"
	},
	testify_flags = {
		ui_views = false
	}
}

return settings("CraftingMechanicusReplaceTraitViewDeclarationSettings", view_settings)
