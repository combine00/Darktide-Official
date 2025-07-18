local DamageSettings = require("scripts/settings/damage/damage_settings")
local HitScanTemplates = require("scripts/settings/projectile/hit_scan_templates")
local LineEffects = require("scripts/settings/effects/line_effects")
local damage_types = DamageSettings.damage_types
local renegade_plasma_shocktrooper_default = {
	shoot_vfx_name = "content/fx/particles/weapons/rifles/shotgun/shotgun_rifle_muzzle",
	shoot_sound_event = "wwise/events/weapon/play_weapon_shotgun_chaos",
	scope_reflection_vfx_name = "content/fx/particles/enemies/assault_scope_flash",
	collision_filter = "filter_minion_shooting",
	shotgun_blast = true,
	scope_reflection_timing = 1,
	scope_reflection_distance = 3,
	hit_scan_template = HitScanTemplates.shocktrooper_shotgun_bullet,
	spread = math.degrees_to_radians(1),
	damage_type = damage_types.minion_pellet,
	line_effect = LineEffects.renegade_pellet,
	damage_falloff = {
		falloff_range = 15,
		max_range = 8,
		max_power_reduction = 0.6
	}
}
local renegade_plasma_shocktrooper_plasma_beam = {
	shoot_vfx_name = "content/fx/particles/enemies/renegade_plasma_trooper/renegade_plasma_muzzle",
	shoot_sound_event = "wwise/events/weapon/play_minion_plasmapistol",
	collision_filter = "filter_minion_shooting",
	damage_type = damage_types.minion_laser,
	line_effect = LineEffects.renegade_captain_plasma_beam,
	hit_scan_template = HitScanTemplates.renegade_captain_plasma_pistol_plasma,
	spread = math.degrees_to_radians(0.1),
	damage_falloff = {
		falloff_range = 25,
		max_range = 25,
		max_power_reduction = 0.5
	}
}
local shoot_templates = {
	renegade_plasma_shocktrooper_default = renegade_plasma_shocktrooper_default,
	renegade_plasma_shocktrooper_plasma_beam = renegade_plasma_shocktrooper_plasma_beam
}

return shoot_templates
