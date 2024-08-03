local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local PacingReporter = class("PacingReporter")
local SAMPLE_INTERVAL = 45

function PacingReporter:init(params)
	self._last_sample_time = 0
	self._last_tension_sample = 0
end

function PacingReporter:destroy()
	return
end

function PacingReporter:update(dt, t)
	if not Managers.state or not Managers.state.pacing then
		return
	end

	local tension = Managers.state.pacing:tension()
	local travel_progress = Managers.state.main_path:furthest_travel_percentage(1)

	if SAMPLE_INTERVAL < t - self._last_sample_time and tension ~= self._last_tension_sample then
		Managers.telemetry_events:pacing(tension, travel_progress)

		self._last_tension_sample = tension
		self._last_sample_time = math.floor(t)
	end
end

function PacingReporter:report()
	return
end

implements(PacingReporter, ReporterInterface)

return PacingReporter
