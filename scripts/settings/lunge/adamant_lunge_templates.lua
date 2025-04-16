local ArmorSettings = require("scripts/settings/damage/armor_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local MoodSettings = require("scripts/settings/camera/mood/mood_settings")
local TalentSettings = require("scripts/settings/talent/talent_settings")
local armor_types = ArmorSettings.types
local damage_types = DamageSettings.damage_types
local talent_settings = TalentSettings.adamant
local adamant_lunge_templates = {
	adamant_charge = {
		on_screen_effect_delay = 0.13,
		is_dodging = true,
		move_back_cancel_time_threshold = 0.4,
		sensitivity_modifier = 0.1,
		move_back_cancel = true,
		on_screen_effect = "content/fx/particles/screenspace/screen_adamant_charge",
		combat_ability = true,
		disable_minion_collision = true,
		keep_slot_wielded_on_lunge_end = true,
		block_input_cancel = true,
		slot_to_wield = "slot_primary",
		block_input_cancel_time_threshold = 0.4,
		hit_dot_check = 0.7,
		stop_sound_event = "wwise/events/player/play_ability_zealot_maniac_dash_exit",
		directional_lunge = false,
		lunge_end_camera_shake = "adamant_charge_end",
		start_sound_event = "wwise/events/player/play_ability_zealot_maniac_dash_enter",
		lunge_speed_at_times = {
			{
				speed = 8,
				time_in_lunge = 0
			},
			{
				speed = 10,
				time_in_lunge = 0.1
			},
			{
				speed = 12,
				time_in_lunge = 0.15
			},
			{
				speed = 13,
				time_in_lunge = 0.2
			},
			{
				speed = 13,
				time_in_lunge = 0.25
			},
			{
				speed = 13,
				time_in_lunge = 0.35
			},
			{
				speed = 13,
				time_in_lunge = 0.4
			}
		},
		distance = talent_settings.combat_ability.charge.range,
		damage_settings = {
			radius = 2,
			anim_event_1p_on_damage = "shake_medium",
			damage_profile = DamageProfileTemplates.adamant_charge_impact,
			damage_profile_damage = DamageProfileTemplates.adamant_charge_damage,
			damage_type = damage_types.physical
		},
		anim_settings = {
			on_enter = {
				"move_fwd",
				"sprint"
			}
		},
		wwise_state = {
			group = "player_ability",
			on_state = "adamant_charge",
			off_state = "none"
		},
		stop_tags = {
			elite = true,
			special = true,
			monster = true
		},
		mood = MoodSettings.mood_types.adamant_combat_ability_charge
	}
}

return adamant_lunge_templates
