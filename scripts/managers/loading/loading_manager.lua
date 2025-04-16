local Missions = require("scripts/settings/mission/mission_templates")
local LoadingManager = class("LoadingManager")

function LoadingManager:init()
	self._loading_client = nil
	self._loading_host = nil
	self._shelved_clients_loaders = {}

	Managers.event:register(self, "on_suspend", "_on_suspend")
end

function LoadingManager:destroy()
	Managers.event:unregister(self, "on_suspend")
	self:cleanup()
	self:_cleanup_shelved_loaders()
end

function LoadingManager:_cleanup_shelved_loaders()
	local shelved_clients_loaders = self._shelved_clients_loaders

	if shelved_clients_loaders then
		for i = 1, #shelved_clients_loaders do
			local clients_loaders = shelved_clients_loaders[i]

			for _, loader in ipairs(clients_loaders) do
				if not loader:dont_destroy() then
					loader:cleanup()
					loader:delete()
				end
			end

			Log.info("LoadingManager", "Deleting shelved loading client")
		end

		table.clear(shelved_clients_loaders)
	end
end

function LoadingManager:update(dt)
	if self._loading_client then
		self._loading_client:update(dt)
	end

	if self._loading_host then
		self._loading_host:update(dt)
	end
end

function LoadingManager:cleanup()
	if self._loading_client then
		self:_shelve_loaders()
		self._loading_client:delete()

		self._loading_client = nil
	end

	if self._loading_host then
		self._loading_host:delete()

		self._loading_host = nil
	end
end

function LoadingManager:_shelve_loaders()
	local loading_client = self._loading_client
	local loaders = self._shelved_clients_loaders
	loaders[#loaders + 1] = loading_client:take_ownership_of_loaders()
end

function LoadingManager:is_alive()
	return self._loading_client ~= nil or self._loading_host ~= nil
end

function LoadingManager:is_client()
	return self._loading_client ~= nil
end

function LoadingManager:is_host()
	return self._loading_host ~= nil
end

function LoadingManager:set_client(loading_client)
	self:cleanup()

	self._loading_client = loading_client
end

function LoadingManager:set_host(loading_host)
	self:cleanup()

	self._loading_host = loading_host
end

function LoadingManager:failed()
	return self._loading_client:state() == "failed"
end

function LoadingManager:add_client(channel_id)
	self._loading_host:add(channel_id)
end

function LoadingManager:remove_client(channel_id)
	self._loading_host:remove(channel_id)
end

function LoadingManager:failed_clients(failed_clients)
	self._loading_host:failed(failed_clients)
end

function LoadingManager:load_mission(loading_context)
	if self._loading_host then
		self:_cleanup_shelved_loaders()
		self._loading_host:load_mission(loading_context)
	end

	if self._loading_client then
		self:_cleanup_shelved_loaders()
		self._loading_client:load_mission(loading_context)
	end
end

function LoadingManager:stop_load_mission()
	if self._loading_host then
		self._loading_host:stop_load_mission()
	end

	if self._loading_client then
		self._loading_client:stop_load_mission()
	end
end

function LoadingManager:no_level_needed()
	if self._loading_client then
		self._loading_client:no_level_needed()
	end
end

function LoadingManager:load_finished()
	if self._loading_host then
		return self._loading_host:first_group_ready()
	elseif self._loading_client then
		return self._loading_client:load_finished()
	end
end

function LoadingManager:end_load()
	self._loading_host:end_load()
end

function LoadingManager:take_ownership_of_level()
	if self._loading_host then
		return self._loading_host:take_ownership_of_level()
	end

	if self._loading_client then
		return self._loading_client:take_ownership_of_level()
	end
end

function LoadingManager:mission()
	if self._loading_host then
		return self._loading_host:mission()
	end

	if self._loading_client then
		return self._loading_client:mission()
	end
end

function LoadingManager:spawn_group_id()
	if self._loading_client then
		return self._loading_client:spawn_group()
	end

	return nil
end

function LoadingManager:_on_suspend()
	self:cleanup()
end

return LoadingManager
