local pickup_data = {
	description = "loc_pickup_syringe_pocketable_04",
	name = "syringe_speed_boost_pocketable",
	spawn_unit_component_event = "set_colors",
	group = "pocketable",
	interaction_type = "pocketable",
	look_at_tag = "pocketable",
	inventory_slot_name = "slot_pocketable_small",
	unit_name = "content/pickups/pocketables/syringe/pup_syringe_case",
	interaction_icon = "content/ui/materials/hud/interactions/icons/pocketable_syringe_speed",
	pickup_sound = "wwise/events/player/play_pick_up_syringe",
	smart_tag_target_type = "pickup",
	inventory_item = "content/items/pocketable/syringe_speed_boost_pocketable",
	on_pickup_func = function (pickup_unit, interactor_unit, pickup_data)
		local unit_data_extension = ScriptUnit.has_extension(interactor_unit, "unit_data_system")
		local inventory_component = unit_data_extension and unit_data_extension:read_component("inventory")
		local replaced_unit_name = nil

		if inventory_component then
			local visual_loadout_extension = ScriptUnit.has_extension(interactor_unit, "visual_loadout_system")

			if visual_loadout_extension then
				local weapon_template = visual_loadout_extension:weapon_template_from_slot("slot_pocketable_small")
				replaced_unit_name = weapon_template and weapon_template.name
			end
		end

		local is_server = Managers.state.game_session:is_server()

		if is_server then
			local player_unit_spawn_manager = Managers.state.player_unit_spawn
			local player = player_unit_spawn_manager:owner(interactor_unit)

			if player then
				local pickup_name = pickup_data.name
				local data = {
					pickup_name = pickup_name,
					exchanged_unit = replaced_unit_name
				}

				Managers.telemetry_events:player_picked_up_stimm(player, data)
			end
		end
	end
}

return pickup_data
