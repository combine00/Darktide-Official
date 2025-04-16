local BuffSettings = require("scripts/settings/buff/buff_settings")
local Component = require("scripts/utilities/component")
local JobInterface = require("scripts/managers/unit_job/job_interface")
local buff_keywords = BuffSettings.keywords
local ProximityShockMine = class("ProximityShockMine")
local COMPONENT_STATES = table.enum("none", "arming", "deployed")

function ProximityShockMine:init(logic_context, init_data, owner_unit_or_nil)
	self._world = logic_context.world
	self._physics_world = logic_context.physics_world
	self._unit = logic_context.unit
	local side_name = logic_context.side_name
	local side_system = Managers.state.extension:system("side_system")
	local side = side_system:get_side_from_name(side_name)
	local enemy_side_names = side:relation_side_names("enemy")
	self._side_name = side_name
	self._enemy_side_names = enemy_side_names
	self._units_in_proximity = {}
	local settings = init_data
	self._settings = settings
	self._owner_unit_or_nil = owner_unit_or_nil
	self._start_time = nil
	self._current_t = nil
	self._arming_time = settings.arming_time
	self._trigger_interval = settings.trigger_interval
	self._buff_trigger_t = 0
	self._life_time = settings.life_time + settings.arming_time
	self._buff_to_add = settings.buff_to_add
	self._num_targets_per_trigger = settings.num_targets_per_trigger
	local fx_system = Managers.state.extension:system("fx_system")
	local broadphase_system = Managers.state.extension:system("broadphase_system")
	self._fx_system = fx_system
	self._broadphase = broadphase_system.broadphase
	self._component_state = COMPONENT_STATES.none
end

function ProximityShockMine:unit_entered_proximity(t, unit)
	local health_extension = ScriptUnit.has_extension(unit, "health_system")

	if not health_extension or not HEALTH_ALIVE[unit] then
		return
	end

	self._units_in_proximity[unit] = health_extension
end

function ProximityShockMine:unit_left_proximity(unit)
	self._units_in_proximity[unit] = nil
end

function ProximityShockMine:unit_in_proximity_deleted(unit)
	self._units_in_proximity[unit] = nil
end

function ProximityShockMine:update(dt, t)
	self._current_t = t

	if not self._started then
		return
	end

	if t < self._start_time + self._arming_time then
		return
	end

	if self._component_state == COMPONENT_STATES.arming then
		local components = self._components

		for ii = 1, #components do
			Component.trigger_event_on_clients(components[ii], "shock_mine_deploy")
		end

		self._components = components

		if not DEDICATED_SERVER then
			Component.event(self._unit, "shock_mine_deploy")
		end

		self._component_state = COMPONENT_STATES.deployed
	end

	self:_apply_buffs(t)
end

local HARD_CODED_RADIUS = 3
local _broadphase_results = {}

function ProximityShockMine:_apply_buffs(t)
	if t < self._buff_trigger_t then
		return
	end

	table.clear(_broadphase_results)

	local broadphase = self._broadphase
	local num_results = broadphase:query(POSITION_LOOKUP[self._unit], HARD_CODED_RADIUS, _broadphase_results, self._enemy_side_names)

	table.shuffle(_broadphase_results)

	local num_added_buffs = 0
	local result_index = 0
	local buff_to_add = self._buff_to_add
	local stop = false

	while not stop do
		result_index = result_index + 1
		local target_unit = _broadphase_results[result_index]

		if HEALTH_ALIVE[target_unit] then
			local buff_extension = ScriptUnit.has_extension(target_unit, "buff_system")

			if buff_extension then
				local target_is_electrocuted = buff_extension:has_keyword(buff_keywords.electrocuted)

				if not target_is_electrocuted then
					buff_extension:add_internally_controlled_buff(buff_to_add, t, "owner_unit", self._owner_unit_or_nil)

					num_added_buffs = num_added_buffs + 1
				end
			end
		end

		stop = self._num_targets_per_trigger < num_added_buffs or num_results < result_index
	end

	self._buff_trigger_t = t + self._trigger_interval
end

function ProximityShockMine:start_job()
	if self:is_job_completed() or self:is_job_canceled() then
		return
	end

	local t = Managers.time:time("gameplay")
	self._start_time = t
	self._current_t = t
	self._buff_trigger_t = t + self._arming_time
	self._started = true
	local components = Component.get_components_by_name(self._unit, "ShockMine")

	for ii = 1, #components do
		Component.trigger_event_on_clients(components[ii], "shock_mine_start_arming")
	end

	self._components = components
	self._component_state = COMPONENT_STATES.arming

	if not DEDICATED_SERVER then
		Component.event(self._unit, "shock_mine_start_arming")
	end
end

function ProximityShockMine:is_job_completed()
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

function ProximityShockMine:cancel_job()
	self._is_canceled = true
end

function ProximityShockMine:is_job_canceled()
	return not not self._is_canceled
end

implements(ProximityShockMine, JobInterface)

return ProximityShockMine
