local Crosshair = require("scripts/ui/utilities/crosshair")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIHudSettings = require("scripts/settings/ui/ui_hud_settings")
local template = {
	name = "shotgun_wide"
}
local SIZE = {
	24,
	8
}
local HALF_SIZE_X = SIZE[1] * 0.5
local HALF_SIZE_Y = SIZE[2] * 0.5
local SPREAD_DISTANCE_VERTICAL = 1.5
local SPREAD_DISTANCE_HORIZONTAL = 25

local function _crosshair_segment(style_id, angle)
	return table.clone({
		value = "content/ui/materials/hud/crosshairs/shotgun_spread_2",
		pass_type = "rotated_texture",
		style_id = style_id,
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			angle = angle,
			offset = {
				0,
				0,
				1
			},
			size = {
				SIZE[1],
				SIZE[2]
			},
			color = UIHudSettings.color_tint_main_1
		}
	})
end

function template.create_widget_defintion(template, scenegraph_id)
	return UIWidget.create_definition({
		Crosshair.hit_indicator_segment("top_left"),
		Crosshair.hit_indicator_segment("bottom_left"),
		Crosshair.hit_indicator_segment("top_right"),
		Crosshair.hit_indicator_segment("bottom_right"),
		Crosshair.weakspot_hit_indicator_segment("top_left"),
		Crosshair.weakspot_hit_indicator_segment("bottom_left"),
		Crosshair.weakspot_hit_indicator_segment("top_right"),
		Crosshair.weakspot_hit_indicator_segment("bottom_right"),
		_crosshair_segment("left", math.rad(90)),
		_crosshair_segment("right", math.rad(-90))
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
		local scalar_vertical = SPREAD_DISTANCE_VERTICAL * (crosshair_settings.spread_scalar_vertical or 1)
		local scalar_horizontal = SPREAD_DISTANCE_HORIZONTAL * (crosshair_settings.spread_scalar_horizontal or 1)
		local spread_offset_y = pitch * scalar_vertical
		local spread_offset_x = yaw * scalar_horizontal
		local left_style = style.left
		left_style.offset[1] = -spread_offset_x - HALF_SIZE_X * 2
		left_style.offset[2] = 0
		local right_style = style.right
		right_style.offset[1] = spread_offset_x + HALF_SIZE_X * 2
		right_style.offset[2] = 0
	end

	Crosshair.update_hit_indicator(style, hit_progress, hit_color, hit_weakspot, draw_hit_indicator)
end

return template
