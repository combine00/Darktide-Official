local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Contracts = class("Contracts")

function Contracts:get_current_contract(character_id, account_id, create_if_missing)
	create_if_missing = create_if_missing ~= false

	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/contracts/current"):query("createIfMissing", create_if_missing), {}, account_id):next(function (data)
		return data.body.contract
	end)
end

function Contracts:get_current_task(character_id, task_id, optional_account_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/contracts/current/tasks/" .. task_id), {}, optional_account_id):next(function (data)
		return data.body.task
	end)
end

function Contracts:complete_contract(character_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/contracts/current/complete"), {
		method = "POST"
	}):next(function (data)
		return data.body.contract
	end)
end

function Contracts:reroll_task(character_id, task_id, last_transaction_id)
	return BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/contracts/current/tasks/"):path(task_id):query("lastTransactionId", last_transaction_id), {
		method = "DELETE"
	}):next(function (data)
		return data.body.refreshedContract
	end)
end

return Contracts
