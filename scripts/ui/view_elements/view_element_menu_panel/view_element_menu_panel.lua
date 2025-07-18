local Definitions = require("scripts/ui/view_elements/view_element_menu_panel/view_element_menu_panel_definitions")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local InputUtils = require("scripts/managers/input/input_utils")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIWidgetGrid = require("scripts/ui/widget_logic/ui_widget_grid")
local ViewElementMenuPanelSettings = require("scripts/ui/view_elements/view_element_menu_panel/view_element_menu_panel_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local ViewElementMenuPanel = class("ViewElementMenuPanel", "ViewElementBase")
local button_template = {
	size = ViewElementMenuPanelSettings.button_max_size,
	pass_template = ButtonPassTemplates.menu_panel_button
}

function button_template.init(parent, widget, element, callback_name)
	local content = widget.content
	local hotspot = content.hotspot
	local text = element.text
	content.text = text
	local style = widget.style
	local text_style = style.text
	local button_size = content.size
	local ui_renderer = parent:ui_renderer()
	local text_width = UIRenderer.text_size(ui_renderer, text, text_style.font_type, text_style.font_size, button_size)
	local desired_button_width = text_width + ViewElementMenuPanelSettings.button_text_margin * 2

	if desired_button_width <= button_size[1] then
		button_size[1] = desired_button_width
	end

	hotspot.pressed_callback = callback(parent, callback_name, widget, element)
	hotspot.disabled = not element.callback
	widget.update = element.update
end

function ViewElementMenuPanel:init(parent, draw_layer, start_scale, definitions)
	ViewElementMenuPanel.super.init(self, parent, draw_layer, start_scale, Definitions)

	self._selected_index = nil
	self._is_handling_navigation_input = false
	self._content = {}
end

function ViewElementMenuPanel:is_handling_navigation_input()
	return self._is_handling_navigation_input
end

function ViewElementMenuPanel:set_is_handling_navigation_input(is_enabled)
	self._is_handling_navigation_input = is_enabled

	self:_update_input_texts()
end

function ViewElementMenuPanel:_on_navigation_input_changed()
	self:_update_input_texts()
end

function ViewElementMenuPanel:set_selected_panel_index(index)
	local widgets = self._content_widgets
	local focus_widget = nil

	for j = 1, #widgets do
		local widget = widgets[j]
		local content = widget.content
		local is_selected = index == j
		content.hotspot.is_selected = is_selected

		if is_selected then
			focus_widget = widget or focus_widget
		end
	end

	if self._selected_index == nil and focus_widget then
		local hotspot = focus_widget.content.hotspot
		hotspot.anim_select_progress = 1
		hotspot._is_selected = true
	end

	self._selected_index = index
end

function ViewElementMenuPanel:set_render_scale(scale)
	ViewElementMenuPanel.super.set_render_scale(self, scale)

	if self._content_grid then
		self._content_grid:set_render_scale(scale)
	end
end

function ViewElementMenuPanel:num_entries()
	return #self._content
end

function ViewElementMenuPanel:selected_index()
	return self._selected_index
end

function ViewElementMenuPanel:index_by_entry(entry)
	local content = self._content

	for i = 1, #content do
		if content[i] == entry then
			return i
		end
	end
end

function ViewElementMenuPanel:is_disabled(index)
	index = index or self._selected_index

	return self._content_widgets[index].content.hotspot.disabled
end

function ViewElementMenuPanel:remove_all_entries()
	if self._content_widgets then
		for i = 1, #self._content_widgets do
			local widget = self._content_widgets[i]

			self:_unregister_widget_name(widget.name)
		end
	end

	self._content_widgets = nil
	self._selected_index = nil
	self._content = {}
end

function ViewElementMenuPanel:add_entry(text, onclick_callback, update_function)
	if self._content_widgets then
		for i = 1, #self._content_widgets do
			local widget = self._content_widgets[i]

			self:_unregister_widget_name(widget.name)
		end
	end

	self._content[#self._content + 1] = {
		text = Utf8.upper(text),
		callback = onclick_callback,
		update = update_function
	}
	local scenegraph_id = "grid_content_pivot"
	local callback_name = "_on_entry_pressed_cb"
	self._content_widgets, self._alignment_list = self:_setup_content_widgets(self._content, scenegraph_id, callback_name)
	self._content_grid = self:_setup_grid(self._content_widgets, self._alignment_list)
end

function ViewElementMenuPanel:ui_renderer()
	return self._parent._ui_renderer
end

function ViewElementMenuPanel:_setup_content_widgets(content, scenegraph_id, callback_name)
	local widgets = {}
	local alignment_list = {}
	local amount = #content

	for i = 1, amount do
		local entry = content[i]
		local widget = nil
		local template = button_template
		local size = template.size
		local pass_template = template.pass_template
		local widget_definition = pass_template and UIWidget.create_definition(pass_template, scenegraph_id, nil, size)

		if widget_definition then
			local name = scenegraph_id .. "_widget_" .. i
			widget = self:_create_widget(name, widget_definition)
			local init = template.init

			if init then
				init(self, widget, entry, callback_name)
			end

			widgets[#widgets + 1] = widget
		end

		alignment_list[#alignment_list + 1] = widget or {
			size = size
		}
	end

	return widgets, alignment_list
end

function ViewElementMenuPanel:_setup_grid(widgets, alignment_list)
	local ui_scenegraph = self._ui_scenegraph
	local grid_scenegraph_id = "top_panel"
	local direction = "right"
	local spacing = ViewElementMenuPanelSettings.grid_spacing
	local grid = UIWidgetGrid:new(widgets, alignment_list, ui_scenegraph, grid_scenegraph_id, direction, spacing)
	local render_scale = self._render_scale

	grid:set_render_scale(render_scale)

	return grid
end

function ViewElementMenuPanel:_on_entry_pressed_cb(widget, entry)
	local current_index = self._selected_index

	if not current_index then
		return
	end

	local index = self:index_by_entry(entry)

	if index and index ~= current_index then
		local callback = entry.callback

		if callback then
			callback()
		end

		self:set_selected_panel_index(index)
		self:_play_sound(UISoundEvents.tab_button_pressed)
	end
end

function ViewElementMenuPanel:on_resolution_modified(scale)
	ViewElementMenuPanel.super.on_resolution_modified(self, scale)

	if self._content_grid then
		self._content_grid:on_resolution_modified(scale)
	end

	self._grid_length = nil
end

function ViewElementMenuPanel:update(dt, t, input_service)
	local content_widgets = self._content_widgets

	if content_widgets then
		local num_content_widgets = #content_widgets

		for i = 1, num_content_widgets do
			local widget = content_widgets[i]

			if widget.update then
				widget.update(widget.content, widget.style, dt)
			end
		end
	end

	local grid = self._content_grid

	if grid then
		local grid_length = grid:length()

		if grid_length ~= self._grid_length then
			self._grid_length = grid_length
			local x = -grid_length * 0.5

			self:_set_scenegraph_position("grid_content_pivot", x)
			self:_update_input_text_positions(grid_length)
		end

		grid:update(dt, t, input_service:null_service())
	end

	if self._is_handling_navigation_input then
		if input_service:get("navigate_primary_right_pressed") then
			self:_select_next_tab("forward")
		elseif input_service:get("navigate_primary_left_pressed") then
			self:_select_next_tab("backward")
		end
	end

	return ViewElementMenuPanel.super.update(self, dt, t, input_service)
end

function ViewElementMenuPanel:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	ViewElementMenuPanel.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)

	if self._grid_length then
		local content_widgets = self._content_widgets

		if content_widgets then
			local num_content_widgets = #content_widgets

			for i = 1, num_content_widgets do
				local widget = content_widgets[i]

				UIWidget.draw(widget, ui_renderer)
			end
		end
	end
end

function ViewElementMenuPanel:_select_next_tab(direction)
	local current_index = self._selected_index

	if not current_index then
		return
	end

	local num_items = #self._content
	local step = direction == "backward" and -1 or 1
	local index = current_index
	local content_widgets = self._content_widgets
	local is_disabled, selected_widget = nil

	repeat
		index = math.index_wrapper(index + step, num_items)
		selected_widget = content_widgets[index]
		is_disabled = selected_widget.content.hotspot.disabled
	until not is_disabled or index == current_index

	if index ~= current_index then
		local hotspot_style = selected_widget.style.hotspot
		local trigger_sound = hotspot_style and hotspot_style.on_pressed_sound or selected_widget.content.hotspot.on_pressed_sound

		if trigger_sound then
			self:_play_sound(trigger_sound)
		end

		local callback = self._content[index].callback

		if callback then
			callback()
		end

		self:set_selected_panel_index(index)
	end
end

function ViewElementMenuPanel:_update_input_texts()
	local using_gamepad = not self._using_cursor_navigation
	local is_visible = using_gamepad and self._is_handling_navigation_input
	local service = "View"
	local left_alias_key = Managers.ui:get_input_alias_key("navigate_primary_left_pressed", service)
	local right_alias_key = Managers.ui:get_input_alias_key("navigate_primary_right_pressed", service)
	local widgets_by_name = self._widgets_by_name
	local left_widget = widgets_by_name.input_text_left
	left_widget.content.text = InputUtils.input_text_for_current_input_device(service, left_alias_key)
	left_widget.style.text.visible = is_visible
	local right_widget = widgets_by_name.input_text_right
	right_widget.content.text = InputUtils.input_text_for_current_input_device(service, right_alias_key)
	right_widget.style.text.visible = is_visible
end

function ViewElementMenuPanel:_update_input_text_positions(grid_length)
	local widgets_by_name = self._widgets_by_name
	local left_widget = widgets_by_name.input_text_left
	local left_input_text_style = left_widget.style.text
	left_widget.offset[1] = -left_input_text_style.size[1]
	local right_widget = widgets_by_name.input_text_right
	right_widget.offset[1] = grid_length
end

return ViewElementMenuPanel
