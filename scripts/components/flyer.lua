local Flyer = component("Flyer")

function Flyer:init(unit)
	local flyer_extension = ScriptUnit.fetch_component_extension(unit, "flyer_system")
	self._flyer_extension = flyer_extension

	if flyer_extension then
		local start_free_flight_enabled = self:get_data(unit, "start_free_flight_enabled")

		flyer_extension:setup_from_component(start_free_flight_enabled)
	end
end

function Flyer:editor_init(unit)
	return
end

function Flyer:editor_validate(unit)
	return true, ""
end

function Flyer:enable(unit)
	return
end

function Flyer:disable(unit)
	return
end

function Flyer:destroy(unit)
	return
end

function Flyer:free_flight_enable(unit)
	local flyer_extension = self._flyer_extension

	if flyer_extension then
		flyer_extension:set_active(true)
	end
end

function Flyer:free_flight_disable(unit)
	local flyer_extension = self._flyer_extension

	if flyer_extension then
		flyer_extension:set_active(false)
	end
end

Flyer.component_data = {
	start_free_flight_enabled = {
		ui_type = "check_box",
		value = true,
		ui_name = "Free Flight Enabled"
	},
	inputs = {
		free_flight_enable = {
			accessibility = "public",
			type = "event"
		},
		free_flight_disable = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"FlyerExtension"
	}
}

return Flyer
