local Component = require("scripts/utilities/component")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local LasgunAmmoDisplay = class("LasgunAmmoDisplay")
local CRITICAL_THRESHOLD_MULTIPLIER = 0.1

function LasgunAmmoDisplay:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	local owner_unit = context.owner_unit
	local unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
	self._inventory_slot_component = unit_data_extension:read_component(slot.name)
	local unit_components = {}
	local attachments_1p = slot.attachments_by_unit_1p[unit_1p]
	local num_attachments_1p = #attachments_1p

	for ii = 1, num_attachments_1p do
		local attachment_unit = attachments_1p[ii]
		local components = Component.get_components_by_name(attachment_unit, "AmmoDisplay")

		for _, component in ipairs(components) do
			unit_components[#unit_components + 1] = {
				unit = attachment_unit,
				component = component
			}
		end
	end

	local attachments_3p = slot.attachments_by_unit_3p[unit_3p]
	local num_attachments_3p = #attachments_3p

	for ii = 1, num_attachments_3p do
		local attachment_unit = attachments_3p[ii]
		local components = Component.get_components_by_name(attachment_unit, "AmmoDisplay")

		for _, component in ipairs(components) do
			unit_components[#unit_components + 1] = {
				unit = attachment_unit,
				component = component
			}
		end
	end

	self._unit_components = unit_components
end

function LasgunAmmoDisplay:fixed_update(unit, dt, t, frame)
	return
end

function LasgunAmmoDisplay:update(unit, dt, t)
	local inventory_slot_component = self._inventory_slot_component
	local current_ammo = inventory_slot_component.current_ammunition_clip
	local max_ammo = inventory_slot_component.max_ammunition_clip
	local critical_threshold = max_ammo * CRITICAL_THRESHOLD_MULTIPLIER
	local unit_components = self._unit_components
	local num_displays = #unit_components

	for ii = 1, num_displays do
		local display = unit_components[ii]

		display.component:set_ammo(display.unit, current_ammo, max_ammo, critical_threshold)
	end
end

function LasgunAmmoDisplay:update_first_person_mode(first_person_mode)
	return
end

function LasgunAmmoDisplay:wield()
	return
end

function LasgunAmmoDisplay:unwield()
	return
end

function LasgunAmmoDisplay:destroy()
	return
end

implements(LasgunAmmoDisplay, WieldableSlotScriptInterface)

return LasgunAmmoDisplay
