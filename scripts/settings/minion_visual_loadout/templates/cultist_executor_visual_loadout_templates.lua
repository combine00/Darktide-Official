local MissionSettings = require("scripts/settings/mission/mission_settings")
local templates = {
	cultist_executor = {}
}
local zone_ids = MissionSettings.mission_zone_ids
local basic_cultist_executor_template = {
	slots = {
		slot_upperbody = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_cultists/attachments_base/upperbody_g_elite"
			}
		},
		slot_lowerbody = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_cultists/attachments_base/lowerbody_a"
			}
		},
		slot_melee_weapon = {
			use_outline = true,
			is_weapon = true,
			drop_on_death = true,
			items = {
				"content/items/weapons/minions/melee/cultist_executor_weapon"
			}
		},
		slot_flesh = {
			starts_invisible = true,
			items = {
				"content/items/characters/minions/gib_items/traitor_guard_flesh"
			}
		},
		slot_variation_gear = {
			use_outline = true,
			items = {
				"content/items/characters/minions/chaos_cultists/attachments_gear/ritualist_a"
			}
		},
		envrionmental_override = {
			is_material_override_slot = true,
			items = {
				"content/items/characters/minions/generic_items/empty_minion_item"
			}
		}
	}
}
local default_1 = table.clone(basic_cultist_executor_template)
templates.cultist_executor.default = {
	default_1
}
local foundry_1 = table.clone(basic_cultist_executor_template)
foundry_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/dirt_02"
}
templates.cultist_executor[zone_ids.tank_foundry] = {
	foundry_1
}
local dust_1 = table.clone(basic_cultist_executor_template)
dust_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/sand_02"
}
templates.cultist_executor[zone_ids.dust] = {
	dust_1
}
local watertown_1 = table.clone(basic_cultist_executor_template)
watertown_1.slots.envrionmental_override.items = {
	"content/items/characters/minions/environment_overrides/acid_02"
}
templates.cultist_executor[zone_ids.watertown] = {
	watertown_1
}

return templates
