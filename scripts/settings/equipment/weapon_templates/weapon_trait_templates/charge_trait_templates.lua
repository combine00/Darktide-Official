local charge_trait_templates = {
	forcestaff_p1_m1_charge_speed_stat = {
		{
			"charge_duration",
			{
				max = 0.8,
				min = 0.2
			}
		}
	},
	forcestaff_p1_m1_charge_speed_perk = {
		{
			"charge_duration",
			0.05
		}
	},
	forcestaff_p1_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"forcestaff_p1_m1_use_aoe",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcestaff_p1_m1_warp_charge_cost_perk = {
		{
			"warp_charge_percent",
			0.05
		},
		{
			"full_charge_warp_charge_percent",
			0.05
		}
	},
	forcestaff_p2_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcestaff_p3_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcestaff_p3_m1_charge_speed_stat = {
		{
			"charge_duration",
			{
				max = 0.8,
				min = 0.2
			}
		}
	},
	forcestaff_p4_m1_charge_speed_stat = {
		{
			"charge_duration",
			{
				max = 0.8,
				min = 0.2
			}
		}
	},
	forcestaff_p4_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcestaff_secondary_action_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 1,
				min = 0
			}
		}
	},
	forcesword_p1_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcesword_p1_m1_warp_charge_cost_perk = {
		{
			"warp_charge_percent",
			0.05
		},
		{
			"full_charge_warp_charge_percent",
			0.05
		}
	},
	forcesword_p1_m1_weapon_special_warp_charge_cost = {
		{
			"warp_charge_percent",
			{
				max = 0.9,
				min = 0.1
			}
		}
	},
	forcesword_2h_p1_m1_warp_charge_cost_stat = {
		{
			"warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		},
		{
			"full_charge_warp_charge_percent",
			{
				max = 0.75,
				min = 0.25
			}
		}
	},
	forcesword_2h_p1_m1_warp_charge_cost_perk = {
		{
			"warp_charge_percent",
			0.05
		},
		{
			"full_charge_warp_charge_percent",
			0.05
		}
	},
	forcesword_2h_p1_m1_weapon_special_warp_charge_cost = {
		{
			"warp_charge_percent",
			{
				max = 1,
				min = 0.1
			}
		}
	},
	plasmagun_charge_speed_stat = {
		{
			"charge_duration",
			{
				max = 1,
				min = 0
			}
		}
	},
	plasmagun_charge_cost_stat = {
		{
			"overheat_percent",
			{
				max = 1,
				min = 0
			}
		},
		{
			"full_charge_overheat_percent",
			{
				max = 1,
				min = 0
			}
		}
	},
	powersword_2h_p1_heat_stat = {
		{
			"overheat_overtime",
			"overheat_percent",
			{
				max = 1,
				min = 0
			}
		},
		{
			"overheat_swing",
			"overheat_percent",
			{
				max = 1,
				min = 0
			}
		},
		{
			"overheat_decay",
			"auto_vent_duration",
			{
				max = 1,
				min = 0
			}
		}
	}
}

return charge_trait_templates
