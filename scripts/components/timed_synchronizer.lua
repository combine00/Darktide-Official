local TimedSynchronizer = component("TimedSynchronizer")

function TimedSynchronizer:init(unit, is_server)
	local timed_synchronizer_extension = ScriptUnit.fetch_component_extension(unit, "event_synchronizer_system")
	self._unit = unit
	self._is_server = is_server

	if timed_synchronizer_extension then
		local objective_name = self:get_data(unit, "objective_name")
		local auto_start = self:get_data(unit, "automatic_start")
		local curve_power = self:get_data(unit, "curve_power")

		timed_synchronizer_extension:setup_from_component(objective_name, auto_start, curve_power)

		self._timed_synchronizer_extension = timed_synchronizer_extension
	end
end

function TimedSynchronizer:editor_init(unit)
	return
end

function TimedSynchronizer:editor_validate(unit)
	return true, ""
end

function TimedSynchronizer:start_timed_event()
	if self._timed_synchronizer_extension then
		self._timed_synchronizer_extension:start_event()
	end
end

function TimedSynchronizer:add_time()
	if self._timed_synchronizer_extension then
		local time = self:get_data(self._unit, "time_to_add")

		self._timed_synchronizer_extension:add_time(time)
	end
end

function TimedSynchronizer:pause()
	if self._timed_synchronizer_extension and self._is_server then
		self._timed_synchronizer_extension:pause_event()
	end
end

function TimedSynchronizer:resume()
	if self._timed_synchronizer_extension and self._is_server then
		self._timed_synchronizer_extension:resume_event()
	end
end

function TimedSynchronizer:enable(unit)
	return
end

function TimedSynchronizer:disable(unit)
	return
end

function TimedSynchronizer:destroy(unit)
	return
end

TimedSynchronizer.component_data = {
	objective_name = {
		ui_type = "text_box",
		value = "default",
		ui_name = "Objective name"
	},
	automatic_start = {
		ui_type = "check_box",
		value = false,
		ui_name = "Automatic Start On Mission Start"
	},
	time_to_add = {
		ui_type = "number",
		value = 0,
		ui_name = "Time To Add"
	},
	curve_power = {
		ui_type = "number",
		value = 1,
		ui_name = "Curve Power"
	},
	inputs = {
		start_timed_event = {
			accessibility = "public",
			type = "event"
		},
		add_time = {
			accessibility = "public",
			type = "event"
		},
		pause = {
			accessibility = "public",
			type = "event"
		},
		resume = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"TimedSynchronizerExtension"
	}
}

return TimedSynchronizer
