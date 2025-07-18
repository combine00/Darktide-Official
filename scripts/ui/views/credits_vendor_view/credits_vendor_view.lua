require("scripts/ui/views/vendor_view_base/vendor_view_base")

local Definitions = require("scripts/ui/views/credits_vendor_view/credits_vendor_view_definitions")
local CreditsVendorViewSettings = require("scripts/ui/views/credits_vendor_view/credits_vendor_view_settings")
local Promise = require("scripts/foundation/utilities/promise")
local ItemUtils = require("scripts/utilities/items")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local CreditsVendorView = class("CreditsVendorView", "VendorViewBase")

function CreditsVendorView:init(settings, context)
	local parent = context and context.parent
	self._parent = parent
	self._optional_store_service = context and context.optional_store_service

	CreditsVendorView.super.init(self, Definitions, settings, context)
end

function CreditsVendorView:on_enter()
	CreditsVendorView.super.on_enter(self)
	self._item_grid:update_dividers("content/ui/materials/frames/item_list_top_hollow", {
		652,
		118
	}, {
		0,
		-18,
		20
	}, "content/ui/materials/frames/details_lower_armoury", {
		674,
		80
	}, {
		0,
		0,
		20
	})
	self._item_grid:set_sort_button_offset(0, 45)
	self._item_grid:set_timer_text_offset(0, 45)
end

function CreditsVendorView:_get_store()
	local store_service = Managers.data_service.store
	local store_promise = nil
	local optional_store_service = self._optional_store_service

	if optional_store_service and store_service[optional_store_service] then
		store_promise = store_service[optional_store_service](store_service)
	else
		store_promise = store_service:get_credits_store()
	end

	if not store_promise then
		return
	end

	return store_promise:next(function (data)
		local local_player_id = 1
		local player = Managers.player:local_player(local_player_id)
		local character_id = player:character_id()

		return Managers.data_service.gear:fetch_inventory(character_id):next(function (items)
			local offers = data.offers

			for i = 1, #offers do
				local offer = offers[i]
				local offer_id = offer.offerId
				local sku = offer.sku
				local category = sku.category

				if category == "item_instance" and offer.state == "active" then
					local item = offer.description

					if self:_does_item_exist_in_list(items, item) then
						offer.state = "owned"
					end
				end
			end

			return Promise.resolved(data)
		end)
	end)
end

function CreditsVendorView:_purchase_item(offer)
	local store_service = Managers.data_service.store
	local promise = store_service:purchase_item(offer)

	promise:next(function (result)
		self._purchase_promise = nil
		local widgets_by_name = self._widgets_by_name
		local purchase_sound = widgets_by_name.purchase_button.content.purchase_sound

		if purchase_sound then
			self:_play_sound(purchase_sound)
		end

		offer.state = "owned"

		self:_on_purchase_complete(result.items)
	end):catch(function (error)
		self:_fetch_store_items()

		self._purchase_promise = nil

		Managers.event:trigger("event_add_notification_message", "alert", {
			text = Localize("loc_notification_acqusition_failed")
		}, nil, UISoundEvents.notification_join_party_failed)
	end)

	self._purchase_promise = promise
end

function CreditsVendorView:_does_item_exist_in_list(items, item)
	for gear_id, _ in pairs(items) do
		if gear_id == item.gear_id then
			return true
		end
	end

	return false
end

function CreditsVendorView:_on_purchase_complete(items)
	CreditsVendorView.super._on_purchase_complete(self, items)
	self._parent:play_vo_events(CreditsVendorViewSettings.vo_event_vendor_purchase, "credit_store_servitor_b", nil, 1.4)
end

function CreditsVendorView:dialogue_system()
	return self._parent:dialogue_system()
end

function CreditsVendorView:_setup_sort_options()
	if not self._sort_options then
		self._sort_options = {
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_high_low", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_item_power")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					">",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_low_high", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_item_power")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					"<",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_high_low", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_rarity")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					">",
					"item",
					ItemUtils.compare_item_rarity,
					">",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_low_high", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_rarity")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					"<",
					"item",
					ItemUtils.compare_item_rarity,
					">",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_low_high", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_item_price")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					"false",
					"offer",
					ItemUtils.compare_credits_offer_owned,
					"<",
					"offer",
					ItemUtils.compare_offer_price,
					"<",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_high_low", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_item_price")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					"false",
					"offer",
					ItemUtils.compare_credits_offer_owned,
					">",
					"offer",
					ItemUtils.compare_offer_price,
					">",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_increasing_letters", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_name")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					"<",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			},
			{
				display_name = Localize("loc_inventory_item_grid_sort_title_format_decreasing_letters", true, {
					sort_name = Localize("loc_inventory_item_grid_sort_title_name")
				}),
				sort_function = ItemUtils.sort_element_key_comparator({
					">",
					"item",
					ItemUtils.compare_item_name,
					"<",
					"item",
					ItemUtils.compare_item_level,
					"<",
					"item",
					ItemUtils.compare_item_rarity
				})
			}
		}
	end

	local sort_callback = callback(self, "cb_on_sort_button_pressed")

	self._item_grid:setup_sort_button(self._sort_options, sort_callback)
end

function CreditsVendorView:cb_switch_tab(index)
	self._next_tab_index = index
	self._next_tab_index_ignore_item_selection = true
end

function CreditsVendorView:_generate_menu_tabs(layout, offers)
	local definitions = self._definitions

	return definitions.item_category_tabs_content
end

return CreditsVendorView
