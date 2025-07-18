local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local CraftingSettings = require("scripts/settings/item/crafting_settings")
local MasterItems = require("scripts/backend/master_items")
local Promise = require("scripts/foundation/utilities/promise")
local TRAIT_STICKER_BOOK_ENUM = CraftingSettings.trait_sticker_book_enum
local Crafting = class("Crafting")

local function _send_crafting_operation(request_body)
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/crafting"), {
		method = "POST",
		body = request_body
	}):next(function (data)
		data.body._links = nil
		local body = data.body
		local items = body.items

		for i, item in pairs(items) do
			items[i] = MasterItems.get_item_instance(item, item.uuid)
		end

		local traits = body.traits

		for i, trait in pairs(traits) do
			traits[i] = MasterItems.get_item_instance(trait, trait.uuid)
		end

		return data.body
	end)
end

function Crafting:refresh_all_costs()
	return Promise.all(self:refresh_crafting_costs(), self:refresh_traits_mastery_costs(), self:refresh_sacrifice_mastery_costs())
end

function Crafting:refresh_crafting_costs()
	return Managers.backend:title_request(BackendUtilities.url_builder("/data/account/crafting/costs"):to_string()):next(function (data)
		local weapon_crafting_costs = data.body.costs.weapon
		local gadget_crafting_costs = data.body.costs.gadget
		self._crafting_costs = {
			weapon = weapon_crafting_costs,
			gadget = gadget_crafting_costs
		}

		return self._crafting_costs
	end)
end

function Crafting:get_item_crafting_metadata(master_id)
	return Managers.backend:title_request(BackendUtilities.url_builder("/data/crafting/items/"):path(Http.url_encode(master_id)):path("/meta"):to_string()):next(function (data)
		return data.body
	end)
end

function Crafting:crafting_costs()
	return self._crafting_costs
end

function Crafting:trait_sticker_book(trait_category_id)
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/traits/"):path(trait_category_id)):next(function (data)
		local body = data.body
		local sticker_book = {}
		local num_ranks = body.numRanks

		for trait_name, trait_bitmask in pairs(body.stickerBook) do
			local status = {}

			for i = 1, num_ranks do
				local value = nil

				if bit.band(bit.rshift(trait_bitmask, i + 3), 1) == 0 then
					value = TRAIT_STICKER_BOOK_ENUM.invalid
				elseif bit.band(bit.rshift(trait_bitmask, i - 1), 1) == 1 then
					value = TRAIT_STICKER_BOOK_ENUM.seen
				else
					value = TRAIT_STICKER_BOOK_ENUM.unseen
				end

				status[i] = value
			end

			sticker_book[trait_name] = status
		end

		return sticker_book
	end)
end

function Crafting:all_trait_sticker_book()
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/traits/")):next(function (data)
		local body = data.body
		local sticker_book = {}

		for trait_cat_name, trait_cat_data in pairs(body) do
			local trait_data = {}
			local num_ranks = trait_cat_data.numRanks

			for trait_name, trait_bitmask in pairs(trait_cat_data.stickerBook) do
				local status = {}

				for i = 1, num_ranks do
					local value = nil

					if bit.band(bit.rshift(trait_bitmask, i + 3), 1) == 0 then
						value = TRAIT_STICKER_BOOK_ENUM.invalid
					elseif bit.band(bit.rshift(trait_bitmask, i - 1), 1) == 1 then
						value = TRAIT_STICKER_BOOK_ENUM.seen
					else
						value = TRAIT_STICKER_BOOK_ENUM.unseen
					end

					status[i] = value
				end

				trait_data[trait_name] = status
			end

			sticker_book[trait_cat_name] = trait_data
		end

		return sticker_book
	end)
end

function Crafting:upgrade_weapon_rarity(gear_id)
	return _send_crafting_operation({
		op = "upgradeWeaponRarity",
		gearId = gear_id
	})
end

function Crafting:upgrade_gadget_rarity(gear_id)
	return _send_crafting_operation({
		op = "upgradeGadgetRarity",
		gearId = gear_id
	})
end

function Crafting:extract_trait_from_weapon(gear_id, trait_index)
	return _send_crafting_operation({
		traitType = "traits",
		op = "extractTrait",
		gearId = gear_id,
		traitIndex = trait_index - 1
	})
end

function Crafting:extract_perk_from_weapon(gear_id, trait_index)
	return _send_crafting_operation({
		traitType = "perks",
		op = "extractTrait",
		gearId = gear_id,
		traitIndex = trait_index - 1
	})
end

function Crafting:replace_trait_in_weapon(gear_id, existing_trait_index, new_trait_id, new_trait_tier)
	return _send_crafting_operation({
		traitType = "traits",
		op = "replaceTrait",
		gearId = gear_id,
		traitIndex = existing_trait_index - 1,
		traitId = new_trait_id,
		traitTier = new_trait_tier
	})
end

function Crafting:replace_perk_in_weapon(gear_id, existing_trait_index, new_trait_id, new_trait_tier)
	return _send_crafting_operation({
		traitType = "perks",
		op = "replaceTrait",
		gearId = gear_id,
		traitIndex = existing_trait_index - 1,
		traitId = new_trait_id,
		traitTier = new_trait_tier
	})
end

function Crafting:reroll_perk_in_item(gear_id, existing_perk_index, is_gadget)
	return _send_crafting_operation({
		op = "rerollPerk",
		gearId = gear_id,
		perkIndex = existing_perk_index - 1,
		itemType = is_gadget and "gadget" or "weapon"
	})
end

function Crafting:fuse_traits(character_id, trait_ids)
	return _send_crafting_operation({
		op = "fuseTraits",
		traitIds = trait_ids,
		characterId = character_id
	})
end

function Crafting:add_weapon_expertise(gear_id, added_expertise)
	return _send_crafting_operation({
		op = "addExpertise",
		gearId = gear_id,
		newLevel = added_expertise
	})
end

function Crafting:extract_weapon_mastery(track_id, gear_ids)
	return _send_crafting_operation({
		op = "extractMastery",
		gearIds = gear_ids,
		trackId = track_id
	})
end

function Crafting:refresh_traits_mastery_costs()
	return Managers.backend:title_request(BackendUtilities.url_builder("/data/crafting/costs/traits/purchase"):to_string()):next(function (data)
		self._traits_mastery_costs = data.body or {}

		return self._traits_mastery_costs
	end)
end

function Crafting:traits_mastery_costs()
	return self._traits_mastery_costs
end

function Crafting:refresh_sacrifice_mastery_costs()
	return Managers.backend:title_request(BackendUtilities.url_builder("/data/crafting/settings/mastery"):to_string()):next(function (data)
		self._sacrifice_mastery_costs = data.body and data.body.extractMastery or {}

		return self._sacrifice_mastery_costs
	end)
end

function Crafting:sacrifice_mastery_costs()
	return self._sacrifice_mastery_costs
end

return Crafting
