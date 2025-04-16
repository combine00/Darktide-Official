local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIScenegraph = require("scripts/managers/ui/ui_scenegraph")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UISequenceAnimator = require("scripts/managers/ui/ui_sequence_animator")
local ConstantElementBase = class("ConstantElementBase")

function ConstantElementBase:init(parent, draw_layer, start_scale, definitions)
	self._definitions = definitions
	self._draw_layer = draw_layer
	self._parent = parent
	self._is_visible = true
	self._event_list = {}
	self._ui_scenegraph = self:_create_scenegraph(definitions, start_scale)
	self._widgets_by_name = {}
	self._widgets = {}

	self:_create_widgets(definitions, self._widgets, self._widgets_by_name)

	self._ui_sequence_animator = self:_create_sequence_animator(definitions)
end

function ConstantElementBase:_create_scenegraph(definitions, start_scale)
	local scenegraph_definition = definitions.scenegraph_definition
	local scenegraph = UIScenegraph.init_scenegraph(scenegraph_definition, start_scale)

	return scenegraph
end

function ConstantElementBase:_create_widgets(definitions, widgets, widgets_by_name)
	local widget_definitions = definitions.widget_definitions
	widgets = widgets or {}
	widgets_by_name = widgets_by_name or {}

	for name, definition in pairs(widget_definitions) do
		local widget = self:_create_widget(name, definition)
		widgets[#widgets + 1] = widget
	end

	return widgets, widgets_by_name
end

function ConstantElementBase:_create_widget(name, definition)
	local widgets_by_name = self._widgets_by_name
	local widget = UIWidget.init(name, definition)
	widgets_by_name[name] = widget

	return widget
end

function ConstantElementBase:_unregister_widget_name(name)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name[name] = nil
end

function ConstantElementBase:has_widget(name)
	return self._widgets_by_name[name] ~= nil
end

function ConstantElementBase:_register_event(event_name, function_name)
	function_name = function_name or event_name

	Managers.event:register(self, event_name, function_name)

	self._event_list[event_name] = function_name
end

function ConstantElementBase:_unregister_event(event_name)
	Managers.event:unregister(self, event_name)

	self._event_list[event_name] = nil
end

function ConstantElementBase:_unregister_events()
	if self._event_list then
		for event_name, _ in pairs(self._event_list) do
			self:_unregister_event(event_name)
		end

		self._event_list = {}
	end
end

function ConstantElementBase:_create_sequence_animator(definitions)
	local animations = definitions.animations

	if animations then
		local scenegraph_definition = definitions.scenegraph_definition

		return UISequenceAnimator:new(self._ui_scenegraph, scenegraph_definition, animations)
	end
end

function ConstantElementBase:_start_animation(animation_sequence_name, widgets, params, callback, speed)
	speed = speed or 1
	widgets = widgets or self._widgets_by_name
	local scenegraph_definition = self._definitions.scenegraph_definition
	local ui_sequence_animator = self._ui_sequence_animator
	local animation_id = ui_sequence_animator:start_animation(self, animation_sequence_name, widgets, params, speed, callback)

	return animation_id
end

function ConstantElementBase:_stop_animation(animation_id)
	return self._ui_sequence_animator:stop_animation(animation_id)
end

function ConstantElementBase:_is_animation_active(animation_id)
	return self._ui_sequence_animator:is_animation_active(animation_id)
end

function ConstantElementBase:_is_animation_completed(animation_id)
	return self._ui_sequence_animator:is_animation_completed(animation_id)
end

function ConstantElementBase:_complete_animation(animation_id)
	self._ui_sequence_animator:complete_animation(animation_id)
end

function ConstantElementBase:set_visible(visible, optional_visibility_parameters)
	self._is_visible = visible
end

function ConstantElementBase:should_update()
	return self._is_visible
end

function ConstantElementBase:should_draw()
	return self._is_visible
end

function ConstantElementBase:set_render_scale(render_scale)
	self._render_scale = render_scale
end

function ConstantElementBase:on_resolution_modified()
	self._update_scenegraph = true
end

function ConstantElementBase:scenegraph_size(id, scale)
	local ui_scenegraph = self._ui_scenegraph

	return UIScenegraph.size_scaled(ui_scenegraph, id, scale)
end

function ConstantElementBase:scenegraph_position(id)
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]

	return scenegraph.position
end

function ConstantElementBase:scenegraph_world_position(id, scale)
	local ui_scenegraph = self._ui_scenegraph

	return UIScenegraph.world_position(ui_scenegraph, id, scale)
end

function ConstantElementBase:_force_update_scenegraph()
	UIScenegraph.update_scenegraph(self._ui_scenegraph, self._render_scale)
end

function ConstantElementBase:set_scenegraph_position(id, x, y, z, horizontal_alignment, vertical_alignment)
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph = ui_scenegraph[id]
	scenegraph.horizontal_alignment = horizontal_alignment or scenegraph.horizontal_alignment
	scenegraph.vertical_alignment = vertical_alignment or scenegraph.vertical_alignment
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

	self._update_scenegraph = true
end

function ConstantElementBase:_set_scenegraph_size(id, width, height)
	local ui_scenegraph = self._ui_scenegraph
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

function ConstantElementBase:_update_animations(dt, t)
	local ui_sequence_animator = self._ui_sequence_animator

	if ui_sequence_animator and ui_sequence_animator:update(dt, t) then
		self._update_scenegraph = true
	end
end

function ConstantElementBase:update(dt, t, ui_renderer, render_settings, input_service)
	self:_update_animations(dt, t)

	if self._update_scenegraph then
		local ui_scenegraph = self._ui_scenegraph

		UIScenegraph.update_scenegraph(ui_scenegraph, render_settings.scale)

		self._update_scenegraph = nil
	end
end

function ConstantElementBase:draw(dt, t, ui_renderer, render_settings, input_service)
	render_settings.start_layer = self._draw_layer
	local ui_scenegraph = self._ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)
	self:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	UIRenderer.end_pass(ui_renderer)
end

function ConstantElementBase:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]

		UIWidget.draw(widget, ui_renderer)
	end
end

function ConstantElementBase:_play_sound(event_name)
	local ui_manager = Managers.ui

	ui_manager:play_2d_sound(event_name)
end

function ConstantElementBase:_localize(text, no_cache, context)
	return Managers.localization:localize(text, no_cache, context)
end

function ConstantElementBase:destroy()
	self:_unregister_events()
end

return ConstantElementBase
