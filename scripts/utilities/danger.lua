local DangerSettings = require("scripts/settings/difficulty/danger_settings")
local PlayerProgressionUnlocks = require("scripts/settings/player/player_progression_unlocks")
local QPCode = require("scripts/utilities/qp_code")
local TextUtilities = require("scripts/utilities/ui/text")
local Danger = {}

function Danger.danger_by_qp_code(qp_code)
	local qp_keys = QPCode.decode(qp_code)
	local challenge = qp_keys.challenge
	local resistance = qp_keys.resistance

	return Danger.danger_by_difficulty(challenge, resistance)
end

function Danger.danger_by_mission(mission_data)
	local challenge = mission_data.challenge
	local resistance = mission_data.resistance

	return Danger.danger_by_difficulty(challenge, resistance)
end

function Danger.danger_by_difficulty(challenge, resistance)
	local index = Danger.calculate_danger(challenge, resistance)

	return DangerSettings[index]
end

function Danger.calculate_danger(challenge, resistance)
	local danger_by_index = DangerSettings

	for i = 1, #danger_by_index do
		local danger = danger_by_index[i]
		local correct_challenge = danger.challenge == challenge
		local correct_resistance = resistance == nil or danger.resistance == resistance

		if correct_challenge and correct_resistance then
			return i
		end
	end
end

function Danger.required_level_by_mission_type(index, mission_type)
	return DangerSettings[index] and DangerSettings[index].unlocks_at
end

function Danger.text_bars(difficulty_index)
	local difficulty_settings = DangerSettings[difficulty_index]
	local difficulty_color = difficulty_settings and difficulty_settings.color

	if not difficulty_color then
		return nil
	end

	local pre = TextUtilities.apply_color_to_text(" ", Color.terminal_text_header(255, true))
	local before = TextUtilities.apply_color_to_text(string.rep("", difficulty_index), difficulty_settings.color)
	local post = ""
	local remaining_count = #DangerSettings - difficulty_index

	if remaining_count > 0 then
		post = string.rep("", remaining_count)
	end

	return string.format("%s%s%s", pre, before, post)
end

function Danger.index_by_name(name)
	for i = 1, #DangerSettings do
		local danger = DangerSettings[i]

		if danger.name == name then
			return i
		end
	end
end

return Danger
