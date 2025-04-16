local HazardPropOverrides = {
	no_empty_hazards = {
		hazard_prop_settings = {
			explosion = 1,
			fire = 1,
			none = 0
		}
	},
	all_fire_barrels = {
		hazard_prop_settings = {
			explosion = 0,
			fire = 1,
			none = 0
		}
	}
}

return HazardPropOverrides
