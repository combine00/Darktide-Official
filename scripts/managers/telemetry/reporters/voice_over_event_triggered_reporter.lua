local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local VoiceOverEventTriggeredReporter = class("VoiceOverEventTriggeredReporter")

function VoiceOverEventTriggeredReporter:init()
	self._report = {}
	self._vo_name_to_index = {}
end

function VoiceOverEventTriggeredReporter:update(dt, t)
	return
end

function VoiceOverEventTriggeredReporter:report()
	if table.is_empty(self._report) then
		return
	end

	Managers.telemetry_events:voice_over_event_triggered_report(self._report)
end

function VoiceOverEventTriggeredReporter:register_event(rule_name)
	local index = self._vo_name_to_index[rule_name]

	if not index then
		index = #self._report + 1
		self._report[index] = {
			observations = 1,
			vo_name = rule_name
		}
		self._vo_name_to_index[rule_name] = index
	else
		self._report[index].observations = self._report[index].observations + 1
	end
end

function VoiceOverEventTriggeredReporter:destroy()
	return
end

implements(VoiceOverEventTriggeredReporter, ReporterInterface)

return VoiceOverEventTriggeredReporter
