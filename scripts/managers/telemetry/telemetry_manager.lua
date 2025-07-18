local BackendError = require("scripts/foundation/managers/backend/backend_error")
local TelemetryManagerTestify = GameParameters.testify and require("scripts/managers/telemetry/telemetry_manager_testify")
local TelemetrySettings = require("scripts/managers/telemetry/telemetry_settings")
local POST_INTERVAL = TelemetrySettings.batch.post_interval
local FULL_POST_INTERVAL = TelemetrySettings.batch.full_post_interval
local MAX_BATCH_SIZE = TelemetrySettings.batch.max_size
local BATCH_SIZE = TelemetrySettings.batch.size
local ENABLED = TelemetrySettings.enabled
local TelemetryManager = class("TelemetryManager")
local RPCS_HOST = {
	"rpc_failed_sending_telemetry"
}

function TelemetryManager:init()
	self._events = {}
	self._events_in_flight = {}
	self._batch_post_time = 0
	self._t = 0
	self._enable_update = true
	local event_manager = Managers.event

	if event_manager then
		event_manager:register(self, "event_player_authenticated", "_event_player_authenticated")
		event_manager:register(self, "event_telemetry_change", "_event_telemetry_change")
	end

	self._network_event_delegate = Managers.connection:network_event_delegate()

	self._network_event_delegate:register_connection_events(self, unpack(RPCS_HOST))
end

local log_cache = {}

function TelemetryManager:rpc_failed_sending_telemetry(channel_id, message)
	local peer_id = Managers.state.game_session:channel_to_peer(channel_id)
	local account_id = nil

	if peer_id then
		local players = Managers.player:players_at_peer(peer_id)

		if players then
			local player = players[1]

			if player then
				account_id = player:account_id()
			end
		end
	end

	log_cache.peer_id = peer_id or "unknown_peer"
	log_cache.account_id = account_id or "unknown_player"
	log_cache.message = message or "no_message"

	Log.warning("TelemetryManager", "Player failed sending telemetry: %s", cjson.encode(log_cache))
end

function TelemetryManager:update(dt, t)
	if IS_PLAYSTATION and not self._enable_update then
		return
	end

	self._t = t

	if self:_ready_to_post_batch(t) then
		self:post_batch()
	end

	if GameParameters.testify then
		Testify:poll_requests_through_handler(TelemetryManagerTestify, self)
	end
end

function TelemetryManager:register_event(event)
	if not ENABLED then
		return
	end

	local raw_event = event:raw()
	raw_event.time = self._t
	raw_event.data = self:_convert_userdata(raw_event.data)

	if #self._events < MAX_BATCH_SIZE then
		Log.debug("TelemetryManager", "Registered event '%s'", event)
		table.insert(self._events, table.remove_empty_values(raw_event))
	else
		Log.warning("TelemetryManager", "Discarding event '%s', buffer is full!", event)
	end
end

function TelemetryManager:_convert_userdata(data)
	if type(data) == "table" then
		for key, value in pairs(data) do
			if Script.type_name(value) == "Vector3" then
				data[key] = {
					x = value.x,
					y = value.y,
					z = value.z
				}
			elseif type(value) == "function" then
				data[key] = nil
			elseif type(value) == "userdata" then
				data[key] = tostring(value)
			elseif type(value) == "table" then
				data[key] = self:_convert_userdata(value)
			end
		end
	end

	return data
end

function TelemetryManager:_ready_to_post_batch(t)
	if self._batch_in_flight then
		return false
	end

	if POST_INTERVAL < t - self._batch_post_time then
		return true
	elseif FULL_POST_INTERVAL < t - self._batch_post_time and BATCH_SIZE <= #self._events then
		return true
	end
end

function TelemetryManager:post_batch(shutdown)
	if not ENABLED or table.is_empty(self._events) then
		return
	end

	if not shutdown then
		local batch_size, time_since_last_post, events = self:batch_info()

		Managers.telemetry_events:post_batch(batch_size, time_since_last_post, events, false)
	end

	Log.info("TelemetryManager", "Posting batch of %d events", #self._events)

	if GameParameters.testify then
		Log.debug("TelemetryManager", cjson.encode(self._events))
	end

	self._batch_in_flight = true
	self._batch_post_time = math.floor(self._t)
	local headers = {
		["x-reference-time"] = tostring(self._t)
	}
	local compress = true
	self._events_in_flight = self._events
	self._events = self._events_in_flight

	Managers.backend:send_telemetry_events(self._events_in_flight, headers, compress, shutdown):next(function ()
		table.clear(self._events_in_flight)
		Log.debug("TelemetryManager", "Batch successfully posted")

		self._batch_in_flight = nil
	end):catch(function (error)
		if error.code ~= BackendError.NotInitialized then
			Log.exception("TelemetryManager", "Error posting batch: %s", error)

			local is_host = Managers.connection and Managers.connection:is_host()
			local connected_to_host = not is_host and Managers.state.game_session and Managers.state.game_session:connected_to_host()

			if connected_to_host then
				local error_text = error and tostring(error) or "no_error"
				local step_size = 500

				for i = 1, string.len(error_text), step_size do
					local message = string.sub(error_text, i, i + step_size - 1)

					Managers.state.game_session:send_rpc_server("rpc_failed_sending_telemetry", message)
				end
			end
		else
			Log.info("TelemetryManager", "Error posting batch as we're not logged in")
		end

		self:_remove_events_of_type(self._events_in_flight, "post_batch")
		table.merge_array(self._events, self._events_in_flight)
		table.clear(self._events_in_flight)

		self._batch_in_flight = nil
	end)
end

function TelemetryManager:batch_in_flight()
	return self._batch_in_flight or false
end

function TelemetryManager:destroy()
	self._network_event_delegate:unregister_events(unpack(RPCS_HOST))

	local event_manager = Managers.event

	if event_manager then
		event_manager:unregister(self, "event_player_authenticated", "_event_player_authenticated")
		event_manager:unregister(self, "event_telemetry_change", "_event_telemetry_change")
	end

	local shutdown = true

	self:post_batch(shutdown)
end

function TelemetryManager:_remove_events_of_type(events, event_type)
	for ii = #events, 1, -1 do
		if events[ii].type == event_type then
			table.remove(events, ii)
		end
	end
end

function TelemetryManager:_event_telemetry_change(value)
	self._enable_update = value
end

function TelemetryManager:batch_info()
	local batch_size = #self._events
	local time_since_last_post = self._t - self._batch_post_time
	local event_types = {}

	for _, event in pairs(self._events) do
		local event_type = event.type
		local current = event_types[event_type]

		if current then
			event_types[event_type] = current + 1
		else
			event_types[event_type] = 1
		end
	end

	return batch_size, time_since_last_post, event_types
end

function TelemetryManager:_event_player_authenticated()
	local save_manager = Managers.save

	if save_manager then
		local account_data = save_manager:account_data()
		self._enable_update = account_data.interface_settings.telemetry_enabled
	end
end

return TelemetryManager
