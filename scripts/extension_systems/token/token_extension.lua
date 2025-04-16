local TokenExtension = class("TokenExtension")

function TokenExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._breed = extension_init_data.breed
	self._owned_tokens = table.clone(self._breed.tokens)
end

function TokenExtension:assign_token(unit, token_name)
	local current_owner = self._owned_tokens[token_name]

	if not current_owner or not HEALTH_ALIVE[current_owner] then
		self._owned_tokens[token_name] = unit
	end
end

function TokenExtension:free_token(token_name)
	self._owned_tokens[token_name] = nil
end

function TokenExtension:is_token_free_or_mine(unit, token_name)
	local token_owner = self._owned_tokens[token_name]

	return token_owner == nil or token_owner == unit
end

return TokenExtension
