local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local FixedUpdateMissedInputsReporter = class("FixedUpdateMissedInputsReporter")

function FixedUpdateMissedInputsReporter:init()
	self._reports = {}
end

function FixedUpdateMissedInputsReporter:update(dt, t)
	return
end

function FixedUpdateMissedInputsReporter:report()
	if table.is_empty(self._reports) then
		return
	end

	Managers.telemetry_events:fixed_update_missed_inputs_report(self._reports)
end

function FixedUpdateMissedInputsReporter:register_event(player)
	local subject = player:telemetry_subject()
	local player_key = string.format("%s:%s", subject.account_id, subject.character_id)
	local entries = self._reports[player_key] and self._reports[player_key].entries

	if entries then
		self._reports[player_key].entries = entries + 1
	else
		local player_data = {
			telemetry_subject = subject,
			telemetry_game_session = player:telemetry_game_session()
		}
		self._reports[player_key] = {
			entries = 1,
			player_data = player_data
		}
	end
end

function FixedUpdateMissedInputsReporter:destroy()
	return
end

implements(FixedUpdateMissedInputsReporter, ReporterInterface)

return FixedUpdateMissedInputsReporter
