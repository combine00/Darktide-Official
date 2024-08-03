local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local VoiceOverBankReshuffledReporter = class("VoiceOverBankReshuffledReporter")

function VoiceOverBankReshuffledReporter:init()
	self._report = {}
	self._vo_name_to_index = {}
end

function VoiceOverBankReshuffledReporter:update(dt, t)
	return
end

function VoiceOverBankReshuffledReporter:report()
	if table.is_empty(self._report) then
		return
	end

	Managers.telemetry_events:voice_over_bank_reshuffled_report(self._report)
end

function VoiceOverBankReshuffledReporter:register_event(bank_name)
	local index = self._vo_name_to_index[bank_name]

	if not index then
		index = #self._report + 1
		self._report[index] = {
			observations = 1,
			vo_name = bank_name
		}
		self._vo_name_to_index[bank_name] = index
	else
		self._report[index].observations = self._report[index].observations + 1
	end
end

function VoiceOverBankReshuffledReporter:destroy()
	return
end

implements(VoiceOverBankReshuffledReporter, ReporterInterface)

return VoiceOverBankReshuffledReporter
