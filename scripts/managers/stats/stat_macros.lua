local StatMacros = {}

function StatMacros:forward(stat_data, ...)
	return self.id, ...
end

function StatMacros:increment(stat_data)
	local id = self.id
	stat_data[id] = (stat_data[id] or self.default) + 1

	return id, stat_data[id]
end

function StatMacros:decrement(stat_data)
	local id = self.id
	stat_data[id] = (stat_data[id] or self.default) - 1

	return id, stat_data[id]
end

function StatMacros:set_to_max(stat_data, value)
	local id = self.id
	local current_value = stat_data[id] or self.default

	if current_value < value then
		stat_data[id] = value

		return id, value
	end
end

function StatMacros:set_to_min(stat_data, value)
	local id = self.id
	local current_value = stat_data[id] or self.default

	if value < current_value then
		stat_data[id] = value

		return id, value
	end
end

return StatMacros
