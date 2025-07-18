local Ammo = require("scripts/utilities/ammo")
local _reset_state = nil
local ReloadStates = {
	reload_kinds = {
		reload_shotgun = true,
		reload_state = true
	},
	reset = function (reload_template, inventory_slot_component)
		_reset_state(reload_template, inventory_slot_component)
	end,
	start_reload_state = function (reload_template, inventory_slot_component, condition_func_params)
		local state_name = inventory_slot_component.reload_state
		local state_config = reload_template[state_name]
		local anim_1p = state_config.anim_1p
		local anim_3p = state_config.anim_3p or anim_1p
		local action_time_offset = state_config.action_time_offset

		if type(anim_1p) == "function" then
			anim_1p = anim_1p(condition_func_params)
		end

		if type(anim_3p) == "function" then
			anim_3p = anim_3p(condition_func_params)
		end

		return anim_1p, anim_3p, action_time_offset
	end
}

function ReloadStates.get_total_time(reload_template, inventory_slot_component)
	local reload_state = ReloadStates.reload_state(reload_template, inventory_slot_component)

	return reload_state.time
end

function ReloadStates.uses_reload_states(inventory_slot_component)
	return inventory_slot_component.reload_state ~= "none"
end

function ReloadStates.started_reload(reload_template, inventory_slot_component)
	local reload_state = inventory_slot_component.reload_state
	local state = reload_template[reload_state]

	return state.state_index > 1
end

function ReloadStates.reload_state(reload_template, inventory_slot_component)
	local reload_state = inventory_slot_component.reload_state

	return reload_template[reload_state]
end

function ReloadStates.reimburse_clip_to_reserve(inventory_slot_component)
	local current_ammo_reserve = inventory_slot_component.current_ammunition_reserve
	local current_ammo_clip = inventory_slot_component.current_ammunition_clip
	local new_ammunition_reserve = current_ammo_reserve + current_ammo_clip

	if Managers.state.game_mode:infinite_ammo_reserve() then
		new_ammunition_reserve = inventory_slot_component.max_ammunition_reserve
	end

	inventory_slot_component.ammunition_at_reload_start = current_ammo_clip
	inventory_slot_component.current_ammunition_reserve = new_ammunition_reserve
	inventory_slot_component.current_ammunition_clip = 0
end

function ReloadStates.reload(inventory_slot_component)
	local max_ammo_in_clip = inventory_slot_component.max_ammunition_clip
	local current_ammo_in_clip = inventory_slot_component.current_ammunition_clip
	local missing_ammo_in_clip = max_ammo_in_clip - current_ammo_in_clip

	Ammo.transfer_from_reserve_to_clip(inventory_slot_component, missing_ammo_in_clip)
end

function _reset_state(reload_template, inventory_slot_component)
	local first_state = reload_template.states[1]
	inventory_slot_component.reload_state = first_state
end

return ReloadStates
