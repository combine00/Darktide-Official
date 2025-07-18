local AmmoCountEffects = class("AmmoCountEffects")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local WWISE_PARAMETER_NAME = "weapon_ammo_count"

function AmmoCountEffects:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	local unit_data_extension = context.unit_data_extension
	self._owner_unit = context.owner_unit
	self._is_husk = context.is_husk
	self._is_local_unit = context.is_local_unit
	self._slot = slot
	self._world = context.world
	self._wwise_world = context.wwise_world
	self._fx_extension = context.fx_extension
	self._muzzle_fx_source_name = fx_sources._muzzle
	self._last_clip_size = 0
	self._inventory_slot_component = unit_data_extension:read_component(slot.name)
end

function AmmoCountEffects:destroy()
	return
end

function AmmoCountEffects:fixed_update(unit, dt, t, frame)
	return
end

function AmmoCountEffects:update(unit, dt, t)
	local inventory_slot_component = self._inventory_slot_component
	local current_clip = inventory_slot_component.current_ammunition_clip

	if self._last_clip_size ~= current_clip then
		local muzzle_source = self._fx_extension:sound_source(self._muzzle_fx_source_name)
		local wwise_world = self._wwise_world
		local max_clip = inventory_slot_component.max_ammunition_clip
		local ammo_percentage = max_clip > 0 and current_clip / max_clip * 100 or 0

		WwiseWorld.set_global_parameter(wwise_world, WWISE_PARAMETER_NAME, ammo_percentage)
		WwiseWorld.set_source_parameter(wwise_world, muzzle_source, WWISE_PARAMETER_NAME, ammo_percentage)

		if IS_PLAYSTATION and self._is_local_unit then
			Managers.input.haptic_trigger_effects:set_ammo_count_percentage(ammo_percentage)
		end

		self._last_clip_size = current_clip
	end
end

function AmmoCountEffects:update_first_person_mode(first_person_mode)
	return
end

function AmmoCountEffects:wield()
	return
end

function AmmoCountEffects:unwield()
	return
end

implements(AmmoCountEffects, WieldableSlotScriptInterface)

return AmmoCountEffects
