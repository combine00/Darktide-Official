local GRPCBatchedPresenceStream = class("GRPCBatchedPresenceStream")

local function _info(...)
	Log.info("GRPCBatchedPresenceStream", ...)
end

local function _error(...)
	Log.error("GRPCBatchedPresenceStream", ...)
end

function GRPCBatchedPresenceStream:init(grpc_manager, operation_id, request_presence, abort_presence, get_presence)
	self._grpc_manager = grpc_manager
	self._operation_id = operation_id
	self._request_presence = request_presence
	self._abort_presence = abort_presence
	self._get_presence = get_presence
	self._alive = true
	self._error = nil
end

function GRPCBatchedPresenceStream:destroy()
	self._grpc_manager = nil

	self:abort()
end

function GRPCBatchedPresenceStream:get_presence(request_id)
	if self:alive() then
		return self._get_presence(self._operation_id, request_id)
	else
		return nil
	end
end

function GRPCBatchedPresenceStream:request_presence(platform, platform_user_id)
	if self:alive() then
		return self._request_presence(self._operation_id, platform, platform_user_id)
	else
		return nil
	end
end

function GRPCBatchedPresenceStream:abort_presence(request_id)
	if self:alive() then
		self._abort_presence(self._operation_id, request_id)
	end
end

function GRPCBatchedPresenceStream:alive()
	return self._alive
end

function GRPCBatchedPresenceStream:_end(error)
	self._alive = false
	self._error = error
end

function GRPCBatchedPresenceStream:completed()
	return not self:alive() and not self._error
end

function GRPCBatchedPresenceStream:error()
	return self._error
end

function GRPCBatchedPresenceStream:abort()
	self._grpc_manager:abort_operation(self._operation_id)
end

return GRPCBatchedPresenceStream
