local ArchetypeDodgeTemplates = require("scripts/settings/dodge/archetype_dodge_templates")
local ArchetypeSprintTemplates = require("scripts/settings/sprint/archetype_sprint_templates")
local ArchetypeStaminaTemplates = require("scripts/settings/stamina/archetype_stamina_templates")
local ArchetypeTalents = require("scripts/settings/ability/archetype_talents/archetype_talents")
local ArchetypeToughnessTemplates = require("scripts/settings/toughness/archetype_toughness_templates")
local ArchetypeWarpChargeTemplates = require("scripts/settings/warp_charge/archetype_warp_charge_templates")
local UiSoundEvents = require("scripts/settings/ui/ui_sound_events")
local Promise = require("scripts/foundation/utilities/promise")
local archetype_data = {
	archetype_description = "loc_class_zealot_description",
	archetype_background_large = "content/ui/materials/icons/classes/large/zealot",
	archetype_icon_selection_large_unselected = "content/ui/materials/icons/classes/zealot_terminal_shadow",
	talent_layout_file_path = "scripts/ui/views/talent_builder_view/layouts/zealot_tree",
	archetype_selection_icon = "content/ui/textures/frames/class_selection/windows/class_selection_top_zealot_unselected",
	archetype_selection_level = "content/levels/ui/class_selection/class_selection_zealot/class_selection_zealot",
	archetype_title = "loc_class_zealot_title",
	archetype_selection_background = "content/ui/materials/backgrounds/info_panels/zealot",
	base_critical_strike_chance = 0.05,
	archetype_selection_highlight_icon = "content/ui/textures/frames/class_selection/windows/class_selection_top_zealot",
	archetype_badge = "content/ui/materials/icons/class_badges/zealot_01_01",
	archetype_video = "content/videos/class_selection/zealot_2",
	ui_selection_order = 2,
	talents_package_path = "packages/ui/views/talent_builder_view/zealot",
	archetype_name = "loc_class_zealot_name",
	archetype_icon_selection_large = "content/ui/materials/icons/classes/zealot_terminal",
	archetype_icon_large = "content/ui/materials/icons/classes/zealot",
	health = 200,
	breed = "human",
	knocked_down_health = 1000,
	toughness = ArchetypeToughnessTemplates.zealot,
	dodge = ArchetypeDodgeTemplates.zealot,
	sprint = ArchetypeSprintTemplates.default,
	stamina = ArchetypeStaminaTemplates.zealot,
	warp_charge = ArchetypeWarpChargeTemplates.default,
	talents = ArchetypeTalents.zealot,
	base_talents = {
		zealot_shock_grenade = 1,
		zealot_dash = 1,
		zealot_toughness_damage_coherency = 1
	},
	selection_sound_event = UiSoundEvents.character_create_archetype_zealot,
	unique_weapons = {
		{
			item = "content/items/weapons/player/melee/chainsword_2h_p1_m1",
			display_name = "loc_class_selection_unique_weapon_zealot_melee_1"
		},
		{
			item = "content/items/weapons/player/ranged/flamer_p1_m1",
			display_name = "loc_class_selection_unique_weapon_zealot_ranged_1"
		}
	},
	is_available = function (archetype_ref)
		return Promise.resolved({
			available = true,
			archetype = archetype_ref
		})
	end,
	acquire_callback = function (archetype_ref, on_flow_finished_callback)
		return
	end
}

return archetype_data
