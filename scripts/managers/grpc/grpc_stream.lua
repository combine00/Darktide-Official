local Promise = require("scripts/foundation/utilities/promise")
local GRPCStream = class("GRPCStream")

local function _info(...)
	Log.info("GRPCStream", ...)
end

local function _error(...)
	Log.error("GRPCStream", ...)
end

local empty_list = {}

function GRPCStream:init(grpc_manager, operation_id, stream_getter, stream_sender)
	self._grpc_manager = grpc_manager
	self._operation_id = operation_id
	self._stream_getter = stream_getter
	self._stream_sender = stream_sender
	self._alive = true
	self._error = nil
end

function GRPCStream:destroy()
	self._grpc_manager = nil

	self:abort()
end

function GRPCStream:get_stream_messages()
	if self:alive() then
		return self._stream_getter(self._operation_id)
	else
		return empty_list
	end
end

function GRPCStream:send_stream_message(message)
	if self._stream_sender then
		return self._stream_sender(self._operation_id, message)
	else
		return false
	end
end

function GRPCStream:alive()
	return self._alive
end

function GRPCStream:_end(error)
	self._alive = false
	self._error = error
end

function GRPCStream:completed()
	return not self:alive() and not self._error
end

function GRPCStream:error()
	return self._error
end

function GRPCStream:abort()
	self._grpc_manager:abort_operation(self._operation_id)
end

return GRPCStream
