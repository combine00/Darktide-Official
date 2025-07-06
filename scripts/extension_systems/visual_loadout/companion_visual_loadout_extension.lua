local CompanionVisualLoadoutExtension = class("CompanionVisualLoadoutExtension")
local PlayerUnitVisualLoadout = require("scripts/extension_systems/visual_loadout/utilities/player_unit_visual_loadout")

function CompanionVisualLoadoutExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id)
	local is_server = extension_init_context.is_server
	self._is_server = is_server
	self._unit = unit
	self._owner_player = extension_init_data.owner_player
	self._blackboard = BLACKBOARDS[unit]
	local slots = {}
	self._slots = slots
	local material_override_slots = {}
	self._material_override_slots = material_override_slots

	if not is_server then
		self._game_object_id = nil_or_game_object_id
		self._game_session = game_object_data_or_game_session
	end

	local player_unit = self._owner_player.player_unit
	local local_player = Managers.player:local_player(1)

	if not is_server and self._owner_player ~= local_player then
		return
	end

	local owner_visual_loadout_extension = ScriptUnit.has_extension(player_unit, "visual_loadout_system")

	if owner_visual_loadout_extension and self:is_slot_unit_spawned("slot_companion_gear_full") then
		local profile = self._owner_player:profile()
		local visual_loadout = profile.visual_loadout
		local unit_data = ScriptUnit.extension(self._owner_player.player_unit, "unit_data_system")
		local inventory_component = unit_data and unit_data:read_component("inventory")

		if inventory_component then
			if PlayerUnitVisualLoadout.slot_equipped(inventory_component, owner_visual_loadout_extension, "slot_companion_body_skin_color") then
				owner_visual_loadout_extension:unequip_item_from_slot("slot_companion_body_skin_color", 0)
			end

			if PlayerUnitVisualLoadout.slot_equipped(inventory_component, owner_visual_loadout_extension, "slot_companion_gear_full") then
				owner_visual_loadout_extension:unequip_item_from_slot("slot_companion_gear_full", 0)
			end

			local skin_item = visual_loadout.slot_companion_body_skin_color

			if skin_item then
				owner_visual_loadout_extension:equip_item_to_slot(skin_item, "slot_companion_body_skin_color", self._unit, 0)
			end

			local gear_full_item = visual_loadout.slot_companion_gear_full

			if gear_full_item then
				owner_visual_loadout_extension:equip_item_to_slot(gear_full_item, "slot_companion_gear_full", self._unit, 0)
			end
		end
	end
end

function CompanionVisualLoadoutExtension:game_object_initialized(game_session, game_object_id)
	self._game_object_id = game_object_id
	self._game_session = game_session
end

function CompanionVisualLoadoutExtension:destroy()
	return
end

function CompanionVisualLoadoutExtension:slots()
	return
end

function CompanionVisualLoadoutExtension:material_override_slots()
	return self._material_override_slots
end

function CompanionVisualLoadoutExtension:inventory()
	return
end

function CompanionVisualLoadoutExtension:inventory_slots()
	local owner_unit = self:_unit_owner()
	local visual_loadout_extension = ScriptUnit.extension(owner_unit, "visual_loadout_system")
	local companion_slots = visual_loadout_extension:companion_slots()

	return companion_slots
end

function CompanionVisualLoadoutExtension:slot_unit(slot_name)
	return nil
end

function CompanionVisualLoadoutExtension:is_slot_unit_spawned(slot_name)
	local owner_unit = self:_unit_owner()
	local visual_loadout_extension = ScriptUnit.has_extension(owner_unit, "visual_loadout_system")

	return visual_loadout_extension and visual_loadout_extension:is_slot_unit_spawned(slot_name)
end

function CompanionVisualLoadoutExtension:is_slot_unit_valid(slot_name)
	local owner_unit = self:_unit_owner()
	local visual_loadout_extension = ScriptUnit.has_extension(owner_unit, "visual_loadout_system")

	return visual_loadout_extension and visual_loadout_extension:is_slot_unit_valid(slot_name)
end

function CompanionVisualLoadoutExtension:_unit_owner()
	return self._owner_player.player_unit
end

function CompanionVisualLoadoutExtension:_wield_slot(slot_name)
	return
end

function CompanionVisualLoadoutExtension:has_slot(slot_name)
	return
end

function CompanionVisualLoadoutExtension:wield_slot(slot_name)
	self:_wield_slot(slot_name)
end

function CompanionVisualLoadoutExtension:_unwield_slot(slot_name)
	return
end

function CompanionVisualLoadoutExtension:unwield_slot(slot_name)
	self:_unwield_slot(slot_name)
end

function CompanionVisualLoadoutExtension:equip_item_to_slot(item, slot_name, optional_existing_unit_3p, t)
	return
end

function CompanionVisualLoadoutExtension:_equip_item_to_slot(item, slot_name, t, optional_existing_unit_3p, from_server_correction_occurred)
	return
end

function CompanionVisualLoadoutExtension:_unequip_slot(slot_name)
	return
end

function CompanionVisualLoadoutExtension:unequip_slot(slot_name)
	self:_unequip_slot(slot_name)
end

function CompanionVisualLoadoutExtension:slot_items()
	return self._slots
end

function CompanionVisualLoadoutExtension:slot_item(slot_name)
	local slots = self._slots
	local slot_data = slots[slot_name]

	if not slot_data then
		return nil
	end

	return slot_data
end

function CompanionVisualLoadoutExtension:can_wield_slot(slot_name)
	return false
end

function CompanionVisualLoadoutExtension:can_unwield_slot(slot_name)
	return false
end

function CompanionVisualLoadoutExtension:can_unequip_slot(slot_name)
	return false
end

function CompanionVisualLoadoutExtension:wielded_slot_name()
	return nil
end

function CompanionVisualLoadoutExtension:set_ailment_effect(effect_template)
	if self._ailment_effect_template then
		return
	end

	self._ailment_effect_template = effect_template
end

function CompanionVisualLoadoutExtension:ailment_effect()
	return self._ailment_effect_template
end

function CompanionVisualLoadoutExtension:slot_material_override(slot_name)
	local slot_data = self._slots[slot_name] or self._material_override_slots[slot_name]
	local item_data = slot_data and slot_data.item_data

	if not item_data then
		return nil, nil
	end

	return item_data.material_override_apply_to_parent, item_data.material_overrides
end

function CompanionVisualLoadoutExtension:telemetry_wielded_weapon()
	return nil
end

return CompanionVisualLoadoutExtension
