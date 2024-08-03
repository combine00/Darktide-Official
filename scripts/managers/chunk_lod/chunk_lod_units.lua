local ChunkLodUnits = class("ChunkLodUnits")

function ChunkLodUnits:init(level)
	self._units = {}
	self._level = level
	self._visible = true
end

function ChunkLodUnits:register_unit(unit, callback_function)
	self._units[unit] = callback_function

	if not self._visible then
		callback_function(false)
	end
end

function ChunkLodUnits:unregister_unit(unit)
	self._units[unit] = nil
end

function ChunkLodUnits:set_visibility_state(is_visible)
	if self._visible ~= is_visible then
		for _, callback_function in pairs(self._units) do
			callback_function(is_visible)
		end

		self._visible = is_visible
	end
end

return ChunkLodUnits
