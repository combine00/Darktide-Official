local Promise = require("scripts/foundation/utilities/promise")
local UISettings = require("scripts/settings/ui/ui_settings")
local MasteryUtils = require("scripts/utilities/mastery")
local MasterItems = require("scripts/backend/master_items")
local ItemUtils = require("scripts/utilities/items")
local MasteryService = class("MasteryService")

function MasteryService:_convert_mastery_data(mastery_data)
	local mastery = mastery_data.mastery
	local mastery_progress = mastery_data.mastery_overview
	local pattern_name = mastery_data.id

	if pattern_name then
		local current_xp = mastery_progress.state and mastery_progress.state.xpTracked or 0
		local claimed_level = mastery_progress.state and mastery_progress.state.rewarded or -1
		local milestones = mastery.tiers or {}
		local start_exp, end_exp, current_level = nil

		for i = 1, #milestones do
			local milestone = milestones[i]
			milestone.level = i
			local claims = mastery_progress.claims and mastery_progress.claims[tostring(i - 1)]

			if claims then
				for reward_id, reward_data in pairs(milestone.rewards) do
					local claimed_reward = nil

					for f = 1, #claims do
						local claim_id = claims[f]

						if claim_id == reward_id then
							claimed_reward = true

							break
						end
					end

					milestone.rewards[reward_id].claimed = claimed_reward
				end
			end
		end

		for i = 1, #milestones do
			local milestone = milestones[i]
			local milestone_xp = milestone.xpLimit or 1
			local previous_milestone = milestones[i - 1]

			if current_xp < milestone_xp then
				current_level = previous_milestone and previous_milestone.level or 0
				start_exp = previous_milestone and previous_milestone.xpLimit or 0
				end_exp = milestone_xp

				break
			end
		end

		if not current_level then
			local last_milestone = #milestones
			local milestone = milestones[last_milestone]
			local previous_milestone = milestones[last_milestone - 1]
			current_level = milestone.level or 0
			start_exp = previous_milestone.xpLimit or 0
			end_exp = milestone.xpLimit or 0
		end

		return {
			current_xp = math.floor(current_xp),
			mastery_level = current_level or 0,
			milestones = milestones,
			start_xp = start_exp and math.floor(start_exp),
			end_xp = end_exp and math.floor(end_exp),
			mastery_id = pattern_name,
			id = mastery_progress.id,
			claimed_level = claimed_level
		}
	end

	return {}
end

function MasteryService:init(backend_interface)
	self._backend_interface = backend_interface
	self._mastery_tracks = {}
	self._mastery_track_ids = {}
	self._mastery_track_ids_inverted = {}
	self._track_claim_in_progress = {}
end

function MasteryService:_get_mastery_track_and_state(id, mastery_overview)
	local mastery = self._mastery_tracks[id]
	local mastery_data = {
		id = self._mastery_track_ids_inverted[id],
		mastery = mastery,
		mastery_overview = mastery_overview or {}
	}
	local converted_mastery_data = self:_convert_mastery_data(mastery_data)

	return converted_mastery_data
end

function MasteryService:_add_mastery_claim_count(mastery_id)
	local track_id = self._mastery_track_ids[mastery_id]
	self._track_claim_in_progress[track_id] = self._track_claim_in_progress[track_id] and self._track_claim_in_progress[track_id] + 1 or 1
end

function MasteryService:_remove_mastery_claim_count(mastery_id)
	local track_id = self._mastery_track_ids[mastery_id]
	self._track_claim_in_progress[track_id] = self._track_claim_in_progress[track_id] and self._track_claim_in_progress[track_id] - 1

	if self._track_claim_in_progress[track_id] <= 0 then
		self._track_claim_in_progress[track_id] = nil
	end
end

function MasteryService:is_mastery_claim_in_progress(mastery_id)
	local track_id = self._mastery_track_ids[mastery_id]

	return not not self._track_claim_in_progress[track_id]
end

function MasteryService:are_all_masteries_claimed()
	return table.is_empty(self._track_claim_in_progress)
end

function MasteryService:_get_masteries_tracks()
	if table.is_empty(self._mastery_tracks) then
		return self._backend_interface.tracks:get_masteries_tracks():next(function (masteries)
			for i = 1, #masteries do
				local mastery = masteries[i]
				local id = mastery.id
				local name = mastery.data and mastery.data.pattern
				self._mastery_tracks[id] = mastery
				self._mastery_track_ids[name] = id
				self._mastery_track_ids_inverted[id] = name
			end
		end)
	else
		return Promise.resolved()
	end
end

function MasteryService:get_all_masteries(optional_account_id)
	return self:_get_masteries_tracks():next(function ()
		return self._backend_interface.tracks:get_track_state()
	end):next(function (tracks_state_data)
		local mastery_data_by_id = {}

		for id, mastery_track in pairs(self._mastery_tracks) do
			local track_state = nil

			if tracks_state_data then
				track_state = tracks_state_data[id]
			end

			local mastery_data = self:_get_mastery_track_and_state(id, track_state)
			mastery_data_by_id[mastery_data.mastery_id] = mastery_data
		end

		return mastery_data_by_id
	end)
end

function MasteryService:get_mastery(track_id, optional_account_id)
	return self:_get_masteries_tracks():next(function ()
		return self._backend_interface.tracks:get_track(track_id):next(function (mastery)
			if not table.is_empty(mastery) then
				local id = mastery.id

				return self._backend_interface.tracks:get_track_state(id, optional_account_id):next(function (mastery_overview)
					local mastery = self:_get_mastery_track_and_state(id, mastery_overview)

					return mastery
				end):catch(function ()
					local mastery = self:_get_mastery_track_and_state(id)

					return mastery
				end)
			end
		end):catch(function (error)
			return Promise.resolved({})
		end)
	end)
end

function MasteryService:get_mastery_by_pattern(pattern_id, optional_account_id)
	return self:_get_masteries_tracks():next(function ()
		local track_id = self._mastery_track_ids[pattern_id]

		if track_id then
			return self:get_mastery(track_id, optional_account_id)
		else
			return Promise.resolved({})
		end
	end):catch(function (error)
		return Promise.resolved({})
	end)
end

local function _purchase_trait(self, pattern_name, trait_name, rarity)
	local trait_cat_id = MasteryUtils.get_pattern_id_to_category_id(pattern_name)

	return self._backend_interface.mastery:purchase_trait(trait_cat_id, trait_name, rarity):next(function (data)
		return data
	end):catch(function (error)
		return Promise.rejected(error)
	end)
end

function MasteryService:purchase_traits(pattern_name, traits_data)
	local operations = table.clone(traits_data)

	for i = 1, #operations do
		local operation = operations[i]
		operation.operation_index = i
	end

	local failed_traits = {}

	local function _recursive_purchase_trait(trait_data)
		if not trait_data then
			return Managers.data_service.crafting:reset_sticker_book():next(function ()
				self:_remove_mastery_claim_count(pattern_name)

				return Promise.resolved(failed_traits)
			end)
		else
			local trait_name = trait_data.trait_name
			local rarity = trait_data.rarity

			return _purchase_trait(self, pattern_name, trait_name, rarity):next(function ()
				table.remove(operations, 1)

				return _recursive_purchase_trait(operations[1])
			end):catch(function ()
				local invalid_operations_indices = {}

				for i = 1, #operations do
					local operation = operations[i]

					if operation.trait_name == trait_name then
						failed_traits[#failed_traits + 1] = operation
						invalid_operations_indices[#invalid_operations_indices + 1] = operation.operation_index
					end
				end

				while #invalid_operations_indices > 0 do
					local operation_index = invalid_operations_indices[1]

					for i = 1, #operations do
						local operation = operations[i]

						if operation_index == operation.operation_index then
							table.remove(operations, i)

							break
						end
					end

					table.remove(invalid_operations_indices, 1)
				end

				return _recursive_purchase_trait(operations[1])
			end)
		end
	end

	if not table.is_empty(operations) then
		self:_add_mastery_claim_count(pattern_name)

		return _recursive_purchase_trait(operations[1])
	end

	return Promise.resolved(failed_traits)
end

function MasteryService:purchase_trait(pattern_name, trait_name, rarity)
	return _purchase_trait(self, pattern_name, trait_name, rarity):next(function (data)
		return data
	end):catch(function (error)
		return error
	end)
end

function MasteryService:switch_mark(gear_id, mark_id)
	return self._backend_interface.mastery:switch_mark(gear_id, mark_id):next(function (data)
		return data
	end):catch(function (error)
		return error
	end)
end

function MasteryService:claim_level(mastery_data, level_to_claim)
	if not mastery_data or not level_to_claim then
		return Promise.resolved()
	end

	local track_id = self._mastery_track_ids[mastery_data.mastery_id]

	return self._backend_interface.tracks:claim_track_tier(track_id, level_to_claim):next(function ()
		local rewards = mastery_data.milestones and mastery_data.milestones[level_to_claim] and mastery_data.milestones[level_to_claim].rewards

		if rewards then
			for reward_id, data in pairs(rewards) do
				-- Nothing
			end
		end
	end)
end

function MasteryService:claim_levels_by_new_exp(mastery_data, new_exp)
	local chain_data = {}
	local total_added_exp = (new_exp or 0) + (mastery_data.current_xp or 0)
	local track_id = self._mastery_track_ids[mastery_data.mastery_id]
	local start_claim, end_claim = nil

	if mastery_data then
		start_claim, end_claim = MasteryUtils.get_levels_to_claim(mastery_data, total_added_exp)

		if start_claim <= end_claim then
			for f = start_claim, end_claim do
				chain_data[#chain_data + 1] = {
					arguments = {
						mastery_data,
						f
					}
				}
			end
		end
	end

	if not table.is_empty(chain_data) then
		self:_add_mastery_claim_count(mastery_data.mastery_id)

		local function run_chain(promises, results)
			local data = chain_data[1]

			return self:claim_level(unpack(data.arguments)):next(function (result)
				results[#results + 1] = result

				table.remove(chain_data, 1)

				if table.is_empty(promises) then
					if not table.is_empty(results) then
						return Promise.resolved(results)
					else
						Promise.resolved()
					end
				else
					return run_chain(chain_data, results)
				end
			end):catch(function (error)
				if not table.is_empty(results) then
					return Promise.resolved(results)
				else
					Promise.resolved()
				end
			end)
		end

		return run_chain(chain_data, {}):next(function (results)
			self:_remove_mastery_claim_count(mastery_data.mastery_id)

			return self:get_mastery(track_id):next(function (data)
				if not table.is_empty(data) then
					return data
				end
			end):catch(function ()
				return nil
			end)
		end):catch(function (error)
			self:_remove_mastery_claim_count(mastery_data.mastery_id)
			Promise.resolved()
		end)
	else
		return Promise.resolved()
	end
end

function MasteryService:check_and_claim_all_masteries_levels(masteries_data)
	local promises = {}

	for id, mastery_data in pairs(masteries_data) do
		promises[#promises + 1] = self:claim_levels_by_new_exp(mastery_data)
	end

	local claim_promise = nil

	if table.is_empty(promises) then
		claim_promise = Promise.resolved({})
	else
		claim_promise = Promise.all(unpack(promises)):next(function (data)
			local result = {}

			for index, mastery_data in pairs(data) do
				if mastery_data and mastery_data.mastery_id then
					result[mastery_data.mastery_id] = mastery_data
				end
			end

			return result
		end)
	end

	return claim_promise:next(function ()
		local missing_rewards_promises = {}

		for index, mastery_data in pairs(masteries_data) do
			local missing_rewards = MasteryUtils.get_unclaimed_rewards(mastery_data)
			local track_id = self._mastery_track_ids[mastery_data.mastery_id]

			for tier, reward_ids in pairs(missing_rewards) do
				for i = 1, #reward_ids do
					local reward_id = reward_ids[i]
					missing_rewards_promises[#missing_rewards_promises + 1] = self._backend_interface.tracks:claim_track_tier_reward(track_id, tier, reward_id)
				end
			end
		end

		return Promise.all(unpack(missing_rewards_promises))
	end)
end

function MasteryService:get_track_id(mastery_id)
	return self._mastery_track_ids[mastery_id]
end

function MasteryService:get_all_traits_data(masteries_data)
	if not masteries_data then
		return {}
	end

	local result = {}

	for id, mastery_data in pairs(masteries_data) do
		result[id] = self:get_traits_data_by_mastery_id(id)
	end

	return result
end

function MasteryService:get_traits_data_by_mastery_id(mastery_id)
	if not mastery_id then
		return {}
	end

	local mastery = UISettings.weapon_patterns[mastery_id]

	if mastery and mastery.marks then
		for i = 1, #mastery.marks do
			local mark = mastery.marks[i]
			local master_item = mark.item and MasterItems.get_item(mark.item)

			if master_item then
				local trait_category = ItemUtils.trait_category(master_item)

				if trait_category then
					local traits_data = {}
					local seen_traits = Managers.data_service.crafting:cached_trait_sticker_book(trait_category)
					local valid_traits = {}

					for name, trait_data in pairs(seen_traits) do
						if MasterItems.get_item(name) then
							valid_traits[#valid_traits + 1] = {
								trait_status = trait_data,
								trait_name = name
							}
						end
					end

					table.sort(valid_traits, function (a, b)
						return a.trait_name < b.trait_name
					end)

					return valid_traits
				end
			end
		end
	end

	return {}
end

return MasteryService
