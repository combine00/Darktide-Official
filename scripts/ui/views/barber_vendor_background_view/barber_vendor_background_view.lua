local Definitions = require("scripts/ui/views/barber_vendor_background_view/barber_vendor_background_view_definitions")
local VendorInteractionViewBase = require("scripts/ui/views/vendor_interaction_view_base/vendor_interaction_view_base")
local ViewSettings = require("scripts/ui/views/barber_vendor_background_view/barber_vendor_background_view_settings")
local BarberVendorBackgroundView = class("BarberVendorBackgroundView", "VendorInteractionViewBase")

function BarberVendorBackgroundView:init(settings, context)
	self._wallet_type = "credits"

	BarberVendorBackgroundView.super.init(self, Definitions, settings, context)
end

function BarberVendorBackgroundView:on_enter()
	BarberVendorBackgroundView.super.on_enter(self)

	local viewport_name = self._definitions.background_world_params.viewport_name

	if self._world_spawner then
		self._world_spawner:set_listener(viewport_name)
	end

	self._backend_interfaces = Managers.backend.interfaces

	self:_fetch_operations()

	local narrative_manager = Managers.narrative
	local narrative_event_name = "level_unlock_barber_visited"

	if narrative_manager:can_complete_event(narrative_event_name) then
		narrative_manager:complete_event(narrative_event_name)
		self:play_vo_events(ViewSettings.vo_event_vendor_first_interaction, "barber_a", nil, 0.8)
	else
		self:play_vo_events(ViewSettings.vo_event_vendor_greeting, "barber_a", nil, 0.8)
	end
end

function BarberVendorBackgroundView:on_exit()
	if self._world_spawner then
		self._world_spawner:release_listener()
	end

	BarberVendorBackgroundView.super.on_exit(self)

	local level = Managers.state.mission and Managers.state.mission:mission_level()

	if level then
		Level.trigger_event(level, "lua_barber_store_closed")
	end
end

function BarberVendorBackgroundView:_fetch_operations()
	local promise = self._backend_interfaces.characters:fetch_operations()

	promise:next(function (data)
		if not self._destroyed then
			local shopkeep = "barber"
			self._operations = data[shopkeep]
		end
	end)
end

function BarberVendorBackgroundView:get_mindwipe_cost()
	local cost = {
		type = "credits",
		amount = self._cost
	}

	return cost
end

function BarberVendorBackgroundView:can_afford_mindwipe()
	local barber_operations = self._operations

	if barber_operations then
		local operation_type = "transform"
		local mindwipe_operation = barber_operations[operation_type]
		local currency = mindwipe_operation.type
		local cost = mindwipe_operation.amount
		local can_afford = self:can_afford(cost, currency)
		self._cost = cost
		self._balance = self:get_balance(currency)

		return can_afford
	end
end

return BarberVendorBackgroundView
