local TestifySnippets = {
	create_new_character = function ()
		Testify:make_request("wait_for_view_to_close", "main_menu_background_view")
		Testify:make_request("create_new_character")
	end,
	create_character_from_main_menu = function (archetype, gender)
		local archetype = archetype or "veteran"
		local gender = gender or "male"

		Testify:make_request("navigate_to_create_character_from_main_menu")
		Testify:make_request("create_character_by_archetype_and_gender", archetype, gender)
	end,
	create_character_if_none = function ()
		local is_any_character_created = Testify:make_request("is_any_character_created")

		if not is_any_character_created then
			Testify:make_request("navigate_to_create_character_from_main_menu")
			Testify:make_request("create_random_character")
		end
	end
}

function TestifySnippets.skip_title_and_main_menu_and_create_character_if_none()
	if not DEDICATED_SERVER then
		TestifySnippets.skip_splash_and_title_screen()

		if Testify:make_request("current_state_name") == "StateGameplay" or GameParameters.mission then
			return
		end

		local is_any_character_created = Testify:make_request("is_any_character_created")

		if not is_any_character_created then
			Testify:make_request("navigate_to_create_character_from_main_menu")
			Testify:make_request("create_random_character")
		else
			Testify:make_request("wait_for_main_menu_play_button_enabled")
			TestifySnippets.wait(4)
			Testify:make_request("press_play_main_menu")
		end
	end
end

function TestifySnippets.skip_splash_and_title_screen()
	Testify:make_request("skip_splash_screen")
	Testify:make_request("skip_title_screen")
end

function TestifySnippets.wait_for_main_menu()
	Testify:make_request("wait_for_main_menu_displayed")
	Testify:make_request("wait_for_profile_synchronization")
	Testify:make_request("wait_for_narrative_loaded")
end

function TestifySnippets.load_mission(mission_name, challenge, resistance, circumstance_name, side_mission)
	Testify:make_request("wait_for_state_gameplay_reached")

	local mission_context = {
		mission_name = mission_name,
		challenge = challenge,
		resistance = resistance,
		circumstance_name = circumstance_name,
		side_mission = side_mission
	}

	Testify:make_request("load_mission", mission_context)
end

function TestifySnippets.load_mission_in_mission_board(level_key, challenge, resistance, circumstance_name, side_mission, peer_id)
	challenge = challenge or 1
	resistance = resistance or 1
	circumstance_name = circumstance_name or "default"
	side_mission = side_mission or "default"
	local params = {
		map = level_key,
		challenge = challenge,
		resistance = resistance,
		circumstance_name = circumstance_name,
		side_mission = side_mission
	}

	if peer_id == nil then
		Testify:make_request("load_mission_in_mission_board", params)
	else
		Testify:make_request_on_client(peer_id, "load_mission_in_mission_board", true, params)
	end
end

function TestifySnippets.mission_circumstances(mission_name)
	local mission_settings = Testify:make_request("mission_settings", mission_name)
	local level = mission_settings.level
	local mission_themes = Testify:make_request("mission_themes", level)
	local circumstances = Testify:make_request("circumstances")
	local mission_circumstances = {}
	local i = 0

	for circumstance_name, circumstance in pairs(circumstances) do
		local theme_tag = circumstance.theme_tag
		local testify_skip = circumstance.testify_skip

		if mission_themes[theme_tag] ~= nil and not testify_skip then
			i = i + 1
			mission_circumstances[i] = circumstance_name
		end
	end

	return mission_circumstances, i
end

function TestifySnippets.reload_current_mission()
	local current_mission = Testify:make_request("current_mission")

	TestifySnippets.load_mission(current_mission)
end

function TestifySnippets.lobby_set_all_peers_ready_status(is_ready)
	TestifySnippets.send_request_to_all_peers("lobby_set_ready_status", true, nil, is_ready)
end

function TestifySnippets.wait_for_all_peers_reach_gameplay_state()
	TestifySnippets.send_request_to_all_peers("wait_for_state_gameplay_reached", true, 3)
end

function TestifySnippets.enter_free_flight()
	if DEDICATED_SERVER then
		TestifySnippets.send_request_to_all_peers("enter_free_flight")
	else
		Testify:make_request("enter_free_flight")
	end
end

function TestifySnippets.set_free_flight_camera_position(camera_data)
	if DEDICATED_SERVER then
		TestifySnippets.send_request_to_all_peers("set_free_flight_camera_position", nil, nil, camera_data)
	else
		Testify:make_request("set_free_flight_camera_position", camera_data)
	end
end

function TestifySnippets.wait_for_mission_intro()
	if DEDICATED_SERVER then
		TestifySnippets.send_request_to_all_peers("wait_for_mission_intro", true)
	else
		Testify:make_request("wait_for_mission_intro")
	end
end

function TestifySnippets.spawn_bot()
	Testify:make_request("wait_for_master_items_data")
	Testify:make_request("spawn_random_bot")
	Testify:make_request("wait_for_bot_synchronizer_ready")
end

function TestifySnippets.set_difficulty(difficulty)
	local resistance = {
		name = "resistance",
		value = difficulty.resistance
	}

	Testify:make_request("change_dev_parameter", resistance)

	local challenge = {
		name = "challenge",
		value = difficulty.challenge
	}

	Testify:make_request("change_dev_parameter", challenge)
end

function TestifySnippets.set_render_settings(setting_id, value, wait_time)
	local setting = TestifySnippets.render_setting_template(setting_id)
	local new_value = value
	local option_data = {
		setting = setting,
		new_value = new_value
	}

	Testify:make_request("setting_on_activated", option_data)

	if wait_time then
		TestifySnippets.wait(wait_time)
	end
end

function TestifySnippets.render_setting_template(setting_id)
	local render_settings = Testify:make_request("display_and_graphics_presets_settings")

	for i = 1, #render_settings do
		local setting = render_settings[i]
		local id = setting.id

		if setting_id == id then
			return setting
		end
	end
end

function TestifySnippets.is_host()
	return Testify:make_request("is_host")
end

function TestifySnippets.wait_for_peers(num_peers)
	while Testify:num_peers() ~= num_peers do
		coroutine.yield()
	end
end

function TestifySnippets.send_request_to_all_peers(request_name, wait_for_response, num_retries, ...)
	local peer_ids = Testify:peers()
	num_retries = num_retries or 1
	local retry_time = 30

	for _, peer_id in ipairs(peer_ids) do
		local request_sent = false

		while num_retries > 0 and request_sent == false do
			if TestifySnippets.peer_exists(peer_id) then
				Testify:make_request_on_client(peer_id, request_name, wait_for_response, ...)

				request_sent = true
			else
				Log.info("Testify", "The peer %s is not connected to the server, retrying", peer_id)
				TestifySnippets.wait(retry_time)

				num_retries = num_retries - 1
			end
		end
	end
end

function TestifySnippets.peer_exists(peer_id)
	local peer_ids = Testify:peers()

	Log.info("Testify", "checking peer %s existence: %s", peer_id, table.contains(peer_ids, peer_id))

	return table.contains(peer_ids, peer_id)
end

function TestifySnippets.check_flags_for_mission(flags, mission_key)
	for i = 1, #flags do
		local flag = flags[i]
		local flag_value = TestifySnippets.mission_flag_of_type(mission_key, flags[i])

		if flag_value == false then
			local output = string.format("%s's %s flag is set to false. The test was not run", mission_key, flag)

			return output
		end
	end
end

function TestifySnippets.mission_exists(mission_key)
	local exists = Testify:make_request("mission_exists", mission_key)

	if exists == false then
		local output = string.format("The mission %s does not exist in mission templates. The test was not run", mission_key)

		return output
	end
end

function TestifySnippets.all_mission_flags(mission)
	local flags = Testify:make_request("all_mission_flags", mission)

	return flags ~= "" and flags or nil
end

function TestifySnippets.all_missions_with_flag_of_type(flag_type)
	local missions = Testify:make_request("all_missions_with_flag_of_type", flag_type)

	if missions == "" then
		return nil
	end

	return missions
end

function TestifySnippets.mission_flag_of_type(mission, flag_type)
	local flags = TestifySnippets.all_mission_flags(mission)

	if flags and not table.is_empty(flags) then
		for type, flag in pairs(flags) do
			if type == flag_type then
				return flag
			end
		end

		return nil
	else
		return nil
	end
end

function TestifySnippets.send_telemetry_batch()
	Testify:make_request("send_telemetry_batch")
	Testify:make_request("wait_for_batch_post")
	TestifySnippets.wait(3)
end

function TestifySnippets.lua_trace_statistics()
	Testify:make_request("console_command_lua_trace")
	TestifySnippets.wait(1)

	local lua_trace_statistics = Testify:make_request_to_runner("lua_trace_statistics")
	lua_trace_statistics = cjson.decode(lua_trace_statistics)

	return lua_trace_statistics
end

function TestifySnippets.memory_tree(depth, ascii_separator, memory_limit)
	Testify:make_request_to_runner("start_memory_tree_monitoring", ascii_separator)
	Testify:make_request("console_command_memory_tree_formatted", depth, ascii_separator, memory_limit)

	local memory_tree = Testify:make_request_to_runner("stop_memory_tree_monitoring")
	memory_tree = cjson.decode(memory_tree)

	return memory_tree
end

function TestifySnippets.memory_resources_all(include_details)
	Testify:make_request_to_runner("start_memory_resources_all_monitoring")
	Testify:make_request("console_command_memory_resources_all")
	TestifySnippets.wait(1)

	local memory_resources_all = Testify:make_request_to_runner("stop_memory_resources_all_monitoring")
	memory_resources_all = cjson.decode(memory_resources_all)

	if include_details then
		local max_resources_number = -1
		local size_threshold = -1

		for key, _ in pairs(memory_resources_all) do
			local resource_type_size = memory_resources_all[key].size

			if resource_type_size and (size_threshold == -1 or size_threshold < tonumber(resource_type_size)) then
				local memory_resources_details = TestifySnippets.memory_resources_details(key, max_resources_number)
				memory_resources_all[key].details = memory_resources_details
			end
		end
	end

	return memory_resources_all
end

function TestifySnippets.memory_resources_details(resource_name, max_resources_number)
	Testify:make_request_to_runner("start_memory_resources_details_monitoring", max_resources_number)
	Testify:make_request("console_command_memory_resources_list", resource_name)
	TestifySnippets.wait(0.5)

	local memory_resources_details = Testify:make_request_to_runner("stop_memory_resources_details_monitoring")
	memory_resources_details = cjson.decode(memory_resources_details)

	return memory_resources_details
end

function TestifySnippets.memory_usage()
	if DEDICATED_SERVER then
		local first_peer = TestifySnippets.first_peer()

		return Testify:make_request_on_client(first_peer, "memory_usage", true)
	else
		return Testify:make_request("memory_usage")
	end
end

function TestifySnippets.equip_all_traits_support_snippet(player, slot_name, traits, has_local_profile, weapon_name, units_to_spawn)
	local weapon = Testify:make_request("weapon", weapon_name)
	local data = {
		player = player,
		slot = slot_name,
		item = weapon
	}
	local trait_params = {
		player = player,
		slot_name = slot_name,
		traits = traits
	}
	units_to_spawn = units_to_spawn or 1
	local breed_name = "chaos_ogryn_executor"
	local minion = {
		breed_side = 2,
		breed_name = breed_name,
		spawn_position = Vector3Box(Vector3.zero())
	}

	if not has_local_profile then
		Testify:make_request("equip_item_backend", data)
	else
		Testify:make_request("equip_item", data)
	end

	Testify:make_request("wait_for_item_equipped", data)
	Log.info("Testify", "Applying Traits")
	Testify:make_request("apply_select_traits", trait_params)
	TestifySnippets.wait(0.5)
	Testify:make_request("wield_slot", data)
	Log.info("Testify", "Spawning chaos_ogryn_executor")

	for i = 1, units_to_spawn do
		minion.unit = Testify:make_request("spawn_minion", minion)
	end

	TestifySnippets.wait(0.5)

	return minion
end

function TestifySnippets.reset_weapon_traits(player, slot_name)
	Log.info("Testify", "Reseting Traits")

	local empty_trait_params = {
		player = player,
		slot_name = slot_name,
		traits = {}
	}

	Testify:make_request("apply_select_traits", empty_trait_params)
end

function TestifySnippets.wait_for_gameplay_ready()
	if not DEDICATED_SERVER then
		Testify:make_request("wait_for_view_to_close", "loading_view")
	end

	Testify:make_request("wait_for_state_gameplay_reached")
end

function TestifySnippets.open_barber_surgeon_shop()
	local view_data = {
		view_name = "barber_vendor_background_view",
		dummy_data = {
			debug_preview = true,
			can_exit = true
		}
	}

	Testify:make_request("open_view", view_data)
	Testify:make_request("vendor_interaction_view_press_option", 1)
	Testify:make_request("wait_for_view", "character_appearance_view")
	TestifySnippets.wait(2)
end

function TestifySnippets.appearance_options_widgets(appearance_slots_widget_names)
	local appearance_options_widgets = {}

	for slot_name, slot_widget_name in pairs(appearance_slots_widget_names) do
		Testify:make_request("trigger_widget_callback", slot_widget_name)

		local widgets = Testify:make_request("character_appearance_view_options_widgets")
		appearance_options_widgets[slot_name] = widgets
	end

	return appearance_options_widgets
end

function TestifySnippets.connection_statistics()
	local statistics = Testify:make_request_to_runner("get_connection_statistics")

	return cjson.decode(statistics)
end

function TestifySnippets.wait(seconds)
	local now = os.clock()

	while seconds > os.clock() - now do
		coroutine.yield()
	end
end

function TestifySnippets.wait_frames(num_frames)
	for i = 1, num_frames do
		coroutine.yield()
	end
end

function TestifySnippets.is_debug_stripped()
	local is_debug_stripped = true

	return is_debug_stripped
end

function TestifySnippets.peers_sorted()
	local peers = Testify:peers()

	table.sort(peers)

	return peers
end

function TestifySnippets.first_peer()
	local peers = TestifySnippets.peers_sorted()

	return peers[1]
end

function TestifySnippets.peers_except_first()
	local peers = TestifySnippets.peers_sorted()

	table.remove(peers, 1)

	return peers
end

return TestifySnippets
