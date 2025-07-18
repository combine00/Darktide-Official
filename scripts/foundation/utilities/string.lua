function string.starts_with(str, start)
	return str:sub(1, #start) == start
end

function string.ends_with(str, ending)
	return ending == "" or str:sub(-(#ending)) == ending
end

function string.split(str, sep)
	local array = {}
	local reg = string.format("([^%s]+)", sep)

	for mem in string.gmatch(str, reg) do
		table.insert(array, mem)
	end

	return array
end

function string.double_dash_split(str)
	local array = {}
	local dash_byte = string.byte("-")
	local from = 1

	for idx = 2, #str do
		if str:byte(idx) == dash_byte and str:byte(idx - 1) == dash_byte then
			local to = idx - 2

			if from < to then
				table.insert(array, str:sub(from, to))
			else
				table.insert(array, "")
			end

			from = idx + 1
		end
	end

	return array
end

function string.trim(str)
	local rltrim = string.match(string.match(str, "%S.*"), ".*%S")

	return rltrim
end

function string.split_and_trim(str, sep)
	local array = {}
	local reg = string.format("([^%s]+)", sep)

	for mem in string.gmatch(str, reg) do
		mem = string.trim(mem)

		table.insert(array, mem)
	end

	return array
end

function string.split_by_chunk(str, chunk_size)
	local array = {}

	for i = 1, #str, chunk_size do
		array[#array + 1] = string.sub(str, i, i + chunk_size - 1)
	end

	return array
end

function string.value_or_nil(value)
	if value == "" or value == false then
		return nil
	else
		return value
	end
end

function string.encode_base64(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

	return (data:gsub(".", function (x)
		local r = ""
		local b = x:byte()

		for i = 8, 1, -1 do
			r = r .. (b % 2^i - b % 2^(i - 1) > 0 and "1" or "0")
		end

		return r
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function (x)
		if #x < 6 then
			return ""
		end

		local c = 0

		for i = 1, 6 do
			c = c + (x:sub(i, i) == "1" and 2^(6 - i) or 0)
		end

		return b:sub(c + 1, c + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#data % 3 + 1]
end

function string.decode_base64(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	data = string.gsub(data, "[^" .. b .. "=]", "")

	return data:gsub(".", function (x)
		if x == "=" then
			return ""
		end

		local r = ""
		local f = b:find(x) - 1

		for i = 6, 1, -1 do
			r = r .. (f % 2^i - f % 2^(i - 1) > 0 and "1" or "0")
		end

		return r
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function (x)
		if #x ~= 8 then
			return ""
		end

		local c = 0

		for i = 1, 8 do
			c = c + (x:sub(i, i) == "1" and 2^(8 - i) or 0)
		end

		return string.char(c)
	end)
end

function string.is_snake_case(str)
	if string.ends_with(str, "_") then
		return false
	end

	local arr = string.split(str, "_")

	for _, substr in pairs(arr) do
		if string.match(substr, "%w+") ~= substr or substr:lower() ~= substr then
			return false
		end
	end

	return true
end
