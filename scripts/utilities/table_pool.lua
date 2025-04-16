local TablePool = class("TablePool")

function TablePool:init(name, preconstruct_table_count, max_table_count, construct_table_func)
	self._name = name
	self._max_table_count = max_table_count
	self._construct_table_func = construct_table_func
	local freelist = Script.new_map(max_table_count)

	for i = 1, preconstruct_table_count do
		local t = construct_table_func()
		freelist[t] = true
	end

	self._freelist = freelist
end

function TablePool:destroy()
	table.clear(self._freelist)
end

function TablePool:get_table()
	local freelist = self._freelist
	local t = next(freelist)

	if t then
		freelist[t] = nil

		return t
	end

	return self._construct_table_func()
end

function TablePool:return_table(t)
	self._freelist[t] = true
end

return TablePool
