local MissionGiverVoSettings = {
	overrides = table.enum("sergeant_a", "pilot_a", "tech_priest_a", "tech_priest_b", "explicator_a", "purser_a", "contract_vendor_a", "sergeant_b", "training_ground_psyker_a", "shipmistress_a", "interrogator_a", "boon_vendor_a", "enginseer_a", "sergeant_c", "none")
}

return settings("MissionGiverVoSettings", MissionGiverVoSettings)
