local Promise = require("scripts/foundation/utilities/promise")
local ContractsService = class("ContractsService")

function ContractsService:init(backend_interface)
	self._backend_interface = backend_interface
end

function ContractsService:reroll_task(character_id, task_id, last_transaction_id, reroll_cost)
	return self._backend_interface.contracts:reroll_task(character_id, task_id, last_transaction_id):next(function (result)
		return Managers.data_service.store:on_contract_task_rerolled(reroll_cost):next(function ()
			return result
		end)
	end):catch(function (err)
		Managers.data_service.store:invalidate_wallets_cache()

		return Promise.rejected(err)
	end)
end

function ContractsService:complete_contract(character_id)
	return self._backend_interface.contracts:complete_contract(character_id):next(function (result)
		return Managers.data_service.store:on_contract_completed(result):next(function ()
			return result
		end)
	end):catch(function (err)
		Managers.data_service.store:invalidate_wallets_cache()

		return Promise.rejected(err)
	end)
end

function ContractsService:has_contract(character_id)
	return self._backend_interface.contracts:get_current_contract(character_id, nil, false):next(function ()
		return true
	end, function (error)
		if error.code ~= 404 then
			Log.warning("ContractsService", "Failed to fetch contracts with error: %s", table.tostring(error, 5))
		end

		return false
	end)
end

function ContractsService:get_contract(character_id, create_contract)
	return self._backend_interface.contracts:get_current_contract(character_id, nil, create_contract)
end

return ContractsService
