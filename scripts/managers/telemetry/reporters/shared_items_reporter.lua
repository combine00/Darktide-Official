local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local SharedItemsReporter = class("SharedItemsReporter")

function SharedItemsReporter:init()
	self._reports = {}
end

function SharedItemsReporter:update(dt, t)
	return
end

function SharedItemsReporter:report()
	if table.is_empty(self._reports) then
		return
	end

	Managers.telemetry_events:shared_items_report(self._reports)
end

function SharedItemsReporter:register_event(player, item_name)
	local subject = player:telemetry_subject()
	local player_key = string.format("%s:%s", subject.account_id, subject.character_id)
	local entries = self._reports[player_key] and self._reports[player_key].entries

	if entries then
		entries[item_name] = (entries[item_name] or 0) + 1
	else
		local player_data = {
			telemetry_subject = subject,
			telemetry_game_session = player:telemetry_game_session()
		}
		self._reports[player_key] = {
			player_data = player_data,
			entries = {
				[item_name] = 1
			}
		}
	end
end

function SharedItemsReporter:destroy()
	return
end

implements(SharedItemsReporter, ReporterInterface)

return SharedItemsReporter
