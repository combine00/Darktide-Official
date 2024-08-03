local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local TacticalOverlayReporter = class("TacticalOverlayReporter")

function TacticalOverlayReporter:init()
	self._report = {
		times_opened = 0
	}
end

function TacticalOverlayReporter:update(dt, t)
	return
end

function TacticalOverlayReporter:report()
	if table.is_empty(self._report) then
		return
	end

	Managers.telemetry_events:tactical_overlay_report(self._report)
end

function TacticalOverlayReporter:register_event(penance_count)
	self._report.times_opened = self._report.times_opened + 1
	self._report.tracked_penances = penance_count
end

function TacticalOverlayReporter:destroy()
	return
end

implements(TacticalOverlayReporter, ReporterInterface)

return TacticalOverlayReporter
