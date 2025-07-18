local GroupFinderViewDefinitions = require("scripts/ui/views/group_finder_view/group_finder_view_definitions")
local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local CircumstanceTemplates = require("scripts/settings/circumstance/circumstance_templates")
local MissionTemplates = require("scripts/settings/mission/mission_templates")
local PlayerCompositions = require("scripts/utilities/players/player_compositions")
local ProfileUtils = require("scripts/utilities/profile_utils")
local Promise = require("scripts/foundation/utilities/promise")
local PromiseContainer = require("scripts/utilities/ui/promise_container")
local RegionLocalizationMappings = require("scripts/settings/backend/region_localization")
local TextUtilities = require("scripts/utilities/ui/text")
local TextUtils = require("scripts/utilities/ui/text")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWorldSpawner = require("scripts/managers/ui/ui_world_spawner")
local ViewElementGrid = require("scripts/ui/view_elements/view_element_grid/view_element_grid")
local ViewElementInputLegend = require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local ViewElementMissionBoardOptions = require("scripts/ui/view_elements/view_element_mission_board_options/view_element_mission_board_options")
local GroupFinderView = class("GroupFinderView", "BaseView")
local STATE = table.enum("idle", "fetching_tags", "browsing", "advertising")
local settings_by_category = {
	start_group = {
		text = Localize("loc_group_finder_category_start_group")
	},
	game_mode = {
		description_sort_order = 3,
		text = Localize("loc_group_finder_category_game_mode")
	},
	difficulty = {
		description_sort_order = 4,
		text = Localize("loc_group_finder_category_difficulty")
	},
	language = {
		description_sort_order = 1,
		text = Localize("loc_group_finder_category_language")
	},
	key_words = {
		description_sort_order = 2,
		text = Localize("loc_group_finder_category_key_words")
	},
	havoc_threshold = {
		text = Localize("loc_group_finder_subcategory_havoc_thresholds")
	}
}

local function _tags_sort_function(a, b)
	local a_ui_category = a.ui_category
	local a_category_settings = a_ui_category and settings_by_category[a_ui_category]
	local a_description_sort_order = a_category_settings and a_category_settings.description_sort_order or math.huge
	local b_ui_category = b.ui_category
	local b_category_settings = b_ui_category and settings_by_category[b_ui_category]
	local b_description_sort_order = b_category_settings and b_category_settings.description_sort_order or math.huge

	if a_description_sort_order == b_description_sort_order then
		return a.name < b.name
	end

	return a_description_sort_order < b_description_sort_order
end

local REQUEST_DURATION = 90

function GroupFinderView:init(settings, context)
	self._state = STATE.idle
	self._selected_tags = {}
	self._selected_tags_by_name = {}
	self._metadata_for_selected_tags = {}
	self._havoc_threshold_tag_to_inject = ""
	self._has_active_havoc_order = false
	self._is_party_full = false
	self._groups = {}
	self._sent_requests = {}
	self._sent_requests_duration = {}
	self._advertisement_join_requests_version = -1
	self._join_requests = {}
	self._lowest_party_member_level = 0
	self._highest_tag_level_requirement = 0
	self._anim_preview_progress = 1
	self._visited_tag_pages = {
		{}
	}
	self._initial_party_id = self:party_id()
	self._promise_container = PromiseContainer:new()
	self._regions_latency = {}
	self._show_group_loading = false
	self._player_request_button_accept_input_action = "confirm_pressed"
	self._player_request_button_decline_input_action = "hotkey_menu_special_1"
	self._refresh_button_input_action = "group_finder_refresh_groups"
	self._preview_button_input_action = "group_finder_group_inspect"
	self._start_group_button_input_action = "group_finder_start_group"
	self._cancel_group_button_input_action = "group_finder_cancel_group"
	self._using_cursor_navigation = Managers.ui:using_cursor_navigation()

	GroupFinderView.super.init(self, GroupFinderViewDefinitions, settings, context)

	self._pass_input = false
	self._pass_draw = false
	self._allow_close_hotkey = false
end

function GroupFinderView:on_enter()
	GroupFinderView.super.on_enter(self)

	local definitions = self._definitions

	if definitions.background_world_params then
		self:_setup_background_world(definitions.background_world_params)
	end

	self:_setup_widgets_stating_states()
	self:_set_group_list_empty_info_visibility(false)
	self:_update_refresh_button_text()
	self:_update_preview_input_text()
	self:_update_player_request_button_accept()
	self:_update_player_request_button_decline()
	self:_create_group_loading_widget()

	local input_legend_params = self._definitions.input_legend_params

	if input_legend_params then
		self:_setup_input_legend(input_legend_params)
	end

	self:_set_state(STATE.fetching_tags)

	self._enter_animation_id = self:_start_animation("on_enter", self._widgets_by_name, self)

	self:_register_event(PlayerCompositions.player_composition_changed_event, "event_party_composition_changed")
end

function GroupFinderView:_setup_widgets_stating_states()
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.join_button.content.hotspot.pressed_callback = callback(self, "_cb_on_join_button_pressed")
	widgets_by_name.join_button.content.hotspot.disabled = true
	widgets_by_name.player_request_button_accept.style.text.text_horizontal_alignment = "right"
	widgets_by_name.player_request_button_decline.style.text.text_horizontal_alignment = "right"
	widgets_by_name.refresh_button.style.text.text_horizontal_alignment = "right"
	widgets_by_name.refresh_button.content.hotspot.pressed_callback = callback(self, "_cb_on_refresh_button_pressed")
	widgets_by_name.start_group_button.content.hotspot.pressed_callback = callback(self, "_cb_on_start_group_button_pressed")
	widgets_by_name.previous_filter_button.content.hotspot.pressed_callback = callback(self, "_cb_on_previous_filter_button_pressed")

	ButtonPassTemplates.terminal_button_hold_small.init(self, self._widgets_by_name.cancel_group_button, self._ui_renderer, {
		timer = 0.5,
		keep_hold_active = true,
		text = Utf8.upper(Localize("loc_group_finder_cancel_group_button")),
		complete_function = callback(self, "_cb_on_cancel_group_button_pressed"),
		input_action = self._cancel_group_button_input_action .. "_hold",
		start_input_action = self._cancel_group_button_input_action
	})

	widgets_by_name.join_button_level_warning.content.text = ""

	self:_set_preview_grid_visibility(false)

	self._side_widgets_by_state = {
		[STATE.browsing] = {
			widgets_by_name.start_group_button_level_warning,
			widgets_by_name.start_group_button_party_full_warning,
			widgets_by_name.start_group_button,
			widgets_by_name.previous_filter_button,
			widgets_by_name.start_group_button_header,
			widgets_by_name.category_description,
			widgets_by_name.filter_page_divider_top,
			widgets_by_name.filter_page_divider_bottom
		},
		[STATE.advertising] = {
			widgets_by_name.player_request_window,
			widgets_by_name.created_group_party_title,
			widgets_by_name.cancel_group_button,
			widgets_by_name.team_member_1,
			widgets_by_name.team_member_2,
			widgets_by_name.team_member_3,
			widgets_by_name.team_member_4,
			widgets_by_name.own_group_presentation,
			widgets_by_name.player_request_button_accept,
			widgets_by_name.player_request_button_decline
		}
	}
end

function GroupFinderView:_setup_input_legend(input_legend_params)
	if self:_element("input_legend") then
		self:_remove_element("input_legend")
	end

	local layer = input_legend_params.layer or 10
	self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", layer)
	local buttons_params = input_legend_params.buttons_params

	for i = 1, #buttons_params do
		local legend_input = buttons_params[i]

		self:add_input_legend_entry(legend_input)
	end
end

function GroupFinderView:add_input_legend_entry(entry_params)
	local input_legend = self:_element("input_legend")
	local press_callback = nil
	local on_pressed_callback = entry_params.on_pressed_callback

	if on_pressed_callback then
		local callback_parent = self[on_pressed_callback] and self or nil

		if not callback_parent and self._active_view then
			local view_instance = self._active_view and Managers.ui:view_instance(self._active_view)
			callback_parent = view_instance
		end

		press_callback = callback_parent and callback(callback_parent, on_pressed_callback)
	end

	local display_name = entry_params.display_name
	local input_action = entry_params.input_action
	local visibility_function = entry_params.visibility_function
	local alignment = entry_params.alignment
	local suffix_function = entry_params.suffix_function

	return input_legend:add_entry(display_name, input_action, visibility_function, press_callback, alignment, nil, nil, nil, suffix_function)
end

function GroupFinderView:_create_group_loading_widget()
	local widget_definition = UIWidget.create_definition({
		{
			pass_type = "rect",
			style = {
				color = Color.black(127.5, true)
			}
		},
		{
			value = "content/ui/materials/loading/loading_icon",
			pass_type = "texture",
			style = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				size = {
					256,
					256
				},
				offset = {
					0,
					0,
					1
				}
			}
		}
	}, "group_loading")
	self._group_loading_widget = self:_create_widget("loading", widget_definition)
end

function GroupFinderView:_update_group_loading_widget(dt)
	if not self._group_loading_widget then
		return
	end

	local anim_speed = 4

	if anim_speed then
		local group_loading_anim_progress = self._group_loading_anim_progress or 0

		if self._show_group_loading then
			group_loading_anim_progress = math.min(group_loading_anim_progress + dt * anim_speed, 1)
		else
			group_loading_anim_progress = math.max(group_loading_anim_progress - dt * anim_speed, 0)
		end

		self._group_loading_anim_progress = group_loading_anim_progress
	end

	self._group_loading_widget.alpha_multiplier = self._group_loading_anim_progress or 0
end

function GroupFinderView:_setup_background_world(world_params)
	if world_params.register_camera_event then
		self:_register_event(world_params.register_camera_event, "event_register_camera")
	end

	local world_name = world_params.world_name or self.view_name .. "_world"
	local world_layer = world_params.world_layer or 1
	local world_timer_name = world_params.timer_name or "ui"
	self._world_spawner = UIWorldSpawner:new(world_name, world_layer, world_timer_name, self.view_name)

	if self._context then
		self._context.background_world_spawner = self._world_spawner
	end

	local level_name = world_params.level_name

	if level_name then
		self._world_spawner:spawn_level(level_name)
	end
end

function GroupFinderView:event_register_camera(camera_unit)
	local world_params = self._definitions.background_world_params

	self:_unregister_event(world_params.register_camera_event)

	local viewport_name = world_params.viewport_name or self.view_name .. "_viewport"
	local viewport_type = world_params.viewport_type or "default"
	local viewport_layer = world_params.viewport_layer or 1
	local shading_environment = world_params.shading_environment

	self._world_spawner:create_viewport(camera_unit, viewport_name, viewport_type, viewport_layer, shading_environment)
end

local function _format_group_finder_tags(backend_data)
	if not backend_data or not backend_data.tags then
		Log.error("GroupFinderView", "Invalid response: response or response.tags is nil")

		return {}
	end

	local formatted_response = {}
	local formatted_response_by_name = {}
	local parents_map = {}
	local response_tags = backend_data.tags.tags

	for _, tag in ipairs(response_tags) do
		local formatted_tag = {
			name = tag.name,
			locked = tag.locked,
			access_requirement = tag.accessRequirement,
			difficulty_requirement = tag.difficultyRequirement,
			level_requirement = tag.levelRequirement,
			mutually_exclusive = tag.mutuallyExclusive,
			unlocks = tag.unlocks,
			pattern = tag.pattern,
			root_tag = tag.rootTag,
			display_mode = tag.display and tag.display.mode,
			ui_category = tag.display and tag.display.uiGroup,
			widget_type = tag.display and tag.display.widgetType,
			header = tag.display and tag.display.header,
			text = tag.display and tag.display.text and Localize(tag.display.text) or "",
			background_texture = tag.display and tag.display.backgroundTexture,
			difficulty = tag.display and tag.display.difficulty
		}

		if tag.unlocks then
			for _, child_name in ipairs(tag.unlocks) do
				if not parents_map[child_name] then
					parents_map[child_name] = {}
				end

				table.insert(parents_map[child_name], tag.name)
			end
		end

		table.insert(formatted_response, formatted_tag)

		formatted_response_by_name[tag.name] = formatted_tag
	end

	for _, tag in ipairs(formatted_response) do
		if tag.locked and parents_map[tag.name] then
			tag.parents = parents_map[tag.name]
		end
	end

	for _, tag in ipairs(formatted_response) do
		if not tag.root_tag then
			local unlocks = tag.unlocks

			if unlocks then
				local mutually_exclusive = tag.mutually_exclusive

				if mutually_exclusive then
					local mutually_exclusive_additions = {}

					for _, mutually_exclusive_tag_name in ipairs(mutually_exclusive) do
						local mutually_exclusive_tag = formatted_response_by_name[mutually_exclusive_tag_name]
						local mutually_exclusive_tag_unlocks = mutually_exclusive_tag.unlocks

						if mutually_exclusive_tag_unlocks then
							for _, key in ipairs(mutually_exclusive_tag_unlocks) do
								if not table.contains(unlocks, key) then
									mutually_exclusive_additions[key] = true
								end
							end
						end
					end

					for key, _ in pairs(mutually_exclusive_additions) do
						if not table.contains(mutually_exclusive, key) then
							mutually_exclusive[#mutually_exclusive + 1] = key
						end
					end
				end
			end
		end
	end

	for _, tag in ipairs(formatted_response) do
		local tag_name = tag.name

		if not tag.root_tag then
			local mutually_exclusive = tag.mutually_exclusive or {}

			for _, inspect_tag in ipairs(formatted_response) do
				if inspect_tag.mutually_exclusive and table.contains(inspect_tag.mutually_exclusive, tag_name) and not table.contains(mutually_exclusive, inspect_tag.name) then
					table.insert(mutually_exclusive, inspect_tag.name)
				end
			end

			if table.size(mutually_exclusive) > 0 then
				tag.mutually_exclusive = mutually_exclusive
			end
		end
	end

	return formatted_response
end

function GroupFinderView:_get_group_finder_tags()
	local promise = self._promise_container:cancel_on_destroy(Managers.data_service.social:get_group_finder_tags():catch(function (error)
		local error_string = tostring(error)

		Log.error("GroupFinderView", "Error fetching groupfinder tags: %s", error_string)

		return {}
	end))

	return promise:next(_format_group_finder_tags)
end

function GroupFinderView:_on_fetching_tags_complete()
	local visited_tag_pages = self._visited_tag_pages

	for _, tag in ipairs(self._tags) do
		local root_tag = tag.root_tag

		if root_tag then
			table.insert(visited_tag_pages[1], tag)
		end
	end

	local save_manager = Managers.save
	local player = self:_player()
	local character_id = player:character_id()
	local save_data = save_manager:character_data(character_id)
	local group_finder_search_tags = save_data and save_data.group_finder_search_tags

	if group_finder_search_tags then
		for i = #group_finder_search_tags, 1, -1 do
			local tag_name = group_finder_search_tags[i]
			local tag = self:_get_tag_by_name(tag_name)

			if tag then
				local can_select_tag = self:_can_select_tag(tag)

				if can_select_tag then
					self:_add_selected_tag(tag)
				else
					table.remove(group_finder_search_tags, i)
				end
			else
				table.remove(group_finder_search_tags, i)
			end
		end
	end

	self:_update_tag_grid()
	self:_update_tag_navigation_buttons_status()

	local party_immaterium = Managers.party_immaterium

	if party_immaterium and party_immaterium:is_party_advertisement_active() then
		self:_set_state(STATE.advertising)
	else
		self:_set_state(STATE.browsing)
	end
end

function GroupFinderView:_get_tag_depth(current_tag)
	local function get_max_depth(tag_name, current_depth)
		current_depth = current_depth or 0
		local tags = self._group_finder_tags_data
		local found_depth = nil

		for _, tag in ipairs(tags) do
			if tag.name == tag_name then
				found_depth = current_depth

				if tag.unlocks then
					for _, unlocked_tag_name in ipairs(tag.unlocks) do
						local depth = get_max_depth(unlocked_tag_name, current_depth + 1)

						if depth and (not found_depth or found_depth < depth) then
							found_depth = depth
						end
					end
				end
			end
		end

		return found_depth
	end

	return get_max_depth(current_tag, 1)
end

function GroupFinderView:_get_visited_tag_pages()
	return self._visited_tag_pages
end

function GroupFinderView:_get_page_descripion_by_category(category_name)
	local category_settings = settings_by_category[category_name]
	local description = category_settings and category_settings.text or "n/a"

	return description
end

local _temp_used_header_list = {}

function GroupFinderView:_get_layout_by_tags(tags, grid_size, tags_layout, is_preview)
	table.clear(_temp_used_header_list)

	tags_layout = tags_layout or {}

	if not is_preview then
		tags_layout[#tags_layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				grid_size[1],
				15
			}
		}
	end

	local player = self:_player()
	local profile = player:profile()
	local current_level = profile and profile.current_level or 0
	local num_tags = #tags

	for i = 1, num_tags do
		local tag = tags[i]
		local layout_data = {}

		if not is_preview then
			local header = tag.header

			if header and not _temp_used_header_list[header] then
				_temp_used_header_list[header] = true
				tags_layout[#tags_layout + 1] = {
					widget_type = "header",
					text = Localize(header),
					size = {
						grid_size[1],
						100
					}
				}
				tags_layout[#tags_layout + 1] = {
					widget_type = "dynamic_spacing",
					size = {
						grid_size[1],
						30
					}
				}
			end
		end

		local widget_type = is_preview and "tag_preview" or tag.widget_type
		local small_spacing = widget_type == "tag_checkbox"
		layout_data.is_preview = is_preview
		layout_data.widget_type = widget_type or "tag_default"
		layout_data.text = tag.text
		layout_data.tag = tag
		local level_requirement = tag.level_requirement or 0
		local level_requirement_met = is_preview or level_requirement <= current_level
		layout_data.required_level = not level_requirement_met and level_requirement
		layout_data.level_requirement_met = level_requirement_met

		if not level_requirement_met and not layout_data.block_reason then
			layout_data.block_reason = Localize("loc_group_finder_tag_level_requirement", true, {
				level = level_requirement
			})
		end

		local access_requirement = tag.access_requirement

		if access_requirement and not layout_data.block_reason then
			local block_reason, block_context = Managers.data_service.mission_board:get_block_reason("group_finder", access_requirement)
			layout_data.block_reason = block_reason and Localize(block_reason, block_context ~= nil, block_context)
		end

		local difficulty_requirement = tag.difficulty_requirement

		if difficulty_requirement and not Managers.data_service.mission_board:is_difficulty_unlocked(difficulty_requirement) and not layout_data.block_reason then
			local block_reason = "loc_narrative_unknown_lock_reason"
			local block_context = nil
			layout_data.block_reason = block_reason and Localize(block_reason, block_context ~= nil, block_context)
		end

		if layout_data.block_reason == nil then
			local personal_havoc_order_exists = self._has_active_havoc_order
			layout_data.active_havoc_order = personal_havoc_order_exists
		end

		layout_data.dynamic_size = false
		layout_data.size = {
			grid_size[1],
			small_spacing and 40 or nil
		}

		if not is_preview then
			layout_data.pressed_callback = callback(self, "_cb_on_list_tag_pressed", layout_data)
		end

		if layout_data.widget_type == "tag_slot_button" then
			layout_data.get_selected_unlocks_tags = callback(function ()
				return self:get_selected_unlocks_by_tag(tag)
			end)
		end

		tags_layout[#tags_layout + 1] = layout_data

		if not is_preview and i < num_tags then
			tags_layout[#tags_layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					10,
					small_spacing and 15 or 30
				}
			}
		end
	end

	if not is_preview then
		tags_layout[#tags_layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				grid_size[1],
				15
			}
		}
	end

	return tags_layout
end

function GroupFinderView:allow_close_hotkey()
	return self._allow_close_hotkey and self:using_cursor_navigation()
end

function GroupFinderView:cb_on_clear_pressed()
	local selected_tags = self._selected_tags

	if #selected_tags == 0 then
		return
	end

	local selected_tags_by_name = self._selected_tags_by_name

	table.clear(selected_tags)
	table.clear(selected_tags_by_name)

	self._highest_tag_level_requirement = self:_get_highest_tag_level_requirement(self._selected_tags)
	local clear_slot_widgets = true

	self:_update_tag_widgets(clear_slot_widgets)
	self:_reset_search()
	self:_update_tag_navigation_buttons_status()
	self:_play_sound(UISoundEvents.group_finder_filter_list_tag_deselected)
end

function GroupFinderView:cb_handle_back_pressed()
	local visited_tag_pages = self:_get_visited_tag_pages()

	if #visited_tag_pages >= 2 then
		visited_tag_pages[#visited_tag_pages] = nil

		self:_update_tag_grid()
		self:_update_tag_navigation_buttons_status()
		self:_play_sound(UISoundEvents.group_finder_filter_list_back)
	elseif self:can_exit() then
		local view_name = self.view_name

		Managers.ui:close_view(view_name)
	end
end

function GroupFinderView:_handle_input(input_service, dt, t)
	local state = self._state
	local using_cursor_navigation = self:using_cursor_navigation()
	local wanted_preview_group_id = nil

	if not using_cursor_navigation then
		local tags_grid = self._tags_grid
		local group_grid = self._group_grid
		local player_request_grid = self._player_request_grid

		if state == STATE.advertising then
			local input_handled = false

			if player_request_grid and not input_handled then
				local selected_grid_widget = player_request_grid:selected_grid_widget()
				local selected_grid_element = selected_grid_widget and selected_grid_widget.content.element

				if selected_grid_element then
					local player_request_button_accept_input_action = self._player_request_button_accept_input_action

					if not input_handled and input_service:get(player_request_button_accept_input_action) then
						self:_cb_on_player_request_accept_pressed(selected_grid_element)

						input_handled = true
					end

					local player_request_button_decline_input_action = self._player_request_button_decline_input_action

					if not input_handled and input_service:get(player_request_button_decline_input_action) then
						self:_cb_on_player_request_decline_pressed(selected_grid_element)
					end
				end
			end
		elseif state == STATE.browsing then
			if input_service:get(self._preview_button_input_action) then
				wanted_preview_group_id = self._selected_group_id
			end

			if group_grid then
				if self._previewed_group_id then
					if group_grid:is_gamepad_scrolling_enabled() then
						group_grid:set_enable_gamepad_scrolling(false)
					end
				elseif not group_grid:is_gamepad_scrolling_enabled() then
					group_grid:set_enable_gamepad_scrolling(true)
				end
			end

			if tags_grid:selected_grid_index() then
				if input_service:get("navigate_right_continuous") and group_grid and #group_grid:widgets() > 0 then
					tags_grid:select_grid_index(nil)
					group_grid:select_first_index()
				end
			elseif group_grid:selected_grid_index() and input_service:get("navigate_left_continuous") and self._can_leave_group_grid_selection then
				group_grid:select_grid_index(nil)
				tags_grid:select_first_index()
			end

			local refresh_button_input_action = self._refresh_button_input_action

			if input_service:get(refresh_button_input_action) then
				self:_cb_on_refresh_button_pressed()
			end

			local start_group_button_input_action = self._start_group_button_input_action

			if input_service:get(start_group_button_input_action) then
				self:_cb_on_start_group_button_pressed()
			end
		end
	elseif state == STATE.browsing then
		local refresh_button_input_action = self._refresh_button_input_action

		if input_service:get(refresh_button_input_action) then
			self:_cb_on_refresh_button_pressed()
		end

		local group_grid = self._group_grid

		if group_grid and input_service:get(self._preview_button_input_action) then
			local hovered_group_id = nil
			local hovered_grid_index = group_grid:hovered_grid_index()

			if hovered_grid_index then
				local selected_widget = hovered_grid_index and group_grid:widget_by_index(hovered_grid_index)

				if selected_widget then
					local content = selected_widget.content
					local element = content.element
					hovered_group_id = element and element.group_id
				end
			end

			wanted_preview_group_id = hovered_group_id or self._selected_group_id
		end
	end

	if wanted_preview_group_id ~= self._previewed_group_id then
		self:_setup_group_preview(wanted_preview_group_id)
	end

	local tags_grid = self._tags_grid

	if tags_grid then
		if self._previewed_group_id then
			tags_grid:disable_input(true)
		else
			tags_grid:disable_input(false)
		end
	end

	self:_handle_group_list_input(input_service)
end

function GroupFinderView:_block_reason_for_group(group_id)
	local group = self:_group_by_id(group_id)

	if not group then
		return
	end

	local player = self:_player()
	local profile = player:profile()
	local current_level = profile and profile.current_level or 0
	local tags = group.tags
	local num_tags = tags and #tags or 0
	local block_reason = nil

	for i = 1, num_tags do
		local tag = tags[i]
		local level_requirement = tag.level_requirement or 0
		local level_requirement_met = current_level >= level_requirement

		if not level_requirement_met then
			block_reason = block_reason or Localize("loc_group_finder_tag_level_requirement", true, {
				level = level_requirement
			})
		end

		local access_requirement = tag.access_requirement

		if access_requirement and not block_reason then
			local block_loc_key, block_context = Managers.data_service.mission_board:get_block_reason("group_finder", access_requirement)
			block_reason = block_loc_key and Localize(block_loc_key, block_context ~= nil, block_context)
		end

		local difficulty_requirement = tag.difficulty_requirement

		if difficulty_requirement and not Managers.data_service.mission_board:is_difficulty_unlocked(difficulty_requirement) and not block_reason then
			local block_loc_key = "loc_narrative_unknown_lock_reason"
			local block_context = nil
			block_reason = block_loc_key and Localize(block_loc_key, block_context ~= nil, block_context)
		end
	end

	return block_reason
end

function GroupFinderView:_handle_group_list_input(input_service)
	local widgets_by_name = self._widgets_by_name
	local join_button = widgets_by_name.join_button
	local selected_group_id = self._selected_group_id
	local block_reason = selected_group_id and self:_block_reason_for_group(selected_group_id)
	join_button.content.hotspot.disabled = selected_group_id == nil or block_reason ~= nil
end

function GroupFinderView:_respond_to_join_request(element, accept)
	local party_immaterium = Managers.party_immaterium

	if not party_immaterium then
		return
	end

	self:_play_sound(UISoundEvents.group_finder_request_button_decline)

	local join_request = element.join_request
	local account_id = join_request.account_id
	local party_id = self:party_id()
	local promise, id = party_immaterium:party_finder_respond_to_join_request(party_id, account_id, accept)

	self._promise_container:cancel_on_destroy(promise)
end

function GroupFinderView:_cb_on_player_request_accept_pressed(element)
	self:_play_sound(UISoundEvents.group_finder_request_button_accept)
	self:_respond_to_join_request(element, true)
end

function GroupFinderView:_cb_on_player_request_decline_pressed(element)
	self:_respond_to_join_request(element, false)
end

function GroupFinderView:_is_tag_mutually_exclusive_with_current_selection(tag)
	local is_mutually_exclusive = false
	local deselection_allowed = true
	local mutually_exclusive = tag.mutually_exclusive

	if mutually_exclusive then
		for i = 1, #mutually_exclusive do
			local mutually_exclusive_tag_name = mutually_exclusive[i]
			local mutually_exclusive_tag = self:_get_tag_by_name(mutually_exclusive_tag_name)

			if self:_is_tag_name_selected(mutually_exclusive_tag_name) then
				local parents = mutually_exclusive_tag.parents

				if parents then
					is_mutually_exclusive = true

					if tag.ui_category ~= mutually_exclusive_tag.ui_category then
						deselection_allowed = false
					end
				end
			end
		end
	end

	return is_mutually_exclusive, deselection_allowed
end

local _temp_return_value_by_visisted_tag = {}

function GroupFinderView:_can_select_tag(tag, _ignore_tag_name)
	local tag_name = tag.name

	if tag.root_tag then
		return false
	end

	if not _ignore_tag_name then
		table.clear(_temp_return_value_by_visisted_tag)
	end

	if _temp_return_value_by_visisted_tag[tag_name] ~= nil then
		return _temp_return_value_by_visisted_tag[tag_name]
	end

	local character_level = self:character_level()
	local level_requirement = tag.level_requirement or 0
	local level_requirement_met = character_level >= level_requirement

	if not level_requirement_met then
		_temp_return_value_by_visisted_tag[tag_name] = false

		return false
	end

	local access_requirement = tag.access_requirement

	if access_requirement and not Managers.data_service.mission_board:is_key_unlocked("group_finder", access_requirement) then
		_temp_return_value_by_visisted_tag[tag_name] = false

		return false
	end

	local tag_is_already_selected = self:_is_tag_name_selected(tag_name)

	if tag_is_already_selected then
		_temp_return_value_by_visisted_tag[tag_name] = false

		return false
	end

	local has_mutually_exclusive_selections, _ = self:_is_tag_mutually_exclusive_with_current_selection(tag)

	if has_mutually_exclusive_selections then
		_temp_return_value_by_visisted_tag[tag_name] = false

		return false
	end

	local parents = tag.parents

	if parents then
		local only_root_tag_parents = true
		local has_available_parent_path = false

		for i = 1, #parents do
			local parent_name = parents[i]
			local parent_tag = self:_get_tag_by_name(parent_name)

			if not parent_tag.root_tag then
				only_root_tag_parents = false

				if self:_is_tag_name_selected(parent_name) then
					_temp_return_value_by_visisted_tag[tag_name] = true

					return true
				elseif self:_can_select_tag(parent_tag, tag_name) then
					has_available_parent_path = true
				end
			end
		end

		if not only_root_tag_parents then
			_temp_return_value_by_visisted_tag[tag_name] = has_available_parent_path

			return has_available_parent_path
		end
	end

	_temp_return_value_by_visisted_tag[tag_name] = true

	return true
end

function GroupFinderView:_cb_on_list_tag_pressed(element)
	if element.block_reason then
		return
	end

	local tag = element.tag
	local pressed_tag_name = tag.name
	local can_select_tag = self:_can_select_tag(tag)

	if can_select_tag then
		if self:_add_selected_tag(tag) then
			self:_play_sound(UISoundEvents.group_finder_filter_list_tag_selected)
		end
	elseif self:_is_tag_name_selected(pressed_tag_name) then
		if tag.unlocks and element.auto_next then
			for i = 1, #tag.unlocks do
				local unlock_tag = tag.unlocks[i]

				if self:_is_tag_name_selected(unlock_tag) then
					self:_play_sound(UISoundEvents.group_finder_filter_list_tag_selected)

					break
				end
			end
		elseif self:_remove_selected_tag(tag) then
			self:_play_sound(UISoundEvents.group_finder_filter_list_tag_deselected)
		end
	else
		local is_mutually_exclusive, deselection_allowed = self:_is_tag_mutually_exclusive_with_current_selection(tag)

		if is_mutually_exclusive and deselection_allowed then
			local mutually_exclusive = tag.mutually_exclusive

			for i = 1, #mutually_exclusive do
				local mutually_exclusive_tag_name = mutually_exclusive[i]
				local mutually_exclusive_tag = self:_get_tag_by_name(mutually_exclusive_tag_name)

				self:_remove_selected_tag(mutually_exclusive_tag)
			end

			if self:_add_selected_tag(tag) then
				self:_play_sound(UISoundEvents.group_finder_filter_list_tag_selected)
			end
		end
	end

	self:_update_tag_widgets()
	self:_reset_search()
	self:_update_tag_navigation_buttons_status()

	if element.auto_next then
		self._auto_continue_from_tag = tag
	end
end

function GroupFinderView:_update_tag_widgets(clear_slot_widgets)
	local any_visible_tag_selected = false
	local tags_grid = self._tags_grid

	if tags_grid then
		local grid_widgets = tags_grid:widgets()

		for i = 1, #grid_widgets do
			local grid_widget = grid_widgets[i]
			local content = grid_widget.content
			local widget_element = content.element
			local tag = widget_element.tag

			if tag then
				local tag_name = tag.name
				local is_tag_selected = self:_is_tag_name_selected(tag_name)

				if clear_slot_widgets then
					content.slot_filled = false
				end

				local hotspot = content.hotspot

				if hotspot then
					content.checked = is_tag_selected

					if content.checked then
						any_visible_tag_selected = true
					end
				end

				local root_tag = tag.root_tag
				local disabled = true

				if root_tag then
					disabled = false
				else
					local block_reason = widget_element.block_reason

					if block_reason == nil then
						local can_select_tag = self:_can_select_tag(tag)

						if not can_select_tag then
							if is_tag_selected then
								disabled = false
							else
								local is_mutually_exclusive, deselection_allowed = self:_is_tag_mutually_exclusive_with_current_selection(tag)

								if is_mutually_exclusive and deselection_allowed then
									disabled = false
								end
							end
						else
							disabled = false
						end
					end
				end

				hotspot.disabled = disabled
			end
		end

		for i = 1, #grid_widgets do
			local grid_widget = grid_widgets[i]
			local content = grid_widget.content
			local hotspot = content.hotspot

			if hotspot then
				content.any_visible_tag_selected_last_frame = any_visible_tag_selected
			end
		end
	end
end

function GroupFinderView:_is_tag_name_selected(tag_name)
	return self._selected_tags_by_name[tag_name]
end

function GroupFinderView:_get_highest_tag_level_requirement(tags)
	local highest_tag_level_requirement = 0

	for i = 1, #tags do
		local tag = tags[i]
		local level_requirement = tag.level_requirement or 0

		if highest_tag_level_requirement < level_requirement then
			highest_tag_level_requirement = level_requirement
		end
	end

	return highest_tag_level_requirement
end

function GroupFinderView:_add_selected_tag(tag)
	local tag_name = tag.name

	if not self._selected_tags_by_name[tag_name] then
		self._selected_tags_by_name[tag_name] = tag
		self._selected_tags[#self._selected_tags + 1] = tag
		self._highest_tag_level_requirement = self:_get_highest_tag_level_requirement(self._selected_tags)

		return true
	end
end

function GroupFinderView:_remove_selected_tag(tag)
	local tag_name = tag.name

	if self._selected_tags_by_name[tag_name] then
		self._selected_tags_by_name[tag_name] = nil

		for i = 1, #self._selected_tags do
			if self._selected_tags[i].name == tag_name then
				table.remove(self._selected_tags, i)

				self._highest_tag_level_requirement = self:_get_highest_tag_level_requirement(self._selected_tags)

				return true
			end
		end
	end
end

function GroupFinderView:_update_tag_navigation_buttons_status()
	local visited_tag_pages = self:_get_visited_tag_pages()
	local selected_tags = self._selected_tags
	local widgets_by_name = self._widgets_by_name
	local previous_filter_button = widgets_by_name.previous_filter_button
	previous_filter_button.content.hotspot.disabled = #visited_tag_pages <= 1
	local lowest_party_member_level = self._lowest_party_member_level
	local highest_tag_level_requirement = self._highest_tag_level_requirement
	local is_level_requirement_met = highest_tag_level_requirement <= lowest_party_member_level
	local is_party_full = self._is_party_full
	widgets_by_name.start_group_button_party_full_warning.content.is_party_full = is_party_full
	widgets_by_name.start_group_button_level_warning.content.level_requirement_met = is_party_full or is_level_requirement_met
	local start_group_button = widgets_by_name.start_group_button
	start_group_button.content.hotspot.disabled = is_party_full or not is_level_requirement_met or #selected_tags <= 0
end

function GroupFinderView:_generate_tags_description(tags)
	local text = ""
	local grid_scenegraph_id = "group_grid"
	local definitions = self._definitions
	local scenegraph_definition = definitions.scenegraph_definition
	local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
	local grid_size = grid_scenegraph.size
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.own_group_presentation
	local description_text_style = widget.style.description
	local extra_tags_width = 50
	local max_length = (grid_size[1] - 20) * 0.5 + description_text_style.size_addition[1] - extra_tags_width
	local extra_tags_counter = 0

	for i = 1, #tags do
		local tag = tags[i]
		local new_text = text .. "[" .. tag.text .. "] "
		local width, _ = self:_text_size_for_style(new_text, description_text_style, {
			max_length + max_length,
			5
		})

		if width <= max_length then
			text = new_text
		else
			extra_tags_counter = extra_tags_counter + 1
		end
	end

	if extra_tags_counter > 0 then
		text = text .. " (+" .. tostring(extra_tags_counter) .. ")"
	end

	return text
end

function GroupFinderView:_get_selected_tags(return_table)
	return_table = return_table or {}
	local tags_grid = self._tags_grid

	if tags_grid then
		local grid_widgets = tags_grid:widgets()

		for i = 1, #grid_widgets do
			local grid_widget = grid_widgets[i]
			local content = grid_widget.content
			local hotspot = content.hotspot

			if hotspot then
				local checked = content.checked

				if checked then
					local widget_element = content.element
					local tag = widget_element.tag

					if tag then
						return_table[#return_table + 1] = tag
					end
				end
			end
		end
	end

	return return_table
end

function GroupFinderView:_cb_on_list_group_pressed(element, widget_index)
	if self._previewed_group_id then
		return
	end

	if self:using_cursor_navigation() then
		local group_grid = self._group_grid

		if group_grid then
			if group_grid:selected_grid_index() == widget_index then
				group_grid:select_grid_index(nil)
			else
				group_grid:select_grid_index(widget_index)
			end
		end
	else
		self:_cb_on_join_button_pressed()
	end
end

function GroupFinderView:_on_group_selection_changed()
	local group_grid = self._group_grid
	local selected_grid_index = group_grid and group_grid:selected_grid_index()
	local selected_widget = selected_grid_index and group_grid:widget_by_index(selected_grid_index)

	if selected_widget then
		local content = selected_widget.content
		local element = content.element
		self._selected_group_id = element and element.group_id
		self._selected_group_grid_index = selected_grid_index
	else
		self._selected_group_id = nil
		self._selected_group_grid_index = nil
	end

	self._widgets_by_name.join_button_level_warning.content.text = self._selected_group_id and self:_block_reason_for_group(self._selected_group_id) or ""
end

function GroupFinderView:_setup_group_preview(group_id)
	local group = self:_group_by_id(group_id)

	if group then
		self._previewed_group_id = group_id
		local tags = group and group.tags
		local group_grid_size = self._ui_scenegraph.group_grid.size
		local tags_grid_size = self._ui_scenegraph.tags_grid.size
		local player_request_grid_size = self._ui_scenegraph.player_request_grid.size
		local preview_grid_size = self._ui_scenegraph.preview_grid.size
		local layout = {
			[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					preview_grid_size[1],
					60
				}
			}
		}
		local group_width = group_grid_size[1] * 0.5 - 5
		layout[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				(preview_grid_size[1] - group_width) * 0.5,
				20
			}
		}
		local group_entry = {
			is_preview = true,
			level_requirement_met = true,
			widget_type = "group",
			group = group,
			description = group.description,
			group_id = group.id,
			tags = tags,
			metadata = group.metadata
		}
		layout[#layout + 1] = group_entry
		layout[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				preview_grid_size[1],
				30
			}
		}
		layout[#layout + 1] = {
			vertical_alignment = "center",
			texture = "content/ui/materials/dividers/skull_center_01",
			horizontal_alignment = "center",
			widget_type = "texture",
			texture_size = {
				380,
				30
			},
			color = Color.terminal_text_body_sub_header(nil, true),
			size = {
				preview_grid_size[1],
				30
			}
		}
		local group_members = group.members

		if group_members and #group_members > 0 then
			layout[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					preview_grid_size[1],
					30
				}
			}
			layout[#layout + 1] = {
				widget_type = "header",
				text = Localize("loc_group_finder_group_player_title"),
				size = {
					preview_grid_size[1],
					30
				}
			}
			layout[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					preview_grid_size[1],
					10
				}
			}

			for _, member in ipairs(group_members) do
				local presence_info = member.presence_info
				local member_account_id = member.account_id

				if presence_info and presence_info.synced then
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							preview_grid_size[1] * 0.5 - player_request_grid_size[1] * 0.5,
							50
						}
					}
					local entry = {
						is_preview = true,
						widget_type = "player_request_entry",
						presence_info = presence_info,
						account_id = member_account_id
					}
					layout[#layout + 1] = entry
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							preview_grid_size[1] * 0.5 - player_request_grid_size[1] * 0.5,
							50
						}
					}
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							preview_grid_size[1],
							10
						}
					}
				end
			end
		end

		if tags then
			local spacing = 10
			local preview_tag_row_width = player_request_grid_size[1]
			local preview_tag_size = {
				(preview_tag_row_width - spacing) * 0.5,
				45
			}
			layout[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					preview_grid_size[1],
					45
				}
			}
			layout[#layout + 1] = {
				widget_type = "header",
				text = Localize("loc_group_finder_category_option_key_words"),
				size = {
					preview_grid_size[1],
					45
				}
			}
			layout[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					preview_grid_size[1],
					10
				}
			}
			local tag_layout = self:_get_layout_by_tags(tags, preview_tag_size, nil, true)

			for i = 1, #tag_layout do
				local is_even = i % 2 == 0

				if not is_even then
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							(preview_grid_size[1] - preview_tag_row_width) * 0.5,
							10
						}
					}
				end

				layout[#layout + 1] = tag_layout[i]

				if not is_even then
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							spacing,
							10
						}
					}
				end

				if is_even then
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							(preview_grid_size[1] - preview_tag_row_width) * 0.5,
							10
						}
					}
					layout[#layout + 1] = {
						widget_type = "dynamic_spacing",
						size = {
							preview_grid_size[1],
							10
						}
					}
				end
			end
		end

		layout[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				preview_grid_size[1],
				45
			}
		}

		self:_populate_preview_grid(layout)
		self:_set_preview_grid_visibility(true)
	else
		self._previewed_group_id = nil

		self:_set_preview_grid_visibility(false)
	end
end

function GroupFinderView:draw(dt, t, input_service, layer)
	local render_settings = self._render_settings
	local alpha_multiplier = render_settings.alpha_multiplier
	local animation_alpha_multiplier = self.animation_alpha_multiplier or 0
	render_settings.alpha_multiplier = animation_alpha_multiplier

	GroupFinderView.super.draw(self, dt, t, input_service, layer)

	render_settings.alpha_multiplier = alpha_multiplier
end

function GroupFinderView:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	GroupFinderView.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)

	local group_loading_widget = self._group_loading_widget

	if group_loading_widget then
		UIWidget.draw(group_loading_widget, ui_renderer)
	end
end

function GroupFinderView:on_resolution_modified(scale)
	GroupFinderView.super.on_resolution_modified(self, scale)
end

function GroupFinderView:_cb_on_join_button_pressed()
	if self._widgets_by_name.join_button.content.hotspot.disabled then
		return
	end

	if not self._selected_group_id then
		return
	end

	local group = self:_group_by_id(self._selected_group_id)

	if not group then
		return
	end

	self:_set_group_request_status(group.id, "sent")

	local party_immaterium = Managers.party_immaterium

	if party_immaterium then
		local player = self:_player()
		local account_id = player:account_id()

		party_immaterium:send_request_to_join_party(group, account_id):next(function (response)
			if response.accepted then
				self:_set_group_request_status(group.id, "approved")
			else
				self:_set_group_request_status(group.id, "declined")
			end
		end):catch(function (error)
			Log.error("GroupFinderView", "Error joining game" .. table.tostring(error, 3))
			table.insert(self._sent_requests, group.id)
			self:_set_group_request_status(group.id, "declined")
		end)

		local message = Localize("loc_group_finder_join_notification_sent")

		Managers.event:trigger("event_add_notification_message", "default", message, nil, nil)
		self:_play_sound(UISoundEvents.group_finder_request_to_join_group)
	end
end

function GroupFinderView:_set_group_request_status(id, state)
	self._sent_requests[id] = state
	self._sent_requests_duration[id] = Managers.time:time("ui") + REQUEST_DURATION
end

function GroupFinderView:_get_group_request_status(id)
	return self._sent_requests[id]
end

function GroupFinderView:_handle_group_request_status_clearing(t)
	local sent_requests = self._sent_requests
	local sent_requests_duration = self._sent_requests_duration

	for id, time in pairs(sent_requests_duration) do
		if time < t then
			sent_requests[id] = nil
			sent_requests_duration[id] = nil
		end
	end
end

function GroupFinderView:_cb_on_start_group_button_pressed()
	local widget = self._widgets_by_name.start_group_button
	local content = widget.content
	local hotspot = content.hotspot

	if hotspot.disabled then
		return
	end

	local party_immaterium = Managers.party_immaterium

	if not party_immaterium then
		return
	end

	if self._previewed_group_id then
		return
	end

	local region = BackendUtilities.prefered_mission_region
	local selected_tags = self._selected_tags

	if #selected_tags <= 0 then
		return
	end

	local tags_for_group_advertisement = {}
	local tag_set = {}

	local function add_tag_if_not_exists(tag)
		if not tag_set[tag] then
			tag_set[tag] = true

			table.insert(tags_for_group_advertisement, tag)
		end
	end

	for i = 1, #selected_tags do
		local tag_data = selected_tags[i]

		if tag_data.name then
			add_tag_if_not_exists(tag_data.name)

			if tag_data.parents then
				local parents_data = self:_get_tags_by_names(tag_data.parents)

				for j = 1, #parents_data do
					local parent_tag = parents_data[j]

					if parent_tag.root_tag then
						add_tag_if_not_exists(parent_tag.name)
					end
				end
			end
		end
	end

	if #tags_for_group_advertisement == 0 then
		return
	end

	local function process_havoc_order_tags(tags)
		for i = #tags, 1, -1 do
			if tags[i] == "my_havoc_order" then
				if self._has_active_havoc_order then
					return true
				else
					table.remove(tags, i)

					break
				end
			end
		end

		return false
	end

	local metadata_config = {}
	local contains_personal_havoc_order_tag = process_havoc_order_tags(tags_for_group_advertisement)

	if contains_personal_havoc_order_tag then
		local havoc_threshold_tag_to_inject = self._havoc_threshold_tag_to_inject

		for i = #tags_for_group_advertisement, 1, -1 do
			local tag = tags_for_group_advertisement[i]

			if string.starts_with(tag, "havoc_order_threshold_") and tag ~= havoc_threshold_tag_to_inject then
				table.remove(tags_for_group_advertisement, i)

				tag_set[tag] = nil
			end
		end

		if not tag_set[havoc_threshold_tag_to_inject] then
			tag_set[havoc_threshold_tag_to_inject] = true

			table.insert(tags_for_group_advertisement, havoc_threshold_tag_to_inject)
		end

		metadata_config = self._metadata_for_selected_tags
	end

	local promise, id = party_immaterium:start_party_finder_advertise(metadata_config, tags_for_group_advertisement, region)

	Log.info("Party advertisement initiated with ID:", id)
	self._promise_container:cancel_on_destroy(promise)
	promise:next(function (result)
		Log.info("Party advertisement successfully started with result:", result)
		self:_set_state(STATE.advertising)
	end):catch(function (error)
		Log.error("Failed to start party advertisement. Error:", table.tostring(error, 10))
	end)
	self:_play_sound(UISoundEvents.group_finder_own_group_advertisement_start)
end

function GroupFinderView:_group_by_id(group_id)
	local groups = self._groups

	for i = 1, #groups do
		local group = groups[i]

		if group.id == group_id then
			return group
		end
	end
end

function GroupFinderView:_cb_on_previous_filter_button_pressed()
	if self._previewed_group_id then
		return
	end

	self:cb_handle_back_pressed()
end

local _temp_selected_unlocks = {}

function GroupFinderView:get_selected_unlocks_by_tag(tag)
	table.clear(_temp_selected_unlocks)

	local function add_if_selected(tag_name)
		if self:_is_tag_name_selected(tag_name) then
			local current_tag = self:_get_tag_by_name(tag_name)
			_temp_selected_unlocks[#_temp_selected_unlocks + 1] = current_tag
		end
	end

	local unlocks = tag.unlocks or {}

	for i = 1, #unlocks do
		local unlock_tag_name = unlocks[i]
		local unlock_tag = self:_get_tag_by_name(unlock_tag_name)

		add_if_selected(unlock_tag_name)

		if unlock_tag.widget_type == "tag_game_mode_with_unlocks" then
			for j = 1, #(unlock_tag.unlocks or {}) do
				add_if_selected(unlock_tag.unlocks[j])
			end
		end
	end

	return _temp_selected_unlocks
end

function GroupFinderView:_get_tag_by_name(name)
	local tags = self._tags

	for i = 1, #tags do
		local tag = tags[i]

		if tag.name == name then
			return tag
		end
	end
end

function GroupFinderView:_get_tags_by_names(names)
	local tags = self._tags
	local return_tags = {}

	for _, name in ipairs(names) do
		for i = 1, #tags do
			local tag = tags[i]

			if tag.name == name then
				return_tags[#return_tags + 1] = tag
			end
		end
	end

	return return_tags
end

function GroupFinderView:_handle_next_filter_button_options(tag)
	local unlocks = tag.unlocks
	local next_page_tags = self:_get_tags_by_names(unlocks)

	if next_page_tags then
		local visited_tag_pages = self:_get_visited_tag_pages()
		visited_tag_pages[#visited_tag_pages + 1] = next_page_tags

		self:_set_state(STATE.browsing)
		self:_update_tag_grid()
		self:_update_tag_navigation_buttons_status()
		self:_play_sound(UISoundEvents.group_finder_filter_list_category_pressed)
	end
end

function GroupFinderView:_update_tag_grid()
	local visited_tag_pages = self:_get_visited_tag_pages()
	local tags = visited_tag_pages[#visited_tag_pages]
	local first_tag = tags[1]
	local first_ui_category = first_tag.ui_category
	local description_text = self:_get_page_descripion_by_category(first_ui_category)

	if self._category_description_animation_id then
		self:_stop_animation(self._category_description_animation_id)

		self._category_description_animation_id = nil
	end

	self._category_description_animation_id = self:_start_animation("update_widget_text_fade", self._widgets_by_name.category_description, {
		new_text = description_text or ""
	})
	local tags_grid_size = self._ui_scenegraph.tags_grid.size
	local tags_layout = self:_get_layout_by_tags(tags, tags_grid_size)

	self:_populate_tags_grid(tags_layout)
end

function GroupFinderView:_cb_on_cancel_group_button_pressed()
	local widget = self._widgets_by_name.cancel_group_button
	local content = widget.content

	if not content.visible then
		return
	end

	content.hold_active = false
	content.current_timer = 0
	content.hold_progress = 0
	local party_immaterium = Managers.party_immaterium

	if not party_immaterium then
		return
	end

	if self._listed_group then
		for i = 1, #self._groups do
			local group = self._groups[i]

			if group.id == self._listed_group.id then
				table.remove(self._groups, i)
				self:_update_group_grid()

				break
			end
		end
	end

	local promise, id = party_immaterium:cancel_party_finder_advertise()

	self._promise_container:cancel_on_destroy(promise)

	self._cancel_group_promise = promise

	promise:next(function (response)
		self._advertisement_join_requests_version = -1

		self:_populate_player_request_grid({})

		self._cancel_group_promise = nil

		self:_set_state(STATE.browsing)
		self:_reset_search()
	end)
	self:_play_sound(UISoundEvents.group_finder_own_group_advertisement_stop)
end

function GroupFinderView:_cb_on_refresh_button_pressed()
	if self._refresh_promise then
		return
	end

	local refresh_promise = nil

	if self._refresh_available_timer then
		self._show_group_loading = true
		local delay_promise = Promise.delay(self._refresh_available_timer)
		refresh_promise = Promise.all(self:_reset_search(), delay_promise)
	else
		refresh_promise = self:_reset_search()
	end

	self._refresh_available_timer = 5
	self._refresh_promise = refresh_promise:next(function ()
		self._refresh_promise = nil

		if not self:using_cursor_navigation() and not self._tags_grid:selected_grid_index() then
			self._tags_grid:select_first_index()
		end
	end)

	self:_play_sound(UISoundEvents.group_finder_refresh_group_list)
end

function GroupFinderView:get_narrative_metadata()
	local player = Managers.player:local_player(1)

	return Managers.data_service.mission_board:fetch_player_journey_data(player:account_id(), player:character_id(), false)
end

function GroupFinderView:_show_error()
	local context = {
		title_text = "loc_action_interaction_unavailable",
		description_text = "loc_popup_unavailable_view_group_finder_description",
		enter_popup_sound = UISoundEvents.social_menu_receive_invite,
		options = {
			{
				text = "loc_popup_button_close",
				close_on_pressed = true,
				hotkey = "back",
				callback = function ()
					Managers.ui:close_view(self.view_name)
				end
			}
		}
	}

	Managers.event:trigger("event_show_ui_popup", context)
end

function GroupFinderView:_set_state(new_state)
	if self._update_listed_group_on_update and self._state == STATE.advertising and new_state ~= STATE.advertising then
		self._update_listed_group_on_update = false
	end

	Log.info("[GroupFinderView] - set state: CURRENT STATE: " .. self._state .. " | NEW STATE: " .. new_state)

	self._state = new_state
	self._anim_preview_progress = -0.01

	if new_state == STATE.idle then
		self:_set_group_list_empty_info_visibility(false)

		self._show_group_loading = false
	elseif new_state == STATE.fetching_tags then
		self:_set_group_list_empty_info_visibility(false)
		self:_update_grids_selection()

		self._show_group_loading = false

		self:_set_own_group_listing_widgets_visibility(false)
		self:_set_group_browsing_widgets_visibility(false)
		self:_set_tag_grid_visibility(false)
		self:_update_party_statuses()
		self._promise_container:cancel_on_destroy(Promise.all(self:fetch_regions(), self:_get_group_finder_tags(), self:get_narrative_metadata(), self:get_havoc_order_metadata())):next(function (data)
			local group_finder_tags = data[2]

			if not group_finder_tags or #group_finder_tags <= 0 then
				self:_show_error()
			else
				self._tags = group_finder_tags

				self:_on_fetching_tags_complete()
			end
		end):catch(function (err)
			self:_show_error()
		end)
	elseif new_state == STATE.browsing then
		self:_set_group_list_empty_info_visibility(false)
		self:_update_grids_selection()
		self:_set_own_group_listing_widgets_visibility(false)
		self:_set_group_browsing_widgets_visibility(true)
		self:_set_tag_grid_visibility(true)
		self:_update_party_statuses()
	elseif new_state == STATE.advertising then
		self._join_requests = {}

		self:_update_grids_selection()

		self._show_group_loading = false

		self:_set_group_list_empty_info_visibility(false)

		local party_immaterium = Managers.party_immaterium

		if party_immaterium then
			local advertise_state = party_immaterium:advertise_state()
			self._listed_group = advertise_state
		end

		self:_update_group_grid()
		self:_set_own_group_listing_widgets_visibility(true)
		self:_set_group_browsing_widgets_visibility(false)
		self:_set_tag_grid_visibility(false)
		self:_init_own_group_presentation(self._listed_group)
		self:_update_listed_group()
	end
end

function GroupFinderView:_init_own_group_presentation(listed_group)
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.own_group_presentation
	local own_group_visualization = {}
	local tags_by_name = listed_group.tags
	local tags = {}

	for _, tag_name in ipairs(tags_by_name) do
		local tag = self:_get_tag_by_name(tag_name)

		if tag and not tag.root_tag and not tag.pattern then
			tags[#tags + 1] = tag
		end
	end

	table.sort(tags, _tags_sort_function)

	local metadata_config = listed_group.config

	if metadata_config and next(metadata_config) then
		local metadata = {
			havoc_order_rank = metadata_config.havoc_order_rank,
			havoc_mission_template = metadata_config.havoc_mission_template,
			havoc_theme = metadata_config.havoc_theme
		}
		local havoc_circumstances = {}

		for key, value in pairs(metadata_config) do
			if key:find("^havoc_circ") then
				table.insert(havoc_circumstances, value)
			end
		end

		if #havoc_circumstances > 0 then
			metadata.havoc_circumstances = havoc_circumstances
		end

		if next(metadata) then
			own_group_visualization.metadata = metadata
		end

		local mission_template = metadata_config.havoc_mission_template and MissionTemplates[metadata_config.havoc_mission_template]

		if mission_template and mission_template.mission_name then
			local mission_name = Localize(mission_template.mission_name)
			tags[#tags + 1] = {
				text = mission_name
			}
		end

		for i = 1, math.min(4, #havoc_circumstances) do
			local circumstance = havoc_circumstances[i]
			local circumstance_template = CircumstanceTemplates[circumstance]

			if circumstance_template and circumstance_template.ui and circumstance_template.ui.display_name then
				local circumstance_name = Localize(circumstance_template.ui.display_name)
				tags[#tags + 1] = {
					text = circumstance_name
				}
			end
		end
	end

	own_group_visualization.level_requirement_met = true
	own_group_visualization.group_id = listed_group.party_id
	own_group_visualization.tags = tags
	own_group_visualization.description = self:_generate_tags_description(tags)
	own_group_visualization.status = listed_group.status
	own_group_visualization.version = listed_group.version
	own_group_visualization.restrictions = listed_group.restrictions
	own_group_visualization.members = {}
	own_group_visualization.group = own_group_visualization
	own_group_visualization.disabled = true
	self._own_group_visualization = own_group_visualization
	local definitions = self._definitions
	local groups_blueprints = definitions.groups_blueprints

	UIWidget.destroy(self._ui_renderer, widget)

	local new_widget = UIWidget.init("own_group_presentation", UIWidget.create_definition(groups_blueprints.group.pass_template, "own_group_presentation"))
	widgets_by_name.own_group_presentation = new_widget

	for i = 1, #self._widgets do
		local current_widget = self._widgets[i]

		if current_widget.name == "own_group_presentation" then
			self._widgets[i] = new_widget

			break
		end
	end

	groups_blueprints.group.init(self, new_widget, self._own_group_visualization, nil, nil, self._ui_renderer)
end

local time_loc_string_start = "loc_group_finder_group_list_last_time_updated_start"
local time_loc_string = "loc_group_finder_group_list_last_time_updated"

function GroupFinderView:_update_group_list_time_stamp(dt, t)
	local last_time_group_list_updated = self._last_time_group_list_updated

	if not last_time_group_list_updated then
		return
	end

	local current_time = t - last_time_group_list_updated

	if current_time % 60 > 1 then
		return
	end

	local presentation_text = nil

	if current_time < 60 then
		presentation_text = Localize(time_loc_string_start)
	else
		local time_text = TextUtilities.format_time_span_localized(current_time, false, true)
		presentation_text = Localize(time_loc_string, true, {
			time = time_text
		})
	end

	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.group_list_time_stamp
	widget.content.text = presentation_text
end

function GroupFinderView:_update_own_group_presentation(input_service, dt, t, ui_renderer)
	local definitions = self._definitions
	local groups_blueprints = definitions.groups_blueprints
	local widgets_by_name = self._widgets_by_name
	local widget = widgets_by_name.own_group_presentation

	groups_blueprints.group.update(self, widget, input_service, dt, t, ui_renderer)
end

function GroupFinderView:_update_incoming_join_requests(t)
	local party_immaterium = Managers.party_immaterium

	if not party_immaterium then
		return
	end

	local join_requests, version = party_immaterium:advertisement_request_to_join_list()

	if version ~= self._advertisement_join_requests_version then
		self._advertisement_join_requests_version = version
		local join_requests_update = {}

		for i = 1, #self._join_requests do
			local stored_join_request = self._join_requests[i]
			local stored_account_id = stored_join_request.account_id

			if join_requests[stored_account_id] then
				join_requests_update[#join_requests_update + 1] = stored_join_request
			end
		end

		for account_id, join_request in pairs(join_requests) do
			local found = false

			for i = 1, #self._join_requests do
				local stored_join_request = self._join_requests[i]
				local stored_account_id = stored_join_request.account_id

				if stored_account_id == account_id then
					found = true

					break
				end
			end

			if not found then
				join_requests_update[#join_requests_update + 1] = join_request
			end
		end

		self._join_requests = join_requests_update

		self:_populate_player_request_grid(self._join_requests)
	end
end

function GroupFinderView:update(dt, t, input_service)
	local party_id = self:party_id()
	local has_joined_new_party = party_id ~= self._initial_party_id
	local is_in_matchmaking = Managers.data_service.social:is_in_matchmaking()

	if (is_in_matchmaking or has_joined_new_party) and not Managers.ui:is_view_closing(self.view_name) then
		if has_joined_new_party then
			Managers.ui:close_all_views()
		else
			Managers.ui:close_view(self.view_name)
		end

		return
	end

	if self._refresh_available_timer then
		self._refresh_available_timer = self._refresh_available_timer - dt

		if self._refresh_available_timer <= 0 then
			self._refresh_available_timer = nil
		end
	end

	self:_handle_group_request_status_clearing(t)
	self:_update_group_list_time_stamp(dt, t)

	local anim_alpha_speed = 8
	local anim_preview_progress = self._anim_preview_progress or 0

	if self._previewed_group_id then
		anim_preview_progress = math.min(anim_preview_progress + dt * anim_alpha_speed, 1)
	else
		anim_preview_progress = math.max(anim_preview_progress - dt * anim_alpha_speed, 0)
	end

	local current_state = self._state

	if anim_preview_progress ~= self._anim_preview_progress then
		if self._preview_grid then
			self._preview_grid:set_alpha_multiplier(anim_preview_progress)

			self._widgets_by_name.preview_window.alpha_multiplier = anim_preview_progress
		end

		if self._tags_grid then
			self._tags_grid:set_alpha_multiplier(1 - anim_preview_progress)
		end

		local side_widgets = self._side_widgets_by_state[current_state]

		if side_widgets then
			for i = 1, #side_widgets do
				local widget = side_widgets[i]
				widget.alpha_multiplier = 1 - anim_preview_progress
			end
		end

		self._anim_preview_progress = anim_preview_progress
	end

	if current_state == STATE.browsing then
		local party_immaterium = Managers.party_immaterium

		if party_immaterium and party_immaterium:is_party_advertisement_active() then
			self:_set_state(STATE.advertising)
		else
			self:_start_advertisements_stream()
			self:_handle_incoming_advertisement_events()

			local group_grid = self._group_grid

			if group_grid:selected_grid_index() ~= self._selected_group_grid_index then
				self:_on_group_selection_changed()
			end

			local hovered_grid_index = group_grid:hovered_grid_index()
			local show_preview_input = hovered_grid_index or self._selected_group_grid_index
			self._widgets_by_name.preview_input_text.alpha_multiplier = show_preview_input and 1 or 0
			self._can_leave_group_grid_selection = group_grid:selected_grid_index() and group_grid:selected_grid_index() % 2 == 1
		end
	elseif current_state == STATE.advertising then
		local party_immaterium = Managers.party_immaterium

		if party_immaterium and party_immaterium:is_party_advertisement_active() then
			self:_handle_incoming_advertisement_events()
			self:_update_incoming_join_requests()

			local widgets_by_name = self._widgets_by_name

			ButtonPassTemplates.terminal_button_hold_small.update(self, widgets_by_name.cancel_group_button, self._ui_renderer, dt)

			local player_request_grid = self._player_request_grid

			if player_request_grid then
				local selected_grid_index = player_request_grid:selected_grid_index()
				local input_prompts_visible = selected_grid_index ~= nil and not self:using_cursor_navigation()
				widgets_by_name.player_request_button_accept.content.visible = input_prompts_visible
				widgets_by_name.player_request_button_decline.content.visible = input_prompts_visible
			end

			local own_group_visualization = self._own_group_visualization

			if own_group_visualization.group_id ~= self:party_id() then
				self:_set_state(STATE.advertising)
			end

			if self._update_listed_group_on_update then
				self:_update_listed_group()
			end
		else
			self:_set_state(STATE.browsing)
		end
	end

	self:_update_group_loading_widget(dt)
	self:_update_own_group_presentation(input_service, dt, t, self._ui_renderer)

	local world_spawner = self._world_spawner

	if world_spawner then
		world_spawner:update(dt, t)
	end

	if self._auto_continue_from_tag then
		self:_handle_next_filter_button_options(self._auto_continue_from_tag)

		self._auto_continue_from_tag = nil
	end

	local tags_grid = self._tags_grid

	if tags_grid and tags_grid:visible() ~= self._tag_grid_visibility then
		tags_grid:set_visibility(self._tag_grid_visibility)
	end

	local preview_grid = self._preview_grid

	if preview_grid and preview_grid:visible() ~= self._preview_grid_visibility then
		preview_grid:set_visibility(self._preview_grid_visibility)
	end

	return GroupFinderView.super.update(self, dt, t, input_service)
end

function GroupFinderView:can_exit()
	local widgets_by_name = self._widgets_by_name

	return GroupFinderView.super.can_exit(self)
end

function GroupFinderView:on_exit()
	local save_manager = Managers.save
	local player = self:_player()
	local character_id = player:character_id()
	local save_data = save_manager:character_data(character_id)
	local group_finder_search_tags = save_data and save_data.group_finder_search_tags

	if group_finder_search_tags then
		table.clear(group_finder_search_tags)

		local selected_tags_by_name = self._selected_tags_by_name

		for tag_name, _ in pairs(selected_tags_by_name) do
			group_finder_search_tags[#group_finder_search_tags + 1] = tag_name
		end

		save_manager:queue_save()
	end

	self._promise_container:delete()

	if self._enter_animation_id then
		self:_stop_animation(self._enter_animation_id)

		self._enter_animation_id = nil
	end

	if self._world_spawner then
		self._world_spawner:destroy()

		self._world_spawner = nil
	end

	local ui_renderer = self._ui_renderer
	local widgets_by_name = self._widgets_by_name

	for i = 1, 4 do
		local widget_name = "team_member_" .. i
		local widget = widgets_by_name[widget_name]
		local content = widget.content

		if content.slot_filled then
			self:_unload_portrait_icon(widget, ui_renderer)
		end
	end

	GroupFinderView.super.on_exit(self)
end

function GroupFinderView:ui_renderer()
	return self._ui_renderer
end

function GroupFinderView:_set_own_group_listing_widgets_visibility(visible)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.player_request_window.content.visible = visible
	widgets_by_name.created_group_party_title.content.visible = visible
	widgets_by_name.player_request_grid_title.content.visible = visible
	widgets_by_name.cancel_group_button.content.visible = visible
	widgets_by_name.team_member_1.content.visible = visible
	widgets_by_name.team_member_2.content.visible = visible
	widgets_by_name.team_member_3.content.visible = visible
	widgets_by_name.team_member_4.content.visible = visible
	widgets_by_name.own_group_presentation.content.visible = visible
	widgets_by_name.player_request_button_accept.content.visible = false
	widgets_by_name.player_request_button_decline.content.visible = false

	if self._player_request_grid then
		self._player_request_grid:set_visibility(visible)
	end
end

function GroupFinderView:_set_group_browsing_widgets_visibility(visible)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.group_window.content.visible = visible
	widgets_by_name.join_button.content.visible = visible
	widgets_by_name.refresh_button.content.visible = visible
	widgets_by_name.preview_input_text.content.visible = visible
	widgets_by_name.group_list_time_stamp.content.visible = visible
	widgets_by_name.join_button_level_warning.content.visible = visible

	self:_set_start_group_widgets_visibility(visible)

	if self._group_grid then
		self._group_grid:set_visibility(visible)
	end
end

function GroupFinderView:_set_group_list_empty_info_visibility(visible)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.group_window_info.content.visible = visible
end

function GroupFinderView:_set_start_group_widgets_visibility(visible)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.start_group_button_level_warning.content.visible = visible
	widgets_by_name.start_group_button_party_full_warning.content.visible = visible
	widgets_by_name.start_group_button.content.visible = visible
	widgets_by_name.previous_filter_button.content.visible = visible
	widgets_by_name.start_group_button_header.content.visible = visible
	widgets_by_name.category_description.content.visible = visible
	widgets_by_name.filter_page_divider_top.content.visible = visible
	widgets_by_name.filter_page_divider_bottom.content.visible = visible
end

function GroupFinderView:event_party_composition_changed()
	if self._state == STATE.advertising then
		self:_update_listed_group()
	end

	self:_update_party_statuses()
end

function GroupFinderView:_update_party_statuses()
	local player_composition_name_party = "party"
	local party_players = PlayerCompositions.players(player_composition_name_party, {})
	local lowest_party_member_level = math.huge
	local num_party_members = 0

	for _, player in pairs(party_players) do
		num_party_members = num_party_members + 1
		local profile = player:profile()
		local current_level = profile and profile.current_level or 1

		if lowest_party_member_level > current_level then
			lowest_party_member_level = current_level
		end
	end

	self._lowest_party_member_level = lowest_party_member_level
	self._is_party_full = num_party_members >= 4

	self:_update_tag_navigation_buttons_status()
end

function GroupFinderView:_update_listed_group()
	if self._update_listed_group_on_update then
		self._update_listed_group_on_update = false
	end

	local widgets_by_name = self._widgets_by_name
	local player_composition_name_party = "party"
	local temp_team_players = {}
	local players_sorted_by_name = {}
	local party_players = PlayerCompositions.players(player_composition_name_party, temp_team_players)

	for _, player in pairs(party_players) do
		players_sorted_by_name[#players_sorted_by_name + 1] = player
	end

	table.sort(players_sorted_by_name, function (a, b)
		return a:name() < b:name()
	end)

	local own_group_visualization = self._own_group_visualization
	local members = own_group_visualization.members

	for i = 1, 4 do
		local player = players_sorted_by_name[i]
		local widget_name = "team_member_" .. i
		local widget = widgets_by_name[widget_name]
		local content = widget.content
		local style = widget.style
		local profile = player and player:profile()

		if player and profile then
			local social_service_manager = Managers.data_service.social
			local player_info = social_service_manager and social_service_manager:get_player_info_by_account_id(player:account_id())
			local platform = player_info and player_info:platform() or ""
			local character_archetype_title = ProfileUtils.character_archetype_title(profile)
			local character_level = tostring(profile.current_level) .. " "
			local havoc_rank_cadence_high = player_info._presence:havoc_rank_cadence_high()

			if havoc_rank_cadence_high ~= nil and profile.current_level ~= nil and profile.current_level >= 30 then
				local havoc_prefix_text = Localize("loc_havoc_highest_order_reached")
				local havoc_highest_cadence_rank = "- " .. havoc_prefix_text .. " " .. tostring(havoc_rank_cadence_high) .. " "
				content.character_archetype_title = string.format("%s %s", character_archetype_title, havoc_highest_cadence_rank)
			else
				content.character_archetype_title = string.format("%s %s", character_archetype_title, character_level)
			end

			if IS_PLAYSTATION and (platform == "psn" or platform == "ps5") then
				content.character_name = player_info:user_display_name()
			else
				content.character_name = player:name()
			end

			local archetype = profile.archetype
			content.archetype_icon = archetype.archetype_icon_selection_large_unselected
			local player_title = ProfileUtils.character_title(profile)

			if player_title then
				content.character_title = player_title
			end

			if not player_title or player_title == "" then
				style.character_name.offset[2] = -12
				style.character_archetype_title.offset[2] = -1
			else
				style.character_name.offset[2] = -30
				style.character_archetype_title.offset[2] = 12
			end

			if content.slot_filled then
				local ui_renderer = self._ui_renderer

				self:_unload_portrait_icon(widget, ui_renderer)
			end

			self:_request_player_icon(profile, widget)

			local loadout = profile.loadout
			local frame_item = loadout and loadout.slot_portrait_frame

			if frame_item then
				local cb = callback(self, "_cb_set_player_frame", widget)
				widget.content.frame_load_id = Managers.ui:load_item_icon(frame_item, cb)
			end

			local insignia_item = loadout and loadout.slot_insignia

			if insignia_item then
				local cb = callback(self, "_cb_set_player_insignia", widget)
				widget.content.insignia_load_id = Managers.ui:load_item_icon(insignia_item, cb)
			end

			if not members[i] then
				members[i] = {
					presence_info = {}
				}
			end

			members[i].account_id = player:account_id()
			members[i].presence_info.archetype = archetype.name
			members[i].havoc_rank_cadence_high = havoc_rank_cadence_high
			members[i].presence_info.synced = true
			content.slot_filled = true
		else
			if player and not profile then
				self._update_listed_group_on_update = true
			end

			if members[i] then
				members[i] = nil
			end

			content.slot_filled = false
		end
	end
end

function GroupFinderView:_cb_set_player_frame(widget, item)
	local material_values = widget.style.character_portrait.material_values
	material_values.portrait_frame_texture = item.icon
end

function GroupFinderView:_cb_set_player_insignia(widget, item)
	local icon_style = widget.style.character_insignia
	local material_values = icon_style.material_values

	if item.icon_material and item.icon_material ~= "" then
		if material_values.texture_map then
			material_values.texture_map = nil
		end

		widget.content.character_insignia = item.icon_material
	else
		material_values.texture_map = item.icon
	end

	icon_style.color[1] = 255
end

function GroupFinderView:_request_player_icon(profile, widget)
	local material_values = widget.style.character_portrait.material_values
	material_values.use_placeholder_texture = 1

	self:_load_portrait_icon(profile, widget)
end

function GroupFinderView:_load_portrait_icon(profile, widget)
	local load_cb = callback(self, "_cb_set_player_icon", widget)
	local unload_cb = callback(self, "_cb_unset_player_icon", widget)
	widget.content.icon_load_id = Managers.ui:load_profile_portrait(profile, load_cb, nil, unload_cb)
end

function GroupFinderView:_cb_set_player_icon(widget, grid_index, rows, columns, render_target)
	local material_values = widget.style.character_portrait.material_values
	widget.content.character_portrait = "content/ui/materials/base/ui_portrait_frame_base"
	material_values.use_placeholder_texture = 0
	material_values.rows = rows
	material_values.columns = columns
	material_values.grid_index = grid_index - 1
	material_values.texture_icon = render_target
end

function GroupFinderView:_cb_unset_player_icon(widget)
	local material_values = widget.style.character_portrait.material_values
	material_values.use_placeholder_texture = nil
	material_values.rows = nil
	material_values.columns = nil
	material_values.grid_index = nil
	material_values.texture_icon = nil
	widget.content.character_portrait = "content/ui/materials/base/ui_portrait_frame_base_no_render"
end

function GroupFinderView:_unload_portrait_icon(widget, ui_renderer)
	UIWidget.set_visible(widget, ui_renderer, false)

	local icon_load_id = widget.content.icon_load_id
	local frame_load_id = widget.content.frame_load_id
	local insignia_load_id = widget.content.insignia_load_id

	if icon_load_id then
		Managers.ui:unload_profile_portrait(icon_load_id)

		widget.content.icon_load_id = nil
	end

	if frame_load_id then
		Managers.ui:unload_item_icon(frame_load_id)

		widget.content.frame_load_id = nil
	end

	if insignia_load_id then
		Managers.ui:unload_item_icon(insignia_load_id)

		widget.content.insignia_load_id = nil
		local icon_style = widget.style.character_insignia
		icon_style.color[1] = 0
	end
end

function GroupFinderView:_is_table_containing_tags(source_tags, tags)
	for i = 1, #tags do
		local tag = tags[i]
		local tag_name = tag.name
		local found = false

		for j = 1, #source_tags do
			local source_tag = source_tags[j]
			local source_tag_name = source_tag.name

			if source_tag_name == tag_name then
				found = true
			end
		end

		if not found then
			return false
		end
	end

	return true
end

function GroupFinderView:_update_group_grid(optional_complete_callback)
	self._selected_group_id = nil
	self._selected_group_grid_index = nil
	local groups = self._groups

	self:_populate_group_grid(groups, optional_complete_callback)
end

function GroupFinderView:_is_searching()
	return self._search_connection and #self._found_groups == 0
end

function GroupFinderView:_reset_search()
	self:_set_group_list_empty_info_visibility(false)

	self._groups = {}

	self:_update_group_grid()

	if self._search_connection_id then
		local abort_promise, _ = self._promise_container:cancel_on_destroy(Managers.grpc:abort_operation(self._search_connection_id))

		abort_promise:next(function ()
			Log.info("GroupFinderView", "STREAM CLOSED")

			self._found_groups = {}
			self._search_connection_promise = nil
			self._search_connection_id = nil
		end)

		return abort_promise
	end
end

function GroupFinderView:_start_advertisements_stream()
	local grpc = Managers.grpc

	if not self._search_connection_promise and not self._refresh_promise then
		Log.info("GroupFinderView", "OPEN STREAM")

		local region = BackendUtilities.prefered_mission_region
		local tags = self._selected_tags
		local tags_for_group_search = {}

		for i = 1, #tags do
			if tags[i].name then
				table.insert(tags_for_group_search, tags[i].name)
			end
		end

		Log.info("GroupFinderView", "Category: " .. region .. ", Tags: " .. table.concat(tags_for_group_search, ", "))

		self._show_group_loading = true
		self._groups = {}

		self:_update_group_grid()

		self._group_list_initialized = false
		local promise, id = grpc:party_finder_list_advertisements_stream(region, tags_for_group_search)

		if not promise then
			Log.error("GroupFinderView", "Failed to start advertisement stream: promise is nil")

			return
		end

		self._promise_container:cancel_on_destroy(promise)

		self._search_connection_id = id

		Log.info("GroupFinderView", "Stream ID: " .. tostring(self._search_connection_id))

		self._search_connection_promise = promise

		promise:next(function ()
			Log.info("GroupFinderView", "STREAM CLOSED")

			self._search_connection_promise = nil
		end):catch(function (error)
			if error.aborted then
				Log.info("GroupFinderView", "STREAM ABORTED " .. tostring(id))
			else
				Log.error("GroupFinderView", "STREAM ERROR")
				Log.error("GroupFinderView", table.tostring(error, 10))
			end
		end)
	end
end

function GroupFinderView:party_id()
	local party_immaterium = Managers.party_immaterium

	return party_immaterium and party_immaterium:party_id()
end

function GroupFinderView:_handle_incoming_advertisement_events()
	local search_connection_id = self._search_connection_id

	if not search_connection_id then
		return
	end

	local grpc = Managers.grpc
	local events = grpc:get_party_finder_list_advertisements_events(tostring(search_connection_id))

	if not events then
		return
	end

	local state = self._state
	local group_list_initialized = self._group_list_initialized
	local player = self:_player()
	local profile = player:profile()
	local current_level = profile and profile.current_level or 0

	Log.info("GroupFinderView", "Received Events: " .. table.tostring(events, 10))

	for j = 1, #events do
		local event = events[j]
		local event_type = event.type

		Log.info("GroupFinderView", "Processing event type: " .. tostring(event_type))

		if event_type == "advertisement_entries_update" then
			if state == STATE.browsing and not self._group_list_initialized then
				group_list_initialized = true
				local entries = event.entries
				local groups = {}

				for i = 1, #entries do
					local entry = entries[i]
					local entry_tags = entry.tags
					local entry_metadata = entry.config or {}
					local group_tags = {}

					for k = 1, #entry_tags do
						local tag_name = entry_tags[k]
						local tag = self:_get_tag_by_name(tag_name)

						if tag and not tag.root_tag then
							table.insert(group_tags, tag)
						end
					end

					table.sort(group_tags, _tags_sort_function)

					local group_metadata = {}

					if entry_metadata and next(entry_metadata) then
						local havoc_circumstances = {}

						for key, value in pairs(entry_metadata) do
							if key:find("^havoc_circ") then
								havoc_circumstances[#havoc_circumstances + 1] = value
							end
						end

						group_metadata = {
							havoc_order_rank = entry_metadata.havoc_order_rank,
							havoc_mission_template = entry_metadata.havoc_mission_template,
							havoc_theme = entry_metadata.havoc_theme,
							havoc_circumstances = havoc_circumstances
						}
					end

					local filtered_tags = {}

					if group_metadata and next(group_metadata) then
						if group_metadata.havoc_mission_template then
							local mission_template = MissionTemplates[group_metadata.havoc_mission_template]
							local mission_name = Localize(mission_template.mission_name)
							filtered_tags[#filtered_tags + 1] = {
								text = mission_name
							}
						end

						if group_metadata.havoc_circumstances then
							for n = 1, math.min(4, #group_metadata.havoc_circumstances) do
								local circumstance = group_metadata.havoc_circumstances[n]
								local circumstance_template = CircumstanceTemplates[circumstance]
								local circumstance_name = Localize(circumstance_template.ui.display_name)
								filtered_tags[#filtered_tags + 1] = {
									text = circumstance_name
								}
							end
						end
					end

					if group_tags then
						for _, tag in ipairs(group_tags) do
							if tag.name ~= "my_havoc_order" then
								filtered_tags[#filtered_tags + 1] = tag
							end
						end
					end

					local description = self:_generate_tags_description(filtered_tags)
					local required_level = self:_get_highest_tag_level_requirement(group_tags) or 0
					local level_requirement_met = current_level >= required_level
					local group = {
						tags = filtered_tags,
						metadata = group_metadata,
						id = entry.party_id,
						members = {},
						version = entry.version,
						description = description,
						required_level = required_level,
						level_requirement_met = level_requirement_met
					}
					groups[#groups + 1] = group
				end

				self._groups = groups
			end
		elseif event_type == "party_update" then
			Log.info("GroupFinderView", "Updating participants from party update: " .. table.tostring(event, 10))

			local party = event.party
			local members = party and party.members

			if not members then
				return
			end

			if state == STATE.advertising then
				if party.party_id == self:party_id() then
					break
				end
			elseif state == STATE.browsing then
				local party_id = party.party_id
				local group = self:_group_by_id(party_id)

				if group then
					local group_members = group.members

					for i = #group_members, 1, -1 do
						local group_member = group_members[i]
						local group_member_account_id = group_member.account_id
						local remove = true

						for _, member in ipairs(members) do
							if group_member_account_id == member.account_id then
								remove = false

								break
							end
						end

						if remove then
							table.remove(group_members, i)
						end
					end

					for _, member in ipairs(members) do
						local member_status = member.status

						if member_status == "CONNECTED" then
							local member_account_id = member.account_id
							local group_member = group_members[member_account_id]

							if not group_member then
								group_member = {
									account_id = member_account_id,
									presence_info = {}
								}
								group_members[#group_members + 1] = group_member
							end

							local _, promise = Managers.presence:get_presence(member_account_id)

							self._promise_container:cancel_on_destroy(promise)
							promise:next(function (data)
								if not data then
									return
								end

								local member_group = self:_group_by_id(party_id)
								local member_group_members = member_group and member_group.members
								local member_data = nil

								if member_group_members then
									for i = 1, #member_group_members do
										if member_group_members[i].account_id == member_account_id then
											member_data = member_group_members[i]

											break
										end
									end
								end

								if member_data then
									local presence_info = member_data.presence_info
									local parsed_character_profile = data._parsed_character_profile

									if parsed_character_profile then
										local name = parsed_character_profile.name
										local member_current_level = parsed_character_profile.current_level
										local archetype = parsed_character_profile.archetype
										local archetype_name = archetype.name
										presence_info.name = name
										presence_info.level = member_current_level
										presence_info.archetype = archetype_name
										presence_info.profile = parsed_character_profile
										presence_info.havoc_rank_cadence_high = data:havoc_rank_cadence_high()
										presence_info.synced = true
									end
								end
							end):catch(function (error)
								Log.error("GroupFinder", "Presence failed")

								local account_members = self:_group_by_id(party_id)

								if account_members then
									for i = 1, #account_members do
										if account_members[i].account_id == member_account_id then
											table.remove(account_members, i)

											break
										end
									end
								end
							end)
						end
					end
				end
			end
		end
	end

	if state == STATE.browsing and not self._group_list_initialized and group_list_initialized then
		self._group_list_initialized = group_list_initialized
		local cb_on_grid_popluated = callback(function ()
			if self._group_list_initialized then
				self._show_group_loading = false
				local is_list_empty = #self._groups <= 0

				self:_set_group_list_empty_info_visibility(is_list_empty)

				self._last_time_group_list_updated = Managers.ui:get_time("ui")
			end
		end)

		self:_update_group_grid(cb_on_grid_popluated)
	end
end

function GroupFinderView:_populate_preview_grid(layout)
	local definitions = self._definitions

	if not self._preview_grid then
		local grid_scenegraph_id = "preview_grid"
		local window_scenegraph_id = "preview_window"
		local scenegraph_definition = definitions.scenegraph_definition
		local window_scenegraph = scenegraph_definition[window_scenegraph_id]
		local grid_size = window_scenegraph.size
		local grid_settings = {
			scrollbar_vertical_margin = 0,
			widget_icon_load_margin = 0,
			scrollbar_width = 7,
			edge_padding = 0,
			scrollbar_horizontal_offset = -5,
			hide_dividers = true,
			resource_renderer_background = false,
			enable_gamepad_scrolling = true,
			top_padding = 0,
			title_height = 0,
			scrollbar_vertical_offset = 0,
			hide_background = true,
			grid_size = grid_size,
			mask_size = {
				grid_size[1] + 200,
				grid_size[2] - 20
			},
			grid_spacing = {
				0,
				0
			}
		}
		local layer = (self._draw_layer or 0) + 40
		self._preview_grid = self:_add_element(ViewElementGrid, "preview_grid", layer, grid_settings, grid_scenegraph_id)

		self._preview_grid:set_alpha_multiplier(0)

		self._widgets_by_name.preview_window.alpha_multiplier = 0

		self:_update_element_position("preview_grid", self._preview_grid)
		self._preview_grid:set_empty_message("")
	end

	local grid = self._preview_grid

	grid:present_grid_layout(layout, GroupFinderViewDefinitions.grid_blueprints)
	grid:set_handle_grid_navigation(true)
	self:_set_preview_grid_visibility(true)
end

function GroupFinderView:_set_preview_grid_visibility(visible)
	self._preview_grid_visibility = visible
	self._widgets_by_name.preview_window.content.visible = visible
end

function GroupFinderView:_populate_tags_grid(layout, optional_grid_spacing)
	local definitions = self._definitions

	if not self._tags_grid then
		local grid_scenegraph_id = "tags_grid"
		local scenegraph_definition = definitions.scenegraph_definition
		local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
		local grid_size = grid_scenegraph.size
		local mask_padding_size = 0
		local grid_settings = {
			scrollbar_width = 7,
			hide_dividers = true,
			widget_icon_load_margin = 0,
			enable_gamepad_scrolling = false,
			title_height = 0,
			scrollbar_horizontal_offset = 17,
			hide_background = true,
			grid_size = grid_size,
			mask_size = {
				grid_size[1] + 20,
				grid_size[2] + mask_padding_size
			},
			grid_spacing = {
				0,
				0
			}
		}
		local layer = (self._draw_layer or 0) + 10
		self._tags_grid = self:_add_element(ViewElementGrid, "tags_grid", layer, grid_settings, grid_scenegraph_id)

		self:_update_element_position("tags_grid", self._tags_grid)
		self._tags_grid:set_empty_message("")
	end

	local grid = self._tags_grid
	local menu_settings = grid:menu_settings()

	if optional_grid_spacing then
		menu_settings.grid_spacing[1] = optional_grid_spacing[1] or 0
		menu_settings.grid_spacing[2] = optional_grid_spacing[2] or 0
	else
		menu_settings.grid_spacing[1] = 0
		menu_settings.grid_spacing[2] = 0
	end

	local cb_on_grid_layout_updated = callback(self, "_on_populate_tags_grid_completed")

	grid:present_grid_layout(layout, GroupFinderViewDefinitions.grid_blueprints, nil, nil, nil, nil, cb_on_grid_layout_updated)
	grid:set_handle_grid_navigation(true)
end

function GroupFinderView:_on_populate_tags_grid_completed()
	self:_update_tag_widgets()
	self:_update_tag_navigation_buttons_status()

	local grid = self._tags_grid
	local widgets = grid:widgets()

	if self._tag_grid_enter_animation_id then
		self:_stop_animation(self._tag_grid_enter_animation_id)

		self._tag_grid_enter_animation_id = nil
	end

	for _, widget in pairs(widgets) do
		widget.alpha_multiplier = 0
	end

	self._tag_grid_enter_animation_id = self:_start_animation("tag_grid_entry", widgets, self)

	if not self:using_cursor_navigation() then
		grid:select_first_index()
	end
end

function GroupFinderView:_set_tag_grid_visibility(visible)
	self._tag_grid_visibility = visible
end

function GroupFinderView:_populate_group_grid(groups, optional_complete_callback)
	local definitions = self._definitions
	local grid_scenegraph_id = "group_grid"
	local scenegraph_definition = definitions.scenegraph_definition
	local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
	local grid_size = grid_scenegraph.size

	if not self._group_grid then
		local mask_padding_size = 0
		local grid_settings = {
			scrollbar_vertical_margin = 0,
			widget_icon_load_margin = 0,
			scrollbar_vertical_offset = 0,
			use_select_on_focused = true,
			hide_dividers = true,
			enable_gamepad_scrolling = true,
			top_padding = 0,
			scrollbar_width = 7,
			title_height = 0,
			scrollbar_horizontal_offset = 17,
			hide_background = true,
			grid_size = grid_size,
			mask_size = {
				grid_size[1] + 20,
				grid_size[2] + mask_padding_size
			},
			grid_spacing = {
				0,
				10
			}
		}
		local layer = (self._draw_layer or 0) + 10
		self._group_grid = self:_add_element(ViewElementGrid, "group_grid", layer, grid_settings, grid_scenegraph_id)

		self:_update_element_position("group_grid", self._group_grid)
		self._group_grid:set_empty_message("")
	end

	local grid = self._group_grid
	local layout = {
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				grid_size[1],
				10
			}
		}
	}

	for i = 1, #groups do
		local group = groups[i]
		local entry = {
			widget_type = "group",
			group = group,
			description = group.description,
			group_id = group.id,
			tags = group.tags,
			metadata = group.metadata,
			required_level = group.required_level,
			level_requirement_met = group.level_requirement_met,
			group_request_status_callback = function ()
				return self:_get_group_request_status(group.id)
			end,
			pressed_callback = callback(self, "_cb_on_list_group_pressed", entry, i)
		}
		layout[#layout + 1] = entry

		if i % 2 == 1 and i < #groups then
			layout[#layout + 1] = {
				widget_type = "dynamic_spacing",
				size = {
					10,
					10
				}
			}
		end
	end

	layout[#layout + 1] = {
		widget_type = "dynamic_spacing",
		size = {
			grid_size[1],
			10
		}
	}

	grid:present_grid_layout(layout, GroupFinderViewDefinitions.grid_blueprints, nil, nil, nil, nil, optional_complete_callback)
	grid:set_handle_grid_navigation(true)
end

function GroupFinderView:_populate_player_request_grid(join_requests)
	local definitions = self._definitions
	local grid_scenegraph_id = "player_request_grid"
	local scenegraph_definition = definitions.scenegraph_definition
	local grid_scenegraph = scenegraph_definition[grid_scenegraph_id]
	local grid_size = grid_scenegraph.size

	if not self._player_request_grid then
		local mask_padding_size = 0
		local grid_settings = {
			scrollbar_width = 7,
			hide_dividers = true,
			widget_icon_load_margin = 0,
			scrollbar_vertical_offset = 10,
			enable_gamepad_scrolling = true,
			title_height = 0,
			scrollbar_horizontal_offset = 13,
			hide_background = true,
			grid_size = grid_size,
			mask_size = {
				grid_size[1] + 20,
				grid_size[2] + mask_padding_size
			},
			grid_spacing = {
				0,
				10
			}
		}
		local layer = (self._draw_layer or 0) + 10
		self._player_request_grid = self:_add_element(ViewElementGrid, "player_request_grid", layer, grid_settings, grid_scenegraph_id)

		self:_update_element_position("player_request_grid", self._player_request_grid)
		self._player_request_grid:set_empty_message("")
	end

	local grid = self._player_request_grid
	local layout = {
		[#layout + 1] = {
			widget_type = "dynamic_spacing",
			size = {
				grid_size[1],
				15
			}
		}
	}

	for i = 1, #join_requests do
		local join_request = join_requests[i]
		local presence = join_request.presence

		if presence then
			local name = presence:character_name()
			local profile = presence:character_profile()
			local current_level = profile.current_level
			local archetype = profile.archetype
			local archetype_name = archetype.name
			local havoc_rank_cadence_high = presence:havoc_rank_cadence_high()
			local presence_info = {
				name = name,
				level = current_level,
				archetype = archetype_name,
				profile = profile,
				havoc_rank_cadence_high = havoc_rank_cadence_high
			}
			local entry = {
				widget_type = "player_request_entry",
				presence_info = presence_info,
				join_request = join_request,
				account_id = join_request.account_id,
				accept_callback = callback(self, "_cb_on_player_request_accept_pressed", entry),
				decline_callback = callback(self, "_cb_on_player_request_decline_pressed", entry)
			}
			layout[#layout + 1] = entry
		end
	end

	layout[#layout + 1] = {
		widget_type = "dynamic_spacing",
		size = {
			grid_size[1],
			15
		}
	}
	local current_selected_grid_index = grid:selected_grid_index()
	local scrollbar_progress = grid:length_scrolled()
	local cb_on_grid_layout_updated = callback(self, "_on_populate_player_request_grid_completed", current_selected_grid_index, scrollbar_progress)

	grid:present_grid_layout(layout, GroupFinderViewDefinitions.grid_blueprints, nil, nil, nil, nil, cb_on_grid_layout_updated)
	grid:set_handle_grid_navigation(true)
end

function GroupFinderView:_on_populate_player_request_grid_completed(current_selected_grid_index, scrollbar_progress)
	if not self:using_cursor_navigation() then
		if self._state == STATE.advertising then
			local grid = self._player_request_grid

			if current_selected_grid_index then
				grid:select_grid_index(current_selected_grid_index)

				if not grid:selected_grid_index() then
					grid:select_first_index()
				end
			else
				grid:select_first_index()
			end
		end
	else
		local grid = self._player_request_grid
		local scroll_length = grid:scroll_length()

		grid:set_scrollbar_progress(scrollbar_progress / scroll_length, true)
	end
end

local _dummy_text_size = {
	800,
	50
}

function GroupFinderView:_update_player_request_button_decline()
	local action = self._player_request_button_decline_input_action
	local service_type = "View"
	local include_input_type = false
	local text = TextUtils.localize_with_button_hint(action, "loc_group_finder_player_request_action_decline", nil, service_type, Localize("loc_input_legend_text_template"), include_input_type)
	local widget = self._widgets_by_name.player_request_button_decline
	widget.content.text = text

	if self:using_cursor_navigation() then
		widget.alpha_multiplier = 0
	else
		widget.alpha_multiplier = 1
	end

	local width = self:_text_size_for_style(text, widget.style.text, _dummy_text_size)

	self:_set_scenegraph_size("player_request_button_decline", width + 10)
	self:_force_update_scenegraph()
end

function GroupFinderView:_update_player_request_button_accept()
	local action = self._player_request_button_accept_input_action
	local service_type = "View"
	local include_input_type = false
	local text = TextUtils.localize_with_button_hint(action, "loc_group_finder_player_request_action_accept", nil, service_type, Localize("loc_input_legend_text_template"), include_input_type)
	local widget = self._widgets_by_name.player_request_button_accept
	widget.content.text = text

	if self:using_cursor_navigation() then
		widget.alpha_multiplier = 0
	else
		widget.alpha_multiplier = 1
	end

	local width = self:_text_size_for_style(text, widget.style.text, _dummy_text_size)

	self:_set_scenegraph_size("player_request_button_accept", width + 10)
	self:_set_scenegraph_position("player_request_button_accept", -(width + 10 + 30))
	self:_force_update_scenegraph()
end

function GroupFinderView:_update_preview_input_text()
	local action = self._preview_button_input_action
	local service_type = "View"
	local include_input_type = false
	local text = TextUtils.localize_with_button_hint(action, "loc_mission_voting_view_show_details", nil, service_type, Localize("loc_input_legend_text_template"), include_input_type)
	local widget = self._widgets_by_name.preview_input_text
	widget.content.text = text
	local width = self:_text_size_for_style(text, widget.style.text, _dummy_text_size)

	self:_set_scenegraph_size("preview_input_text", width + 10)
end

function GroupFinderView:_update_refresh_button_text()
	local action = self._refresh_button_input_action
	local service_type = "View"
	local include_input_type = false
	local text = TextUtils.localize_with_button_hint(action, "loc_group_finder_refresh_group_list_button", nil, service_type, Localize("loc_input_legend_text_template"), include_input_type)
	local widget = self._widgets_by_name.refresh_button
	widget.content.text = text
	local width = self:_text_size_for_style(text, widget.style.text, _dummy_text_size)

	self:_set_scenegraph_size("refresh_button", width + 10)
end

function GroupFinderView:_on_navigation_input_changed()
	GroupFinderView.super._on_navigation_input_changed(self)
	self:_update_grids_selection()
	self:_update_player_request_button_accept()
	self:_update_player_request_button_decline()
	self:_update_refresh_button_text()
	self:_update_preview_input_text()
end

function GroupFinderView:_update_grids_selection()
	local using_cursor_navigation = self:using_cursor_navigation()
	local state = self._state
	local tags_grid = self._tags_grid
	local group_grid = self._group_grid
	local player_request_grid = self._player_request_grid

	if using_cursor_navigation then
		if tags_grid then
			tags_grid:select_grid_index(nil)
		end

		if group_grid then
			group_grid:select_grid_index(nil)
		end

		if player_request_grid then
			player_request_grid:select_grid_index(nil)
		end
	elseif state == STATE.advertising then
		if tags_grid then
			tags_grid:select_grid_index(nil)
		end

		if group_grid then
			group_grid:select_grid_index(nil)
		end

		if player_request_grid and not player_request_grid:selected_grid_index() then
			player_request_grid:select_first_index()
		end
	elseif state == STATE.browsing then
		if player_request_grid then
			player_request_grid:select_grid_index(nil)
		end

		if not tags_grid:selected_grid_index() then
			tags_grid:select_first_index()
			group_grid:select_grid_index(nil)
		end
	end
end

function GroupFinderView:_callback_open_options(region_data)
	self._mission_board_options = self:_add_element(ViewElementMissionBoardOptions, "mission_board_options_element", 200, {
		on_destroy_callback = callback(self, "_callback_close_options")
	})
	local regions_latency = self._regions_latency
	local presentation_data = {
		{
			widget_type = "dropdown",
			display_name = "loc_mission_board_view_options_Matchmaking_Location",
			id = "region_matchmaking",
			tooltip_text = "loc_matchmaking_change_region_confirmation_desc",
			validation_function = function ()
				return
			end,
			on_activated = function (value, template)
				BackendUtilities.prefered_mission_region = value
			end,
			get_function = function (template)
				local options = template.options_function()

				for i = 1, #options do
					local option = options[i]

					if option.value == BackendUtilities.prefered_mission_region then
						return option.id
					end
				end

				return 1
			end,
			options_function = function (template)
				local options = {}

				for region_name, latency_data in pairs(regions_latency) do
					local loc_key = RegionLocalizationMappings[region_name]
					local ignore_localization = true
					local region_display_name = loc_key and Localize(loc_key) or region_name

					if math.abs(latency_data.min_latency - latency_data.max_latency) < 5 then
						region_display_name = string.format("%s %dms", region_display_name, latency_data.min_latency)
					else
						region_display_name = string.format("%s %d-%dms", region_display_name, latency_data.min_latency, latency_data.max_latency)
					end

					options[#options + 1] = {
						id = region_name,
						display_name = region_display_name,
						ignore_localization = ignore_localization,
						value = region_name,
						latency_order = latency_data.min_latency
					}
				end

				table.sort(options, function (a, b)
					return a.latency_order < b.latency_order
				end)

				return options
			end,
			on_changed = function (value)
				BackendUtilities.prefered_mission_region = value
			end
		},
		{
			id = "private_match",
			display_name = "loc_private_tag_name",
			tooltip_text = "loc_mission_board_view_options_private_game_desc",
			widget_type = "checkbox",
			start_value = self._private_match,
			get_function = function ()
				return self._private_match
			end,
			on_activated = function (value, data)
				data.changed_callback(value)
			end,
			on_changed = function (value)
				self:_callback_toggle_private_matchmaking()
			end
		}
	}

	self._mission_board_options:present(presentation_data)
end

function GroupFinderView:_callback_close_options()
	self:_destroy_options_element()
end

function GroupFinderView:_destroy_options_element()
	self:_remove_element("mission_board_options_element")

	self._mission_board_options = nil
end

function GroupFinderView:fetch_regions()
	local region_promise = Managers.backend.interfaces.region_latency:get_region_latencies()
	self._region_promise = region_promise

	self._promise_container:cancel_on_destroy(region_promise):next(function (regions_data)
		local prefered_region_promise = nil

		if BackendUtilities.prefered_mission_region == "" then
			prefered_region_promise = self._promise_container:cancel_on_destroy(Managers.backend.interfaces.region_latency:get_preferred_reef())
		else
			prefered_region_promise = Promise.resolved()
		end

		prefered_region_promise:next(function (prefered_region)
			BackendUtilities.prefered_mission_region = BackendUtilities.prefered_mission_region ~= "" and BackendUtilities.prefered_mission_region or prefered_region or regions_data[1].reefs[1]
			local regions_latency = Managers.backend.interfaces.region_latency:get_reef_info_based_on_region_latencies(regions_data)
			self._regions_latency = regions_latency
			self._region_promise = nil
		end)
	end)

	return region_promise
end

function GroupFinderView:get_havoc_order_metadata()
	Managers.data_service.havoc:available_orders():next(function (havoc_order)
		if not havoc_order or not havoc_order[1] then
			return
		end

		local current_havoc_order = havoc_order[1]
		local blueprint = current_havoc_order.blueprint or {}
		local data = current_havoc_order.data or {}
		local havoc_order_id = current_havoc_order.id
		local havoc_order_rank = data.rank and tostring(data.rank)
		local havoc_mission_template = blueprint.template and blueprint.template.id
		local flags = blueprint.flags or {}

		if not havoc_order_id or not havoc_order_rank or not havoc_mission_template or not next(flags) then
			Log.warn("Havoc order data is incomplete for:", current_havoc_order)

			return
		end

		local metadata_to_add = {
			havoc_order_owner = self:_player():account_id(),
			havoc_order_id = havoc_order_id,
			havoc_order_rank = havoc_order_rank,
			havoc_mission_template = havoc_mission_template
		}
		local circ_counter = 1

		for flag, _ in pairs(flags) do
			if flag:find("^havoc%-circ%-") then
				metadata_to_add["havoc_circ_" .. circ_counter] = flag:sub(#"havoc-circ-" + 1)
				circ_counter = circ_counter + 1
			elseif flag:find("^havoc%-theme%-") then
				metadata_to_add.havoc_theme = flag:sub(#"havoc-theme-" + 1)
			elseif flag:find("^havoc%-threshold%-") then
				self._havoc_threshold_tag_to_inject = flag:sub(#"havoc-threshold-" + 1)
			end
		end

		for key, value in pairs(metadata_to_add) do
			self._metadata_for_selected_tags[key] = value
		end

		self._has_active_havoc_order = true
	end)
end

function GroupFinderView:_callback_toggle_private_matchmaking()
	self._private_match = not self._private_match

	if self._solo_play then
		self._solo_play = false
	end

	self:_set_play_button_game_mode_text(self._solo_play, self._private_match)

	local mission_board_save_data = self._mission_board_save_data

	if mission_board_save_data then
		local changed = false

		if self._private_match ~= mission_board_save_data.private_matchmaking then
			mission_board_save_data.private_matchmaking = self._private_match
			changed = true
		end

		if changed then
			Managers.save:queue_save()
		end
	end
end

return GroupFinderView
