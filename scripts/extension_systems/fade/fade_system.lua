local FadeSystem = class("FadeSystem", "ExtensionSystemBase")
local DEFAULT_MIN_DISTANCE = 0.5
local DEFAULT_MAX_DISTANCE = 0.7
local DEFAULT_MAX_HEIGHT_DIFFERENCE = 1
local DEFAULT_NODE_NAME = "j_spine"
FadeSystem.system_extensions = {
	"FadeExtension"
}

function FadeSystem:init(context, system_init_data, system_name, _, ...)
	local extensions = FadeSystem.system_extensions

	FadeSystem.super.init(self, context, system_init_data, system_name, extensions, ...)

	self._fade_system = Fade.init()
	self._unit_to_extension_map = {}
end

function FadeSystem:destroy()
	local fade_system = self._fade_system

	for unit, _ in pairs(self._unit_to_extension_map) do
		Fade.unregister_unit(fade_system, unit)
	end

	Fade.destroy(fade_system)
	FadeSystem.super.destroy(self)
end

function FadeSystem:on_add_extension(world, unit, extension_name)
	local min_distance, max_distance, max_height_difference, node_name = nil
	local unit_data_extension = ScriptUnit.has_extension(unit, "unit_data_system")

	if unit_data_extension then
		local breed = unit_data_extension:breed()
		local fade = breed.fade

		if fade then
			min_distance = fade.min_distance
			max_distance = fade.max_distance
			max_height_difference = fade.max_height_difference
			node_name = fade.node_name
		end
	end

	min_distance = min_distance or DEFAULT_MIN_DISTANCE
	max_distance = max_distance or DEFAULT_MAX_DISTANCE
	max_height_difference = max_height_difference or DEFAULT_MAX_HEIGHT_DIFFERENCE
	node_name = node_name or DEFAULT_NODE_NAME

	Fade.register_unit(self._fade_system, unit, min_distance, max_distance, max_height_difference, node_name)

	local extension = {}

	ScriptUnit.set_extension(unit, self._name, extension)

	self._unit_to_extension_map[unit] = extension

	return extension
end

function FadeSystem:on_remove_extension(unit, extension_name)
	Fade.unregister_unit(self._fade_system, unit)

	self._unit_to_extension_map[unit] = nil

	ScriptUnit.remove_extension(unit, self._name)
end

function FadeSystem:update(context, dt, t, ...)
	if DEDICATED_SERVER then
		return
	end

	local player_manager = Managers.player
	local camera_manager = Managers.state.camera
	local player = player_manager and player_manager:local_player(1)
	local fade_position = nil

	if player and camera_manager then
		fade_position = camera_manager:camera_position(player.viewport_name)
	end

	Fade.update(self._fade_system, fade_position or Vector3.zero())
end

function FadeSystem:set_min_fade(unit, min_fade)
	Fade.set_min_fade(self._fade_system, unit, min_fade)
end

return FadeSystem
