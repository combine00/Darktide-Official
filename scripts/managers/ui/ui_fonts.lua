local UIFonts = {
	scaled_size = function (font_size, scale)
		local scaled_size = math.max(font_size * scale, 1)

		return scaled_size
	end,
	data_by_type = function (font_type)
		return Managers.font:data_by_type(font_type)
	end
}
local font_heights = {}
local font_vertical_base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
local font_height_base = "A"

function UIFonts.font_height(gui, font_type, font_size)
	font_size = math.ceil(font_size)
	font_heights[font_type] = font_heights[font_type] or {}
	local height_data = font_heights[font_type][font_size]

	if height_data then
		return height_data[1], height_data[2], height_data[3]
	end

	local font_data = UIFonts.data_by_type(font_type)
	local font = font_data.path
	local min, max, caret = Gui.slug_text_extents(gui, font_vertical_base, font, font_size)
	local base_min, base_max, caret = Gui.slug_text_extents(gui, font_height_base, font, font_size)
	local height = base_max[3] - base_min[3]
	font_heights[font_type][font_size] = {
		height,
		min.y,
		max.y
	}

	return height, min.y, max.y
end

local text_horizontal_alignment_lookup = {
	left = Gui.HorizontalAlignLeft,
	center = Gui.HorizontalAlignCenter,
	right = Gui.HorizontalAlignRight
}
local text_vertical_alignment_lookup = {
	top = Gui.VerticalAlignTop,
	center = Gui.VerticalAlignCenter,
	bottom = Gui.VerticalAlignBottom
}

local function assign_font_options(style, destination)
	destination.line_spacing = style.line_spacing
	destination.character_spacing = style.character_spacing
	destination.horizontal_alignment = text_horizontal_alignment_lookup[style.text_horizontal_alignment]
	destination.vertical_alignment = text_vertical_alignment_lookup[style.text_vertical_alignment]
	destination.shadow = style.drop_shadow

	return destination
end

local font_options_by_style = Script.new_map(128)

function UIFonts.get_font_options_by_style(style, destination)
	if destination then
		return assign_font_options(style, destination)
	end

	local style_hash = Application.make_hash(style.line_spacing, style.character_spacing, text_horizontal_alignment_lookup[style.text_horizontal_alignment], text_vertical_alignment_lookup[style.text_vertical_alignment], style.shadow)
	local font_options = font_options_by_style[style_hash]

	if not font_options then
		font_options = assign_font_options(style, Script.new_map(8))
		font_options_by_style[style_hash] = font_options
	end

	return font_options
end

return UIFonts
