local Archetypes = require("scripts/settings/archetype/archetypes")
local BackendError = require("scripts/managers/error/errors/backend_error")
local MasterItems = require("scripts/backend/master_items")
local ParameterResolver = require("scripts/foundation/utilities/parameters/parameter_resolver")
local ProfileUtils = require("scripts/utilities/profile_utils")
local Promise = require("scripts/foundation/utilities/promise")
local ProfilesService = class("ProfilesService")

function ProfilesService:init(backend_interface)
	self._backend_interface = backend_interface
end

local function _find_character_progression(character, characters_progression)
	local character_id = character.id

	for i = 1, #characters_progression do
		local progression = characters_progression[i]

		if progression.id == character_id then
			return progression
		end
	end
end

local function _fetch_all_backend_profiles(backend_interface)
	local characters_promise = backend_interface.characters:fetch()
	local characters_progression_promise = backend_interface.progression:get_entity_type_progression("character")
	local gear_list_promise = Managers.data_service.gear:fetch_gear()
	local selected_character_id_promise = backend_interface.account:get_selected_character()

	return Promise.all(characters_promise, characters_progression_promise, gear_list_promise, selected_character_id_promise):next(function (results)
		local characters, characters_progression, gear_list, selected_character_id = unpack(results, 1, 4)

		if not characters or #characters == 0 then
			return Promise.resolved({
				profiles = {}
			})
		end

		local profiles = {}
		local selected_profile, backup_profile = nil

		for i = 1, #characters do
			local character = characters[i]
			local archetype_name = character.archetype

			if Archetypes[archetype_name] then
				local progression = _find_character_progression(character, characters_progression)
				local profile = ProfileUtils.character_to_profile(character, gear_list, progression)
				profiles[#profiles + 1] = profile

				if selected_character_id and character.id == selected_character_id then
					selected_profile = profile
				else
					backup_profile = profile
				end
			elseif backup_profile then
				selected_profile = backup_profile
			end
		end

		selected_profile = selected_profile or profiles[1]

		return Promise.resolved({
			profiles = profiles,
			selected_profile = selected_profile,
			gear = gear_list
		})
	end)
end

local function _fetch_backend_profile(backend_interface, character_id)
	local character_promise = backend_interface.characters:fetch(character_id)
	local character_progression_promise = backend_interface.progression:get_progression("character", character_id)
	local gear_list_promise = Managers.data_service.gear:fetch_gear()

	return Promise.all(character_promise, character_progression_promise, gear_list_promise):next(function (results)
		local character, character_progression, gear_list = unpack(results, 1, 3)
		local profile = ProfileUtils.character_to_profile(character, gear_list, character_progression)

		return Promise.resolved(profile)
	end)
end

local function _new_character_to_profile(backend_interface, character)
	return Managers.data_service.gear:fetch_gear():next(function (gear_list)
		local profile = ProfileUtils.character_to_profile(character, gear_list, nil)

		return profile
	end)
end

local function _handle_fetch_all_profiles_error()
	return Promise.rejected({})
end

function ProfilesService:fetch_all_profiles()
	return _fetch_all_backend_profiles(self._backend_interface):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return _handle_fetch_all_profiles_error()
	end)
end

function ProfilesService:new_character_to_profile(character)
	return _new_character_to_profile(self._backend_interface, character):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

function ProfilesService:fetch_profile(character_id)
	return _fetch_backend_profile(self._backend_interface, character_id):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

local function _invalidate_gear_cache(promise)
	return promise:next(function (result)
		Managers.data_service.gear:invalidate_gear_cache()

		return result
	end):catch(function (err)
		Managers.data_service.gear:invalidate_gear_cache()

		return Promise.rejected(err)
	end)
end

function ProfilesService:create_profile(profile)
	return _invalidate_gear_cache(self._backend_interface.characters:create(profile)):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

function ProfilesService:delete_profile(character_id)
	return self._backend_interface.characters:delete_character(character_id):next(function (result)
		Managers.data_service.gear:on_character_deleted(character_id)

		return result
	end):catch(function (error)
		Managers.data_service.gear:invalidate_gear_cache()
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected(error)
	end)
end

function ProfilesService:equip_items_in_slots(character_id, item_gear_ids_by_slots, item_gear_names_by_slots)
	local promise = self._backend_interface.characters:equip_items_in_slots(character_id, item_gear_ids_by_slots, item_gear_names_by_slots)

	if table.is_empty(item_gear_names_by_slots) then
		return promise
	else
		return _invalidate_gear_cache(promise)
	end
end

function ProfilesService:unequip_slots(character_id, unequipped_slots)
	local promise = self._backend_interface.characters:unequip_slots(character_id, unequipped_slots)

	return _invalidate_gear_cache(promise)
end

function ProfilesService:equip_master_items_in_slots(character_id, item_master_ids_by_slots)
	return _invalidate_gear_cache(self._backend_interface.characters:equip_master_items_in_slots(character_id, item_master_ids_by_slots))
end

function ProfilesService:fetch_suggested_names_by_archetype(archetype_name, gender, planet)
	return Managers.backend.interfaces.social:suggested_names_by_archetype(archetype_name, gender, planet):next(function (result)
		local names = {
			character = result.names,
			companion = result.companionNames
		}

		return Promise.resolved(names)
	end):catch(function (error)
		return Promise.resolved({
			"Rikard",
			"Thomas",
			"Jane",
			"Niki",
			"Marie",
			"Rikard",
			"Thomas",
			"Jane",
			"Niki",
			"Marie",
			companion = "Alex",
			character = "Alex"
		})
	end)
end

function ProfilesService:set_character_height(character_id, value)
	return self._backend_interface.characters:set_character_height(character_id, value):next(function ()
		return Promise.resolved(character_id)
	end):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

function ProfilesService:check_name(name)
	return self._backend_interface.characters:check_name(name):next(function (data)
		return Promise.resolved(data)
	end):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

function ProfilesService:check_companion_name(name)
	return self._backend_interface.characters:check_name(name, "comp"):next(function (data)
		return Promise.resolved(data)
	end):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

function ProfilesService:fetch_character_operation(shopkeep, operation_name)
	return self._backend_interface.characters:fetch_character_operation():next(function (data)
		local operations = Promise.resolved(data)
		local operation = operations[shopkeep][operation_name]

		return operation
	end):catch(function (error)
		Managers.error:report_error(BackendError:new(error))

		return Promise.rejected({})
	end)
end

return ProfilesService
