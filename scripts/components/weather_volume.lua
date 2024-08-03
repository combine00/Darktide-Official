local WeatherVolume = component("WeatherVolume")

function WeatherVolume:init(unit)
	if not DEDICATED_SERVER then
		self:enable(unit)
	end
end

function WeatherVolume:enable(unit)
	local weather_extension = ScriptUnit.fetch_component_extension(unit, "weather_system")

	if weather_extension then
		local world_particles = self:get_data(unit, "world_particles")
		local screen_particles = self:get_data(unit, "screen_particles")
		local priority = self:get_data(unit, "priority")

		weather_extension:setup_from_component(world_particles, screen_particles, priority)
	end
end

function WeatherVolume:disable(unit)
	return
end

function WeatherVolume:destroy(unit)
	return
end

function WeatherVolume:editor_init(unit)
	return
end

function WeatherVolume:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_volume(unit, "weather_volume") then
		success = false
		error_message = error_message .. "\nMissing volume 'weather_volume'"
	end

	return success, error_message
end

function WeatherVolume:editor_destroy(unit)
	return
end

WeatherVolume.component_data = {
	world_particles = {
		ui_type = "resource",
		preview = false,
		value = "",
		ui_name = "World Particles",
		filter = "particles"
	},
	screen_particles = {
		ui_type = "resource",
		preview = false,
		value = "",
		ui_name = "Screen Particles",
		filter = "particles"
	},
	priority = {
		ui_type = "number",
		min = 1,
		max = 10,
		decimals = 0,
		value = 1,
		ui_name = "Priority",
		step = 1
	},
	extensions = {
		"WeatherExtension"
	}
}

return WeatherVolume
