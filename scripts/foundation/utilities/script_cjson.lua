ScriptCJson = ScriptCJson or {}

function ScriptCJson.encode_lua_to_json_for_lua(data)
	cjson.encode_sparse_array(true, 1, 0)

	local encoded = cjson.encode(data)

	cjson.encode_sparse_array(false, 2, 10)

	return encoded
end

return ScriptCJson
