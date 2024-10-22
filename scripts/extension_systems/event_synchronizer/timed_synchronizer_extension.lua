local TimedSynchronizerExtension = class("TimedSynchronizerExtension", "EventSynchronizerBaseExtension")

function TimedSynchronizerExtension:init(extension_init_context, unit, extension_init_data, ...)
	TimedSynchronizerExtension.super.init(self, extension_init_context, unit, extension_init_data, ...)

	self._objective_name = "default"
end

function TimedSynchronizerExtension:setup_from_component(objective_name, auto_start, curve_power, rubberband_ratio, rubberband_over_progression)
	self._objective_name = objective_name
	self._auto_start = auto_start
	self._curve_power = curve_power
	self._rubberband_ratio = rubberband_ratio
	self._rubberband_over_progression = rubberband_over_progression

	self._mission_objective_system:register_objective_synchronizer(objective_name, self._unit)
end

function TimedSynchronizerExtension:objective_started()
	TimedSynchronizerExtension.super.objective_started(self)

	if self._is_server then
		self._start_progress = Managers.state.main_path:furthest_travel_percentage(1)
	end
end

function TimedSynchronizerExtension:add_time(time)
	if self._is_server then
		local mission_objective = self._mission_objective_system:active_objective(self._objective_name)

		mission_objective:add_time(time)
	end
end

function TimedSynchronizerExtension:rubberband_time(dt)
	if self._rubberband_ratio <= 0 then
		return dt
	end

	local progress = math.clamp((Managers.state.main_path:furthest_travel_percentage(1) - self._start_progress) / self._rubberband_over_progression, 0, 1)

	return math.lerp(1 - self._rubberband_ratio, 1, progress) * dt
end

function TimedSynchronizerExtension:progression_displayed(progression)
	if self._curve_power == 1 or progression > 1 then
		return progression
	end

	return 1 - math.pow(1 - progression, self._curve_power)
end

return TimedSynchronizerExtension
