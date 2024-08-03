local TestifyExpect = class("TestifyExpect")

function TestifyExpect:init()
	self._expects = {}
end

function TestifyExpect:update()
	local expects = self._expects

	for index, expect in pairs(expects) do
		self:_handle_expect(expect)

		expects[index] = nil
	end
end

function TestifyExpect:fail(expect, message)
	self:_expect(expect, false, message)
end

function TestifyExpect:is_true(expect, condition, message)
	condition = condition == true

	self:_expect(expect, condition, message)
end

function TestifyExpect:is_false(expect, condition, message)
	condition = condition == false

	self:_expect(expect, condition, message)
end

function TestifyExpect:is_not_nil(expect, var, message)
	local condition = var ~= nil

	self:_expect(expect, condition, message)
end

function TestifyExpect:is_nil(expect, var, message)
	local condition = var == nil

	self:_expect(expect, condition, message)
end

function TestifyExpect:are_equal(expect, var1, var2, message)
	local condition = self:_are_equal(var1, var2)

	self:_expect(expect, condition, message)
end

function TestifyExpect:are_not_equal(expect, var1, var2, message)
	local condition = not self:_are_equal(var1, var2)

	self:_expect(expect, condition, message)
end

function TestifyExpect:_expect(expect, condition, message)
	local expect_data = {
		expect = expect,
		condition = condition,
		message = message
	}
	local expects = self._expects
	expects[#expects + 1] = expect_data
end

function TestifyExpect:_handle_expect(expect_data)
	if not string.is_snake_case(expect_data.expect) then
		ferror("expect parameter must be in snake case format (eg: this_is_snake_case): " .. expect_data.expect)
	end

	local context = {
		expect_data = expect_data
	}
	local func = loadstring(string.format("%s(expect_data.condition, expect_data.message)", expect_data.expect))

	setfenv(func, context)
	func(expect_data)
end

function TestifyExpect:_are_equal(o1, o2)
	if o1 == o2 then
		return true
	end

	local o1_type = type(o1)
	local o2_type = type(o2)

	if o1_type ~= o2_type then
		return false
	end

	if o1_type ~= "table" then
		return false
	end

	local key_set = {}

	for key1, value1 in pairs(o1) do
		local value2 = o2[key1]

		if value2 == nil or self:_are_equal(value1, value2) == false then
			return false
		end

		key_set[key1] = true
	end

	for key2, _ in pairs(o2) do
		if not key_set[key2] then
			return false
		end
	end

	return true
end

return TestifyExpect
