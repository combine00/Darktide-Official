local GameplayInitStepInterface = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_state_interface")
local GameplayInitStepOutOfBounds = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_out_of_bounds")
local GameplayInitStepFrameRate = class("GameplayInitStepFrameRate")

function GameplayInitStepFrameRate:on_enter(parent, params)
	self._shared_state = params.shared_state

	Managers.frame_rate:request_full_frame_rate("gameplay")
end

function GameplayInitStepFrameRate:update(main_dt, main_t)
	self._shared_state.initialized_steps.GameplayInitStepFrameRate = true
	local next_step_params = {
		shared_state = self._shared_state
	}

	return GameplayInitStepOutOfBounds, next_step_params
end

implements(GameplayInitStepFrameRate, GameplayInitStepInterface)

return GameplayInitStepFrameRate
