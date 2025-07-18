local Armor = require("scripts/utilities/attack/armor")
local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local BotSpawning = require("scripts/managers/bot/bot_spawning")
local Breed = require("scripts/utilities/breed")
local BreedQueries = require("scripts/utilities/breed_queries")
local CameraShake = require("scripts/utilities/camera/camera_shake")
local CompanionVisualLoadout = require("scripts/utilities/companion_visual_loadout")
local Effect = require("scripts/extension_systems/fx/utilities/effect")
local FixedFrame = require("scripts/utilities/fixed_frame")
local ForceRotation = require("scripts/extension_systems/locomotion/utilities/force_rotation")
local GameModeSettings = require("scripts/settings/game_mode/game_mode_settings")
local HordesModeSettings = require("scripts/settings/hordes_mode_settings")
local MaterialFx = require("scripts/utilities/material_fx")
local MaterialQuery = require("scripts/utilities/material_query")
local NavQueries = require("scripts/utilities/nav_queries")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local PlayerMovement = require("scripts/utilities/player_movement")
local PlayerUnitVisualLoadout = require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")
local PlayerVisibility = require("scripts/utilities/player_visibility")
local PlayerVoiceGrunts = require("scripts/utilities/player_voice_grunts")
local PlayerVoStoryStage = require("scripts/utilities/player_vo_story_stage")
local ScriptWorld = "scripts/foundation/utilities/script_world"
local Vo = require("scripts/utilities/vo")
local slot_configuration = PlayerCharacterConstants.slot_configuration
local unit_alive = Unit.alive
local Vector3 = Vector3
local Quaternion = Quaternion
local Matrix4x4 = Matrix4x4
local Unit = Unit
local flow_return_table = {}
FlowCallbacks = FlowCallbacks or {}
local unit_flow_event = Unit.flow_event

function FlowCallbacks.clear_return_value()
	table.clear(flow_return_table)
end

function FlowCallbacks.anim_callback(params)
	local unit = params.unit
	local callback_name = params.callback
	local param1 = params.param1
	local animation_system = Managers.state.extension:system("animation_system")

	animation_system:anim_callback(unit, callback_name, param1)
end

function FlowCallbacks.call_anim_event(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.unit
	local event_name = params.event_name
	local animation_extension = ScriptUnit.has_extension(unit, "animation_system")

	if animation_extension then
		animation_extension:anim_event(event_name)
	end
end

function FlowCallbacks.disable_animation_statemachine(params)
	local unit = params.unit

	Unit.disable_animation_state_machine(unit)
end

function FlowCallbacks.play_npc_foley(params)
	local unit = params.unit
	local event_resource = params.event_resource
	local unit_node = Unit.node(unit, params.unit_node)
	local world = Application.flow_callback_context_world()
	local wwise_world = World.get_data(world, "wwise_world")
	local source_id = WwiseWorld.make_auto_source(wwise_world, unit, unit_node)

	WwiseWorld.trigger_resource_event(wwise_world, event_resource, source_id)
end

function FlowCallbacks.play_npc_vce(params)
	local unit = params.unit
	local event_resource = params.event_resource
	local world = Application.flow_callback_context_world()
	local wwise_world = World.get_data(world, "wwise_world")
	local dialogue_extension = ScriptUnit.has_extension(unit, "dialogue_system")

	if dialogue_extension then
		local unit_node = dialogue_extension:get_voice_node()
		local source_id = WwiseWorld.make_auto_source(wwise_world, unit, unit_node)
		local wwise_switch_group, selected_voice = dialogue_extension:voice_data()

		WwiseWorld.set_switch(wwise_world, wwise_switch_group, selected_voice, source_id)
		WwiseWorld.trigger_resource_event(wwise_world, event_resource, true, source_id)
	end
end

function FlowCallbacks.set_allowed_nav_tag_volume_name(params)
	local volume_name = params.volume_name
	local allowed = params.allowed
	local nav_mesh_manager = Managers.state.nav_mesh

	nav_mesh_manager:set_allowed_nav_tag_layer(volume_name, allowed)
end

function FlowCallbacks.set_allowed_nav_tag_volume_type(params)
	local volume_type = params.volume_type
	local allowed = params.allowed
	local nav_mesh_manager = Managers.state.nav_mesh
	local nav_tag_volume_data = nav_mesh_manager:nav_tag_volume_data()

	for volume, data in pairs(nav_tag_volume_data) do
		if data.type == volume_type then
			nav_mesh_manager:set_allowed_nav_tag_layer(data.name, allowed)
		end
	end
end

function FlowCallbacks.enable_script_component(params)
	local guid = params.guid
	local unit = params.unit

	Managers.state.extension:system("component_system"):enable_component(unit, guid)
end

function FlowCallbacks.disable_script_component(params)
	local guid = params.guid
	local unit = params.unit

	Managers.state.extension:system("component_system"):disable_component(unit, guid)
end

function FlowCallbacks.call_script_component(params)
	local guid = params.guid
	local unit = params.unit
	local value = params.value
	local function_name = params.event

	Managers.state.extension:system("component_system"):flow_call_component(unit, guid, function_name, value)
end

function FlowCallbacks.get_component_data(params)
	local guid = params.guid
	local unit = params.unit
	local key = params.key
	flow_return_table.out_value = Unit.get_data(unit, "components", guid, "component_data", key)

	return flow_return_table
end

function FlowCallbacks.set_component_data(params)
	local guid = params.guid
	local unit = params.unit
	local key = params.key
	local value = params.value

	Unit.set_data(unit, "components", guid, "component_data", key, value)
end

function FlowCallbacks.volume_event_set_enabled(params)
	local volume_name = params.volume_name
	local enabled = params.enabled
	local volume_event_system = Managers.state.extension:system("volume_event_system")

	if enabled then
		volume_event_system:register_volumes_by_name(volume_name)
	else
		volume_event_system:unregister_volumes_by_name(volume_name)
	end
end

function FlowCallbacks.volume_event_connect_unit(params)
	local volume_name = params.volume_name
	local unit = params.unit
	local volume_event_system = Managers.state.extension:system("volume_event_system")

	volume_event_system:connect_unit_to_volume(volume_name, unit)
end

function FlowCallbacks.volume_event_disconnect_unit(params)
	local volume_name = params.volume_name
	local unit = params.unit
	local volume_event_system = Managers.state.extension:system("volume_event_system")

	volume_event_system:disconnect_unit_from_volume(volume_name, unit)
end

local function _set_minion_foley_speed(unit, wwise_world, source_id)
	local locomotion_extension = ScriptUnit.has_extension(unit, "locomotion_system")

	if not locomotion_extension then
		return
	end

	local current_velocity = locomotion_extension:current_velocity()
	local move_speed = Vector3.length(current_velocity)

	WwiseWorld.set_source_parameter(wwise_world, source_id, "foley_speed", move_speed)
end

local function _minion_auto_source_trigger_wwise_event(unit, param_sound_source_object, param_sound_position, wwise_world, wwise_event)
	local wwise_playing_id, source_id = nil
	local sound_source_object = 1

	if param_sound_source_object then
		sound_source_object = Unit.node(unit, param_sound_source_object)
	end

	if param_sound_position then
		local world_position = Vector3.add(Unit.world_position(unit, sound_source_object), param_sound_position)
		wwise_playing_id, source_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, world_position)
	else
		wwise_playing_id, source_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, unit, sound_source_object)
	end

	return wwise_playing_id, source_id
end

local function _minion_update_special_targeting_parameter(unit, wwise_world, source_id)
	local game_session = Managers.state.game_session:game_session()
	local game_object_id = Managers.state.unit_spawner:game_object_id(unit)

	if game_object_id then
		local target_unit_id = GameSession.game_object_field(game_session, game_object_id, "target_unit_id")

		if target_unit_id ~= NetworkConstants.invalid_game_object_id then
			local target_unit = Managers.state.unit_spawner:unit(target_unit_id)

			if not target_unit then
				return
			end

			Effect.update_targeted_by_special_wwise_parameters(target_unit, wwise_world, source_id, nil, unit)
		end
	end
end

local MIN_MELEE_TARGETING_DISTANCE = 10

local function _minion_update_targeted_in_melee_parameter(unit, wwise_world, source_id)
	local game_session = Managers.state.game_session:game_session()
	local game_object_id = Managers.state.unit_spawner:game_object_id(unit)

	if game_object_id then
		local target_unit_id = GameSession.game_object_field(game_session, game_object_id, "target_unit_id")

		if target_unit_id ~= NetworkConstants.invalid_game_object_id then
			local target_unit = Managers.state.unit_spawner:unit(target_unit_id)

			if not target_unit then
				return
			end

			local unit_pos = Unit.world_position(unit, 1)
			local target_pos = Unit.world_position(target_unit, 1)
			local distance = Vector3.distance(unit_pos, target_pos)

			if distance <= MIN_MELEE_TARGETING_DISTANCE then
				Effect.update_targeted_in_melee_wwise_parameters(target_unit, wwise_world, source_id)
			end
		end
	end
end

local function _minion_target_unit_armor_type(unit)
	local game_session = Managers.state.game_session:game_session()
	local game_object_id = Managers.state.unit_spawner:game_object_id(unit)

	if not game_object_id then
		return nil
	end

	local target_unit_id = GameSession.game_object_field(game_session, game_object_id, "target_unit_id")

	if target_unit_id == NetworkConstants.invalid_game_object_id then
		return nil
	end

	local target_unit = Managers.state.unit_spawner:unit(target_unit_id)

	if not target_unit then
		return nil
	end

	local target_breed_or_nil = Breed.unit_breed_or_nil(target_unit)
	local armor_type = Armor.armor_type(unit, target_breed_or_nil)

	return armor_type
end

function FlowCallbacks.minion_fx(params)
	if DEDICATED_SERVER then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = nil

		return flow_return_table
	end

	local unit = params.unit
	local name = params.name
	local breed = ScriptUnit.extension(unit, "unit_data_system"):breed()
	local sounds = breed.sounds
	local wwise_events = sounds.events
	local use_proximity_culling = sounds.use_proximity_culling
	local wwise_event = wwise_events[name]
	local sound_uses_proximity_culling = use_proximity_culling[name]
	local legacy_v2_proximity_extension = ScriptUnit.extension(unit, "legacy_v2_proximity_system")
	local is_proximity_fx_enabled = legacy_v2_proximity_extension.is_proximity_fx_enabled

	if sound_uses_proximity_culling and not is_proximity_fx_enabled then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = nil

		return flow_return_table
	end

	local vfx = breed.vfx
	local particle_name = vfx[name]
	local switch_name = nil
	local switch_on_wielded_slot = params.switch_on_wielded_slot
	local switch_on_target_armor = params.switch_on_target_armor
	local use_switch = switch_on_wielded_slot or switch_on_target_armor

	if use_switch then
		if switch_on_wielded_slot then
			local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
			local wielded_slot_name = visual_loadout_extension:wielded_slot_name()
			switch_name = wielded_slot_name
		elseif switch_on_target_armor then
			local armor_type = _minion_target_unit_armor_type(unit)
			switch_name = armor_type
		end

		if switch_name then
			if type(wwise_event) == "table" then
				wwise_event = wwise_event[switch_name]
			end

			if type(particle_name) == "table" then
				particle_name = particle_name[switch_name]
			end
		else
			wwise_event = nil
			particle_name = nil
		end
	end

	local world_manager = Managers.world
	local world = world_manager:world("level_world")
	local wwise_playing_id = nil

	if wwise_event then
		local wwise_world = world_manager:wwise_world(world)
		local source_id = params.sound_existing_source_id

		if source_id then
			if params.sound_set_speed_parameter then
				_set_minion_foley_speed(unit, wwise_world, source_id)
			end

			local play_vce = true
			local use_voice = params.sound_use_breed_voice_profile
			local dialogue_extension = ScriptUnit.has_extension(unit, "dialogue_system")

			if dialogue_extension then
				local is_playing_vo = dialogue_extension:is_currently_playing_dialogue()

				if is_playing_vo then
					local suppress_vo = params.sound_suppress_vo

					if suppress_vo then
						dialogue_extension:stop_currently_playing_vo()
					elseif use_voice then
						play_vce = false
					end
				end

				if use_voice then
					local wwise_switch_group, selected_voice = dialogue_extension:voice_data()

					WwiseWorld.set_switch(wwise_world, wwise_switch_group, selected_voice, source_id)
				end
			end

			if play_vce or not use_voice then
				wwise_playing_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, source_id)

				if breed.uses_wwise_special_targeting_parameter then
					_minion_update_special_targeting_parameter(unit, wwise_world, source_id)
				else
					_minion_update_targeted_in_melee_parameter(unit, wwise_world, source_id)
				end
			end
		else
			wwise_playing_id, source_id = _minion_auto_source_trigger_wwise_event(unit, params.sound_source_object, params.sound_position, wwise_world, wwise_event)

			if breed.uses_wwise_special_targeting_parameter then
				_minion_update_special_targeting_parameter(unit, wwise_world, source_id)
			else
				_minion_update_targeted_in_melee_parameter(unit, wwise_world, source_id)
			end

			if params.sound_set_speed_parameter then
				_set_minion_foley_speed(unit, wwise_world, source_id)
			end
		end
	end

	if not is_proximity_fx_enabled then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = wwise_playing_id

		return flow_return_table
	end

	local effect_id = nil

	if particle_name then
		if type(particle_name) == "table" then
			particle_name = particle_name[math.random(1, #particle_name)]
		end

		local node_name = params.particle_source_object

		if params.particle_linked then
			effect_id = World.create_particles(world, particle_name)
			local node = Unit.node(unit, node_name)
			local pose = Matrix4x4.from_quaternion_position(params.particle_rotation_offset or Quaternion.identity(), params.particle_offset or Vector3.zero())

			World.link_particles(world, effect_id, unit, node, pose, params.particle_orphaned_policy)
		elseif node_name then
			local node = Unit.node(unit, node_name)
			local node_pose = Unit.world_pose(unit, node)
			local pose = Matrix4x4.multiply(node_pose, Matrix4x4.from_quaternion_position(params.particle_rotation_offset or Quaternion.identity(), params.particle_offset or Vector3.zero()))
			effect_id = World.create_particles(world, particle_name, Matrix4x4.translation(pose), Matrix4x4.rotation(pose))
		else
			effect_id = World.create_particles(world, particle_name, params.particle_offset or Vector3.zero(), params.particle_rotation_offset or Quaternion.identity())
		end
	end

	flow_return_table.effect_id = effect_id
	flow_return_table.playing_id = wwise_playing_id

	return flow_return_table
end

function FlowCallbacks.minion_material_fx(params)
	if DEDICATED_SERVER then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = nil

		return flow_return_table
	end

	local name = params.name
	local unit = params.unit
	local breed = ScriptUnit.extension(unit, "unit_data_system"):breed()
	local sounds = breed.sounds
	local use_proximity_culling = sounds.use_proximity_culling
	local sound_uses_proximity_culling = use_proximity_culling[name]
	local legacy_v2_proximity_extension = ScriptUnit.extension(unit, "legacy_v2_proximity_system")
	local is_proximity_fx_enabled = legacy_v2_proximity_extension.is_proximity_fx_enabled

	if sound_uses_proximity_culling and not is_proximity_fx_enabled then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = nil

		return flow_return_table
	end

	local query_position_object = Unit.node(unit, params.query_position_object)
	local query_from = Unit.world_position(unit, query_position_object)
	local unit_rotation = Unit.world_rotation(unit, 1)

	if params.query_clamp_to_ground then
		query_from.z = POSITION_LOOKUP[unit].z
	end

	local query_offset = params.query_offset

	if query_offset then
		query_from = query_from + Quaternion.rotate(unit_rotation, query_offset)
	end

	local query_vector = params.query_vector
	local query_to = query_from + Quaternion.rotate(unit_rotation, query_vector)
	local world_manager = Managers.world
	local world = world_manager:world("level_world")
	local wwise_events = sounds.events
	local wwise_event = wwise_events[name]
	local vfx_table = breed.vfx.material_vfx[name]
	local hit, material, impact_position, normal = nil

	if wwise_event or vfx_table then
		hit, material, impact_position, normal = MaterialQuery.query_material(World.get_data(world, "physics_world"), query_from, query_to, name)

		if hit then
			Unit.set_data(unit, "cache_material", material)
		end
	end

	local wwise_playing_id = nil

	if wwise_event then
		local wwise_world = World.get_data(world, "wwise_world")
		local source_id = params.sound_source_id

		if source_id then
			if not hit then
				local cached_material = Unit.get_data(unit, "cache_material")

				if cached_material then
					WwiseWorld.set_switch(wwise_world, "surface_material", cached_material, source_id)
				end
			elseif material then
				WwiseWorld.set_switch(wwise_world, "surface_material", material, source_id)
			end

			if breed.uses_wwise_special_targeting_parameter then
				_minion_update_special_targeting_parameter(unit, wwise_world, source_id)
			else
				_minion_update_targeted_in_melee_parameter(unit, wwise_world, source_id)
			end

			if params.sound_set_speed_parameter then
				_set_minion_foley_speed(unit, wwise_world, source_id)
			end

			wwise_playing_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, source_id)
		else
			source_id = WwiseWorld.make_auto_source(wwise_world, unit, query_position_object)

			if not hit then
				local cached_material = Unit.get_data(unit, "cache_material")

				if cached_material then
					WwiseWorld.set_switch(wwise_world, "surface_material", cached_material, source_id)
				end
			elseif material then
				WwiseWorld.set_switch(wwise_world, "surface_material", material, source_id)
			end

			if breed.uses_wwise_special_targeting_parameter then
				_minion_update_special_targeting_parameter(unit, wwise_world, source_id)
			else
				_minion_update_targeted_in_melee_parameter(unit, wwise_world, source_id)
			end

			if params.sound_set_speed_parameter then
				_set_minion_foley_speed(unit, wwise_world, source_id)
			end

			local param_sound_source_object = params.query_position_object
			local param_sound_position = params.sound_position
			local sound_source_object = 1

			if param_sound_source_object then
				sound_source_object = Unit.node(unit, param_sound_source_object)
			end

			if param_sound_position then
				local world_position = Vector3.add(Unit.world_position(unit, sound_source_object), param_sound_position)
				wwise_playing_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, world_position)
			else
				wwise_playing_id = WwiseWorld.trigger_resource_event(wwise_world, wwise_event, unit, sound_source_object)
			end
		end
	end

	if not is_proximity_fx_enabled then
		flow_return_table.effect_id = nil
		flow_return_table.playing_id = wwise_playing_id

		return flow_return_table
	end

	local effect_id = nil

	if hit then
		local particle_name = vfx_table[material] or vfx_table.default

		if particle_name then
			if type(particle_name) == "table" then
				particle_name = particle_name[math.random(1, #particle_name)]
			end

			local position_source = params.particle_position_source or "Impact"
			local rotation_source = params.particle_rotation_source or "Normal"
			local particle_rotation_offset = params.particle_rotation_offset
			local particle_offset = params.particle_offset
			local node = params.particle_source_object and Unit.node(unit, params.particle_source_object)

			if params.particle_linked then
				effect_id = World.create_particles(world, particle_name, Vector3.zero(), Quaternion.identity())
				local pose = Matrix4x4.from_quaternion_position(params.particle_rotation_offset or Quaternion.identity(), params.particle_rotation_offset or Vector3.zero())

				World.link_particles(world, effect_id, unit, node, pose, params.particle_orphaned_policy)
			else
				local position = nil

				if position_source == "Impact" then
					position = impact_position
				elseif position_source == "Unit" then
					position = Unit.world_position(unit, 1)
				elseif position_source == "Object" then
					position = Unit.world_position(unit, node)
				else
					position = Vector3.zero()
				end

				local rotation = nil

				if rotation_source == "Normal" then
					local particle_forward = normal
					local right = Quaternion.right(unit_rotation)
					local particle_up = Vector3.cross(particle_forward, right)
					rotation = Quaternion.look(normal, particle_up)
				elseif rotation_source == "Object" then
					rotation = Unit.world_rotation(unit, node)
				elseif rotation_source == "Unit" then
					rotation = Unit.world_rotation(unit, 1)
				else
					rotation = Quaternion.identity()
				end

				if particle_offset then
					position = position + Quaternion.rotate(rotation, particle_offset)
				end

				if particle_rotation_offset then
					rotation = Quaternion.multiply(rotation, params.particle_rotation_offset)
				end

				if params.particle_randomize_roll then
					rotation = Quaternion.multiply(rotation, Quaternion.from_yaw_pitch_roll(0, 0, math.random() * math.pi * 2))
				end

				effect_id = World.create_particles(world, particle_name, position, rotation)
			end
		end
	end

	if material == "water_puddle" or material == "water_deep" then
		material = "water"

		Managers.state.world_interaction:add_world_interaction(material, unit)
	end

	flow_return_table.effect_id = effect_id
	flow_return_table.playing_id = wwise_playing_id

	return flow_return_table
end

local function _set_player_foley_speed(unit, wwise_world, source_id)
	local locomotion_ext = ScriptUnit.extension(unit, "locomotion_system")
	local move_speed = locomotion_ext:move_speed()

	WwiseWorld.set_source_parameter(wwise_world, source_id, "foley_speed", move_speed)
end

local function _set_player_first_person_parameter(unit, wwise_world, source_id)
	local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
	local first_person_mode = first_person_extension:is_in_first_person_mode()
	local parameter_value = first_person_mode and 1 or 0

	WwiseWorld.set_source_parameter(wwise_world, source_id, "first_person_mode", parameter_value)
end

local function _set_voice_switch(unit, wwise_world, source_id)
	local voice_data = PlayerVoiceGrunts.voice_data(unit)

	PlayerVoiceGrunts.set_voice(wwise_world, source_id, voice_data.switch_group, voice_data.selected_voice, voice_data.selected_voice_fx_preset)
end

local function _should_play_player_fx(play_in, extension_unit)
	local first_person_extension = ScriptUnit.extension(extension_unit, "first_person_system")
	local is_in_first_person_mode = first_person_extension:is_in_first_person_mode()
	local should_play_fx = nil

	if play_in == "both" or play_in == nil then
		should_play_fx = true
	elseif play_in == "1p only" then
		should_play_fx = is_in_first_person_mode
	elseif play_in == "3p only" then
		should_play_fx = not is_in_first_person_mode
	end

	return should_play_fx
end

local function _player_fx_source_and_extension_unit(params)
	local first_person_unit = params.first_person_unit
	local source_unit, extension_unit = nil

	if first_person_unit then
		extension_unit = Unit.get_data(first_person_unit, "owner_unit")
		source_unit = first_person_unit
	else
		extension_unit = params.unit
		source_unit = extension_unit
	end

	return source_unit, extension_unit
end

function FlowCallbacks.player_voice(params)
	if DEDICATED_SERVER then
		return
	end

	local _, extension_unit = _player_fx_source_and_extension_unit(params)
	local play_in = params.play_in
	local should_play_fx = _should_play_player_fx(play_in, extension_unit)
	local wwise_playing_id = nil

	if should_play_fx then
		local vce_alias = params.vce_alias

		if vce_alias and vce_alias ~= "" then
			local visual_loadout_extension = ScriptUnit.extension(extension_unit, "visual_loadout_system")
			local fx_extension = ScriptUnit.extension(extension_unit, "fx_system")
			local suppress_vo = params.suppress_vo or false
			wwise_playing_id = PlayerVoiceGrunts.trigger_voice_non_synced(vce_alias, visual_loadout_extension, fx_extension, suppress_vo)
		end
	end

	flow_return_table.playing_id = wwise_playing_id

	return flow_return_table
end

function FlowCallbacks.player_fx(params)
	local source_unit, extension_unit = _player_fx_source_and_extension_unit(params)
	local play_in = params.play_in
	local should_play_fx = _should_play_player_fx(play_in, extension_unit)
	local wwise_playing_id, particle_id = nil

	if should_play_fx then
		local world_manager = Managers.world
		local world = world_manager:world("level_world")
		local sound_alias = params.sound_gear_alias
		local particle_alias = params.particle_gear_alias

		if sound_alias and sound_alias ~= "" then
			local wwise_world = world_manager:wwise_world(world)
			local source_id = params.sound_existing_source_id

			if not source_id then
				local node_index = 1

				if params.source_object then
					node_index = Unit.node(source_unit, params.source_object)
				end

				source_id = WwiseWorld.make_auto_source(wwise_world, source_unit, node_index)
			end

			if params.sound_set_speed_parameter then
				_set_player_foley_speed(extension_unit, wwise_world, source_id)
			end

			if params.sound_set_first_person_parameter then
				_set_player_first_person_parameter(extension_unit, wwise_world, source_id)
			end

			if params.sound_set_voice_switch then
				_set_voice_switch(extension_unit, wwise_world, source_id)
			end

			local fx_extension = ScriptUnit.extension(extension_unit, "fx_system")
			local external_properties = nil
			wwise_playing_id = fx_extension:trigger_gear_wwise_event(sound_alias, external_properties, source_id)
		end

		if particle_alias and particle_alias ~= "" then
			local visual_loadout_extension = ScriptUnit.extension(extension_unit, "visual_loadout_system")
			local resolved, particle_name = visual_loadout_extension:resolve_gear_particle(particle_alias)

			if resolved then
				local link = not not params.particle_linked
				local orphaned_policy = params.particle_orphaned_policy
				local translation_offset = params.particle_offset or Vector3.zero()
				local rotation_offset = params.particle_rotation_offset or Quaternion.identity()
				local source_object = params.source_object
				local node_index = 1

				if source_object then
					node_index = Unit.node(source_unit, source_object)
				end

				if link then
					particle_id = World.create_particles(world, particle_name, Vector3.zero(), Quaternion.identity())
					local pose = Matrix4x4.from_quaternion_position(rotation_offset, translation_offset)

					World.link_particles(world, particle_id, source_unit, node_index, pose, orphaned_policy)
				else
					local node_pose = Unit.world_pose(source_unit, node_index)
					local offset_pose = Matrix4x4.multiply(node_pose, Matrix4x4.from_quaternion_position(rotation_offset, translation_offset))
					local translation = Matrix4x4.translation(offset_pose)
					local rotation = Matrix4x4.rotation(offset_pose)
					particle_id = World.create_particles(world, particle_name, translation, rotation)
				end
			end
		end
	end

	flow_return_table.playing_id = wwise_playing_id
	flow_return_table.particle_id = particle_id

	return flow_return_table
end

function FlowCallbacks.player_footstep(params)
	local unit = params.unit
	local should_play_fx = _should_play_player_fx("3p only", unit)

	if should_play_fx then
		local particle_alias = params.particle_gear_alias
		local sound_alias = params.sound_gear_alias
		local foot = params.foot
		local use_cached_material_hit = params.use_cached_material_hit
		local world = Managers.world:world("level_world")
		local wwise_world = World.get_data(world, "wwise_world")
		local physics_world = World.get_data(world, "physics_world")

		MaterialFx.flow_cb_3p_footstep(world, wwise_world, physics_world, unit, sound_alias, foot, use_cached_material_hit)
	end

	return flow_return_table
end

function FlowCallbacks.companion_footstep(params)
	local unit = params.unit
	local sound_alias = params.sound_gear_alias
	local unit_node_name = params.unit_node
	local unit_node = Unit.node(unit, unit_node_name)
	local query_from = Unit.world_position(unit, unit_node) + Vector3.up() * 0.5
	local query_to = query_from - Vector3.up()
	local world = Managers.world:world("level_world")
	local wwise_world = World.get_data(world, "wwise_world")
	local physics_world = World.get_data(world, "physics_world")
	local hit, material, _, _ = MaterialQuery.query_material(physics_world, query_from, query_to, "companion_footstep")

	if hit then
		Unit.set_data(unit, "cache_material", material)
	end

	local owner_player = Managers.state.player_unit_spawn:owner(unit)
	local player_unit = owner_player and owner_player.player_unit

	if player_unit then
		local owner_visual_loadout_extension = ScriptUnit.has_extension(player_unit, "visual_loadout_system")

		if owner_visual_loadout_extension then
			local resolved, event_name, has_husk_events = owner_visual_loadout_extension:resolve_gear_sound(sound_alias, nil)

			if resolved then
				local source_id = WwiseWorld.make_auto_source(wwise_world, unit, unit_node)

				if not hit then
					local cached_material = Unit.get_data(unit, "cache_material")

					if cached_material then
						WwiseWorld.set_switch(wwise_world, "surface_material", cached_material, source_id)
					end
				elseif material then
					WwiseWorld.set_switch(wwise_world, "surface_material", material, source_id)
				end

				local locomotion_extension = ScriptUnit.has_extension(unit, "locomotion_system")
				local current_velocity = locomotion_extension and locomotion_extension:current_velocity()
				local move_speed = current_velocity and Vector3.length(current_velocity) or 0

				WwiseWorld.set_source_parameter(wwise_world, source_id, "foley_speed", move_speed)

				if has_husk_events and owner_player.remote then
					event_name = event_name .. "_husk"
				end

				local wwise_playing_id = WwiseWorld.trigger_resource_event(wwise_world, event_name, source_id)
				flow_return_table.playing_id = wwise_playing_id
			end
		end
	end

	return flow_return_table
end

function FlowCallbacks.player_material_fx(params)
	local unit = params.unit
	local play_in = params.play_in
	local should_play_fx = _should_play_player_fx(play_in, unit)

	if should_play_fx then
		local source_id = params.sound_source_id
		local query_position_object = Unit.node(unit, params.query_position_object)
		local sound_alias = params.sound_gear_alias
		local world = Managers.world:world("level_world")
		local wwise_world = World.get_data(world, "wwise_world")
		local physics_world = World.get_data(world, "physics_world")
		local unit_pos = Unit.world_position(unit, query_position_object)
		local query_from = unit_pos + Vector3(0, 0, 0.5)
		local query_to = query_from + Vector3(0, 0, -1)

		MaterialFx.trigger_material_fx(unit, world, wwise_world, physics_world, sound_alias, source_id, query_from, query_to, params.sound_set_speed_parameter, params.sound_set_first_person_parameter)
	end

	return flow_return_table
end

local external_properties = {}

function FlowCallbacks.player_inventory_fx(params)
	local source_alias = params.fx_source_name
	local sound_alias = params.sound_alias
	local effect_alias = params.effect_alias
	local first_person_unit = params.first_person_unit
	local extension_unit = nil

	if first_person_unit then
		extension_unit = Unit.get_data(first_person_unit, "owner_unit")
	else
		extension_unit = params.unit
	end

	local fx_extension = ScriptUnit.extension(extension_unit, "fx_system")
	local visual_loadout_extension = ScriptUnit.extension(extension_unit, "visual_loadout_system")
	local unit_data_extension = ScriptUnit.extension(extension_unit, "unit_data_system")
	local inventory_component = unit_data_extension:read_component("inventory")
	local critical_strike_component = unit_data_extension:read_component("critical_strike")
	local wielded_slot = inventory_component.wielded_slot
	local play_in = params.play_in
	local should_play_fx = _should_play_player_fx(play_in, extension_unit)
	local wwise_playing_id = nil

	if should_play_fx and wielded_slot and wielded_slot ~= "none" then
		local fx_sources = visual_loadout_extension:source_fx_for_slot(wielded_slot)
		local source_name = fx_sources and fx_sources[source_alias]
		local slot_config = slot_configuration[wielded_slot]
		local slot_type = slot_config.slot_type
		external_properties.is_critical_strike = tostring(critical_strike_component.is_active)

		if slot_type == "weapon" then
			local inventory_slot_component = unit_data_extension:read_component(wielded_slot)
			external_properties.special_active = tostring(inventory_slot_component.special_active)
		end

		if source_name then
			if sound_alias and sound_alias ~= "" then
				local sync_to_clients = true
				wwise_playing_id = fx_extension:trigger_gear_wwise_event_with_source(sound_alias, external_properties, source_name, sync_to_clients)
			end

			if effect_alias and effect_alias ~= "" then
				local link = true
				local orphaned_policy = "stop"

				fx_extension:spawn_gear_particle_effect_with_source(effect_alias, external_properties, source_name, link, orphaned_policy)
			end
		end
	end

	flow_return_table.playing_id = wwise_playing_id

	return flow_return_table
end

function FlowCallbacks.player_inventory_event(params)
	local first_person_unit = params.first_person_unit
	local event_name = params.event_name
	local extension_unit = nil

	if first_person_unit then
		extension_unit = Unit.get_data(first_person_unit, "owner_unit")
	else
		extension_unit = params.unit
	end

	local visual_loadout_extension = ScriptUnit.extension(extension_unit, "visual_loadout_system")
	local unit_data_extension = ScriptUnit.extension(extension_unit, "unit_data_system")
	local inventory_component = unit_data_extension:read_component("inventory")
	local wielded_slot = inventory_component.wielded_slot

	if wielded_slot ~= "none" then
		local unit_1p, unit_3p, attachments_by_unit_1p, attachments_by_unit_3p = visual_loadout_extension:unit_and_attachments_from_slot(wielded_slot)

		if unit_1p then
			unit_flow_event(unit_1p, event_name)
		end

		if attachments_by_unit_1p then
			local attachments_1p = attachments_by_unit_1p[unit_1p]

			for i = 1, #attachments_1p do
				local attachment_unit = attachments_1p[i]

				unit_flow_event(attachment_unit, event_name)
			end
		end
	end
end

function FlowCallbacks.companion_inventory_fx(params)
	local unit = params.unit
	local sound_alias = params.sound_gear_alias
	local unit_node_name = params.unit_node
	local profile_properties_wwise_switch = params.profile_properties_wwise_switch
	local unit_node = Unit.node(unit, unit_node_name)
	local world = Managers.world:world("level_world")
	local wwise_world = World.get_data(world, "wwise_world")
	local source_id = WwiseWorld.make_auto_source(wwise_world, unit, unit_node)

	CompanionVisualLoadout.trigger_gear_sound(unit, source_id, sound_alias, profile_properties_wwise_switch)

	return flow_return_table
end

function FlowCallbacks.disable_lights_event(params)
	local unit = params.unit
	local num_lights = Unit.num_lights(unit)

	for i = 1, num_lights do
		local light = Unit.light(unit, i)

		Light.set_enabled(light, false)
	end

	if params.disable_emissive then
		Unit.set_vector4_for_materials(unit, "emissive_color_intensity", Color(0, 0, 0, 0), true)
	end
end

function FlowCallbacks.blood_ball_collision(params)
	if not Managers.state.blood then
		return
	end

	local actor = params.colliding_actor
	local unit = Actor.unit(actor)
	local position = params.collision_position
	local normal = params.collision_normal
	local velocity = Actor.velocity(actor)
	local blood_type = params.blood_type or "default"
	local remove_blood_ball = params.remove_blood_ball

	Managers.state.blood:blood_ball_collision(unit, position, normal, velocity, blood_type, remove_blood_ball)
end

function FlowCallbacks.remove_blood_ball(params)
	if Managers.state.blood ~= nil then
		Managers.state.blood:remove_blood_ball(params.unit)
	end
end

function FlowCallbacks.create_networked_flow_state(params)
	local created, out_value = Managers.state.networked_flow_state:flow_cb_create_state(params.unit, params.state_name, params.in_value, params.client_state_changed_event, params.client_hot_join_event, params.is_game_object)

	if created then
		flow_return_table.created = created
		flow_return_table.out_value = out_value

		return flow_return_table
	end
end

function FlowCallbacks.change_networked_flow_state(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return nil
	end

	local out_value = Managers.state.networked_flow_state:flow_cb_change_state(params.unit, params.state_name, params.in_value)
	flow_return_table.changed = true
	flow_return_table.out_value = out_value

	return flow_return_table
end

function FlowCallbacks.get_networked_flow_state(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.out_value = out_value

	return flow_return_table
end

function FlowCallbacks.client_networked_flow_state_changed(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.changed = true
	flow_return_table.out_value = out_value

	return flow_return_table
end

function FlowCallbacks.client_networked_flow_state_set(params)
	local out_value = Managers.state.networked_flow_state:flow_cb_get_state(params.unit, params.state_name)
	flow_return_table.set = true
	flow_return_table.out_value = out_value

	return flow_return_table
end

function FlowCallbacks.new_onboarding_cinematic(params)
	local chapter = Managers.narrative:current_chapter(Managers.narrative.STORIES.onboarding)

	if chapter then
		flow_return_table.template_name = chapter.name
	end

	return flow_return_table
end

function FlowCallbacks.new_onboarding_cinematic_viewed(params)
	Managers.narrative:complete_current_chapter(Managers.narrative.STORIES.onboarding)
end

function FlowCallbacks.trigger_cinematic_video_with_popup(params)
	local video_config_name = params.video_config_name
	local popup_config_name = params.popup_config_name

	Managers.video:play_video_with_popup(video_config_name, popup_config_name)
end

function FlowCallbacks.trigger_cinematic_video(params)
	local template_name = params.template_name

	if template_name and template_name ~= "" then
		Managers.ui:open_view("video_view", nil, true, true, nil, {
			allow_skip_input = true,
			template = template_name
		})

		flow_return_table.triggered = true
	else
		flow_return_table.not_triggered = true
	end

	return flow_return_table
end

function FlowCallbacks.register_cinematic_story(params)
	params.flow_level = Application.flow_callback_context_level()

	return Managers.state.cinematic:register_story(params)
end

function FlowCallbacks.trigger_cinematic_story(params)
	Log.warning("FlowCallbacks", "'trigger_cinematic_story' is deprecated. Use CinematicScene Unit 'content/gizmos/cinematic_scene/cinematic_scene' instead.")

	return flow_return_table
end

function FlowCallbacks.queue_cinematic_story(params)
	Log.warning("FlowCallbacks", "'queue_cinematic_story' is deprecated. Use CinematicScene Unit 'content/gizmos/cinematic_scene/cinematic_scene' instead.")

	return flow_return_table
end

function FlowCallbacks.sub_levels_spawned(params)
	local world = Application.flow_callback_context_world()
	local level = Application.flow_callback_context_level()
	local cb = callback("Level", "trigger_script_node_event", level, params.node_id, "out", true)

	ScriptWorld.register_sub_levels_spawned_callback(world, level, cb)
end

function FlowCallbacks.show_players(params)
	PlayerVisibility.show_players()
end

function FlowCallbacks.hide_players(params)
	PlayerVisibility.hide_players()
end

function FlowCallbacks.set_host_gameplay_timescale(params)
	if GameParameters.disable_flow_timescale then
		return
	end

	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		Log.warning("FlowCallbacks", "set_host_gameplay_timescale() is called on a client")

		return
	end

	local time_manager = Managers.time

	time_manager:set_local_scale("gameplay", tonumber(params.scale))
end

function FlowCallbacks.set_cinematic_playback_speed(params)
	Managers.world:set_world_update_time_scale(tonumber(params.scale))
end

function FlowCallbacks.set_host_unkillable(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		Log.warning("FlowCallbacks", "set_host_unkillable() is called on a client")

		return
	end

	local local_player = Managers.player:local_player(1)
	local players = Managers.player:players_at_peer(local_player:peer_id())

	for _, player in pairs(players) do
		if player:unit_is_alive() then
			local player_unit = player.player_unit
			local health_extension = ScriptUnit.extension(player_unit, "health_system")

			health_extension:set_unkillable(params.enabled)
		end
	end
end

function FlowCallbacks.cutscene_fade_in(params)
	local duration = params.duration
	local easing_function = params.easing_function and math[params.easing_function]
	local local_player = Managers.player:local_player(1)
	local fade_color = params.fade_color

	Managers.event:trigger("event_cutscene_fade_in", local_player, duration, easing_function, fade_color)
end

function FlowCallbacks.cutscene_fade_out(params)
	local duration = params.duration
	local easing_function = params.easing_function and math[params.easing_function]
	local local_player = Managers.player:local_player(1)
	local fade_color = params.fade_color

	Managers.event:trigger("event_cutscene_fade_out", local_player, duration, easing_function, fade_color)
end

function FlowCallbacks.tutorial_display_popup_message(params)
	local is_server = Managers.state.game_session:is_server()
	local local_player = Managers.player:local_player(1)

	if not is_server or not local_player then
		return
	end

	local info_data = {
		description = params.description,
		title = params.title,
		close_action = params.close_action,
		use_ingame_input = true
	}

	Managers.event:trigger("event_player_display_prologue_tutorial_info_box", local_player, info_data)
end

function FlowCallbacks.tutorial_hide_popup_message(params)
	local is_server = Managers.state.game_session:is_server()
	local local_player = Managers.player:local_player(1)

	if not is_server or not local_player then
		return
	end

	Managers.event:trigger("event_player_hide_prologue_tutorial_info_box", local_player)
end

function FlowCallbacks.clear_hostiles(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local minion_spawn_manager = Managers.state.minion_spawn

	minion_spawn_manager:despawn_all_minions()
end

function FlowCallbacks.add_bot(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		Log.warning("FlowCallbacks.add_bot", "Only server can spawn bots!")

		return
	end

	local profile_name = params.profile_identifier
	flow_return_table.local_player_id = BotSpawning.spawn_bot_character(profile_name)

	return flow_return_table
end

function FlowCallbacks.remove_bot_safe(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		Log.warning("FlowCallbacks.remove_bot", "Only server can remove bots!")

		return
	end

	local local_player_id = params.local_player_id

	BotSpawning.despawn_bot_character(local_player_id, true)
end

function FlowCallbacks.bot_unit_by_profile_id(params)
	local profile_id = params.profile_id
	local bot_players = Managers.player:bot_players()

	for _, bot_player in pairs(bot_players) do
		local profile = bot_player:profile()

		if profile.character_id == profile_id then
			local bot_unit = bot_player.player_unit

			if bot_unit then
				flow_return_table.bot_unit = bot_unit
				flow_return_table.unit_found = true
				flow_return_table.unit_not_found = false

				return flow_return_table
			else
				break
			end
		end
	end

	flow_return_table.bot_unit = nil
	flow_return_table.unit_found = false
	flow_return_table.unit_not_found = true

	return flow_return_table
end

local HOLD_POSITION_NAV_ABOVE = 0.5
local HOLD_POSITION_NAV_BELOW = 2

function FlowCallbacks.bot_hold_position(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local player_unit = params.player_unit
	local behavior_extension = ScriptUnit.extension(player_unit, "behavior_system")
	local should_hold_position = params.should_hold_position

	if should_hold_position then
		local navigation_extension = ScriptUnit.extension(player_unit, "navigation_system")
		local nav_world = navigation_extension:nav_world()
		local traverse_logic = navigation_extension:traverse_logic()
		local hold_position = params.position or POSITION_LOOKUP[player_unit]
		local hold_position_on_nav_mesh = NavQueries.position_on_mesh(nav_world, hold_position, HOLD_POSITION_NAV_ABOVE, HOLD_POSITION_NAV_BELOW, traverse_logic)

		if hold_position_on_nav_mesh then
			local max_distance = params.max_allowed_distance_from_position or 0

			behavior_extension:set_hold_position(hold_position_on_nav_mesh, max_distance)
		else
			Log.warning("FlowCallbacks", "%s could not hold position %s since it is not near nav mesh!", player_unit, tostring(hold_position))
		end
	else
		behavior_extension:set_hold_position(nil)
	end
end

function FlowCallbacks.local_player_archetype_name(params)
	local local_player = Managers.player:local_player(1)

	if not local_player then
		return
	end

	local profile = local_player:profile()
	flow_return_table.archetype_name = profile.archetype.name

	return flow_return_table
end

function FlowCallbacks.prologue_local_player_equip_slot(params)
	local slot_name = params.slot_name
	local local_player = Managers.player:local_player(1)
	local player_unit = local_player.player_unit
	local profile = local_player:profile()
	local visual_loadout = profile.visual_loadout
	local item = visual_loadout[slot_name]
	local fixed_t = FixedFrame.get_latest_fixed_time()

	PlayerUnitVisualLoadout.equip_item_to_slot(player_unit, item, slot_name, nil, fixed_t)
	PlayerUnitVisualLoadout.wield_slot(slot_name, player_unit, fixed_t)
end

function FlowCallbacks.prologue_local_player_wield_slot(params)
	local slot_name = params.slot_name
	local local_player = Managers.player:local_player(1)
	local player_unit = local_player.player_unit
	local fixed_t = FixedFrame.get_latest_fixed_time()

	PlayerUnitVisualLoadout.wield_slot(slot_name, player_unit, fixed_t)
end

function FlowCallbacks.get_peer_id_from_unit(params)
	local player_unit_manager = Managers.state.player_unit_spawn
	local player = player_unit_manager:owner(params.player_unit)

	if player then
		flow_return_table.peer_id = player:peer_id()
	end

	return flow_return_table
end

function FlowCallbacks.create_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_create_story(params.node_id)
end

function FlowCallbacks.has_stopped_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_has_stopped_networked_story(params.node_id)
end

function FlowCallbacks.has_played_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_has_played_networked_story(params.node_id, params.story_id)
end

function FlowCallbacks.play_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_play_networked_story(params.client_call_event_name, params.start_time, params.start_from_stop_time, params.node_id)
end

function FlowCallbacks.stop_networked_story(params)
	return Managers.state.networked_flow_state:flow_cb_stop_networked_story(params.node_id)
end

function FlowCallbacks.complete_game_mode(params)
	local triggered_from_flow = true

	Managers.state.game_mode:complete_game_mode(params.reason, triggered_from_flow)
end

function FlowCallbacks.fail_game_mode(params)
	Managers.state.game_mode:fail_game_mode(params.reason)
end

function FlowCallbacks.set_difficulty(params)
	if params.challenge then
		Managers.state.difficulty:set_challenge(params.challenge)
	end

	if params.resistance then
		Managers.state.difficulty:set_resistance(params.resistance)
	end
end

function FlowCallbacks.is_difficulty(params)
	local wanted_difficulty = params.wanted_difficulty

	if Managers.state.difficulty:get_initial_challenge() == wanted_difficulty then
		flow_return_table.is_difficulty = true

		return flow_return_table
	end

	flow_return_table.is_difficulty = false

	return flow_return_table
end

function FlowCallbacks.open_view(params)
	local view_name = params.view_name
	local transition_time = params.transition_time
	local close_previous = params.close_previous
	local close_all = params.close_all
	local ui_manager = Managers.ui

	if ui_manager then
		ui_manager:open_view(view_name, transition_time, close_previous, close_all)
	end
end

function FlowCallbacks.trigger_lua_event(params)
	local event = params.event
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event)
	end
end

function FlowCallbacks.trigger_lua_unit_event(params)
	local event = params.event
	local unit = params.unit
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event, unit)
	end
end

function FlowCallbacks.trigger_lua_level_event(params)
	local event = params.event
	local level = params.level
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event, level)
	end
end

function FlowCallbacks.trigger_lua_level_and_unit_event(params)
	local event = params.event
	local level = params.level
	local unit = params.unit
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event, level, unit)
	end
end

function FlowCallbacks.trigger_lua_string_event(params)
	local event = params.event
	local string = params.string
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event, string)
	end
end

function FlowCallbacks.trigger_lua_integer_event(params)
	local event = params.event
	local integer = params.integer
	local event_manager = Managers.event

	if event_manager then
		event_manager:trigger(event, integer)
	end
end

function FlowCallbacks.load_mission(params)
	local new_mission_name = params.mission_name
	local mechanism_context = {
		mission_name = new_mission_name
	}
	local Missions = require("scripts/settings/mission/mission_templates")
	local mission_settings = Missions[new_mission_name]
	local mechanism_name = mission_settings.mechanism_name
	local game_mode_name = mission_settings.game_mode_name
	local game_mode_settings = GameModeSettings[game_mode_name]

	if game_mode_settings.host_singleplay then
		Managers.multiplayer_session:reset("Hosting singleplay mission from flow")
		Managers.multiplayer_session:boot_singleplayer_session()
	end

	Managers.mechanism:change_mechanism(mechanism_name, mechanism_context)
	Managers.mechanism:trigger_event("all_players_ready")
end

function FlowCallbacks.flow_callback_trigger_dialogue_event(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source

	if ScriptUnit.has_extension(unit, "dialogue_system") then
		local dialogue_extension = ScriptUnit.extension(unit, "dialogue_system")
		local event_table = flow_return_table

		if params.argument1_name then
			event_table[params.argument1_name] = tonumber(params.argument1) or params.argument1
		end

		if params.argument2_name then
			event_table[params.argument2_name] = tonumber(params.argument2) or params.argument2
		end

		if params.argument3_name then
			event_table[params.argument3_name] = tonumber(params.argument3) or params.argument3
		end

		dialogue_extension:trigger_dialogue_event(params.concept, event_table, params.identifier)
	end
end

function FlowCallbacks.trigger_player_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source
	local trigger_id = params.trigger_id

	Vo.generic_mission_vo_event(unit, trigger_id)
end

function FlowCallbacks.trigger_random_player_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local trigger_id = params.trigger_id
	local random_player_unit = nil
	local side_system = Managers.state.extension:system("side_system")
	local side_name = side_system:get_default_player_side_name()
	local side = side_system:get_side_from_name(side_name)
	local players = side:added_player_units()
	local unit_list = {}
	local unit_list_n = 0

	for i = 1, #players do
		local unit = players[i]

		if HEALTH_ALIVE[unit] then
			unit_list_n = unit_list_n + 1
			unit_list[unit_list_n] = unit
		end
	end

	if unit_list_n > 0 then
		random_player_unit = unit_list[math.random(1, unit_list_n)]
	end

	Vo.generic_mission_vo_event(random_player_unit, trigger_id)
end

function FlowCallbacks.trigger_player_vo_all(params)
	local trigger_id = params.trigger_id

	Vo.generic_mission_vo_event_all_players(trigger_id)
end

function FlowCallbacks.trigger_mission_giver_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local voice_over_spawn_manager = Managers.state.voice_over_spawn
		local voice_profile = params.voice_profile
		local unit = voice_over_spawn_manager:voice_over_unit(voice_profile)
		local trigger_id = params.concept

		Vo.mission_giver_mission_info(unit, trigger_id)
	end
end

function FlowCallbacks.trigger_mission_info_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local voice_over_spawn_manager = Managers.state.voice_over_spawn
		local voice_profile = params.voice_profile
		local unit = voice_over_spawn_manager:voice_over_unit(voice_profile)
		local trigger_id = params.trigger_id

		Vo.mission_giver_mission_info(unit, trigger_id)
	end
end

function FlowCallbacks.trigger_mission_giver_mission_info_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local voice_selection = params.voice_selection
		local selected_voice = params.selected_voice
		local trigger_id = params.trigger_id

		Vo.mission_giver_mission_info_vo(voice_selection, selected_voice, trigger_id)
	end
end

function FlowCallbacks.trigger_mission_giver_mission_info_backend_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local backend_group_id = params.backend_group_id

		Vo.backend_vo_event(backend_group_id)
	end
end

function FlowCallbacks.trigger_save_backend_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		Vo.save_backend_vo()
	end
end

function FlowCallbacks.play_next_backend_vo(params)
	local backend_group_id = params.backend_group_id
	local optional_substring = params.optional_substring
	local last_line = Vo.play_next_backend_vo(backend_group_id, optional_substring)
	flow_return_table.last_line = last_line

	return flow_return_table
end

function FlowCallbacks.substring_exists_in_backend_vo(params)
	local backend_group_id = params.backend_group_id
	local substring = params.substring
	local exists = Vo.substring_exists_in_backend_vo(backend_group_id, substring)

	if exists then
		flow_return_table.exists = true
		flow_return_table.not_exists = false
	else
		flow_return_table.exists = false
		flow_return_table.not_exists = true
	end

	return flow_return_table
end

function FlowCallbacks.trigger_confessional_vo_event(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local unit = params.source
		local category = params.category

		Vo.confessional_vo_event(unit, category)
	end
end

function FlowCallbacks.trigger_npc_vo_event(params)
	local unit = params.source
	local vo_event = params.vo_event
	local is_interaction_vo = params.is_interaction_vo or false
	local interacting_unit = params.interacting_unit
	local cooldown_time = params.cooldown_time
	local play_in = params.play_in

	if is_interaction_vo then
		Vo.play_npc_interacting_vo_event(unit, interacting_unit, vo_event, cooldown_time, play_in)
	else
		Vo.play_npc_vo_event(unit, vo_event)
	end
end

function FlowCallbacks.trigger_mission_giver_conversation_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local voice_over_spawn_manager = Managers.state.voice_over_spawn
		local voice_profile = params.voice_profile
		local unit = voice_over_spawn_manager:voice_over_unit(voice_profile)
		local trigger_id = params.trigger_id

		Vo.mission_giver_conversation_starter(unit, trigger_id)
	end
end

function FlowCallbacks.trigger_story_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source
	local story = params.story

	Vo.environmental_story_vo_event(unit, story)
end

function FlowCallbacks.trigger_cutscene_vo(params)
	local unit = params.source
	local vo_line_id = params.vo_line_id

	Vo.cutscene_vo_event(unit, vo_line_id)
end

function FlowCallbacks.trigger_local_vo_event(params)
	local unit = params.source
	local rule_name = params.rule_name
	local wwise_route_key = params.wwise_route_key
	local opinion_vo = params.opinion_vo
	local use_radio_pre = params.use_radio_pre
	local use_radio_post = params.use_radio_post

	Vo.play_local_vo_event(unit, rule_name, wwise_route_key, nil, opinion_vo, use_radio_pre, use_radio_post)
end

function FlowCallbacks.trigger_on_demand_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source
	local trigger_id = params.trigger_id

	Vo.on_demand_vo_event(unit, trigger_id)
end

function FlowCallbacks.trigger_start_banter_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source

	Vo.start_banter_vo_event(unit)
end

function FlowCallbacks.trigger_enemy_generic_vo(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.source
	local trigger_id = params.trigger_id
	local breed_name = params.breed_name

	Vo.enemy_generic_vo_event(unit, trigger_id, breed_name)
end

function FlowCallbacks.set_player_vo_story_stage(params)
	local story_stage = params.story_stage

	PlayerVoStoryStage.set_story_stage(story_stage)
end

function FlowCallbacks.set_story_ticker(params)
	local story_ticker = params.story_ticker

	Vo.set_story_ticker(story_ticker)
end

function FlowCallbacks.set_ignore_server_play_requests(params)
	local ignore_server = params.ignore_server

	Vo.set_ignore_server_play_requests(ignore_server)
end

function FlowCallbacks.set_unit_vo_memory(params)
	local unit = params.unit
	local memory_type = params.memory_type
	local memory_id = params.memory_id
	local value = params.value

	Vo.set_unit_vo_memory(unit, memory_type, memory_id, value)
end

function FlowCallbacks.mission_giver_check(params)
	Vo.mission_giver_check_event()
end

function FlowCallbacks.stop_unit_vo(params)
	local unit = params.source

	Vo.stop_currently_playing_vo(unit)
end

function FlowCallbacks.stop_all_vo(params)
	Vo.stop_all_currently_playing_vo()
end

function FlowCallbacks.is_currently_playing_dialogue(params)
	local unit = params.source
	local is_playing = Vo.is_currently_playing_dialogue(unit)

	if is_playing then
		flow_return_table.vo_playing = true
	else
		flow_return_table.vo_not_playing = true
	end

	return flow_return_table
end

function FlowCallbacks.trigger_subtitle(params)
	local subtitle_id = params.subtitle_id

	Vo.trigger_subtitle(subtitle_id)
end

function FlowCallbacks.spawn_2d_vo_unit(params)
	local breed_name = params.breed_name

	Vo.spawn_2d_unit(breed_name)
end

function FlowCallbacks.spawn_3d_vo_unit(params)
	local breed_name = params.breed_name
	local voice_profile = params.voice_profile
	local position = params.position
	local vo_unit = Vo.spawn_3d_unit(breed_name, voice_profile, position)
	flow_return_table.unit = vo_unit

	return flow_return_table
end

function FlowCallbacks.set_unit_voice_profile(params)
	local unit = params.unit
	local voice_profile = params.voice_profile
	local dialogue_extension = ScriptUnit.has_extension(unit, "dialogue_system")

	if dialogue_extension then
		dialogue_extension:set_vo_profile(voice_profile)
	end
end

function FlowCallbacks.is_mission_active(params)
	local mission_name = params.mission_name
	flow_return_table.active = Vo.is_mission_available(mission_name)

	return flow_return_table
end

function FlowCallbacks.start_terror_event(params)
	local terror_event_manager = Managers.state.terror_event

	if terror_event_manager then
		local event_name = params.event_name
		local optional_level = params.optional_level

		terror_event_manager:start_event(event_name, nil, optional_level)
	end
end

function FlowCallbacks.stop_terror_event(params)
	local terror_event_manager = Managers.state.terror_event

	if terror_event_manager then
		local event_name = params.event_name

		terror_event_manager:stop_event(event_name)
	end
end

function FlowCallbacks.start_random_terror_event(params)
	local terror_event_manager = Managers.state.terror_event

	if terror_event_manager then
		local event_chunk_name = params.event_chunk_name

		terror_event_manager:start_random_event(event_chunk_name)
	end
end

function FlowCallbacks.change_spawner_groups_terror_event(params)
	local is_server = Managers.state.game_session:is_server()

	if is_server then
		local unit = params.unit
		local new_spawner_group_names = params.new_spawner_group_names
		local spawner_group_names = nil

		if new_spawner_group_names then
			spawner_group_names = string.split_and_trim(new_spawner_group_names, ",")
		end

		local minion_spawner_system = Managers.state.extension:system("minion_spawner_system")

		minion_spawner_system:change_spawner_group_names(unit, spawner_group_names)
	end
end

function FlowCallbacks.get_crossroad_road_id(params)
	local crossroads_id = params.crossroads_id
	local main_path_manager = Managers.state.main_path
	local chosen_road_id = main_path_manager:crossroad_road_id(crossroads_id)
	flow_return_table.road_id = chosen_road_id

	return flow_return_table
end

function FlowCallbacks.spawn_network_unit(params)
	local unit_name = params.unit_name
	local template_name = params.template_name
	local position = params.position
	local rotation = params.rotation
	local unit_spawner = Managers.state.unit_spawner

	if unit_spawner ~= nil then
		flow_return_table.unit = unit_spawner:spawn_network_unit(unit_name, template_name, position, rotation)
	end

	return flow_return_table
end

function FlowCallbacks.register_extensions(params)
	local unit = params.unit
	local world = Application.flow_callback_context_world()

	if Managers.state.extension ~= nil then
		Managers.state.extension:register_unit(world, unit, "flow_spawned")
	end
end

function FlowCallbacks.delete_extension_registered_unit(params)
	local unit = params.unit

	if Managers.state.unit_spawner ~= nil then
		Managers.state.unit_spawner:mark_for_deletion(unit)
	end
end

function FlowCallbacks.debug_print_world_text(params)
	local text = params.text_id or "no text id"
	local size = params.text_size
	local tc = params.text_color
	local color = tc and Color(tc.x, tc.y, tc.z)
	local time = params.time
	local res_x, res_y = Application.back_buffer_size()
	local text_position = Vector3(res_x / 2, res_y / 2, 1)
	local background = params.background
	local options = {
		text_vertical_alignment = "center",
		text_horizontal_alignment = "center",
		text_size = size,
		text_color = color,
		time = time,
		position = text_position,
		background = background
	}
end

function FlowCallbacks.switchcase(params)
	local ret = {}
	local outStr = "out"

	if params.case ~= "" then
		for k, v in pairs(params) do
			if k ~= "case" and k ~= "node_id" and params.case == v then
				ret[outStr .. string.sub(k, 6, -1)] = true
			end
		end
	end

	return ret
end

function FlowCallbacks.camera_shake(params)
	local source_unit = params.shake_unit

	if not source_unit or not unit_alive(source_unit) then
		return
	end

	local position = Unit.local_position(source_unit, 1)

	CameraShake.camera_shake_by_distance(params.shake_name, position, params.near_distance, params.far_distance, params.near_shake_scale, params.far_shake_scale)
end

function FlowCallbacks.add_timed_mood_to_players(params)
	local mood_type = params.mood_type
	local t = Managers.time:time("gameplay")
	local player_manager = Managers.player
	local players = player_manager:human_players()

	if mood_type then
		for unique_id, player in pairs(players) do
			local unit = player.player_unit
			local mood_extension = ScriptUnit.has_extension(unit, "mood_system")

			if mood_extension then
				mood_extension:add_timed_mood(t, mood_type)
			end
		end
	end
end

function FlowCallbacks.remove_mood_from_players(params)
	local mood_type = params.mood_type
	local t = Managers.time:time("gameplay")
	local player_manager = Managers.player
	local players = player_manager:human_players()

	if mood_type then
		for unique_id, player in pairs(players) do
			local unit = player.player_unit
			local mood_extension = ScriptUnit.has_extension(unit, "mood_system")

			if mood_extension then
				mood_extension:remove_mood(t, mood_type)
			end
		end
	end
end

function FlowCallbacks.script_data_set_unit(params)
	local my_unit = params.my_unit
	local script_data_unit = params.script_data_unit
	local script_data_name = params.script_data_name

	if not unit_alive(script_data_unit) then
		return
	end

	local i = 1

	while Unit.has_data(my_unit, script_data_name, i) do
		i = i + 1
	end

	Unit.set_data(my_unit, script_data_name, i, script_data_unit)
end

function FlowCallbacks.register_objective_unit(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_register_objective_unit(params.objective_name, params.objective_unit)
	end
end

function FlowCallbacks.teleport_payload(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local unit = params.payload

	if ScriptUnit.has_extension(unit, "payload_system") then
		local payload_extension = ScriptUnit.extension(unit, "payload_system")

		payload_extension:teleport_to_node(params.path, params.node)
	end
end

function FlowCallbacks.start_mission_objective(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_start_mission_objective(params.objective_name)
	end
end

function FlowCallbacks.update_mission_objective(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_update_mission_objective(params.objective_name)
	end
end

function FlowCallbacks.end_mission_objective(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_end_mission_objective(params.objective_name)
	end
end

function FlowCallbacks.start_side_mission_objective(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local side_mission = Managers.state.mission:side_mission()

		if side_mission then
			local objective_name = side_mission.name
			local mission_objective_system = Managers.state.extension:system("mission_objective_system")

			mission_objective_system:flow_callback_start_mission_objective(objective_name)
		else
			Log.warning("FlowCallbacks", "side_mission(%s) not defined.", tostring(Managers.state.mission:side_mission_name()))
		end
	end
end

function FlowCallbacks.mission_objective_override_ui_string(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local new_ui_header = params.new_ui_header
		local new_ui_description = params.new_ui_description
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_override_ui_string(objective_name, new_ui_header, new_ui_description)
	end
end

function FlowCallbacks.mission_objective_reset_override_ui_string(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_override_ui_string(objective_name, "empty_objective_string", "empty_objective_string")
	end
end

function FlowCallbacks.mission_objective_show_ui(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local show = params.show
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_set_objective_show_ui(objective_name, show)
	end
end

function FlowCallbacks.mission_objective_set_ui_state(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local state = params.state
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_set_objective_ui_state(objective_name, state)
	end
end

function FlowCallbacks.mission_objective_increment(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local amount = params.amount
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:external_update_mission_objective(objective_name, 0, amount)
	end
end

function FlowCallbacks.mission_objective_show_counter(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local show = params.show_counter
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_set_objective_show_counter(objective_name, show)
	end
end

function FlowCallbacks.mission_objective_show_bar(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local show = params.show_bar
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_set_objective_show_bar(objective_name, show)
	end
end

function FlowCallbacks.mission_objective_show_timer(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if is_server then
		local objective_name = params.mission_objective_name
		local show = params.show_timer
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")

		mission_objective_system:flow_callback_set_objective_show_timer(objective_name, show)
	end
end

local function _teleport_player_companion(player, destination_position)
	local player_unit = player.player_unit
	local companion_spawner_extension = ScriptUnit.extension(player_unit, "companion_spawner_system")
	local companion_unit = companion_spawner_extension:companion_unit()

	if companion_unit and ALIVE[companion_unit] then
		local companion_blackboard = BLACKBOARDS[companion_unit]

		if companion_blackboard then
			local teleport_component = Blackboard.write_component(companion_blackboard, "teleport")

			teleport_component.teleport_position:store(destination_position)

			teleport_component.has_teleport_position = true
		end
	end
end

function FlowCallbacks.teleport_team_to_locations(params)
	if not Managers.state.game_session:is_server() then
		return
	end

	local destination_units = {}

	for par, val in pairs(params) do
		if string.find(par, "destination_unit") then
			destination_units[#destination_units + 1] = val
		end
	end

	local num_destinations = #destination_units
	local player_manager = Managers.player
	local players = player_manager:human_players()
	local index = 0
	local local_player = player_manager:local_player(1)

	for unique_id, player in pairs(players) do
		if player and player.player_unit then
			index = index % num_destinations + 1
			local unit = destination_units[index]
			local position = Unit.world_position(unit, 1)
			local local_rotation = Unit.local_rotation(unit, 1)
			local look_direction_flat_forward = Vector3.normalize(Vector3.flat(Quaternion.forward(local_rotation)))

			if Vector3.length_squared(look_direction_flat_forward) == 0 then
				look_direction_flat_forward = Vector3.forward()
			end

			local target_rotation = Quaternion.look(look_direction_flat_forward, Vector3.up())

			PlayerMovement.teleport(player, position, target_rotation)
			_teleport_player_companion(player, position)

			local channel_id = player:channel_id()
			local pitch = Quaternion.pitch(target_rotation)
			local yaw = Quaternion.yaw(target_rotation)
			local roll = 0

			if (DEDICATED_SERVER or local_player:peer_id() ~= player:peer_id()) and channel_id then
				RPC.rpc_client_set_local_player_orientation(channel_id, yaw, pitch, roll)
			elseif local_player:peer_id() == player:peer_id() then
				local_player:set_orientation(yaw, pitch, roll)
			end
		end
	end

	Managers.event:trigger("players_teleported")
end

function FlowCallbacks.rotate_team_with_units(params)
	if Managers.state.game_session:is_server() then
		return
	end

	local local_player = Managers.player:local_player(1)
	local local_player_unit = local_player and local_player.player_unit

	if not local_player_unit then
		return
	end

	local rotation_units = {}

	for par, val in pairs(params) do
		if string.find(par, "rotation_unit") then
			rotation_units[#rotation_units + 1] = val
		end
	end

	local unit = rotation_units[1]
	local rotation = Unit.world_rotation(unit, 1)
	local t = Managers.time:time("gameplay")
	local unit_data = ScriptUnit.extension(local_player_unit, "unit_data_system")
	local locomotion_force_rotation_component = unit_data:write_component("locomotion_force_rotation")
	local locomotion_steering_component = unit_data:write_component("locomotion_steering")

	ForceRotation.start(locomotion_force_rotation_component, locomotion_steering_component, rotation, rotation, t, 0)

	local pitch = Quaternion.pitch(rotation)
	local yaw = Quaternion.yaw(rotation)

	local_player:set_orientation(yaw, pitch, 0)
end

function FlowCallbacks.teleport_player_by_local_id(params)
	if not Managers.state.game_session:is_server() then
		return
	end

	local destination_units = {}

	for par, val in pairs(params) do
		if string.find(par, "player_id") then
			local destination_par = "destination_unit" .. string.sub(par, string.find(par, "id") + 2, #par)
			destination_units[val] = params[destination_par]
		end
	end

	local player_manager = Managers.player
	local players = player_manager:players()

	for unique_id, player in pairs(players) do
		local id = tostring(player:local_player_id())
		local unit = destination_units[id]

		if unit and player and player.player_unit then
			local position = Unit.world_position(unit, 1)
			local rotation = Unit.world_rotation(unit, 1)

			PlayerMovement.teleport(player, position, rotation)
		end
	end
end

local function _distance(start_unit, end_unit)
	local start_position = Unit.world_position(start_unit, 1)
	local end_position = Unit.world_position(end_unit, 1)

	return Vector3.distance(start_position, end_position)
end

function FlowCallbacks.closest_alive_player(params)
	local player_manager = Managers.player
	local players = player_manager:players()
	local tracked_units = {}

	for unique_id, player in pairs(players) do
		if player:unit_is_alive() then
			tracked_units[#tracked_units + 1] = player.player_unit
		end
	end

	local lowest_distance = math.huge

	for i = 1, #tracked_units do
		local distance = _distance(tracked_units[i], params.location_unit)

		if distance < lowest_distance then
			lowest_distance = distance
			flow_return_table.player_unit = tracked_units[i]
		end
	end

	return flow_return_table
end

function FlowCallbacks.is_player_near(params)
	local player_manager = Managers.player
	local players = player_manager:players()
	local location_unit = params.location_unit
	local distance = params.distance
	flow_return_table.is_player_near = false

	for unique_id, player in pairs(players) do
		if player:unit_is_alive() and _distance(player.player_unit, location_unit) <= distance then
			flow_return_table.is_player_near = true

			return flow_return_table
		end
	end

	return flow_return_table
end

function FlowCallbacks.random_player_alive(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local side_name = params.side_name
	local side_system = Managers.state.extension:system("side_system")
	local side = side_system:get_side_from_name(side_name)
	local player_unit_spawn_manager = Managers.state.player_unit_spawn
	local alive_players = table.shallow_copy(player_unit_spawn_manager:alive_players())

	for i = #alive_players, 1, -1 do
		local player = alive_players[i]

		if not side.units_lookup[player.player_unit] then
			table.remove(alive_players, i)
		end
	end

	flow_return_table.player_unit = nil
	local num_alive_players = table.size(alive_players)

	if num_alive_players > 0 then
		local random_index = math.random(1, num_alive_players)
		local random_player = alive_players[random_index]
		flow_return_table.player_unit = random_player.player_unit
	end

	return flow_return_table
end

function FlowCallbacks.camera_set_far_range(params)
	local camera_manager = Managers.state.camera
	local local_player = Managers.player:local_player(1)

	if not local_player then
		return
	end

	local viewport_name = local_player.viewport_name
	local camera = camera_manager:camera(viewport_name)
	local far_range = params.far_range

	Camera.set_data(camera, "far_range", far_range)
end

function FlowCallbacks.camera_reset_far_range(params)
	local camera_manager = Managers.state.camera
	local local_player = Managers.player:local_player(1)

	if not local_player then
		return
	end

	local viewport_name = local_player.viewport_name
	local camera = camera_manager:camera(viewport_name)

	Camera.set_data(camera, "far_range", nil)
end

function FlowCallbacks.get_unit_from_item_slot(params)
	local unit = params.unit
	local slot_name = params.slot
	local slot_unit = nil
	local component_system = Managers.state.extension:system("component_system")
	local player_customization_components = component_system:get_components(unit, "PlayerCustomization")

	if table.size(player_customization_components) == 1 then
		slot_unit = player_customization_components[1]:unit_in_slot(slot_name)
	end

	if not unit_alive(slot_unit) then
		local cutscene_character_extension = ScriptUnit.fetch_component_extension(unit, "cutscene_character_system")

		if cutscene_character_extension then
			slot_unit = cutscene_character_extension:unit_3p_from_slot(slot_name)
		end
	end

	if unit_alive(slot_unit) then
		flow_return_table.slot_unit = slot_unit
	else
		Log.error("FlowCallbacks", "[get_unit_from_item_slot] missing 'slot_unit' for (unit: %s, slot_name: %s). Returning the owner unit.", unit, slot_name)
	end

	return flow_return_table
end

function FlowCallbacks.minion_check_velocity_threshold(params)
	local unit = params.unit
	local threshold = params.threshold
	local locomotion_extension = ScriptUnit.has_extension(unit, "locomotion_system")

	if not locomotion_extension then
		return
	end

	local current_velocity = locomotion_extension:current_velocity()
	local move_speed = Vector3.length(current_velocity)
	flow_return_table.is_at_or_above = threshold <= move_speed

	return flow_return_table
end

function FlowCallbacks.render_static_shadows(params)
	local world_name = "level_world"

	if Managers.world:has_world(world_name) then
		local world = Managers.world:world(world_name)

		World.set_data(world, "shadow_baked", false)
	end
end

function FlowCallbacks.light_controller_set_light_flicker_config(params)
	local unit = params.unit
	local flicker_configuration = params.flicker_configuration
	local extension = ScriptUnit.extension(unit, "light_controller_system")
	local flicker_enabled = extension:is_flicker_enabled()

	extension:set_flicker_state(flicker_enabled, flicker_configuration, false)
end

function FlowCallbacks.is_circumstance_active(params)
	local circumstance_name = params.circumstance_name
	local active_circumstance_name = Managers.state.circumstance:circumstance_name()
	flow_return_table.active = active_circumstance_name == circumstance_name

	return flow_return_table
end

function FlowCallbacks.is_theme_active(params)
	local theme_tag = params.theme_tag
	local active_theme_tag = Managers.state.circumstance:active_theme_tag()
	flow_return_table.active = active_theme_tag == theme_tag

	return flow_return_table
end

function FlowCallbacks.get_render_config(params)
	local type = params.type
	local variable = params.variable
	flow_return_table.enabled = Application.render_config(type, variable, false)

	return flow_return_table
end

function FlowCallbacks.make_respawn_point_priority(params)
	local respawn_beacon_system = Managers.state.extension:system("respawn_beacon_system")
	local respawn_beacon = params.respawn_beacon

	respawn_beacon_system:make_respawn_beacon_priority(respawn_beacon)
end

function FlowCallbacks.remove_respawn_point_priority(params)
	local respawn_beacon_system = Managers.state.extension:system("respawn_beacon_system")

	respawn_beacon_system:remove_respawn_beacon_priority()
end

function FlowCallbacks:spawn_unit(unit)
	return
end

function FlowCallbacks:unspawn_unit(unit)
	local extension_manager = Managers.state.extension
	local registered_units = extension_manager and extension_manager:units()
end

function FlowCallbacks.empty(params)
	return
end

function FlowCallbacks.start_scripted_scenario(params)
	local scenario_alias = params.scenario_alias
	local scenario_name = params.scenario_name
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")

	if not scenario_system then
		Log.error("FlowCallbacks", "ScriptedScenarioSystem is not initiated.")

		return
	end

	local t = Managers.time:time("gameplay")

	scenario_system:start_scenario(scenario_alias, scenario_name, t)
end

function FlowCallbacks.start_parallel_scripted_scenario(params)
	local scenario_alias = params.scenario_alias
	local scenario_name = params.scenario_name
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")

	if not scenario_system then
		Log.error("FlowCallbacks", "ScriptedScenarioSystem is not initiated.")

		return
	end

	local t = Managers.time:time("gameplay")

	scenario_system:start_parallel_scenario(scenario_alias, scenario_name, t)
end

function FlowCallbacks.spawn_scripted_scenario_group(params)
	local spawn_group_name = params.spawn_group_name
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")

	scenario_system:spawn_attached_units_in_spawn_group(spawn_group_name)
end

function FlowCallbacks.despawn_scripted_scenario_group(params)
	local spawn_group_name = params.spawn_group_name
	local scenario_system = Managers.state.extension:system("scripted_scenario_system")

	scenario_system:unspawn_attached_units_in_spawn_group(spawn_group_name)
end

function FlowCallbacks.training_grounds_servitor_interact()
	Managers.event:trigger("tg_servitor_interact")
end

local SPEED_EPSILON = 0.001

function FlowCallbacks.projectile_locomotion_engine_collision(params)
	local impulse_force = params.impulse_force
	local actor = params.actor
	local mass = Actor.mass(actor)
	local delta_velocity = impulse_force / mass
	local post_collision_velocity = Actor.velocity(actor)
	local pre_collision_velocity = post_collision_velocity - delta_velocity
	local speed = Vector3.length(pre_collision_velocity)

	if SPEED_EPSILON < speed then
		local unit = params.unit
		local collision_direction = Vector3.normalize(pre_collision_velocity)
		local collision_position = params.collision_position
		local collision_actor = params.collision_actor
		local collision_normal = params.collision_normal
		local collision_unit = Actor.unit(collision_actor)
		local projectile_damage_extension = ScriptUnit.has_extension(unit, "projectile_damage_system")

		if projectile_damage_extension then
			projectile_damage_extension:on_impact(collision_position, collision_unit, collision_actor, collision_direction, collision_normal, speed)
		end

		local fx_extension = ScriptUnit.has_extension(unit, "fx_system")

		if fx_extension then
			fx_extension:on_impact(collision_position, collision_unit, collision_direction, collision_normal, speed)
		end
	end
end

function FlowCallbacks.get_current_mission(params)
	local mission_name = Managers.state.mission:mission_name()
	flow_return_table.mission_name = mission_name
	flow_return_table.out = true
	flow_return_table[mission_name] = true

	return flow_return_table
end

function FlowCallbacks.set_backfill_wanted(params)
	if Managers.mission_server then
		Managers.mission_server:set_backfill_wanted(params.enabled or false)
	end
end

function FlowCallbacks.is_dedicated_server(params)
	flow_return_table.is_dedicated_server = DEDICATED_SERVER

	return flow_return_table
end

function FlowCallbacks.local_player_level(params)
	local local_player_id = 1
	local local_player = Managers.player:local_player(local_player_id)
	local profile = local_player:profile()
	local level = profile.current_level
	flow_return_table.level = level

	return flow_return_table
end

function FlowCallbacks.local_player_level_larger_than(params)
	local local_player_id = 1
	local local_player = Managers.player:local_player(local_player_id)
	local profile = local_player:profile()
	local level = profile.current_level
	local target_level = params.target_level
	flow_return_table.level_larger_than = target_level <= level

	return flow_return_table
end

function FlowCallbacks.new_path_of_trust(params)
	local event_name = "none"
	local chapter = Managers.narrative:current_chapter(Managers.narrative.STORIES.path_of_trust)

	if chapter then
		event_name = chapter.name
	end

	flow_return_table[event_name] = true

	return flow_return_table
end

function FlowCallbacks.new_path_of_trust_viewed(params)
	Managers.narrative:complete_current_chapter(Managers.narrative.STORIES.path_of_trust)
end

function FlowCallbacks.hook_stat_team(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	Managers.stats:record_team(params.hook_id)
end

function FlowCallbacks.live_event_check(params)
	flow_return_table.event_active = false
	flow_return_table.event_progress = 0
	local template = Managers.live_event:active_template()

	if template then
		local id = template.id

		if params.event_name == id then
			local progress = Managers.live_event:active_progress()
			flow_return_table.event_active = true
			flow_return_table.event_progress = progress
		end
	end

	return flow_return_table
end

function FlowCallbacks.unlock_achievement_everyone(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local players = Managers.player:players()

	for peer_id, player in pairs(players) do
		Managers.achievements:unlock_achievement(player, params.achievement_id)
	end
end

function FlowCallbacks.unlock_achievement_player(params)
	local is_server = Managers.state.game_session:is_server()

	if params.player_unit and not is_server then
		return
	end

	local player = Managers.player:player_by_unit(params.player_unit)

	if player then
		Managers.achievements:unlock_achievement(player, params.achievement_id)
	end
end

function FlowCallbacks.is_narrative_event_completed(params)
	local event_name = params.event_name
	flow_return_table.event_completed = Managers.narrative:is_event_complete(event_name)

	return flow_return_table
end

function FlowCallbacks.is_narrative_event_completable(params)
	local event_name = params.event_name
	flow_return_table.event_completed = Managers.narrative:can_complete_event(event_name)

	return flow_return_table
end

function FlowCallbacks.complete_narrative_event(params)
	local event_name = params.event_name

	Managers.narrative:complete_event(event_name)
end

function FlowCallbacks.is_narrative_chapter_completed(params)
	local story_name = params.story_name
	local chapter_name = params.chapter_name
	flow_return_table.chapter_completed = Managers.narrative:is_chapter_complete(story_name, chapter_name)

	return flow_return_table
end

function FlowCallbacks.complete_narrative_chapter(params)
	local story_name = params.story_name
	local chapter_name = params.chapter_name
	flow_return_table.success = Managers.narrative:complete_current_chapter(story_name, chapter_name)

	return flow_return_table
end

function FlowCallbacks.delete_impact_fx_unit(params)
	local unit = params.unit
	local extension_manager = Managers.state and Managers.state.extension
	local fx_system = extension_manager and extension_manager:system("fx_system")

	if fx_system then
		fx_system:delete_impact_fx_unit(unit)
	end
end

function FlowCallbacks.leave_shooting_range(params)
	Managers.event:trigger("leave_shooting_range")
end

function FlowCallbacks.any_player_has_achievement_completed(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local required_achievement = params.required_achievement
	local player_manager = Managers.player
	local players = player_manager:human_players()

	for unique_id, player in pairs(players) do
		local completed = Managers.achievements:achievement_completed(player, required_achievement)

		if completed then
			flow_return_table.required_achievement_completed = true

			return flow_return_table
		end
	end

	flow_return_table.required_achievement_completed = false

	return flow_return_table
end

function FlowCallbacks.set_actor_scene_query_enabled(params)
	local actor = params.actor
	local enabled = params.enabled

	Actor.set_scene_query_enabled(actor, enabled)
end

function FlowCallbacks.aggro_all_within_radius(params)
	local is_server = Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local pacing_manager = Managers.state.pacing
	local position = params.worldposition
	local radius = params.radius

	pacing_manager:aggro_all_within_radius(position, radius)
end

function FlowCallbacks.mission_buffs_send_family_selection(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	local num_choices = params.num_choices > 0 and params.num_choices or 3

	Managers.event:trigger("mission_buffs_event_request_family_buff_choice", num_choices)
end

function FlowCallbacks.mission_buffs_send_family_buff_to_all(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if not is_server then
		return
	end
end

function FlowCallbacks.mission_buffs_send_legendary_buff_selection(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if not is_server then
		return
	end
end

function FlowCallbacks.hordes_mode_wave_start(params)
	Managers.event:trigger("hordes_mode_on_wave_started", params.wave_num)
end

function FlowCallbacks.hordes_mode_objective_completed(params)
	local is_server = Managers.state.game_session and Managers.state.game_session:is_server()

	if not is_server then
		return
	end

	Managers.event:trigger("hordes_mode_on_objective_completed", params.wave_num)
end

function FlowCallbacks.hordes_mode_wave_completed(params)
	Managers.event:trigger("hordes_mode_on_wave_completed", params.wave_num > 0 and params.wave_num or 1)
end

function FlowCallbacks.hordes_mode_island_entered(params)
	Managers.event:trigger("hordes_mode_on_island_entered", params.island_id)
end

function FlowCallbacks.hordes_mode_island_completed(params)
	Managers.event:trigger("hordes_mode_on_island_completed")
end

function FlowCallbacks.hordes_mode_on_mcguffin_returned(params)
	Managers.event:trigger("hordes_mode_on_mcguffin_returned")
end

function FlowCallbacks.hordes_mode_start_random_terror_event(params)
	local terror_event_manager = Managers.state.terror_event

	if terror_event_manager then
		local event_chunk_name = params.event_chunk_name
		local difficulty = Managers.state.difficulty:get_initial_challenge()
		local resistance = Managers.state.difficulty:get_initial_resistance()
		local target_terror_chunk_name = HordesModeSettings.terror_event_name_function(event_chunk_name, difficulty, resistance)

		terror_event_manager:start_random_event(target_terror_chunk_name)
	end
end

function FlowCallbacks.set_unit_material_scalar(params)
	local unit = params.unit
	local material_name = params.material_name
	local material_variable_name = params.variable_name
	local material_scalar = params.scalar or 1

	Unit.set_scalar_for_material(unit, material_name, material_variable_name, material_scalar)
end

function FlowCallbacks.pj_feature_check()
	local feature = "off"
	feature = "on"
	flow_return_table[feature] = true

	return flow_return_table
end

return FlowCallbacks
