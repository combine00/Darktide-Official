function _index_lookup_table(start_index, ...)
	local t = {}

	for ii = 1, select("#", ...) do
		local value = select(ii, ...)
		local index = start_index - 1 + ii
		t[value] = index
		t[index] = value
	end

	return t
end

local effect_mode = _index_lookup_table(0, "off", "feedback", "weapon", "vibration", "multi_position_feedback", "slope_feedback", "multi_position_vibration")
local haptic_trigger_settings = {
	trigger_index = _index_lookup_table(0, "l2", "r2"),
	trigger_mask = _index_lookup_table(1, "l2", "r2", "both"),
	effect_mode = effect_mode,
	wield_state = table.enum("none", "ranged", "melee"),
	vibration_state = table.enum("off", "starting", "active", "stopping"),
	defaults = {
		[effect_mode.weapon] = {
			start_position = 3,
			end_position = 3,
			strength = 4
		},
		[effect_mode.feedback] = {
			strength = 4,
			position = 3
		},
		[effect_mode.slope_feedback] = {
			start_position = 0,
			start_strength = 1,
			end_position = 9,
			end_strength = 5
		},
		[effect_mode.multi_position_feedback] = {
			strength = {
				4,
				7,
				0,
				2,
				4,
				6,
				0,
				3,
				6,
				0
			}
		},
		[effect_mode.vibration] = {
			frequency = 0,
			position = 2,
			amplitude = 4
		},
		[effect_mode.multi_position_vibration] = {
			frequency = 0,
			amplitude = {
				4,
				7,
				0,
				2,
				4,
				6,
				0,
				3,
				6,
				0
			}
		}
	},
	low_ammo_extra_vibration_amplitude = {
		1.25,
		1.5,
		2.25
	},
	resistance_multiplier = {
		full = 0.75,
		off = 0,
		subtle = 0.15,
		strong = 0.5
	},
	vibration_multiplier = {
		full = 1,
		off = 0,
		subtle = 0.25,
		strong = 0.75
	}
}

return settings("HapticTriggerSettings", haptic_trigger_settings)
