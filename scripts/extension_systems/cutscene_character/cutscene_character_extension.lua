local Breeds = require("scripts/settings/breed/breeds")
local CinematicSceneSettings = require("scripts/settings/cinematic_scene/cinematic_scene_settings")
local CinematicSceneTemplates = require("scripts/settings/cinematic_scene/cinematic_scene_templates")
local MasterItems = require("scripts/backend/master_items")
local UIProfileSpawner = require("scripts/managers/ui/ui_profile_spawner")
local UIUnitSpawner = require("scripts/managers/ui/ui_unit_spawner")
local WeaponTemplate = require("scripts/utilities/weapon/weapon_template")
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")
local CutsceneCharacterExtension = class("CutsceneCharacterExtension")
local AnimationType = {
	Weapon = 2,
	Inventory = 1,
	None = 0
}

function CutsceneCharacterExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._extension_manager = extension_init_context.extension_manager
	self._unit = unit
	self._is_server = extension_init_context.is_server
	self._cinematic_name = CinematicSceneSettings.CINEMATIC_NAMES.none
	self._character_type = "none"
	self._breed_name = "none"
	self._companion_inclusion_setting = "any"
	self._player_unique_id = nil
	self._prop_items = {}
	self._equip_slot_on_loadout_assign = ""
	local mission_manager = Managers.state.mission
	local mission_template = mission_manager and mission_manager:mission()
	self._mission_template = mission_template
	self._is_loading_profile = false
	self._activate_post_spawn_weapon_specific_walk_animation = false
	self._activate_post_spawn_inventory_specific_walk_animation = false
	local world = extension_init_context.world
	local unit_spawner = UIUnitSpawner:new(world)
	local level_unit_id = Unit.id_string(unit)
	local camera = nil
	local force_highest_lod_step = true
	self._profile_spawner = UIProfileSpawner:new("CutsceneCharacterExtension_" .. level_unit_id, world, camera, unit_spawner, force_highest_lod_step, mission_template)
	self._inventory_animation_event = nil
	self._weapon_animation_event = nil
	self._current_state_machine = AnimationType.None
end

function CutsceneCharacterExtension:destroy()
	self._profile_spawner:destroy()

	local cutscene_character_system = self._extension_manager:system("cutscene_character_system")

	cutscene_character_system:unregister_cutscene_character(self)
end

function CutsceneCharacterExtension:setup_from_component(cinematic_name, character_type, breed_name, prop_items, slot, inventory_animation_event, equip_slot_on_loadout_assign, companion_inclusion_setting)
	self._cinematic_name = cinematic_name
	self._character_type = character_type
	self._breed_name = breed_name
	self._companion_inclusion_setting = companion_inclusion_setting
	self._prop_items = prop_items
	self._slot = slot
	self._equip_slot_on_loadout_assign = equip_slot_on_loadout_assign

	if cinematic_name ~= "none" and self:_check_valid_animation(cinematic_name, inventory_animation_event, AnimationType.Inventory) then
		self._inventory_animation_event = inventory_animation_event
	end

	local cutscene_character_system = self._extension_manager:system("cutscene_character_system")

	cutscene_character_system:register_cutscene_character(self)
end

function CutsceneCharacterExtension:update(unit, dt, t)
	self._profile_spawner:update(dt, t)

	if self._is_loading_profile then
		local bypass_check_streaming = true

		if self._profile_spawner:spawned(bypass_check_streaming) then
			self._is_loading_profile = false

			if self._activate_post_spawn_weapon_specific_walk_animation then
				self:_start_weapon_specific_walk_animation()

				self._activate_post_spawn_weapon_specific_walk_animation = false
			end

			if self._activate_post_spawn_inventory_specific_walk_animation then
				self:_start_inventory_specific_walk_animation()

				self._activate_post_spawn_inventory_specific_walk_animation = false
			end
		end
	end
end

function CutsceneCharacterExtension:cinematic_name()
	return self._cinematic_name
end

function CutsceneCharacterExtension:character_type()
	return self._character_type
end

function CutsceneCharacterExtension:breed_name()
	return self._breed_name
end

function CutsceneCharacterExtension:companion_inclusion_setting()
	return self._companion_inclusion_setting
end

function CutsceneCharacterExtension:breed()
	return Breeds[self._breed_name]
end

function CutsceneCharacterExtension:slot()
	return self._slot
end

function CutsceneCharacterExtension:_check_valid_animation(cinematic_name, animation_event, animation_type)
	if not animation_event or animation_event == "none" then
		return false
	end

	local available_animation_events = nil
	local cinematic_template = CinematicSceneTemplates[cinematic_name]

	if animation_type == AnimationType.Inventory then
		available_animation_events = cinematic_template.available_inventory_animation_events
	elseif animation_type == AnimationType.Weapon then
		available_animation_events = cinematic_template.available_weapon_animation_events
	end

	local valid_animation = table.contains(available_animation_events, animation_event)

	return valid_animation
end

local NUM_CPT_PER_UNIT = 1

local function _check_component_amount(unit, components, component_name)
	if table.size(components) ~= NUM_CPT_PER_UNIT then
		Log.warning("[CutsceneCharacterExtension]", "Incorrect amount(%d / %d) of ScriptComponent('%s') for Unit(%s. %s)", table.size(components), NUM_CPT_PER_UNIT, component_name, unit, Unit.id_string(unit))

		return false
	end

	return true
end

function CutsceneCharacterExtension:_clear_loadout()
	local extension_manager = self._extension_manager
	local player_character_unit = self._unit
	local component_system = extension_manager:system("component_system")
	local player_customization_components = component_system:get_components(player_character_unit, "PlayerCustomization")
	self._equipped_weapon = nil

	if _check_component_amount(player_character_unit, player_customization_components, "PlayerCustomization") then
		local player_customization_component = player_customization_components[1]

		player_customization_component:unspawn_items()
	end
end

function CutsceneCharacterExtension:has_player_assigned()
	return self._player_unique_id ~= nil or self._profile_spawner:loading()
end

local PROP_ITEMS = {}

function CutsceneCharacterExtension:assign_player_loadout(player_unique_id, items, companion_cutscene_extension)
	local cinematic_name = self._cinematic_name
	local cinematic_template = CinematicSceneTemplates[cinematic_name]
	local ignored_slots = cinematic_template.ignored_slots
	local equip_slot = self._equip_slot_on_loadout_assign
	local ignore_wield_on_assigned = equip_slot == ""

	for j = 1, #ignored_slots do
		local ignored_slot_name = ignored_slots[j]

		self._profile_spawner:ignore_slot(ignored_slot_name)

		if equip_slot ~= "" and ignored_slot_name == equip_slot then
			ignore_wield_on_assigned = true
		end
	end

	if equip_slot ~= "" and not ignore_wield_on_assigned then
		self._profile_spawner:wield_slot(equip_slot)
	end

	self._companion_cutscene_extension = companion_cutscene_extension
	local companion_unit = companion_cutscene_extension and companion_cutscene_extension:unit()

	if companion_cutscene_extension then
		companion_cutscene_extension:assign_player_unique_id(player_unique_id)
	end

	local profile_spawner_companion_data = {
		attach_to_character = false,
		optional_unit_3p = companion_unit,
		ignore = companion_cutscene_extension == nil
	}
	local profile = Managers.player:player_from_unique_id(player_unique_id):profile()
	local unit = self._unit
	local position = Unit.world_position(unit, 1)
	local rotation = Unit.world_rotation(unit, 1)
	local scale = Unit.world_scale(unit, 1)
	local animation_event, face_animation_event = nil
	local force_highest_mip = true
	local disable_hair_state_machine = false
	local state_machine = nil
	local ignore_state_machine = true
	local mission_template = self._mission_template
	local face_state_machine_key = mission_template and mission_template.face_state_machine_key

	self._profile_spawner:spawn_profile(profile, position, rotation, scale, state_machine, animation_event, face_state_machine_key, face_animation_event, force_highest_mip, disable_hair_state_machine, unit, ignore_state_machine, profile_spawner_companion_data)
	self:_load_props()

	self._player_unique_id = player_unique_id
	self._is_loading_profile = true
end

function CutsceneCharacterExtension:_load_props()
	table.clear(PROP_ITEMS)

	local prop_item_names = self._prop_items
	local item_definitions = MasterItems.get_cached()

	for i = 1, #prop_item_names do
		local item_name = prop_item_names[i]
		PROP_ITEMS[i] = rawget(item_definitions, item_name)
	end

	local extension_manager = self._extension_manager
	local component_system = extension_manager:system("component_system")
	local player_character_unit = self._unit
	local player_customization_components = component_system:get_components(player_character_unit, "PlayerCustomization")

	if _check_component_amount(player_character_unit, player_customization_components, "PlayerCustomization") then
		local player_customization_component = player_customization_components[1]
		local mission_manager = Managers.state.mission
		local mission_template = mission_manager and mission_manager:mission()

		player_customization_component:spawn_items(PROP_ITEMS, mission_template)
	end
end

function CutsceneCharacterExtension:unassign_player_loadout()
	if self._current_state_machine ~= AnimationType.None then
		local unit = self._unit

		Unit.disable_animation_state_machine(unit)

		self._current_state_machine = AnimationType.None
	end

	self:_clear_loadout()
	self._profile_spawner:reset()

	self._player_unique_id = nil
	self._companion_cutscene_extension = nil
end

function CutsceneCharacterExtension:set_equipped_weapon(weapon)
	self._equipped_weapon = weapon
end

function CutsceneCharacterExtension:wield_slot(slot_name)
	self._profile_spawner:wield_slot(slot_name)
end

function CutsceneCharacterExtension:wield_slot_set_visibility(state)
	if self._profile_spawner._character_spawn_data ~= nil then
		local slot = self._profile_spawner._character_spawn_data.wielded_slot
		slot.wants_hidden_by_gameplay_1p = not state
		slot.wants_hidden_by_gameplay_3p = not state

		self._profile_spawner:_update_items_visibility()
	end
end

function CutsceneCharacterExtension:set_visibility(state)
	self._profile_spawner:set_visibility(state)
end

function CutsceneCharacterExtension:set_weapon_animation_event(animation_event)
	if self:_check_valid_animation(self._cinematic_name, animation_event, AnimationType.Weapon) then
		self._weapon_animation_event = animation_event
	end
end

function CutsceneCharacterExtension:start_weapon_specific_walk_animation()
	if self._weapon_animation_event and self:has_player_assigned() then
		local bypass_check_streaming = true

		if self._profile_spawner:spawned(bypass_check_streaming) then
			self:_start_weapon_specific_walk_animation()

			self._activate_post_spawn_weapon_specific_walk_animation = false
		else
			self._activate_post_spawn_weapon_specific_walk_animation = true
		end
	end
end

function CutsceneCharacterExtension:_start_weapon_specific_walk_animation()
	local unit = self._unit
	local event = self._weapon_animation_event

	if self._companion_cutscene_extension then
		self._companion_cutscene_extension:trigger_walk_animation_event()
	end

	if self._current_state_machine ~= AnimationType.Weapon then
		local weapon_template = WeaponTemplates[self._equipped_weapon.weapon_template]
		local state_machine_3p, _ = WeaponTemplate.state_machines(weapon_template, self._breed_name)

		Unit.set_animation_state_machine(unit, state_machine_3p)

		self._current_state_machine = AnimationType.Weapon
	end

	if Unit.has_animation_event(unit, event) then
		Unit.animation_event(unit, event)
	else
		Log.error(CutsceneCharacterExtension.DEBUG_TAG, "No animation event called %q in state machine, using fallback weapon?", event)
	end
end

function CutsceneCharacterExtension:start_inventory_specific_walk_animation()
	if self._inventory_animation_event and self:has_player_assigned() then
		local bypass_check_streaming = true

		if self._profile_spawner:spawned(bypass_check_streaming) then
			self:_start_inventory_specific_walk_animation()

			self._activate_post_spawn_inventory_specific_walk_animation = false
		else
			self._activate_post_spawn_inventory_specific_walk_animation = true
		end
	end
end

function CutsceneCharacterExtension:_start_inventory_specific_walk_animation()
	if self._current_state_machine ~= AnimationType.Inventory then
		local breed = Breeds[self._breed_name]

		Unit.set_animation_state_machine(self._unit, breed.inventory_state_machine)
		Unit.enable_animation_state_machine(self._unit)
		Unit.animation_event(self._unit, self._equipped_weapon.inventory_animation_event)

		self._current_state_machine = AnimationType.Inventory
	end

	if self._inventory_animation_event ~= "unready_idle" then
		Unit.animation_event(self._unit, self._inventory_animation_event)
	end
end

function CutsceneCharacterExtension:unit_3p_from_slot(slot_id)
	return self._profile_spawner:unit_3p_from_slot(slot_id)
end

return CutsceneCharacterExtension
