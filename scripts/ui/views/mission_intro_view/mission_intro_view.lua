local Definitions = require("scripts/ui/views/mission_intro_view/mission_intro_view_definitions")
local Breeds = require("scripts/settings/breed/breeds")
local MissionIntroViewSettings = require("scripts/ui/views/mission_intro_view/mission_intro_view_settings")
local Missions = require("scripts/settings/mission/mission_templates")
local ScriptWorld = require("scripts/foundation/utilities/script_world")
local UIProfileSpawner = require("scripts/managers/ui/ui_profile_spawner")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIWorldSpawner = require("scripts/managers/ui/ui_world_spawner")
local ViewElementVideo = require("scripts/ui/view_elements/view_element_video/view_element_video")
local Vo = require("scripts/utilities/vo")
local MissionIntroView = class("MissionIntroView", "BaseView")

local function _generate_seed(mission_id)
	if not mission_id then
		return 0
	end

	local seed = 1

	for i = 1, 5 do
		local num = string.byte(mission_id, i) or 1
		seed = seed * num
	end

	return seed
end

function MissionIntroView:init(settings, context)
	self._spawn_point_units = {}
	self._context = context
	self._debug_preview = context and context.debug_preview
	self._viewport = nil
	self._camera = nil
	self._profile_loaders = {}
	self._spawn_slots = {}
	self._prioritized_ogryn_slots = table.clone(MissionIntroViewSettings.prioritized_ogryn_slots)
	local backend_mission_id = Managers.mechanism:backend_mission_id()
	self._seed = _generate_seed(backend_mission_id)
	local intro_level, dynamic_level_package = self.select_target_intro_level()
	self._intro_level = intro_level

	MissionIntroView.super.init(self, Definitions, settings, context, dynamic_level_package)

	self._pass_draw = false
	self._can_exit = not context or context.can_exit

	Managers.event:trigger("event_mission_intro_started")
end

function MissionIntroView:on_enter()
	MissionIntroView.super.on_enter(self)
	Managers.event:trigger("event_start_waiting")

	self._animation_events_used = {}
	self._num_animation_events_used = 0
end

USE_DEBUG_RENDERER = false

function MissionIntroView:draw(dt, t, input_service, layer)
	Managers.ui:render_loading_info()
end

function MissionIntroView:event_register_mission_intro_spawn_point_1(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_1")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 1)
end

function MissionIntroView:event_register_mission_intro_spawn_point_2(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_2")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 2)
end

function MissionIntroView:event_register_mission_intro_spawn_point_3(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_3")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 3)
end

function MissionIntroView:event_register_mission_intro_spawn_point_4(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_4")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 4)
end

function MissionIntroView:event_register_mission_intro_spawn_point_5(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_5")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 5)
end

function MissionIntroView:event_register_mission_intro_spawn_point_6(spawn_point_unit)
	self:_unregister_event("event_register_mission_intro_spawn_point_6")
	self:_register_mission_intro_spawn_point(spawn_point_unit, 6)
end

function MissionIntroView:_register_mission_intro_spawn_point(spawn_point_unit, index)
	self._spawn_point_units[index] = spawn_point_unit
end

function MissionIntroView:event_register_mission_intro_camera(camera_unit)
	self:_unregister_event("event_register_mission_intro_camera")

	local intro_level = self._intro_level
	local viewport_name = MissionIntroViewSettings.viewport_name
	local viewport_type = MissionIntroViewSettings.viewport_type
	local viewport_layer = MissionIntroViewSettings.viewport_layer
	local shading_environment = intro_level.shading_environment

	self._world_spawner:create_viewport(camera_unit, viewport_name, viewport_type, viewport_layer, shading_environment)
end

function MissionIntroView.select_target_intro_level(mission_name)
	if not mission_name then
		local mechanism_data = Managers.mechanism:mechanism_data()
		mission_name = mechanism_data and mechanism_data.mission_name
	end

	local mission_zone_id = mission_name and Missions[mission_name].zone_id or "default"
	local intro_level = MissionIntroViewSettings.intro_levels_by_zone_id[mission_zone_id] or MissionIntroViewSettings.intro_levels_by_zone_id.default
	local intro_level_packages = {
		is_level_package = true,
		name = intro_level.level_name
	}

	return intro_level, intro_level_packages
end

function MissionIntroView:_initialize_background_world()
	self:_register_event("event_register_mission_intro_camera")
	self:_register_event("event_register_mission_intro_spawn_point_1")
	self:_register_event("event_register_mission_intro_spawn_point_2")
	self:_register_event("event_register_mission_intro_spawn_point_3")
	self:_register_event("event_register_mission_intro_spawn_point_4")
	self:_register_event("event_register_mission_intro_spawn_point_5")
	self:_register_event("event_register_mission_intro_spawn_point_6")

	local world_name = MissionIntroViewSettings.world_name
	local world_layer = MissionIntroViewSettings.world_layer
	local world_timer_name = MissionIntroViewSettings.timer_name
	local optional_flags = MissionIntroViewSettings.world_custom_flags
	self._world_spawner = UIWorldSpawner:new(world_name, world_layer, world_timer_name, self.view_name, optional_flags)
	local game_state_context = Managers.player:game_state_context()
	local mission_name = game_state_context and game_state_context.mission_name
	local mission_giver_vo = game_state_context and game_state_context.mission_giver_vo
	local circumstance_name = game_state_context and game_state_context.circumstance_name
	local target_intro_level = self._intro_level
	local level_name = target_intro_level.level_name

	self._world_spawner:spawn_level(level_name)

	self._world_initialized = true

	if mission_name then
		self:_play_mission_brief_vo(mission_name, mission_giver_vo, circumstance_name)
		self:_set_hologram_briefing_material(mission_name)
	else
		self.mission_briefing_done = true
	end

	self:_register_event("event_mission_intro_trigger_players_event")
end

function MissionIntroView:_get_unit_by_value_key(key, value)
	local world_spawner = self._world_spawner
	local level = world_spawner:level()
	local level_units = Level.units(level)

	for i = 1, #level_units do
		local unit = level_units[i]

		if Unit.get_data(unit, key) == value then
			return unit
		end
	end
end

function MissionIntroView:can_exit()
	return self._can_exit
end

function MissionIntroView:on_exit()
	MissionIntroView.super.on_exit(self)
	Managers.event:trigger("event_stop_waiting")

	local spawn_slots = self._spawn_slots
	local num_slots = #spawn_slots

	for i = 1, num_slots do
		local slot = spawn_slots[i]

		if slot.occupied then
			self:_reset_spawn_slot(slot)
		end
	end

	if self._world_spawner then
		self._world_spawner:destroy()

		self._world_spawner = nil
	end

	Managers.event:trigger("event_mission_intro_finished")
end

function MissionIntroView:update(dt, t, input_service)
	if self._world_initialized then
		local world_spawner = self._world_spawner

		if world_spawner then
			world_spawner:update(dt, t)
		end

		self:_update_player_slots(dt, t)
	else
		self:_initialize_background_world()
		self:_setup_spawn_slots()
		self:_assign_player_slots()
	end

	if self._current_vo_id then
		local id = self._current_vo_id
		local unit = self._vo_unit
		local dialogue_extension = ScriptUnit.extension(unit, "dialogue_system")
		local is_playing = dialogue_extension:is_playing(id)
		local is_finished_playing = not is_playing
		local current_vo_event = self._current_vo_event
		local last_vo_event = self._last_vo_event
		local is_last_vo_event = current_vo_event == last_vo_event

		if is_last_vo_event and is_finished_playing then
			self.mission_briefing_done = true
			self._current_vo_id = nil
			self._current_vo_event = nil
		end
	end

	return MissionIntroView.super.update(self, dt, t, input_service)
end

function MissionIntroView:_get_free_slot_id(player)
	local spawn_slots = self._spawn_slots
	local profile = player:profile()
	local archetype_settings = profile.archetype
	local breed_name = archetype_settings.breed
	local is_ogryn = breed_name == "ogryn"
	local prioritized_ogryn_slots = self._prioritized_ogryn_slots
	local back_slots_decided = #prioritized_ogryn_slots == 2

	if is_ogryn and back_slots_decided then
		for i = 1, #prioritized_ogryn_slots do
			local slot_index = prioritized_ogryn_slots[i]
			local slot = spawn_slots[slot_index]

			if not slot.occupied then
				return slot_index
			end
		end
	else
		for i = 1, #spawn_slots do
			local slot = spawn_slots[i]

			if not slot.occupied then
				if not back_slots_decided then
					if is_ogryn then
						table.remove(prioritized_ogryn_slots, i)
					else
						table.remove(prioritized_ogryn_slots, i + 1)
					end
				end

				return i
			end
		end
	end

	for i = 1, #spawn_slots do
		local slot = spawn_slots[i]

		if not slot.occupied then
			return i
		end
	end
end

function MissionIntroView:_player_slot_id(unique_id)
	local spawn_slots = self._spawn_slots

	for i = 1, #spawn_slots do
		local slot = spawn_slots[i]

		if slot.occupied and slot.unique_id == unique_id then
			return i
		end
	end
end

function MissionIntroView:_setup_spawn_slots()
	local spawn_point_units = self._spawn_point_units
	local world = self._world_spawner:world()
	local camera = self._world_spawner:camera()
	local unit_spawner = self._world_spawner:unit_spawner()
	local ignored_slots = MissionIntroViewSettings.ignored_slots
	local spawn_slots = {}
	local num_slots = 6

	for i = 1, num_slots do
		local spawn_point_unit = spawn_point_units[i]
		local initial_position = Unit.world_position(spawn_point_unit, 1)
		local initial_rotation = Unit.world_rotation(spawn_point_unit, 1)
		local profile_spawner = UIProfileSpawner:new("MissionIntroView_" .. i, world, camera, unit_spawner)

		for j = 1, #ignored_slots do
			local slot_name = ignored_slots[j]

			profile_spawner:ignore_slot(slot_name)
		end

		local spawn_slot = {
			index = i,
			boxed_rotation = QuaternionBox(initial_rotation),
			boxed_position = Vector3.to_array(initial_position),
			profile_spawner = profile_spawner,
			spawn_point_unit = spawn_point_unit
		}
		spawn_slots[i] = spawn_slot
	end

	self._spawn_slots = spawn_slots
end

function MissionIntroView:event_mission_intro_trigger_players_event(animation_event)
	local spawn_slots = self._spawn_slots

	for i = 1, #spawn_slots do
		local slot = spawn_slots[i]

		if slot.occupied then
			local profile_spawner = slot.profile_spawner

			profile_spawner:assign_animation_event(animation_event)
		end
	end
end

function MissionIntroView:_update_player_slots(dt, t, input_service)
	local spawn_slots = self._spawn_slots

	for i = 1, #spawn_slots do
		local slot = spawn_slots[i]

		if slot.occupied then
			local profile_spawner = slot.profile_spawner

			profile_spawner:update(dt, t, input_service)
		end
	end
end

local temp_sorted_players = {}

function MissionIntroView:_assign_player_slots()
	local player_manager = Managers.player
	local players = player_manager:players()

	local function bot_sort_function(a, b)
		local a_slot_index = a:slot() + (a:is_human_controlled() and 0 or 100)
		local b_slot_index = b:slot() + (b:is_human_controlled() and 0 or 100)

		return a_slot_index < b_slot_index
	end

	local function ogryn_sort_function(a, b)
		local a_slot_index = a:slot() + (a:breed_name() == "human" and 0 or 100)
		local b_slot_index = b:slot() + (b:breed_name() == "human" and 0 or 100)

		return a_slot_index < b_slot_index
	end

	table.clear(temp_sorted_players)

	for unique_id, player in pairs(players) do
		temp_sorted_players[#temp_sorted_players + 1] = player
	end

	if #temp_sorted_players > 1 then
		table.sort(temp_sorted_players, bot_sort_function)
		table.sort(temp_sorted_players, ogryn_sort_function)
	end

	local spawn_slots = self._spawn_slots

	for i = 1, #temp_sorted_players do
		local player = temp_sorted_players[i]
		local unique_id = player:unique_id()
		local slot_id = self:_player_slot_id(unique_id)

		if not slot_id then
			slot_id = self:_get_free_slot_id(player)
			local slot = spawn_slots[slot_id]

			if slot then
				self:_assign_player_to_slot(player, slot)
			end
		end
	end
end

function MissionIntroView:_assign_player_to_slot(player, slot)
	local unique_id = player:unique_id()
	local profile = player:profile()
	local boxed_position = slot.boxed_position
	local boxed_rotation = slot.boxed_rotation
	local spawn_position = Vector3.from_array(boxed_position)
	local spawn_rotation = QuaternionBox.unbox(boxed_rotation)
	local profile_spawner = slot.profile_spawner
	local archetype_settings = profile.archetype
	local archetype_name = archetype_settings.name
	local breed_name = archetype_settings.breed
	local breed_settings = Breeds[breed_name]
	local mission_intro_state_machine = breed_settings.mission_intro_state_machine
	local animations_per_archetype = MissionIntroViewSettings.animations_per_archetype
	local animations_settings = animations_per_archetype[archetype_name]
	local animation_event = nil
	local num_animations = #animations_settings

	while not animation_event do
		local new_seed, random_index = math.next_random(self._seed, 1, num_animations)
		local wanted_event = animations_settings[random_index]

		if not self._animation_events_used[wanted_event] or num_animations <= self._num_animation_events_used then
			animation_event = wanted_event
			self._animation_events_used[animation_event] = true
			self._num_animation_events_used = self._num_animation_events_used + 1
		end

		self._seed = new_seed
	end

	profile_spawner:spawn_profile(profile, spawn_position, spawn_rotation, nil, mission_intro_state_machine, animation_event)

	slot.occupied = true
	slot.player = player
	slot.unique_id = unique_id
end

function MissionIntroView:_reset_spawn_slot(slot)
	local profile_spawner = slot.profile_spawner

	if profile_spawner then
		profile_spawner:destroy()
	end

	slot.unique_id = nil
	slot.profile_spawner = nil
	slot.player = nil
end

function MissionIntroView:_play_mission_brief_vo(mission_name, mission_giver_vo, circumstance_name)
	local mission = Missions[mission_name]
	local mission_intro_time = mission.mission_intro_minimum_time or 0
	self.done_at = Managers.time:time("main") + mission_intro_time
	local mission_brief_vo = mission.mission_brief_vo

	if not mission_brief_vo or not mission_brief_vo.vo_events then
		self.mission_briefing_done = true

		return
	end

	local events = mission_brief_vo.vo_events
	local voice_profile = nil

	if mission_giver_vo == "none" then
		voice_profile = mission_brief_vo.vo_profile
	else
		voice_profile = mission_giver_vo
	end

	local wwise_route_key = mission_brief_vo.wwise_route_key
	local dialogue_system = self:dialogue_system()
	local callback = callback(self, "_cb_on_play_mission_brief_vo")
	local seed = nil

	if Managers.connection then
		seed = Managers.connection:session_seed()
	end

	local specific_lines = MissionIntroViewSettings.journey_briefing_lines[circumstance_name]
	local vo_unit = Vo.play_local_vo_events(dialogue_system, events, voice_profile, wwise_route_key, callback, seed, nil, specific_lines)
	self._vo_unit = vo_unit
	self._last_vo_event = events[#events]
end

function MissionIntroView:_set_hologram_briefing_material(mission_name)
	local mission = Missions[mission_name]
	local material = mission.mission_brief_material

	if material then
		local unit = World.unit_by_name(self._world_spawner._world, "valkyrie_hologram_prototype_01")

		Unit.set_material(unit, "hologram_briefing_placeholder", material)
	end
end

function MissionIntroView:_cb_on_play_mission_brief_vo(id, event_name)
	self._current_vo_event = event_name
	self._current_vo_id = id
end

function MissionIntroView:dialogue_system()
	local world_spawner = self._world_spawner

	if not world_spawner then
		return nil
	end

	local world = world_spawner:world()
	local extension_manager = Managers.ui:world_extension_manager(world)

	return extension_manager:system_by_extension("DialogueExtension")
end

return MissionIntroView
