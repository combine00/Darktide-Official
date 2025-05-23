require("scripts/extension_systems/mission_objective/utilities/mission_objective_base")

local MissionObjectiveTimed = class("MissionObjectiveTimed", "MissionObjectiveBase")

function MissionObjectiveTimed:init()
	MissionObjectiveTimed.super.init(self)

	self._time_elapsed = 0
	self._paused = false
end

function MissionObjectiveTimed:get_time_left()
	return self._max_incremented_progression - self._time_elapsed
end

function MissionObjectiveTimed:_get_duration(mission_objective_data)
	if mission_objective_data.duration then
		return mission_objective_data.duration
	end

	if mission_objective_data.duration_by_difficulty then
		local difficulty = Managers.state.difficulty:get_initial_challenge()

		if difficulty > #mission_objective_data.duration_by_difficulty then
			Log.error("MissionObjectiveTimed", "duration_by_difficulty misses a duration corresponding to difficulty '%d', falling back to the duration on the highest index instead (duration will be '%d')", difficulty, mission_objective_data.duration_by_difficulty[#mission_objective_data.duration_by_difficulty])

			return mission_objective_data.duration_by_difficulty[#mission_objective_data.duration_by_difficulty]
		end

		return mission_objective_data.duration_by_difficulty[difficulty]
	end

	return nil
end

function MissionObjectiveTimed:start_objective(mission_objective_data, registered_units, synchronizer_unit)
	MissionObjectiveTimed.super.start_objective(self, mission_objective_data, registered_units, synchronizer_unit)

	self._use_counter = false
	self._time_elapsed = 0
	self._mission_assigned_duration = self:_get_duration(mission_objective_data)
end

function MissionObjectiveTimed:start_stage(stage)
	MissionObjectiveTimed.super.start_stage(self, stage)
	self:set_max_increment(self._mission_assigned_duration)
end

function MissionObjectiveTimed:update(dt)
	MissionObjectiveTimed.super.update(self, dt)

	if not self._paused then
		local duration = self._max_incremented_progression
		self._time_elapsed = self._time_elapsed + dt
		self._time_elapsed = math.min(self._time_elapsed, duration)
	end
end

function MissionObjectiveTimed:add_time(time)
	local duration = self._max_incremented_progression
	self._time_elapsed = math.clamp(self._time_elapsed + time, 0, duration)
end

function MissionObjectiveTimed:pause()
	self._paused = true
end

function MissionObjectiveTimed:resume()
	self._paused = false
end

function MissionObjectiveTimed:timer_paused()
	return self._paused
end

function MissionObjectiveTimed:update_progression()
	MissionObjectiveTimed.super.update_progression(self)

	local duration = self._max_incremented_progression

	if duration > 0 then
		local progression = self._time_elapsed / duration
		local timed_synchronizer_extension = self:synchronizer_extension()

		if timed_synchronizer_extension then
			progression = timed_synchronizer_extension:progression_displayed(progression)
		end

		progression = math.clamp(progression, 0, 1)

		self:set_progression(progression)
	end

	if self:max_progression_achieved() then
		self:stage_done()
	end
end

function MissionObjectiveTimed:progression_to_flow()
	local synchronizer_unit = self._synchronizer_unit

	if synchronizer_unit and ALIVE[synchronizer_unit] then
		local duration = self._max_incremented_progression

		Unit.set_flow_variable(synchronizer_unit, "lua_var_objective_time_remaining", duration * (1 - self._progression))
	end

	MissionObjectiveTimed.super.progression_to_flow(self)
end

return MissionObjectiveTimed
