local LocalInSessionState = class("LocalInSessionState")

function LocalInSessionState:init(state_machine, shared_state)
	self._shared_state = shared_state
	self._clock_handler_client = shared_state.clock_handler_client
	self._clock_handler_client_panic_timer = 0
end

function LocalInSessionState:enter()
	local shared_state = self._shared_state
	self._clock_handler_client_panic_timer = 0
	shared_state.event_list[#shared_state.event_list + 1] = {
		name = "session_joined",
		parameters = {
			peer_id = shared_state.peer_id,
			channel_id = shared_state.channel_id
		}
	}
end

local CLOCK_HANDLER_PANIC_TIMER = 20

function LocalInSessionState:update(dt)
	local shared_state = self._shared_state

	if not GameSession.in_session(shared_state.engine_gamesession) or Network.channel_state(shared_state.channel_id) ~= "connected" then
		Log.info("LocalInSessionState", "Lost game session")

		return "lost_session", {
			game_reason = "lost_session"
		}
	end

	local clock_handler_client = self._clock_handler_client

	if clock_handler_client:in_panic() then
		local time_in_panic = self._clock_handler_client_panic_timer + dt
		self._clock_handler_client_panic_timer = time_in_panic

		if CLOCK_HANDLER_PANIC_TIMER <= time_in_panic then
			local diagnostics_dump = clock_handler_client:diagnostics_dump()
			local error_text = string.format("AdaptiveClockHandler has been in panic for more than 10 seconds.\n%s", diagnostics_dump)

			Crashify.print_exception("ApativeClockHandler", error_text)

			return "lost_session", {
				game_reason = "lost_session"
			}
		end
	elseif self._clock_handler_client_panic_timer > 0 then
		self._clock_handler_client_panic_timer = 0
	end
end

return LocalInSessionState
