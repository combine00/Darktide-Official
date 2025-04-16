local breed_settings = {
	types = table.enum("living_prop", "minion", "objective_prop", "player", "prop")
}

return settings("BreedSettings", breed_settings)
