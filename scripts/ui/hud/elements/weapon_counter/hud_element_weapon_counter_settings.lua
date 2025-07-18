local shield_size = {
	31,
	38
}
local hud_element_weapon_counter_settings = {
	max_glow_alpha = 130,
	spacing = 0,
	half_distance = 1,
	center_offset = 200,
	size = shield_size,
	area_size = {
		shield_size[1] * 12,
		shield_size[2]
	},
	glow_size = {
		29,
		29
	},
	templates = {
		"scripts/ui/hud/elements/weapon_counter/templates/weapon_counter_template_block_charges",
		"scripts/ui/hud/elements/weapon_counter/templates/weapon_counter_template_kill_charges",
		"scripts/ui/hud/elements/weapon_counter/templates/weapon_counter_template_overheat_lockout"
	}
}

return settings("HudElementWeaponCounterSettings", hud_element_weapon_counter_settings)
