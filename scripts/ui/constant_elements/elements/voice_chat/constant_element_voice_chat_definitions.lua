local HudElementTeamPanelHandlerSettings = require("scripts/ui/hud/elements/team_panel_handler/hud_element_team_panel_handler_settings")
local HudElementTeamPlayerPanelSettings = require("scripts/ui/hud/elements/team_player_panel/hud_element_team_player_panel_settings")
local HudElementPersonalPlayerPanelSettings = require("scripts/ui/hud/elements/personal_player_panel/hud_element_personal_player_panel_settings")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local max_panels = 4
local panel_size = {
	1000,
	30
}
local panel_offset = {
	0,
	-35,
	0
}
local panel_spacing = {
	0,
	16
}
local start_offset = {
	17,
	-20,
	0
}
local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
	local_player = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "left",
		position = start_offset,
		size = panel_size
	}
}
local widget_definitions = {}
local position_x = start_offset[1] + panel_offset[1]
local position_y = start_offset[2] + panel_offset[2] - panel_size[2]

for i = 1, max_panels do
	local scenegraph_id = "player_" .. i
	local position = {
		position_x,
		position_y,
		panel_offset[3]
	}
	scenegraph_definition[scenegraph_id] = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "left",
		size = panel_size,
		position = position
	}
	position_x = position_x + panel_spacing[1]
	position_y = position_y - (panel_size[2] + panel_spacing[2])
	widget_definitions[scenegraph_id] = UIWidget.create_definition({
		{
			style_id = "background",
			value_id = "background",
			pass_type = "texture_uv",
			value = "content/ui/materials/backgrounds/terminal_notification",
			style = {
				vertical_alignment = "center",
				scale_to_material = true,
				horizontal_alignment = "left",
				size_addition = {
					0,
					20
				},
				material_values = {},
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				}
			}
		},
		{
			value = "content/ui/materials/hud/icons/speaker",
			style_id = "texture",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				size = {
					32,
					32
				},
				offset = {
					10,
					0,
					6
				},
				color = Color.terminal_text_header(255, true)
			}
		},
		{
			value = "",
			value_id = "display_name",
			pass_type = "text",
			style = {
				font_size = 18,
				text_vertical_alignment = "center",
				text_horizontal_alignment = "left",
				text_color = Color.terminal_text_header(255, true),
				offset = {
					40,
					0,
					1
				}
			}
		}
	}, scenegraph_id, {
		visible = false
	})
end

return {
	widget_definitions = widget_definitions,
	scenegraph_definition = scenegraph_definition
}
