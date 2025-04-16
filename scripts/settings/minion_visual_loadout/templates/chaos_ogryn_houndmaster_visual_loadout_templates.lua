local MissionSettings = require("scripts/settings/mission/mission_settings")
local zone_ids = MissionSettings.mission_zone_ids
local templates = {
	chaos_ogryn_houndmaster = {}
}
local basic_chaos_ogryn_houndmaster_template = {
	slots = {
		slot_base_lowerbody = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_gear/houndmaster_lower"
			}
		},
		slot_base_arms = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_base/arms_a",
				"content/items/characters/minions/chaos_ogryn/attachments_base/arms_a_tattoo_01",
				"content/items/characters/minions/chaos_ogryn/attachments_base/arms_a_tattoo_02",
				"content/items/characters/minions/chaos_ogryn/attachments_base/arms_a_tattoo_03"
			}
		},
		slot_melee_weapon = {
			use_outline = true,
			is_weapon = true,
			drop_on_death = true,
			items = {
				"content/items/weapons/minions/melee/chaos_ogryn_melee_weapon"
			}
		},
		slot_melee_weapon_offhand = {
			use_outline = true,
			is_weapon = true,
			drop_on_death = true,
			items = {
				"content/items/weapons/minions/melee/chaos_ogryn_offhand_melee_weapon"
			}
		},
		slot_headgear = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_gear/melee_head_attachment_02",
				"content/items/characters/minions/chaos_ogryn/attachments_gear/melee_head_attachment_03",
				"content/items/characters/minions/generic_items/empty_minion_item"
			}
		},
		slot_base_attachment = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_base/skin_attachment_01_b",
				"content/items/characters/minions/generic_items/empty_minion_item"
			}
		},
		slot_head_attachment = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_gear/houndmaster_head"
			}
		},
		slot_head = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_base/head_b",
				"content/items/characters/minions/chaos_ogryn/attachments_base/head_b_tattoo_01",
				"content/items/characters/minions/chaos_ogryn/attachments_base/head_b_tattoo_02",
				"content/items/characters/minions/chaos_ogryn/attachments_base/head_b_tattoo_03"
			}
		},
		slot_gear_attachment = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_ogryn/attachments_gear/houndmaster_upper"
			}
		},
		slot_flesh = {
			starts_invisible = true,
			items = {
				"content/items/characters/minions/gib_items/chaos_ogryn_flesh"
			}
		},
		envrionmental_override = {
			is_material_override_slot = true,
			items = {
				"content/items/characters/minions/generic_items/empty_minion_item"
			}
		},
		skin_color_override = {
			is_material_override_slot = true,
			items = {
				"content/items/characters/minions/generic_items/empty_minion_item",
				"content/items/characters/minions/skin_color_overrides/chaos_skin_color_01",
				"content/items/characters/minions/skin_color_overrides/chaos_skin_color_02",
				"content/items/characters/minions/skin_color_overrides/chaos_skin_color_03"
			}
		}
	}
}
local default_1 = table.clone(basic_chaos_ogryn_houndmaster_template)
templates.chaos_ogryn_houndmaster.default = {
	default_1
}
local foundry_1 = table.clone(basic_chaos_ogryn_houndmaster_template)
foundry_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/dirt_02"
}
templates.chaos_ogryn_houndmaster[zone_ids.tank_foundry] = {
	foundry_1
}
local dust_1 = table.clone(basic_chaos_ogryn_houndmaster_template)
dust_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/sand_02"
}
templates.chaos_ogryn_houndmaster[zone_ids.dust] = {
	dust_1
}
local watertown_1 = table.clone(basic_chaos_ogryn_houndmaster_template)
watertown_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/acid_02"
}
templates.chaos_ogryn_houndmaster[zone_ids.watertown] = {
	watertown_1
}

return templates
