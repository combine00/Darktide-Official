local HudElementPlayerWeaponHandlerSettings = require("scripts/ui/hud/elements/player_weapon_handler/hud_element_player_weapon_handler_settings")
local HudElementPlayerWeaponSettings = require("scripts/ui/hud/elements/player_weapon/hud_element_player_weapon_settings")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIHudSettings = require("scripts/settings/ui/ui_hud_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local size = HudElementPlayerWeaponHandlerSettings.size
local icon_size = HudElementPlayerWeaponHandlerSettings.icon_size
local max_ammo_digits = HudElementPlayerWeaponSettings.max_ammo_digits
local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
	weapon = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "right",
		size = size,
		position = {
			-50,
			0,
			2
		}
	},
	background = {
		vertical_alignment = "bottom",
		parent = "weapon",
		horizontal_alignment = "right",
		size = size,
		position = {
			0,
			0,
			0
		}
	}
}
local ammo_text_style = {
	line_spacing = 0.9,
	font_size = 48,
	drop_shadow = false,
	font_type = "machine_medium",
	text_color = UIHudSettings.color_tint_main_1,
	offset = {
		-64,
		0,
		6
	},
	default_font_size = HudElementPlayerWeaponSettings.ammo_font_size_default,
	focused_font_size = HudElementPlayerWeaponSettings.ammo_font_size_focused,
	text_horizontal_alignment = "right",
	text_vertical_alignment = "top",
	vertical_alignment = "center",
	drop_shadow = false,
	clip_ammo = true
}
local ammo_spare_text_style = table.clone(ammo_text_style)
ammo_spare_text_style.offset = {
	0,
	0,
	7
}
ammo_spare_text_style.text_horizontal_alignment = "right"
ammo_spare_text_style.text_vertical_alignment = "top"
ammo_spare_text_style.vertical_alignment = "center"
ammo_spare_text_style.text_color = UIHudSettings.color_tint_main_3
ammo_spare_text_style.default_text_color = ammo_text_style.text_color
ammo_spare_text_style.default_font_size = HudElementPlayerWeaponSettings.ammo_font_size_default_small
ammo_spare_text_style.focused_font_size = HudElementPlayerWeaponSettings.ammo_font_size_focused_small
ammo_spare_text_style.clip_ammo = false
local input_text_style = table.clone(UIFontSettings.hud_body)
input_text_style.horizontal_alignment = "left"
input_text_style.vertical_alignment = "center"
input_text_style.text_horizontal_alignment = "left"
input_text_style.text_vertical_alignment = "center"
input_text_style.font_size = 20
input_text_style.offset = {
	10,
	0,
	8
}
input_text_style.drop_shadow = false
input_text_style.text_color = UIHudSettings.color_tint_main_1

local function _create_ammo_counter_pass_definitions()
	local pass_definitions = {}

	for ii = 1, max_ammo_digits do
		pass_definitions[#pass_definitions + 1] = {
			pass_type = "text",
			value_id = string.format("ammo_amount_%d", ii),
			style_id = string.format("ammo_amount_%d", ii),
			value = string.format("<ammo_amount_%d>", ii),
			style = table.merge({
				primary_counter = true,
				index = ii
			}, ammo_text_style)
		}
		pass_definitions[#pass_definitions + 1] = {
			pass_type = "text",
			value = "",
			value_id = string.format("ammo_spare_%d", ii),
			style_id = string.format("ammo_spare_%d", ii),
			style = table.merge({
				index = ii
			}, ammo_spare_text_style)
		}
	end

	return pass_definitions
end

local widget_definitions = {
	icon = UIWidget.create_definition({
		{
			value_id = "icon",
			style_id = "icon",
			pass_type = "texture",
			value = "content/ui/materials/hud/icons/weapon_icon_container",
			style = {
				horizontal_alignment = "right",
				vertical_alignment = "center",
				size = icon_size,
				default_size = icon_size,
				offset = {
					0,
					0,
					4
				},
				color = UIHudSettings.color_tint_main_2,
				default_color = Color.terminal_corner_hover(nil, true),
				highlight_color = Color.terminal_icon(nil, true),
				material_values = {}
			}
		}
	}, "background"),
	ammo_text = UIWidget.create_definition(_create_ammo_counter_pass_definitions(), "background"),
	input_text = UIWidget.create_definition({
		{
			value_id = "text",
			style_id = "text",
			pass_type = "text",
			value = "<n/a>",
			style = input_text_style,
			visibility_function = function (content, style)
				local text = content.text

				return text ~= nil
			end
		}
	}, "background"),
	infinite_symbol = UIWidget.create_definition({
		{
			value = "content/ui/materials/symbols/infinite",
			style_id = "texture",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				size = HudElementPlayerWeaponSettings.infinite_symbol_size,
				offset = {
					20,
					0,
					10
				},
				color = UIHudSettings.color_tint_main_2
			}
		}
	}, "background"),
	background = UIWidget.create_definition({
		{
			value = "content/ui/materials/hud/backgrounds/terminal_background_weapon",
			style_id = "background",
			pass_type = "texture",
			style = {
				color = Color.terminal_background_gradient(255, true)
			}
		},
		{
			style_id = "line",
			pass_type = "rect",
			style = {
				horizontal_alignment = "right",
				color = Color.terminal_icon(nil, true),
				default_color = Color.terminal_corner(nil, true),
				highlight_color = Color.terminal_corner_hover(nil, true),
				size = {
					4
				},
				offset = {
					0,
					0,
					2
				}
			}
		}
	}, "background")
}

return {
	widget_definitions = widget_definitions,
	scenegraph_definition = scenegraph_definition
}
