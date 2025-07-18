local BuffSettings = require("scripts/settings/buff/buff_settings")
local templates = {}

table.make_unique(templates)

local stat_buffs = BuffSettings.stat_buffs
templates.weapon_trait_bespoke_combatknife_p1_stacking_rending_on_weakspot = {
	format_values = {
		rending = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_stacking_rending_on_weakspot_parent",
				find_value_type = "trait_override",
				path = {
					"stat_buffs",
					stat_buffs.rending_multiplier
				}
			}
		},
		time = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_stacking_rending_on_weakspot_parent",
				find_value_type = "buff_template",
				path = {
					"child_duration"
				}
			}
		},
		stacks = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_stacking_rending_on_weakspot_parent",
				find_value_type = "trait_override",
				path = {
					"max_stacks"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_stacking_rending_on_weakspot_parent = {
			{
				max_stacks = 5,
				stat_buffs = {
					[stat_buffs.rending_multiplier] = 0.12
				}
			},
			{
				max_stacks = 5,
				stat_buffs = {
					[stat_buffs.rending_multiplier] = 0.16
				}
			},
			{
				max_stacks = 5,
				stat_buffs = {
					[stat_buffs.rending_multiplier] = 0.2
				}
			},
			{
				max_stacks = 5,
				stat_buffs = {
					[stat_buffs.rending_multiplier] = 0.24
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_chained_weakspot_hits_increases_power = {
	format_values = {
		power_level = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_chained_weakspot_hits_increases_power_parent",
				find_value_type = "trait_override",
				path = {
					"stat_buffs",
					stat_buffs.melee_power_level_modifier
				}
			}
		},
		stacks = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_chained_weakspot_hits_increases_power_child",
				find_value_type = "buff_template",
				path = {
					"max_stacks"
				}
			}
		},
		time = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_chained_weakspot_hits_increases_power_parent",
				find_value_type = "buff_template",
				path = {
					"child_duration"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_chained_weakspot_hits_increases_power_parent = {
			{
				stat_buffs = {
					[stat_buffs.melee_power_level_modifier] = 0.045
				}
			},
			{
				stat_buffs = {
					[stat_buffs.melee_power_level_modifier] = 0.05
				}
			},
			{
				stat_buffs = {
					[stat_buffs.melee_power_level_modifier] = 0.055
				}
			},
			{
				stat_buffs = {
					[stat_buffs.melee_power_level_modifier] = 0.06
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_heavy_chained_hits_increases_killing_blow_chance = {
	format_values = {
		proc_chance = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_heavy_chained_hits_increases_killing_blow_chance_parent",
				find_value_type = "trait_override",
				path = {
					"target_buff_data",
					"killing_blow_chance"
				}
			}
		},
		stacks = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_heavy_chained_hits_increases_killing_blow_chance_parent",
				find_value_type = "buff_template",
				path = {
					"max_stacks"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_heavy_chained_hits_increases_killing_blow_chance_parent = {
			{
				target_buff_data = {
					killing_blow_chance = 0.01
				}
			},
			{
				target_buff_data = {
					killing_blow_chance = 0.02
				}
			},
			{
				target_buff_data = {
					killing_blow_chance = 0.03
				}
			},
			{
				target_buff_data = {
					killing_blow_chance = 0.04
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_dodge_grants_finesse_bonus = {
	format_values = {
		damage = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_dodge_grants_finesse_bonus",
				find_value_type = "trait_override",
				path = {
					"proc_stat_buffs",
					stat_buffs.finesse_modifier_bonus
				}
			}
		},
		time = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_dodge_grants_finesse_bonus",
				find_value_type = "trait_override",
				path = {
					"active_duration"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_dodge_grants_finesse_bonus = {
			{
				active_duration = 2,
				proc_stat_buffs = {
					[stat_buffs.finesse_modifier_bonus] = 0.45
				}
			},
			{
				active_duration = 2,
				proc_stat_buffs = {
					[stat_buffs.finesse_modifier_bonus] = 0.5
				}
			},
			{
				active_duration = 2,
				proc_stat_buffs = {
					[stat_buffs.finesse_modifier_bonus] = 0.55
				}
			},
			{
				active_duration = 2,
				proc_stat_buffs = {
					[stat_buffs.finesse_modifier_bonus] = 0.6
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_dodge_grants_critical_strike_chance = {
	format_values = {
		crit_chance = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_dodge_grants_critical_strike_chance",
				find_value_type = "trait_override",
				path = {
					"proc_stat_buffs",
					stat_buffs.critical_strike_chance
				}
			}
		},
		time = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_dodge_grants_critical_strike_chance",
				find_value_type = "buff_template",
				path = {
					"active_duration"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_dodge_grants_critical_strike_chance = {
			{
				proc_stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.125
				}
			},
			{
				proc_stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.15
				}
			},
			{
				proc_stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.175
				}
			},
			{
				proc_stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.2
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_bleed_on_non_weakspot_hit = {
	format_values = {
		stacks = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_bleed_on_non_weakspot_hit",
				find_value_type = "trait_override",
				path = {
					"target_buff_data",
					"num_stacks_on_proc"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_bleed_on_non_weakspot_hit = {
			{
				target_buff_data = {
					num_stacks_on_proc = 1
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 2
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 3
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 4
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_bleed_on_crit = {
	format_values = {
		stacks = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_bleed_on_crit",
				find_value_type = "trait_override",
				path = {
					"target_buff_data",
					"num_stacks_on_proc"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_bleed_on_crit = {
			{
				target_buff_data = {
					num_stacks_on_proc = 5
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 6
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 7
				}
			},
			{
				target_buff_data = {
					num_stacks_on_proc = 8
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_rending_on_backstab = {
	format_values = {
		rending = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_rending_on_backstab",
				find_value_type = "trait_override",
				path = {
					"conditional_stat_buffs",
					stat_buffs.backstab_rending_multiplier
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_rending_on_backstab = {
			{
				conditional_stat_buffs = {
					[stat_buffs.backstab_rending_multiplier] = 0.7
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.backstab_rending_multiplier] = 0.8
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.backstab_rending_multiplier] = 0.9
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.backstab_rending_multiplier] = 1
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_increased_weakspot_damage_against_bleeding = {
	format_values = {
		damage = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_increased_weakspot_damage_against_bleeding",
				find_value_type = "trait_override",
				path = {
					"conditional_stat_buffs",
					stat_buffs.melee_weakspot_damage_vs_bleeding
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_increased_weakspot_damage_against_bleeding = {
			{
				conditional_stat_buffs = {
					[stat_buffs.melee_weakspot_damage_vs_bleeding] = 0.525
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.melee_weakspot_damage_vs_bleeding] = 0.55
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.melee_weakspot_damage_vs_bleeding] = 0.575
				}
			},
			{
				conditional_stat_buffs = {
					[stat_buffs.melee_weakspot_damage_vs_bleeding] = 0.6
				}
			}
		}
	}
}
templates.weapon_trait_bespoke_combatknife_p1_increased_crit_chance_on_staggered_weapon_special_hit = {
	format_values = {
		crit_chance = {
			prefix = "+",
			format_type = "percentage",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_increased_crit_chance_on_staggered_weapon_special_hit_parent",
				find_value_type = "trait_override",
				path = {
					"stat_buffs",
					stat_buffs.critical_strike_chance
				}
			}
		},
		time = {
			format_type = "number",
			find_value = {
				buff_template_name = "weapon_trait_bespoke_combatknife_p1_increased_crit_chance_on_staggered_weapon_special_hit_parent",
				find_value_type = "buff_template",
				path = {
					"child_duration"
				}
			}
		}
	},
	buffs = {
		weapon_trait_bespoke_combatknife_p1_increased_crit_chance_on_staggered_weapon_special_hit_parent = {
			{
				stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.125
				}
			},
			{
				stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.15
				}
			},
			{
				stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.175
				}
			},
			{
				stat_buffs = {
					[stat_buffs.critical_strike_chance] = 0.2
				}
			}
		}
	}
}

return templates
