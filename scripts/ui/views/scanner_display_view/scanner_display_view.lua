local MinigameBalanceView = require("scripts/ui/views/scanner_display_view/minigame_balance_view")
local MinigameDecodeSymbolsView = require("scripts/ui/views/scanner_display_view/minigame_decode_symbols_view")
local MinigameDrillView = require("scripts/ui/views/scanner_display_view/minigame_drill_view")
local MinigameFrequencyView = require("scripts/ui/views/scanner_display_view/minigame_frequency_view")
local MinigameNoneView = require("scripts/ui/views/scanner_display_view/minigame_none_view")
local MinigameSettings = require("scripts/settings/minigame/minigame_settings")
local ScannerDisplayViewDefinitions = require("scripts/ui/views/scanner_display_view/scanner_display_view_definitions")
local ScriptWorld = require("scripts/foundation/utilities/script_world")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local DEBUG_RENDERING = false
local RENDER_SIZE = 1024
local ScannerDisplayView = class("ScannerDisplayView", "BaseView")
ScannerDisplayView.MINIGAMES = {
	[MinigameSettings.types.none] = MinigameNoneView,
	[MinigameSettings.types.balance] = MinigameBalanceView,
	[MinigameSettings.types.decode_symbols] = MinigameDecodeSymbolsView,
	[MinigameSettings.types.drill] = MinigameDrillView,
	[MinigameSettings.types.frequency] = MinigameFrequencyView
}

function ScannerDisplayView:init(settings, context)
	local class_name = self.__class_name
	self._viewport_name = class_name .. "_ui_offscreen_world_viewport"
	self._render_name = class_name .. "_offscreen_ui_renderer"
	self._no_cursor = true
	self._auspex_unit = context.auspex_unit
	self._minigame = ScannerDisplayView.MINIGAMES[context.minigame_type]:new(context)
	local definitions = ScannerDisplayViewDefinitions[context.minigame_type]

	ScannerDisplayView.super.init(self, definitions, settings, context)

	if self._minigame.set_local_player then
		local player = self:_player()

		self._minigame:set_local_player(player)
	end
end

local system_name = "dialogue_system"

function ScannerDisplayView:dialogue_system()
	local state_managers = Managers.state

	if state_managers then
		local extension_manager = state_managers.extension

		return extension_manager and extension_manager:has_system(system_name) and extension_manager:system(system_name)
	end
end

function ScannerDisplayView:on_enter()
	ScannerDisplayView.super.on_enter(self)
	self:_setup_offscreen_gui()
end

function ScannerDisplayView:is_using_input()
	return false
end

function ScannerDisplayView:on_exit()
	local offscreen_ui_renderer = self._offscreen_ui_renderer

	if offscreen_ui_renderer then
		self:_unlink_material()

		local ui_manager = Managers.ui
		local world = self._offscreen_world
		local renderer_name = self._render_name
		local viewport_name = self._viewport_name

		ui_manager:destroy_renderer(renderer_name)
		ScriptWorld.destroy_viewport(world, viewport_name)

		self._offscreen_viewport = nil
		self._offscreen_ui_renderer = nil

		ui_manager:destroy_world(world)

		self._offscreen_world = nil
	end

	ScannerDisplayView.super.on_exit(self)
end

function ScannerDisplayView:_setup_offscreen_gui()
	local ui_manager = Managers.ui
	local world = self:_create_offscreen_world()
	self._offscreen_world = world
	local viewport_name = self._viewport_name
	local viewport_type = "overlay_offscreen"
	local viewport_layer = 1
	local renderer_name = self._render_name
	self._offscreen_viewport = ui_manager:create_viewport(world, viewport_name, viewport_type, viewport_layer)
	self._offscreen_ui_renderer = Managers.ui:create_renderer(renderer_name, nil, true, self._ui_renderer.gui, self._ui_renderer.gui_retained, "content/ui/materials/mission_board/render_target_scanlines", RENDER_SIZE, RENDER_SIZE, true)
end

function ScannerDisplayView:_create_offscreen_world()
	local world_layer = 500
	local timer_name = "ui"
	local class_name = self.__class_name
	local world_name = class_name .. "_ui_offscreen_world"
	local view_name = self.view_name

	return Managers.ui:create_world(world_name, world_layer, timer_name, view_name)
end

function ScannerDisplayView:_link_material()
	local ui_resource_renderer = self._offscreen_ui_renderer
	local render_target = ui_resource_renderer and ui_resource_renderer.render_target

	if render_target then
		local plane_unit = self._auspex_unit

		if plane_unit then
			local material_linked = Unit.get_data(plane_unit, "auspex_scanner_display_material_linked")

			if not material_linked then
				Unit.set_data(plane_unit, "auspex_scanner_display_material_linked", true)

				local plane_mesh = Unit.mesh(plane_unit, "auspex_scanner_display")
				local material_instance = plane_mesh and Mesh.material(plane_mesh, "auspex_scanner_display")

				Material.set_resource(material_instance, "source", render_target)
			end
		end
	end
end

function ScannerDisplayView:_unlink_material()
	local plane_unit = self._auspex_unit

	if plane_unit then
		local material_linked = Unit.get_data(plane_unit, "auspex_scanner_display_material_linked")

		if material_linked then
			local plane_mesh = plane_unit and Unit.mesh(plane_unit, "auspex_scanner_display")
			local material_instance = plane_mesh and Mesh.material(plane_mesh, "auspex_scanner_display")

			Material.set_texture(material_instance, "source", nil)
			Unit.set_data(plane_unit, "auspex_scanner_display_material_linked", false)
		end
	end
end

function ScannerDisplayView:update(dt, t)
	self._minigame:update(dt, t, self._widgets_by_name)
	self:_link_material()

	return ScannerDisplayView.super.update(self, dt, t)
end

function ScannerDisplayView:_draw_widgets(dt, t, input_service, ui_renderer)
	ScannerDisplayView.super._draw_widgets(self, dt, t, input_service, ui_renderer)
	self._minigame:draw_widgets(dt, t, input_service, ui_renderer)
end

function ScannerDisplayView:_begin_render_offscreen()
	local gui = self._ui_renderer.gui
	local ui_resource_renderer = self._offscreen_ui_renderer

	Gui.render_pass(gui, 0, ui_resource_renderer.base_render_pass, true, ui_resource_renderer.render_target)
	Gui.render_pass(gui, 1, "to_screen", false)

	return ui_resource_renderer
end

function ScannerDisplayView:draw(dt, t, input_service, layer)
	if DEBUG_RENDERING then
		ScannerDisplayView.super.draw(self, dt, t, input_service, layer)
	else
		self._render_scale = 1

		self:_set_scenegraph_position("center_pivot", (RENDER_SIZE - RESOLUTION_LOOKUP.width) / 2, RENDER_SIZE * 0.09)

		local render_scale = self._render_scale
		local render_settings = self._render_settings
		local ui_scenegraph = self._ui_scenegraph
		local ui_resource_renderer = self:_begin_render_offscreen()
		render_settings.start_layer = layer
		render_settings.scale = render_scale
		render_settings.inverse_scale = render_scale and 1 / render_scale

		UIRenderer.begin_pass(ui_resource_renderer, ui_scenegraph, input_service, dt, render_settings)
		self:_draw_widgets(dt, t, input_service, ui_resource_renderer)
		UIRenderer.end_pass(ui_resource_renderer)
	end
end

return ScannerDisplayView
