local InputUtils = {
	input_device_list = {
		xbox_controller = {
			rawget(_G, "Pad1"),
			rawget(_G, "Pad2"),
			rawget(_G, "Pad3"),
			rawget(_G, "Pad4"),
			rawget(_G, "Pad5"),
			rawget(_G, "Pad6"),
			rawget(_G, "Pad7"),
			rawget(_G, "Pad8")
		},
		ps4_controller = {
			rawget(_G, "PS5Pad1"),
			rawget(_G, "PS5Pad2"),
			rawget(_G, "PS5Pad3"),
			rawget(_G, "PS5Pad4"),
			rawget(_G, "PS5Pad5"),
			rawget(_G, "PS5Pad6"),
			rawget(_G, "PS5Pad7"),
			rawget(_G, "PS5Pad8")
		},
		mouse = {
			rawget(_G, "Mouse")
		},
		keyboard = {
			rawget(_G, "Keyboard")
		}
	},
	replaced_strings = {}
}
InputUtils.replaced_strings.oem_period = "oem_period (> .)"
InputUtils.replaced_strings.oem_minus = "oem_minus (_ -)"
InputUtils.replaced_strings["numpad plus"] = "numpad +"
InputUtils.replaced_strings["num minus"] = "num -"
InputUtils.replaced_strings.oem_comma = "oem_comma (< ,)"
InputUtils.replaced_strings.oem_colon = "oem_1 (: ;)"
InputUtils.replaced_strings.oem_plus = "oem_plus (+ =)"
InputUtils.replaced_strings.oem_2 = "oem_2 (? /)"
InputUtils.replaced_strings.oem_3 = "oem_3 (~ `)"
InputUtils.replaced_strings.oem_4 = "oem_4 ({ [)"
InputUtils.replaced_strings.oem_5 = "oem_5 (| )"
InputUtils.replaced_strings.oem_6 = "oem_6 (} ])"
InputUtils.replaced_strings.oem_7 = "oem_7 (\" ')"
InputUtils.replaced_strings.oem_8 = "oem_8 (?!)"
InputUtils.replaced_strings.oem_102 = "oem_102 (> <)"

function InputUtils.axis_index(global_name, raw_device, device_type)
	local k = InputUtils.local_key_name(global_name, device_type)

	if k then
		return raw_device.axis_index(k)
	end

	return nil
end

function InputUtils.button_index(global_name, raw_device, device_type)
	local k = InputUtils.local_key_name(global_name, device_type)

	if k then
		return raw_device.button_index(k)
	end

	return nil
end

function InputUtils.local_key_name(global_name, device_type)
	local i, j = string.find(global_name, device_type .. "_")

	if i then
		local k = string.sub(global_name, j + 1)
		k = InputUtils.replaced_strings[k] or k

		return k
	end
end

function InputUtils.local_to_global_name(local_name, device_type)
	local_name = table.find(InputUtils.replaced_strings, local_name) or local_name

	return device_type .. "_" .. local_name
end

function InputUtils.split_key(inputstr)
	local t = {}

	for str in string.gmatch(inputstr, "([^(%+)]+)") do
		table.insert(t, str)
	end

	local k = t[#t]
	t[#t] = nil
	local d = {}
	local m = nil

	for str in string.gmatch(k, "([^(%-)]+)") do
		if not m then
			m = str
		else
			table.insert(d, str)
		end
	end

	return m, t, d
end

function InputUtils.make_string(key_info)
	local keystring = key_info.main

	if key_info.enablers then
		for _, key in ipairs(key_info.enablers) do
			keystring = key .. "+" .. keystring
		end
	end

	if key_info.disablers then
		for _, key in ipairs(key_info.disablers) do
			keystring = keystring .. "-" .. key
		end
	end

	return keystring
end

function InputUtils.get_first_device_of_type(device_type)
	return InputUtils.input_device_list[device_type][1]
end

function InputUtils.key_device_type(global_name)
	for device_type, _ in pairs(InputUtils.input_device_list) do
		if string.find(global_name, device_type) then
			return device_type
		end
	end
end

function InputUtils.localized_button_name(index, device)
	local device_category = device.category()
	local keystring = device.button_locale_name(index) or string.upper(device.button_name(index))

	if device_category == "keyboard" then
		keystring = string.upper(keystring)
		keystring = string.format("[%s]", keystring)
	end

	return keystring
end

function InputUtils.localized_axis_name(index, device)
	local device_category = device.category()
	local keystring = device.axis_locale_name(index) or string.format("AXIS_%s", string.upper(device.axis_name(index)))

	if device_category == "keyboard" then
		keystring = string.upper(keystring)
		keystring = string.format("[%s]", keystring)
	end

	return keystring
end

function InputUtils.key_axis_locale(global_name)
	local device_type = InputUtils.key_device_type(global_name)
	local dummy_device = InputUtils.get_first_device_of_type(device_type)

	if not dummy_device then
		return "[]"
	end

	local index = InputUtils.button_index(global_name, dummy_device, device_type)

	if index then
		return InputUtils.localized_button_name(index, dummy_device), device_type
	end

	index = InputUtils.axis_index(global_name, dummy_device, device_type)

	if index then
		return InputUtils.localized_axis_name(index, dummy_device), device_type
	end

	return "[]"
end

function InputUtils.localized_string_from_key_info(key_info, color_tint_text)
	local keystring = InputUtils.key_axis_locale(key_info.main)

	if key_info.enablers then
		for _, key in ipairs(key_info.enablers) do
			keystring = InputUtils.key_axis_locale(key) .. "+" .. keystring
		end
	end

	if key_info.disablers then
		for _, key in ipairs(key_info.disablers) do
			keystring = keystring .. "-" .. InputUtils.key_axis_locale(key)
		end
	end

	if color_tint_text then
		local ui_input_color = Color.ui_input_color(255, true)
		keystring = InputUtils.apply_color_to_input_text(keystring, ui_input_color)
	end

	return keystring
end

function InputUtils.apply_color_to_input_text(text, color)
	return "{#color(" .. color[2] .. "," .. color[3] .. "," .. color[4] .. ")}" .. text .. "{#reset()}"
end

local _keyboard_devices = {
	"keyboard",
	"mouse"
}
local _gamepad_devices = {
	xbox_controller = {
		"xbox_controller"
	},
	ps4_controller = {
		"ps4_controller"
	}
}

function InputUtils.get_gamepad_device_type()
	if IS_XBS then
		return _gamepad_devices.xbox_controller
	elseif IS_PLAYSTATION then
		return _gamepad_devices.ps4_controller
	else
		local device = Managers.input:last_pressed_device()
		local type = device:type()

		return _gamepad_devices[type] or _keyboard_devices
	end
end

function InputUtils.input_text_for_device_types(service_type, alias_key, color_tint_text, device_types)
	local alias = Managers.input:alias_object(service_type)
	local key_info = alias:get_keys_for_alias(alias_key, device_types)
	local input_key = key_info and InputUtils.localized_string_from_key_info(key_info, color_tint_text) or ""

	return input_key
end

function InputUtils.input_text_for_current_input_device(service_type, alias_key, color_tint_text)
	local device_types = Managers.input:device_in_use("gamepad") and InputUtils.get_gamepad_device_type() or _keyboard_devices

	return InputUtils.input_text_for_device_types(service_type, alias_key, color_tint_text, device_types)
end

function InputUtils.is_gamepad(device_type)
	return _gamepad_devices[device_type] ~= nil
end

function InputUtils.start_simulate_action(input_service_name, action_name, value)
	local input_service = Managers.input:get_input_service(input_service_name)

	input_service:start_simulate_action(action_name, value)
end

function InputUtils.stop_simulate_action(input_service_name, action_name)
	local input_service = Managers.input:get_input_service(input_service_name)

	input_service:stop_simulate_action(action_name)
end

local _temp_device_list = {}

function InputUtils.platform_device_list()
	table.clear(_temp_device_list)

	local input_device_list = InputUtils.input_device_list

	if IS_XBS then
		table.append(_temp_device_list, input_device_list.xbox_controller)
	elseif IS_PLAYSTATION then
		table.append(_temp_device_list, input_device_list.ps4_controller)
	else
		table.append(_temp_device_list, input_device_list.mouse)
		table.append(_temp_device_list, input_device_list.keyboard)

		_temp_device_list[#_temp_device_list + 1] = Pad1
	end

	return _temp_device_list
end

return InputUtils
