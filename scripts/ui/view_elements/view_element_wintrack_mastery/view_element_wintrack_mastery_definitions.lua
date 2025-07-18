local ScrollbarPassTemplates = require("scripts/ui/pass_templates/scrollbar_pass_templates")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local ViewElementWintrackSettings = require("scripts/ui/view_elements/view_element_wintrack/view_element_wintrack_settings")
local rating_text_style = table.clone(UIFontSettings.body_small)
rating_text_style.text_horizontal_alignment = "right"
rating_text_style.text_vertical_alignment = "center"
rating_text_style.text_color = Color.white(255, true)
rating_text_style.font_size = 30
rating_text_style.offset = {
	-10,
	0,
	300
}
rating_text_style.material = "content/ui/materials/font_gradients/slug_font_gradient_item_level"
local rating_header_text_style = table.clone(UIFontSettings.body_small)
rating_header_text_style.text_horizontal_alignment = "right"
rating_header_text_style.text_vertical_alignment = "center"
rating_header_text_style.text_color = Color.terminal_text_body(255, true)
rating_header_text_style.font_size = 17
rating_header_text_style.size = {
	nil,
	18
}
rating_header_text_style.offset = {
	-112,
	3,
	300
}
local mark_display_name_text_style = table.clone(UIFontSettings.header_3)
mark_display_name_text_style.text_vertical_alignment = "top"
mark_display_name_text_style.vertical_alignment = "top"
mark_display_name_text_style.horizontal_alignment = "center"
mark_display_name_text_style.text_horizontal_alignment = "center"
mark_display_name_text_style.size_addition = {
	-40
}
mark_display_name_text_style.offset = {
	20,
	0,
	6
}
mark_display_name_text_style.font_size = 24
mark_display_name_text_style.text_color = Color.terminal_text_header(255, true)
local bar_size = {
	1300,
	17
}
local reward_field_size = {
	bar_size[1] + 300,
	198
}
local item_size = ViewElementWintrackSettings.item_size
local reward_size = {
	155,
	186
}
local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
	pivot = {
		vertical_alignment = "top",
		parent = "screen",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	reward_field = {
		vertical_alignment = "bottom",
		parent = "pivot",
		horizontal_alignment = "center",
		size = reward_field_size,
		position = {
			0,
			-95,
			2
		}
	},
	experience_bar_frame = {
		vertical_alignment = "bottom",
		parent = "reward_field",
		horizontal_alignment = "center",
		size = {
			1420,
			34
		},
		position = {
			0,
			-10,
			3
		}
	},
	reward_progress_bar = {
		vertical_alignment = "bottom",
		parent = "reward_field",
		horizontal_alignment = "center",
		size = bar_size,
		position = {
			0,
			-22,
			6
		}
	},
	experience_progress_bar = {
		vertical_alignment = "bottom",
		parent = "reward_field",
		horizontal_alignment = "center",
		size = bar_size,
		position = {
			0,
			-22,
			5
		}
	},
	reward_mask = {
		vertical_alignment = "bottom",
		parent = "reward_progress_bar",
		horizontal_alignment = "center",
		size = {
			bar_size[1] + 50,
			reward_size[2] + 150
		},
		position = {
			0,
			50,
			1
		}
	},
	reward = {
		vertical_alignment = "bottom",
		parent = "reward_progress_bar",
		horizontal_alignment = "left",
		size = reward_size,
		position = {
			0,
			5,
			10
		}
	},
	reward_item = {
		vertical_alignment = "center",
		parent = "reward",
		horizontal_alignment = "center",
		size = item_size,
		position = {
			0,
			-10,
			3
		}
	},
	claim_button = {
		vertical_alignment = "bottom",
		parent = "reward_field",
		horizontal_alignment = "left",
		size = {
			232,
			52
		},
		position = {
			9,
			-6,
			33
		}
	},
	page_thumb_indicator = {
		vertical_alignment = "bottom",
		parent = "reward_progress_bar",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			30,
			15
		}
	},
	navigation_arrow_left = {
		vertical_alignment = "center",
		parent = "page_thumb_indicator",
		horizontal_alignment = "left",
		size = {
			35,
			35
		},
		position = {
			-80,
			0,
			30
		}
	},
	navigation_arrow_right = {
		vertical_alignment = "center",
		parent = "page_thumb_indicator",
		horizontal_alignment = "right",
		size = {
			35,
			35
		},
		position = {
			80,
			0,
			30
		}
	},
	item_stats_pivot = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			170,
			1
		}
	},
	reward_input_description = {
		vertical_alignment = "bottom",
		parent = "item_stats_pivot",
		horizontal_alignment = "center",
		size = {
			800,
			40
		},
		position = {
			0,
			75,
			1
		}
	},
	tooltip = {
		vertical_alignment = "bottom",
		parent = "pivot",
		horizontal_alignment = "center",
		size = {
			700,
			200
		},
		position = {
			0,
			-330,
			50
		}
	}
}
local widget_definitions = {
	reward_input_description = UIWidget.create_definition({
		{
			value_id = "text",
			pass_type = "text",
			style_id = "text",
			value = "",
			style = {
				font_type = "proxima_nova_bold",
				font_size = 28,
				drop_shadow = true,
				text_vertical_alignment = "center",
				text_horizontal_alignment = "center",
				text_color = Color.terminal_text_body(nil, true),
				offset = {
					0,
					0,
					1
				}
			}
		}
	}, "reward_input_description"),
	navigation_arrow_left = UIWidget.create_definition({
		{
			pass_type = "hotspot",
			content_id = "hotspot"
		},
		{
			value_id = "arrow",
			style_id = "arrow",
			pass_type = "texture_uv",
			value = "content/ui/materials/buttons/premium_store_button_next_page",
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
			},
			visibility_function = function (content, style)
				local hotspot = content.hotspot

				return not hotspot.is_selected and not hotspot.is_hover and not hotspot.is_focused
			end
		},
		{
			value_id = "arrow_active",
			style_id = "arrow_active",
			pass_type = "texture_uv",
			value = "content/ui/materials/buttons/premium_store_button_next_page_hover",
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
			},
			visibility_function = function (content, style)
				local hotspot = content.hotspot

				return hotspot.is_selected or hotspot.is_hover or hotspot.is_focused
			end
		}
	}, "navigation_arrow_left"),
	navigation_arrow_right = UIWidget.create_definition({
		{
			pass_type = "hotspot",
			content_id = "hotspot"
		},
		{
			value_id = "arrow",
			style_id = "arrow",
			pass_type = "texture",
			value = "content/ui/materials/buttons/premium_store_button_next_page",
			visibility_function = function (content, style)
				local hotspot = content.hotspot

				return not hotspot.is_selected and not hotspot.is_hover and not hotspot.is_focused
			end
		},
		{
			value_id = "arrow_active",
			style_id = "arrow_active",
			pass_type = "texture",
			value = "content/ui/materials/buttons/premium_store_button_next_page_hover",
			visibility_function = function (content, style)
				local hotspot = content.hotspot

				return hotspot.is_selected or hotspot.is_hover or hotspot.is_focused
			end
		}
	}, "navigation_arrow_right"),
	reward_field = UIWidget.create_definition({
		{
			value = "content/ui/materials/frames/achievements/wintrack_frame_background",
			style_id = "bg",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				size = {
					1286,
					146
				},
				offset = {
					0,
					-35,
					0
				},
				material_values = {
					texture_map = "content/ui/textures/frames/mastery_tree/wintrack_frame_background"
				}
			}
		}
	}, "reward_field"),
	experience_bar_frame = UIWidget.create_definition({
		{
			value = "content/ui/materials/frames/mastery_tree/wintrack_frame_progress_bar_holder",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				offset = {
					0,
					0,
					1
				},
				color = Color.white(255, true)
			}
		},
		{
			pass_type = "rect",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				size = {
					nil,
					15
				},
				color = Color.black(255, true),
				offset = {
					0,
					-3,
					-3
				}
			}
		}
	}, "experience_bar_frame"),
	experience_progress_bar = UIWidget.create_definition({
		{
			value = "content/ui/materials/bars/exp_fill",
			style_id = "bar",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				color = Color.terminal_text_body_sub_header(255, true),
				size = {
					0
				},
				size_addition = {
					0,
					-4
				},
				offset = {
					0,
					0,
					0
				},
				material_values = {
					progress = 1
				}
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_heavy",
			style_id = "outer_glow",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				scale_to_material = true,
				size = {
					0
				},
				offset = {
					-10,
					1,
					0
				},
				color = Color.terminal_text_body_sub_header(0, true),
				size_addition = {
					20,
					14
				}
			}
		}
	}, "experience_progress_bar"),
	reward_progress_bar = UIWidget.create_definition({
		{
			value = "content/ui/materials/bars/exp_fill",
			style_id = "bar",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				color = Color.terminal_corner_selected(255, true),
				size = {
					0
				},
				size_addition = {
					0,
					-4
				},
				offset = {
					0,
					0,
					0
				},
				material_values = {
					progress = 1
				}
			}
		},
		{
			value = "content/ui/materials/frames/dropshadow_heavy",
			style_id = "outer_glow",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				scale_to_material = true,
				size = {
					0
				},
				offset = {
					-10,
					1,
					0
				},
				color = Color.terminal_text_key_value(0, true),
				size_addition = {
					20,
					14
				}
			}
		}
	}, "reward_progress_bar"),
	tooltip = UIWidget.create_definition({
		{
			style_id = "background",
			pass_type = "rect",
			style = {
				horizontal_alignment = "center",
				vertical_alignment = "center",
				color = Color.black(150, true),
				size_addition = {
					20,
					20
				}
			}
		},
		{
			value = "content/ui/materials/backgrounds/terminal_basic",
			value_id = "background",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				scale_to_material = true,
				horizontal_alignment = "center",
				color = Color.terminal_grid_background(255, true),
				offset = {
					0,
					0,
					0
				},
				size_addition = {
					40,
					40
				}
			}
		},
		{
			value_id = "description",
			pass_type = "text",
			style_id = "description",
			value = "",
			style = {
				vertical_alignment = "top",
				text_vertical_alignment = "top",
				horizontal_alignment = "left",
				text_horizontal_alignment = "center",
				text_color = Color.white(255, true),
				size_addition = {
					-40,
					0
				},
				offset = {
					20,
					0,
					2
				}
			}
		},
		{
			value_id = "title",
			style_id = "title",
			pass_type = "text",
			value = "",
			style = mark_display_name_text_style
		},
		{
			value_id = "icon",
			pass_type = "texture",
			style_id = "icon",
			style = {
				vertical_alignment = "top",
				horizontal_alignment = "center",
				unlock_color = Color.terminal_text_key_value(255, true),
				locked_color = Color.white(100, true),
				default_color = Color.white(255, true),
				color = Color.white(255, true),
				offset = {
					0,
					20,
					5
				}
			},
			visibility_function = function (content, style)
				return not not content.icon
			end
		}
	}, "tooltip", {
		visible = false
	})
}
local page_thumb_size = ViewElementWintrackSettings.page_thumb_size
local page_thumb_widget_definition = UIWidget.create_definition({
	{
		pass_type = "rect",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			color = Color.terminal_frame(nil, true),
			size = page_thumb_size,
			offset = {
				0,
				0,
				0
			}
		}
	},
	{
		pass_type = "rect",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			color = Color.terminal_icon(255, true),
			size = page_thumb_size,
			offset = {
				0,
				0,
				1
			}
		},
		visibility_function = function (content, style)
			return content.active
		end
	},
	{
		value = "content/ui/materials/frames/frame_glow_01",
		pass_type = "texture",
		style = {
			vertical_alignment = "center",
			scale_to_material = true,
			horizontal_alignment = "center",
			color = Color.terminal_icon(150, true),
			size = page_thumb_size,
			offset = {
				0,
				0,
				1
			},
			size_addition = {
				24,
				24
			}
		},
		visibility_function = function (content, style)
			return content.active
		end
	}
}, "page_thumb_indicator")
local reward_base_pass_template = {
	{
		style_id = "hotspot",
		pass_type = "hotspot",
		content_id = "hotspot",
		content = {},
		style = {
			anim_select_speed = 4
		}
	},
	{
		style_id = "claim_icon_glow",
		pass_type = "texture",
		value = "content/ui/materials/frames/achievements/wintrack_claimed_reward_display_background_glow",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size_addition = {
				140,
				140
			},
			color = Color.ui_terminal(255, true),
			offset = {
				0,
				-10,
				0
			}
		},
		visibility_function = function (content, style)
			return content.can_claim and not content.claimed
		end
	},
	{
		pass_type = "texture",
		style_id = "frame",
		value = "content/ui/materials/buttons/mastery_tree/wintrack_reward_holder",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			offset = {
				0,
				-2,
				1
			},
			material_values = {
				background_intensity = 0
			}
		},
		change_function = function (content, style)
			if content.claimed then
				style.material_values.background_intensity = -0.12
			else
				style.material_values.background_intensity = 0
			end
		end
	},
	{
		pass_type = "texture",
		value = "content/ui/materials/icons/generic/top_right_triangle",
		style = {
			vertical_alignment = "top",
			horizontal_alignment = "right",
			size = {
				40,
				40
			},
			color = Color.terminal_frame_selected(255, true),
			default_color = Color.terminal_frame(180, true),
			selected_color = Color.terminal_frame_selected(180, true),
			disabled_color = Color.ui_grey_medium(180, true),
			hover_color = Color.terminal_frame_hover(180, true),
			offset = {
				-22,
				30,
				24
			}
		},
		visibility_function = function (content, style)
			return content.claimed
		end,
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		pass_type = "text",
		value = "",
		style_id = "complete_sign",
		style = {
			font_size = 22,
			text_horizontal_alignment = "right",
			text_vertical_alignment = "top",
			font_type = "proxima_nova_bold",
			text_color = Color.white(255, true),
			default_color = Color.ui_terminal(nil, true),
			selected_color = Color.white(nil, true),
			disabled_color = Color.ui_grey_light(255, true),
			hover_color = Color.ui_terminal(nil, true),
			offset = {
				-26,
				29,
				25
			}
		},
		visibility_function = function (content, style)
			return content.claimed
		end,
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		style_id = "completed_gradient",
		pass_type = "texture",
		value = "content/ui/materials/gradients/gradient_vertical",
		style = {
			vertical_alignment = "bottom",
			horizontal_alignment = "center",
			size = {
				110,
				110
			},
			offset = {
				0,
				-48,
				2
			},
			color = Color.terminal_frame_selected(200, true)
		},
		visibility_function = function (content, style)
			return content.claimed
		end
	},
	{
		style_id = "reward_count_bg",
		pass_type = "texture",
		value = "content/ui/materials/gradients/gradient_horizontal",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			color = {
				255,
				0,
				0,
				0
			},
			size = {
				60,
				30
			},
			offset = {
				26,
				32,
				20
			}
		},
		visibility_function = function (content, style)
			return content.reward_count ~= ""
		end
	},
	{
		pass_type = "texture",
		value = "content/ui/materials/base/ui_default_base",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			size = {
				155,
				186
			},
			default_color = Color.terminal_frame(180, true),
			selected_color = Color.terminal_frame_selected(180, true),
			disabled_color = Color.ui_grey_medium(180, true),
			hover_color = Color.terminal_corner_hover(180, true),
			color = Color.terminal_completed(180, true),
			offset = {
				0,
				0,
				1
			},
			material_values = {
				texture_map = "content/ui/textures/buttons/mastery_tree/wintrack_reward_holder_mask_inner"
			}
		},
		visibility_function = function (content, style)
			return content.hotspot.is_hover or content.hotspot.is_selected
		end,
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		value_id = "reward_count",
		pass_type = "text",
		style_id = "reward_count",
		value = "",
		style = {
			font_type = "proxima_nova_bold",
			font_size = 20,
			drop_shadow = true,
			text_vertical_alignment = "center",
			text_horizontal_alignment = "right",
			text_color = Color.terminal_text_key_value(nil, true),
			offset = {
				-30,
				31,
				25
			}
		}
	},
	{
		value_id = "required_points",
		style_id = "required_points",
		pass_type = "text",
		value = "00000",
		style = {
			font_type = "proxima_nova_bold",
			font_size = 16,
			text_vertical_alignment = "bottom",
			text_horizontal_alignment = "center",
			text_color = Color.terminal_text_header(255, true),
			offset = {
				0,
				-24,
				25
			}
		}
	}
}
local claim_button_pass_template = table.clone(ButtonPassTemplates.terminal_button)
claim_button_pass_template[#claim_button_pass_template + 1] = {
	style_id = "button_attention",
	pass_type = "texture",
	value = "content/ui/materials/effects/button_attention",
	style = {
		vertical_alignment = "center",
		play_pulse = false,
		scale_to_material = true,
		horizontal_alignment = "center",
		color = Color.terminal_frame_hover(0, true),
		offset = {
			0,
			0,
			2
		},
		material_values = {
			intensity = 0
		}
	},
	visibility_function = function (content, style)
		return style.play_pulse
	end
}
claim_button_pass_template[#claim_button_pass_template + 1] = {
	pass_type = "texture",
	value = "content/ui/materials/frames/inner_shadow_sharp",
	style_id = "inner_frame_glow",
	style = {
		vertical_alignment = "center",
		play_pulse = false,
		scale_to_material = true,
		horizontal_alignment = "center",
		color = Color.terminal_corner_hover(255, true),
		offset = {
			0,
			0,
			2
		}
	},
	visibility_function = function (content, style)
		return style.play_pulse
	end,
	change_function = function (content, style)
		local alpha = 0

		if style.play_pulse then
			local speed = 0.8
			local pulse_progress = Application.time_since_launch() * speed % 1
			local pulse_anim_progress = (pulse_progress * 2 - 1)^2
			local alpha_multiplier = 0.6 + pulse_anim_progress * 0.4
			alpha = 255 * alpha_multiplier
		end

		style.color[1] = alpha
	end
}
local front_widget_definitions = {
	reward_field_2 = UIWidget.create_definition({
		{
			style_id = "corner_left",
			pass_type = "texture",
			value = "content/ui/materials/frames/mastery_tree/wintrack_frame_corner_left",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				size = {
					276,
					228
				},
				offset = {
					-21,
					9,
					30
				}
			},
			visibility_function = function (content, style)
				return not content.read_only
			end
		},
		{
			value = "content/ui/materials/effects/mastery_tree/wintrack_frame_corner_left_candles",
			style_id = "corner_left",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				size = {
					276,
					228
				},
				offset = {
					0,
					16,
					31
				}
			}
		},
		{
			value = "content/ui/materials/frames/mastery_tree/wintrack_frame_corner_right",
			style_id = "corner_right",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				size = {
					260,
					228
				},
				offset = {
					0,
					17,
					30
				}
			}
		},
		{
			style_id = "corner_left_read_only",
			pass_type = "texture",
			value = "content/ui/materials/frames/mastery_tree/wintrack_frame_corner_left",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				size = {
					276,
					228
				},
				offset = {
					0,
					17,
					30
				}
			},
			visibility_function = function (content, style)
				return content.read_only
			end
		}
	}, "reward_field"),
	claim_button = UIWidget.create_definition(claim_button_pass_template, "claim_button", {
		gamepad_action = "hotkey_menu_special_2",
		original_text = Utf8.upper(Localize("loc_penance_menu_claim_button")),
		hotspot = {
			on_pressed_sound = UISoundEvents.default_click
		}
	}, nil, {
		text = {
			font_size = 22,
			line_spacing = 0.8,
			offset = {
				10,
				0,
				6
			},
			size_addition = {
				-20,
				0
			}
		}
	})
}
local animations = {
	on_points_added = {
		{
			name = "in",
			end_time = 0.3,
			start_time = 0,
			init = function (parent, ui_scenegraph, scenegraph_definition, widgets, params)
				return
			end,
			update = function (parent, ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_progress = math.ease_in_exp(progress)
				widgets.experience_progress_bar.style.outer_glow.color[1] = anim_progress * 200

				if not params.anim_only_experience_bar then
					widgets.reward_progress_bar.style.outer_glow.color[1] = anim_progress * 200
				end
			end
		},
		{
			name = "out",
			end_time = 1.9,
			start_time = 1.2,
			init = function (parent, ui_scenegraph, scenegraph_definition, widgets, params)
				return
			end,
			update = function (parent, ui_scenegraph, scenegraph_definition, widgets, progress, params)
				local anim_progress = math.ease_in_exp(1 - progress)
				widgets.experience_progress_bar.style.outer_glow.color[1] = anim_progress * 200

				if not params.anim_only_experience_bar then
					widgets.reward_progress_bar.style.outer_glow.color[1] = anim_progress * 200
				end
			end
		}
	},
	activate_claim_button = {
		{
			name = "fade_in",
			end_time = 0.2,
			start_time = 0,
			init = function (parent, ui_scenegraph, _scenegraph_definition, widgets, progress, params)
				widgets.claim_button.style.inner_frame_glow.play_pulse = true
				widgets.claim_button.style.button_attention.play_pulse = true
			end,
			update = function (parent, ui_scenegraph, _scenegraph_definition, widgets, progress, params)
				widgets.claim_button.style.button_attention.color[1] = 255 * progress
			end
		},
		{
			name = "intensity",
			end_time = 1,
			start_time = 0,
			update = function (parent, ui_scenegraph, _scenegraph_definition, widgets, progress, params)
				widgets.claim_button.style.button_attention.material_values.intensity = 1 - math.ease_sine(progress)
			end
		},
		{
			name = "fade_out",
			end_time = 2,
			start_time = 0.8,
			update = function (parent, ui_scenegraph, _scenegraph_definition, widgets, progress, params)
				widgets.claim_button.style.button_attention.color[1] = 255 - 255 * math.easeOutCubic(progress)
			end
		}
	},
	deactivate_claim_button = {
		{
			name = "disable_pulse",
			end_time = 0.1,
			start_time = 0,
			init = function (parent, ui_scenegraph, _scenegraph_definition, widgets, progress, params)
				widgets.claim_button.style.inner_frame_glow.play_pulse = false
				widgets.claim_button.style.button_attention.play_pulse = true
			end
		}
	}
}

return {
	animations = animations,
	reward_base_pass_template = reward_base_pass_template,
	page_thumb_widget_definition = page_thumb_widget_definition,
	widget_definitions = widget_definitions,
	front_widget_definitions = front_widget_definitions,
	scenegraph_definition = scenegraph_definition
}
