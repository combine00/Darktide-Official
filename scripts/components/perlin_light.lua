local PerlinLight = component("PerlinLight")

function PerlinLight:init(unit)
	local light_enabled = self:get_data(unit, "light_enabled")

	if light_enabled then
		self:enable(unit)
	else
		self:disable(unit)
	end
end

function PerlinLight:editor_validate(unit)
	return true, ""
end

function PerlinLight:enable(unit)
	local config_name = self:get_data(unit, "flicker_config")

	for i = 1, Unit.num_lights(unit) do
		local light = Unit.light(unit, i)

		Light.set_enabled(light, true)
		Light.set_flicker_type(light, config_name)
	end
end

function PerlinLight:disable(unit)
	for i = 1, Unit.num_lights(unit) do
		local light = Unit.light(unit, i)

		Light.set_enabled(light, false)
	end
end

function PerlinLight:destroy(unit)
	return
end

PerlinLight.component_data = {
	flicker_config = {
		value = "default",
		ui_type = "combo_box",
		ui_name = "Flicker Config",
		options_keys = {
			"Default",
			"Default 2"
		},
		options_values = {
			"default",
			"default2"
		}
	},
	light_enabled = {
		ui_type = "check_box",
		value = true,
		ui_name = "Light Enabled"
	}
}

return PerlinLight
