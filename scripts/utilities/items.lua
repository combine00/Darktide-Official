local AchievementUIHelper = require("scripts/managers/achievements/utility/achievement_ui_helper")
local Archetypes = require("scripts/settings/archetype/archetypes")
local BuffTemplates = require("scripts/settings/buff/buff_templates")
local ItemSlotSettings = require("scripts/settings/item/item_slot_settings")
local ItemSourceSettings = require("scripts/settings/item/item_source_settings")
local LiveEvents = require("scripts/settings/live_event/live_events")
local MasterItems = require("scripts/backend/master_items")
local RankSettings = require("scripts/settings/item/rank_settings")
local RaritySettings = require("scripts/settings/item/rarity_settings")
local TraitValueParser = require("scripts/utilities/trait_value_parser")
local UISettings = require("scripts/settings/ui/ui_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local WeaponTemplate = require("scripts/utilities/weapon/weapon_template")
local unit_alive = Unit.alive
local expertise_multiplier = 10
local max_weapon_preview = 0.8
local Items = {}

local function _character_save_data()
	local local_player_id = 1
	local player_manager = Managers.player
	local player = player_manager and player_manager:local_player(local_player_id)
	local character_id = player and player:character_id()
	local save_manager = Managers.save
	local character_data = character_id and save_manager and save_manager:character_data(character_id)

	return character_data
end

function Items.get_expertise_multiplier()
	return expertise_multiplier
end

function Items.get_max_weapon_preview()
	return max_weapon_preview
end

function Items.get_weapon_modification_cap(expertise_value)
	return expertise_value * 2 / expertise_multiplier
end

function Items.calculate_stats_rating(item)
	if item.baseItemLevel then
		return item.baseItemLevel
	end

	local rating_budget = item.itemLevel or 0
	local rating_contribution = Items.item_perk_rating(item) + Items.item_trait_rating(item)

	return math.max(0, rating_budget - rating_contribution)
end

function Items.is_weapon(item_type)
	return item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED"
end

function Items.is_character_bound(item_type)
	return item_type == "WEAPON_MELEE" or item_type == "WEAPON_RANGED" or item_type == "GADGET"
end

function Items.mark_item_id_as_new(item, skip_notification)
	local gear_id = item.gear_id
	local item_type = item.item_type
	local is_character_bound = Items.is_character_bound(item_type)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	if is_character_bound then
		if not character_data.new_items then
			character_data.new_items = {}
		end

		if not character_data.new_item_notifications then
			character_data.new_item_notifications = {}
		end

		local new_items = character_data.new_items
		new_items[gear_id] = true

		if item_type then
			if not character_data.new_items_by_type then
				character_data.new_items_by_type = {}
			end

			local new_items_by_type = character_data.new_items_by_type

			if not new_items_by_type[item_type] then
				new_items_by_type[item_type] = {}
			end

			new_items_by_type[item_type][gear_id] = true
		end
	else
		local item_archetypes = item.archetypes or {}

		if table.is_empty(item_archetypes) then
			for archetype_name, _ in pairs(Archetypes) do
				item_archetypes[#item_archetypes + 1] = archetype_name
			end
		end

		local save_manager = Managers.save
		local account_data = save_manager:account_data()

		for i = 1, #item_archetypes do
			local archetype_name = item_archetypes[i]
			account_data.new_account_items_by_archetype[archetype_name] = account_data.new_account_items_by_archetype[archetype_name] or {}
			account_data.new_account_items_by_archetype[archetype_name][gear_id] = true
		end
	end

	local new_item_notifications = character_data.new_item_notifications
	local show_notification = skip_notification and skip_notification ~= true or not skip_notification
	new_item_notifications[gear_id] = {
		show_notification = show_notification
	}

	Managers.save:queue_save()
	Managers.event:trigger("event_resync_character_news_feed")
end

function Items.unmark_item_id_as_new(gear_id)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items = character_data.new_items

	if new_items and new_items[gear_id] then
		new_items[gear_id] = nil
		local new_items_by_type = character_data.new_items_by_type

		if new_items_by_type then
			for item_type, items in pairs(new_items_by_type) do
				if items[gear_id] then
					items[gear_id] = nil

					break
				end
			end
		end
	end

	local save_manager = Managers.save
	local account_data = save_manager:account_data()
	local player_manager = Managers.player
	local local_player_id = 1
	local player = player_manager and player_manager:local_player(local_player_id)
	local archetype_name = player:archetype_name()

	if account_data.new_account_items_by_archetype[archetype_name] and account_data.new_account_items_by_archetype[archetype_name][gear_id] then
		account_data.new_account_items_by_archetype[archetype_name][gear_id] = nil
	end

	Managers.save:queue_save()
end

function Items.unmark_all_items_as_new()
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items = character_data.new_items

	if new_items then
		table.clear(new_items)
	end

	local new_items_by_type = character_data.new_items_by_type

	if new_items_by_type then
		table.clear(new_items_by_type)
	end

	local save_manager = Managers.save
	local account_data = save_manager:account_data()
	local player_manager = Managers.player
	local local_player_id = 1
	local player = player_manager and player_manager:local_player(local_player_id)
	local archetype_name = player:archetype_name()

	if account_data.new_account_items_by_archetype[archetype_name] then
		table.clear(account_data.new_account_items_by_archetype[archetype_name])
	end

	Managers.save:queue_save()
end

function Items.unmark_item_type_as_new(item_type)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items = character_data.new_items

	if new_items then
		local new_items_by_type = character_data.new_items_by_type

		if new_items_by_type then
			local items = new_items_by_type[item_type]

			if items then
				for gear_id, _ in pairs(items) do
					new_items[gear_id] = nil
					items[gear_id] = nil
				end
			end
		end

		Managers.save:queue_save()
	end
end

function Items.unmark_item_notification_id_as_new(gear_id)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_item_notifications = character_data.new_item_notifications

	if new_item_notifications and new_item_notifications[gear_id] then
		new_item_notifications[gear_id] = nil

		Managers.save:queue_save()
	end
end

function Items.is_item_id_new(gear_id)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items = character_data.new_items

	return new_items[gear_id] or false
end

function Items.has_new_items_by_type(item_type)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items_by_type = character_data.new_items_by_type

	if new_items_by_type then
		local items = new_items_by_type[item_type]

		if items and not table.is_empty(items) then
			return true
		end
	end

	return false
end

function Items.new_item_ids()
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_items = character_data.new_items

	return new_items
end

function Items.new_item_notification_ids()
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local new_item_notifications = character_data.new_item_notifications

	return new_item_notifications
end

function Items.display_name(item)
	if not item then
		return "n/a"
	end

	local display_name = item.display_name

	if Items.is_weapon(item.item_type) then
		local lore_family_name = Items.weapon_lore_family_name(item)
		local lore_pattern_name = Items.weapon_lore_pattern_name(item)
		local lore_mark_name = Items.weapon_lore_mark_name(item)

		return string.format("%s %s %s", lore_family_name, lore_pattern_name, lore_mark_name)
	end

	local localization_function = Localize
	local display_name_localized = display_name and localization_function(display_name) or "-"

	return display_name_localized
end

function Items.sub_display_name(item, required_level, include_item_type)
	local item_type_display_name_localized = Items.type_display_name(item)
	local text = nil

	if item.rarity then
		local rarity_display_name_localized = Items.rarity_display_name(item)
		text = rarity_display_name_localized
	else
		return item_type_display_name_localized
	end

	if required_level then
		local no_cache = true
		text = text .. " · {#color(120,120,120)}" .. Localize("loc_requires_level", no_cache, {
			level = required_level
		})
	end

	return text
end

function Items.weapon_card_display_name(item)
	return Items.weapon_lore_family_name(item)
end

function Items.weapon_card_sub_display_name(item)
	local lore_pattern_name = Items.weapon_lore_pattern_name(item)
	local lore_mark_name = Items.weapon_lore_mark_name(item)
	local has_pattern = lore_pattern_name ~= "n/a"
	local has_mark = lore_mark_name ~= "n/a"

	if has_pattern and has_mark then
		local sub_display_name = string.format("%s • %s", lore_pattern_name, lore_mark_name)

		return sub_display_name
	end

	return has_pattern and lore_pattern_name or has_mark and lore_mark_name or "n/a"
end

function Items.weapon_lore_family_name(item)
	if not item then
		return "n/a"
	end

	local weapon_family_display_name = item.weapon_family_display_name

	if not weapon_family_display_name then
		return "n/a"
	end

	local loc_id = weapon_family_display_name.loc_id
	local weapon_family_display_name_localized = loc_id and Localize(loc_id) or "n/a"

	return weapon_family_display_name_localized
end

function Items.weapon_lore_pattern_name(item)
	if not item then
		return "n/a"
	end

	local weapon_pattern_display_name = item.weapon_pattern_display_name

	if not weapon_pattern_display_name then
		return "n/a"
	end

	local loc_id = weapon_pattern_display_name.loc_id
	local weapon_pattern_display_name_localized = loc_id and Localize(loc_id) or "n/a"

	return weapon_pattern_display_name_localized
end

function Items.weapon_lore_mark_name(item)
	if not item then
		return "n/a"
	end

	local weapon_mark_display_name = item.weapon_mark_display_name

	if not weapon_mark_display_name then
		return "n/a"
	end

	local loc_id = weapon_mark_display_name.loc_id
	local weapon_mark_display_name_localized = loc_id and Localize(loc_id) or "n/a"

	return weapon_mark_display_name_localized
end

function Items.trait_textures(trait_item, rarity)
	local icon = trait_item and trait_item.icon ~= "" and trait_item.icon
	local texture_icon = icon or "content/ui/textures/icons/traits/weapon_trait_default"
	local texture_frame = RankSettings[rarity or 0].trait_frame_texture

	return texture_icon, texture_frame
end

function Items.perk_textures(perk_item, rarity)
	return RankSettings[rarity or 0].perk_icon
end

function Items.character_level(item)
	local character_level = item.characterLevel or 0

	return character_level
end

local _find_link_attachment_item_slot_path = nil

function _find_link_attachment_item_slot_path(target_table, slot_id, item, link_item, optional_path)
	local unused_trinket_name = "content/items/weapons/player/trinkets/unused_trinket"
	local path = optional_path or nil

	for k, t in pairs(target_table) do
		if type(t) == "table" then
			if k == slot_id then
				if not t.item or t.item ~= unused_trinket_name then
					path = path and path .. "." .. k or k

					if link_item then
						t.item = item
					end

					return path, t.item
				else
					return nil
				end
			else
				local previous_path = path
				path = path and path .. "." .. k or k
				local alternative_path, path_item = _find_link_attachment_item_slot_path(t, slot_id, item, link_item, path)

				if alternative_path then
					return alternative_path, path_item
				else
					path = previous_path
				end
			end
		end
	end
end

local trinket_slot_order = {
	"slot_trinket_1",
	"slot_trinket_2"
}

function Items.get_current_equipped_trinket(item)
	for i = 1, #trinket_slot_order do
		local slot_id = trinket_slot_order[i]
		local _, trinket_item = _find_link_attachment_item_slot_path(item, slot_id, nil, false)

		if type(trinket_item) == "table" then
			return trinket_item, slot_id
		end
	end
end

function Items.weapon_trinket_preview_item(item, optional_preview_item)
	local preview_item_name = optional_preview_item or "content/items/weapons/player/trinkets/preview_trinket"
	local preview_item = preview_item_name and MasterItems.get_item(preview_item_name)
	local visual_item = nil

	if preview_item then
		visual_item = table.clone_instance(preview_item)
	end

	if visual_item then
		visual_item.gear_id = item.gear_id

		for i = 1, #trinket_slot_order do
			local slot_id = trinket_slot_order[i]

			if _find_link_attachment_item_slot_path(visual_item, slot_id, item, true) then
				break
			end
		end
	end

	return visual_item
end

function Items.add_weapon_trinket_on_preview_item(weapon_item, trinket_item)
	for i = 1, #trinket_slot_order do
		local slot_id = trinket_slot_order[i]
		local alternative_path, _ = _find_link_attachment_item_slot_path(weapon_item.attachments, slot_id, trinket_item, true)

		if alternative_path then
			break
		end
	end
end

function Items.weapon_skin_preview_item(item, include_skin_item_info)
	local preview_item_name = item.preview_item
	local preview_item = preview_item_name and MasterItems.get_item(preview_item_name)
	local visual_item = nil

	if preview_item then
		visual_item = table.clone_instance(preview_item)
	end

	if visual_item then
		visual_item.gear_id = item.gear_id
		visual_item.slot_weapon_skin = item
	end

	if include_skin_item_info then
		visual_item.display_name = item.display_name
		visual_item.description = item.description
		visual_item.item_type = item.item_type
		visual_item.weapon_template_restriction = item.weapon_template_restriction
	end

	return visual_item
end

function Items.total_stats_value(item)
	local item_type = item.item_type
	local total_stats = nil

	if item_type and Items.is_weapon(item_type) then
		local item_base_stats = item.base_stats

		if item_base_stats and not table.is_empty(item_base_stats) then
			total_stats = 0

			for i = 1, #item_base_stats do
				local stat = item_base_stats[i]
				local value = stat.value
				total_stats = total_stats + value
			end

			total_stats = math.floor(total_stats * 100 + 0.5)
		end
	end

	return total_stats
end

function Items.expertise_level(item, no_symbol, use_base_item_level)
	if item.item_type ~= "GADGET" then
		local base_item_level = item.baseItemLevel
		local item_level = nil

		if use_base_item_level then
			item_level = base_item_level
		else
			item_level = Items.total_stats_value(item)
		end

		local expertise_level = math.max(0, math.floor((item_level and item_level - 80 or 0) / 6) * expertise_multiplier)

		if no_symbol then
			return tostring(expertise_level), base_item_level ~= nil
		end

		return string.format(" %s", expertise_level), base_item_level ~= nil
	else
		local max_gadget_level = 92
		local max_weapon_level = 300
		local base_item_level = item.baseItemLevel or 0
		local item_level_normalized = math.ilerp(0, max_gadget_level, base_item_level)
		local item_level = math.floor(item_level_normalized * max_weapon_level / 6) * expertise_multiplier

		if no_symbol then
			return tostring(item_level or 0), item_level ~= nil
		end

		return string.format(" %s", item_level or 0), item_level ~= nil
	end
end

function Items.max_expertise_level()
	return 50 * expertise_multiplier
end

function Items.is_weapon_template_ranged(item)
	local weapon_template = WeaponTemplate.weapon_template_from_item(item)
	local keywords = weapon_template and weapon_template.keywords
	local search_result = keywords and table.find(keywords, "ranged")

	return search_result and search_result > 0
end

function Items.type_display_name(item)
	local item_type = item.item_type and Utf8.upper(item.item_type)
	local item_type_localization_key = UISettings.item_type_localization_lookup[item_type]
	local item_type_display_name_localized = item_type_localization_key and Localize(item_type_localization_key) or ""

	return item_type_display_name_localized
end

function Items.level_display_name(item)
	local item_level = Items.expertise_level(item)
	local item_level_display_name_localized = Localize("loc_item_display_level_format_key", true, {
		level = item_level
	})

	return item_level_display_name_localized
end

function Items.type_texture(item)
	local item_type = item.item_type
	local item_type_texture_path = UISettings.item_type_texture_lookup[item_type] or "content/ui/textures/icons/item_types/weapons"

	return item_type_texture_path
end

function Items.variant_display_name(item)
	local variant = item.variant
	local variant_localization_key = UISettings.item_variant_localization_lookup[variant]
	local variant_display_name_localized = variant_localization_key and Localize(variant_localization_key) or ""

	return variant_display_name_localized
end

local _item_property_definitions = {
	{
		loc_key = "loc_item_property_change_voice",
		icon = "",
		condition = function (item)
			local item_voice_modulator = item.voice_fx_preset

			return item_voice_modulator and item_voice_modulator ~= "voice_fx_rtpc_none"
		end
	},
	{
		loc_key = "loc_item_property_change_walk",
		icon = "",
		condition = function (item)
			local left_value = table.nested_get(item, "profile_properties", "footstep_type_left")
			local right_value = table.nested_get(item, "profile_properties", "footstep_type_right")

			return left_value and left_value ~= "default" or right_value and right_value ~= "default"
		end
	}
}

local function _item_property_list(item)
	local properties = {}

	for i = 1, #_item_property_definitions do
		local property_definition = _item_property_definitions[i]

		if property_definition.condition(item) then
			properties[#properties + 1] = i
		end
	end

	return properties
end

function Items.item_property_icons(item, optional_separator)
	local properties = _item_property_list(item)

	if #properties == 0 then
		return
	end

	for i = 1, #properties do
		local definition = _item_property_definitions[properties[i]]
		properties[i] = definition.icon
	end

	local separator = optional_separator or "\n"

	return table.concat(properties, separator)
end

function Items.item_property_text(item, prefer_iconography)
	local properties = _item_property_list(item)

	if #properties == 0 then
		return
	end

	for i = 1, #properties do
		local definition = _item_property_definitions[properties[i]]
		local icon = prefer_iconography and definition.icon or "•"
		properties[i] = string.format("%s %s", icon, Localize(definition.loc_key))
	end

	return table.concat(properties, "\n")
end

local _key_value_color = Color.terminal_text_body(255, true)
local _obtained_source_color_context = {
	r = _key_value_color[2],
	g = _key_value_color[3],
	b = _key_value_color[4]
}

function Items.obtained_display_name(item)
	local item_source = item.source
	local source_settings = item_source and ItemSourceSettings[item_source]
	local display_name_localization_key = source_settings and source_settings.display_name
	local display_name_localized = display_name_localization_key and Localize(display_name_localization_key)
	local display_name = display_name_localized
	local optional_description = nil

	if display_name and source_settings then
		if source_settings.is_achievement then
			local slots = item.slots
			local first_slot_name = slots and slots[1]

			if first_slot_name then
				local player_manager = Managers.player
				local player = player_manager:local_player(1)
				local achievement = AchievementUIHelper.get_acheivement_by_reward_item(item)
				local is_complete = achievement and Managers.achievements:achievement_completed(player, achievement.id)

				if achievement then
					if not is_complete then
						if achievement.type == "meta" then
							local sub_penances_count = table.size(achievement.achievements)
							optional_description = Localize("loc_inventory_cosmetic_item_acquisition_penance_description_multiple_requirement", true, {
								penance_amount = sub_penances_count
							})
						else
							optional_description = AchievementUIHelper.localized_description(achievement)
						end
					end

					local achievement_label = AchievementUIHelper.localized_title(achievement)
					_obtained_source_color_context.value = achievement_label
					local achievement_label_colored = Localize("loc_color_value_fomat_key", true, _obtained_source_color_context)
					display_name = Localize(display_name_localization_key, true, {
						achievement_label = achievement_label_colored
					})
				end
			end
		elseif source_settings.is_live_event then
			local reward_item_name = item.__master_item and item.__master_item.name or ""
			local live_event_label_colored = nil

			for _, live_event in pairs(LiveEvents) do
				if live_event.item_rewards and table.array_contains(live_event.item_rewards, reward_item_name) then
					_obtained_source_color_context.value = Localize(live_event.name)
					live_event_label_colored = Localize("loc_color_value_fomat_key", true, _obtained_source_color_context)
				end
			end

			display_name = Localize(display_name_localization_key, true, {
				live_event_label = live_event_label_colored
			})
		elseif source_settings.is_dlc then
			optional_description = Localize("loc_term_glossary_dlc")
		end
	end

	return display_name, optional_description
end

function Items.rarity_display_name(item)
	local rarity_settings = RaritySettings[item.rarity]
	local loc_key = rarity_settings and rarity_settings.display_name
	local rarity_display_name_localized = loc_key and Localize(loc_key) or ""

	return rarity_display_name_localized
end

function Items.rarity_color(item)
	local rarity_settings = RaritySettings[item and item.rarity] or RaritySettings[0]

	return rarity_settings.color, rarity_settings.color_dark
end

function Items.keywords_text(item)
	local weapon_template = WeaponTemplate.weapon_template_from_item(item)
	local displayed_keywords = weapon_template.displayed_keywords
	local text = ""

	if displayed_keywords then
		for i = 1, #displayed_keywords do
			local keyword = displayed_keywords[i]
			local display_name = keyword.display_name
			text = text .. Localize(display_name)

			if i ~= #displayed_keywords then
				text = text .. " • "
			end
		end
	end

	return text
end

function Items.restriction_text(item, prefer_iconography)
	local item_type = item.item_type and Utf8.upper(item.item_type) or ""

	if item_type == "WEAPON_SKIN" then
		return Items.weapon_skin_requirement_text(item)
	elseif item_type == "GEAR_UPPERBODY" or item_type == "GEAR_EXTRA_COSMETIC" or item_type == "GEAR_HEAD" or item_type == "GEAR_LOWERBODY" or item_type == "SET" then
		return Items.class_requirement_text(item, prefer_iconography)
	end

	return "", false
end

function Items.weapon_skin_requirement_text(item)
	local weapon_template_restriction = item.weapon_template_restriction
	local text = ""

	if not weapon_template_restriction or table.is_empty(weapon_template_restriction) then
		return text, false
	end

	local potential_weapon_paths = {}

	for i = 1, #weapon_template_restriction do
		local weapon_template_name = weapon_template_restriction[i]
		local base_item_location = "content/items/weapons/player"
		potential_weapon_paths[1] = string.format("%s/melee/%s", base_item_location, weapon_template_name)
		potential_weapon_paths[2] = string.format("%s/ranged/%s", base_item_location, weapon_template_name)
		local item_or_nil = nil

		for j = 1, #potential_weapon_paths do
			item_or_nil = MasterItems.get_item(potential_weapon_paths[j])

			if item_or_nil then
				break
			end
		end

		local template_display_name_localized = item_or_nil and Items.weapon_card_display_name(item_or_nil)

		if template_display_name_localized and not string.find(text, template_display_name_localized, nil, true) then
			text = text .. "• " .. template_display_name_localized

			if i < #weapon_template_restriction then
				text = text .. "\n"
			end
		end
	end

	return text, true
end

local _temp_archetype_restriction_list = {}

function Items.set_item_class_requirement_text(item)
	table.clear(_temp_archetype_restriction_list)

	local text = ""
	local items = item.items

	for i = 1, #items do
		local set_piece_item = items[i]
		local archetype_restrictions = set_piece_item.archetypes

		if not archetype_restrictions or table.is_empty(archetype_restrictions) then
			return text, false
		end

		for j = 1, #archetype_restrictions do
			local archetype_name = archetype_restrictions[j]

			if not _temp_archetype_restriction_list[archetype_name] then
				local archetype = Archetypes[archetype_name]
				local display_name_localized = archetype and Localize(archetype.archetype_name)

				if display_name_localized then
					text = text .. "• " .. display_name_localized

					if i < #archetype_restrictions then
						text = text .. "\n"
					end
				end

				_temp_archetype_restriction_list[archetype_name] = true
			end
		end
	end

	return text, true
end

function Items.item_num_classes_not_available_by_total(item)
	local archetype_restrictions = item and item.archetypes

	if not archetype_restrictions or table.is_empty(archetype_restrictions) then
		return 0, 0
	else
		local not_available_count = 0
		local total_archetypes = #archetype_restrictions

		for i = 1, total_archetypes do
			local archetype_name = archetype_restrictions[i]
			local archetype = Archetypes[archetype_name]
			local is_archetype_available_func = archetype and archetype.is_available
			local is_archetype_available = true

			if is_archetype_available_func then
				is_archetype_available = is_archetype_available_func()
			end

			if not is_archetype_available then
				not_available_count = not_available_count + 1
			end
		end

		return not_available_count, total_archetypes
	end
end

function Items.check_archetype_restrictions(item)
	local restriction_type = nil
	local archetypes_not_available, total_archetypes = Items.item_num_classes_not_available_by_total(item)

	if archetypes_not_available > 0 then
		if archetypes_not_available == 1 and archetypes_not_available == total_archetypes then
			local archetype = item.archetypes[1]

			if restriction_type and archetype ~= restriction_type then
				restriction_type = "generic"
			elseif not restriction_type then
				restriction_type = archetype
			end
		elseif archetypes_not_available > 1 then
			restriction_type = "generic"
		end
	end

	return restriction_type
end

local function _class_requirement_entries(item, available_archetypes)
	local item_type = item.item_type

	if item_type == "SET" then
		local items = item.items

		for i = 1, #items do
			_class_requirement_entries(items[i], available_archetypes)
		end

		return available_archetypes
	end

	local archetype_restrictions = item.archetypes

	if not archetype_restrictions or #archetype_restrictions == 0 then
		return available_archetypes
	end

	for i = #available_archetypes, 1, -1 do
		local archetype_name = available_archetypes[i]
		local is_present = table.array_contains(archetype_restrictions, archetype_name)

		if not is_present then
			table.remove(available_archetypes, i)
		end
	end

	return available_archetypes
end

function Items.class_requirement_text(item, prefer_iconography)
	local entries = _class_requirement_entries(item, table.keys(Archetypes))

	if #entries == 0 or #entries == table.size(Archetypes) then
		return nil, false
	end

	for i = 1, #entries do
		local archetype_name = entries[i]
		local archetype = Archetypes[archetype_name]

		if archetype then
			local display_name_localized = Localize(archetype.archetype_name)
			local string_symbol = prefer_iconography and UISettings.archetype_font_icon[archetype_name] or "•"
			entries[i] = string.format("%s %s", string_symbol, display_name_localized)
		end
	end

	return table.concat(entries, "\n"), true
end

function Items.retrieve_items_for_archetype(archetype, filtered_slots, workflow_states)
	local WORKFLOW_STATES = {
		"SHIPPABLE",
		"RELEASABLE",
		"FUNCTIONAL"
	}
	workflow_states = workflow_states and workflow_states or WORKFLOW_STATES
	local item_definitions = MasterItems.get_cached()
	local items = {}

	for item_name, item in pairs(item_definitions) do
		repeat
			local slots = item.slots
			local slot = slots and slots[1]

			if not table.contains(filtered_slots, slot) then
				break
			end

			local archetypes = item.archetypes

			if not archetypes or not table.contains(archetypes, archetype) then
				break
			end

			local is_item_stripped = true
			local strip_tags_table = Application.get_strip_tags_table()

			if table.size(item.feature_flags) == 0 then
				is_item_stripped = false
			else
				for _, feature_flag in pairs(item.feature_flags) do
					if strip_tags_table[feature_flag] == true then
						is_item_stripped = false

						break
					end
				end
			end

			if is_item_stripped then
				break
			end

			local filtered_workflow_states = table.contains(workflow_states, item.workflow_state)

			if not filtered_workflow_states then
				break
			end

			if items[slot] == nil then
				items[slot] = {}
			end

			items[slot][item_name] = item
		until true
	end

	return items
end

function Items.perk_item_by_id(perk_id)
	return MasterItems.get_item(perk_id)
end

local temp_item_rank_localization_context = {
	rank = 0
}

function Items.rank_display_text(item)
	local weapon_rank = Managers.progression:get_item_rank(item)
	temp_item_rank_localization_context.rank = weapon_rank
	local no_cache = true

	return Localize("loc_item_display_rank_format_key", no_cache, temp_item_rank_localization_context)
end

function Items.equip_weapon_skin(weapon_item, skin_item)
	local weapon_gear_id = weapon_item.gear_id
	local skin_gear_id = skin_item and skin_item.gear_id
	local attach_point = "slot_weapon_skin"

	return Managers.data_service.gear:attach_item_as_override(weapon_gear_id, attach_point, skin_gear_id)
end

function Items.equip_weapon_trinket(weapon_item, trinket_item, optional_path)
	local weapon_gear_id = weapon_item.gear_id
	local trinket_gear_id = trinket_item and trinket_item.gear_id
	local attach_point = optional_path

	if not attach_point then
		local link_attachment_item_to_slot = nil
		local unused_trinket_name = "content/items/weapons/player/trinkets/unused_trinket"

		function link_attachment_item_to_slot(target_table, slot_id, item, optional_path)
			local path = optional_path or nil

			for k, t in pairs(target_table) do
				if type(t) == "table" then
					local correct_path = k == slot_id

					if correct_path and (not t.item or t.item ~= unused_trinket_name) then
						t.item = item
						path = path and path .. "." .. k or k

						return path
					else
						local previous_path = path
						path = path and path .. "." .. k or k
						local alternative_path = link_attachment_item_to_slot(t, slot_id, item, path)

						if alternative_path then
							return alternative_path
						else
							path = previous_path
						end
					end
				end
			end
		end

		local master_item = weapon_item.__master_item
		attach_point = link_attachment_item_to_slot(master_item, "slot_trinket_1", trinket_item)
		attach_point = attach_point or link_attachment_item_to_slot(master_item, "slot_trinket_2", trinket_item)
	end

	return Managers.data_service.gear:attach_item_as_override(weapon_gear_id, attach_point .. ".item", trinket_gear_id)
end

function Items.unequip_slots(unequip_sots)
	local peer_id = Network.peer_id()
	local local_player_id = 1
	local player_manager = Managers.player
	local player = player_manager:player(peer_id, local_player_id)
	local character_id = player:character_id()

	return Managers.data_service.profiles:unequip_slots(character_id, unequip_sots):next(function (v)
		Log.debug("Items", "Unequipped loadout slots")

		if Managers.connection:is_host() then
			local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

			profile_synchronizer_host:profile_changed(peer_id, local_player_id)
		elseif Managers.connection:is_client() then
			local ui_manager = Managers.ui

			if ui_manager then
				ui_manager:update_client_loadout_waiting_state(true)
			end

			Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
		end

		return true
	end):catch(function (errors)
		Log.error("Items", "Failed uneequipping loadout slots", errors)

		return false
	end)
end

function Items.equip_slot_items(items)
	local peer_id = Network.peer_id()
	local local_player_id = 1
	local player_manager = Managers.player
	local player = player_manager:player(peer_id, local_player_id)
	local profile = player:profile()
	local archetype = profile.archetype
	local breed_name = archetype.breed
	local character_id = player:character_id()

	if items then
		local item_gear_ids_by_slots = {}
		local item_gear_names_by_slots = {}

		for slot_name, item in pairs(items) do
			if item then
				local breeds = item and item.breeds
				local breed_valid = not breeds or table.contains(breeds, breed_name)
				local slots = item and item.slots
				local slot_valid = not slots or table.contains(slots, slot_name)

				if breed_valid and slot_valid then
					if item.gear_id then
						item_gear_ids_by_slots[slot_name] = item.gear_id
					elseif item.name then
						item_gear_names_by_slots[slot_name] = item.name
					end
				end
			end
		end

		return Managers.data_service.profiles:equip_items_in_slots(character_id, item_gear_ids_by_slots, item_gear_names_by_slots):next(function (v)
			Log.debug("Items", "Items equipped in loadout slots")

			if Managers.connection:is_host() then
				local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

				profile_synchronizer_host:profile_changed(peer_id, local_player_id)
			elseif Managers.connection:is_client() then
				local ui_manager = Managers.ui

				if ui_manager then
					ui_manager:update_client_loadout_waiting_state(true)
				end

				Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
			end

			return true
		end):catch(function (errors)
			Log.error("Items", "Failed equipping items in loadout slots: %s", errors)

			return false
		end)
	end
end

function Items.is_item_compatible_with_profile(item, profile)
	local item_gender, item_breed, item_archetype = nil
	local item_genders = item.genders
	local wanted_gender = profile.gender

	if item_genders and not table.is_empty(item_genders) then
		for ii = 1, #item_genders do
			local gender = item_genders[ii]

			if gender == wanted_gender then
				item_gender = wanted_gender

				break
			end
		end
	else
		item_gender = wanted_gender
	end

	local item_breeds = item.breeds
	local wanted_breed = profile.archetype.breed

	if item_breeds and not table.is_empty(item_breeds) then
		for ii = 1, #item_breeds do
			local breed = item_breeds[ii]

			if breed == wanted_breed then
				item_breed = wanted_breed

				break
			end
		end
	else
		item_breed = wanted_breed
	end

	local item_archetypes = item.archetypes
	local wanted_archetype = profile.archetype

	if item_archetypes and not table.is_empty(item_archetypes) then
		for i = 1, #item_archetypes do
			local archetype = item_archetypes[i]

			if archetype == wanted_archetype.name then
				item_archetype = wanted_archetype

				break
			end
		end
	else
		item_archetype = wanted_archetype
	end

	return item_gender and item_breed and not not item_archetype
end

function Items.equip_slot_master_items(items)
	local peer_id = Network.peer_id()
	local local_player_id = 1
	local player_manager = Managers.player
	local player = player_manager and player_manager:player(peer_id, local_player_id)

	if not player then
		return
	end

	local profile = player:profile()
	local archetype = profile.archetype
	local breed_name = archetype.breed
	local character_id = player:character_id()

	if items then
		local item_master_ids_by_slots = {}

		for slot_name, item in pairs(items) do
			local breeds = item and item.breeds
			local breed_valid = not breeds or table.contains(breeds, breed_name)
			local slots = item and item.slots
			local slot_valid = not slots or table.contains(slots, slot_name)

			if breed_valid and slot_valid then
				item_master_ids_by_slots[slot_name] = item.name
			end
		end

		Managers.data_service.profiles:equip_master_items_in_slots(character_id, item_master_ids_by_slots):next(function (v)
			Log.debug("Items", "Master items equipped in loadout slots")

			if Managers.connection:is_host() then
				local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

				profile_synchronizer_host:profile_changed(peer_id, local_player_id)
			elseif Managers.connection:is_client() then
				local ui_manager = Managers.ui

				if ui_manager then
					ui_manager:update_client_loadout_waiting_state(true)
				end

				Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
			end

			return true
		end):catch(function (errors)
			Log.error("Items", "Failed equipping master items in loadout slots", errors)

			return false
		end)
	end
end

function Items.equip_item_in_slot(slot_name, item)
	local peer_id = Network.peer_id()
	local local_player_id = 1
	local player_manager = Managers.player
	local player = player_manager and player_manager:player(peer_id, local_player_id)

	if not player then
		return
	end

	local profile = player:profile()
	local archetype = profile.archetype
	local breed_name = archetype.breed
	local breeds = item and item.breeds
	local breed_valid = not breeds or table.contains(breeds, breed_name)

	if not breed_valid then
		return
	end

	local character_id = player:character_id()

	if item then
		Managers.backend.interfaces.characters:equip_item_slot(character_id, slot_name, item.gear_id or item.name):next(function (v)
			Log.debug("Items", "Equipped!")

			if Managers.connection:is_host() then
				local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

				profile_synchronizer_host:profile_changed(peer_id, local_player_id)
			elseif Managers.connection:is_client() then
				local ui_manager = Managers.ui

				if ui_manager then
					ui_manager:update_client_loadout_waiting_state(true)
				end

				Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
			end

			return true
		end):catch(function (errors)
			Log.error("Items", "Equipping %s (ID: %s) to %s failed. User should be shown some error message! %s", item.name, item.gear_id, slot_name, errors)

			return false
		end)
	end
end

function Items.refresh_equipped_items()
	local peer_id = Network.peer_id()
	local local_player_id = 1

	if Managers.connection:is_host() then
		local profile_synchronizer_host = Managers.profile_synchronization:synchronizer_host()

		profile_synchronizer_host:profile_changed(peer_id, local_player_id)
	elseif Managers.connection:is_client() then
		local ui_manager = Managers.ui

		if ui_manager then
			ui_manager:update_client_loadout_waiting_state(true)
		end

		Managers.connection:send_rpc_server("rpc_notify_profile_changed", peer_id, local_player_id)
	end
end

function Items.slot_name(item)
	return item.slots and item.slots[1]
end

function Items.item_slot(item)
	local slot_name = Items.slot_name(item)

	return slot_name and ItemSlotSettings[slot_name]
end

function Items.sort_element_key_comparator(definitions)
	return function (a, b)
		for i = 1, #definitions, 3 do
			local order = definitions[i]
			local key = definitions[i + 1]
			local func = definitions[i + 2]
			local is_lt = func(key and a[key] or a, key and b[key] or b)

			if is_lt ~= nil then
				if order == "<" or order == "true" then
					return is_lt
				else
					return not is_lt
				end
			end
		end

		return nil
	end
end

function Items.sort_comparator(definitions)
	return function (a, b)
		local a_item = a.item
		local b_item = b.item

		if a_item and b_item then
			for i = 1, #definitions, 2 do
				local order = definitions[i]
				local func = definitions[i + 1]
				local is_lt = func(a_item, b_item)

				if is_lt ~= nil then
					if order == "<" or order == "true" then
						return is_lt
					else
						return not is_lt
					end
				end
			end
		end

		return nil
	end
end

function Items.compare_offer_owned(a_offer, b_offer)
	if a_offer and b_offer then
		local owned_key = "owned"
		local a_owned = a_offer.state and a_offer.state == owned_key
		local b_owned = b_offer.state and b_offer.state == owned_key

		if a_owned and not b_owned then
			return true
		elseif b_owned and not a_owned then
			return false
		end
	end

	return nil
end

function Items.compare_credits_offer_owned(a_offer, b_offer)
	if a_offer and b_offer then
		local owned_key = "completed"
		local a_owned = a_offer.state and a_offer.state == owned_key
		local b_owned = b_offer.state and b_offer.state == owned_key

		if a_owned and not b_owned then
			return true
		elseif b_owned and not a_owned then
			return false
		end
	end

	return nil
end

function Items.compare_offer_price(a_offer, b_offer)
	if a_offer and b_offer then
		local owned_key = "owned"
		local a_owned = a_offer.state and a_offer.state == owned_key
		local b_owned = b_offer.state and b_offer.state == owned_key
		local a_price_data = a_offer.price.amount
		local a_price = not a_owned and a_price_data and (a_price_data.discounted_price or a_price_data.amount)
		local b_price_data = b_offer.price.amount
		local b_price = not b_owned and b_price_data and (b_price_data.discounted_price or b_price_data.amount)

		if a_price and b_price and a_price ~= b_price then
			return a_price < b_price
		end
	end
end

function Items.compare_set_item_parts_presentation_order(a, b)
	local a_item_type = a.item_type
	local b_item_type = b.item_type
	local a_sort_index = UISettings.set_item_parts_presentation_order[a_item_type] or 0
	local b_sort_index = UISettings.set_item_parts_presentation_order[b_item_type] or 0

	return a_sort_index < b_sort_index
end

function Items.compare_item_type(a, b)
	local a_item_type = a.item_type or ""
	local b_type = b.item_type or ""

	if a_item_type < b_type then
		return true
	elseif b_type < a_item_type then
		return false
	end

	return nil
end

function Items.compare_item_name(a, b)
	local a_display_name = Items.display_name(a) or ""
	local b_display_name = Items.display_name(b) or ""
	a_display_name = a_display_name:gsub("[\n\r]", "")
	b_display_name = b_display_name:gsub("[\n\r]", "")

	if a_display_name < b_display_name then
		return true
	elseif b_display_name < a_display_name then
		return false
	end

	return nil
end

function Items.compare_item_rarity(a, b)
	local a_rarity = a.rarity or 0
	local b_rarity = b.rarity or 0

	if a_rarity < b_rarity then
		return true
	elseif b_rarity < a_rarity then
		return false
	end

	return nil
end

function Items.compare_item_sort_order(a, b)
	local a_sort_order = a.sort_order or 0
	local b_sort_order = b.sort_order or 0

	if a_sort_order < b_sort_order then
		return true
	elseif b_sort_order < a_sort_order then
		return false
	end

	return nil
end

function Items.compare_item_level(a, b)
	local a_expertiseLevel_text = Items.expertise_level(a, true)
	local a_expertiseLevel = tonumber(a_expertiseLevel_text)
	local b_expertiseLevel_text = Items.expertise_level(b, true)
	local b_expertiseLevel = tonumber(b_expertiseLevel_text)

	if a_expertiseLevel < b_expertiseLevel then
		return true
	elseif b_expertiseLevel < a_expertiseLevel then
		return false
	end

	return nil
end

function Items.trait_description(item, rarity, lerp_value)
	return TraitValueParser.trait_description(item, rarity, lerp_value)
end

function Items.perk_rating(perk_item, perk_rarity, perk_value)
	local rank_item_type_name = perk_item.item_type == "GADGET" and "gadget" or "weapon"

	return RankSettings[perk_rarity or 0].perk_rating[rank_item_type_name]
end

function Items.trait_rating(trait_item, trait_rarity, trait_value)
	local rank_item_type_name = trait_item.item_type == "GADGET" and "gadget" or "weapon"

	return RankSettings[trait_rarity or 0].trait_rating[rank_item_type_name]
end

function Items.item_perk_rating(item)
	local rating = 0
	local perks = item.perks
	local num_perks = perks and #perks or 0

	for i = 1, num_perks do
		local perk = perks[i]
		local rank_item_type_name = item.item_type == "GADGET" and "gadget" or "weapon"
		rating = rating + RankSettings[perk.rarity or 0].perk_rating[rank_item_type_name]
	end

	return rating
end

function Items.item_trait_rating(item)
	local rating = 0
	local traits = item.traits
	local num_traits = traits and #traits or 0

	if item.item_type == "GADGET" then
		for i = 1, num_traits do
			local trait = traits[i]
			rating = rating + math.round(trait.value * 100)
		end
	else
		local fake_perk_count = 0

		for i = 1, num_traits do
			local trait = traits[i]
			local rank_item_type_name = item.item_type == "GADGET" and "gadget" or "weapon"
			rating = rating + RankSettings[trait.rarity or 0].trait_rating[rank_item_type_name]

			if trait.is_fake then
				fake_perk_count = fake_perk_count + 1
			end
		end
	end

	return rating
end

function Items.trait_category(item)
	local trait_category = nil

	if item.item_type == "TRAIT" then
		local trait_name = item.name
		trait_category = string.match(trait_name, "^content/items/traits/([%w_]+)/")
	elseif item.trait_category then
		trait_category = item.trait_category
	elseif item.weapon_template then
		Log.error("Items", "no trait_category found for %s, using fallback", item.name)

		trait_category = "bespoke_" .. string.gsub(item.weapon_template, "_m%d$", "")
	end

	return trait_category
end

function Items.has_crafting_modification(item)
	local perks = item.perks
	local has_perk_modification = false

	if perks then
		for i = 1, #perks do
			if perks[i].modified then
				has_perk_modification = true

				break
			end
		end
	end

	local traits = item.traits
	local has_trait_modification = false

	if traits then
		for i = 1, #traits do
			if traits[i].modified then
				has_trait_modification = true

				break
			end
		end
	end

	return has_perk_modification, has_trait_modification
end

function Items.count_crafting_modification(item)
	local perks = item.perks
	local count = 0

	if perks then
		for i = 1, #perks do
			if perks[i].modified then
				count = count + 1
			end
		end
	end

	local traits = item.traits

	if traits then
		for i = 1, #traits do
			if traits[i].modified then
				count = count + 1
			end
		end
	end

	return count
end

function Items.modifications_by_rarity(item)
	if item and item.rarity then
		local rarity_settings = RaritySettings[item.rarity]
		local count_modifications = Items.count_crafting_modification(item)
		local max_modifications = rarity_settings.max_modifications

		return count_modifications, max_modifications
	end

	return 0, 0
end

function Items.preview_stats_change(item, expertise_increase, stats, max_stat_value)
	local filled_stats = {}
	local trait_indices = {}

	for i = 1, #stats do
		local stat = stats[i]
		local fraction = stat.fraction
		filled_stats[#filled_stats + 1] = {
			display_name = stat.display_name,
			name = stat.name,
			value = fraction and fraction * 100 or 0
		}
	end

	local item_current_level = Items.total_stats_value(item)
	local item_max_level = 380

	if not item_current_level then
		local result = {}

		for i = 1, #filled_stats do
			local filled_stat = filled_stats[i]
			local value = math.floor(filled_stat.value + 0.5)
			result[filled_stat.display_name] = {
				fraction = math.min(value / 100, 1),
				value = math.min(value, 100)
			}
		end

		return result
	end

	max_stat_value = (max_stat_value or Items.get_max_weapon_preview()) * 100
	local remaining_budget = expertise_increase / Items.get_expertise_multiplier() * 6

	if item_max_level < remaining_budget + item_current_level then
		remaining_budget = item_max_level - item_current_level
	end

	remaining_budget = math.max(remaining_budget, 0)
	local this_round_indices = {}
	local min_value = nil
	local stored_expertise_stats_increase = item.gear and item.gear.masterDataInstance and item.gear.masterDataInstance.overrides and item.gear.masterDataInstance.overrides.expertise_stat_increases

	if stored_expertise_stats_increase then
		min_value = math.huge

		for i = 1, #filled_stats do
			local stat = filled_stats[i]
			local added_expertise_fraction = nil

			for ii = 1, #stored_expertise_stats_increase do
				local stored_expertise_stat_increase = stored_expertise_stats_increase[ii]

				if stored_expertise_stat_increase.name == stat.name and math.floor(stat.value + 0.5) < max_stat_value then
					added_expertise_fraction = stored_expertise_stat_increase.value

					break
				end
			end

			if added_expertise_fraction then
				min_value = math.min(min_value, added_expertise_fraction)
			end
		end
	end

	for i = 1, #filled_stats do
		local stat = filled_stats[i]
		local initial_round_stat = true

		if stored_expertise_stats_increase then
			local added_expertise_fraction = nil

			for ii = 1, #stored_expertise_stats_increase do
				local stored_expertise_stat_increase = stored_expertise_stats_increase[ii]

				if stored_expertise_stat_increase.name == stat.name then
					added_expertise_fraction = stored_expertise_stat_increase.value

					break
				end
			end

			initial_round_stat = added_expertise_fraction == min_value and math.floor(stat.value + 0.5) < max_stat_value
		end

		if math.floor(stat.value + 0.5) < max_stat_value then
			trait_indices[#trait_indices + 1] = i
		end

		if initial_round_stat then
			this_round_indices[#this_round_indices + 1] = i
		end
	end

	while remaining_budget > 0 and #trait_indices > 0 do
		local indices_to_remove = {}

		for i = 1, #this_round_indices do
			local current_index = this_round_indices[i]

			if math.floor(filled_stats[current_index].value + 0.5) < max_stat_value then
				local stat_increase = 1
				local previous_value = filled_stats[current_index].value
				filled_stats[current_index].value = filled_stats[current_index].value + stat_increase
				remaining_budget = remaining_budget - (filled_stats[current_index].value - previous_value)
			else
				indices_to_remove[#indices_to_remove + 1] = current_index
			end

			if remaining_budget <= 0 then
				break
			end
		end

		for i = 1, #indices_to_remove do
			local index_to_remove = indices_to_remove[i]
			local found_index = table.find(trait_indices, index_to_remove)

			if found_index then
				table.remove(trait_indices, found_index)
			end
		end

		this_round_indices = table.clone(trait_indices)
	end

	local result = {}

	for i = 1, #filled_stats do
		local filled_stat = filled_stats[i]
		local value = math.floor(filled_stat.value + 0.5)
		result[filled_stat.display_name] = {
			fraction = math.min(value / 100, 1),
			value = math.min(value, 100)
		}
	end

	return result
end

function Items.create_mannequin_profile_by_item(item, preferred_gender, preferred_archetype, preferred_breed)
	local item_gender, item_breed, item_archetype, item_slot_name = nil

	if item.archetypes and not table.is_empty(item.archetypes) then
		if preferred_archetype and table.find(item.archetypes, preferred_archetype) then
			item_archetype = type(preferred_archetype) == "string" and Archetypes[preferred_archetype] or preferred_archetype
		else
			local archetype = nil
			local num_archetypes = #item.archetypes

			for ii = 1, num_archetypes do
				archetype = Archetypes[item.archetypes[ii]]

				if archetype then
					break
				end
			end
		end
	end

	if item.breeds and not table.is_empty(item.breeds) then
		if #item.breeds > 1 and preferred_breed and table.find(item.breeds, preferred_breed) then
			item_breed = preferred_breed
		elseif #item.breeds > 1 and item_archetype and item_archetype.name == "ogryn" and table.find(item.breeds, "ogryn") then
			item_breed = "ogryn"
		else
			item_breed = item.breeds[1]
		end
	end

	if item.genders and not table.is_empty(item.genders) then
		if preferred_gender and table.find(item.genders, preferred_gender) then
			item_gender = preferred_gender
		elseif table.find(item.genders, "male") then
			item_gender = "male"
		else
			item_gender = item.genders[1]
		end
	elseif (not item.genders or item.genders and table.is_empty(item.genders)) and preferred_gender and item_breed ~= "ogryn" then
		item_gender = preferred_gender
	end

	if item.slots and not table.is_empty(item.slots) then
		item_slot_name = item.slots[1]
	else
		item_slot_name = nil
	end

	local breed = item_breed or "human"
	local archetype = item_archetype or breed == "ogryn" and Archetypes.ogryn or Archetypes.veteran
	local gender = item_gender or "male"
	local loadout = {}
	local required_breed_item_names_per_slot = UISettings.item_preview_required_slot_items_per_slot_by_breed_and_gender[breed]
	local required_gender_item_names_per_slot = required_breed_item_names_per_slot and required_breed_item_names_per_slot[gender]
	local required_items = required_gender_item_names_per_slot and (required_gender_item_names_per_slot[item_slot_name] or required_gender_item_names_per_slot.default)

	if required_items then
		for slot_name, slot_item_name in pairs(required_items) do
			local item_definition = MasterItems.get_item(slot_item_name)

			if item_definition then
				local slot_item = table.clone(item_definition)
				loadout[slot_name] = slot_item
			end
		end
	end

	if archetype.companion_breed == "companion_dog" and item.companion_state_machine then
		loadout.slot_companion_gear_full = MasterItems.get_item("content/items/characters/companion/companion_dog/gear_full/companion_dog_set_02_var_01")
	end

	return {
		loadout = loadout,
		archetype = archetype,
		breed = breed,
		gender = gender
	}
end

function Items.track_reward_item_to_gear(item)
	local gear = table.clone(item)
	local gear_id = gear.uuid
	gear.overrides = nil
	gear.id = nil
	gear.uuid = nil
	gear.gear_id = nil

	return gear_id, gear
end

function Items.register_track_reward(claimed_reward)
	local item_id = claimed_reward.id
	local reward_id = claimed_reward.gearId
	local rewarded_master_item = MasterItems.get_item(item_id)
	rewarded_master_item.uuid = reward_id
	rewarded_master_item.masterDataInstance = {
		id = item_id,
		overrides = {},
		slots = rewarded_master_item.slots
	}
	local gear_id, gear = Items.track_reward_item_to_gear(rewarded_master_item)

	Managers.data_service.gear:on_gear_created(gear_id, gear)

	local item = MasterItems.get_item_instance(gear, gear_id)

	if item then
		local skip_notification = true

		Items.mark_item_id_as_new(item, skip_notification)
	end

	return item
end

function Items.set_item_id_as_favorite(item_gear_id, state)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	if not character_data.favorite_items then
		character_data.favorite_items = {}
	end

	local ui_manager = Managers.ui

	if state then
		ui_manager:play_2d_sound(UISoundEvents.weapons_favorite)
	else
		ui_manager:play_2d_sound(UISoundEvents.weapons_select_weapon)
	end

	local favorite_items = character_data.favorite_items
	favorite_items[item_gear_id] = state

	Managers.save:queue_save()
end

function Items.is_item_id_favorited(item_gear_id)
	local character_data = _character_save_data()

	if not character_data then
		return
	end

	local favorite_items = character_data.favorite_items

	return favorite_items and favorite_items[item_gear_id]
end

return Items
