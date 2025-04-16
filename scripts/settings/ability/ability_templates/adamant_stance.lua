local ability_template = {
	action_inputs = {
		stance_pressed = {
			buffer_time = 0.5,
			input_sequence = {
				{
					value = true,
					input = "combat_ability_pressed"
				}
			}
		}
	},
	action_input_hierarchy = {
		{
			transition = "stay",
			input = "stance_pressed"
		}
	},
	actions = {
		action_stance_change = {
			refill_toughness = true,
			use_ability_charge = true,
			start_input = "stance_pressed",
			use_charge_at_start = true,
			kind = "stance_change",
			sprint_ready_up_time = 0,
			vo_tag = "ability_adamant_stance",
			anim_3p = "ability_buff",
			abort_sprint = true,
			uninterruptible = true,
			anim = "ability_overcharge",
			allowed_during_sprint = true,
			ability_type = "combat_ability",
			block_weapon_actions = false,
			prevent_sprint = true,
			total_time = 1
		}
	},
	fx_sources = {},
	ability_meta_data = {
		activation = {
			action_input = "stance_pressed"
		}
	}
}

return ability_template
