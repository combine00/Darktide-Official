local InputUtils = require("scripts/managers/input/input_utils")
local InputAliases = class("InputAliases")

function InputAliases:init(default_aliases)
	self._aliases = table.clone(default_aliases)
	self._default_aliases = default_aliases
end

function InputAliases:restore_default(alias)
	local default_aliases = self._default_aliases

	if not alias then
		self._aliases = table.clone(default_aliases)
	else
		self._aliases[alias] = table.clone(default_aliases[alias])
	end
end

function InputAliases:restore_default_by_devices(specific_alias, device_types)
	local default_aliases = self._default_aliases

	for alias, alias_row in pairs(default_aliases) do
		if not specific_alias or alias == specific_alias then
			for i = 1, #alias_row do
				local key_info = self:_get_keys_for_row(alias_row, device_types)

				if key_info then
					self:set_keys_for_alias(alias, device_types, key_info)
				end
			end
		end
	end
end

function InputAliases:overrides()
	local overrides = {}
	local default_aliases = self._default_aliases
	local aliases = self._aliases

	for alias_name, alias_info in pairs(aliases) do
		local default = default_aliases[alias_name]

		for index, value in ipairs(alias_info) do
			if value ~= default[index] then
				overrides[alias_name] = overrides[alias_name] or {}
				overrides[alias_name][index] = value
			end
		end
	end

	return overrides
end

function InputAliases:save(service_name)
	local save_manager = Managers.save
	local save_data = save_manager:account_data()
	save_data.key_bindings[service_name] = self:overrides()

	save_manager:queue_save()
end

local TO_REMOVE = {}

function InputAliases:load(service_name)
	table.clear(TO_REMOVE)

	local save_manager = Managers.save
	local save_data = save_manager:account_data()
	local service_overrides = save_data.key_bindings[service_name]

	if service_overrides then
		for alias, alias_table in pairs(service_overrides) do
			local current_alias_table = self._aliases[alias]

			if current_alias_table and self:bindable(alias) then
				for index, value in pairs(alias_table) do
					current_alias_table[index] = value
				end
			else
				TO_REMOVE[#TO_REMOVE + 1] = alias
			end
		end
	end

	for i = 1, #TO_REMOVE do
		local alias_to_remove = TO_REMOVE[i]
		service_overrides[alias_to_remove] = nil

		Application.warning(string.format("[InputAliases] Removed missing/old keybinding alias %q", alias_to_remove))
	end
end

function InputAliases:get_keys_for_alias(name, device_types)
	return self:_get_keys_for_row(self._aliases[name], device_types)
end

function InputAliases:get_default_keys_for_alias(name, device_types)
	return self:_get_keys_for_row(self._default_aliases[name], device_types)
end

function InputAliases:get_keys_for_alias_row(alias_row_array, device_types)
	return self:_get_keys_for_row(alias_row_array, device_types)
end

function InputAliases:_get_keys_for_row(alias_row, device_types)
	if not alias_row then
		return
	end

	local key_info = {}

	for _, element in ipairs(alias_row) do
		key_info.main, key_info.enablers, key_info.disablers = InputUtils.split_key(element)

		if table.contains(device_types, InputUtils.key_device_type(key_info.main)) then
			return key_info
		end
	end
end

function InputAliases:_get_key(element, index, device_types)
	if not element then
		return
	end

	local key_info = {}
	local found = 0
	key_info.main, key_info.enablers, key_info.disablers = InputUtils.split_key(element)

	if table.contains(device_types, InputUtils.key_device_type(key_info.main)) then
		found = found + 1

		if found == index then
			return key_info
		end
	end
end

function InputAliases:set_keys_for_alias(name, device_types, new_key_info, device_index)
	local alias_row = self._aliases[name]

	if not alias_row then
		return
	end

	local col = nil
	local key_info = {}

	for i, element in ipairs(alias_row) do
		key_info.main, key_info.enablers, key_info.disablers = InputUtils.split_key(element)

		if table.contains(device_types, InputUtils.key_device_type(key_info.main)) then
			col = i

			break
		end
	end

	local value = new_key_info and InputUtils.make_string(new_key_info)
	local pc_device_types = {
		"mouse",
		"keyboard"
	}

	if col then
		if alias_row[col] then
			table.remove(alias_row, col)
		end

		table.insert(alias_row, col, value)
	elseif device_index then
		local first_index = alias_row[1]

		if first_index then
			key_info.main, key_info.enablers, key_info.disablers = InputUtils.split_key(first_index)

			if table.contains(pc_device_types, InputUtils.key_device_type(key_info.main)) then
				alias_row[device_index + 1] = value

				return
			end
		end

		alias_row[device_index] = value
	elseif value and table.contains(pc_device_types, InputUtils.key_device_type(new_key_info.main)) then
		table.insert(alias_row, 1, value)
	end
end

function InputAliases:hide_in_controller_layout(name)
	local alias_row = self._aliases[name]

	if alias_row then
		return alias_row.hide_in_controller_layout or false
	end
end

function InputAliases:description(name)
	local alias_row = self._aliases[name]

	if alias_row then
		return alias_row.description
	end
end

function InputAliases:sort_order(name)
	local alias_row = self._aliases[name]

	if alias_row then
		return alias_row.sort_order or math.huge
	end
end

function InputAliases:group(name)
	local alias_row = self._aliases[name]

	if alias_row then
		return alias_row.group
	end
end

function InputAliases:bindable(name)
	local alias_row = self._aliases[name]

	if alias_row then
		if alias_row.bindable ~= nil then
			return alias_row.bindable
		end

		return true
	end

	return false
end

function InputAliases:hide_in_keybindings_menu(name)
	local alias_row = self._aliases[name]

	if alias_row then
		if alias_row.hide_in_keybindings_menu ~= nil then
			return alias_row.hide_in_keybindings_menu
		end

		return false
	end

	return false
end

function InputAliases:alias_table()
	return self._aliases
end

return InputAliases
