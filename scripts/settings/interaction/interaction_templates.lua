local interaction_templates = {
	default = {
		only_once = false,
		start_anim_event = "arms_down",
		stop_anim_event = "arms_down",
		description = "loc_generic_interaction",
		start_anim_event_3p = "interaction_revive",
		action_text = "loc_generic_interaction",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 3,
		interaction_class_name = "base",
		anim_duration_variable_name_3p = "assist_interaction_duration"
	},
	ammunition = {
		action_text = "loc_action_interaction_pickup",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/ammunition",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "ammunition"
	},
	chest = {
		action_text = "loc_action_interaction_open",
		ui_interaction_type = "default",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "chest"
	},
	decoding = {
		action_text = "loc_action_interaction_decode",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		ui_interaction_type = "mission",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "decoding"
	},
	door_control_panel = {
		action_text = "loc_action_interaction_use",
		ui_interaction_type = "default",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "door_control_panel"
	},
	setup_decoding = {
		wield_slot = "slot_device",
		ui_interaction_type = "mission",
		stop_anim_event = "servo_finished",
		start_anim_event = "servo_start",
		interrupt_anim_event = "servo_interrupt",
		action_text = "loc_action_interaction_plant",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		interaction_priority = 1,
		duration = 3.8,
		interaction_class_name = "setup_decoding"
	},
	gamemode_havoc = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/havoc",
		description = "loc_havoc_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "gamemode_havoc",
		ui_view_name = "havoc_background_view"
	},
	grenade = {
		action_text = "loc_action_interaction_pickup",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/grenade",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "grenade"
	},
	health = {
		action_text = "loc_action_interaction_use",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/respawn",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "health"
	},
	health_station = {
		start_anim_event = "arms_down",
		taggable = true,
		stop_anim_event = "arms_down",
		ui_interaction_type = "point_of_interest",
		start_anim_event_3p = "interaction_revive",
		action_text = "loc_action_interaction_use",
		interaction_icon = "content/ui/materials/hud/interactions/icons/respawn",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 3,
		interaction_class_name = "health_station"
	},
	luggable = {
		action_text = "loc_action_interaction_pickup",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "luggable"
	},
	luggable_socket = {
		action_text = "loc_action_interaction_insert",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		ui_interaction_type = "pickup",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "luggable_socket"
	},
	mission_board = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/mission_board",
		description = "loc_mission_board_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "mission_board",
		ui_view_name = "mission_board_view"
	},
	crafting = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/forge",
		description = "loc_crafting_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "crafting",
		ui_view_name = "crafting_view"
	},
	penances = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/penances",
		description = "loc_penances_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "penances",
		ui_view_name = "penance_overview_view"
	},
	inbox = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/inbox",
		description = "loc_training_ground_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "inbox",
		ui_view_name = "inbox_view"
	},
	body_shop = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/barber",
		description = "loc_training_ground_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "body_shop",
		ui_view_name = "barber_vendor_background_view"
	},
	vendor = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/credits_store",
		description = "loc_vendor_view_title",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "vendor",
		ui_view_name = "credits_vendor_background_view"
	},
	marks_vendor = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/contracts",
		description = "loc_marks_vendor_view_title",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "marks_vendor",
		ui_view_name = "marks_vendor_view"
	},
	premium_vendor = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/premium_store",
		description = "loc_premium_vendor_view_title",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "premium_vendor",
		ui_view_name = "store_view"
	},
	cosmetics_vendor = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/cosmetics_store",
		description = "loc_cosmetics_vendor_view_title",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "cosmetics_vendor",
		ui_view_name = "cosmetics_vendor_background_view"
	},
	training_ground = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/training_grounds",
		description = "loc_training_ground_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "training_ground",
		ui_view_name = "training_grounds_view"
	},
	contracts = {
		action_text = "loc_action_interaction_view",
		ui_interaction_type = "point_of_interest",
		interaction_icon = "content/ui/materials/hud/interactions/icons/contracts",
		description = "loc_contracts_view",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "contracts",
		ui_view_name = "contracts_background_view"
	},
	moveable_platform = {
		action_text = "loc_action_interaction_press",
		ui_interaction_type = "default",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "moveable_platform"
	},
	pocketable = {
		action_text = "loc_action_interaction_pickup",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/pocketable_default",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "pocketable"
	},
	pull_up = {
		description = "loc_pull_up",
		ui_interaction_type = "critical",
		stop_anim_event = "arms_down",
		taggable = true,
		is_third_person = true,
		start_anim_event_3p = "interaction_revive",
		action_text = "loc_action_interaction_help",
		interaction_icon = "content/ui/materials/hud/interactions/icons/help",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 3,
		interaction_class_name = "pull_up",
		start_anim_event_func = function (interactee_unit, interactor_unit)
			local interactee_unit_data_extension = ScriptUnit.extension(interactee_unit, "unit_data_system")
			local breed = interactee_unit_data_extension:breed()
			local breed_name = breed.name

			if breed_name == "human" then
				return "arms_down", "interaction_revive_human"
			end

			return "arms_down", "interaction_revive_ogryn"
		end
	},
	remove_net = {
		description = "loc_remove_net",
		ui_interaction_type = "critical",
		stop_anim_event = "arms_down",
		taggable = true,
		is_third_person = true,
		start_anim_event_3p = "interaction_revive",
		vo_event = "start_revive",
		action_text = "loc_action_interaction_help",
		interaction_icon = "content/ui/materials/hud/interactions/icons/help",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 1,
		interaction_class_name = "remove_net",
		start_anim_event_func = function (interactee_unit, interactor_unit)
			local interactee_unit_data_extension = ScriptUnit.extension(interactee_unit, "unit_data_system")
			local breed = interactee_unit_data_extension:breed()
			local breed_name = breed.name

			if breed_name == "human" then
				return "arms_down", "interaction_revive_human"
			end

			return "arms_down", "interaction_revive_ogryn"
		end
	},
	revive = {
		description = "loc_revive",
		ui_interaction_type = "critical",
		stop_anim_event = "arms_down",
		only_once = false,
		is_third_person = true,
		taggable = false,
		vo_event = "start_revive",
		action_text = "loc_action_interaction_revive",
		interaction_icon = "content/ui/materials/hud/interactions/icons/help",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 3,
		interaction_class_name = "revive",
		anim_duration_variable_name_3p = "assist_interaction_duration",
		start_anim_event_func = function (interactee_unit, interactor_unit)
			local interactee_unit_data_extension = ScriptUnit.extension(interactee_unit, "unit_data_system")
			local breed = interactee_unit_data_extension:breed()
			local breed_name = breed.name

			if breed_name == "human" then
				return "arms_down", "interaction_revive_human"
			end

			return "arms_down", "interaction_revive_ogryn"
		end
	},
	rescue = {
		description = "loc_rescue",
		ui_interaction_type = "critical",
		stop_anim_event = "arms_down",
		only_once = false,
		is_third_person = true,
		taggable = false,
		vo_event = "start_revive",
		action_text = "loc_action_interaction_rescue",
		interaction_icon = "content/ui/materials/hud/interactions/icons/help",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 3,
		interaction_class_name = "rescue",
		anim_duration_variable_name_3p = "assist_interaction_duration",
		start_anim_event_func = function (interactee_unit, interactor_unit)
			local interactee_unit_data_extension = ScriptUnit.extension(interactee_unit, "unit_data_system")
			local breed = interactee_unit_data_extension:breed()
			local breed_name = breed.name

			if breed_name == "human" then
				return "arms_down", "interaction_revive_human"
			end

			return "arms_down", "interaction_revive_ogryn"
		end
	},
	scanning = {
		description = "loc_scanning",
		ui_interaction_type = "mission",
		stop_anim_event = "scan_end",
		start_anim_event = "scan_start",
		wield_slot = "slot_device",
		interrupt_anim_event = "scan_interrupt",
		action_text = "loc_scanning",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		wwise_player_state = "auspex_scanner",
		interaction_priority = 1,
		duration = 4,
		interaction_class_name = "scanning"
	},
	servo_skull = {
		description = "loc_interactable_servo_skull_scanner",
		ui_interaction_type = "mission",
		stop_anim_event = "arms_down",
		start_anim_event = "arms_down",
		start_anim_event_3p = "interaction_revive",
		action_text = "loc_interactable_servo_skull_scanner_continue",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 1,
		interaction_class_name = "servo_skull",
		anim_duration_variable_name_3p = "assist_interaction_duration"
	},
	servo_skull_activator = {
		description = "loc_interactable_servo_skull_scanner",
		ui_interaction_type = "mission",
		action_text = "loc_interactable_servo_skull_scanner_deploy",
		wield_slot = "slot_device",
		start_anim_event_3p = "interaction_revive",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 1,
		interaction_class_name = "servo_skull_activator"
	},
	setup_breach_charge = {
		wield_slot = "slot_device",
		ui_interaction_type = "mission",
		stop_anim_event = "action_finished",
		start_anim_event = "deploy",
		interrupt_anim_event = "action_interrupt",
		action_text = "loc_action_interaction_plant",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_secondary",
		interaction_priority = 1,
		duration = 4,
		interaction_class_name = "setup_breach_charge"
	},
	side_mission = {
		action_text = "loc_action_interaction_pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/objective_side",
		ui_interaction_type = "pickup",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "pickup"
	},
	forge_material = {
		action_text = "loc_action_interaction_pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/environment_generic",
		ui_interaction_type = "pickup",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "pickup"
	},
	objective_pickup = {
		action_text = "loc_action_interaction_pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/environment_generic",
		ui_interaction_type = "pickup",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "pickup"
	},
	equip_auspex = {
		action_text = "loc_action_interaction_pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/environment_generic",
		ui_interaction_type = "pickup",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "equip_auspex"
	},
	scripted_scenario = {
		action_text = "loc_action_interaction_view",
		interaction_icon = "content/ui/materials/hud/interactions/icons/environment_generic",
		ui_interaction_type = "point_of_interest",
		description = "loc_character_view_display_name",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "scripted_scenario"
	},
	player_hub_inspect = {
		action_text = "loc_lobby_entry_inspect",
		ui_interaction_type = "player_interaction",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		interaction_input = "interact_inspect_pressed",
		interaction_priority = 2,
		duration = 0,
		interaction_class_name = "player_hub_inspect"
	},
	companion_hub_interact = {
		action_text = "loc_companion_hub_interaction_pet",
		ui_interaction_type = "player_interaction",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		interaction_input = "interact_inspect_pressed",
		interaction_priority = 2,
		duration = 0,
		interaction_class_name = "companion_hub_interact"
	},
	penance_collectible = {
		action_text = "loc_action_interaction_pickup",
		ui_interaction_type = "pickup",
		interaction_icon = "content/ui/materials/hud/interactions/icons/default",
		taggable = true,
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "penance_collectible",
		description = "loc_pickup_collectible"
	},
	tainted_skull = {
		description = "loc_pickup_tainted_skull",
		taggable = false,
		stop_anim_event = "arms_down",
		start_anim_event = "arms_down",
		ui_interaction_type = "pickup",
		start_anim_event_3p = "interaction_revive",
		action_text = "loc_action_interaction_tainted_skull",
		interaction_icon = "content/ui/materials/hud/interactions/icons/enemy",
		stop_anim_event_3p = "interaction_end",
		interaction_priority = 1,
		duration = 0,
		interaction_class_name = "pickup",
		anim_duration_variable_name_3p = "assist_interaction_duration"
	}
}

for interaction_type, template in pairs(interaction_templates) do
	template.type = interaction_type
end

return settings("InteractionTemplates", interaction_templates)
