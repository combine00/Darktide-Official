local GameplayInitStepInterface = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_state_interface")
local GameplayInitStepVoiceOver = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_voice_over")
local GameplayInitStepWwiseGameSync = class("GameplayInitStepWwiseGameSync")

function GameplayInitStepWwiseGameSync:on_enter(parent, params)
	local shared_state = params.shared_state
	local level = shared_state.level
	local is_dedicated_server = shared_state.is_dedicated_server
	self._shared_state = shared_state

	self:_music_post_init(level, is_dedicated_server)
end

function GameplayInitStepWwiseGameSync:update(main_dt, main_t)
	self._shared_state.initialized_steps.GameplayInitStepWwiseGameSync = true
	local next_step_params = {
		shared_state = self._shared_state
	}

	return GameplayInitStepVoiceOver, next_step_params
end

function GameplayInitStepWwiseGameSync:_music_post_init(level, is_dedicated_server)
	if not is_dedicated_server then
		Managers.wwise_game_sync:on_gameplay_post_init(level)
	end
end

implements(GameplayInitStepWwiseGameSync, GameplayInitStepInterface)

return GameplayInitStepWwiseGameSync
