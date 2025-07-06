local BackendError = require("scripts/foundation/managers/backend/backend_error")
local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Promise = require("scripts/foundation/utilities/promise")
local Interface = {
	"fetch",
	"create",
	"delete",
	"equip_items_in_slots"
}
local Characters = class("Characters")

function Characters:init()
	return
end

function Characters:equip_item_slot(character_id, slot_name, gear_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/inventory/"):path(slot_name), {
		method = "PUT",
		body = {
			instanceId = gear_id
		}
	}):next(function (data)
		return data.body
	end)
end

function Characters:equip_items_in_slots(character_id, item_gear_ids_by_slots, item_gear_names_by_slots)
	local body = {}

	for slot_id, gear_id in pairs(item_gear_ids_by_slots) do
		body[#body + 1] = {
			instanceId = gear_id,
			slotId = slot_id
		}
	end

	for slot_id, name in pairs(item_gear_names_by_slots) do
		body[#body + 1] = {
			masterId = name,
			slotId = slot_id
		}
	end

	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/inventory/"), {
		method = "PUT",
		body = body
	}):next(function (data)
		return data.body
	end)
end

function Characters:unequip_slots(character_id, slots)
	local promises = {}

	for slot_name, _ in pairs(slots) do
		promises[#promises + 1] = BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/inventory/"):path(slot_name), {
			method = "DELETE"
		})
	end

	return Promise.all(unpack(promises))
end

function Characters:equip_master_items_in_slots(character_id, item_master_ids_by_slots)
	local body = {}

	for slot_id, master_id in pairs(item_master_ids_by_slots) do
		body[#body + 1] = {
			masterId = master_id,
			slotId = slot_id
		}
	end

	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/inventory/"), {
		method = "PUT",
		body = body
	}):next(function (data)
		return data.body
	end)
end

function Characters:create(new_character)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(), {
		method = "POST",
		body = {
			newCharacter = new_character
		}
	}):next(function (data)
		return data.body
	end):next(function (result)
		local character = result.character

		if not character or not character.id then
			local p = Promise:new()

			p:reject(BackendUtilities.create_error(BackendError.UnknownError, "Invalid characterId"))

			return p
		end

		return character
	end)
end

function Characters:transform(character_id, transformed_character, operation_cost)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/operations"):path("/transform"), {
		method = "PUT",
		body = transformed_character
	}):next(function (result)
		return Managers.data_service.store:on_character_operation(operation_cost):next(function ()
			return result
		end)
	end)
end

function Characters:fetch_operations()
	return Managers.backend:title_request("/data/characters/operations", {
		method = "GET"
	}):next(function (data)
		return data.body
	end)
end

local function _process_stats(stats)
	local result = {}

	for i, v in ipairs(stats) do
		local type_path = table.concat(v.typePath, "/")
		result[type_path] = v.value
	end

	return result
end

function Characters:get_character_stats(account_id, character_id, stat_prefix)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/statistics/"):path(stat_prefix or "")):next(function (data)
		return _process_stats(data.body.statistics)
	end)
end

function Characters:fetch_account_character(account_id, character_id, include_inventory, include_progression)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):query("includeInventoryDetails", include_inventory):query("includeProgressionDetails", include_progression), {}, account_id):next(function (data)
		return data.body
	end)
end

function Characters:fetch(character_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id)):next(function (data)
		if character_id then
			return data.body.character
		else
			return data.body.characters
		end
	end)
end

function Characters:delete_character(character_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id), {
		method = "DELETE"
	}):next(function (data)
		return data.body
	end)
end

function Characters:set_specialization(character_id, specialization)
	return self:set_data(character_id, "career", {
		specialization = specialization
	})
end

function Characters:set_talents_v2(character_id, talents)
	return self:set_data(character_id, "vocation", {
		talents = talents
	})
end

function Characters:get_talents_v2(character_id)
	return self:get_data(character_id, "vocation", "talents")
end

function Characters:set_character_height(character_id, value)
	return self:set_data(character_id, "personal", {
		character_height = value
	})
end

function Characters:get_character_height(character_id)
	return self:get_data(character_id, "personal", "character_height")
end

local function _process_narrative(data)
	local result = {}

	for i, v in ipairs(data) do
		local type_path = v.typePath[2]
		result[type_path] = v.value
	end

	return result
end

function Characters:get_narrative(character_id)
	return self:get_data(character_id, "narrative"):next(function (response)
		return _process_narrative(response.body.data)
	end)
end

function Characters:get_missions(character_id)
	return self:get_data(character_id, "narrative|missions"):next(function (response)
		local data = _process_narrative(response.body.data)

		return data and data.missions or {}
	end)
end

function Characters:set_mission(character_id, event_name, is_completed)
	return self:set_data(character_id, "narrative|missions", {
		[event_name] = is_completed ~= false and "true" or "false"
	})
end

function Characters:set_narrative_story_chapter(character_id, story_name, chapter_id)
	return self:set_data(character_id, "narrative|stories", {
		[story_name] = chapter_id
	})
end

function Characters:set_narrative_event_completed(character_id, event_name, is_completed)
	return self:set_data(character_id, "narrative|events", {
		[event_name] = is_completed ~= false and "true" or "false"
	})
end

function Characters:get_narrative_event(character_id, event_name, optional_account_id)
	return self:get_data(character_id, "narrative|events", event_name, optional_account_id):next(function (value)
		return value == "true" or value == true
	end)
end

function Characters:set_data(character_id, section, data)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/data/" .. section), {
		method = "PUT",
		body = {
			data = data
		}
	}):next(function (data)
		return nil
	end)
end

function Characters:get_data(character_id, section, part, optional_account_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/data/" .. section), nil, optional_account_id):next(function (data)
		if part then
			if #data.body.data > 0 then
				return data.body.data[1].value[part]
			else
				return nil
			end
		else
			return data
		end
	end)
end

function Characters:check_name(name, name_type)
	local sanitized_name = Http.url_encode(name)
	local url = BackendUtilities.url_builder("/data/characters/name/" .. sanitized_name .. "/check")

	if name_type then
		url:query("nameType", name_type)
	end

	return Managers.backend:title_request(url:to_string(), {
		method = "GET"
	}):next(function (data)
		return data.body
	end)
end

implements(Characters, Interface)

return Characters
