local BodyShopViewSettings = require("scripts/ui/views/body_shop_view/body_shop_settings")
local Definitions = require("scripts/ui/views/body_shop_view/body_shop_definitions")
local UIWorldSpawner = require("scripts/managers/ui/ui_world_spawner")
local ViewElementInputLegend = require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local WorldRenderUtils = require("scripts/utilities/world_render")
local BodyShopView = class("BodyShopView", "BaseView")

function BodyShopView:init(settings, context)
	self._context = context or {}

	BodyShopView.super.init(self, Definitions, settings, context)

	self._pass_draw = false
	self._can_exit = true
end

function BodyShopView:on_enter()
	BodyShopView.super.on_enter(self)
	self:_setup_background_world()
	self:_setup_input_legend()
end

function BodyShopView:_setup_background_world()
	self:_register_event("event_register_crafting_view_camera")

	local world_name = BodyShopViewSettings.world_name
	local world_layer = BodyShopViewSettings.world_layer
	local world_timer_name = BodyShopViewSettings.timer_name
	self._world_spawner = UIWorldSpawner:new(world_name, world_layer, world_timer_name, self.view_name)

	if self._context then
		self._context.background_world_spawner = self._world_spawner
	end

	local level_name = BodyShopViewSettings.level_name

	self._world_spawner:spawn_level(level_name)
end

function BodyShopView:event_register_crafting_view_camera(camera_unit)
	self:_unregister_event("event_register_crafting_view_camera")

	local viewport_name = BodyShopViewSettings.viewport_name
	local viewport_type = BodyShopViewSettings.viewport_type
	local viewport_layer = BodyShopViewSettings.viewport_layer
	local shading_environment = BodyShopViewSettings.shading_environment

	self._world_spawner:create_viewport(camera_unit, viewport_name, viewport_type, viewport_layer, shading_environment)
end

function BodyShopView:can_exit()
	return self._can_exit
end

function BodyShopView:on_exit()
	if self._world_spawner then
		self._world_spawner:destroy()

		self._world_spawner = nil
	end

	if self._input_legend_element then
		self._input_legend_element = nil

		self:_remove_element("input_legend")
	end

	BodyShopView.super.on_exit(self)
end

function BodyShopView:cb_on_close_pressed()
	local view_name = self.view_name

	Managers.ui:close_view(view_name)
end

function BodyShopView:_setup_input_legend()
	self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
	local legend_inputs = self._definitions.legend_inputs

	for i = 1, #legend_inputs do
		local legend_input = legend_inputs[i]
		local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)

		self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, legend_input.visibility_function, on_pressed_callback, legend_input.alignment)
	end
end

function BodyShopView:_handle_background_blur()
	local ui_manager = Managers.ui
	local apply_blur, blur_amount = ui_manager:use_fullscreen_blur()

	if apply_blur ~= self._game_world_fullscreen_blur_enabled or self._game_world_fullscreen_blur_amount ~= blur_amount then
		local world_name = BodyShopViewSettings.world_name
		local viewport_name = BodyShopViewSettings.viewport_name
		self._game_world_fullscreen_blur_enabled = apply_blur
		self._game_world_fullscreen_blur_amount = blur_amount

		if apply_blur then
			WorldRenderUtils.enable_world_fullscreen_blur(world_name, viewport_name, blur_amount)
		else
			WorldRenderUtils.disable_world_fullscreen_blur(world_name, viewport_name)
		end
	end
end

function BodyShopView:update(dt, t, input_service)
	local world_spawner = self._world_spawner

	if world_spawner then
		local ui_manager = Managers.ui
		local apply_blur, blur_amount = ui_manager:use_fullscreen_blur()
		local blur_animation_duration = 0.2

		if apply_blur and not self._screen_blurred then
			self._screen_blurred = true

			world_spawner:set_camera_blur(blur_amount, blur_animation_duration)
		elseif not apply_blur and self._screen_blurred then
			self._screen_blurred = nil

			world_spawner:set_camera_blur(blur_amount, blur_animation_duration)
		end

		world_spawner:update(dt, t)
	end

	return BodyShopView.super.update(self, dt, t, input_service)
end

return BodyShopView
