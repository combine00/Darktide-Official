local ready_slot_margin = 5
local constant_element_mission_lobby_status_settings = {
	ready_slot_size = {
		22 + ready_slot_margin,
		55
	},
	active_view_position = {
		inventory_view = {
			nil,
			0
		},
		talent_builder_view = {
			nil,
			0
		}
	},
	allowed_views = {
		options_view = true,
		group_finder_view = true,
		system_view = true,
		social_menu_view = true,
		social_menu_roster_view = true
	}
}

return settings("ConstantGroupFinderStatusSettings", constant_element_mission_lobby_status_settings)
