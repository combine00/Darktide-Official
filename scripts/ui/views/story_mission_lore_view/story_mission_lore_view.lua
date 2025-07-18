local StoryMissionLoreViewDefinitions = require("scripts/ui/views/story_mission_lore_view/story_mission_lore_view_definitions")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local ViewElementGrid = require("scripts/ui/view_elements/view_element_grid/view_element_grid")
local StoryMissionLoreView = class("StoryMissionLoreView", "BaseView")

function StoryMissionLoreView:init(settings, context)
	StoryMissionLoreView.super.init(self, StoryMissionLoreViewDefinitions, settings, context)

	self._pass_input = true
	self._pass_draw = true
end

function StoryMissionLoreView:on_enter()
	StoryMissionLoreView.super.on_enter(self)
	self:_setup_lore_grid()

	self._widgets_by_name.trailer_button.content.hotspot.pressed_callback = callback(self, "_cb_on_trailer_button_pressed")
	self._enter_animation_id = self:_start_animation("on_enter", self._widgets_by_name, self)
end

function StoryMissionLoreView:_handle_input(input_service, dt, t)
	local gamepad_action = self._widgets_by_name.trailer_button.content.gamepad_action

	if gamepad_action and not Managers.ui:using_cursor_navigation() and input_service:get(gamepad_action) then
		self:_cb_on_trailer_button_pressed()
	end
end

function StoryMissionLoreView:draw(dt, t, input_service, layer)
	local render_settings = self._render_settings
	local alpha_multiplier = render_settings.alpha_multiplier
	local animation_alpha_multiplier = self.animation_alpha_multiplier or 0
	render_settings.alpha_multiplier = animation_alpha_multiplier

	StoryMissionLoreView.super.draw(self, dt, t, input_service, layer)

	render_settings.alpha_multiplier = alpha_multiplier
end

function StoryMissionLoreView:on_resolution_modified(scale)
	StoryMissionLoreView.super.on_resolution_modified(self, scale)
end

function StoryMissionLoreView:on_back_pressed()
	Managers.event:trigger("event_select_story_mission_background_option", 2)

	return true
end

function StoryMissionLoreView:_cb_on_trailer_button_pressed()
	if Managers.ui:view_active("video_view") then
		return
	end

	self:_play_sound(UISoundEvents.story_mission_lore_screen_play_video)
	Managers.ui:open_view("video_view", nil, nil, nil, nil, {
		template = "s1_intro",
		allow_skip_input = true
	})
end

function StoryMissionLoreView:update(dt, t, input_service)
	return StoryMissionLoreView.super.update(self, dt, t, input_service)
end

function StoryMissionLoreView:on_exit()
	if self._enter_animation_id then
		self:_stop_animation(self._enter_animation_id)

		self._enter_animation_id = nil
	end

	StoryMissionLoreView.super.on_exit(self)
end

function StoryMissionLoreView:ui_renderer()
	return self._ui_renderer
end

function StoryMissionLoreView:_setup_lore_grid()
	local definitions = self._definitions

	if not self._lore_grid then
		local grid_scenegraph_id = "lore_grid"
		local scenegraph_definition = definitions.scenegraph_definition
		local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
		local grid_size = grid_scenegraph.size
		local mask_padding_size = 0
		local grid_settings = {
			scrollbar_width = 7,
			hide_dividers = true,
			widget_icon_load_margin = 0,
			enable_gamepad_scrolling = true,
			title_height = 0,
			scrollbar_horizontal_offset = 25,
			hide_background = true,
			grid_spacing = {
				0,
				0
			},
			grid_size = grid_size,
			mask_size = {
				grid_size[1] + 20,
				grid_size[2] + mask_padding_size
			}
		}
		local layer = (self._draw_layer or 0) + 10
		self._lore_grid = self:_add_element(ViewElementGrid, "lore_grid", layer, grid_settings, grid_scenegraph_id)

		self:_update_element_position("lore_grid", self._lore_grid)
		self._lore_grid:set_empty_message("")
	end

	local grid = self._lore_grid
	local layout = {
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				25
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_1")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				50
			}
		},
		[#layout + 1] = {
			widget_type = "body_centered",
			text = Localize("loc_story_mission_lore_menu_body_text_2"),
			text_color = Color.terminal_text_body(255, true)
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				40
			}
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				25
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_3")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				50
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_4")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				50
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_5")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				50
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_6")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				10
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_7")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				10
			}
		},
		[#layout + 1] = {
			widget_type = "body",
			text = Localize("loc_story_mission_lore_menu_body_text_8")
		},
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				500,
				25
			}
		}
	}

	grid:present_grid_layout(layout, StoryMissionLoreViewDefinitions.grid_blueprints)
	grid:set_handle_grid_navigation(true)
end

return StoryMissionLoreView
