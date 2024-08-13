local MissionOverrides = require("scripts/settings/circumstance/mission_overrides")
local circumstance_templates = {
	friendly_explosives_01 = {
		wwise_state = "None",
		theme_tag = "default",
		mutators = {
			"mutator_explosive_friendly_fire"
		},
		ui = {
			description = "loc_circumstance_more_hordes_description",
			icon = "content/ui/materials/icons/circumstances/placeholder",
			display_name = "loc_circumstance_more_hordes_title"
		}
	}
}

return circumstance_templates
