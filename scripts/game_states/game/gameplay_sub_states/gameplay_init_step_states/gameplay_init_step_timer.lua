local AdaptiveClockHandlerClient = require("scripts/managers/player/player_game_states/utilities/adaptive_clock_handler_client")
local GameplayInitStepInterface = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_state_interface")
local GameplayInitGameModeDependencies = require("scripts/game_states/game/gameplay_sub_states/gameplay_init_step_states/gameplay_init_step_game_mode_dependencies")
local GameplayInitStepTimer = class("GameplayInitStepTimer")

function GameplayInitStepTimer:on_enter(parent, params)
	local shared_state = params.shared_state
	self._shared_state = shared_state
	local is_server = shared_state.is_server

	self:_register_timer(is_server, shared_state)
end

function GameplayInitStepTimer:update(main_dt, main_t)
	self._shared_state.initialized_steps.GameplayInitStepTimer = true
	local next_step_params = {
		shared_state = self._shared_state
	}

	return GameplayInitGameModeDependencies, next_step_params
end

function GameplayInitStepTimer:_register_timer(is_server, out_shared_state)
	out_shared_state.gameplay_timer_registered = true

	if is_server then
		Managers.time:register_timer("gameplay", "main", 0)
	else
		local connection_manager = Managers.connection
		local network_event_delegate = connection_manager:network_event_delegate()
		local fixed_time_step = out_shared_state.fixed_time_step
		out_shared_state.clock_handler_client = AdaptiveClockHandlerClient:new(network_event_delegate, fixed_time_step)
	end
end

implements(GameplayInitStepTimer, GameplayInitStepInterface)

return GameplayInitStepTimer
