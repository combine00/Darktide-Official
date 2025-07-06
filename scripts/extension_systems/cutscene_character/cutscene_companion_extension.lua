local Breeds = require("scripts/settings/breed/breeds")
local CinematicSceneSettings = require("scripts/settings/cinematic_scene/cinematic_scene_settings")
local CinematicSceneTemplates = require("scripts/settings/cinematic_scene/cinematic_scene_templates")
local MasterItems = require("scripts/backend/master_items")
local UIProfileSpawner = require("scripts/managers/ui/ui_profile_spawner")
local UIUnitSpawner = require("scripts/managers/ui/ui_unit_spawner")
local WeaponTemplate = require("scripts/utilities/weapon/weapon_template")
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")
local CutsceneCompanionExtension = class("CutsceneCompanionExtension")

function CutsceneCompanionExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._extension_manager = extension_init_context.extension_manager
	self._unit = unit
	self._is_server = extension_init_context.is_server
	self._cinematic_name = CinematicSceneSettings.CINEMATIC_NAMES.none
	self._breed_name = "none"
	self._player_unique_id = nil
end

function CutsceneCompanionExtension:destroy()
	local breed_name = self._breed_name
	local cutscene_character_system = self._extension_manager:system("cutscene_character_system")

	cutscene_character_system:unregister_cutscene_companion(self)
end

function CutsceneCompanionExtension:setup_from_component(cinematic_name, breed_name, slot, starting_animation_event, walking_animation_event)
	self._cinematic_name = cinematic_name
	self._breed_name = breed_name
	self._slot = slot
	self._starting_animation_event = starting_animation_event ~= "" and starting_animation_event or nil
	self._walking_animation_event = walking_animation_event ~= "" and walking_animation_event or "to_walk"
	local cutscene_character_system = self._extension_manager:system("cutscene_character_system")

	cutscene_character_system:register_cutscene_companion(self)
	self:set_visibility(false)
end

function CutsceneCompanionExtension:set_visibility(visibility)
	Unit.set_unit_visibility(self._unit, visibility, true)
end

function CutsceneCompanionExtension:unit()
	return self._unit
end

function CutsceneCompanionExtension:has_player_assigned()
	return self._player_unique_id ~= nil
end

function CutsceneCompanionExtension:cinematic_name()
	return self._cinematic_name
end

function CutsceneCompanionExtension:breed_name()
	return self._breed_name
end

function CutsceneCompanionExtension:breed()
	return Breeds[self._breed_name]
end

function CutsceneCompanionExtension:slot()
	return self._slot
end

function CutsceneCompanionExtension:assign_player_unique_id(player_unique_id)
	self._player_unique_id = player_unique_id

	self:trigger_starting_animation_event()
	self:set_visibility(true)
end

function CutsceneCompanionExtension:unassign_player_loadout()
	self._player_unique_id = nil
end

function CutsceneCompanionExtension:trigger_starting_animation_event()
	local unit = self._unit
	local event = self._starting_animation_event

	if self:has_player_assigned() and event then
		Unit.enable_animation_state_machine(unit)
		Unit.animation_event(unit, event)
	end
end

function CutsceneCompanionExtension:trigger_walk_animation_event()
	local unit = self._unit
	local event = self._walking_animation_event

	if self:has_player_assigned() and event and Unit.has_animation_event(unit, event) then
		Unit.enable_animation_state_machine(unit)
		Unit.animation_event(unit, event)
	end
end

return CutsceneCompanionExtension
