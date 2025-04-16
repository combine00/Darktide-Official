local HostLoadersState = class("HostLoadersState")

function HostLoadersState:init(state_machine, shared_state)
	self._shared_state = shared_state
	local loaders = shared_state.loaders
	self._loaders = loaders

	for _, loader in ipairs(loaders) do
		loader:start_loading(shared_state)
	end
end

function HostLoadersState:update(dt)
	local loaders = self._loaders

	for i = 1, #loaders do
		if not loaders[i]:is_loading_done() then
			return
		end
	end

	return "load_done"
end

return HostLoadersState
