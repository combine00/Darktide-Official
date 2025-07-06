local BaseViewTestify = GameParameters.testify and require("scripts/ui/views/base_view_testify")
local InputUtils = require("scripts/managers/input/input_utils")
local UIFonts = require("scripts/managers/ui/ui_fonts")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIScenegraph = require("scripts/managers/ui/ui_scenegraph")
local UISequenceAnimator = require("scripts/managers/ui/ui_sequence_animator")
local UIWidget = require("scripts/managers/ui/ui_widget")
local BaseView = class("BaseView")

function BaseView:init(definitions, settings, context, dynamic_package_name)
	self:_create_ui_renderer(context)

	self._allow_close_hotkey = false
	self._pass_input = false
	self._pass_draw = true
	self._definitions = definitions
	self._settings = settings
	self._event_list = {}
	self._elements = {}
	self._elements_array = {}
	self._element_to_pivot = {}
	self._local_player_id = 1
	self._loading = true
	local view_name = settings.name
	self.view_name = view_name
	local on_load_callback = callback(self, "_on_view_load_complete", true)
	self._should_unload = Managers.ui:load_view(view_name, self.__class_name, on_load_callback, dynamic_package_name)
	self._hub_interaction = context and not not context.hub_interaction
end

function BaseView:_create_ui_renderer(context)
	local ui_renderer = context and context.ui_renderer

	if ui_renderer then
		self._ui_renderer = ui_renderer
		self._ui_renderer_is_external = true
	else
		self._ui_renderer = Managers.ui:create_renderer(self.__class_name .. "_ui_renderer")
	end
end

function BaseView:dialogue_system()
	return nil
end

function BaseView:_is_event_registered(event_name)
	if self._event_list[event_name] then
		return true
	end

	return false
end

function BaseView:_register_event(event_name, function_name)
	function_name = function_name or event_name

	Managers.event:register(self, event_name, function_name)

	self._event_list[event_name] = function_name
end

function BaseView:_unregister_event(event_name)
	Managers.event:unregister(self, event_name)

	self._event_list[event_name] = nil
end

function BaseView:_unregister_events()
	for event_name, _ in pairs(self._event_list) do
		self:_unregister_event(event_name)
	end

	self._event_list = {}
end

function BaseView:_on_view_load_complete(loaded)
	if self._destroyed then
		return
	end

	self._loading = nil

	if self:is_view_requirements_complete() then
		self:_on_view_requirements_complete()
	end
end

function BaseView:is_view_requirements_complete()
	return not self._loading or false
end

function BaseView:_on_view_requirements_complete()
	self._can_close = true
	self._render_scale = Managers.ui:view_render_scale()
	local definitions = self._definitions
	self._ui_scenegraph = self:_create_scenegraph(definitions)
	self._widgets_by_name = {}
	self._widgets = {}

	self:_create_widgets(definitions, self._widgets, self._widgets_by_name)

	self._ui_sequence_animator = self:_create_sequence_animator(definitions)
	self._render_settings = {}

	self:on_enter()
end

function BaseView:loading()
	return self._loading or false
end

function BaseView:widgets_by_name()
	return self._widgets_by_name
end

function BaseView:_create_scenegraph(definitions)
	local scenegraph_definition = definitions.scenegraph_definition
	local scenegraph = UIScenegraph.init_scenegraph(scenegraph_definition, self._render_scale)

	return scenegraph
end

function BaseView:_create_widgets(definitions, widgets, widgets_by_name)
	local widget_definitions = definitions.widget_definitions
	widgets = widgets or {}
	widgets_by_name = widgets_by_name or {}
	local widget_count = #widgets

	for name, definition in pairs(widget_definitions) do
		local widget = self:_create_widget(name, definition, widgets_by_name)
		widget_count = widget_count + 1
		widgets[widget_count] = widget
	end

	return widgets, widgets_by_name
end

function BaseView:_create_widget(name, definition, widgets_by_name)
	widgets_by_name = widgets_by_name or self._widgets_by_name
	local widget = UIWidget.init(name, definition)
	widgets_by_name[name] = widget

	return widget
end

function BaseView:_unregister_widget_name(name)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name[name] = nil
end

function BaseView:get_time()
	return Managers.ui:get_time()
end

function BaseView:has_widget(name)
	return self._widgets_by_name[name] ~= nil
end

function BaseView:trigger_widget_pressed(name, optional_content_id)
	local widget = self._widgets_by_name[name]
	local hotspot_content = self:widget_hotspot_content(name, optional_content_id)

	if hotspot_content and not hotspot_content.disabled then
		hotspot_content.force_input_pressed = true
	end
end

function BaseView:widget_hotspot_content(name, optional_content_id)
	local widget = self._widgets_by_name[name]
	local content = widget.content
	local hotspot_content = nil

	if optional_content_id then
		hotspot_content = content[optional_content_id]
	end

	local passes = widget.passes

	for i = 1, #passes do
		local pass = passes[i]
		local pass_type = pass.pass_type

		if pass_type == "hotspot" then
			local content_id = pass.content_id
			hotspot_content = content[content_id]

			break
		end
	end

	return hotspot_content
end

function BaseView:_create_sequence_animator(definitions)
	local animations = definitions.animations

	if animations then
		local scenegraph_definition = definitions.scenegraph_definition

		return UISequenceAnimator:new(self._ui_scenegraph, scenegraph_definition, animations)
	end
end

function BaseView:_is_animation_active(animation_id)
	return self._ui_sequence_animator:is_animation_active(animation_id)
end

function BaseView:_is_animation_completed(animation_id)
	return self._ui_sequence_animator:is_animation_completed(animation_id)
end

function BaseView:_start_animation(animation_sequence_name, widgets, params, callback, speed, delay)
	speed = speed or 1
	widgets = widgets or self._widgets_by_name
	local scenegraph_definition = self._definitions.scenegraph_definition
	local ui_sequence_animator = self._ui_sequence_animator
	local animation_id = ui_sequence_animator:start_animation(self, animation_sequence_name, widgets, params, speed, callback, delay)

	return animation_id
end

function BaseView:_stop_animation(animation_id)
	self._ui_sequence_animator:stop_animation(animation_id)
end

function BaseView:_complete_animation(animation_id)
	self._ui_sequence_animator:complete_animation(animation_id)
end

function BaseView:entered()
	return self._entered
end

function BaseView:on_enter()
	local input_manager = Managers.input
	local name = self.__class_name

	if not self._no_cursor then
		input_manager:push_cursor(name)

		self._cursor_pushed = true
	end

	self._update_scenegraph = true
	self._entered = true
	local enter_sound_events = self._settings.enter_sound_events

	if enter_sound_events then
		for i = 1, #enter_sound_events do
			local sound_event = enter_sound_events[i]

			self:_play_sound(sound_event)
		end
	end

	Managers.telemetry_events:open_view(self.view_name, self._hub_interaction, self._telemetry_id)
	Profiler.send_message(string.format("[UIView] on_enter '%s'", self.view_name))
end

function BaseView:supports_changeable_context()
	return false
end

function BaseView:character_level()
	local player = self:_player()
	local profile = player:profile()
	local profile_level = profile.current_level

	return profile_level
end

function BaseView:on_exit()
	self:_unregister_events()
	Profiler.send_message(string.format("[UIView] on_exit '%s'", self.view_name))

	if Managers.telemetry_events then
		Managers.telemetry_events:close_view(self.view_name)
	end

	if self._cursor_pushed then
		local input_manager = Managers.input
		local name = self.__class_name

		input_manager:pop_cursor(name)

		self._cursor_pushed = nil
	end

	if self._should_unload then
		self._should_unload = nil
		local frame_delay_count = 1

		Managers.ui:unload_view(self.view_name, self.__class_name, frame_delay_count)
	end

	local elements_array = self._elements_array

	if elements_array then
		for _, element in ipairs(elements_array) do
			element:destroy(self._ui_renderer)
		end
	end

	self._elements = nil
	self._elements_array = nil
	self._ui_renderer = nil

	if not self._ui_renderer_is_external then
		Managers.ui:destroy_renderer(self.__class_name .. "_ui_renderer")
	end

	self._destroyed = true
end

function BaseView:set_can_exit(value, apply_next_frame)
	if not apply_next_frame then
		self._can_close = value
	else
		self._next_frame_can_close = value
		self._can_close_frame_counter = 1
	end
end

function BaseView:can_exit()
	return self._can_close
end

function BaseView:allow_close_hotkey()
	return self._allow_close_hotkey
end

function BaseView:on_resolution_modified(scale)
	return
end

function BaseView:trigger_resolution_update()
	local ui_scenegraph = self._ui_scenegraph

	UIScenegraph.update_scenegraph(ui_scenegraph, self._render_scale)
	self:_on_resolution_modified_elements(self._render_scale)
	self:on_resolution_modified(self._render_scale)

	self._update_scenegraph = nil
end

function BaseView:_set_scenegraph_position(id, x, y, z, horizontal_alignment, vertical_alignment, optional_ui_scenegraph)
	local ui_scenegraph = optional_ui_scenegraph or self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]
	local position = scenegraph.position

	if x then
		position[1] = x
	end

	if y then
		position[2] = y
	end

	if z then
		position[3] = z
	end

	scenegraph.horizontal_alignment = horizontal_alignment or scenegraph.horizontal_alignment
	scenegraph.vertical_alignment = vertical_alignment or scenegraph.vertical_alignment
	self._update_scenegraph = true
end

function BaseView:render_scale()
	return self._render_scale
end

function BaseView:set_render_scale(scale)
	self._render_scale = scale
end

function BaseView:_set_scenegraph_size(id, width, height, optional_ui_scenegraph)
	local ui_scenegraph = optional_ui_scenegraph or self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]
	local size = scenegraph.size

	if width then
		size[1] = width
	end

	if height then
		size[2] = height
	end

	self._update_scenegraph = true
end

function BaseView:_scenegraph_size(id, optional_ui_scenegraph)
	local ui_scenegraph = optional_ui_scenegraph or self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]
	local size = scenegraph.size

	return size[1], size[2]
end

function BaseView:_scenegraph_position(id, optional_ui_scenegraph)
	local ui_scenegraph = optional_ui_scenegraph or self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]
	local position = scenegraph.position

	return position[1], position[2], position[3]
end

function BaseView:_scenegraph_world_position(id, scale, optional_ui_scenegraph)
	local ui_scenegraph = optional_ui_scenegraph or self._ui_scenegraph

	return UIScenegraph.world_position(ui_scenegraph, id, scale)
end

function BaseView:_update_element_position(scenegraph_id, element, use_local_position)
	local position = nil

	if use_local_position then
		position = self._ui_scenegraph[scenegraph_id].position
	else
		position = self:_scenegraph_world_position(scenegraph_id)
	end

	local horizontal_alignment = self._ui_scenegraph[scenegraph_id].horizontal_alignment
	local vertical_alignment = self._ui_scenegraph[scenegraph_id].vertical_alignment

	element:set_pivot_offset(position[1], position[2], horizontal_alignment, vertical_alignment)

	if element.grid_height then
		self:_set_scenegraph_size(scenegraph_id, nil, element:grid_height())
	end
end

function BaseView:_force_update_scenegraph(ui_scenegraph)
	UIScenegraph.update_scenegraph(ui_scenegraph or self._ui_scenegraph, self._render_scale)
end

function BaseView:_update_animations(dt, t)
	local ui_sequence_animator = self._ui_sequence_animator

	if ui_sequence_animator and ui_sequence_animator:update(dt, t) then
		self._update_scenegraph = true
	end
end

function BaseView:update(dt, t, input_service)
	if GameParameters.testify then
		Testify:poll_requests_through_handler(BaseViewTestify, self)
	end

	if self._can_close_frame_counter then
		if self._can_close_frame_counter == 0 then
			self:set_can_exit(self._next_frame_can_close)

			self._next_frame_can_close = nil
			self._can_close_frame_counter = nil
		else
			self._can_close_frame_counter = self._can_close_frame_counter - 1
		end
	end

	self:_update_animations(dt, t)

	if self._update_scenegraph then
		self._update_scenegraph = nil

		self:trigger_resolution_update()
	end

	self:_update_elements(dt, t, input_service)

	if self._entered and input_service and not input_service:is_null_service() then
		local using_cursor_navigation = Managers.ui:using_cursor_navigation()

		if self._using_cursor_navigation ~= using_cursor_navigation or self._using_cursor_navigation == nil then
			self._using_cursor_navigation = using_cursor_navigation

			self:_on_navigation_input_changed()
		end

		self:_handle_input(input_service, dt, t)
	end

	return self._pass_input, self._pass_draw
end

function BaseView:post_update(dt, t)
	return
end

function BaseView:_handle_input(input_service, dt, t)
	return
end

function BaseView:using_cursor_navigation()
	return self._using_cursor_navigation
end

function BaseView:_on_navigation_input_changed()
	return
end

function BaseView:is_using_input()
	return true
end

function BaseView:draw(dt, t, input_service, layer)
	local render_scale = self._render_scale
	local render_settings = self._render_settings
	local ui_renderer = self._ui_renderer
	render_settings.start_layer = layer
	render_settings.scale = render_scale
	render_settings.inverse_scale = render_scale and 1 / render_scale
	local alpha_multiplier = render_settings.alpha_multiplier
	local ui_scenegraph = self._ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)
	self:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	UIRenderer.end_pass(ui_renderer)
	self:_draw_elements(dt, t, ui_renderer, render_settings, input_service)

	render_settings.alpha_multiplier = alpha_multiplier
end

function BaseView:set_local_player_id(local_player_id)
	self._local_player_id = local_player_id
end

function BaseView:trigger_on_enter_animation()
	self._on_enter_animation_triggered = true
end

function BaseView:trigger_on_exit_animation()
	self._on_exit_animation_triggered = true
	local exit_sound_events = self._settings.exit_sound_events

	if exit_sound_events then
		for i = 1, #exit_sound_events do
			local sound_event = exit_sound_events[i]

			self:_play_sound(sound_event)
		end
	end
end

function BaseView:triggered_on_enter_animation()
	return self._on_enter_animation_triggered
end

function BaseView:triggered_on_exit_animation()
	return self._on_exit_animation_triggered
end

function BaseView:on_enter_animation_done()
	return self._on_enter_animation_triggered
end

function BaseView:on_exit_animation_done()
	return self._on_exit_animation_triggered
end

function BaseView:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]

		UIWidget.draw(widget, ui_renderer)
	end
end

function BaseView:_localize(text, no_cache, context)
	return Managers.localization:localize(text, no_cache, context)
end

function BaseView:_localized_input_text(action, optional_service_type)
	local service_type = optional_service_type or "View"

	return InputUtils.input_text_for_current_input_device(service_type, action)
end

function BaseView:_text_size(text, font_type, font_size, optional_size, options)
	local ui_renderer = self._ui_renderer

	return UIRenderer.text_size(ui_renderer, text, font_type, font_size, optional_size, options)
end

local _temp_optional_size = {
	0,
	0
}

function BaseView:_text_size_for_style(text, text_style, optional_size)
	optional_size = optional_size or text_style.size

	if optional_size then
		_temp_optional_size[1] = optional_size[1]
		_temp_optional_size[2] = optional_size[2]
		local size_addition = text_style.size_addition

		if size_addition then
			_temp_optional_size[1] = _temp_optional_size[1] + size_addition[1]
			_temp_optional_size[2] = _temp_optional_size[2] + size_addition[2]
		end
	end

	local text_options = UIFonts.get_font_options_by_style(text_style)
	local ui_renderer = self._ui_renderer

	return UIRenderer.text_size(ui_renderer, text, text_style.font_type, text_style.font_size, optional_size and _temp_optional_size, text_options)
end

function BaseView:_play_sound(event_name)
	local ui_manager = Managers.ui

	return ui_manager:play_2d_sound(event_name)
end

function BaseView:_stop_sound(event_id)
	local ui_manager = Managers.ui

	return ui_manager:stop_2d_sound(event_id)
end

function BaseView:_set_sound_parameter(parameter_id, value)
	local ui_manager = Managers.ui

	ui_manager:set_2d_sound_parameter(parameter_id, value)
end

function BaseView:_add_element(class, reference_name, layer, context, pivot)
	local elements = self._elements
	local elements_array = self._elements_array

	if not self._elements or not self._elements_array then
		return
	end

	context = context or {}

	if not context.reference_name then
		context.reference_name = reference_name
	end

	local draw_layer = layer or 0
	local scale = self._ui_renderer.scale or RESOLUTION_LOOKUP.scale
	local element = class:new(self, draw_layer, scale, context)

	element:set_render_scale(self._render_scale)

	elements[reference_name] = element
	local id = #elements_array + 1
	elements_array[id] = element

	if pivot then
		self._element_to_pivot[element] = pivot
	end

	return element
end

function BaseView:_remove_element(reference_name)
	local elements = self._elements or {}
	local element = elements[reference_name]
	local elements_array = self._elements_array

	if elements_array and element then
		for i = 1, #elements_array do
			if elements_array[i] == element then
				table.remove(elements_array, i)

				break
			end
		end

		element:destroy()

		elements[reference_name] = nil
	end
end

function BaseView:_element_reference_name(element)
	local elements = self._elements or {}
	local reference_name = table.find(elements, element)

	return reference_name
end

function BaseView:_element(reference_name)
	local elements = self._elements or {}
	local element = elements[reference_name]

	return element
end

function BaseView:_on_resolution_modified_elements(scale)
	local elements_array = self._elements_array

	if elements_array then
		for i = 1, #elements_array do
			local element = elements_array[i]
			local element_name = element.__class_name

			if element.on_resolution_modified then
				element:set_render_scale(scale)
				element:on_resolution_modified(scale)
			end
		end
	end

	for element, scenegraph_id in pairs(self._element_to_pivot) do
		self:_update_element_position(scenegraph_id, element)
	end
end

function BaseView:_draw_elements(dt, t, ui_renderer, render_settings, input_service)
	local elements_array = self._elements_array

	if elements_array then
		for i = 1, #elements_array do
			local element = elements_array[i]

			if element then
				local element_name = element.__class_name

				element:draw(dt, t, ui_renderer, render_settings, input_service)
			end
		end
	end
end

function BaseView:_update_elements(dt, t, input_service)
	local elements_array = self._elements_array

	if elements_array then
		for i = 1, #elements_array do
			local element = elements_array[i]

			if element then
				local element_name = element.__class_name

				element:update(dt, t, input_service)
			end
		end
	end
end

function BaseView:_player()
	local player_manager = Managers.player
	local player = player_manager:local_player(self._local_player_id or 1)

	return player
end

function BaseView:_player_viewport()
	local player = self:_player()

	return player.viewport_name
end

return BaseView
