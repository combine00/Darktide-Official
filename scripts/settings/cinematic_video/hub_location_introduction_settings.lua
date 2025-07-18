local hub_location_introduction_settings = {
	mission_board_view = {
		video_template = "hli_mission_board",
		narrative_event_name = "hli_mission_board_viewed",
		video_template_by_archetype = {
			adamant = "hli_mission_board_adamant"
		}
	},
	barber_vendor_background_view = {
		video_template = "hli_barbershop",
		narrative_event_name = "hli_barbershop_viewed"
	},
	contracts_background_view = {
		video_template = "hli_contracts",
		narrative_event_name = "hli_contracts_viewed"
	},
	crafting_view = {
		video_template = "hli_crafting_station_underground",
		narrative_event_name = "hli_crafting_station_underground_viewed"
	},
	credits_vendor_background_view = {
		video_template = "hli_gun_shop",
		narrative_event_name = "hli_gun_shop_viewed"
	},
	penance_overview_view = {
		video_template = "hli_penances",
		narrative_event_name = "hli_penances_viewed"
	}
}

return settings("HubLocationIntroductionSettings", hub_location_introduction_settings)
