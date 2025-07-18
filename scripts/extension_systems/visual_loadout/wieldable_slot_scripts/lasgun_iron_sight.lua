local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local LasgunIronSight = class("LasgunIronSight")
local SHOW_DELAY = 0.04
local HIDE_DELAY = 0.1

function LasgunIronSight:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	if not context.is_husk then
		local owner_unit = context.owner_unit
		local unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
		self._alternate_fire_component = unit_data_extension:read_component("alternate_fire")
		self._first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local attachments_1p = slot.attachments_by_unit_1p[unit_1p]
		local num_attachments = #attachments_1p

		for i = 1, num_attachments do
			local attachment_unit = attachments_1p[i]
			local has_front_walls = Unit.has_visibility_group(attachment_unit, "front_walls")

			if has_front_walls then
				self._receiver_unit = attachment_unit

				break
			end
		end

		self._is_aiming_down_sights = false
		self._show_at_t = nil
		self._hide_at_t = nil
	end
end

function LasgunIronSight:fixed_update(unit, dt, t, frame)
	local is_aiming_down_sights = self._alternate_fire_component.is_active
	local first_person_extension = self._first_person_extension

	if first_person_extension:is_in_first_person_mode() then
		if self._is_aiming_down_sights and not is_aiming_down_sights and not self._show_at_t then
			self._show_at_t = t + SHOW_DELAY
		elseif not self._is_aiming_down_sights and is_aiming_down_sights and not self._hide_at_t then
			self._hide_at_t = t + HIDE_DELAY
		end

		if self._show_at_t and self._show_at_t <= t then
			Unit.set_visibility(self._receiver_unit, "front_walls", true)

			self._show_at_t = nil
		elseif self._hide_at_t and self._hide_at_t <= t then
			Unit.set_visibility(self._receiver_unit, "front_walls", false)

			self._hide_at_t = nil
		end
	end

	self._is_aiming_down_sights = is_aiming_down_sights
end

function LasgunIronSight:update(unit, dt, t)
	return
end

function LasgunIronSight:update_first_person_mode(first_person_mode)
	return
end

function LasgunIronSight:wield()
	return
end

function LasgunIronSight:unwield()
	return
end

function LasgunIronSight:destroy()
	return
end

implements(LasgunIronSight, WieldableSlotScriptInterface)

return LasgunIronSight
