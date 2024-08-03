local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Promise = require("scripts/foundation/utilities/promise")
local Interface = {}
local Account = class("Account")

function Account:init()
	return
end

function Account:get_boon_inventory()
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("boons")):next(function (data)
		return data.body
	end)
end

function Account:set_has_created_first_character(value)
	return self:set_data("core", {
		has_created_first_character = value
	})
end

function Account:get_has_created_first_character()
	return self:get_data("core", "has_created_first_character")
end

function Account:set_has_completed_onboarding(value)
	return self:set_data("core", {
		has_completed_onboarding = value
	})
end

function Account:get_has_completed_onboarding()
	return self:get_data("core", "has_completed_onboarding")
end

function Account:set_selected_character(character_id)
	return self:set_data("core", {
		selected_character = character_id
	})
end

function Account:get_selected_character()
	return self:get_data("core", "selected_character")
end

function Account:get_has_migrated_commendation_score()
	return self:get_data("core", "has_migrated_commendation_score")
end

function Account:get()
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("")):next(function (data)
		return data.body
	end)
end

function Account:set_data(section, data)
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/data/"):path(section), {
		method = "PUT",
		body = {
			data = data
		}
	}):next(function (data)
		return nil
	end)
end

local function _same_path(...)
	local desired_path = {
		...
	}

	return function (entry)
		local real_path = entry.typePath

		return table.array_equals(real_path, desired_path)
	end
end

function Account:get_data(section, part, ...)
	local same_path = _same_path(section, ...)

	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/data/"):path(section)):next(function (data)
		local entries = data.body.data
		local index = table.index_of_condition(entries, same_path)
		local entry = entries[index]

		if entry and part then
			return entry.value[part]
		else
			return entry
		end
	end)
end

function Account:rename_account(requested_name)
	return BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/name"), {
		method = "POST",
		body = {
			accountName = requested_name
		}
	})
end

function Account:_get_migration_status(account_id)
	return Managers.backend:title_request(BackendUtilities.url_builder("/data/"):path(account_id):path("/account/migrations/status"):to_string()):next(function (data)
		local body = data.body
		local status = body.status

		return {
			has_pending = status.hasPending,
			is_blocking = status.isBlocking,
			migrate_link = BackendUtilities.fetch_link(body, "migrate"),
			latest_completed = status.latestCompleted
		}
	end)
end

function Account:check_and_run_migrations(account_id)
	return self:_get_migration_status(account_id):next(function (result)
		if result.has_pending then
			local migrate_promise = Managers.backend:title_request(result.migrate_link, {
				method = "POST"
			})

			if result.is_blocking then
				return migrate_promise:next(function (data)
					return {
						migrations = data.body.migrations,
						latest_completed = result.latest_completed
					}
				end)
			end
		end

		return Promise.resolved({
			latest_completed = result.latest_completed
		})
	end)
end

implements(Account, Interface)

return Account
