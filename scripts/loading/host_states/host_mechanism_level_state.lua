local HostMechanismLevelState = class("HostMechanismLevelState")

function HostMechanismLevelState:init(state_machine, shared_state)
	self._shared_state = shared_state
end

function HostMechanismLevelState:destroy()
	return
end

function HostMechanismLevelState:update(dt)
	return "spawning_done"
end

return HostMechanismLevelState
