local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local WalletSettings = require("scripts/settings/wallet_settings")
local MatchmakingConstants = require("scripts/settings/network/matchmaking_constants")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local PlayerProgressionUnlocks = require("scripts/settings/player/player_progression_unlocks")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local SINGLEPLAY_TYPES = MatchmakingConstants.SINGLEPLAY_TYPES
local scenegraph_definition = {
	corner_bottom_left = {
		vertical_alignment = "bottom",
		parent = "screen",
		horizontal_alignment = "left",
		size = {
			154,
			340
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
			136,
			350
		},
		position = {
			0,
			0,
			62
		}
	}
}
local widget_definitions = {
	corner_bottom_left = UIWidget.create_definition({
		{
			value = "content/ui/materials/effects/screen/horde_lower_left",
			style_id = "corner_left",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				horizontal_alignment = "left",
				scale_to_material = true,
				offset = {
					0,
					0,
					1
				},
				size = {
					154,
					340
				}
			}
		}
	}, "corner_bottom_left"),
	corner_bottom_right = UIWidget.create_definition({
		{
			value = "content/ui/materials/effects/screen/horde_lower_right",
			style_id = "corner_right",
			pass_type = "texture",
			style = {
				vertical_alignment = "bottom",
				horizontal_alignment = "right",
				scale_to_material = true,
				size = {
					136,
					350
				},
				offset = {
					0,
					0,
					1
				}
			}
		}
	}, "corner_bottom_right")
}
local input_legend_params = {}
local intro_texts = {
	description_text = "loc_training_grounds_view_intro_description",
	title_text = "loc_training_grounds_view_intro_title"
}
local list_button_base_pass_template = {
	{
		pass_type = "hotspot",
		content_id = "hotspot",
		content = {},
		style = {
			anim_hover_speed = 8,
			anim_input_speed = 8,
			anim_select_speed = 8,
			anim_focus_speed = 8,
			on_hover_sound = UISoundEvents.default_mouse_hover,
			on_pressed_sound = UISoundEvents.default_click
		}
	},
	{
		pass_type = "texture",
		style_id = "background",
		value = "content/ui/materials/backgrounds/default_square",
		style = {
			default_color = Color.terminal_background(nil, true),
			selected_color = Color.terminal_background_selected(nil, true)
		},
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		pass_type = "texture",
		style_id = "arrow_highlight",
		value = "content/ui/materials/buttons/arrow_01",
		style = {
			horizontal_alignment = "right",
			vertical_alignment = "center",
			size = {
				12,
				18
			},
			default_color = Color.terminal_icon(255, true),
			offset = {
				-30,
				0,
				5
			},
			default_offset = {
				-40,
				0,
				5
			},
			size_addition = {
				0,
				0
			},
			disabled_color = UIFontSettings.list_button.disabled_color,
			hover_color = UIFontSettings.list_button.hover_color
		},
		change_function = function (content, style)
			local hotspot = content.hotspot
			local progress = math.max(hotspot.anim_hover_progress, hotspot.anim_focus_progress)
			local size_addition = 2 * math.easeInCubic(progress)
			local style_size_addition = style.size_addition
			style_size_addition[1] = size_addition * 2
			style_size_addition[2] = size_addition * 2
			local offset = style.offset
			local default_offset = style.default_offset

			ButtonPassTemplates.list_button_label_change_function(content, style)
		end
	},
	{
		value = "content/ui/materials/patterns/diagonal_lines_pattern_01",
		pass_type = "texture",
		style = {
			offset = {
				0,
				0,
				7
			},
			color = {
				105,
				45,
				45,
				45
			}
		},
		visibility_function = function (content, style)
			return content.hotspot.disabled
		end
	},
	{
		style_id = "required_level_background",
		pass_type = "rect",
		style = {
			offset = {
				0,
				0,
				6
			},
			color = {
				150,
				35,
				0,
				0
			}
		},
		visibility_function = function (content, style)
			return content.hotspot.disabled
		end
	},
	{
		value_id = "required_level_text",
		style_id = "required_level_text",
		pass_type = "text",
		value = "",
		style = {
			text_vertical_alignment = "center",
			font_size = 22,
			horizontal_alignment = "center",
			text_horizontal_alignment = "right",
			vertical_alignment = "center",
			drop_shadow = true,
			font_type = "proxima_nova_bold",
			size_addition = {
				-100,
				-20
			},
			text_color = {
				255,
				159,
				67,
				67
			},
			offset = {
				0,
				0,
				8
			}
		},
		visibility_function = function (content, style)
			return content.hotspot.disabled
		end
	},
	{
		pass_type = "texture",
		style_id = "frame",
		value = "content/ui/materials/frames/frame_tile_2px",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			offset = {
				0,
				0,
				9
			},
			default_color = Color.terminal_frame(nil, true),
			selected_color = Color.terminal_frame_selected(nil, true),
			disabled_color = Color.ui_grey_medium(255, true),
			hover_color = Color.terminal_frame_hover(nil, true)
		},
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		pass_type = "texture",
		style_id = "corner",
		value = "content/ui/materials/frames/frame_corner_2px",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			offset = {
				0,
				0,
				10
			},
			default_color = Color.terminal_corner(nil, true),
			selected_color = Color.terminal_corner_selected(nil, true),
			disabled_color = Color.ui_grey_light(255, true),
			hover_color = Color.terminal_corner_hover(nil, true)
		},
		change_function = ButtonPassTemplates.terminal_button_change_function
	},
	{
		value = "content/ui/materials/frames/dropshadow_medium",
		style_id = "outer_shadow",
		pass_type = "texture",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			scale_to_material = true,
			color = Color.black(200, true),
			size_addition = {
				20,
				20
			},
			offset = {
				0,
				0,
				4
			}
		}
	},
	{
		pass_type = "texture",
		style_id = "background_gradient",
		value = "content/ui/materials/gradients/gradient_vertical",
		style = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			default_color = Color.terminal_frame(nil, true),
			selected_color = Color.terminal_frame_selected(nil, true),
			disabled_color = Color.ui_grey_medium(255, true),
			offset = {
				0,
				0,
				1
			}
		},
		change_function = function (content, style)
			ButtonPassTemplates.terminal_button_change_function(content, style)
			ButtonPassTemplates.terminal_button_hover_change_function(content, style)
		end
	},
	{
		style_id = "text",
		value_id = "text",
		pass_type = "text",
		value = "n/a",
		style = {
			horizontal_alignment = "center",
			font_size = 24,
			text_vertical_alignment = "center",
			text_horizontal_alignment = "left",
			vertical_alignment = "center",
			font_type = "proxima_nova_bold",
			text_color = Color.terminal_text_header(255, true),
			offset = {
				0,
				0,
				3
			},
			size_addition = {
				-100,
				0
			}
		}
	}
}
local list_button_pass_template = table.clone(list_button_base_pass_template)
list_button_pass_template[#list_button_pass_template + 1] = {
	pass_type = "texture",
	style_id = "background",
	value = "content/ui/materials/backgrounds/default_square",
	style = {
		default_color = Color.terminal_background(nil, true),
		selected_color = Color.terminal_background_selected(nil, true)
	},
	change_function = ButtonPassTemplates.terminal_button_change_function
}
local list_button_with_texture_background_pass_template = table.clone(list_button_base_pass_template)
list_button_with_texture_background_pass_template[#list_button_with_texture_background_pass_template + 1] = {
	style_id = "rect",
	pass_type = "rect",
	style = {
		color = Color.black(200, true)
	}
}
list_button_with_texture_background_pass_template[#list_button_with_texture_background_pass_template + 1] = {
	value = "content/ui/materials/frames/dropshadow_medium",
	style_id = "outer_shadow",
	pass_type = "texture",
	style = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		scale_to_material = true,
		color = Color.black(200, true),
		size_addition = {
			20,
			20
		},
		offset = {
			0,
			0,
			4
		}
	}
}
list_button_with_texture_background_pass_template[#list_button_with_texture_background_pass_template + 1] = {
	pass_type = "texture",
	style_id = "outer_highlight",
	value = "content/ui/materials/frames/dropshadow_heavy",
	style = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		scale_to_material = true,
		color = Color.terminal_text_body(200, true),
		size_addition = {
			20,
			20
		},
		offset = {
			0,
			0,
			4
		}
	},
	change_function = function (content, style, _, dt)
		local any_visible_tag_selected_last_frame = content.any_visible_tag_selected_last_frame
		local anim_speed = 2

		if anim_speed then
			local anim_highlight_progress = content.anim_highlight_progress or 0

			if not any_visible_tag_selected_last_frame then
				anim_highlight_progress = math.min(anim_highlight_progress + dt * anim_speed, 1)
			else
				anim_highlight_progress = math.max(anim_highlight_progress - dt * anim_speed, 0)
			end

			content.anim_highlight_progress = anim_highlight_progress
			local pulse_speed = 3
			local pulse_progress = 1 - (0.5 + math.sin(Application.time_since_launch() * pulse_speed) * 0.5)
			style.color[1] = (50 + 100 * pulse_progress) * anim_highlight_progress
		end
	end,
	visibility_function = function (content, style)
		return not content.hotspot.disabled
	end
}
list_button_with_texture_background_pass_template[#list_button_with_texture_background_pass_template + 1] = {
	value = "content/ui/materials/base/ui_default_base",
	style_id = "background_texture",
	pass_type = "texture_uv",
	style = {
		scale_to_material = true,
		horizontal_alignment = "right",
		vertical_alignment = "center",
		material_values = {
			texture_map = "content/ui/textures/backgrounds/group_finder/button_horde"
		},
		offset = {
			0,
			0,
			2
		},
		size_addition = {
			-50,
			0
		},
		color = {
			200,
			200,
			200,
			200
		},
		selected_color = {
			200,
			200,
			200,
			200
		},
		uvs = {
			{
				0,
				1
			},
			{
				1,
				1
			}
		}
	}
}
local button_options_definitions = {
	{
		display_name = "loc_horde_psykanium_horde_button",
		callback = function (self)
			local tab_bar_params = {
				hide_tabs = true,
				layer = 10,
				tabs_params = {
					{
						view = "horde_play_view",
						display_name = "loc_horde_play_view_title",
						input_legend_buttons = {
							{
								input_action = "hotkey_menu_special_1",
								display_name = "loc_mission_board_view_options",
								alignment = "right_alignment",
								on_pressed_callback = "_callback_open_options",
								visibility_function = function (parent, id)
									local active_view = parent._active_view

									if not active_view then
										return false
									end

									local view_instance = Managers.ui:view_instance(active_view)

									return view_instance and view_instance._missions and #view_instance._missions > 0 and not view_instance._mission_board_options and not view_instance._is_in_matchmaking
								end
							}
						}
					}
				}
			}

			self:_setup_tab_bar(tab_bar_params, nil, 1)
		end,
		button_template = {
			size = {
				nil,
				60
			},
			pass_template = {
				{
					pass_type = "hotspot",
					content_id = "hotspot",
					content = {},
					style = {
						anim_hover_speed = 8,
						anim_input_speed = 8,
						anim_select_speed = 8,
						anim_focus_speed = 8,
						on_hover_sound = UISoundEvents.default_mouse_hover,
						on_pressed_sound = UISoundEvents.default_click
					}
				},
				{
					style_id = "rect",
					pass_type = "rect",
					style = {
						color = Color.black(200, true)
					}
				},
				{
					pass_type = "texture",
					style_id = "arrow_highlight",
					value = "content/ui/materials/buttons/arrow_01",
					style = {
						horizontal_alignment = "right",
						vertical_alignment = "center",
						size = {
							12,
							18
						},
						default_color = Color.terminal_icon(255, true),
						offset = {
							-30,
							0,
							5
						},
						default_offset = {
							-40,
							0,
							5
						},
						size_addition = {
							0,
							0
						},
						disabled_color = UIFontSettings.list_button.disabled_color,
						hover_color = UIFontSettings.list_button.hover_color
					},
					change_function = function (content, style)
						local hotspot = content.hotspot
						local progress = math.max(hotspot.anim_hover_progress, hotspot.anim_focus_progress)
						local size_addition = 2 * math.easeInCubic(progress)
						local style_size_addition = style.size_addition
						style_size_addition[1] = size_addition * 2
						style_size_addition[2] = size_addition * 2
						local offset = style.offset
						local default_offset = style.default_offset

						ButtonPassTemplates.list_button_label_change_function(content, style)
					end
				},
				{
					value = "content/ui/materials/patterns/diagonal_lines_pattern_01",
					pass_type = "texture",
					style = {
						offset = {
							0,
							0,
							7
						},
						color = {
							105,
							45,
							45,
							45
						}
					},
					visibility_function = function (content, style)
						return content.hotspot.disabled
					end
				},
				{
					style_id = "required_level_background",
					pass_type = "rect",
					style = {
						offset = {
							0,
							0,
							6
						},
						color = {
							150,
							35,
							0,
							0
						}
					},
					visibility_function = function (content, style)
						return content.hotspot.disabled
					end
				},
				{
					value_id = "required_level_text",
					style_id = "required_level_text",
					pass_type = "text",
					value = "",
					style = {
						text_vertical_alignment = "center",
						font_size = 22,
						horizontal_alignment = "center",
						text_horizontal_alignment = "right",
						vertical_alignment = "center",
						drop_shadow = true,
						font_type = "proxima_nova_bold",
						size_addition = {
							-100,
							-20
						},
						text_color = {
							255,
							159,
							67,
							67
						},
						offset = {
							0,
							0,
							8
						}
					},
					visibility_function = function (content, style)
						return content.hotspot.disabled
					end
				},
				{
					pass_type = "texture",
					style_id = "frame",
					value = "content/ui/materials/frames/frame_tile_2px",
					style = {
						vertical_alignment = "center",
						horizontal_alignment = "center",
						offset = {
							0,
							0,
							9
						},
						default_color = Color.terminal_frame(nil, true),
						selected_color = Color.terminal_frame_selected(nil, true),
						disabled_color = Color.ui_grey_medium(255, true),
						hover_color = Color.terminal_frame_hover(nil, true)
					},
					change_function = ButtonPassTemplates.terminal_button_change_function
				},
				{
					pass_type = "texture",
					style_id = "corner",
					value = "content/ui/materials/frames/frame_corner_2px",
					style = {
						vertical_alignment = "center",
						horizontal_alignment = "center",
						offset = {
							0,
							0,
							10
						},
						default_color = Color.terminal_corner(nil, true),
						selected_color = Color.terminal_corner_selected(nil, true),
						disabled_color = Color.ui_grey_light(255, true),
						hover_color = Color.terminal_corner_hover(nil, true)
					},
					change_function = ButtonPassTemplates.terminal_button_change_function
				},
				{
					value = "content/ui/materials/frames/dropshadow_medium",
					style_id = "outer_shadow",
					pass_type = "texture",
					style = {
						vertical_alignment = "center",
						horizontal_alignment = "center",
						scale_to_material = true,
						color = Color.black(200, true),
						size_addition = {
							20,
							20
						},
						offset = {
							0,
							0,
							4
						}
					}
				},
				{
					pass_type = "texture",
					style_id = "outer_highlight",
					value = "content/ui/materials/frames/dropshadow_heavy",
					style = {
						vertical_alignment = "center",
						horizontal_alignment = "center",
						scale_to_material = true,
						color = Color.terminal_text_body(200, true),
						size_addition = {
							20,
							20
						},
						offset = {
							0,
							0,
							4
						}
					},
					change_function = function (content, style, _, dt)
						local any_visible_tag_selected_last_frame = content.any_visible_tag_selected_last_frame
						local anim_speed = 2

						if anim_speed then
							local anim_highlight_progress = content.anim_highlight_progress or 0

							if not any_visible_tag_selected_last_frame then
								anim_highlight_progress = math.min(anim_highlight_progress + dt * anim_speed, 1)
							else
								anim_highlight_progress = math.max(anim_highlight_progress - dt * anim_speed, 0)
							end

							content.anim_highlight_progress = anim_highlight_progress
							local pulse_speed = 3
							local pulse_progress = 1 - (0.5 + math.sin(Application.time_since_launch() * pulse_speed) * 0.5)
							style.color[1] = (50 + 100 * pulse_progress) * anim_highlight_progress
						end
					end,
					visibility_function = function (content, style)
						return not content.hotspot.disabled
					end
				},
				{
					pass_type = "texture",
					style_id = "background_gradient",
					value = "content/ui/materials/gradients/gradient_vertical",
					style = {
						vertical_alignment = "center",
						horizontal_alignment = "center",
						default_color = Color.terminal_frame(nil, true),
						selected_color = Color.terminal_frame_selected(nil, true),
						disabled_color = Color.ui_grey_medium(255, true),
						offset = {
							0,
							0,
							1
						}
					},
					change_function = function (content, style)
						ButtonPassTemplates.terminal_button_change_function(content, style)
						ButtonPassTemplates.terminal_button_hover_change_function(content, style)
					end
				},
				{
					style_id = "text",
					value_id = "text",
					pass_type = "text",
					value = "n/a",
					style = {
						horizontal_alignment = "center",
						font_size = 28,
						text_vertical_alignment = "center",
						text_horizontal_alignment = "left",
						vertical_alignment = "center",
						font_type = "proxima_nova_bold",
						text_color = Color.terminal_text_header(255, true),
						offset = {
							0,
							0,
							3
						},
						size_addition = {
							-100,
							0
						}
					}
				},
				{
					value = "content/ui/materials/base/ui_default_base",
					style_id = "background_texture",
					pass_type = "texture_uv",
					style = {
						scale_to_material = true,
						horizontal_alignment = "right",
						vertical_alignment = "center",
						material_values = {
							texture_map = "content/ui/textures/backgrounds/group_finder/button_horde"
						},
						offset = {
							0,
							0,
							2
						},
						size_addition = {
							-50,
							0
						},
						color = {
							200,
							200,
							200,
							200
						},
						selected_color = {
							200,
							200,
							200,
							200
						},
						uvs = {
							{
								0,
								1
							},
							{
								1,
								1
							}
						}
					}
				}
			},
			init = function (parent, widget, element, callback_function)
				local style = widget.style
				local content = widget.content
				content.text = Localize("loc_horde_psykanium_horde_button")
				local game_mode_data = Managers.data_service.mission_board:get_game_modes_progression_data()
				local game_mode_progression = game_mode_data and game_mode_data.hordes
				local locked = game_mode_progression and not game_mode_progression.unlocked or not game_mode_progression
				content.level_requirement_met = not locked

				if not Managers.narrative:is_chapter_complete("onboarding", "play_training") then
					content.hotspot.disabled = true
				elseif not content.level_requirement_met then
					content.hotspot.disabled = true
					content.required_level_text = Localize("loc_requires_player_journey_progress")
				else
					content.hotspot.pressed_callback = callback_function
				end

				local background_texture_style = style.background_texture
				local image_width = 575
				local image_height = 120
				local element_width = 100
				local element_height = 100
				local uvs = background_texture_style.uvs
				uvs[1][2] = (image_width - element_width) * 0.5 / image_width
				uvs[2][2] = 1 - (image_height - element_height) * 0.5 / image_height
			end
		}
	},
	{
		spacing = 20,
		display_name = "loc_basic_training_title",
		callback = function (self)
			local tab_bar_params = {
				hide_tabs = true,
				layer = 10,
				tabs_params = {
					{
						view = "training_grounds_options_view",
						display_name = "loc_training_grounds_view_display_name",
						context = {
							training_grounds_settings = "basic",
							mechanism_context = {
								mission_name = "om_basic_combat_01",
								init_scenario = {
									alias = "training_grounds",
									name = "basic_training"
								},
								singleplay_type = SINGLEPLAY_TYPES.training_grounds
							}
						}
					}
				}
			}

			self:_setup_tab_bar(tab_bar_params)
		end,
		button_template = {
			pass_template = list_button_pass_template,
			init = function (parent, widget, element, callback_function)
				local style = widget.style
				local content = widget.content
				content.text = Localize("loc_basic_training_title")
				content.hotspot.pressed_callback = callback_function
			end
		}
	},
	{
		display_name = "loc_advanced_training_title",
		callback = function (self)
			local tab_bar_params = {
				hide_tabs = true,
				layer = 10,
				tabs_params = {
					{
						view = "training_grounds_options_view",
						display_name = "loc_training_grounds_view_display_name",
						context = {
							training_grounds_settings = "advanced",
							mechanism_context = {
								mission_name = "om_basic_combat_01",
								init_scenario = {
									alias = "training_grounds",
									name = "advanced_training"
								},
								singleplay_type = SINGLEPLAY_TYPES.training_grounds
							}
						}
					}
				}
			}

			self:_setup_tab_bar(tab_bar_params)
		end,
		button_template = {
			pass_template = list_button_pass_template,
			init = function (parent, widget, element, callback_function)
				local style = widget.style
				local content = widget.content
				content.text = Localize("loc_advanced_training_title")

				if not Managers.narrative:is_chapter_complete("onboarding", "play_training") then
					content.hotspot.disabled = true
				else
					content.hotspot.pressed_callback = callback_function
				end
			end
		}
	},
	{
		display_name = "loc_training_grounds_view_shooting_range_text",
		callback = function (self)
			local tab_bar_params = {
				hide_tabs = true,
				layer = 10,
				tabs_params = {
					{
						view = "training_grounds_options_view",
						display_name = "loc_training_grounds_view_display_name",
						context = {
							training_grounds_settings = "shooting_range",
							mechanism_context = {
								mission_name = "tg_shooting_range",
								singleplay_type = SINGLEPLAY_TYPES.training_grounds
							}
						}
					}
				}
			}

			self:_setup_tab_bar(tab_bar_params)
		end,
		button_template = {
			pass_template = list_button_pass_template,
			init = function (parent, widget, element, callback_function)
				local style = widget.style
				local content = widget.content
				content.text = Localize("loc_training_grounds_view_shooting_range_text")
				local player = Managers.player:local_player(1)
				local profile = player:profile()
				local player_level = profile.current_level
				local shooting_range_min_level = PlayerProgressionUnlocks.shooting_range
				content.level_requirement_met = shooting_range_min_level <= player_level

				if not Managers.narrative:is_chapter_complete("onboarding", "play_training") then
					content.hotspot.disabled = true
				elseif not content.level_requirement_met then
					local required_level = shooting_range_min_level
					content.hotspot.disabled = true
					content.required_level_text = Localize("loc_requires_level", true, {
						level = shooting_range_min_level
					})
				else
					content.hotspot.pressed_callback = callback_function
				end
			end
		}
	}
}
local background_world_params = {
	shading_environment = "content/shading_environments/ui/training_grounds",
	world_layer = 1,
	total_blur_duration = 0.5,
	timer_name = "ui",
	viewport_type = "default",
	register_camera_event = "event_register_training_grounds_camera",
	viewport_name = "ui_training_grounds_world_viewport",
	viewport_layer = 1,
	level_name = "content/levels/ui/training_grounds/training_grounds",
	world_name = "ui_training_grounds_world"
}

return {
	intro_texts = intro_texts,
	widget_definitions = widget_definitions,
	scenegraph_definition = scenegraph_definition,
	button_options_definitions = button_options_definitions,
	input_legend_params = input_legend_params,
	background_world_params = background_world_params
}
