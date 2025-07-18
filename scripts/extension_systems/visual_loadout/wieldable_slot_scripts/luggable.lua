local ProjectileLocomotionSettings = require("scripts/settings/projectile_locomotion/projectile_locomotion_settings")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local locomotion_states = ProjectileLocomotionSettings.states
local Luggable = class("Luggable")

function Luggable:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	local is_server = context.is_server
	self._is_server = is_server
	self._slot = slot
	local item_unit_3p = slot.unit_3p
	self._item_unit_3p = item_unit_3p
	self._luggable_locomotion_extension = ScriptUnit.extension(item_unit_3p, "locomotion_system")
	self._owner_unit = context.owner_unit
	self._is_local_unit = context.is_local_unit
	self._visual_loadout_extension = context.visual_loadout_extension
	local unit_data_extension = context.unit_data_extension
	self._action_throw_luggable_component = unit_data_extension:read_component("action_throw_luggable")
	local mission_objective_target_extension = ScriptUnit.extension(item_unit_3p, "mission_objective_target_system")
	local objective_name = mission_objective_target_extension:objective_name()
	local mission_objective_system = Managers.state.extension:system("mission_objective_system")
	local objective = mission_objective_system:active_objective(objective_name)

	if objective then
		objective:luggable_picked_up()
	end

	local item_unit_1p = slot.unit_1p
	self._item_unit_1p = item_unit_1p
	local dynamic_id = Unit.find_actor(item_unit_1p, "dynamic")

	Unit.destroy_actor(item_unit_1p, dynamic_id)
end

function Luggable:fixed_update(unit, dt, t, frame)
	return
end

function Luggable:update(unit, dt, t)
	local slot = self._slot

	if self._action_throw_luggable_component.thrown and self._luggable_locomotion_extension:current_state() ~= locomotion_states.carried then
		if not slot.wants_hidden_by_gameplay_1p then
			local hide_1p = true
			local hide_3p = false

			self._visual_loadout_extension:set_force_hide_wieldable_slot(slot.name, hide_1p, hide_3p)
		end
	elseif slot.wants_hidden_by_gameplay_1p then
		local hide_1p = false
		local hide_3p = false

		self._visual_loadout_extension:set_force_hide_wieldable_slot(slot.name, hide_1p, hide_3p)
	end
end

function Luggable:update_first_person_mode(first_person_mode)
	return
end

function Luggable:wield()
	Unit.flow_event(self._item_unit_3p, "luggable_wield")
	self:_handle_objective_markers(true)
end

function Luggable:unwield()
	local hide_1p = false
	local hide_3p = false

	self._visual_loadout_extension:set_force_hide_wieldable_slot(self._slot.name, hide_1p, hide_3p)
	self:_handle_objective_markers(false)
	Unit.flow_event(self._item_unit_3p, "luggable_unwield")
end

function Luggable:_handle_objective_markers(wielding)
	if not self._is_local_unit then
		return
	end

	local item_unit_3p = self._item_unit_3p

	if not ALIVE[item_unit_3p] then
		self._item_unit_3p = nil

		return
	end

	local mission_objective_system = Managers.state.extension:system("mission_objective_system")
	local mission_objective_target_extension = ScriptUnit.extension(item_unit_3p, "mission_objective_target_system")
	local objective_name = mission_objective_target_extension:objective_name()
	local objective = mission_objective_system:active_objective(objective_name)

	if objective then
		objective:display_socket_markers(wielding)
	end
end

function Luggable:destroy()
	local item_unit_3p = self._item_unit_3p

	if ALIVE[item_unit_3p] then
		local is_server = self._is_server
	else
		self._item_unit_3p = nil
	end
end

implements(Luggable, WieldableSlotScriptInterface)

return Luggable
