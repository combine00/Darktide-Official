local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local MispredictReporter = class("MispredictReporter")

function MispredictReporter:init()
	self._entries = {}
	self._count = 0
end

function MispredictReporter:update(dt, t)
	return
end

function MispredictReporter:report()
	Managers.telemetry_events:mispredict_report(self._entries, self._count)
end

function MispredictReporter:register_frame()
	self._count = self._count + 1
end

function MispredictReporter:register_event(tsm, component_name, field_name)
	local component_data = self._entries[component_name] or {}

	if not component_data[field_name] then
		local field_data = {
			average_t = 0,
			count = 0,
			component = component_name,
			field = field_name
		}
	end

	component_data[field_name] = field_data
	self._entries[component_name] = component_data
	field_data.count = field_data.count + 1
	field_data.average_t = field_data.average_t + (tsm - field_data.average_t) / field_data.count
end

function MispredictReporter:destroy()
	return
end

implements(MispredictReporter, ReporterInterface)

return MispredictReporter
