local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local ExplosionTemplates = require("scripts/settings/damage/explosion_templates")
local hitscan_templates = {}
local overrides = {}

table.make_unique(hitscan_templates)
table.make_unique(overrides)

hitscan_templates.default_boltpistol_hitscan = {
	range = 75,
	damage = {
		explosion_arming_distance = 5,
		impact = {
			damage_profile = DamageProfileTemplates.default_boltpistol_damage,
			hitmass_consumed_explosion = {
				kill_explosion_template = ExplosionTemplates.boltpistol_shell_kill,
				stop_explosion_template = ExplosionTemplates.boltpistol_shell_stop
			}
		},
		penetration = {
			depth = 0.75,
			target_index_increase = 2,
			stop_explosion_template = ExplosionTemplates.boltpistol_shell_stop
		}
	},
	collision_tests = {
		{
			against = "statics",
			test = "ray",
			collision_filter = "filter_player_character_shooting_raycast_statics"
		},
		{
			against = "dynamics",
			test = "sphere",
			radius = 0.1,
			collision_filter = "filter_player_character_shooting_raycast_dynamics"
		}
	}
}

return {
	base_templates = hitscan_templates,
	overrides = overrides
}
