local TokenExtension = class("TokenExtension")

function TokenExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._breed = extension_init_data.breed
	self._unit = unit
	self._owned_tokens = table.clone(self._breed.tokens)
	self._is_server = extension_init_context.is_server
	self._network_event_delegate = extension_init_context.network_event_delegate
end

function TokenExtension:update(unit, dt, t)
	return
end

function TokenExtension:destroy()
	return
end

function TokenExtension:assign_token(unit, token_name)
	if not self._is_server then
		return
	end

	local current_owner = self._owned_tokens[token_name]

	if not current_owner or not HEALTH_ALIVE[current_owner] then
		self._owned_tokens[token_name] = unit
		local owner_unit_id = Managers.state.unit_spawner:game_object_id(unit)
		local unit_id = Managers.state.unit_spawner:game_object_id(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_assign_token", unit_id, owner_unit_id, token_name)
	end
end

function TokenExtension:free_token(token_name)
	if not self._is_server then
		return
	end

	self._owned_tokens[token_name] = nil
	local unit_id = Managers.state.unit_spawner:game_object_id(self._unit)

	Managers.state.game_session:send_rpc_clients("rpc_free_token", unit_id, token_name)
end

function TokenExtension:is_token_free_or_mine(unit, token_name)
	if not self._is_server then
		return
	end

	local token_owner = self._owned_tokens[token_name]

	return token_owner == nil or token_owner == unit
end

function TokenExtension:rpc_assign_token(unit_id, token_name)
	if self._is_server then
		return
	end

	local unit = Managers.state.unit_spawner:unit(unit_id)
	self._owned_tokens[token_name] = unit
end

function TokenExtension:rpc_free_token(token_name)
	if self._is_server then
		return
	end

	self._owned_tokens[token_name] = nil
end

return TokenExtension
