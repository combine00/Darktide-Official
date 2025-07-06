local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local ability_template = {
	action_inputs = {
		aim_pressed = {
			buffer_time = 0.1,
			input_sequence = {
				{
					value = true,
					input = "grenade_ability_pressed"
				}
			}
		},
		aim_released = {
			buffer_time = 0.1,
			input_sequence = {
				{
					value = false,
					input = "grenade_ability_hold",
					time_window = math.huge
				}
			}
		}
	},
	action_input_hierarchy = {
		{
			input = "aim_pressed",
			transition = {
				{
					transition = "base",
					input = "aim_released"
				}
			}
		}
	},
	actions = {
		action_aim = {
			start_input = "aim_pressed",
			kind = "shout_aim",
			allowed_during_lunge = true,
			allowed_during_sprint = true,
			ability_type = "grenade_ability",
			minimum_hold_time = 0.075,
			total_time = math.huge,
			radius = RADIUS,
			allowed_chain_actions = {
				aim_released = {
					action_name = "action_order_companion"
				}
			}
		},
		action_order_companion = {
			allowed_during_sprint = true,
			ability_type = "grenade_ability",
			trigger_time = 0.3,
			use_ability_charge = true,
			kind = "order_companion",
			sprint_ready_up_time = 0,
			uninterruptible = true,
			total_time = 1
		}
	},
	fx_sources = {},
	hud_configuration = {
		uses_overheat = false,
		uses_ammunition = true
	},
	keywords = {
		"adamant"
	},
	anim_state_machine_3p = "content/characters/player/human/third_person/animations/psyker_smite",
	anim_state_machine_1p = "content/characters/player/human/first_person/animations/throwing_knives",
	smart_targeting_template = SmartTargetingTemplates.default_melee,
	hud_icon = "content/ui/materials/icons/throwables/hud/adamant_whistle"
}

return ability_template
