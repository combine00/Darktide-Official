local WorldMarker = component("WorldMarker")

function WorldMarker:init(unit)
	self._marker_id = nil
	self._unit = unit

	Managers.event:register(self, "event_on_hud_created", "_on_hud_created")
end

function WorldMarker:editor_init(unit)
	self._should_debug_draw = false
end

function WorldMarker:enable(unit)
	return
end

function WorldMarker:disable(unit)
	return
end

function WorldMarker:destroy(unit)
	Managers.event:unregister(self, "event_on_hud_created")

	if self._marker_id then
		local event_manager = Managers.event

		event_manager:trigger("remove_world_marker", self._marker_id)
	end
end

function WorldMarker:editor_validate(unit)
	local success = true
	local error_message = ""

	return success, error_message
end

function WorldMarker:_on_beacon_marker_spawned(unit, id)
	self._marker_id = id
end

function WorldMarker:_on_hud_created()
	return
end

WorldMarker.component_data = {
	marker_type = {
		value = "interaction",
		ui_type = "combo_box",
		ui_name = "Marker Type",
		options_keys = {
			"beacon",
			"chat_bubble",
			"damage_indicator",
			"health_bar",
			"hub_objective",
			"interaction",
			"location_attention",
			"location_ping",
			"location_threat",
			"nameplate",
			"nameplate_party",
			"nameplate_party_hud",
			"objective",
			"player_assistance",
			"suppression_indicator",
			"training_grounds",
			"unit_threat",
			"unit_threat_veteran"
		},
		options_values = {
			"beacon",
			"chat_bubble",
			"damage_indicator",
			"health_bar",
			"hub_objective",
			"interaction",
			"location_attention",
			"location_ping",
			"location_threat",
			"nameplate",
			"nameplate_party",
			"nameplate_party_hud",
			"objective",
			"player_assistance",
			"suppression_indicator",
			"training_grounds",
			"unit_threat",
			"unit_threat_veteran"
		}
	}
}

return WorldMarker
