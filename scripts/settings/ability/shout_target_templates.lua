local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local TalentSettings = require("scripts/settings/talent/talent_settings")
local shout_target_templates = {
	veteran_shout = {
		enemies = {
			power_level = 500,
			force_stagger_type_if_not_staggered = "heavy",
			force_stagger_type_if_not_staggered_duration = 2.5,
			damage_profile = DamageProfileTemplates.shout_stagger_veteran
		},
		allies = {
			revive_allies = true
		}
	},
	ogryn_shout = {
		enemies = {
			buff_to_add = "taunted",
			force_stagger_duration = 1,
			special_rule_buff_enemy = "ogryn_taunt_increased_damage_taken_buff",
			force_stagger_type = "light",
			power_level = 500,
			buff_ignored_breeds = {
				chaos_mutator_ritualist = true,
				chaos_mutator_daemonhost = true,
				chaos_daemonhost = true
			},
			can_not_hit = {
				chaos_mutator_ritualist = true,
				chaos_mutator_daemonhost = true
			},
			damage_profile = DamageProfileTemplates.shout_stagger_ogryn_taunt
		}
	}
}
shout_target_templates.ogryn_shout_no_stagger = table.clone(shout_target_templates.ogryn_shout)
shout_target_templates.ogryn_shout_no_stagger.enemies.power_level = 0
shout_target_templates.ogryn_shout_no_stagger.enemies.force_stagger_duration = nil
shout_target_templates.ogryn_shout_no_stagger.enemies.force_stagger_type = nil
shout_target_templates.ogryn_shout_no_stagger.enemies.damage_profile = nil
shout_target_templates.hordes_zealot_lunge_shout = {
	enemies = {
		power_level = 500,
		force_stagger_type_if_not_staggered = "heavy",
		force_stagger_type_if_not_staggered_duration = 2.5,
		damage_profile = DamageProfileTemplates.shout_stagger_veteran
	}
}

return settings("ShoutTargetTemplates", shout_target_templates)
