local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local PlayerTerminateEnemyReporter = class("PlayerTerminateEnemyReporter")

function PlayerTerminateEnemyReporter:init()
	self._reports = {}
end

function PlayerTerminateEnemyReporter:update(dt, t)
	return
end

function PlayerTerminateEnemyReporter:report()
	if table.is_empty(self._reports) then
		return
	end

	Managers.telemetry_events:player_terminate_enemy_report(self._reports)
end

local function compare_entry(e1, e2)
	return e1.victim == e2.victim and e1.weapon == e2.weapon and e1.attack_type == e2.attack_type and e1.damage_profile == e2.damage_profile and e1.damage_type == e2.damage_type
end

local function extract_data(entry)
	return {
		observations = 1,
		victim = entry.victim,
		weapon = entry.weapon,
		attack_type = entry.attack_type,
		damage_profile = entry.damage_profile,
		damage_type = entry.damage_type,
		damage = entry.damage,
		permanent_damage = entry.permanent_damage,
		actual_damage = entry.actual_damage,
		damage_absorbed = entry.damage_absorbed
	}
end

function PlayerTerminateEnemyReporter:register_event(player, data)
	local subject = player:telemetry_subject()
	local player_key = string.format("%s:%s", subject.account_id, subject.character_id)
	local entries = self._reports[player_key] and self._reports[player_key].entries

	if entries then
		for _, entry in pairs(entries) do
			if compare_entry(entry, data) then
				entry.damage = entry.damage + data.damage
				entry.permanent_damage = entry.permanent_damage + data.permanent_damage
				entry.actual_damage = entry.actual_damage + data.actual_damage
				entry.damage_absorbed = entry.damage_absorbed + data.damage_absorbed
				entry.observations = entry.observations + 1

				return
			end
		end

		entries[#entries + 1] = extract_data(data)
	else
		local player_data = {
			telemetry_subject = subject,
			telemetry_game_session = player:telemetry_game_session()
		}
		self._reports[player_key] = {
			player_data = player_data,
			entries = {
				extract_data(data)
			}
		}
	end
end

function PlayerTerminateEnemyReporter:destroy()
	return
end

implements(PlayerTerminateEnemyReporter, ReporterInterface)

return PlayerTerminateEnemyReporter
