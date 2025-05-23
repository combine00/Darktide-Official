local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local ShovelFoldCorrector = class("ShovelFoldCorrector")

function ShovelFoldCorrector:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	self._is_server = context.is_server
	self._is_local_unit = context.is_local_unit
	local owner_unit = context.owner_unit
	self._owner_unit = owner_unit
	self._animation_extension = ScriptUnit.extension(owner_unit, "animation_system")
	local unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
	self._inventory_slot_component = unit_data_extension:read_component(slot.name)
end

function ShovelFoldCorrector:server_correction_occurred(unit, from_frame)
	self._trigger_fold = true
end

function ShovelFoldCorrector:fixed_update(unit, dt, t, frame)
	return
end

local activate_anim_event = "activate_mispredict"
local deactivate_anim_event = "deactivate_mispredict"

function ShovelFoldCorrector:update(unit, dt, t)
	if not self._is_server and self._wielded and self._trigger_fold then
		local special_active = self._inventory_slot_component.special_active
		local anim_event = special_active and activate_anim_event or deactivate_anim_event
		local anim_ext = self._animation_extension

		anim_ext:anim_event_with_variable_floats_1p(anim_event)
		anim_ext:anim_event_with_variable_floats(anim_event)
	end

	self._trigger_fold = false
end

function ShovelFoldCorrector:wield()
	self._wielded = true
end

function ShovelFoldCorrector:unwield()
	self._wielded = false
end

function ShovelFoldCorrector:update_first_person_mode(first_person_mode)
	return
end

function ShovelFoldCorrector:destroy()
	return
end

implements(ShovelFoldCorrector, WieldableSlotScriptInterface)

return ShovelFoldCorrector
