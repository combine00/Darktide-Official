local AchievementCategories = require("scripts/settings/achievements/achievement_categories")
local MasterItems = require("scripts/backend/master_items")
local TextUtils = require("scripts/utilities/ui/text")
local UISettings = require("scripts/settings/ui/ui_settings")
local _item_type_group_lookup = UISettings.item_type_group_lookup
local AchievementUIHelper = {
	achievement_definition_by_id = function (id)
		local definitions = Managers.achievements:achievement_definitions()

		return definitions[id]
	end,
	achievement_category_label = function (category_id)
		local localization_key = AchievementCategories[category_id].display_name

		return Localize(localization_key)
	end,
	get_reward_item = function (achievement_definition)
		local reward_item, item_group = nil
		local rewards = achievement_definition and achievement_definition.rewards

		if rewards and #rewards > 0 then
			local reward_id = rewards[1].masterId
			reward_item = MasterItems.get_item(reward_id)
			local item_type = reward_item and reward_item.item_type
			item_group = item_type and _item_type_group_lookup[item_type]
		end

		return reward_item, item_group
	end,
	get_all_reward_items = function (achievement_definition)
		local reward_item, item_group = nil
		local rewards = achievement_definition and achievement_definition.rewards
		local rewards_data = {}

		if rewards and #rewards > 0 then
			for i = 1, #rewards do
				local reward_id = rewards[i].masterId
				reward_item = MasterItems.get_item(reward_id)
				local item_type = reward_item and reward_item.item_type
				item_group = item_type and _item_type_group_lookup[item_type]
				rewards_data[#rewards_data + 1] = {
					reward_item = reward_item,
					item_type = item_type
				}
			end
		end

		return rewards_data
	end,
	get_acheivement_by_reward_item = function (item)
		local achievements = Managers.achievements:achievement_definitions()

		for _, achievement in pairs(achievements) do
			local rewards = achievement.rewards

			if rewards and #rewards > 0 then
				for i = 1, #rewards do
					local reward_id = rewards[i].masterId
					local reward_item = MasterItems.get_item(reward_id)

					if reward_item and reward_item.name == item.name then
						return achievement
					end
				end
			end
		end
	end,
	localized_title = function (achievement_definition)
		local flags = achievement_definition.flags
		local loc_title_variables = achievement_definition.loc_title_variables
		local localized_title = Localize(achievement_definition.title, loc_title_variables ~= nil, loc_title_variables)

		if flags.private_only then
			localized_title = string.format("%s %s", localized_title, TextUtils.apply_color_to_text("", Color.terminal_text_warning_light(255, true)))
		end

		return localized_title
	end
}
local empty = {}

function AchievementUIHelper.localized_description(achievement_definition, separate_private_discription)
	local flags = achievement_definition.flags
	local loc_variables = achievement_definition.loc_variables or empty
	local has_target = loc_variables.target ~= nil

	if not has_target then
		loc_variables.target = achievement_definition.target
	end

	local localized_description = Localize(achievement_definition.description, loc_variables ~= nil, loc_variables)

	if not has_target then
		loc_variables.target = nil
	end

	local private_description = ""

	if flags.private_only then
		private_description = string.format("\n %s: %s", Localize("loc_private_tag_name"), Localize("loc_private_tag_description"))
		private_description = TextUtils.apply_color_to_text(private_description, Color.terminal_text_warning_dark(255, true))

		if not separate_private_discription then
			localized_description = string.format("%s%s", localized_description, private_description)
		end
	end

	return localized_description, private_description
end

function AchievementUIHelper.get_family(achievement_definition)
	local definitions = Managers.achievements:achievement_definitions()
	local flags = achievement_definition.flags
	local hide_missing = flags.hide_missing
	local at = achievement_definition

	while at.previous do
		at = definitions[at.previous]
	end

	local family = {}

	while at ~= nil do
		family[#family + 1] = at

		if hide_missing and at == achievement_definition then
			at = nil
		else
			at = definitions[at.next]
		end
	end

	return family
end

function AchievementUIHelper.is_achievements_from_same_family(a_achievement_definition, b_achievement_definition)
	local family_a = AchievementUIHelper.get_family(a_achievement_definition)

	for i = 1, #family_a do
		local family_achievement = family_a[i]

		if family_achievement.id == b_achievement_definition.id then
			return true
		end
	end

	return false
end

function AchievementUIHelper.get_achievement_family_order(achievement_definition)
	local family = AchievementUIHelper.get_family(achievement_definition)
	local num_family_achievements = #family

	if num_family_achievements > 1 then
		for i = 1, num_family_achievements do
			local family_achievement = family[i]
			local family_achievement_id = family_achievement.id

			if family_achievement_id == achievement_definition.id then
				return i
			end
		end
	end

	return nil
end

function AchievementUIHelper.add_favorite_achievement(id)
	local save_data = Managers.save:account_data()
	local favorite_achievements = save_data.favorite_achievements

	if UISettings.max_favorite_achievements <= #favorite_achievements then
		return false
	end

	if table.index_of(favorite_achievements, id) ~= -1 then
		return false
	end

	favorite_achievements[#favorite_achievements + 1] = id

	Managers.save:queue_save()

	return true
end

function AchievementUIHelper.remove_favorite_achievement(id)
	local save_data = Managers.save:account_data()
	local favorite_achievements = save_data.favorite_achievements
	local index = table.index_of(favorite_achievements, id)

	if index == -1 then
		return false
	end

	table.remove(favorite_achievements, index)
	Managers.save:queue_save()

	return true
end

function AchievementUIHelper.is_favorite_achievement(id)
	local save_data = Managers.save:account_data()
	local favorite_achievements = save_data.favorite_achievements
	local index = table.index_of(favorite_achievements, id)

	return index ~= -1
end

function AchievementUIHelper.favorite_achievement_count()
	local save_data = Managers.save:account_data()
	local favorite_achievements = save_data.favorite_achievements
	local favorite_achievement_size = #favorite_achievements

	return favorite_achievement_size, UISettings.max_favorite_achievements
end

return AchievementUIHelper
