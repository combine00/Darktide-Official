local BotSpawning = require("scripts/managers/bot/bot_spawning")
local Breed = require("scripts/utilities/breed")
local DebugSingleton = require("scripts/foundation/utilities/debug/debug_singleton")
local DialogueSpeakerVoiceSettings = require("scripts/settings/dialogue/dialogue_speaker_voice_settings")
local FixedFrame = require("scripts/utilities/fixed_frame")
local GameModeSettings = require("scripts/settings/game_mode/game_mode_settings")
local HordesModeSettings = require("scripts/settings/hordes_mode_settings")
local MasterItems = require("scripts/backend/master_items")
local MissionBuffsAllowedBuffs = require("scripts/managers/mission_buffs/mission_buffs_allowed_buffs")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local Promise = require("scripts/foundation/utilities/promise")
local ScriptedScenarios = require("scripts/extension_systems/scripted_scenario/scripted_scenarios")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local level_trigger_event = Level.trigger_event
local ui_manager = nil
local WEAPON_CATEGORY = "Player Equipment - Weapons"
local WEAPON_CATEGORY_DESCRIPTIONS = {
	prototype = "PROTOTYPE (free to test, but don't report issues)",
	blockout = "BLOCKOUT (weapon art and combat teams only)",
	releasable = "RELEASABLE (ready for public release)",
	functional = "FUNCTIONAL (ready for testing)",
	shippable = "SHIPPABLE (ready for testing)"
}
local categories = {
	"Achievements",
	"Ailments",
	"Bot Character",
	"Buffs",
	"Companion",
	"Cinematics",
	"Coherency Buffs",
	"Crafting",
	"Dev Combat",
	"Dev Parameters",
	"Error",
	"Free Flight Camera",
	"Game Mode",
	"Horde Mode",
	"Immaterium (Party)",
	"Level & Mission",
	"Marketing",
	"Memory",
	"Micro Transaction (\"Premium\") Store",
	"Navigation",
	"Network",
	"Pacing",
	"Perception",
	"Player Character",
	"Player Equipment - Boons",
	"Player Equipment - Emotes",
	"Player Equipment - Gear",
	string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS.releasable),
	string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS.shippable),
	string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS.functional),
	string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS.prototype),
	string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS.blockout),
	"Player Equipment",
	"Player Inventory",
	"Player Profiles",
	"Player Voice",
	"Progression",
	"Scripted Scenarios",
	"Social Features",
	"Stagger",
	"Suppression",
	"Sweep Spline",
	"Talents",
	"Time",
	"UI",
	"Unit",
	"VO",
	"Weapon Mastery",
	"Weapon Traits"
}
local EMPTY_TABLE = {}
local functions = {}

local function _apply_ailment(unit, ailment_effect)
	local Ailment = require("scripts/utilities/ailment")
	local include_children = true

	Ailment.play_ailment_effect_template(unit, ailment_effect, include_children)

	local visual_loadout_extension = ScriptUnit.has_extension(unit, "visual_loadout_system")

	if visual_loadout_extension then
		visual_loadout_extension:set_ailment_effect(ailment_effect)
	end
end

local function ailment_options()
	local AilmentSettings = require("scripts/settings/ailments/ailment_settings")
	local ailment_effect_names = table.keys(AilmentSettings.effects)

	table.sort(ailment_effect_names)

	return ailment_effect_names
end

local function apply_ailment_to_selected_unit(new_value)
	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	_apply_ailment(selected_unit, new_value)
end

functions.apply_ailment_to_selected_unit = {
	name = "Play Ailment Effect On Selected Unit",
	category = "Ailments",
	options_function = ailment_options,
	on_activated = apply_ailment_to_selected_unit
}
local hordes_mode_buff_options = {}

for buff_name, _ in pairs(MissionBuffsAllowedBuffs.debug_only_list_used_buffs) do
	table.insert(hordes_mode_buff_options, buff_name)
end

table.sort(hordes_mode_buff_options)

local function buff_options()
	local BuffTemplates = require("scripts/settings/buff/buff_templates")
	local buff_names = table.keys(BuffTemplates)

	table.sort(buff_names)

	return buff_names
end

local function _apply_buff(unit, new_value)
	local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

	if not buff_extension then
		return
	end

	local fixed_t = FixedFrame.get_latest_fixed_time()

	buff_extension:debug_add_buff(new_value, fixed_t)
end

local function apply_buff_to_self(new_value)
	local local_player = Managers.player:local_player(1)
	local local_player_unit = local_player.player_unit

	_apply_buff(local_player_unit, new_value)
end

functions.apply_buff_to_self = {
	name = "Apply Buff To Self",
	category = "Buffs",
	options_function = buff_options,
	on_activated = apply_buff_to_self
}

local function apply_buff_to_selected_unit(new_value)
	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	_apply_buff(selected_unit, new_value)
end

functions.apply_buff_to_selected_unit = {
	name = "Apply Buff To Selected Unit",
	category = "Buffs",
	options_function = buff_options,
	on_activated = apply_buff_to_selected_unit
}

local function _remove_all_buffs(unit)
	local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

	if not buff_extension then
		return
	end

	buff_extension:debug_remove_all_buffs()
end

local function remove_buffs_from_self()
	local local_player = Managers.player:local_player(1)
	local local_player_unit = local_player.player_unit

	_remove_all_buffs(local_player_unit)
end

functions.remove_buffs_from_self = {
	name = "Remove Buffs From Self",
	category = "Buffs",
	on_activated = remove_buffs_from_self
}

local function remove_buffs_from_selected_unit(new_value, old_value)
	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	_remove_all_buffs(selected_unit)
end

functions.remove_buffs_from_selected_unit = {
	name = "Remove Buffs From Selected Unit",
	category = "Buffs",
	on_activated = remove_buffs_from_selected_unit
}

local function buff_index_options()
	local options = {}

	for i = 1, 20 do
		options[i] = i
	end

	return options
end

local function _remove_specific_buff(unit, index)
	local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

	if not buff_extension then
		return
	end

	buff_extension:debug_remove_buff(index)
end

local function remove_specific_buff_from_self(new_value)
	local local_player = Managers.player:local_player(1)
	local local_player_unit = local_player.player_unit

	_remove_specific_buff(local_player_unit, new_value)
end

functions.remove_specific_buff_from_self = {
	name = "Remove Specific Buff From Self",
	category = "Buffs",
	options_function = buff_index_options,
	on_activated = remove_specific_buff_from_self
}

local function remove_specific_buff_from_selected_unit(new_value)
	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	_remove_specific_buff(selected_unit, new_value)
end

functions.remove_specific_buff_from_selected_unit = {
	name = "Remove Specific Buff From Selected Unit",
	category = "Buffs",
	options_function = buff_index_options,
	on_activated = remove_specific_buff_from_selected_unit
}

local function horde_mode_request_buff(buff_name, give_buff_to_self)
	if not buff_name or buff_name == "" then
		Log.error("DebugFunctions", "Invalid Buff Name to give to players.")

		return
	end

	Managers.event:trigger("mission_buffs_event_request_specific_buff", buff_name, give_buff_to_self)
end

functions.horde_mode_apply_buff_to_all_players = {
	name = "Horde Mode Request Buff",
	debug_mission_buffs_request_buff = true,
	category = "Buffs",
	dropdown_width = 250,
	filter_input_width = 100,
	on_activated = horde_mode_request_buff,
	buff_options = hordes_mode_buff_options
}
functions.debug_memory_snapshot = {
	debug_memory_snapshot = true,
	name = "Take Memory Snapshot",
	category = "Memory"
}
functions.horde_mode_tag_all_enemies_local = {
	name = "Tag All Enemies (Local Client)",
	category = "Horde Mode",
	on_activated = function ()
		Managers.event:trigger("event_surival_mode_tag_remaining_enemies")
	end
}
local horde_mode_island_names = HordesModeSettings.island_names
functions.horde_mode_select_island_to_play = {
	name = "Select Island To Play",
	category = "Horde Mode",
	options_function = function ()
		return horde_mode_island_names
	end,
	on_activated = function (selected_option)
		if Managers.state.game_session:is_server() then
			local level = Managers.state.mission:mission_level()
			local game_mode_name = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()

			if game_mode_name and level then
				Log.info("GameModeSurvival", "Server changes Island to play: ", selected_option)

				local island_selected_level_event_name = "debug_horde_mode_" .. selected_option .. "_selected"

				Level.trigger_event(level, island_selected_level_event_name)
			end
		else
			local island_name_id = NetworkLookup.hordes_island_names[selected_option]

			Managers.connection:send_rpc_server("rpc_server_hordes_debug_select_island", island_name_id)
		end
	end
}

local function _mission_name()
	local mission_name = Managers.state.mission:mission().name

	return mission_name
end

local _cutscenes_table = {}
local _temp_keys = {}

local function _cutscenes(mission_name)
	table.clear(_cutscenes_table)
	table.clear(_temp_keys)

	local Missions = require("scripts/settings/mission/mission_templates")
	local cutscenes = Missions[mission_name].cinematics

	if not cutscenes then
		return _cutscenes_table
	end

	local i = 1

	for cutscene_name, _ in table.sorted(cutscenes, _temp_keys) do
		_cutscenes_table[i] = cutscene_name
		i = i + 1
	end

	return _cutscenes_table
end

local function _play_cutscene(cutscene_name)
	local cinematic_scene_system = Managers.state.extension:system("cinematic_scene_system")

	cinematic_scene_system:play_cutscene(cutscene_name)
end

local function _trigger_level_event(event_name)
	level_trigger_event(Managers.state.mission:mission_level(), event_name)
end

local function _mission_outro_win()
	_trigger_level_event("mission_outro_win")
end

local CINEMATICS_TO_SKIP = {
	path_of_trust_12 = true,
	path_of_trust_11 = true,
	path_of_trust_13 = true,
	path_of_trust_10 = true
}
local USE_EVENTS = {
	om_hub_01 = true,
	prologue = true
}
functions.play_cutscene = {
	name = "Play Cutscene",
	category = "Cinematics",
	dynamic_contents = true,
	options_function = function ()
		if not Managers.state or not Managers.state.mission then
			return EMPTY_TABLE
		end

		local mission_name = _mission_name()
		local cutscenes = _cutscenes(mission_name)

		return cutscenes
	end,
	on_activated = function (cutscene_name)
		local skip_cutscene = CINEMATICS_TO_SKIP[cutscene_name]

		if skip_cutscene then
			Log.info("DebugFunctions", "%s is not available. See debug_functions for more info.", cutscene_name)

			return
		end

		Log.info("DebugFunctions", "Playing cutscene %s", cutscene_name)

		local outro_win = cutscene_name == "outro_win"

		if outro_win then
			_mission_outro_win()
		end

		local mission_name = _mission_name()
		local use_events = USE_EVENTS[mission_name]

		if use_events then
			local event_name = "event_cutscene_" .. cutscene_name

			_trigger_level_event(event_name)
		else
			_play_cutscene(cutscene_name)
		end
	end
}
functions.apply_coherency_buff_to_self = {
	name = "Apply Coherency Buff To Self",
	category = "Coherency Buffs",
	options_function = buff_options,
	on_activated = function (new_value)
		local local_player = Managers.player:local_player(1)
		local local_player_unit = local_player.player_unit

		Debug:add_coherency_buff_to_unit(local_player_unit, new_value)
	end
}
functions.apply_coherency_buff_to_selected_unit = {
	name = "Apply Coherency Buff To Selected Unit",
	category = "Coherency Buffs",
	options_function = buff_options,
	on_activated = function (new_value)
		local selected_unit = Debug.selected_unit

		Debug:add_coherency_buff_to_unit(selected_unit, new_value)
	end
}
functions.remove_coherency_buffs_from_self = {
	name = "Remove Coherency Buffs From Self",
	category = "Coherency Buffs",
	on_activated = function ()
		local local_player = Managers.player:local_player(1)
		local local_player_unit = local_player.player_unit

		Debug:remove_coherency_buffs_from_unit(local_player_unit)
	end
}
functions.remove_coherency_buffs_from_selected_unit = {
	name = "Remove Coherency Buffs From Selected Unit",
	category = "Coherency Buffs",
	on_activated = function (new_value, old_value)
		local selected_unit = Debug.selected_unit

		if not ALIVE[selected_unit] then
			return
		end

		Debug:remove_coherency_buffs_from_unit(selected_unit)
	end
}
functions.remove_all_traits = {
	name = "Remove All Traits",
	category = "Crafting",
	on_activated = function ()
		Managers.backend.interfaces.crafting:debug_remove_all_traits():next(function ()
			Log.info("DebugFunctions", "All unlocked traits have been removed")
		end)
	end
}
functions.unlock_all_traits = {
	name = "Unlock All Traits",
	category = "Crafting",
	on_activated = function ()
		Managers.backend.interfaces.crafting:debug_unlock_all_traits():next(function ()
			Log.info("DebugFunctions", "All traits have been unlocked")
		end)
	end
}
functions.prepare_ui_for_marketing = {
	name = "Prepare UI for marketing",
	category = "Marketing",
	on_activated = function ()
		if not Managers.state or not Managers.state.game_session or Managers.state.game_session:is_server() or not Managers.connection then
			return
		end

		local ParameterResolver = require("scripts/foundation/utilities/parameters/parameter_resolver")

		ParameterResolver.set_dev_parameter("hide_hud", true)
		ParameterResolver.set_dev_parameter("render_version_info", false)
		ParameterResolver.set_dev_parameter("show_ingame_fps", false)
		ParameterResolver.set_dev_parameter("render_feature_info", false)
		ParameterResolver.set_dev_parameter("debug_text_enable", false)
		ParameterResolver.set_dev_parameter("enemy_outlines", "off")
		ParameterResolver.set_dev_parameter("player_outlines_mode", "off")
		ParameterResolver.set_dev_parameter("disable_outlines", true)
	end
}
functions.prepare_gameplay_for_marketing = {
	name = "Prepare gameplay for marketing",
	category = "Marketing",
	on_activated = function ()
		if not Managers.state or not Managers.state.game_session or Managers.state.game_session:is_server() or not Managers.connection then
			return
		end

		local ParameterResolver = require("scripts/foundation/utilities/parameters/parameter_resolver")
		local channel = Managers.connection:host_channel()

		ParameterResolver.set_dev_parameter("allow_server_control_from_client", true)
		ParameterResolver.set_dev_parameter("no_ability_cooldowns", true)
		ParameterResolver.set_dev_parameter("infinite_ammo_reserve", true)
		ParameterResolver.set_dev_parameter("debug_players_invulnerable", true)
		ParameterResolver.set_dev_parameter("disable_pacing", true)
		RPC.rpc_debug_client_request_no_ability_cooldowns(channel, true)
		RPC.rpc_debug_client_request_infinite_ammo_reserve(channel, true)
		RPC.rpc_debug_client_request_set_players_invulnerable(channel, true)
		RPC.rpc_debug_client_request_disable_pacing(channel, true)
	end
}
functions.reload_current_level = {
	name = "Reload Current Level",
	category = "Level & Mission",
	on_activated = function ()
		local is_server = Managers.state.game_session:is_server()

		if is_server then
			Debug.reload_level = true
		else
			local channel = Managers.connection:host_channel()

			RPC.rpc_debug_client_request_reload_level(channel)
		end
	end
}

local function list_mission_options(dev)
	local Missions = require("scripts/settings/mission/mission_templates")
	local mission_keys = {}

	for key, mission in pairs(Missions) do
		if not dev and not mission.is_dev_mission or dev and mission.is_dev_mission then
			mission_keys[#mission_keys + 1] = key
		end
	end

	table.sort(mission_keys)

	return mission_keys
end

local function mission_options()
	local dev = false

	return list_mission_options(dev)
end

local function mission_options_dev()
	local dev = true

	return list_mission_options(dev)
end

local function circumstance_options()
	local CircumstanceTemplates = require("scripts/settings/circumstance/circumstance_templates")
	local circumstances = {}

	for circumstance_name, _ in pairs(CircumstanceTemplates) do
		if circumstance_name ~= "default" then
			circumstances[#circumstances + 1] = circumstance_name
		end
	end

	table.sort(circumstances)
	table.insert(circumstances, 1, "default")

	return circumstances
end

local function side_mission_options()
	local SideMissionObjectiveTemplate = require("scripts/settings/mission_objective/templates/side_mission_objective_template")
	local side_missions = {}

	for side_mission, _ in pairs(SideMissionObjectiveTemplate.side_mission.objectives) do
		if side_mission ~= "default" then
			side_missions[#side_missions + 1] = side_mission
		end
	end

	table.sort(side_missions)
	table.insert(side_missions, 1, "default")

	return side_missions
end

local function array_concat(a1, a2)
	for i = 1, #a2 do
		a1[#a1 + 1] = a2[i]
	end

	return a1
end

local function start_mission_level(new_value, old_value)
	local mechanism_context = {
		mission_name = new_value
	}
	local Missions = require("scripts/settings/mission/mission_templates")
	local mission_settings = Missions[new_value]
	local mechanism_name = mission_settings.mechanism_name
	local game_mode_name = mission_settings.game_mode_name
	local game_mode_settings = GameModeSettings[game_mode_name]

	if game_mode_settings.host_singleplay then
		Managers.multiplayer_session:boot_singleplayer_session()
	end

	local is_host = Managers.connection:is_host()

	if is_host then
		Managers.connection:reset_seed()
	end

	Managers.mechanism:change_mechanism(mechanism_name, mechanism_context)
	Managers.mechanism:trigger_event("all_players_ready")
end

local function start_free_flight_follow_main_path(new_value, old_value)
	local free_flight_manager = Managers.free_flight

	if free_flight_manager then
		free_flight_manager:toggle_follow_path(new_value)
	end
end

functions.free_flight_follow_main_path = {
	name = "Follow Main Path",
	category = "Free Flight Camera",
	on_activated = start_free_flight_follow_main_path
}
functions.start__mission = {
	name = "Start Missions",
	category = "Level & Mission",
	options_function = mission_options,
	on_activated = start_mission_level
}
functions.start_dev_mission = {
	name = "Start Missions (DEV)",
	category = "Level & Mission",
	options_function = mission_options_dev,
	on_activated = start_mission_level
}
functions.teleport_to_portal = {
	name = "Teleport To Portal",
	category = "Level & Mission",
	dynamic_contents = true,
	options_function = DebugSingleton.teleport_to_portal_list,
	on_activated = DebugSingleton.teleport_to_portal
}
functions.teleport_to_player = {
	name = "Teleport To Player",
	category = "Level & Mission",
	dynamic_contents = true,
	options_function = DebugSingleton.teleport_to_player_list,
	on_activated = DebugSingleton.teleport_to_player
}

local function _print_camera_teleport_cmd()
	local player = Managers.player:local_player(1)
	local camera_manager = Managers.state.camera
	local free_flight_manager = Managers.free_flight
	local camera_pos, camera_rot = nil

	if free_flight_manager and free_flight_manager:is_in_free_flight() then
		camera_pos, camera_rot = free_flight_manager:camera_position_rotation("global")
	elseif camera_manager and player then
		local viewport_name = player.viewport_name
		local camera = camera_manager:camera(viewport_name)

		if camera then
			camera_pos = camera_manager:camera_position(viewport_name)
			camera_rot = camera_manager:camera_rotation(viewport_name)
		end
	end

	if camera_pos and camera_rot then
		local viewport_name = player.viewport_name
		local camera = camera_manager:camera(viewport_name)

		if camera then
			local yaw = Quaternion.yaw(camera_rot)
			local pitch = Quaternion.pitch(camera_rot)
			local roll = Quaternion.roll(camera_rot)
			local camera_position_string = string.format("Vector3(%.2f, %.2f, %.2f)", camera_pos.x, camera_pos.y, camera_pos.z)
			local camera_rotation_string = string.format("Quaternion.from_yaw_pitch_roll(%.4f, %.4f, %.4f)", yaw, pitch, roll)

			Log.info("DebugFunctions", "DebugSingleton.teleport_to_coordinates(%s, %s)", camera_position_string, camera_rotation_string)
		else
			Log.info("DebugFunctions", "No camera available.")
		end
	end
end

functions.print_location_info = {
	name = "Print Camera Teleport Command",
	category = "Level & Mission",
	on_activated = _print_camera_teleport_cmd
}
functions.teleport_to_coordinates = {
	width = 270,
	name = "Teleport to Coordinates",
	category = "Level & Mission",
	button_text = "Teleport",
	vector3_input = true,
	on_activated = DebugSingleton.teleport_to_coordinates
}
functions.teleport_all_luggables_to_me = {
	name = "Teleport all event luggables to me",
	button_text = "Gimme!",
	category = "Level & Mission",
	on_activated = function (new_value, old_value)
		local event_synchronizer_system = Managers.state.extension:system("event_synchronizer_system")

		if event_synchronizer_system then
			local local_player = Managers.player:local_player(1)
			local local_player_unit = local_player.player_unit

			if Managers.state.game_session:is_server() then
				event_synchronizer_system:debug_teleport_luggables_to_unit(local_player_unit)
			else
				local target_unit_id = Managers.state.unit_spawner:game_object_id(local_player_unit)

				Managers.connection:send_rpc_server("rpc_debug_client_request_teleport_mission_luggables_to_unit", target_unit_id)
			end
		end
	end
}
local mission_board_error_text = "Failed fetching missions"
local mission_board_options = {}
local mission_board_data = {}

local function _fetch_mission_board()
	table.clear(mission_board_options)
	table.clear(mission_board_data)

	if not Managers.backend:authenticated() then
		mission_board_options[1] = mission_board_error_text

		return
	end

	local missions_future = Managers.data_service.mission_board:fetch()

	missions_future:next(function (data)
		local missions = data.missions

		for i = 1, #missions do
			local mission = missions[i]
			local text = string.format("%s. %s (chl %s res %s)", i, mission.map, mission.challenge, mission.resistance)
			mission_board_options[#mission_board_options + 1] = text
			mission_board_data[text] = mission
		end
	end):catch(function (error)
		mission_board_options[1] = mission_board_error_text

		Log.info("DebugFunctions", "Fetching mission board failed, %s", error)
	end)
end

functions.mission_board_start_debug_mission = {
	name = "Start Debug Mission Board",
	category = "Level & Mission",
	debug_mission_input = true,
	on_activated = function (debug_mission)
		Managers.data_service.mission_board:create_debug_mission(debug_mission.map, debug_mission.challenge, debug_mission.resistance, debug_mission.circumstance_name, debug_mission.side_mission):next(function (mission)
			local mission_id = mission.id

			Managers.party_immaterium:wanted_mission_selected(mission_id)
		end):catch(function (error)
			Log.error("DebugFunctions", "Could not create debug mission " .. table.tostring(error, 5))
		end)
	end,
	maps = array_concat(mission_options(), mission_options_dev()),
	circumstances = circumstance_options(),
	side_missions = side_mission_options(),
	default_value = {
		map = "combat",
		resistance = 3,
		side_mission = "default",
		challenge = 3,
		circumstance_name = "default"
	}
}
functions.mission_board_start_mission = {
	name = "Mission Board",
	category = "Level & Mission",
	dynamic_contents = true,
	options_function = function ()
		return mission_board_options
	end,
	on_activated = function (selected_option)
		if selected_option ~= mission_board_error_text then
			local mission_data = mission_board_data[selected_option]
			local backend_mission_id = mission_data.id

			Managers.party_immaterium:wanted_mission_selected(backend_mission_id)
		end
	end
}

local function _havoc_options()
	local havoc_options = {}

	for i = 1, 100 do
		havoc_options[#havoc_options + 1] = i
	end

	return havoc_options
end

functions.start_havoc_session = {
	name = "Start Havoc Session",
	debug_havoc_mission_input = true,
	category = "Level & Mission",
	on_activated = function (debug_mission)
		local map = debug_mission.map
		local havoc_rank = debug_mission.havoc_rank

		Log.info("Havoc", "Starting havoc level %d", havoc_rank)
		Managers.data_service.mission_board:create_havoc_debug_mission(map, havoc_rank):next(function (mission)
			local mission_id = mission.id

			Managers.party_immaterium:wanted_mission_selected(mission_id)
		end):catch(function (error)
			Log.error("DebugFunctions", "Could not create debug mission " .. table.tostring(error, 5))
		end)
	end,
	maps = array_concat(mission_options(), mission_options_dev()),
	havoc_options = _havoc_options(),
	default_value = {
		map = "dm_forge",
		havoc_rank = 5
	}
}
functions.set_havoc_unlock_status = {
	name = "Reset havoc_unlock_status",
	category = "Progression",
	on_activated = function ()
		Managers.data_service.havoc:set_havoc_unlock_status("locked")
	end
}
functions.start_havoc_test_session_voting = {
	name = "Start Havoc Mission Vote",
	category = "Level & Mission",
	on_activated = function (debug_mission)
		local transition_time = nil
		local close_previous = false
		local close_all = false
		local close_transition_time = nil
		local context = {
			backend_mission_id = "eac4d0dc-5ab1-41ed-87e9-85bedac46ad6",
			voting_id = "immaterium_party:bcd93b02-c635-4aba-89ef-ed786217f2a6",
			mission_data = {
				map = "cm_raid",
				missionSize = 1,
				displayIndex = 0,
				missionGiver = "explicator_a",
				resistance = 5,
				xp = 5550,
				minPrivateParticipants = 3,
				credits = 24500,
				challenge = 5,
				start = "1730109745545",
				expiry = "2082758399000",
				requiredLevel = 1,
				circumstance = "default",
				depleted = false,
				category = "havoc",
				id = "eac4d0dc-5ab1-41ed-87e9-85bedac46ad6",
				eligibleParticipants = {},
				extraRewards = {},
				flags = {
					["havoc-circ-darkness_01"] = {},
					["havoc-circ-mutator_havoc_enemies_parasite_headshot"] = {},
					["havoc-circ-mutator_havoc_tougher_skin"] = {},
					["havoc-circ-mutator_highest_difficulty"] = {},
					["havoc-faction-renegade"] = {},
					["havoc-mods-ammo_pickup_modifier-5"] = {},
					["havoc-mods-buff_elites-4"] = {},
					["havoc-mods-buff_horde-5"] = {},
					["havoc-mods-buff_monsters-4"] = {},
					["havoc-mods-buff_specials-4"] = {},
					["havoc-mods-horde_spawn_rate_increase-6"] = {},
					["havoc-mods-melee_minion_attack_speed-5"] = {},
					["havoc-mods-melee_minion_permanent_damage-5"] = {},
					["havoc-mods-melee_minion_power_level_buff-5"] = {},
					["havoc-mods-more_alive_specials-4"] = {},
					["havoc-mods-more_elites-5"] = {},
					["havoc-mods-more_ogryns-5"] = {},
					["havoc-mods-ranged_minion_attack_speed-5"] = {},
					["havoc-mods-reduce_health_and_wounds-5"] = {},
					["havoc-mods-reduce_toughness-5"] = {},
					["havoc-mods-reduce_toughness_regen-5"] = {},
					["havoc-mods-terror_event_point_increase-5"] = {},
					["havoc-rank-35"] = {},
					["havoc-theme-darkness"] = {},
					["order-id-642629d7-7c88-464a-b710-d1d2d79c71bb"] = {},
					["order-owner-aaebd154-43dc-4c9c-9d6b-7b48605a4b4a"] = {}
				}
			}
		}
		local settings_override = {
			game_world_blur = 1,
			name = "mission_voting_view",
			display_name = "loc_mission_voting_view",
			state_bound = true,
			close_on_hotkey_gamepad = false,
			path = "scripts/ui/views/mission_voting_view/mission_voting_view",
			package = "packages/ui/views/mission_voting_view/mission_voting_view",
			load_always = true,
			class = "MissionVotingView",
			disable_game_world = false,
			load_in_hub = true,
			close_on_hotkey_pressed = true,
			enter_sound_events = {
				"wwise/events/ui/play_ui_mission_request"
			},
			testify_flags = {
				ui_views = false
			}
		}

		if not table.is_empty(Managers.ui:active_views()) then
			Managers.ui:close_all_views()
		end

		Managers.ui:open_view("mission_voting_view", transition_time, close_previous, close_all, close_transition_time, context, settings_override)
	end
}
functions.mission_board_update_missions = {
	name = "Mission Board Update",
	category = "Level & Mission",
	on_activated = _fetch_mission_board
}

local function _init_spawn_bot_character(item_definitions)
	local function options_function()
		local num_bot_profiles = 0
		local bot_profile_names = {}
		local BotCharacterProfiles = require("scripts/settings/bot_character_profiles")
		local profiles = BotCharacterProfiles(item_definitions)

		for profile_name, _ in pairs(profiles) do
			num_bot_profiles = num_bot_profiles + 1
			bot_profile_names[num_bot_profiles] = profile_name
		end

		table.sort(bot_profile_names)

		return bot_profile_names
	end

	local function spawn_bot_character(new_value, old_value)
		BotSpawning.spawn_bot_character(new_value)
	end

	functions.spawn_bot_character = {
		name = "Spawns a bot character.",
		category = "Bot Character",
		options_function = options_function,
		on_activated = spawn_bot_character
	}
end

local function remove_bot_character()
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		BotSpawning.despawn_best_bot()
	else
		Managers.connection:send_rpc_server("rpc_debug_remove_bot")
	end
end

functions.remove_bot_character = {
	name = "Remove a bot character.",
	category = "Bot Character",
	on_activated = remove_bot_character
}

local function _init_scripted_scenarios(scenario_templates)
	local function options_function()
		local scenario_types = table.keys(scenario_templates)

		table.sort(scenario_types)

		local all_scenarios = {}

		for i = 1, #scenario_types do
			local scenario_type = scenario_types[i]
			local scenarios = scenario_templates[scenario_type]
			local sorted_scenarios = table.keys(scenarios)

			table.sort(sorted_scenarios)

			for j = 1, #sorted_scenarios do
				local scenario_name = sorted_scenarios[j]
				all_scenarios[#all_scenarios + 1] = string.format("%s.%s", scenario_type, scenario_name)
			end
		end

		return all_scenarios
	end

	local function start_scenario(new_value, old_value)
		local scenario_system = Managers.state.extension:system("scripted_scenario_system")
		local t = Managers.time:time("gameplay")
		local separator_idx = string.find(new_value, "%.")
		local alias = string.sub(new_value, 1, separator_idx - 1)
		local name = string.sub(new_value, separator_idx + 1, #new_value)

		scenario_system:start_scenario(alias, name, t)
	end

	functions.start_scripted_scenario = {
		name = "Start scripted scenario",
		category = "Scripted Scenarios",
		options_function = options_function,
		on_activated = start_scenario
	}
end

local function stop_current_scripted_scenario()
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")
	local t = FixedFrame.get_latest_fixed_time()

	scenario_system:stop_scenario(t, nil, true)
end

functions.stop_scripted_scenario = {
	name = "Stop current scripted scenario",
	category = "Scripted Scenarios",
	on_activated = stop_current_scripted_scenario
}

local function complete_current_step()
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")

	scenario_system:complete_current_step()
end

functions.complete_current_scripted_step = {
	name = "Complete current scripted step",
	category = "Scripted Scenarios",
	on_activated = complete_current_step
}

local function init_nav_visual_server()
	local nav_world = Debug:nav_world()

	if nav_world then
		GwNavWorld.init_visual_debug_server(nav_world, 4888)
	end
end

functions.initialize_navigation_visual_debug_server = {
	name = "Initialize Visual Debug Server.",
	category = "Navigation",
	on_activated = init_nav_visual_server
}

local function _crash_server()
	if not Managers.state.game_session then
		Log.info("DebugFunctions", "Trying to crash server without a game_session")

		return
	end

	local user_name = HAS_STEAM and Steam.user_name() or Application.machine_id()
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		Managers.state.game_session:debug_crash_server(user_name)
	else
		Managers.state.game_session:send_rpc_server("rpc_debug_crash_server", user_name)
	end
end

local function _crash_client()
	return
end

functions.crash_server = {
	name = "Crash Server",
	category = "Network",
	on_activated = function ()
		_crash_server()
	end
}
functions.crash_client = {
	name = "Crash Client",
	category = "Network",
	on_activated = function ()
		_crash_client()
	end
}
local _is_disconnected = false

local function _disconnect(seconds)
	if _is_disconnected then
		return
	end

	_is_disconnected = true

	Network.set_max_transmit_rate(10 * seconds)

	local title_request = Managers.backend.title_request
	local url_request = Managers.backend.url_request
	Managers.backend.title_request = Managers.backend.failed_request
	Managers.backend.url_request = Managers.backend.failed_request

	Promise.delay(seconds):next(function ()
		Network.set_max_transmit_rate(0.03)

		Managers.backend.title_request = title_request
		Managers.backend.url_request = url_request
		_is_disconnected = false
	end)
end

functions.disconnect = {
	width = 60,
	name = "Disconnect for x seconds.",
	num_decimals = 2,
	category = "Network",
	button_text = "Disconnect",
	number_button = true,
	on_activated = _disconnect
}

local function _special_breed_options()
	local num_special_breeds = 0
	local special_breed_names = {}
	local Breeds = require("scripts/settings/breed/breeds")

	for name, breed in pairs(Breeds) do
		if Breed.is_minion(breed) and breed.tags.special then
			num_special_breeds = num_special_breeds + 1
			special_breed_names[num_special_breeds] = name
		end
	end

	table.sort(special_breed_names)

	return special_breed_names
end

local function _try_spawn_special_minion(new_value, old_value)
	if Managers.state.pacing then
		Managers.state.pacing:try_inject_special(new_value)
	end
end

functions.try_spawn_special_minion = {
	name = "Try Spawn Special Minion",
	category = "Pacing",
	options_function = _special_breed_options,
	on_activated = _try_spawn_special_minion
}

local function _make_player_untargetable()
	local player = Managers.player:local_player(1)
	local player_unit = player.player_unit

	if player_unit == nil then
		return
	end

	local is_server = Managers.state.game_session:is_server()

	if is_server then
		Managers.state.extension:system("perception_system"):debug_set_targetability(player_unit, false)
	else
		local player_unit_id = Managers.state.unit_spawner:game_object_id(player_unit)

		Managers.connection:send_rpc_server("rpc_debug_set_targetability_client", player_unit_id, false)
	end
end

local function _make_player_targetable()
	local player = Managers.player:local_player(1)
	local player_unit = player.player_unit

	if player_unit == nil then
		return
	end

	local is_server = Managers.state.game_session:is_server()

	if is_server then
		Managers.state.extension:system("perception_system"):debug_set_targetability(player_unit, true)
	else
		local player_unit_id = Managers.state.unit_spawner:game_object_id(player_unit)

		Managers.connection:send_rpc_server("rpc_debug_set_targetability_client", player_unit_id, true)
	end
end

functions.make_player_untargetable = {
	name = "Make Player Untargetable",
	category = "Perception",
	on_activated = _make_player_untargetable
}
functions.make_player_targetable = {
	name = "Make Player Targetable",
	category = "Perception",
	on_activated = _make_player_targetable
}

local function hide_selected_unit()
	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	Unit.set_unit_visibility(selected_unit, false, true)
end

functions.hide_selected_unit = {
	name = "Hide Selected Unit",
	category = "Unit",
	on_activated = hide_selected_unit
}

local function _current_equipment(slot_name)
	if not Debug.exists() then
		return "n/a"
	end

	local player_unit_spawn_manager = Managers.state.player_unit_spawn

	if player_unit_spawn_manager then
		local local_player = player_unit_spawn_manager:owner(Debug.selected_unit)

		if not local_player or local_player.remote then
			local_player = Managers.player:local_player(1)
		end

		local local_player_unit = local_player.player_unit

		if not local_player_unit then
			return "empty"
		else
			local inventory_component = ScriptUnit.extension(local_player_unit, "unit_data_system"):read_component("inventory")

			return inventory_component[slot_name] or "empty"
		end
	else
		return "n/a"
	end
end

local function _short_party_id(party_id)
	return string.sub(party_id, 1, 8)
end

local function _format_party_entry(party_entry)
	local short_party_id = _short_party_id(party_entry.party_id)

	return short_party_id .. " -> " .. tostring(#party_entry.members)
end

local function _format_party_entries(party_entries)
	local formatted = {}

	for i, party_entry in ipairs(party_entries) do
		if #party_entry.members < 4 then
			table.insert(formatted, _format_party_entry(party_entry))
		end
	end

	return formatted
end

if GameParameters.prod_like_backend then
	functions.immaterium_part_id = {
		readonly = true,
		name = "Party Id",
		category = "Immaterium (Party)",
		get_function = function ()
			return Managers.party_immaterium:party_id()
		end
	}
	functions.immaterium_debug_party_joiner = {
		name = "Party Joiner",
		category = "Immaterium (Party)",
		dynamic_contents = true,
		options_function = function ()
			return _format_party_entries(Managers.party_immaterium:cached_debug_get_parties())
		end,
		on_activated = function (selected_option)
			local short_party_id = _short_party_id(selected_option)

			for i, party in ipairs(Managers.party_immaterium:cached_debug_get_parties()) do
				if string.starts_with(party.party_id, short_party_id) then
					Managers.party_immaterium:join_party(party.party_id)

					return
				end
			end
		end
	}
	functions.immaterium_leave_party = {
		name = "Leave Party",
		category = "Immaterium (Party)",
		on_activated = function ()
			Managers.party_immaterium:leave_party()
		end
	}
end

local function _equip_slot_on_value_set_function(item_name, old_item_name, slot_name, item_data)
	local player_unit_spawn_manager = Managers.state.player_unit_spawn

	if not player_unit_spawn_manager then
		return
	end

	local local_player = player_unit_spawn_manager:owner(Debug.selected_unit)

	if not local_player or local_player.remote then
		local_player = Managers.player:local_player(1)
	end

	local is_server = Managers.state.game_session:is_server()
	local player_unit = local_player.player_unit
	local visual_loadout_extension = ScriptUnit.extension(player_unit, "visual_loadout_system")
	local inventory_component = ScriptUnit.extension(player_unit, "unit_data_system"):read_component("inventory")
	local previous_item = inventory_component[slot_name]
	local can_unequip = previous_item ~= visual_loadout_extension.UNEQUIPPED_SLOT

	if not can_unequip and not item_data then
		return
	end

	local profile = local_player:profile()
	local archetype = profile.archetype
	local breed_name = archetype.breed
	local breeds = item_data and item_data.breeds
	local breed_valid = not breeds or table.contains(breeds, breed_name)

	if not breed_valid then
		Log.info("DebugFunction", "Skipping equip of item %q due to non-compatible breed.", item_name)

		return
	end

	local character_id = local_player:character_id()
	local peer_id = local_player:peer_id()
	local local_player_id = local_player:local_player_id()

	if not local_player:has_local_profile() then
		if item_data then
			Managers.data_service.profiles:equip_item_slot_debug(character_id, slot_name, item_data.name):next(function (v)
				Log.debug("DebugFunctions", "Equipped!")

				if is_server then
					local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

					profile_synchronizer_host:profile_changed(peer_id, local_player_id)
				else
					Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
				end
			end):catch(function (errors)
				Log.error("DebugFunctions", "Equipping %s to %s failed. You probably have Steam running together with a local character profile! %s", item_data.name, slot_name, errors)
			end)
		end
	elseif is_server then
		local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

		profile_synchronizer_host:override_slot(peer_id, local_player_id, slot_name, item_data.name)
	else
		local slot_name_id = NetworkLookup.player_inventory_slot_names[slot_name]
		local item_name_id = NetworkLookup.player_item_names[item_data.name]

		Managers.connection:send_rpc_server("rpc_notify_profile_changed_debug_item", peer_id, local_player_id, slot_name_id, item_name_id)
	end
end

local function _equip_gear_options_function(item_definitions, optional_first_entry)
	local player_items_gear_names = table.keys(item_definitions)

	table.sort(player_items_gear_names)

	if optional_first_entry then
		table.insert(player_items_gear_names, 1, optional_first_entry)
	end

	return player_items_gear_names
end

local function _equip_gear_on_value_set_function(item_name, old_item_name, slot_name, item_definitions)
	local item_data = item_definitions[item_name]

	_equip_slot_on_value_set_function(item_name, old_item_name, slot_name, item_data)
end

local function _generate_slot_item_definitions_lookup(player_items)
	local item_definitions_lookup = {}

	for item_name, item_data in pairs(player_items) do
		local slots = item_data.slots

		if slots then
			for j = 1, #slots do
				local slot_name = slots[j]
				local lookup = item_definitions_lookup[slot_name]

				if not lookup then
					lookup = {}
					item_definitions_lookup[slot_name] = lookup
				end

				lookup[item_name] = item_data
			end
		end
	end

	return item_definitions_lookup
end

local function _add_weapon_category(slot_name, breed_name, workflow_state, definitions)
	local function_key = string.format("equip_%s_%s_%s", workflow_state, slot_name, breed_name)
	local category = string.format("%s - %s", WEAPON_CATEGORY, WEAPON_CATEGORY_DESCRIPTIONS[workflow_state])
	functions[function_key] = {
		category = category,
		name = slot_name,
		get_function = function ()
			return _current_equipment(slot_name)
		end,
		options_function = function ()
			return _equip_gear_options_function(definitions[workflow_state][breed_name])
		end,
		on_activated = function (new_value, old_value)
			_equip_gear_on_value_set_function(new_value, old_value, slot_name, definitions[workflow_state][breed_name])
		end,
		visibility_function = function ()
			local player_unit_spawn_manager = Managers.state.player_unit_spawn

			if not player_unit_spawn_manager then
				return false
			end

			local local_player = player_unit_spawn_manager:owner(Debug.selected_unit)

			if not local_player or local_player.remote then
				local_player = Managers.player:local_player(1)
			end

			local profile = local_player:profile()
			local archetype = profile.archetype
			local archetype_breed_name = archetype.breed

			return archetype_breed_name == breed_name
		end
	}
end

local function _create_weapon_categories(item_definitions, data, slot_name)
	local definitions = {
		releasable = {
			human = {},
			ogryn = {}
		},
		shippable = {
			human = {},
			ogryn = {}
		},
		functional = {
			human = {},
			ogryn = {}
		},
		blockout = {
			human = {},
			ogryn = {}
		},
		prototype = {
			human = {},
			ogryn = {}
		}
	}

	for name, item in pairs(item_definitions) do
		repeat
			local slots = item.slots

			if not slots then
				break
			end

			local is_unarmed = string.find(name, "unarmed")

			if is_unarmed then
				break
			end

			local slot_valid = table.contains(slots, slot_name)

			if not slot_valid then
				break
			end

			local breeds = item.breeds

			if not breeds then
				break
			end

			local archetypes = item.archetypes
			local archetype_valid = not archetypes or archetypes and not table.contains(archetypes, "npc")

			if not archetype_valid then
				break
			end

			local workflow_state = item.workflow_state
			local releasable = workflow_state == "RELEASABLE"
			local shippable = workflow_state == "SHIPPABLE"
			local functional = workflow_state == "FUNCTIONAL"
			local prototype = workflow_state == "PROTOTYPE"
			local blockout = workflow_state == "BLOCKOUT"

			if releasable then
				for j = 1, #breeds do
					definitions.releasable[breeds[j]][name] = item
				end
			elseif shippable then
				for j = 1, #breeds do
					definitions.shippable[breeds[j]][name] = item
				end
			elseif functional then
				for j = 1, #breeds do
					definitions.functional[breeds[j]][name] = item
				end
			elseif prototype then
				for j = 1, #breeds do
					definitions.prototype[breeds[j]][name] = item
				end
			elseif blockout then
				for j = 1, #breeds do
					definitions.blockout[breeds[j]][name] = item
				end
			end
		until true
	end

	local breeds = {
		"human",
		"ogryn"
	}
	local workflow_states = {
		"releasable",
		"shippable",
		"functional",
		"prototype",
		"blockout"
	}

	for breed_i = 1, #breeds do
		for workflow_i = 1, #workflow_states do
			_add_weapon_category(slot_name, breeds[breed_i], workflow_states[workflow_i], definitions)
		end
	end
end

local function _equip_emote_on_value_set_function(item_name, slot_name)
	local player_unit_spawn_manager = Managers.state.player_unit_spawn

	if not player_unit_spawn_manager then
		return
	end

	local local_player = Managers.player:local_player(1)
	local is_server = Managers.state.game_session:is_server()
	local character_id = local_player:character_id()
	local peer_id = local_player:peer_id()
	local local_player_id = local_player:local_player_id()

	if not local_player:has_local_profile() then
		Managers.data_service.profiles:equip_item_slot_debug(character_id, slot_name, item_name):next(function (v)
			Log.debug("DebugFunctions", "Equipped Empote %s", item_name)

			if is_server then
				local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

				profile_synchronizer_host:profile_changed(peer_id, local_player_id)
			else
				Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
			end
		end):catch(function (errors)
			Log.error("DebugFunctions", "Equipping %s to %s failed. You probably have Steam running togehter with a local character profile! %s", item_name, slot_name, errors)
		end)
	elseif is_server then
		local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

		profile_synchronizer_host:override_slot(peer_id, local_player_id, slot_name, item_name)
	else
		local slot_name_id = NetworkLookup.player_inventory_slot_names[slot_name]
		local item_name_id = NetworkLookup.player_item_names[item_name]

		Managers.connection:send_rpc_server("rpc_notify_profile_changed_debug_item", peer_id, local_player_id, slot_name_id, item_name_id)
	end
end

local function _init_weapons(player_items)
	local slot_item_definitions_lookup = _generate_slot_item_definitions_lookup(player_items)

	for slot_name, data in pairs(PlayerCharacterConstants.slot_configuration) do
		local is_weapon = false
		local item_definitions, optional_first_entry, category = nil

		if data.wieldable and data.slot_type == "weapon" then
			item_definitions = slot_item_definitions_lookup[slot_name] or {}
			is_weapon = true
		elseif not data.wieldable then
			category = "Player Equipment - Gear"
			optional_first_entry = "none"
			item_definitions = slot_item_definitions_lookup[slot_name] or {}
		end

		if item_definitions then
			local pretty_name = slot_name

			if is_weapon then
				_create_weapon_categories(item_definitions or {}, data, slot_name)
			else
				functions["equip_" .. slot_name] = {
					category = category,
					name = pretty_name,
					get_function = function ()
						return _current_equipment(slot_name)
					end,
					options_function = function ()
						return _equip_gear_options_function(item_definitions, optional_first_entry)
					end,
					on_activated = function (new_value, old_value)
						_equip_gear_on_value_set_function(new_value, old_value, slot_name, item_definitions)
					end
				}
			end
		end
	end

	functions.equip_emote = {
		name = "Equip Emote",
		category = "Player Equipment - Emotes",
		dynamic_contents = true,
		options_function = function ()
			local options = {}
			local player_unit_spawn_manager = Managers.state.player_unit_spawn

			if not player_unit_spawn_manager then
				return options
			end

			local player = Managers.player:local_player(1)

			if not player:unit_is_alive() then
				return options
			end

			local slot_name = "slot_animation_emote_1"
			local item_definitions = slot_item_definitions_lookup[slot_name] or {}

			if not item_definitions then
				return options
			end

			local breed = player:breed_name()

			for id, item in pairs(item_definitions) do
				local breeds = item.breeds
				local can_use_emote = table.contains(breeds, breed)

				if can_use_emote then
					table.insert(options, id)
				end
			end

			table.sort(options)

			return options
		end,
		on_activated = function (master_item_id, prev_master_item_id)
			if not Managers.state.game_mode then
				return
			end

			local game_mode_name = Managers.state.game_mode:game_mode_name()
			local is_in_hub = game_mode_name == "hub"

			if not is_in_hub then
				return
			end

			local player_unit_spawn_manager = Managers.state.player_unit_spawn

			if not player_unit_spawn_manager then
				return
			end

			local player = Managers.player:local_player(1)
			local player_unit = player.player_unit

			if not player_unit then
				return
			end

			local item = MasterItems.get_item(master_item_id)
			local anim_event = item.animation_event
			local animation_extension = ScriptUnit.extension(player_unit, "animation_system")

			_equip_emote_on_value_set_function(master_item_id, "slot_animation_emote_1")
		end,
		get_function = function ()
			local player_unit_spawn_manager = Managers.state.player_unit_spawn

			if not player_unit_spawn_manager then
				return "empty"
			end

			local player = Managers.player:local_player(1)
			local profile = player:profile()
			local loadout = profile.loadout
			local emote_item = loadout.slot_animation_emote_1

			if not emote_item then
				return "empty"
			end

			local emote_item_name = emote_item.name

			return emote_item_name
		end
	}
end

local function _init_equipment(player_items)
	local function _load_equipment()
		local local_player = Managers.player:local_player(1)
		local local_player_unit = local_player.player_unit

		if not local_player_unit then
			return
		end

		local unit_data_extension = ScriptUnit.extension(local_player_unit, "unit_data_system")
		local breed_name = unit_data_extension:breed_name()
		local equipment_data = Application.user_setting("development_player_equipment", breed_name)

		if not equipment_data then
			Log.warning("DebugFunctions.load_equipment", "Couldn't find any stored equipment for %s.", breed_name)

			return
		end

		local visual_loadout_extension = ScriptUnit.extension(local_player_unit, "visual_loadout_system")
		local UNEQUIPPED_SLOT = visual_loadout_extension.UNEQUIPPED_SLOT
		local slot_configuration = visual_loadout_extension:slot_configuration()

		for slot_name, config in pairs(slot_configuration) do
			local item_name = equipment_data[slot_name]

			if item_name then
				if item_name == UNEQUIPPED_SLOT then
					_equip_slot_on_value_set_function(item_name, nil, slot_name, nil)
				else
					local item_data = rawget(player_items, item_name)

					if item_data then
						_equip_slot_on_value_set_function(item_name, nil, slot_name, item_data)
					else
						Log.warning("DebugFunctions.load_equipment", "Couldn't find item %s (%s) whilst loading equipment for %s - skipping.", item_name, slot_name, breed_name)
					end
				end
			end
		end

		Log.info("DebugFunctions.load_equipment", "Equipment loaded for %s.", breed_name)
	end

	local function _save_equipment()
		local local_player = Managers.player:local_player(1)
		local local_player_unit = local_player.player_unit

		if not local_player_unit then
			return
		end

		local unit_data_extension = ScriptUnit.extension(local_player_unit, "unit_data_system")
		local inventory_component = unit_data_extension:read_component("inventory")
		local equipment_data = {}
		local visual_loadout_extension = ScriptUnit.extension(local_player_unit, "visual_loadout_system")
		local slot_configuration = visual_loadout_extension:slot_configuration()

		for slot_name, config in pairs(slot_configuration) do
			if not config.wieldable or config.slot_type == "weapon" then
				local item_name = inventory_component[slot_name]
				equipment_data[slot_name] = item_name
			end
		end

		local breed_name = unit_data_extension:breed_name()

		Application.set_user_setting("development_player_equipment", breed_name, equipment_data)
		Application.save_user_settings()
		Log.info("DebugFunctions.save_equipment", "Equipment saved for %s.", breed_name)
	end

	functions.load_equipment = {
		name = "Load Equipment",
		category = "Player Equipment",
		on_activated = _load_equipment
	}
	functions.save_equipment = {
		name = "Save Equipment",
		category = "Player Equipment",
		on_activated = _save_equipment
	}
end

local function _gift_equipped()
	for slot_name, data in pairs(PlayerCharacterConstants.slot_configuration) do
		if data.slot_type == "gear" or data.slot_type == "weapon" then
			local item = _current_equipment(slot_name)

			if not string.ends_with(item, "_empty") and item ~= "not_equipped" then
				Log.info("DebugFunctions", "Gifting item %s", item)
				Managers.data_service.gear:create_gear(item, slot_name, nil, nil, false):next(function (v)
					Log.info("DebugFunctions", " %s created", v.uuid)
				end)
			end
		end
	end
end

local function _clear_inventory(wrapped)
	if not wrapped then
		Log.info("DebugFunctions", "Clearing inventory")
		Managers.backend.interfaces.gear:fetch_paged(10):next(_clear_inventory)
	else
		local deletes = {}

		for k, v in pairs(wrapped.items) do
			if string.starts_with(v.uuid, "default") or string.starts_with(v.uuid, "cosmetic") then
				Log.info("DebugFunctions", "Skipping item %s", v.uuid)
			else
				Log.info("DebugFunctions", "Deleting item %s", v.uuid)
				table.insert(deletes, Managers.data_service.gear:delete_gear(v.uuid):next(function (_)
					Log.info("DebugFunctions", " %s deleted", v.uuid)
				end))
			end
		end

		if wrapped.has_next then
			Promise.all(unpack(deletes)):next(wrapped.next_page():next(_clear_inventory))
		end
	end
end

functions.clear_inventory = {
	name = "Clear Inventory",
	category = "Player Inventory",
	on_activated = _clear_inventory
}
functions.gift_equipped = {
	name = "Gift all equipped items",
	category = "Player Inventory",
	on_activated = _gift_equipped
}

local function _dump_selected_loadout_on_activated(new_value, old_value)
	local local_player = Managers.player:local_player(1)
	local local_player_unit = local_player.player_unit

	if not local_player_unit then
		return
	end

	local unit_data_extension = ScriptUnit.extension(local_player_unit, "unit_data_system")
	local inventory_component = unit_data_extension:read_component("inventory")
	local visual_loadout_extension = ScriptUnit.extension(local_player_unit, "visual_loadout_system")
	local slot_configuration = visual_loadout_extension:slot_configuration()
	local s = "loudout = {"

	for slot_name, config in pairs(slot_configuration) do
		local item_name = inventory_component[slot_name]

		if item_name ~= "not_equipped" then
			s = string.format("%s\n\t%s = \"%s\",", s, slot_name, item_name)
		end
	end

	s = s .. "\n},"

	Log.info("DebugFunctions", "%s", s)

	if not Clipboard.put(s) then
		Log.warning("DebugFunctions (Dump Selected Loudout)", "Failed to copy string to clipboard.")
	end
end

functions.dump_selected_loudout = {
	name = "Dump Selected Loudout",
	category = "Player Equipment",
	on_activated = _dump_selected_loadout_on_activated
}

local function _modify_ammo(amount)
	if amount == 0 then
		return
	end

	local local_player = Managers.player:local_player(1)

	if local_player:unit_is_alive() then
		local is_server = Managers.state.game_session:is_server()
		local local_player_unit = local_player.player_unit
		local game_object_id = Managers.state.unit_spawner:game_object_id(local_player_unit)

		if is_server then
			Debug:rpc_debug_client_request_modify_ammo(nil, game_object_id, amount)
		else
			Managers.state.game_session:send_rpc_server("rpc_debug_client_request_modify_ammo", game_object_id, amount)
		end
	end
end

functions.modify_ammo = {
	name = "Modify Ammo",
	category = "Player Equipment",
	width = 40,
	number_button = true,
	on_activated = _modify_ammo
}
functions.weapons = {
	num_decimals = 0,
	name = "Clear ammo reserve",
	category = "Player Equipment",
	number_button = false,
	on_activated = function (value)
		local local_player = Managers.player:local_player(1)

		if not local_player then
			return
		end

		local player_unit = local_player.player_unit

		if not ALIVE[player_unit] then
			return
		end

		local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")

		weapon_extension:debug_set_ammo_reserve(0)
	end
}

local function _delete_characters(character_profiles)
	local character_ids = {}

	for _, character_profile in pairs(character_profiles) do
		local character_id = character_profile.character_id
		character_ids[#character_ids + 1] = character_id
	end

	Managers.event:trigger("event_request_delete_multiple_characters", character_ids)
end

local function _main_menu_view()
	local main_menu_view = ui_manager._view_handler._active_views_data.main_menu_view.instance

	return main_menu_view
end

local function _character_profiles()
	local main_menu_view = _main_menu_view()
	local character_profiles = main_menu_view._character_profiles

	return character_profiles
end

local function _delete_amount_of_characters(amount)
	local character_profiles = _character_profiles()
	local profiles_to_delete = table.move(character_profiles, 1, amount, 1, {})

	_delete_characters(profiles_to_delete)
end

local function _delete_all_characters()
	local character_profiles = _character_profiles()
	local amount = #character_profiles

	_delete_amount_of_characters(amount)
end

local function _delete_selected_character()
	local main_menu_view = _main_menu_view()
	local selected_character_index = main_menu_view._selected_character_list_index
	local selected_character_slot_widget = main_menu_view._character_list_widgets[selected_character_index]
	local selected_character_profile = selected_character_slot_widget.content.profile

	_delete_characters({
		selected_character_profile
	})
end

local function _is_main_menu_active()
	local active_view = ui_manager._view_handler:active_top_view()
	local is_main_menu_active = active_view == "main_menu_view"

	return is_main_menu_active
end

functions.play_emote_animation = {
	name = " ->",
	button_text = "Play Emote",
	category = "Player Equipment - Emotes",
	on_activated = function ()
		if not Managers.state.game_mode then
			Managers.event:trigger("event_add_notification_message", "dev", "Can only play Emotes in Hub")

			return
		end

		local game_mode_name = Managers.state.game_mode:game_mode_name()
		local is_in_hub = game_mode_name == "hub"

		if not is_in_hub then
			Managers.event:trigger("event_add_notification_message", "dev", "Can only play Emotes in Hub")

			return
		end

		Managers.event:trigger("player_activate_emote", "emote_1")
	end
}
functions.add_all_animation_items = {
	name = "Add All Emotes and EOR Animation Items to Inventory",
	button_text = "Add",
	category = "Player Equipment - Emotes",
	on_activated = function ()
		local player_unit_spawn_manager = Managers.state.player_unit_spawn

		if not player_unit_spawn_manager then
			return "empty"
		end

		local player = Managers.player:local_player(1)
		local character_id = player:character_id()

		if not character_id then
			return
		end

		local item_definitions = MasterItems.get_cached()

		for id, item in pairs(item_definitions) do
			repeat
				local item_type = item.item_type

				if not item_type then
					break
				end

				if item_type == "EMOTE" or item_type == "END_OF_ROUND" then
					local item_name = item.name
					local slots = item.slots
					local slot_name = slots[1]
					local overrides = {}
					local DONT_ALLOW_DUPLICATES = false

					Managers.data_service.gear:create_gear(item_name, slot_name, nil, overrides, DONT_ALLOW_DUPLICATES):next(function (v)
						local gear = v.gear
						local gear_id = gear.uuid

						Log.info("DebugFunctions", " %s created in inventory: %s", item_name, gear_id)
					end):catch(function (errors)
						Log.error("DebugFunctions", "Creating %s failed: %s", item_name, errors)
					end)
				end
			until true
		end
	end
}
functions.delete_all_characters = {
	name = "Delete All Characters",
	category = "Player Profiles",
	on_activated = function ()
		local is_main_menu_active = _is_main_menu_active()

		if is_main_menu_active then
			_delete_all_characters()
		else
			Log.info("DebugFunctions", "You can only delete characters while in the main menu!")
		end
	end
}
functions.delete_characters = {
	name = "Delete Characters",
	number_button = true,
	category = "Player Profiles",
	on_activated = function (amount)
		local is_main_menu_active = _is_main_menu_active()

		if is_main_menu_active then
			_delete_amount_of_characters(amount)
		else
			Log.info("DebugFunctions", "You can only delete characters while in the main menu!")
		end
	end
}
functions.delete_selected_character = {
	name = "Delete Selected Character",
	category = "Player Profiles",
	on_activated = function ()
		local is_main_menu_active = _is_main_menu_active()

		if is_main_menu_active then
			_delete_selected_character()
		else
			Log.info("DebugFunctions", "You can only delete characters while in the main menu!")
		end
	end
}

local function _select_player_voice(selected_voice)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local local_player = Managers.player:local_player(1)
		local local_player_unit = local_player.player_unit
		local dialogue_extension = ScriptUnit.extension(local_player_unit, "dialogue_system")

		dialogue_extension:set_vo_profile(selected_voice)
	end
end

local DialogueBreedSettings = require("scripts/settings/dialogue/dialogue_breed_settings")
functions.select_player_voice = {
	name = "Select Player Voice",
	category = "Player Voice",
	options_function = function ()
		local voices = DialogueBreedSettings.human.wwise_voices

		return voices
	end,
	on_activated = function (new_value, old_value)
		_select_player_voice(new_value)
	end
}
functions.report_error = {
	name = "Report Error",
	category = "Error",
	options_function = function ()
		local level_names = {}

		for name, level in pairs(Managers.error.ERROR_LEVEL) do
			level_names[level] = name
		end

		return level_names
	end,
	on_activated = function (level_name)
		local test_error_class = require("scripts/managers/error/errors/test_error")
		local error_obj = test_error_class:new(level_name)

		Managers.error:report_error(error_obj)
	end
}
functions.complete_game_mode = {
	name = "Complete Game Mode",
	category = "Game Mode",
	on_activated = function ()
		local outcome = "won"
		local is_server = Managers.state.game_session:is_server()

		if is_server then
			Managers.state.game_mode:debug_complete_game_mode(outcome)
		else
			local outcome_id = NetworkLookup.game_mode_outcomes[outcome]

			Managers.state.game_session:send_rpc_server("rpc_debug_client_request_complete_game_mode", outcome_id)
		end
	end
}
functions.fail_game_mode = {
	name = "Fail Game Mode",
	category = "Game Mode",
	on_activated = function ()
		local outcome = "lost"
		local is_server = Managers.state.game_session:is_server()

		if is_server then
			Managers.state.game_mode:debug_complete_game_mode(outcome)
		else
			local outcome_id = NetworkLookup.game_mode_outcomes[outcome]

			Managers.state.game_session:send_rpc_server("rpc_debug_client_request_complete_game_mode", outcome_id)
		end
	end
}
functions.force_respawn = {
	name = "Force Respawn All Players",
	category = "Game Mode",
	on_activated = function ()
		local is_server = Managers.state.game_session:is_server()

		if is_server then
			Managers.state.game_mode:debug_force_respawn()
		else
			Managers.state.game_session:send_rpc_server("rpc_debug_client_request_force_respawn")
		end
	end
}
functions.debug_stagger_selected_unit = {
	name = "Stagger (DevParams)",
	button_text = "Trigger",
	category = "Stagger",
	on_activated = function ()
		local selected_unit = Debug.selected_unit

		if selected_unit then
			local Stagger = require("scripts/utilities/attack/stagger")

			Stagger.debug_trigger_minion_stagger(selected_unit)
		end
	end
}
functions.debug_stagger_selected_unit_with_animation = {
	name = "Stagger With Animation (DevParams)",
	category = "Stagger",
	dynamic_contents = true,
	on_activated = function (stagger_animation)
		local selected_unit = Debug.selected_unit

		if selected_unit then
			local Stagger = require("scripts/utilities/attack/stagger")
			local stagger_direction = nil

			Stagger.debug_trigger_minion_stagger(selected_unit, stagger_direction, stagger_animation)
		end
	end,
	options_function = function ()
		local options = {}
		local selected_unit = Debug:exists() and Debug.selected_unit

		if selected_unit and ALIVE[selected_unit] then
			local is_server = Managers.state.game_session:is_server()

			if not is_server then
				return options
			end

			local unit_data_extension = ScriptUnit.has_extension(selected_unit, "unit_data_system")

			if not unit_data_extension then
				return options
			end

			local breed = unit_data_extension:breed()

			if Breed.is_player(breed) then
				return options
			end

			local behavior_extension = ScriptUnit.has_extension(selected_unit, "behavior_system")

			if not behavior_extension then
				return options
			end

			local brain = behavior_extension:brain()
			local behavior_tree = brain:behavior_tree()
			local action_data = behavior_tree:action_data()
			local stagger_action_data = action_data.stagger

			if stagger_action_data then
				local stagger_type = DevParameters.debug_stagger_type
				local action_stagger_anims = stagger_action_data.stagger_anims
				local stagger_type_anims = action_stagger_anims[stagger_type]

				if stagger_type_anims then
					local stagger_direction = DevParameters.debug_stagger_direction
					local stagger_direction_anims = stagger_type_anims[stagger_direction]

					if stagger_direction_anims then
						for _, animation in pairs(stagger_direction_anims) do
							table.insert(options, animation)
						end
					end
				end
			end

			table.sort(options)
		end

		return options
	end
}
functions.force_max_suppression = {
	name = "Force max suppression to unit",
	button_text = "Apply",
	category = "Suppression",
	on_activated = function ()
		local selected_unit = Debug.selected_unit

		if not selected_unit then
			local local_player = Managers.player:local_player(1)
			selected_unit = local_player.player_unit
		end

		if selected_unit then
			local suppression_extension = ScriptUnit.has_extension(selected_unit, "suppression_system")

			if suppression_extension then
				suppression_extension:debug_force_max_suppression()
			end
		end
	end
}
functions.add_max_suppression = {
	name = "Add suppression to unit",
	button_text = "Apply",
	category = "Suppression",
	on_activated = function ()
		local selected_unit = Debug.selected_unit

		if not selected_unit then
			local local_player = Managers.player:local_player(1)
			selected_unit = local_player.player_unit
		end

		if selected_unit then
			local suppression_extension = ScriptUnit.has_extension(selected_unit, "suppression_system")

			if suppression_extension then
				suppression_extension:debug_add_suppression()
			end
		end
	end
}

local function actions_options()
	local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")
	local weapon_template = WeaponTemplates[DevParameters.sweep_spline_selected_weapon_template]
	local options = {}

	for name, action_settings in pairs(weapon_template.actions) do
		if action_settings.kind == "sweep" then
			options[#options + 1] = name
		end
	end

	return options
end

local function run_sweep_spline_editor(new_value, old_value)
	local local_player = Managers.player:local_player(1)

	if local_player:unit_is_alive() then
		local player_unit = local_player.player_unit
		local weapon_template_name = DevParameters.sweep_spline_selected_weapon_template
		local weapon_system = Managers.state.extension:system("weapon_system")

		weapon_system:debug_run_sweep_editor(player_unit, weapon_template_name, new_value)
	end
end

functions.sweep_spline_editor = {
	name = "Start Sweep Spline Editor",
	category = "Sweep Spline",
	options_function = actions_options,
	on_activated = run_sweep_spline_editor
}

local function _dump_selected_talents_on_activated(new_value, old_value)
	local local_player = Managers.player:local_player(1)
	local profile = local_player and local_player:profile()

	if profile then
		local account_id = local_player:account_id()
		local character_id = local_player:character_id()
		local name = HAS_STEAM and Steam.user_name(Steam.user_id()) or local_player:name()
		local archetype = local_player:archetype_name()
		local talents = profile.talents
		local s = string.format([[
Account ID: %s
Character ID: %s
Name: %s
Archetype: %s
Talents:]], account_id, character_id, name, archetype)

		for talent_name, _ in pairs(talents) do
			s = string.format("%s\n%s", s, talent_name)
		end

		Log.info("DebugFunctions", "%s", s)

		if not Clipboard.put(s) then
			Log.warning("DebugFunctions (Dump Selected Talents)", "Failed to copy string to clipboard.")
		end
	end
end

functions.dump_selected_talents = {
	name = "Dump Selected Talents",
	category = "Talents",
	on_activated = _dump_selected_talents_on_activated
}
functions.reset_time_scale = {
	name = "Reset Time Scale",
	category = "Time",
	on_activated = function (new_value, old_value)
		Debug:reset_time_scale()
	end
}

local function _sleep(seconds)
	Application.sleep(1000 * seconds)
end

functions.sleep = {
	width = 60,
	name = "Sleep for x seconds.",
	num_decimals = 2,
	category = "Time",
	button_text = "Sleep",
	number_button = true,
	on_activated = _sleep
}

local function _reset_dev_parameters()
	local ParameterResolver = require("scripts/foundation/utilities/parameters/parameter_resolver")

	ParameterResolver.reset_defaults()
end

functions.reset_dev_parameters = {
	name = "Reset Dev Parameters",
	category = "Dev Parameters",
	on_activated = _reset_dev_parameters
}

local function _params_to_string(actual, defaults)
	local params_as_strings = {}

	for name, default_value in pairs(defaults) do
		repeat
			local value = actual[name]
			local should_skip = type(value) == "table"

			if should_skip then
				break
			end

			if type(default_value) == "table" and default_value.value ~= nil then
				default_value = default_value.value
			end

			if value ~= default_value then
				if value == true then
					params_as_strings[#params_as_strings + 1] = string.format("-%s", name)
				elseif type(value) == "string" and string.find(value, " ") ~= nil then
					params_as_strings[#params_as_strings + 1] = string.format("-%s \"%s\"", name, value)
				else
					params_as_strings[#params_as_strings + 1] = string.format("-%s %s", name, value)
				end
			end
		until true
	end

	return table.concat(params_as_strings, " ")
end

local function _copy_parameters()
	local game_params = _params_to_string(GameParameters, require("scripts/foundation/utilities/parameters/default_game_parameters"))
	local dev_params = _params_to_string(DevParameters, require("scripts/foundation/utilities/parameters/default_dev_parameters").parameters)
	local all_strings = {}

	if #game_params > 0 then
		all_strings[#all_strings + 1] = "-game"
		all_strings[#all_strings + 1] = game_params
	end

	if #dev_params > 0 then
		all_strings[#all_strings + 1] = "-dev"
		all_strings[#all_strings + 1] = dev_params
	end

	local concat_string = table.concat(all_strings, " ")

	if not Clipboard.put(concat_string) then
		Log.warning("DebugFunctions", "Failed to copy string to clipboard.")
	end
end

functions.copy_parameters = {
	name = "Copy Parameters",
	category = "Dev Parameters",
	on_activated = _copy_parameters
}

local function _next_level()
	local local_player = Managers.player:local_player(1)
	local profile = local_player:profile()

	if profile then
		local character_id = local_player:character_id()
		local current_level = profile.current_level

		if character_id then
			Managers.backend.interfaces.progression:get_progression("character", character_id):next(function (character_progression)
				local needed_xp_for_next_level = character_progression.neededXpForNextLevel

				if needed_xp_for_next_level == 0 or needed_xp_for_next_level == -1 then
					return Promise.resolved(true)
				end

				local current_xp = character_progression.currentXp
				local new_xp = current_xp + needed_xp_for_next_level
				local promise = Managers.backend.interfaces.progression:set_character_xp(character_id, new_xp)

				return promise
			end):next(function (data)
				local next_level = current_level + 1
				local promise = Managers.backend.interfaces.progression:level_up_character(character_id, next_level)

				return promise
			end):next(function (data)
				local new_level = data.progressionInfo.currentLevel
				local new_xp = data.progressionInfo.currentXp

				Log.info("DebugFunctions", "Player level bumped to: %s, Player xp bumped to %s", new_level, new_xp)

				profile.current_level = new_level
			end):catch(function (error)
				Log.info("DebugFunctions", "Bumping player level failed, %s", error)
			end)
		end
	end
end

functions.level_up = {
	name = "Level Up Character",
	button_text = "Level Up",
	category = "Progression",
	on_activated = _next_level
}

local function _set_xp(value)
	local local_player = Managers.player:local_player(1)
	local profile = local_player:profile()

	if profile then
		local character_id = local_player:character_id()

		if character_id then
			local promise = Managers.backend.interfaces.progression:set_character_xp(character_id, value)

			promise:next(function ()
				Log.info("DebugFunctions", "XP set to: %d", value)
			end):catch(function (error)
				Log.info("DebugFunctions", "Adding character XP failed, %s", error)
			end)
		end
	end
end

functions.set_xp = {
	name = "Set XP of Character",
	category = "Progression",
	button_text = "Set XP",
	number_button = true,
	on_activated = _set_xp
}
local Stories = require("scripts/settings/narrative/narrative_stories").stories

local function _get_chapter_names(chapters)
	local names = {
		"reset"
	}

	for i = 1, #chapters do
		names[i + 1] = chapters[i].name
	end

	return names
end

for story_name, chapters in pairs(Stories) do
	local function _set_story(chapter_name)
		if chapter_name ~= "reset" then
			Managers.narrative:force_story_chapter(story_name, chapter_name)
		else
			Managers.narrative:force_story_chapter(story_name)
		end
	end

	functions[string.format("force_story_%s", story_name)] = {
		category = "Progression",
		name = string.format("Force %s to specific chapter", story_name),
		on_activated = _set_story,
		options_function = _get_chapter_names(chapters)
	}
end

local function _get_story_names()
	return table.keys(Stories)
end

local function _skip_story(story_name)
	Managers.narrative:skip_story(story_name)
end

functions.skip_story = {
	name = "Skip narrative story",
	category = "Progression",
	on_activated = _skip_story,
	options_function = _get_story_names
}

local function _list_narrative_event_names()
	local NarrativeStories = require("scripts/settings/narrative/narrative_stories")

	return table.keys(NarrativeStories.events)
end

local function _complete_narrative_event(event_name)
	Managers.narrative:force_event_complete(event_name)
end

functions.complete_narrative_event = {
	name = "Set a narrative event to complete",
	category = "Progression",
	on_activated = _complete_narrative_event,
	options_function = _list_narrative_event_names
}

local function _uncomplete_narrative_event(event_name)
	Managers.narrative:force_event_not_complete(event_name)
end

functions.reset_narrative_event = {
	name = "Set a narrative event to not completed",
	category = "Progression",
	on_activated = _uncomplete_narrative_event,
	options_function = _list_narrative_event_names
}

local function _unlock_tracked_achievements()
	local favorite_achievements = Managers.save:account_data().favorite_achievements

	for i = 1, #favorite_achievements do
		local achievement_id = favorite_achievements[i]

		if achievement_id then
			local channel = Managers.connection:host_channel()

			RPC.rpc_debug_client_request_unlock_achievement(channel, achievement_id)
		end
	end
end

functions.unlock_tracked_achievements = {
	name = "Unlock tracked achievements",
	category = "Progression",
	on_activated = _unlock_tracked_achievements
}

local function _delete_all_achievements()
	local channel = Managers.connection:host_channel()
	local local_player = Managers.player:local_player(1)
	local account_id = local_player:account_id()

	RPC.rpc_debug_client_request_reset_achievements(channel, account_id)
end

functions.delete_current_achievement_progression = {
	name = "Reset achievement progress",
	category = "Progression",
	on_activated = _delete_all_achievements
}
local Views = require("scripts/ui/views/views")

local function _ui_manager_not_initialized()
	Log.warning("DebugFunctions", "The UI Manager has not been initialized")
end

local function _get_all_active_views()
	if ui_manager then
		return ui_manager._view_handler._active_views_array
	else
		_ui_manager_not_initialized()
	end
end

local function _get_all_view_names()
	local filtered_views = {}
	local i = 1

	for view_name, view in pairs(Views) do
		local testify_flags = view.testify_flags
		local should_include = testify_flags and testify_flags.ui_views

		if should_include == true or type(should_include) == "function" and should_include() then
			filtered_views[i] = view_name
			i = i + 1
		end
	end

	table.sort(filtered_views)

	return filtered_views
end

functions.close_all_views = {
	name = "Close All Views",
	category = "UI",
	on_activated = function ()
		if ui_manager then
			ui_manager:close_all_views()
		else
			_ui_manager_not_initialized()
		end
	end
}
functions.close_view = {
	name = "Close View",
	category = "UI",
	dynamic_contents = true,
	options_function = function ()
		return _get_all_active_views()
	end,
	on_activated = function (view_name)
		if ui_manager then
			ui_manager:close_view(view_name)
		else
			_ui_manager_not_initialized()
		end
	end
}
functions.open_view = {
	name = "Open View",
	category = "UI",
	options_function = function ()
		return _get_all_view_names()
	end,
	on_activated = function (view_name)
		if ui_manager then
			local is_view_active = ui_manager:view_active(view_name)

			if not is_view_active then
				local context = Views[view_name].dummy_data or {
					debug_preview = true,
					can_exit = true
				}

				ui_manager:open_view(view_name, nil, nil, nil, nil, context)
			else
				Log.warning("DebugFunctions", "View with name " .. view_name .. " is already active.")
			end
		else
			_ui_manager_not_initialized()
		end
	end
}
local selected_voice, selected_sound_event_type, selected_sound_event, player_manager = nil

local function _dialogue_extension()
	local player = player_manager:local_player(1)

	if player == nil or player.player_unit == nil then
		return
	end

	local dialogue_extension = ScriptUnit.extension(player.player_unit, "dialogue_system")

	return dialogue_extension
end

local function _select_voice(voice)
	selected_voice = voice
	selected_sound_event_type = nil
	selected_sound_event = nil
	local dialogue_extension = _dialogue_extension()

	if dialogue_extension then
		local old_vo_profile = dialogue_extension:get_profile_name()

		dialogue_extension:set_vo_profile(voice)
		dialogue_extension:set_vo_profile(old_vo_profile)
	end
end

local function _sound_event_types()
	if selected_voice then
		local dialogue_extension = _dialogue_extension()

		if dialogue_extension == nil then
			return EMPTY_TABLE
		end

		local vo_sources = dialogue_extension._vo_sources_cache._vo_sources
		local sound_event_types = vo_sources[selected_voice]
		local sound_event_type_names = table.keys(sound_event_types)

		table.sort(sound_event_type_names, function (a, b)
			return a:upper() < b:upper()
		end)

		return sound_event_type_names
	else
		return EMPTY_TABLE
	end
end

local function _sound_events()
	if selected_sound_event_type then
		local dialogue_extension = _dialogue_extension()

		if dialogue_extension == nil then
			return EMPTY_TABLE
		end

		local vo_sources = dialogue_extension._vo_sources_cache._vo_sources
		local sound_event_types = vo_sources[selected_voice]
		local sound_event_type = sound_event_types[selected_sound_event_type]
		local sound_events = sound_event_type.sound_events

		return sound_events
	else
		return EMPTY_TABLE
	end
end

local function _play_selected_sound_event()
	local dialogue_extension = _dialogue_extension()

	if selected_sound_event and dialogue_extension then
		local wwise_route = dialogue_extension._dialogue_system._wwise_route_default
		local event_type = "vorbis_external"
		local sound_event = {
			type = event_type,
			wwise_route = wwise_route,
			sound_event = selected_sound_event
		}

		dialogue_extension:play_event(sound_event)

		local subtitle_localized = Managers.localization:localize(sound_event.sound_event, true)
		local constant_elements = Managers.ui:ui_constant_elements()
		local constant_element_subtitles = constant_elements:element("ConstantElementSubtitles")

		constant_element_subtitles:_display_text_line(subtitle_localized, 10)
		Log.info("DebugFunctions", "Played sound event: " .. selected_sound_event)
	else
		Log.info("DebugFunctions", "You need to select a sound event to be able to play one!")
	end
end

functions.select_voice = {
	name = "01. Select Voice",
	category = "VO",
	get_function = function ()
		return selected_voice or ""
	end,
	options_function = function ()
		local voices = {}

		for key, speaker in pairs(DialogueSpeakerVoiceSettings) do
			voices[#voices + 1] = key
		end

		voices = table.unique_array_values(voices)

		table.sort(voices, function (a, b)
			return a:upper() < b:upper()
		end)

		return voices
	end,
	on_activated = function (voice)
		_select_voice(voice)
	end
}
functions.select_sound_event_type = {
	name = "02. Select Sound Event Type",
	category = "VO",
	dynamic_contents = true,
	get_function = function ()
		return selected_sound_event_type or ""
	end,
	options_function = function ()
		return _sound_event_types()
	end,
	on_activated = function (sound_event_type)
		selected_sound_event_type = sound_event_type
		selected_sound_event = nil
	end
}
functions.select_sound_event = {
	name = "03. Select Sound Event",
	category = "VO",
	dynamic_contents = true,
	get_function = function ()
		return selected_sound_event or ""
	end,
	options_function = function ()
		return _sound_events()
	end,
	on_activated = function (sound_event)
		selected_sound_event = sound_event
	end
}
functions.play_sound_event = {
	name = "04. Play Sound Event",
	category = "VO",
	on_activated = function ()
		_play_selected_sound_event()
	end
}

local function voice_fx_options()
	local options = {
		"voice_fx_rtpc_none",
		"voice_fx_rtpc_common",
		"voice_fx_rtpc_common_cloth_filter",
		"voice_fx_rtpc_common_filter",
		"voice_fx_rtpc_common_filter_metal",
		"voice_fx_rtpc_common_krieg",
		"voice_fx_rtpc_common_metal",
		"voice_fx_rtpc_common_tubes",
		"voice_fx_rtpc_rare",
		"voice_fx_rtpc_rare_cloth_filter",
		"voice_fx_rtpc_rare_ecclesiarchy_metal",
		"voice_fx_rtpc_rare_filter",
		"voice_fx_rtpc_rare_filter_metal",
		"voice_fx_rtpc_rare_genstealer_metal",
		"voice_fx_rtpc_rare_tubes",
		"voice_fx_rtpc_epic",
		"voice_fx_rtpc_epic_filter",
		"voice_fx_rtpc_epic_enforcer",
		"voice_fx_rtpc_epic_cloth_filter",
		"voice_fx_rtpc_epic_metal",
		"voice_fx_rtpc_epic_speaker_robo",
		"voice_fx_rtpc_epic_tubes",
		"voice_fx_rtpc_epic_voice_box_pitch",
		"voice_fx_rtpc_voice_box_a",
		"voice_fx_rtpc_epic_psyker_collar",
		"voice_fx_rtpc_robo_a"
	}

	return options
end

local function select_voice_fx(new_value)
	local dialogue_extension = _dialogue_extension()

	dialogue_extension:set_voice_fx_preset(new_value)
end

local function override_all_voice_fx(new_value)
	local side_system = Managers.state.extension:system("side_system")
	local side_name = side_system:get_default_player_side_name()
	local side = side_system:get_side_from_name(side_name)
	local players = side:added_player_units()

	for i = 1, #players do
		local unit = players[i]
		local dialogue_extension = ScriptUnit.has_extension(unit, "dialogue_system")

		dialogue_extension:set_voice_fx_preset(new_value)
	end
end

functions.select_voice_fx = {
	name = "05. Select Voice FX",
	category = "VO",
	options_function = voice_fx_options,
	on_activated = select_voice_fx
}
functions.override_all_voice_fx = {
	name = "06. Override All Voice FX",
	category = "VO",
	options_function = voice_fx_options,
	on_activated = override_all_voice_fx
}
functions.apply_weapon_trait_lerp_value = {
	num_decimals = 2,
	name = "Override Weapon Trait Lerp Value",
	category = "Weapon Traits",
	number_button = true,
	on_activated = function (value)
		local local_player = Managers.player:local_player(1)

		if not local_player then
			return
		end

		local player_unit = local_player.player_unit

		if not ALIVE[player_unit] then
			return
		end

		local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")

		weapon_extension:debug_apply_trait_lerp_value(value)
	end
}
functions.reset_weapon_lerp_values = {
	name = "Remove Override Weapon Trait and Tweak Lerp Value",
	category = "Weapon Traits",
	on_activated = function ()
		local local_player = Managers.player:local_player(1)

		if not local_player then
			return
		end

		local player_unit = local_player.player_unit

		if not ALIVE[player_unit] then
			return
		end

		local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")

		weapon_extension:debug_remove_trait_lerp_value()
	end
}
functions.apply_lerp_value_to_all_tweak_templates = {
	num_decimals = 2,
	name = "Apply lerp_value to all tweak templates",
	category = "Weapon Traits",
	number_button = true,
	on_activated = function (value)
		local local_player = Managers.player:local_player(1)

		if not local_player then
			return
		end

		local player_unit = local_player.player_unit

		if not ALIVE[player_unit] then
			return
		end

		local weapon_extension = ScriptUnit.extension(player_unit, "weapon_system")

		weapon_extension:debug_apply_tweak_template_lerp_value(value)
	end
}
functions.verify_trait_templates = {
	name = "Verify Trait Templates",
	category = "Weapon Traits",
	on_activated = function ()
		local trait_template_verification = require("scripts/settings/equipment/tests/trait_template_verification")
		local success = trait_template_verification()
	end
}
functions.reset_weapon_mastery_override_xp = {
	name = "Reset Weapon Mastery XP Overrides",
	category = "Weapon Mastery",
	on_activated = function ()
		local save_manager = Managers.save
		local save_data = Managers.save:account_data()

		table.clear(save_data.debug.weapon_mastery_xp)
		save_manager:queue_save()
	end
}

local function character_state_options()
	local options = {
		"hogtied",
		"knocked_down",
		"dead"
	}

	return options
end

local function force_character_state(new_value)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		Log.info("DebugFunctions", "Can't set character state as client")
	end

	local selected_unit = Debug.selected_unit

	if not ALIVE[selected_unit] then
		return
	end

	local unit_data_extension = ScriptUnit.has_extension(selected_unit, "unit_data_system")

	if not unit_data_extension then
		return
	end

	local breed_or_nil = unit_data_extension:breed()

	if not Breed.is_player(breed_or_nil) then
		return
	end

	if new_value == "hogtied" then
		local hogtied_state_input = unit_data_extension:write_component("hogtied_state_input")
		hogtied_state_input.hogtie = true
	elseif new_value == "knocked_down" then
		local knocked_down_state_input = unit_data_extension:write_component("knocked_down_state_input")
		knocked_down_state_input.knock_down = true
	elseif new_value == "dead" then
		local dead_state_input = unit_data_extension:write_component("dead_state_input")
		dead_state_input.die = true
	end
end

functions.force_character_state = {
	name = "Force character state",
	category = "Player Character",
	button_text = "Activate",
	options_function = character_state_options,
	on_activated = force_character_state
}
functions.reset_premium_store_custom_time = {
	name = "Reset Store Time",
	button_text = "Reset",
	category = "Micro Transaction (\"Premium\") Store",
	on_activated = function (new_value, old_value)
		ParameterResolver.set_dev_parameter("premium_store_custom_time", 0)
	end
}
functions.premium_store_custom_time = {
	name = "Show Store Using Custom Time (in milliseconds)",
	category = "Micro Transaction (\"Premium\") Store",
	button_text = "Set Time",
	number_button = true,
	on_activated = function (new_value, old_value)
		ParameterResolver.set_dev_parameter("premium_store_custom_time", new_value)
	end
}
functions.collect_cosmetics = {
	name = "Collect playtest cosmetics",
	button_text = "Activate",
	category = "Micro Transaction (\"Premium\") Store",
	on_activated = function ()
		Managers.data_service.store:debug_empty_store("get_playtest_cosmetic_store")
	end
}

for key, config in pairs(functions) do
	local category = config.category

	if category then
		-- Nothing
	end
end

local debug_functions_initialized = false

local function initialize()
	local item_definitions = MasterItems.get_cached()

	_init_weapons(item_definitions)
	_init_equipment(item_definitions)
	_init_spawn_bot_character(item_definitions)
	_fetch_mission_board()
	_init_scripted_scenarios(ScriptedScenarios)

	debug_functions_initialized = true
	player_manager = Managers.player
	ui_manager = Managers.ui
end

local function move_free_flight_camera_to_companion()
	local local_player = Managers.player:local_player(1)

	if not local_player then
		Log.error("move_free_flight_camera_to_companion", "No local player!")

		return
	end

	local companion_spawner_extension = ScriptUnit.extension(local_player.player_unit, "companion_spawner_system")
	local companion_unit = companion_spawner_extension:companion_unit()
	local pos = Unit.world_position(companion_unit, 1)

	Managers.free_flight:teleport_camera("global", pos)
end

functions.move_free_flight_camera_to_companion = {
	name = "Move free flight camera to companion",
	category = "Companion",
	on_activated = move_free_flight_camera_to_companion
}

local function force_companion_OOB()
	local local_player = Managers.player:local_player(1)

	if not local_player then
		Log.error("force_companion_OOB", "No local player!")

		return
	end

	local companion_spawner_extension = ScriptUnit.extension(local_player.player_unit, "companion_spawner_system")
	local companion_unit = companion_spawner_extension:companion_unit()

	if not companion_unit then
		Log.error("force_companion_OOB", "No companion!")

		return
	end

	local companion_blackboard = BLACKBOARDS[companion_unit]
	local behavior_component = Blackboard.write_component(companion_blackboard, "behavior")
	behavior_component.is_out_of_bound = true
end

functions.force_companion_OOB = {
	name = "Force companion OOB",
	category = "Companion",
	on_activated = force_companion_OOB
}

local function add_account_to_block_users_states()
	if IS_PLAYSTATION then
		Managers.account:request_block_user_states("4030197760692964687")
	else
		Log.error("Debug function add_account_to_block_users_states", string.format("You cannot use this function if you are not on Playstation! "))
	end
end

functions.add_account_to_block_users_states = {
	name = "Request random block user states",
	category = "Social Features",
	on_activated = add_account_to_block_users_states
}

return {
	parameters = functions,
	categories = categories,
	is_ready = function ()
		return MasterItems.has_data()
	end,
	is_initialized = function ()
		return debug_functions_initialized
	end,
	initialize = initialize
}
