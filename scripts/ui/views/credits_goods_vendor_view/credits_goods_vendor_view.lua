require("scripts/ui/views/vendor_view_base/vendor_view_base")

local Definitions = require("scripts/ui/views/credits_goods_vendor_view/credits_goods_vendor_view_definitions")
local InputUtils = require("scripts/managers/input/input_utils")
local Items = require("scripts/utilities/items")
local MasterItems = require("scripts/backend/master_items")
local UIFonts = require("scripts/managers/ui/ui_fonts")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local ViewElementItemResultOverlay = require("scripts/ui/view_elements/view_element_item_result_overlay/view_element_item_result_overlay")
local WeaponUnlockSettings = require("scripts/settings/weapon_unlock_settings")
local CreditsGoodsVendorView = class("CreditsGoodsVendorView", "VendorViewBase")

function CreditsGoodsVendorView:init(settings, context)
	CreditsGoodsVendorView.super.init(self, Definitions, settings, context)

	self._releases_to_close = 0
	local parent = context and context.parent
	self._parent = parent
	self._debug = context and context.debug

	if parent then
		context.parent:set_is_handling_navigation_input(true)
	end
end

function CreditsGoodsVendorView:set_loading_state(state)
	CreditsGoodsVendorView.super.set_loading_state(self, state)
end

function CreditsGoodsVendorView:present_grid_layout(layout, on_present_callback)
	local show_info = layout and table.size(layout) <= 0 or false
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.title_text.content.visible = not show_info
	widgets_by_name.description_text.content.visible = not show_info
	widgets_by_name.divider.content.visible = not show_info

	CreditsGoodsVendorView.super.present_grid_layout(self, layout, on_present_callback)
end

function CreditsGoodsVendorView:_generate_menu_tabs(layout, offers)
	local definitions = self._definitions

	return definitions.item_category_tabs_content
end

function CreditsGoodsVendorView:_update_grid_height(use_tab_menu)
	return
end

function CreditsGoodsVendorView:on_enter()
	CreditsGoodsVendorView.super.on_enter(self)
	self._item_grid:update_dividers("content/ui/materials/frames/item_list_top_hollow", {
		652,
		118
	}, {
		0,
		-18,
		20
	})
end

function CreditsGoodsVendorView:_setup_item_grid()
	local total_height = 0
	local widgets_by_name = self._widgets_by_name
	local title_text_widget = widgets_by_name.title_text

	if title_text_widget then
		local ui_renderer = self._ui_renderer
		local content = title_text_widget.content
		local style = title_text_widget.style
		local text_style = style.text
		local text_options = UIFonts.get_font_options_by_style(text_style)
		local _, height = UIRenderer.text_size(ui_renderer, content.text, text_style.font_type, text_style.font_size, text_style.size, text_options)
		height = height + 10

		self:_set_scenegraph_size("title_text", nil, height)

		local height_offset = 120

		self:_set_scenegraph_position("title_text", nil, height_offset)

		total_height = total_height + height + height_offset
	end

	local description_text_widget = widgets_by_name.description_text

	if description_text_widget then
		local ui_renderer = self._ui_renderer
		local content = description_text_widget.content
		local style = description_text_widget.style
		local text_style = style.text
		local text_options = UIFonts.get_font_options_by_style(text_style)
		local _, height = UIRenderer.text_size(ui_renderer, content.text, text_style.font_type, text_style.font_size, text_style.size, text_options)
		height = height + 10
		local definitions = self._definitions
		local grid_settings = definitions.grid_settings
		grid_settings.top_padding = height

		self:_set_scenegraph_size("description_text", nil, height)

		local height_offset = 0

		self:_set_scenegraph_position("description_text", nil, height + height_offset)

		total_height = total_height + height + height_offset
	end

	total_height = total_height + 40
	local definitions = self._definitions
	local grid_settings = definitions.grid_settings
	grid_settings.top_padding = total_height

	CreditsGoodsVendorView.super._setup_item_grid(self)
end

function CreditsGoodsVendorView:_setup_result_overlay(result_data)
	if self._result_overlay then
		self._result_overlay = nil

		self:_remove_element("result_overlay")
	end

	self._releases_to_close = math.min(self._releases_to_close + 1, 2)
	local reference_name = "result_overlay"
	local layer = 40
	self._result_overlay = self:_add_element(ViewElementItemResultOverlay, reference_name, layer)

	self:_update_result_overlay_position()
	self._result_overlay:start(result_data)
end

function CreditsGoodsVendorView:_update_result_overlay_position()
	if not self._result_overlay then
		return
	end
end

function CreditsGoodsVendorView:_get_store()
	local store_service = Managers.data_service.store

	return store_service:get_credits_goods_store()
end

function CreditsGoodsVendorView:show_items()
	self:_clear_list()

	self._show_temporary_store_items = false

	self:_update_wallets():next(function ()
		self:_fetch_store_items()
	end)
end

function CreditsGoodsVendorView:_setup_sort_options()
	return
end

function CreditsGoodsVendorView:cb_on_grid_entry_left_pressed(widget, element)
	local function cb_func()
		if self._destroyed then
			return
		end

		local offer = element.offer

		if Managers.ui:using_cursor_navigation() and offer and offer ~= self._previewed_offer then
			local widget_index = self._item_grid:widget_index(widget) or 1

			self._item_grid:focus_grid_index(widget_index)
		end
	end

	self._update_callback_on_grid_entry_left_pressed = callback(cb_func)
end

function CreditsGoodsVendorView:_convert_offers_to_layout_entries(item_offers)
	local layout = {}
	local player = self:_player()
	local profile = player:profile()
	local profile_archetype = profile.archetype
	local archetype_name = profile_archetype.name
	local archetype_weapon_unlocks = WeaponUnlockSettings[archetype_name]

	for i = 1, #item_offers do
		local offer = item_offers[i]
		local offer_id = offer.offerId
		local sku = offer.sku
		local category = sku.category

		if category == "item_instance" then
			local description = offer.description
			local lootChoices = description.lootChoices
			local master_id = lootChoices[1]
			local master_item = MasterItems.get_item(master_id)

			if master_item then
				local hud_icon = master_item.hud_icon
				hud_icon = hud_icon or "content/ui/materials/icons/weapons/hud/combat_blade_01"
				local display_name = Items.weapon_card_display_name(master_item) or "n/a"
				local sub_display_name = Items.weapon_card_sub_display_name(master_item) or "n/a"
				local weapon_level_requirement = nil

				for weapon_level, weapon_list in ipairs(archetype_weapon_unlocks) do
					for i = 1, #weapon_list do
						local weapon_name = weapon_list[i]

						if weapon_name == master_item.name then
							weapon_level_requirement = weapon_level

							break
						end
					end

					if weapon_level_requirement ~= nil then
						break
					end
				end

				if weapon_level_requirement ~= nil then
					table.insert(layout, 1, {
						widget_type = "credits_goods_item",
						offer = offer,
						offer_id = offer_id,
						icon = hud_icon,
						display_name = display_name,
						sub_display_name = sub_display_name,
						item = master_item,
						weapon_level_requirement = weapon_level_requirement
					})
				end
			end
		end
	end

	table.sort(layout, function (a, b)
		return b.weapon_level_requirement < a.weapon_level_requirement
	end)

	return layout
end

function CreditsGoodsVendorView:_present_purchase_result(item)
	local result_data = {
		type = "item",
		item = item
	}

	self:_setup_result_overlay(result_data)
end

function CreditsGoodsVendorView:draw(dt, t, input_service, layer)
	if self._result_overlay then
		input_service = input_service:null_service()
	end

	return CreditsGoodsVendorView.super.draw(self, dt, t, input_service, layer)
end

function CreditsGoodsVendorView:update(dt, t, input_service)
	local active_overlay = self:_is_result_presentation_active()

	if active_overlay then
		self:_check_for_input(input_service)

		input_service = input_service:null_service()
	end

	local pass_input, pass_draw = CreditsGoodsVendorView.super.update(self, dt, t, input_service)

	if active_overlay and self._releases_to_close == 0 then
		self:_close_result_overlay()
	end

	local handle_input = not active_overlay

	return handle_input and pass_input, pass_draw
end

function CreditsGoodsVendorView:_close_result_overlay()
	if self._result_overlay then
		self._result_overlay = nil

		self:_remove_element("result_overlay")
	end

	local result_item = self._result_item

	Items.mark_item_id_as_new(result_item)
	Managers.event:trigger("event_vendor_view_purchased_item")
end

function CreditsGoodsVendorView:_handle_input(input_service)
	local active_overlay = self:_is_result_presentation_active()

	if not active_overlay then
		self:_check_for_input(input_service)
	end

	CreditsGoodsVendorView.super._handle_input(self, input_service)
end

local _device_list = {
	Keyboard,
	Mouse,
	Pad1
}

function CreditsGoodsVendorView:_check_for_input(input_service)
	local any_input_released = false
	local input_device_list = InputUtils.platform_device_list()

	for i = 1, #input_device_list do
		local device = input_device_list[i]

		if device.active() and device.any_released() then
			any_input_released = true

			break
		end
	end

	if any_input_released then
		self._releases_to_close = math.max(self._releases_to_close - 1, 0)
	end
end

function CreditsGoodsVendorView:_register_button_callbacks()
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.purchase_button.content.hotspot.released_callback = callback(self, "_cb_on_purchase_pressed")
end

function CreditsGoodsVendorView:_on_purchase_complete(items)
	for i, item_data in ipairs(items) do
		local uuid = item_data.uuid
		local item = MasterItems.get_item_instance(item_data, uuid)

		if item then
			self:_update_wallets()
			self:_present_purchase_result(item)
		end

		self._result_item = item
	end

	if self._debug then
		return
	end

	self._parent:play_vo_events({
		"credit_store_servitor_purchase_b"
	}, "credit_store_servitor_b", nil, 1.4)
end

function CreditsGoodsVendorView:_is_result_presentation_active()
	if self._result_overlay then
		return true
	end

	return false
end

function CreditsGoodsVendorView:_preview_element(element)
	CreditsGoodsVendorView.super._preview_element(self, element)

	local icon = element and element.icon
	local display_name = element and element.display_name or "n/a"
	local widgets_by_name = self._widgets_by_name
	local info_box_widget = widgets_by_name.info_box

	if info_box_widget then
		local content = info_box_widget.content
		content.header = display_name
		content.icon = icon
	end

	local visible = true

	self:_set_preview_widgets_visibility(visible)
end

function CreditsGoodsVendorView:_preview_item(item)
	return
end

function CreditsGoodsVendorView:_set_preview_widgets_visibility(visible)
	local widgets_by_name = self._widgets_by_name
	widgets_by_name.price_text.content.visible = visible
	widgets_by_name.purchase_button.content.visible = visible
	widgets_by_name.price_icon.content.visible = visible
	widgets_by_name.info_box.content.visible = visible
end

function CreditsGoodsVendorView:dialogue_system()
	if self._debug then
		return
	end

	return self._parent:dialogue_system()
end

function CreditsGoodsVendorView:_update_button_disable_state()
	CreditsGoodsVendorView.super._update_button_disable_state(self)

	local widgets = self._item_grid and self._item_grid:widgets()
	local selected_grid_index = self._item_grid and self._item_grid:selected_grid_index()

	if widgets and selected_grid_index then
		local widget = widgets[selected_grid_index]
		local button_widget = self._widgets_by_name.purchase_button

		if button_widget.content.visible then
			button_widget.content.hotspot.disabled = not button_widget.content.hotspot.disabled and not widget.content.level_requirement_met or button_widget.content.hotspot.disabled
		end
	end
end

function CreditsGoodsVendorView:_cb_on_purchase_pressed()
	local result_overlay = self._result_overlay
	local purchase_disabled = self._widgets_by_name.purchase_button.content.hotspot.disabled

	if result_overlay or purchase_disabled then
		return
	end

	self._releases_to_close = 1

	CreditsGoodsVendorView.super._cb_on_purchase_pressed(self)
end

function CreditsGoodsVendorView:cb_switch_tab(index)
	self._next_tab_index = index
	self._next_tab_index_ignore_item_selection = true
end

return CreditsGoodsVendorView
