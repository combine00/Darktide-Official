local RPCS = {
	"rpc_sync_tick_rate"
}
local LocalTickRateSyncState = class("LocalTickRateSyncState")

function LocalTickRateSyncState:init(state_machine, shared_state)
	self._shared_state = shared_state
	self._time = 0
	self._received_tick_rate = false

	shared_state.event_delegate:register_connection_channel_events(self, shared_state.channel_id, unpack(RPCS))
	RPC.rpc_ready_to_receive_tick_rate(shared_state.channel_id)
end

function LocalTickRateSyncState:destroy()
	local shared_state = self._shared_state

	shared_state.event_delegate:unregister_channel_events(shared_state.channel_id, unpack(RPCS))
end

function LocalTickRateSyncState:update(dt)
	local shared_state = self._shared_state

	if self._received_tick_rate then
		return "tick_rate synced"
	end

	self._time = self._time + dt

	if shared_state.timeout < self._time then
		Log.info("LocalTickRateSyncState", "Timeout waiting for rpc_sync_tick_rate")

		return "timeout", {
			game_reason = "timeout"
		}
	end
end

function LocalTickRateSyncState:rpc_sync_tick_rate(channel_id, tick_rate)
	self._shared_state.tick_rate = tick_rate
	self._received_tick_rate = true
end

return LocalTickRateSyncState
