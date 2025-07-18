local GameplayInitStepInterface = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_state_interface")
local GameplayInitStepBreedTester = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_breed_tester")
local GameplayInitStepFinalizeDebug = class("GameplayInitStepFinalizeDebug")

function GameplayInitStepFinalizeDebug:on_enter(parent, params)
	local shared_state = params.shared_state
	local level = shared_state.level
	self._shared_state = shared_state
end

function GameplayInitStepFinalizeDebug:update(main_dt, main_t)
	self._shared_state.initialized_steps.GameplayInitStepFinalizeDebug = true
	local next_step_params = {
		shared_state = self._shared_state
	}

	return GameplayInitStepBreedTester, next_step_params
end

implements(GameplayInitStepFinalizeDebug, GameplayInitStepInterface)

return GameplayInitStepFinalizeDebug
