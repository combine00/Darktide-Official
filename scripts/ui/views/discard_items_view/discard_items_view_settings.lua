local elements_width = 440
local window_size = {
	elements_width + 60,
	770
}
local content_size = {
	elements_width,
	window_size[2]
}
local discard_items_view_settings = {
	window_size = window_size,
	content_size = content_size,
	discard_button_size = {
		440,
		40
	},
	checkbox_size = {
		440,
		50
	},
	animation_event_by_archetype = {
		psyker = "human_psyker_inspect_pose",
		adamant = "human_adamant_inspect_pose",
		ogryn = "ogryn_inspect_pose",
		veteran = "human_veteran_inspect_pose",
		zealot = "human_zealot_inspect_pose"
	},
	archetype_badge_texture_by_name = {
		psyker = "content/ui/textures/icons/class_badges/psyker_01_01",
		adamant = "content/ui/textures/icons/class_badges/adamant_01_01",
		ogryn = "content/ui/textures/icons/class_badges/ogryn_01_01",
		veteran = "content/ui/textures/icons/class_badges/veteran_01_01",
		zealot = "content/ui/textures/icons/class_badges/zealot_01_01"
	}
}

return settings("DiscardItemsViewSettings", discard_items_view_settings)
