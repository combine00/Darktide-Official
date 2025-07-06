require("scripts/extension_systems/token/token_extension")

local TokenSystem = class("TokenSystem", "ExtensionSystemBase")
local CLIENT_RPCS = {
	"rpc_assign_token",
	"rpc_free_token"
}

function TokenSystem:init(context, ...)
	TokenSystem.super.init(self, context, ...)

	if not self._is_server then
		self._network_event_delegate:register_session_events(self, unpack(CLIENT_RPCS))
	end
end

function TokenSystem:destroy()
	if not self._is_server then
		self._network_event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end

	TokenSystem.super.destroy(self)
end

function TokenSystem:rpc_assign_token(channel_id, unit_id, owner_unit_id, token_name)
	local unit = Managers.state.unit_spawner:unit(unit_id)
	local extension = self._unit_to_extension_map[unit]

	extension:rpc_assign_token(owner_unit_id, token_name)
end

function TokenSystem:rpc_free_token(channel_id, unit_id, token_name)
	local unit = Managers.state.unit_spawner:unit(unit_id)
	local extension = self._unit_to_extension_map[unit]

	extension:rpc_free_token(token_name)
end

return TokenSystem
