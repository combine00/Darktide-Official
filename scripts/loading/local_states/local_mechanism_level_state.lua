local LocalMechanismLevelState = class("LocalMechanismLevelState")

function LocalMechanismLevelState:init(state_machine, shared_state)
	self._shared_state = shared_state
end

function LocalMechanismLevelState:destroy()
	return
end

function LocalMechanismLevelState:update(dt)
	return "spawning_done"
end

return LocalMechanismLevelState
