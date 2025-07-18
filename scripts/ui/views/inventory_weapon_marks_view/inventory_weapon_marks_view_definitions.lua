local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local InventoryWeaponCosmeticsViewSettings = require("scripts/ui/views/inventory_weapon_cosmetics_view/inventory_weapon_cosmetics_view_settings")
local ItemUtils = require("scripts/utilities/items")
local ScrollbarPassTemplates = require("scripts/ui/pass_templates/scrollbar_pass_templates")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UISettings = require("scripts/settings/ui/ui_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local info_box_size = {
	1150,
	200
}
local equip_button_size = {
	374,
	76
}
local title_height = 70
local edge_padding = 44
local grid_width = 337
local grid_height = 860
local grid_size = {
	grid_width - edge_padding,
	grid_height
}
local grid_spacing = {
	10,
	10
}
local mask_size = {
	grid_width + 40,
	grid_height + 20
}
local grid_settings = {
	scrollbar_width = 7,
	widget_icon_load_margin = 0,
	use_terminal_background = true,
	use_select_on_focused = true,
	use_is_focused_for_navigation = false,
	top_padding = 10,
	scrollbar_vertical_margin = 80,
	scrollbar_horizontal_offset = -7,
	use_item_categories = false,
	title_height = 0,
	scrollbar_vertical_offset = 33,
	show_loading_overlay = true,
	grid_spacing = grid_spacing,
	grid_size = grid_size,
	mask_size = mask_size,
	edge_padding = edge_padding
}
local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
	canvas = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			0
		}
	},
	corner_top_left = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "left",
		size = {
			180,
			310
		},
		position = {
			0,
			0,
			62
		}
	},
	corner_top_right = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "right",
		size = {
			180,
			310
		},
		position = {
			0,
			0,
			62
		}
	},
	corner_bottom_left = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "left",
		size = {
			180,
			120
		},
		position = {
			0,
			0,
			62
		}
	},
	corner_bottom_right = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "right",
		size = {
			180,
			120
		},
		position = {
			0,
			0,
			62
		}
	},
	item_grid_pivot = {
		vertical_alignment = "top",
		parent = "canvas",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			100,
			100,
			1
		}
	},
	display_name = {
		vertical_alignment = "top",
		parent = "item_grid_pivot",
		horizontal_alignment = "left",
		size = {
			1000,
			50
		},
		position = {
			5,
			-40,
			100
		}
	},
	weapon_preview = {
		vertical_alignment = "center",
		parent = "canvas",
		horizontal_alignment = "right",
		size = {
			800,
			800
		},
		position = {
			0,
			0,
			1
		}
	},
	description_text = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "left",
		size = {
			1000,
			150
		},
		position = {
			500,
			-120,
			3
		}
	},
	info_box = {
		vertical_alignment = "bottom",
		parent = "canvas",
		horizontal_alignment = "right",
		size = info_box_size,
		position = {
			-100,
			-125,
			3
		}
	},
	equip_button = {
		vertical_alignment = "bottom",
		parent = "info_box",
		horizontal_alignment = "right",
		size = equip_button_size,
		position = {
			-75,
			20,
			1
		}
	},
	weapon_stats_pivot = {
		vertical_alignment = "top",
		parent = "canvas",
		horizontal_alignment = "right",
		size = {
			0,
			0
		},
		position = {
			-630,
			50,
			1
		}
	}
}
local display_name_style = table.clone(UIFontSettings.header_3)
display_name_style.text_horizontal_alignment = "left"
display_name_style.text_vertical_alignment = "top"
local title_text_style = table.clone(UIFontSettings.header_2)
title_text_style.text_horizontal_alignment = "center"
title_text_style.text_vertical_alignment = "bottom"
local description_text_style = table.clone(UIFontSettings.body)
description_text_style.text_horizontal_alignment = "left"
description_text_style.text_vertical_alignment = "top"
description_text_style.text_color = Color.terminal_text_body(255, true)
local widget_definitions = {
	corner_bottom_left = UIWidget.create_definition({
		{
			pass_type = "texture",
			value = "content/ui/materials/frames/screen/metal_01_lower"
		}
	}, "corner_bottom_left"),
	corner_bottom_right = UIWidget.create_definition({
		{
			value = "content/ui/materials/frames/screen/metal_01_lower",
			pass_type = "texture_uv",
			style = {
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
		}
	}, "corner_bottom_right"),
	description_text = UIWidget.create_definition({
		{
			value = "",
			value_id = "text",
			pass_type = "text",
			style = description_text_style
		}
	}, "description_text"),
	display_name = UIWidget.create_definition({
		{
			value = "",
			value_id = "text",
			pass_type = "text",
			style = display_name_style
		}
	}, "display_name"),
	equip_button = UIWidget.create_definition(table.clone(ButtonPassTemplates.default_button), "equip_button", {
		gamepad_action = "confirm_pressed",
		visible = false,
		original_text = Utf8.upper(Localize("loc_weapon_inventory_equip_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.weapons_equip_mark
		}
	})
}
local background = UIWidget.create_definition({
	{
		value = "content/ui/materials/backgrounds/weapon_views_background",
		pass_type = "texture",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			offset = {
				0,
				0,
				1
			},
			size = {
				1920,
				1080
			}
		}
	},
	{
		pass_type = "rect",
		style = {
			color = Color.black(255, true)
		}
	}
}, "screen")
local legend_inputs = {
	{
		input_action = "back",
		on_pressed_callback = "_cb_on_close_pressed",
		display_name = "loc_settings_menu_close_menu",
		alignment = "left_alignment"
	}
}
local animations = {
	on_enter = {
		{
			name = "fade_in",
			end_time = 0.6,
			start_time = 0,
			init = function (parent, ui_scenegraph, scenegraph_definition, widgets, parent)
				parent.animated_alpha_multiplier = 0
			end,
			update = function (parent, ui_scenegraph, scenegraph_definition, widgets, progress, parent)
				return
			end
		},
		{
			name = "move",
			end_time = 0.8,
			start_time = 0.35,
			init = function (parent, ui_scenegraph, scenegraph_definition, widgets, parent)
				return
			end,
			update = function (parent, ui_scenegraph, scenegraph_definition, widgets, progress, parent)
				local anim_progress = math.easeOutCubic(progress)
				parent.animated_alpha_multiplier = anim_progress
				local x_anim_distance_max = 50
				local x_anim_distance = x_anim_distance_max - x_anim_distance_max * anim_progress

				parent:_set_scenegraph_position("item_grid_pivot", scenegraph_definition.item_grid_pivot.position[1] - x_anim_distance)
				parent:_force_update_scenegraph()
			end
		},
		{
			name = "done",
			end_time = 0.8,
			start_time = 0.8,
			init = function (parent, ui_scenegraph, scenegraph_definition, widgets, parent)
				parent.enter_animation_done = true
			end
		}
	}
}
local always_visible_widget_names = {
	corner_bottom_right = true,
	corner_top_left = true,
	corner_top_right = true,
	corner_bottom_left = true
}

return {
	grid_settings = grid_settings,
	legend_inputs = legend_inputs,
	always_visible_widget_names = always_visible_widget_names,
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	animations = animations,
	background_widget = background
}
