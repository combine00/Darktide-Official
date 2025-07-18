local templates = {
	outline_types = table.enum("special_target", "psyker_marked_target", "smart_tagged_enemy", "smart_tagged_enemy_passive", "scanning", "knocked_down", "owned_companion", "allied_companion", "adamant_mark_target", "buff")
}

local function _minion_alive_check(unit)
	if not HEALTH_ALIVE[unit] then
		return false
	end

	return true
end

templates.MinionOutlineExtension = {
	special_target = {
		priority = 3,
		material_layers = {
			"minion_outline_combat_ability",
			"minion_outline_combat_ability_reversed_depth"
		},
		visibility_check = _minion_alive_check
	},
	psyker_marked_target = {
		priority = 1,
		material_layers = {
			"minion_outline_psyker"
		},
		visibility_check = _minion_alive_check
	},
	smart_tagged_enemy = {
		priority = 3,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			1,
			0.005,
			0
		},
		visibility_check = _minion_alive_check
	},
	smart_tagged_enemy_passive = {
		priority = 1,
		color = {
			0.8,
			0.75,
			0
		},
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	veteran_smart_tag = {
		priority = 1,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			1,
			0.8,
			0.4
		},
		visibility_check = _minion_alive_check
	},
	adamant_smart_tag = {
		priority = 2,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			1,
			0.25,
			0.25
		},
		visibility_check = _minion_alive_check
	},
	adamant_mark_target = {
		priority = 2,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			0.5,
			0.4,
			1
		},
		visibility_check = _minion_alive_check
	},
	hordes_tagged_remaining_target = {
		priority = 4,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			0,
			0.73,
			1
		},
		visibility_check = _minion_alive_check
	}
}
templates.CompanionOutlineExtension = {
	owned_companion = {
		priority = 2,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			0,
			0.4,
			0.1
		},
		visibility_check = function (unit)
			return true
		end
	},
	allied_companion = {
		priority = 2,
		material_layers = {
			"minion_outline",
			"minion_outline_reversed_depth"
		},
		color = {
			0.7,
			1,
			0.8
		},
		visibility_check = function (unit)
			return true
		end
	}
}
templates.PropOutlineExtension = {
	scanning = {
		priority = 2,
		material_layers = {
			"scanning"
		},
		visibility_check = function (unit)
			return true
		end
	},
	scanning_confirm = {
		priority = 1,
		material_layers = {
			"scanning",
			"scanning_reversed_depth"
		},
		visibility_check = function (unit)
			return true
		end
	}
}
templates.PlayerUnitOutlineExtension = {
	buff = {
		priority = 1,
		material_layers = {
			"player_outline_target",
			""
		},
		visibility_check = function (unit)
			return false

			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	knocked_down = {
		priority = 2,
		material_layers = {
			"player_outline_knocked_down",
			"player_outline_knocked_down_reversed_depth"
		},
		visibility_check = function (unit)
			return false

			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_both_obscured = {
		priority = 3,
		material_layers = {
			"player_outline_general",
			"player_outline_general_depth"
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_both_always = {
		priority = 3,
		material_layers = {
			"player_outline_general",
			"player_outline_general_depth"
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_outlines_always = {
		priority = 3,
		material_layers = {
			"player_outline_general",
			""
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_outlines_obscured = {
		priority = 3,
		material_layers = {
			"player_outline_general",
			""
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_mesh_always = {
		priority = 3,
		material_layers = {
			"",
			"player_outline_general_depth"
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	},
	default_mesh_obscured = {
		priority = 3,
		material_layers = {
			"",
			"player_outline_general_depth"
		},
		visibility_check = function (unit)
			if not HEALTH_ALIVE[unit] then
				return false
			end

			return true
		end
	}
}

return settings("OutlineSettings", templates)
