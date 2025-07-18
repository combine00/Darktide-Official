local Crosshair = require("scripts/ui/utilities/crosshair")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIHudSettings = require("scripts/settings/ui/ui_hud_settings")
local template = {
	name = "projectile_drop"
}
local SIZE = {
	16,
	4
}
local HALF_SIZE_X = SIZE[1] * 0.5
local HALF_SIZE_Y = SIZE[2] * 0.5
local SPREAD_DISTANCE = 10
local MIN_OFFSET = HALF_SIZE_X + 7

function template.create_widget_defintion(template, scenegraph_id)
	return UIWidget.create_definition({
		{
			value = "content/ui/materials/hud/crosshairs/projectile_drop_center",
			style_id = "center",
			pass_type = "texture",
			style = {
				vertical_alignment = "top",
				horizontal_alignment = "center",
				offset = {
					0,
					0,
					0
				},
				size = {
					30,
					44
				},
				color = UIHudSettings.color_tint_main_1
			}
		},
		Crosshair.hit_indicator_segment("top_left"),
		Crosshair.hit_indicator_segment("bottom_left"),
		Crosshair.hit_indicator_segment("top_right"),
		Crosshair.hit_indicator_segment("bottom_right"),
		Crosshair.weakspot_hit_indicator_segment("top_left"),
		Crosshair.weakspot_hit_indicator_segment("bottom_left"),
		Crosshair.weakspot_hit_indicator_segment("top_right"),
		Crosshair.weakspot_hit_indicator_segment("bottom_right"),
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "left",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				angle = math.rad(-45),
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				},
				offset = {
					0,
					0,
					1
				},
				default_offset = {
					0,
					0,
					1
				},
				size = SIZE,
				color = UIHudSettings.color_tint_main_1
			}
		},
		{
			value = "content/ui/materials/hud/crosshairs/default_spread",
			style_id = "right",
			pass_type = "rotated_texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				angle = math.rad(45),
				offset = {
					0,
					0,
					1
				},
				default_offset = {
					0,
					0,
					1
				},
				size = SIZE,
				color = UIHudSettings.color_tint_main_1
			}
		}
	}, scenegraph_id)
end

function template.on_enter(widget, template, data)
	return
end

function template.update_function(parent, ui_renderer, widget, template, crosshair_settings, dt, t, draw_hit_indicator)
	local style = widget.style
	local hit_progress, hit_color, hit_weakspot = parent:hit_indicator()
	local yaw, pitch = parent:_spread_yaw_pitch(dt)

	if yaw and pitch then
		local scalar = SPREAD_DISTANCE * (crosshair_settings.spread_scalar or 1)
		local spread_offset_y = pitch * scalar
		local spread_offset_x = yaw * scalar
		local left_style = style.left
		left_style.offset[1] = math.min(-spread_offset_x - HALF_SIZE_X, -MIN_OFFSET)
		left_style.offset[2] = 0
		local right_style = style.right
		right_style.offset[1] = math.max(spread_offset_x + HALF_SIZE_X, MIN_OFFSET)
		right_style.offset[2] = 0
	end

	Crosshair.update_hit_indicator(style, hit_progress, hit_color, hit_weakspot, draw_hit_indicator)
end

return template
