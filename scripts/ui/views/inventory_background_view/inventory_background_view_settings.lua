local discard_items_popup_window_size = {
	800,
	800
}
local discard_items_popup_grid_size = {
	discard_items_popup_window_size[1] - 40,
	discard_items_popup_window_size[2] - 100
}
local inventory_background_view = {
	world_layer = 2,
	total_blur_duration = 0.5,
	timer_name = "ui",
	viewport_type = "default",
	shading_environment = "content/shading_environments/ui/inventory",
	viewport_name = "ui_inventory_viewport",
	viewport_layer = 1,
	level_name = "content/levels/ui/inventory/inventory",
	default_slot = "slot_primary",
	loadout_update_timeout = 3,
	world_name = "ui_inventory",
	discard_items_popup_window_size = discard_items_popup_window_size,
	discard_items_popup_grid_size = discard_items_popup_grid_size,
	allowed_slots = {
		"slot_primary",
		"slot_secondary"
	},
	ignored_slots = {
		"slot_pocketable",
		"slot_pocketable_small",
		"slot_luggable",
		"slot_support_ability",
		"slot_combat_ability",
		"slot_grenade_ability"
	},
	animations_per_archetype = {
		psyker = {
			initial_event = "character_customization_idle",
			events = {
				"character_customization_crime_select_idle",
				"character_customization_idle"
			}
		},
		veteran = {
			initial_event = "character_customization_idle",
			events = {
				"character_customization_crime_select_idle",
				"character_customization_idle"
			}
		},
		zealot = {
			initial_event = "character_customization_idle",
			events = {
				"character_customization_crime_select_idle",
				"character_customization_idle"
			}
		},
		ogryn = {
			initial_event = "character_customization_idle",
			events = {
				"character_customization_crime_select_idle",
				"character_customization_idle"
			}
		}
	}
}

return settings("InventoryBackgroundViewSettings", inventory_background_view)
