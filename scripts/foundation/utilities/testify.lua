local TestifyExpect = require("scripts/tests/testify_expect")
local SIGNALS = {
	current_request = "current_request",
	request = "request",
	reply = "reply",
	ready = "ready",
	end_suite = "end_suite"
}
local SERVER_RPCS = {
	"rpc_testify_wait_for_response"
}
local CLIENT_RPCS = {
	"rpc_testify_make_request"
}
Testify = {
	_are_rpcs_registered = false,
	_requests = {},
	_responses = {},
	_peers = {},
	_cache = {},
	RETRY = newproxy(false),
	expect = TestifyExpect:new()
}
local __raw_print = print
local cjson_decode = cjson.decode
local cjson_encode = cjson.encode
local coroutine_resume = coroutine.resume
local coroutine_yield = coroutine.yield
local string_format = string.format
local table_dump = table.dump
local table_keys = table.keys
local table_merge_varargs = table.merge_varargs
local table_pack = table.pack
local table_size = table.size
local tostring = tostring
local unpack = unpack

function Testify:init()
	self._requests = {}
	self._responses = {}
end

function Testify:ready()
	Log.info("Testify", "Ready!")
	self:_signal(SIGNALS.ready)
end

function Testify:ready_signal_received()
	self._ready_signal_received = true
end

function Testify:reply(message)
	self:_signal(SIGNALS.reply, message)
end

function Testify:run_case(test_case)
	self:init()

	self._test_case = coroutine.create(test_case)
end

function Testify:update(dt, t)
	if GameParameters.testify and not self._ready_signal_received then
		self:_signal(SIGNALS.ready, nil, false)
	end

	if GameParameters.testify_time_scale and not self._time_scaled then
		self:_set_time_scale()
	end

	if self._test_case then
		self.expect:update()

		local success, result, end_suite = coroutine_resume(self._test_case, dt, t)

		if not success then
			ferror(debug.traceback(self._test_case, result))
		elseif coroutine.status(self._test_case) == "dead" then
			self._test_case = nil

			if end_suite == true then
				self:_signal(SIGNALS.end_suite)
			end

			self:_signal(SIGNALS.reply, result)
		end
	end
end

function Testify:make_request(request_name, ...)
	local request_parameters, num_parameters = table_pack(...)
	request_parameters.length = num_parameters

	self:_print("Requesting %s", request_name)

	self._requests[request_name] = request_parameters
	self._responses[request_name] = nil

	return self:_wait_for_response(request_name)
end

function Testify:make_request_to_runner(request_name, ...)
	local request_parameters = table_pack(...)

	self:_print("Requesting %s to the Testify Runner", request_name)

	self._requests[request_name] = request_parameters
	self._responses[request_name] = nil
	local request = {
		name = request_name,
		parameters = request_parameters
	}

	self:_signal(SIGNALS.request, cjson_encode(request))

	return self:_wait_for_response(request_name)
end

function Testify:_wait_for_response(request_name)
	self:_print("Waiting for response %s", request_name)

	while true do
		coroutine_yield()

		local response = self._responses[request_name]

		if response then
			local response_length = response.length

			return unpack(response, 1, response_length)
		end
	end
end

function Testify:poll_requests_through_handler(callback_table, ...)
	local RETRY = Testify.RETRY

	for request, callback in pairs(callback_table) do
		local request_args, num_request_args = self:poll_request(request)

		if request_args then
			local poll_args, num_poll_args = table_pack(...)
			local merged_args, num_merged_args = table_merge_varargs(poll_args, num_poll_args, unpack(request_args))
			local responses, num_responses = table_pack(callback(unpack(merged_args, 1, num_merged_args)))

			if responses[1] ~= RETRY then
				self:respond_to_request(request, responses, num_responses)
			end

			return
		end
	end
end

function Testify:poll_request(request_name)
	local request_arguments = self._requests[request_name]

	if request_arguments then
		local num_request_arguments = request_arguments.length

		return request_arguments, num_request_arguments
	end
end

function Testify:respond_to_request(request_name, responses, num_responses)
	responses.length = num_responses

	self:_print("Responding to %s", request_name)

	self._requests[request_name] = nil
	self._responses[request_name] = responses
end

function Testify:respond_to_runner_request(request_name, responses, num_responses)
	self:respond_to_request(request_name, {
		responses
	}, num_responses)
end

function Testify:store_cache(key, value)
	self._cache[key] = value
end

function Testify:retrieve_cache(key, value)
	return self._cache[key]
end

function Testify:print_test_case_marker()
	__raw_print("<<testify>>test case<</testify>>")
end

function Testify:inspect()
	self:_print("Test case running? %s", self._thread ~= nil)
	table_dump(self._requests, "[Testify] Requests", 2)
	table_dump(self._responses, "[Testify] Responses", 2)
end

function Testify:_set_time_scale()
	local time_manager = Managers.time

	if not time_manager or not time_manager._timers.gameplay then
		return
	end

	local scale = GameParameters.testify_time_scale

	time_manager:set_local_scale("gameplay", tonumber(scale))
end

function Testify:_signal(signal, message, print_signal)
	if print_signal ~= false then
		self:_print("Replying to signal %s %s", signal, message)
	end

	if Application.console_send == nil then
		return
	end

	Application.console_send({
		system = "Testify",
		type = "signal",
		signal = signal,
		message = tostring(message)
	})
end

function Testify:_print(...)
	if GameParameters.debug_testify then
		Log.info("Testify", "%s", string_format(...))
	end
end

function Testify:print(...)
	self:_print(...)
end

function Testify:current_request_name()
	local requests = self._requests
	local request_name, _ = next(requests)

	self:_print("Current request name: %s", request_name)
	self:_signal(SIGNALS.current_request, request_name)
end

function Testify:make_request_on_client(peer_id, request_name, wait_for_response, ...)
	wait_for_response = wait_for_response == true or false
	local request_parameters, num_parameters = table_pack(...)

	self:_print("Requesting %s on peer %s", request_name, peer_id)

	self._responses[request_name] = nil
	request_parameters = cjson_encode(request_parameters)
	local channel_id = self._peers[peer_id]

	RPC.rpc_testify_make_request(channel_id, peer_id, request_name, wait_for_response, request_parameters, num_parameters)

	if wait_for_response then
		return self:_wait_for_response(request_name)
	end
end

function Testify:rpc_testify_make_request(channel_id, peer_id, request_name, wait_for_response, request_parameters, num_parameters)
	self:_print("Request received from server %s", request_name)

	local parameters = cjson_decode(request_parameters)

	self:run_case(function (dt, t)
		self:make_request(request_name, unpack(parameters, 1, num_parameters))

		local responses, num_responses = table_pack(self:_wait_for_response(request_name))

		if wait_for_response then
			self:_print("Responding to the server for request %s on channel %s", request_name, channel_id)

			responses = cjson_encode(responses)

			RPC.rpc_testify_wait_for_response(channel_id, request_name, responses, num_responses)
		end
	end)
end

function Testify:rpc_testify_wait_for_response(channel_id, request_name, responses, num_responses)
	responses = cjson_decode(responses)

	self:_print("Request %s response received from the peer on channel %s", request_name, channel_id)
	self:respond_to_request(request_name, responses, num_responses)
end

function Testify:server_rpcs()
	return SERVER_RPCS
end

function Testify:client_rpcs()
	return CLIENT_RPCS
end

function Testify:add_peer(peer_id, channel_id)
	self:_print("Adding peer %s on channel %s", peer_id, channel_id)

	self._peers[peer_id] = channel_id
end

function Testify:remove_peer(peer_id, channel_id)
	self:_print("Removing peer %s on channel %s", peer_id, channel_id)

	self._peers[peer_id] = nil
end

function Testify:peers()
	local peers = self._peers

	return table_keys(peers)
end

function Testify:num_peers()
	local peers = self._peers
	local num_peers = table_size(peers)

	return num_peers
end

function Testify:are_rpcs_registered()
	return self._are_rpcs_registered
end

function Testify:set_rpcs_registered_value(is_registered)
	self._are_rpcs_registered = is_registered
end
