local ArchetypeDodgeTemplates = require("scripts/settings/dodge/archetype_dodge_templates")
local ArchetypeSprintTemplates = require("scripts/settings/sprint/archetype_sprint_templates")
local ArchetypeStaminaTemplates = require("scripts/settings/stamina/archetype_stamina_templates")
local ArchetypeTalents = require("scripts/settings/ability/archetype_talents/archetype_talents")
local ArchetypeToughnessTemplates = require("scripts/settings/toughness/archetype_toughness_templates")
local ArchetypeWarpChargeTemplates = require("scripts/settings/warp_charge/archetype_warp_charge_templates")
local UiSoundEvents = require("scripts/settings/ui/ui_sound_events")
local archetype_data = {
	archetype_description = "loc_class_adamant_description",
	archetype_background_large = "content/ui/materials/icons/classes/large/adamant",
	archetype_icon_selection_large_unselected = "content/ui/materials/icons/classes/adamant_terminal_shadow",
	talent_layout_file_path = "scripts/ui/views/talent_builder_view/layouts/adamant_tree",
	companion_breed = "companion_dog",
	archetype_selection_background = "content/ui/materials/backgrounds/info_panels/adamant",
	archetype_title = "loc_class_adamant_title",
	archetype_selection_level = "content/levels/ui/class_selection/class_selection_adamant/class_selection_adamant",
	base_critical_strike_chance = 0.075,
	archetype_selection_icon = "content/ui/textures/frames/class_selection/windows/class_selection_top_adamant_unselected",
	archetype_badge = "content/ui/materials/icons/class_badges/adamant_01_01",
	archetype_selection_highlight_icon = "content/ui/textures/frames/class_selection/windows/class_selection_top_adamant",
	archetype_video = "content/videos/class_selection/adamant",
	ui_selection_order = 5,
	talents_package_path = "packages/ui/views/talent_builder_view/adamant",
	archetype_name = "loc_class_adamant_name",
	archetype_icon_selection_large = "content/ui/materials/icons/classes/adamant_terminal",
	archetype_icon_large = "content/ui/materials/icons/classes/adamant",
	health = 150,
	breed = "human",
	knocked_down_health = 1000,
	toughness = ArchetypeToughnessTemplates.adamant,
	dodge = ArchetypeDodgeTemplates.adamant,
	sprint = ArchetypeSprintTemplates.default,
	stamina = ArchetypeStaminaTemplates.adamant,
	warp_charge = ArchetypeWarpChargeTemplates.default,
	talents = ArchetypeTalents.adamant,
	base_talents = {
		adamant_grenade = 1,
		adamant_stance = 1,
		adamant_companion_damage_per_level = 1
	},
	selection_sound_event = UiSoundEvents.character_create_archetype_adamant,
	is_available = function ()
		return true
	end,
	acquire_callback = function ()
		return
	end
}

return archetype_data
