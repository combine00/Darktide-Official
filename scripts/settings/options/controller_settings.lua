local Options = require("scripts/utilities/ui/options")
local SaveData = require("scripts/managers/save/save_data")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local SettingsUtilitiesFunction = require("scripts/settings/options/settings_utils")
local SettingsUtilities = {}

local function construct_interface_settings_boolean(template)
	local entry = {
		default_value = template.default_value,
		display_name = template.display_name,
		on_value_changed = template.on_value_changed,
		indentation_level = template.indentation_level,
		validation_function = template.validation_function,
		tooltip_text = template.tooltip_text,
		disable_rules = template.disable_rules,
		is_sub_setting = template.is_sub_setting,
		id = template.id
	}
	local id = template.id
	local save_location = template.save_location
	local default_value = template.default_value

	function entry.get_function()
		local old_value = SettingsUtilities.get_account_settings(save_location, id)

		if old_value == nil then
			return default_value
		else
			return old_value
		end
	end

	function entry.on_activated(value, template)
		SettingsUtilities.verify_and_apply_changes(template, value)
	end

	function entry.on_changed(new_value)
		local current_value = SettingsUtilities.get_account_settings(save_location, id)

		if current_value == nil then
			current_value = default_value
		end

		if not SettingsUtilities.is_same(current_value, new_value) then
			SettingsUtilities.save_account_settings(save_location, id, new_value)

			if entry.on_value_changed then
				entry.on_value_changed(new_value)
			end
		end
	end

	return entry
end

local function construct_interface_settings_percent_slider(template)
	local min_value = template.min_value or 0
	local max_value = template.max_value or 100
	local value_range = max_value - min_value
	local convertion_value = value_range / 100
	local step_size = template.step_size_value or 1
	local percent_step_size = step_size / convertion_value
	local default_value = ((template.default_value or min_value) - min_value) / convertion_value
	local id = template.id
	local save_location = template.save_location

	local function explode_value(percent_value)
		local exploded_value = min_value + percent_value * convertion_value
		exploded_value = math.round(exploded_value / step_size) * step_size

		return exploded_value
	end

	local on_value_changed = template.on_value_changed

	local function on_value_changed_function(percent_value)
		local exploded_value = explode_value(percent_value)

		SettingsUtilities.save_account_settings(save_location, id, exploded_value)

		if on_value_changed then
			on_value_changed(exploded_value)
		end
	end

	local value_get_function = template.get_function or function ()
		local exploded_value = SettingsUtilities.get_account_settings(save_location, id)

		if exploded_value == nil then
			exploded_value = default_value
		end

		local percent_value = (exploded_value - min_value) / convertion_value

		return percent_value
	end
	local format_value_function = template.format_value_function or function (current_value)
		local exploded_value = explode_value(current_value)
		local result = string.format("%d %%", exploded_value)

		return result
	end

	local function on_activated(value, template)
		SettingsUtilities.verify_and_apply_changes(template, value)
	end

	local params = {
		apply_on_drag = true,
		display_name = template.display_name,
		default_value = default_value,
		step_size_value = percent_step_size,
		value_get_function = value_get_function,
		on_value_changed_function = on_value_changed_function,
		format_value_function = format_value_function,
		on_activated = on_activated,
		indentation_level = template.indentation_level,
		validation_function = template.validation_function,
		tooltip_text = template.tooltip_text,
		disable_rules = template.disable_rules,
		is_sub_setting = template.is_sub_setting
	}

	return Options.create_percent_slider_template(params)
end

local function construct_interface_settings_value_slider(template)
	local min_value = template.min_value or 0
	local max_value = template.max_value or 100
	local default_value = template.default_value or min_value
	local step_size_value = template.step_size_value
	local num_decimals = template.num_decimals
	local on_value_changed = template.on_value_changed
	local id = template.id
	local save_location = template.save_location

	local function on_value_changed_function(value)
		SettingsUtilities.save_account_settings(save_location, id, value)

		if on_value_changed then
			on_value_changed(value)
		end
	end

	local function value_get_function()
		return SettingsUtilities.get_account_settings(save_location, id) or default_value
	end

	local function on_activated(value, template)
		SettingsUtilities.verify_and_apply_changes(template, value)
	end

	local params = {
		min_value = min_value,
		max_value = max_value,
		display_name = template.display_name,
		default_value = default_value,
		num_decimals = num_decimals,
		step_size_value = step_size_value,
		value_get_function = value_get_function,
		on_value_changed_function = on_value_changed_function,
		on_activated = on_activated,
		apply_on_drag = template.apply_on_drag,
		indentation_level = template.indentation_level,
		validation_function = template.validation_function,
		id = template.id,
		tooltip_text = template.tooltip_text,
		disable_rules = template.disable_rules,
		is_sub_setting = template.is_sub_setting
	}

	return Options.create_value_slider_template(params)
end

local function construct_interface_settings_dropdown(template)
	local on_value_changed = template.on_value_changed
	local id = template.id
	local save_location = template.save_location

	local function value_get_function()
		return SettingsUtilities.get_account_settings(save_location, id)
	end

	local options = {}

	for i = 1, #template.options do
		local value = template.options[i]
		options[#options + 1] = {
			id = value.name,
			value = value.name,
			display_name = value.display_name,
			icon = value.icon
		}
	end

	local function on_activated(value, template)
		SettingsUtilities.verify_and_apply_changes(template, value)
	end

	local function on_changed(value, template)
		SettingsUtilities.save_account_settings(save_location, id, value)

		if on_value_changed then
			on_value_changed(value)
		end
	end

	local params = {
		display_name = template.display_name,
		get_function = value_get_function,
		options = options,
		on_activated = on_activated,
		on_changed = on_changed,
		indentation_level = template.indentation_level,
		validation_function = template.validation_function,
		id = template.id,
		tooltip_text = template.tooltip_text,
		disable_rules = template.disable_rules,
		default_value = template.default_value,
		is_sub_setting = template.is_sub_setting
	}

	return params
end

local function _aim_assist_options()
	local options = {
		{
			display_name = "loc_setting_aim_assist_off",
			name = "off"
		},
		{
			display_name = "loc_setting_aim_assist_old",
			name = "old"
		},
		{
			display_name = "loc_setting_aim_assist_new_slim",
			name = "new_slim"
		},
		{
			display_name = "loc_setting_aim_assist_new_full",
			name = "new_full"
		}
	}

	return options
end

local function _response_curve_options()
	local options = {
		{
			icon = "content/ui/materials/icons/system/settings/dropdown/icon_response_curve_linear",
			name = "linear",
			display_name = "loc_setting_controller_rotation_speed_curves_linear"
		},
		{
			icon = "content/ui/materials/icons/system/settings/dropdown/icon_response_curve_exponential",
			name = "exponential",
			display_name = "loc_setting_controller_rotation_speed_curves_exponential"
		},
		{
			icon = "content/ui/materials/icons/system/settings/dropdown/icon_response_curve_dynamic",
			name = "dynamic",
			display_name = "loc_setting_controller_rotation_speed_curves_dynamic"
		}
	}

	return options
end

local settings_definitions = {
	[#settings_definitions + 1] = {
		group_name = "controller_settings",
		display_name = "loc_settings_menu_group_controller_settings",
		widget_type = "group_header"
	}
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].display_name = "loc_settings_menu_group_controller_settings_sony"
end

function get_gamepad_input_layout_names(layouts)
	local layout_names = {}

	for name, values in pairs(layouts) do
		layout_names[#layout_names + 1] = {
			name = name,
			display_name = values.display_name,
			sort_order = values.sort_order
		}

		table.sort(layout_names, function (a, b)
			return a.sort_order < b.sort_order
		end)
	end

	return layout_names
end

local gamepad_input_layouts = require("scripts/settings/input/gamepad_input_layouts")
local gamepad_layout_names = get_gamepad_input_layout_names(gamepad_input_layouts)
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	display_name = "loc_setting_controller_layout",
	id = "controller_layout",
	widget_type = "dropdown",
	options = gamepad_layout_names,
	validation_function = function ()
		return true
	end,
	on_value_changed = function (value)
		local devices = {
			{
				"ps4_controller"
			},
			{
				"xbox_controller"
			}
		}
		local input_manager = Managers.input
		local gamepad_input_layout = gamepad_input_layouts[value]
		local input_settings = gamepad_input_layout.input_settings

		for service_type, aliases in pairs(input_settings) do
			local alias = input_manager:alias_object(service_type)

			if alias then
				alias:restore_default_by_devices(nil, devices)

				for alias_name, new_values in pairs(aliases) do
					if alias:bindable(alias_name) then
						for i = 1, #devices do
							local device_table = devices[i]
							local key_info = nil

							if new_values ~= StrictNil then
								key_info = alias:get_keys_for_alias_row(new_values, device_table)
							end

							alias:set_keys_for_alias(alias_name, device_table, key_info, i)
						end
					end
				end

				input_manager:apply_alias_changes(service_type)
				input_manager:save_key_mappings(service_type)
			end
		end

		if IS_PLAYSTATION then
			Managers.event:trigger("event_update_haptic_trigger_effects_enabled")
			Managers.event:trigger("event_update_haptic_trigger_melee_resistance_strength")
			Managers.event:trigger("event_update_haptic_trigger_ranged_resistance_strength")
			Managers.event:trigger("event_update_haptic_trigger_melee_vibration_strength")
			Managers.event:trigger("event_update_haptic_trigger_ranged_vibration_strength")
		end
	end
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].display_name = "loc_setting_controller_layout_sony"
end

settings_definitions[#settings_definitions + 1] = {
	id = "controller_layout_image",
	display_name = "setting_controller_image_layout",
	widget_type = "controller_image"
}
settings_definitions[#settings_definitions + 1] = {
	display_name = "loc_xbox_controller_chat_button_description",
	shrink_to_fit = true,
	widget_type = "description",
	display_params = {
		input = "+"
	},
	validation_function = function ()
		return IS_XBS
	end
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_settings_menu_group_controller_rumble_settings",
	widget_type = "group_header"
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].display_name = "loc_settings_menu_group_controller_rumble_settings_sony"
end

settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	display_name = "loc_interface_setting_rumble_enabled",
	id = "rumble_enabled",
	default_value = true,
	widget_type = "boolean",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_enabled", value)

		if value then
			local event_name = IS_PLAYSTATION and UISoundEvents.rumble_enabled_ps5 or UISoundEvents.rumble_enabled

			Managers.ui:play_2d_sound(event_name)
		end
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	default_value = 50,
	display_name = "loc_settings_menu_rumble_intensity",
	min_value = 0,
	id = "rumble_intensity",
	tooltip_text = "loc_settings_menu_rumble_intensity_mouseover",
	widget_type = "percent_slider",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_intensity", value)
		Managers.ui:play_2d_sound(UISoundEvents.rumble_changed)
	end
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].tooltip_text = "loc_settings_menu_rumble_intensity_mouseover_sony"
end

settings_definitions[#settings_definitions + 1] = {
	group_name = "trigger_haptics",
	display_name = "loc_settings_menu_group_rumble_combat",
	widget_type = "group_sub_header",
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	default_value = 100,
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	min_value = 0,
	widget_type = "percent_slider",
	id = "rumble_intensity_combat_melee",
	tooltip_text = "loc_settings_menu_rumble_rumble_combat_melee_mouseover",
	save_location = "input_settings",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_intensity", value)
	end,
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	default_value = 100,
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	min_value = 0,
	widget_type = "percent_slider",
	id = "rumble_intensity_combat_ranged",
	tooltip_text = "loc_settings_menu_rumble_rumble_combat_ranged_mouseover",
	save_location = "input_settings",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_intensity", value)
	end,
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	default_value = 100,
	display_name = "loc_settings_menu_rumble_gameplay",
	min_value = 0,
	id = "rumble_intensity_gameplay",
	tooltip_text = "loc_settings_menu_rumble_gameplay_mouseover",
	widget_type = "percent_slider",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_intensity", value)
	end
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].tooltip_text = "loc_settings_menu_rumble_gameplay_mouseover_sony"
end

settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	default_value = 100,
	display_name = "loc_settings_menu_rumble_immersive",
	min_value = 0,
	id = "rumble_intensity_immersive",
	tooltip_text = "loc_settings_menu_rumble_immersive_mouseover",
	widget_type = "percent_slider",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_rumble_intensity", value)
	end
}

if IS_PLAYSTATION then
	settings_definitions[#settings_definitions].tooltip_text = "loc_settings_menu_rumble_immersive_mouseover_sony"
end

settings_definitions[#settings_definitions + 1] = {
	group_name = "trigger_haptics",
	display_name = "loc_settings_menu_group_trigger_haptics_settings",
	widget_type = "group_header",
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	display_name = "loc_settings_menu_trigger_effects_enabled",
	id = "haptic_trigger_effects_enabled",
	default_value = true,
	widget_type = "boolean",
	validation_function = function ()
		return IS_PLAYSTATION
	end,
	on_value_changed = function (value)
		Managers.event:trigger("event_update_haptic_trigger_effects_enabled", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "trigger_haptics",
	display_name = "loc_settings_menu_group_trigger_haptics_resistance_strength_settings",
	widget_type = "group_sub_header",
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	id = "haptic_trigger_melee_resistance_strength",
	widget_type = "dropdown",
	options = {
		{
			display_name = "loc_setting_haptic_trigger_strength_off",
			name = "off"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_subtle",
			name = "subtle"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_strong",
			name = "strong"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_full",
			name = "full"
		}
	},
	validation_function = function ()
		return IS_PLAYSTATION
	end,
	on_value_changed = function (value)
		Managers.event:trigger("event_update_haptic_trigger_melee_resistance_strength", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	id = "haptic_trigger_ranged_resistance_strength",
	widget_type = "dropdown",
	options = {
		{
			display_name = "loc_setting_haptic_trigger_strength_off",
			name = "off"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_subtle",
			name = "subtle"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_strong",
			name = "strong"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_full",
			name = "full"
		}
	},
	validation_function = function ()
		return IS_PLAYSTATION
	end,
	on_value_changed = function (value)
		Managers.event:trigger("event_update_haptic_trigger_ranged_resistance_strength", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "trigger_haptics",
	display_name = "loc_settings_menu_group_trigger_haptics_vibration_strength_settings",
	widget_type = "group_sub_header",
	validation_function = function ()
		return IS_PLAYSTATION
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	id = "haptic_trigger_melee_vibration_strength",
	widget_type = "dropdown",
	options = {
		{
			display_name = "loc_setting_haptic_trigger_strength_off",
			name = "off"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_subtle",
			name = "subtle"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_strong",
			name = "strong"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_full",
			name = "full"
		}
	},
	validation_function = function ()
		return IS_PLAYSTATION
	end,
	on_value_changed = function (value)
		Managers.event:trigger("event_update_haptic_trigger_melee_vibration_strength", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	id = "haptic_trigger_ranged_vibration_strength",
	widget_type = "dropdown",
	options = {
		{
			display_name = "loc_setting_haptic_trigger_strength_off",
			name = "off"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_subtle",
			name = "subtle"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_strong",
			name = "strong"
		},
		{
			display_name = "loc_setting_haptic_trigger_strength_full",
			name = "full"
		}
	},
	validation_function = function ()
		return IS_PLAYSTATION
	end,
	on_value_changed = function (value)
		Managers.event:trigger("event_update_haptic_trigger_ranged_vibration_strength", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_settings_menu_group_controller_aim_settings_new",
	widget_type = "group_header"
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	display_name = "loc_setting_aim_assist",
	id = "controller_aim_assist",
	widget_type = "dropdown",
	options = _aim_assist_options(),
	tooltip_text = function ()
		local assist_title_1 = Localize("loc_setting_aim_assist_new_full")
		local assist_desc_1 = Localize("loc_setting_aim_assist_new_full_desc")
		local assist_title_2 = Localize("loc_setting_aim_assist_new_slim")
		local assist_desc_2 = Localize("loc_setting_aim_assist_new_slim_desc")
		local assist_title_3 = Localize("loc_setting_aim_assist_old")
		local assist_desc_3 = Localize("loc_setting_aim_assist_old_desc")
		local assist_title_4 = Localize("loc_setting_aim_assist_off")
		local assist_desc_4 = Localize("loc_setting_aim_assist_off_desc")

		return Localize("loc_setting_aim_assist_mouseover_text_format", false, {
			assist_title_1 = assist_title_1,
			assist_desc_1 = assist_desc_1,
			assist_title_2 = assist_title_2,
			assist_desc_2 = assist_desc_2,
			assist_title_3 = assist_title_3,
			assist_desc_3 = assist_desc_3,
			assist_title_4 = assist_title_4,
			assist_desc_4 = assist_desc_4
		})
	end
}
settings_definitions[#settings_definitions + 1] = {
	id = "controller_invert_look_y",
	save_location = "input_settings",
	display_name = "loc_setting_controller_invert_look_y",
	widget_type = "boolean"
}
settings_definitions[#settings_definitions + 1] = {
	id = "controller_enable_acceleration",
	save_location = "input_settings",
	display_name = "loc_setting_controller_enable_acceleration_new",
	widget_type = "boolean"
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_setting_menu_group_response_curve_type",
	widget_type = "group_sub_header"
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	id = "controller_response_curve",
	widget_type = "dropdown",
	options = _response_curve_options()
}
settings_definitions[#settings_definitions + 1] = {
	save_location = "input_settings",
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	id = "controller_response_curve_ranged",
	widget_type = "dropdown",
	options = _response_curve_options()
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_setting_menu_group_response_curve_strength",
	widget_type = "group_sub_header"
}
settings_definitions[#settings_definitions + 1] = {
	default_value = 0,
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	max_value = 100,
	min_value = -100,
	widget_type = "percent_slider",
	id = "controller_response_curve_strength",
	tooltip_text = "loc_setting_controller_rotation_speed_curves_strength_mouseover",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	default_value = 0,
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	max_value = 100,
	min_value = -100,
	widget_type = "percent_slider",
	id = "controller_response_curve_strength_ranged",
	tooltip_text = "loc_setting_controller_rotation_speed_curves_strength_mouseover",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.01,
	apply_on_drag = true,
	display_name = "loc_setting_controller_look_dead_zone_new",
	num_decimals = 2,
	max_value = 1,
	min_value = 0,
	widget_type = "value_slider",
	id = "controller_look_dead_zone",
	save_location = "input_settings",
	on_value_changed = function (value)
		Managers.event:trigger("event_update_dead_zone", value)
	end
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_setting_menu_group_horizontal_sensitivity",
	widget_type = "group_sub_header"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale_ranged",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_ranged_alt_fire",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale_ranged_alternate_fire",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	group_name = "controller_aim_settings",
	display_name = "loc_setting_menu_group_vertical_sensitivity",
	widget_type = "group_sub_header"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_melee",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale_vertical",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_ranged",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale_vertical_ranged",
	save_location = "input_settings"
}
settings_definitions[#settings_definitions + 1] = {
	step_size_value = 0.1,
	is_sub_setting = true,
	display_name = "loc_setting_ranged_alt_fire",
	num_decimals = 1,
	max_value = 10,
	min_value = 0.1,
	widget_type = "value_slider",
	id = "controller_look_scale_vertical_ranged_alternate_fire",
	save_location = "input_settings"
}
local template_functions = {
	boolean = construct_interface_settings_boolean,
	value_slider = construct_interface_settings_value_slider,
	percent_slider = construct_interface_settings_percent_slider,
	dropdown = construct_interface_settings_dropdown
}
local settings = {}

for i = 1, #settings_definitions do
	local definition = settings_definitions[i]
	local widget_type = definition.widget_type
	local template_function = template_functions[widget_type]

	if definition.default_value == nil then
		local save_location = definition.save_location
		local id = definition.id

		if save_location then
			definition.default_value = SaveData.default_account_data[save_location][id]
		else
			definition.default_value = SaveData.default_account_data[id]
		end
	end

	if template_function then
		settings[#settings + 1] = template_function(definition)
		settings[#settings].id = definition.id
	else
		settings[#settings + 1] = definition
	end
end

SettingsUtilities = SettingsUtilitiesFunction(settings)
local ControllerSettings = {
	icon = "content/ui/materials/icons/system/settings/category_controls",
	display_name = "loc_settings_menu_group_controller_settings",
	settings_utilities = SettingsUtilities,
	settings_by_id = SettingsUtilities.settings_by_id,
	settings = settings
}

if IS_PLAYSTATION then
	ControllerSettings.display_name = "loc_settings_menu_group_controller_settings_sony"
end

return ControllerSettings
