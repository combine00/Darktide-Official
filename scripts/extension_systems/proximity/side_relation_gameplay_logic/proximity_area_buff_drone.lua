local Component = require("scripts/utilities/component")
local FixedFrame = require("scripts/utilities/fixed_frame")
local JobInterface = require("scripts/managers/unit_job/job_interface")
local ProximityAreaBuffDrone = class("ProximityAreaBuffDrone")
local COMPONENT_STATES = table.enum("none", "active", "deployed")

function ProximityAreaBuffDrone:init(logic_context, init_data, owner_unit_or_nil)
	local unit = logic_context.unit
	self._world = logic_context.world
	self._physics_world = logic_context.physics_world
	self._unit = unit
	self._side_name = logic_context.side_name
	self._units_in_proximity = {}
	self._units_affected_during_lifetime = {}
	self._allies_proximity_enter_time = {}
	local settings = init_data
	self._settings = settings
	self._owner_unit_or_nil = owner_unit_or_nil
	self._buff_to_add = settings.buff_to_add
	self._start_time = nil
	self._current_t = nil
	self._life_time = settings.life_time
	local fx_system = Managers.state.extension:system("fx_system")
	self._fx_system = fx_system
	self._component_state = COMPONENT_STATES.none
end

function ProximityAreaBuffDrone:destroy()
	local units_in_proximity = self._units_in_proximity

	for unit, data in pairs(units_in_proximity) do
		self:_remove_buff_from_unit(unit)
	end

	table.clear(self._units_affected_during_lifetime)
	table.clear(self._allies_proximity_enter_time)

	self._units_affected_during_lifetime = nil
	self._allies_proximity_enter_time = nil
end

function ProximityAreaBuffDrone:unit_entered_proximity(t, unit)
	self._units_in_proximity[unit] = {}

	self:_add_buff_to_unit(t, unit)
end

function ProximityAreaBuffDrone:unit_left_proximity(unit)
	self:_remove_buff_from_unit(unit)
end

function ProximityAreaBuffDrone:unit_in_proximity_deleted(unit)
	self._units_in_proximity[unit] = nil

	self:_handle_ally_buffing_time_stats(unit)
end

function ProximityAreaBuffDrone:update(dt, t)
	self._current_t = t

	if not self._drone_components or not self._particle_components then
		self._drone_components = Component.get_components_by_name(self._unit, "AreaBuffDrone")
		self._particle_components = Component.get_components_by_name(self._unit, "GyroscopeParticleEffect")
	end

	if self._component_state == COMPONENT_STATES.none then
		for ii = 1, #self._drone_components do
			Component.trigger_event_on_clients(self._drone_components[ii], "area_buff_drone_set_active")
		end

		if not DEDICATED_SERVER then
			Component.event(self._unit, "area_buff_drone_set_active")
		end

		self._component_state = COMPONENT_STATES.active
	end
end

function ProximityAreaBuffDrone:start_job()
	if self:is_job_completed() or self:is_job_canceled() then
		return
	end

	local t = Managers.time:time("gameplay")
	self._start_time = t
	self._current_t = t
	self._started = true
	local units_in_proximity = self._units_in_proximity

	for unit, data in pairs(units_in_proximity) do
		self:_add_buff_to_unit(t, unit)
	end

	for ii = 1, #self._particle_components do
		Component.trigger_event_on_clients(self._particle_components[ii], "create_particle")
	end

	for ii = 1, #self._drone_components do
		Component.trigger_event_on_clients(self._drone_components[ii], "area_buff_drone_deploy")
	end

	if not DEDICATED_SERVER then
		Component.event(self._unit, "create_particle")
		Component.event(self._unit, "area_buff_drone_deploy")
	end
end

function ProximityAreaBuffDrone:is_job_completed()
	if not self._started then
		return false
	end

	local life_time_expired = false
	local life_time = self._life_time

	if life_time then
		local life_span = self._current_t - self._start_time
		life_time_expired = self._life_time <= life_span
	end

	return life_time_expired
end

function ProximityAreaBuffDrone:cancel_job()
	self._is_canceled = true
end

function ProximityAreaBuffDrone:is_job_canceled()
	return not not self._is_canceled
end

function ProximityAreaBuffDrone:_add_buff_to_unit(t, unit)
	if not self._started then
		return
	end

	local buff_extension = ScriptUnit.has_extension(unit, "buff_system")

	if not buff_extension or not HEALTH_ALIVE[unit] then
		return
	end

	local _, index, component_index = nil

	if self._buff_to_add then
		_, index, component_index = buff_extension:add_externally_controlled_buff(self._buff_to_add, t, "owner_unit", self._owner_unit_or_nil)
		self._allies_proximity_enter_time[unit] = FixedFrame.get_latest_fixed_time()

		self:_handle_buffs_applied_to_unit_stats(unit)
	end

	self._units_in_proximity[unit] = {
		buff_extension = buff_extension,
		local_index = index,
		component_index = component_index
	}
end

function ProximityAreaBuffDrone:_remove_buff_from_unit(unit)
	if not self._started then
		self._units_in_proximity[unit] = nil

		return
	end

	local units_in_proximity = self._units_in_proximity
	local unit_settings = units_in_proximity[unit]

	if not unit_settings then
		return
	end

	local index = unit_settings.local_index
	local buff_extension = unit_settings.buff_extension

	if index and buff_extension then
		local component_index = unit_settings.component_index

		buff_extension:remove_externally_controlled_buff(index, component_index)
	end

	units_in_proximity[unit] = nil

	self:_handle_ally_buffing_time_stats(unit)
end

function ProximityAreaBuffDrone:_handle_buffs_applied_to_unit_stats(buffed_unit)
	local owner_unit = self._owner_unit_or_nil
	local side_system = Managers.state.extension:system("side_system")
	local unit_was_buffed_before = self._units_affected_during_lifetime[buffed_unit]

	if unit_was_buffed_before or not owner_unit or not side_system then
		return
	end

	self._units_affected_during_lifetime[buffed_unit] = true
	local is_enemy_unit = side_system:is_enemy(buffed_unit, self._owner_unit_or_nil)
	local owner_player = owner_unit and Managers.state.player_unit_spawn:owner(owner_unit)
	local stat_hook_name = string.format("hook_adamant_%s_affected_by_buff_drone", is_enemy_unit and "enemy" or "ally")

	Managers.stats:record_private(stat_hook_name, owner_player)
end

function ProximityAreaBuffDrone:_handle_ally_buffing_time_stats(ally_unit)
	local owner_unit = self._owner_unit_or_nil
	local allies_in_proximity_enter_time = self._allies_proximity_enter_time
	local buffing_start_time = allies_in_proximity_enter_time[ally_unit]
	allies_in_proximity_enter_time[ally_unit] = nil

	if not buffing_start_time or not owner_unit then
		return
	end

	local current_time = FixedFrame.get_latest_fixed_time()
	local time_buffed = math.round(current_time - buffing_start_time)
	local owner_player = owner_unit and Managers.state.player_unit_spawn:owner(owner_unit)

	Managers.stats:record_private("hook_adamant_time_ally_buffed_by_buff_drone", owner_player, time_buffed)
end

implements(ProximityAreaBuffDrone, JobInterface)

return ProximityAreaBuffDrone
