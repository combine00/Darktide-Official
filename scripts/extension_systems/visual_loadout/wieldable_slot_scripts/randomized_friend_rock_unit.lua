local Component = require("scripts/utilities/component")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local RandomizedFriendRockUnit = class("RandomizedFriendRockUnit")

function RandomizedFriendRockUnit:init(context, slot, weapon_template, fx_sources)
	local owner_unit = context.owner_unit
	self._weapon_actions = weapon_template.actions
	self._ability_extension = ScriptUnit.extension(owner_unit, "ability_system")
	self._slot = slot
	local unit_components = {}
	local base_unit_1p = slot.unit_1p
	local components_1p = Component.get_components_by_name(base_unit_1p, "RandomizedFriendRockUnit")

	for _, component in ipairs(components_1p) do
		unit_components[#unit_components + 1] = {
			unit = base_unit_1p,
			component = component
		}
	end

	local base_unit_3p = slot.unit_3p
	local components_3p = Component.get_components_by_name(base_unit_3p, "RandomizedFriendRockUnit")

	for _, component in ipairs(components_3p) do
		unit_components[#unit_components + 1] = {
			unit = base_unit_3p,
			component = component
		}
	end

	self._unit_components = unit_components
end

function RandomizedFriendRockUnit:fixed_update(unit, dt, t, frame)
	return
end

function RandomizedFriendRockUnit:update(unit, dt, t)
	self:_update_next_visibility_group_index()
end

function RandomizedFriendRockUnit:update_first_person_mode(first_person_mode)
	return
end

function RandomizedFriendRockUnit:wield()
	self:_update_next_visibility_group_index()

	local unit_components = self._unit_components
	local next_visibility_group_index = self._next_visibility_group_index

	for ii = 1, #unit_components do
		local random_visual_unit = unit_components[ii]

		random_visual_unit.component:show_visibility_group(next_visibility_group_index)
	end
end

function RandomizedFriendRockUnit:unwield()
	return
end

function RandomizedFriendRockUnit:destroy()
	return
end

function RandomizedFriendRockUnit:_update_next_visibility_group_index()
	local current_num_remaining_charges = self._num_remaining_charges
	local num_remaining_charges = self._ability_extension:remaining_ability_charges("grenade_ability")

	if current_num_remaining_charges ~= num_remaining_charges then
		self._num_remaining_charges = num_remaining_charges
		local next_visibility_group_index = nil
		local unit_components = self._unit_components

		for ii = 1, #unit_components do
			local random_visual_unit = unit_components[ii]
			next_visibility_group_index = next_visibility_group_index or random_visual_unit.component:random_visibility_group_index()
		end

		self._next_visibility_group_index = next_visibility_group_index
	end
end

implements(RandomizedFriendRockUnit, WieldableSlotScriptInterface)

return RandomizedFriendRockUnit
