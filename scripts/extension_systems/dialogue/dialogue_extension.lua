local Breed = require("scripts/utilities/breed")
local DialogueBreedSettings = require("scripts/settings/dialogue/dialogue_breed_settings")
local DialogueQueries = require("scripts/extension_systems/dialogue/dialogue_queries")
local DialogueSettings = require("scripts/settings/dialogue/dialogue_settings")
local PlayerVoiceGrunts = require("scripts/utilities/player_voice_grunts")
local Vo = require("scripts/utilities/vo")
local VoiceFxPresetSettings = require("scripts/settings/dialogue/voice_fx_preset_settings")
local WwiseRouting = require("scripts/settings/dialogue/wwise_vo_routing_settings")
local DialogueExtension = class("DialogueExtension")

local function _has_wwise_voice_switch_config(breed_configuration)
	local wwise_voice_switch_group = breed_configuration.wwise_voice_switch_group
	local wwise_voices = breed_configuration.wwise_voices

	return wwise_voice_switch_group ~= nil and wwise_voice_switch_group ~= "" and wwise_voices ~= nil and #wwise_voices > 0
end

function DialogueExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id)
	self.input = self
	local vo_sources_cache = extension_init_context.vo_sources_cache
	self._dialogue_system = extension_init_context.owner_system
	self._dialogue_system_wwise = extension_init_context.dialogue_system_wwise
	self._unit = unit
	self._vo_sources_cache = vo_sources_cache
	self._wwise_world = extension_init_context.wwise_world
	self._is_server = extension_init_context.is_server
	self._trigger_event_data_payload = {}
	self._vo_choice = nil
	self._vo_profile_name = nil
	self._voice_fx_preset = nil
	self._profile = nil
	self._voice_node = nil
	self._is_network_synced = false
	self._play_unit = nil
	self._vo_center_percent = nil
	self._wwise_source_id = nil
	self._wwise_voice_switch_group = nil
	self._wwise_voice_switch_value = nil
	self._faction = nil
	self._faction_memory = nil
	self._faction_breed_name = nil
	self._user_memory = {}
	self._vo_event_cooldown_times = {}
	self._local_player = extension_init_data.local_player
	self._last_query_sound_event = nil
	self._is_currently_playing_dialogue = false
	self._dialogue = {}
	self._random_talk_enabled = false
	self._next_random_talk_line_update_t = 180
	self._random_talk_tick_time_t = 60
	self._random_talk_trigger_id = nil
	self._mission_update_enabled = false
	self._next_mission_fetch_t = 0
	self._next_mission_play_vo_t = 0
	self._missions = {}
	self._missions_data = {}
	self._dynamic_smart_tag = nil
	self._is_a_player = false
	self._use_local_player_vo_profile = false
	self._stop_vce_event = nil
	self._context = {
		is_catapulted = "false",
		is_ledge_hanging = "false",
		is_hogtied = "false",
		is_disabled = false,
		is_netted = "false",
		player_level = 0,
		weapon_type = "none",
		story_stage = "none",
		is_warp_grabbed = "false",
		is_pounced_down = "false",
		is_local_player = false,
		is_knocked_down = "false",
		voice_fx_preset = 0,
		is_disabled_override = false,
		class_name = "none",
		is_consumed = "false",
		is_grabbed = "false",
		is_mutant_charged = "false",
		voice_template = "none",
		is_player = false,
		breed_name = "unknown_breed_name",
		health = 1
	}

	if self._local_player then
		self._context.is_local_player = true
	end

	local breed = extension_init_data.breed

	if breed then
		local breed_name = breed.name
		local dialogue_breed_settings = DialogueBreedSettings[breed_name]
		self._faction_breed_name = breed.faction_name

		if _has_wwise_voice_switch_config(dialogue_breed_settings) then
			local extension_per_breed_wwise_voice_index = extension_init_context.extension_per_breed_wwise_voice_index

			if extension_per_breed_wwise_voice_index[breed_name] == nil then
				extension_per_breed_wwise_voice_index[breed_name] = 1
			end

			local selected_voice_index = nil

			if dialogue_breed_settings.randomize_voice then
				local voice_selection_seed = extension_init_data.seed
				voice_selection_seed, selected_voice_index = math.next_random(voice_selection_seed, 1, #dialogue_breed_settings.wwise_voices)
			else
				selected_voice_index = extension_per_breed_wwise_voice_index[breed_name]
				extension_per_breed_wwise_voice_index[breed_name] = selected_voice_index % #dialogue_breed_settings.wwise_voices + 1
			end

			self._wwise_voice_switch_value = dialogue_breed_settings.wwise_voices[selected_voice_index]
			self._wwise_voice_switch_group = dialogue_breed_settings.wwise_voice_switch_group
		end

		self._is_network_synced = dialogue_breed_settings.is_network_synced
		self._faction = dialogue_breed_settings.dialogue_memory_faction_name

		if self._faction == nil then
			Log.Warning("DialogueExtension", "Unit %s doesn't define a dialogue_memory_faction_name, please contact the Audio Team", unit)
		end

		if Breed.is_player(breed) then
			self._is_a_player = true
			self._context.is_player = "true"
			local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
			local first_person_unit = first_person_extension:first_person_unit()
			local fx_extension = ScriptUnit.extension(unit, "fx_system")
			self._fx_extension = fx_extension

			PlayerVoiceGrunts.create_voice(fx_extension, first_person_unit, "ap_camera_node")
		end

		self._context.breed_name = breed_name
		self._stop_vce_event = dialogue_breed_settings.stop_vce_event
		local vo_events = dialogue_breed_settings.vo_events

		if vo_events then
			local event_manager = Managers.event

			for event_name, vo_event in pairs(vo_events) do
				event_manager:register_with_parameters(self, "_cb_vo_event_triggered", event_name, event_name)
			end

			self._registered_vo_events = vo_events
		end

		local random_talk_settings = dialogue_breed_settings.random_talk_settings

		if random_talk_settings then
			self:_setup_random_talk_settings(random_talk_settings, dialogue_breed_settings.vo_class_name)
		end
	end

	local selected_voice = extension_init_data.selected_voice

	if selected_voice then
		self._is_a_player = true
		self._context.is_player = "true"
		local player_unit_spawn_manager = Managers.state.player_unit_spawn
		local player = player_unit_spawn_manager:owner(unit)

		if player then
			local profile = player:profile()

			if profile then
				self._context.player_level = profile.current_level
				self._profile = profile

				if not player:is_human_controlled() then
					self._context.player_level = self._dialogue_system.global_context.team_lowest_player_level
				end
			end
		end

		self:set_vo_profile(selected_voice)

		self._context.voice_template = self._vo_profile_name
		self._context.class_name = self:vo_class_name()

		return
	end

	if self._wwise_voice_switch_value then
		self:set_vo_profile(self._wwise_voice_switch_value)

		self._context.voice_template = self._vo_profile_name
		self._context.class_name = self:vo_class_name()

		return
	end

	local profile_name, voice_content = vo_sources_cache:get_default_voice_profile()
	self._vo_profile_name = profile_name
	self._vo_choice = voice_content
	self._context.voice_template = self._vo_profile_name
end

function DialogueExtension:_cb_vo_event_triggered(event_name, ...)
	local registered_vo_events = self._registered_vo_events
	local vo_func_name = registered_vo_events[event_name]
	local vo_function = Vo[vo_func_name]
	local unit = self._unit

	vo_function(unit, self, ...)
end

function DialogueExtension:_setup_random_talk_settings(random_talk_settings, vo_class)
	self._random_talk_enabled = random_talk_settings.enabled
	self._next_random_talk_line_update_t = random_talk_settings.random_talk_start_delay_t
	self._random_talk_tick_time_t = random_talk_settings.random_talk_tick_time_t
	self._random_talk_trigger_id = random_talk_settings.trigger_id
	self._mission_update_enabled = random_talk_settings.mission_update_enabled
end

function DialogueExtension:setup_from_component(vo_class, vo_profile_name, use_local_player_voice_profile, dialogue_faction_name, enabled)
	self._enabled = enabled

	if not enabled then
		return
	end

	local dialogue_breed_settings = DialogueBreedSettings[vo_class]

	if dialogue_breed_settings and dialogue_breed_settings.random_talk_settings then
		self:_setup_random_talk_settings(dialogue_breed_settings.random_talk_settings, dialogue_breed_settings.vo_class_name)
	end

	self:init_faction_memory(dialogue_faction_name)

	self._use_local_player_vo_profile = use_local_player_voice_profile

	if use_local_player_voice_profile and not DEDICATED_SERVER then
		local local_player = Managers.player:local_player(1)
		local profile = local_player:profile()

		self:set_vo_profile(profile.selected_voice)
		self:_set_vo_class(profile.archetype.name)

		return
	end

	if not self._profile then
		self:set_vo_profile(vo_profile_name)
		self:_set_vo_class(vo_class)
	end
end

function DialogueExtension:destroy()
	if self._is_currently_playing_dialogue then
		self:stop_currently_playing_vo()
	end

	local fx_extension = self._fx_extension

	if fx_extension then
		PlayerVoiceGrunts.destroy_voice(fx_extension)
	end

	local registered_vo_events = self._registered_vo_events

	if registered_vo_events then
		local event_manager = Managers.event

		for event_name, _ in pairs(registered_vo_events) do
			event_manager:unregister(self, event_name)
		end
	end
end

function DialogueExtension:extensions_ready(world, unit)
	local play_unit = unit
	local vo_center_percent = 0
	local voice_node = nil

	if self._local_player then
		play_unit = ScriptUnit.extension(unit, "first_person_system"):first_person_unit()
		vo_center_percent = 100
		voice_node = Unit.node(play_unit, "ap_camera_node")
	elseif Unit.has_node(play_unit, "ap_voice") then
		voice_node = Unit.node(play_unit, "ap_voice")
	elseif Unit.has_node(play_unit, "j_head") then
		voice_node = Unit.node(play_unit, "j_head")
	else
		voice_node = 1
	end

	self._play_unit = play_unit
	self._voice_node = voice_node
	self._vo_center_percent = vo_center_percent

	if self._wwise_source_id == nil then
		self._wwise_source_id = WwiseWorld.make_manual_source(self._wwise_world, play_unit, voice_node)
	end
end

function DialogueExtension:physics_async_update(context, dt, t)
	if self._is_server then
		self:_update_random_talk_lines(t)
	end

	self:_update_vo_event_cool_down_times(t)
end

function DialogueExtension:_update_random_talk_lines(t)
	if not self._random_talk_enabled then
		return
	end

	if self._mission_update_enabled == true then
		self:_update_mission_update_vo()
	end

	local next_random_talk_line_update_t = self._next_random_talk_line_update_t

	if next_random_talk_line_update_t < t then
		self._next_random_talk_line_update_t = t + self._random_talk_tick_time_t + math.random(-20, 20)
		local event_name = "generic_vo_event"

		table.clear(self._trigger_event_data_payload)

		local event_data = self:get_event_data_payload()
		event_data.trigger_id = self._random_talk_trigger_id

		self:trigger_dialogue_event(event_name, event_data)
	end
end

function DialogueExtension:_update_mission_update_vo()
	local t = Managers.time:time("main")

	if self._next_mission_fetch_t <= t then
		local missions_data, missions = self._dialogue_system:mission_board()

		if not missions_data or not missions_data.expiry_game_time then
			return
		end

		self._missions_data = missions_data
		self._missions = missions
		self._next_mission_fetch_t = missions_data.expiry_game_time + math.random()
		self._missions_board_promise = nil
		self._next_mission_play_vo_t = 0
	end

	if self._next_mission_play_vo_t <= t then
		local missions = self._missions

		for i = 1, #missions do
			local mission_data = missions[i]
			local start_time = mission_data.start_game_time
			local active_time = t - start_time

			if active_time <= 1 then
				if active_time >= -1 then
					local mission_name = mission_data.map
					local circumstance = mission_data.circumstance or "default"
					local event_name = "mission_update_vo"
					local is_circumstance = nil

					if circumstance == "default" then
						is_circumstance = "false"
					else
						is_circumstance = "true"
					end

					table.clear(self._trigger_event_data_payload)

					local event_data = self:get_event_data_payload()
					event_data.mission = mission_name
					event_data.is_circumstance = is_circumstance
					event_data.trigger_id = "mission_update"

					self:trigger_dialogue_event(event_name, event_data)
				else
					self._next_mission_play_vo_t = start_time

					break
				end
			end
		end

		if self._next_mission_play_vo_t <= 0 then
			self._next_mission_play_vo_t = self._next_mission_fetch_t
		end
	end
end

function DialogueExtension:_update_vo_event_cool_down_times(t)
	local vo_event_cooldown_times = self._vo_event_cooldown_times

	for vo_event_name, vo_profiles in pairs(vo_event_cooldown_times) do
		for vo_profile, cooldown_time in pairs(vo_profiles) do
			if cooldown_time <= t then
				vo_event_cooldown_times[vo_event_name][vo_profile] = nil

				if table.is_empty(vo_event_cooldown_times[vo_event_name]) then
					vo_event_cooldown_times[vo_event_name] = nil
				end
			end
		end
	end
end

function DialogueExtension:trigger_faction_dialogue_query(event_name, event_data, identifier, breed_faction_name, exclude_me)
	if not self._is_server then
		Log.error("DialogueExtension", "trigger_faction_dialogue_query must be executed in the server")

		return
	end

	self._dialogue_system:append_faction_event(self._unit, event_name, event_data, identifier, breed_faction_name, exclude_me)
end

function DialogueExtension:trigger_factions_dialogue_query(event_name, event_data, identifier, breed_factions, exclude_me)
	if not self._is_server then
		Log.error("DialogueExtension", "trigger_faction_dialogue_query must be executed in the server")

		return
	end

	local unit = self._unit
	local dialogue_system = self._dialogue_system

	for _, faction in pairs(breed_factions) do
		dialogue_system:append_faction_event(unit, event_name, event_data, identifier, faction, exclude_me)
	end
end

function DialogueExtension:trigger_dialogue_event(event_name, event_data, identifier)
	self:trigger_networked_dialogue_event(event_name, event_data, identifier)
end

function DialogueExtension:manage_targeted_cooldowns(event_data)
	local cooldown_times = self._vo_event_cooldown_times
	local vo_event_name = event_data.vo_event
	local existing_cooldown_event = cooldown_times[vo_event_name]
	local profile_name = event_data.npc_profile_name

	if existing_cooldown_event then
		local existing_cooldown_time_t = existing_cooldown_event[profile_name]

		if existing_cooldown_time_t then
			return false
		end
	else
		cooldown_times[vo_event_name] = {}
	end

	local game_time = Managers.time:time("gameplay")
	local vo_event_cooldown_t = event_data.cooldown_time

	if vo_event_name and vo_event_cooldown_t then
		cooldown_times[vo_event_name][profile_name] = game_time + vo_event_cooldown_t
	end

	return true
end

function DialogueExtension:trigger_targeted_dialogue_event(event_name, event_data, target_unit, identifier)
	event_data.target_unit = target_unit

	self:trigger_networked_dialogue_event(event_name, event_data, identifier)
end

function DialogueExtension:trigger_networked_dialogue_event(event_name, event_data, identifier)
	if LEVEL_EDITOR_TEST then
		return
	end

	if self._is_server then
		self._dialogue_system:append_event_to_queue(self._unit, event_name, event_data, identifier)
	else
		local index_concept = self._dialogue_system.dialogueLookupConcepts[event_name]
		local array_event_data = {}
		local array_event_data_is_number = {}
		local current_pair = 1

		for key, value in pairs(event_data) do
			local context_name_id = self._dialogue_system.dialogueLookupContexts.all_context_names[key]
			array_event_data[current_pair] = context_name_id
			array_event_data_is_number[current_pair] = false
			current_pair = current_pair + 1

			if type(value) == "number" then
				array_event_data[current_pair] = value
				array_event_data_is_number[current_pair] = true
			else
				if self._dialogue_system.dialogueLookupContexts[key] == nil then
					return
				end

				local value_id = self._dialogue_system.dialogueLookupContexts[key][value]
				array_event_data[current_pair] = value_id
				array_event_data_is_number[current_pair] = false
			end

			current_pair = current_pair + 1
		end

		local _, go_id = Managers.state.unit_spawner:game_object_id_or_level_index(self._unit)

		Managers.state.game_session:send_rpc_server("rpc_trigger_dialogue_event", go_id, index_concept, array_event_data, array_event_data_is_number)
	end
end

function DialogueExtension:trigger_voice(wwise_event_name, sound_source)
	self._dialogue_system_wwise:set_switch(sound_source, self._wwise_voice_switch_group, self._vo_profile_name)
	self:_set_source_parameter("voice_fx_preset", self._voice_fx_preset, sound_source)

	return self._dialogue_system_wwise:trigger_resource_event(wwise_event_name, sound_source)
end

function DialogueExtension:set_vo_profile(profile_name)
	local vo_sources_cache = self._vo_sources_cache
	self._wwise_voice_switch_group = self._wwise_voice_switch_group or DialogueSettings.default_voice_switch_group
	self._wwise_voice_switch_value = profile_name
	self._vo_profile_name = profile_name
	self._context.voice_template = self._vo_profile_name
	self._vo_choice = vo_sources_cache:get_vo_source(self._vo_profile_name)
	local fx_extension = self._fx_extension

	if fx_extension then
		local voice_source_id = PlayerVoiceGrunts.voice_source(fx_extension)

		PlayerVoiceGrunts.set_voice(self._wwise_world, voice_source_id, self._wwise_voice_switch_group, profile_name)
	end
end

function DialogueExtension:_set_vo_class(vo_class_name)
	self._vo_class = vo_class_name
	self._context.class_name = self._vo_class
end

function DialogueExtension:init_faction_memory(faction_memory_name)
	local faction_memory = self._dialogue_system._faction_memories[faction_memory_name]

	if self._dialogue_system._is_rule_db_enabled then
		self._dialogue_system._tagquery_database:add_object_context(self._unit, "faction_memory", faction_memory)
	end

	self._faction_memory = faction_memory
	self._faction_breed_name = faction_memory_name
end

function DialogueExtension:set_voice_profile_data(vo_class_name, wwise_switch_group, voice_profile)
	self._wwise_voice_switch_group = wwise_switch_group

	self:_set_vo_class(vo_class_name)
	self:set_vo_profile(voice_profile)
end

function DialogueExtension:set_voice_data()
	local wwise_world = self._wwise_world

	WwiseWorld.set_switch(wwise_world, self._wwise_voice_switch_group, self._wwise_voice_switch_value, self._wwise_source_id)

	local voice_fx_preset = self._voice_fx_preset

	if voice_fx_preset then
		WwiseWorld.set_source_parameter(wwise_world, self._wwise_source_id, "voice_fx_preset", voice_fx_preset)
	end
end

function DialogueExtension:voice_data()
	return self._wwise_voice_switch_group or "voice_profile", self._vo_profile_name, self._voice_fx_preset
end

function DialogueExtension:get_voice_profile()
	return self._vo_profile_name
end

function DialogueExtension:has_vo_profile()
	return self._vo_choice and self._vo_profile_name
end

function DialogueExtension:set_voice_fx_preset(optional_voice_fx_preset_name)
	local voice_fx_preset = VoiceFxPresetSettings[optional_voice_fx_preset_name] or VoiceFxPresetSettings.voice_fx_rtpc_none
	self._voice_fx_preset = voice_fx_preset
	self._context.voice_fx_preset = voice_fx_preset
end

function DialogueExtension:_set_source_parameter(parameter, value, wwise_source_id)
	WwiseWorld.set_source_parameter(self._wwise_world, wwise_source_id, parameter, value)
end

function DialogueExtension:get_dialogue_event_index(query)
	local vo_choice = self._vo_choice
	local dialogue = vo_choice[query.result]

	if dialogue then
		local dialogue_index = DialogueQueries.get_dialogue_event_index(dialogue)

		return dialogue.sound_events[dialogue_index], dialogue.sound_events_duration[dialogue_index], dialogue_index
	else
		return nil, nil, nil
	end
end

function DialogueExtension:get_dialogue_event(dialogue_name, dialogue_index)
	local vo_choice = self._vo_choice
	local dialogue = vo_choice[dialogue_name]

	if dialogue then
		local event_name = dialogue.sound_events[dialogue_index]

		return event_name, event_name, dialogue.sound_events_duration[dialogue_index]
	else
		return nil, nil, nil
	end
end

function DialogueExtension:has_dialogue(dialogue_name)
	if self._vo_choice[dialogue_name] then
		return true
	else
		return false
	end
end

function DialogueExtension:play_event(event)
	local event_type = event.type

	if event_type == "resource_event" then
		local sound_event = event.sound_event
		local wwise_source_id = self._wwise_source_id or self._dialogue_system_wwise:make_unit_auto_source(self._play_unit, self._voice_node)

		WwiseWorld.set_switch(self._wwise_world, self._wwise_voice_switch_group, self._wwise_voice_switch_value, wwise_source_id)

		return self._dialogue_system_wwise:trigger_resource_event("wwise/events/vo/" .. sound_event, wwise_source_id)
	elseif event_type == "vorbis_external" then
		local wwise_route = event.wwise_route
		local sound_event = event.sound_event
		local wwise_source_id = self._wwise_source_id or self._dialogue_system_wwise:make_unit_auto_source(self._play_unit, self._voice_node)
		local selected_wwise_route = self:get_selected_wwise_route(wwise_route, wwise_source_id)
		local wwise_play_event = selected_wwise_route.wwise_event_path
		local wwise_es = selected_wwise_route.wwise_sound_source
		local stop_vce_event = self._stop_vce_event

		if stop_vce_event and self._wwise_source_id then
			self._dialogue_system_wwise:trigger_resource_event(stop_vce_event, self._wwise_source_id)
		end

		self:_set_source_parameter("voice_fx_preset", self._voice_fx_preset, wwise_source_id)

		return self._dialogue_system_wwise:trigger_vorbis_external_event(wwise_play_event, wwise_es, "wwise/externals/" .. sound_event, wwise_source_id)
	end
end

function DialogueExtension:stop_currently_playing_vo()
	if self._is_currently_playing_dialogue then
		local unit = self._unit
		local dialogue_system = self._dialogue_system
		local animation_event = "stop_talking"

		dialogue_system:_trigger_face_animation_event(unit, animation_event)

		local dialogue = self._dialogue
		local dialogue_system_wwise = self._dialogue_system_wwise
		local currently_playing_event_id = dialogue.currently_playing_event_id
		local concurrent_wwise_event_id = dialogue.concurrent_wwise_event_id

		dialogue_system_wwise:stop_if_playing(concurrent_wwise_event_id)
		dialogue_system_wwise:stop_if_playing(currently_playing_event_id)

		self._is_currently_playing_dialogue = false
		self._last_query_sound_event = nil

		dialogue_system:_remove_stopped_dialogue(unit, dialogue)
	end
end

function DialogueExtension:play_local_vo_events(rule_names, wwise_route_key, on_play_callback, seed, specific_lines)
	local dialogue_system = self._dialogue_system
	local vo_choice = self._vo_choice
	local rule_queue = dialogue_system._vo_rule_queue
	local unit = self._unit

	for i = 1, #rule_names do
		local rule = rule_names[i]

		if vo_choice[rule] then
			local vo_event = {
				unit = unit,
				rule_name = rule,
				wwise_route_key = wwise_route_key,
				on_play_callback = on_play_callback,
				seed = seed,
				specific_line = specific_lines and specific_lines[i]
			}
			rule_queue[#rule_queue + 1] = vo_event
		end
	end

	local animation_event = "start_talking"

	dialogue_system:_trigger_face_animation_event(unit, animation_event)
end

function DialogueExtension:play_local_vo_event(rule_name, wwise_route_key, on_play_callback, seed, optional_keep_talking, pre_wwise_event, post_wwise_event, specific_line)
	local rule = self._vo_choice[rule_name]

	if not rule or self._is_currently_playing_dialogue then
		return
	end

	local dialogue_index = nil

	if seed then
		local _, random_n = math.next_random(seed, 1, rule.sound_events_n)
		dialogue_index = random_n
	else
		dialogue_index = DialogueQueries.get_dialogue_event_index(rule)
	end

	if specific_line then
		dialogue_index = specific_line
	end

	local sound_event, subtitles_event, sound_event_duration = self:get_dialogue_event(rule_name, dialogue_index)

	if not sound_event then
		return
	end

	self._last_query_sound_event = sound_event
	local dialogue_system = self._dialogue_system
	local wwise_route = WwiseRouting[wwise_route_key]
	local dialog_sequence_events = dialogue_system:_create_sequence_events_table(pre_wwise_event, wwise_route, sound_event, post_wwise_event)
	local event_id = self:play_event(dialog_sequence_events[1])
	local unit = self._unit
	local speaker_name = self:get_context().voice_template
	local dialogue = self:request_empty_dialogue_table()
	dialogue.currently_playing_event_id = event_id
	dialogue.currently_playing_unit = unit
	dialogue.speaker_name = speaker_name
	dialogue.dialogue_timer = sound_event_duration
	dialogue.currently_playing_subtitle = subtitles_event
	dialogue.wwise_route = wwise_route_key
	dialogue.is_audible = true
	dialogue.subtitle_distance = wwise_route.subtitle_distance
	dialogue.dialogue_sequence = dialog_sequence_events
	dialogue_system._playing_units[unit] = self

	table.insert(dialogue_system._playing_dialogues_array, 1, dialogue)

	self._is_currently_playing_dialogue = true

	if not optional_keep_talking then
		local animation_event = "start_talking"

		dialogue_system:_trigger_face_animation_event(unit, animation_event)
	end

	local dialogue_system_subtitle = dialogue_system:dialogue_system_subtitle()

	if not pre_wwise_event then
		dialogue_system_subtitle:add_playing_localized_dialogue(speaker_name, dialogue)
	end

	if on_play_callback then
		local id = dialogue.currently_playing_event_id

		on_play_callback(id, rule_name)
	end
end

function DialogueExtension:get_selected_wwise_route(wwise_route, wwise_source_id)
	local selected_wwise_route = wwise_route

	if self._is_a_player and self._local_player and wwise_route.local_player_routing_key then
		local player_unit_spawn_manager = Managers.state.player_unit_spawn
		local player = player_unit_spawn_manager:owner(self._unit)

		if player:is_human_controlled() then
			selected_wwise_route = WwiseRouting[wwise_route.local_player_routing_key]
		end
	end

	if wwise_source_id ~= self._wwise_source_id and self._wwise_voice_switch_group then
		self._wwise_source_id = wwise_source_id

		self._dialogue_system_wwise:set_switch_and_vo_center(self._wwise_source_id, self._wwise_voice_switch_group, self._wwise_voice_switch_value, self._vo_center_percent)
	end

	return selected_wwise_route
end

function DialogueExtension:store_in_memory(memory_name, argument_name, value)
	local target_memory = self["_" .. memory_name]
	target_memory[argument_name] = value
end

function DialogueExtension:read_from_memory(memory_name, argument_name)
	local target_memory = self["_" .. memory_name]

	return target_memory[argument_name]
end

function DialogueExtension:is_dialogue_disabled()
	if self._context.is_disabled_override == true then
		return false
	else
		return self._context.is_disabled
	end
end

function DialogueExtension:set_dialogue_disabled(is_disabled)
	self._context.is_disabled = is_disabled
end

function DialogueExtension:set_is_disabled_override(is_disabled_override)
	self._context.is_disabled_override = is_disabled_override
end

function DialogueExtension:get_context()
	return self._context
end

function DialogueExtension:get_faction()
	return self._faction
end

function DialogueExtension:get_faction_memory()
	return self._faction_memory
end

function DialogueExtension:set_faction_memory(faction_memory)
	self._faction_memory = faction_memory
end

function DialogueExtension:get_user_memory()
	return self._user_memory
end

function DialogueExtension:get_unit()
	return self._unit
end

function DialogueExtension:get_profile_name()
	return self._vo_profile_name
end

function DialogueExtension:get_play_unit()
	return self._play_unit
end

function DialogueExtension:get_voice_node()
	return self._voice_node
end

function DialogueExtension:get_voice_switch_group()
	return self._wwise_voice_switch_group
end

function DialogueExtension:get_voice_switch_value()
	return self._wwise_voice_switch_value
end

function DialogueExtension:get_wwise_source_id()
	return self._wwise_source_id
end

function DialogueExtension:set_wwise_source_id(source_id)
	self._wwise_source_id = source_id
end

function DialogueExtension:get_vo_center_percent()
	return self._vo_center_percent
end

function DialogueExtension:get_last_query_sound_event()
	return self._last_query_sound_event
end

function DialogueExtension:set_last_query_sound_event(sound_event)
	self._last_query_sound_event = sound_event
end

function DialogueExtension:request_empty_dialogue_table()
	local dialogue = self._dialogue

	table.clear(dialogue)

	return dialogue
end

function DialogueExtension:get_currently_playing_dialogue()
	return self._is_currently_playing_dialogue and self._dialogue or nil
end

function DialogueExtension:set_is_currently_playing_dialogue(currently_playing)
	self._is_currently_playing_dialogue = currently_playing
end

function DialogueExtension:set_wwise_route(wwise_route)
	self._wwise_route = wwise_route
end

function DialogueExtension:get_local_player()
	return self._local_player
end

function DialogueExtension:is_network_synced()
	return self._is_network_synced
end

function DialogueExtension:is_a_player()
	return self._is_a_player
end

function DialogueExtension:is_currently_playing_dialogue()
	return self._is_currently_playing_dialogue
end

function DialogueExtension:faction_name()
	return self._faction_breed_name
end

function DialogueExtension:get_event_data_payload()
	table.clear(self._trigger_event_data_payload)

	return self._trigger_event_data_payload
end

function DialogueExtension:vo_class_name()
	if self._profile and self._is_a_player then
		return self._profile.archetype.name
	else
		return DialogueBreedSettings[self._context.breed_name].vo_class_name
	end
end

function DialogueExtension:is_playing(id)
	local wwise_world = self._wwise_world
	local is_playing = WwiseWorld.is_playing(wwise_world, id)

	return is_playing
end

function DialogueExtension:set_story_stage(story_stage)
	self._context.story_stage = story_stage
end

function DialogueExtension:set_dynamic_smart_tag(smart_tag)
	self._dynamic_smart_tag = smart_tag
end

function DialogueExtension:get_dynamic_smart_tag()
	return self._dynamic_smart_tag
end

return DialogueExtension
