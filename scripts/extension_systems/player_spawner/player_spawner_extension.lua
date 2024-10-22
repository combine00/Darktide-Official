local PlayerSpawnerExtension = class("PlayerSpawnerExtension")

function PlayerSpawnerExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._active = false
	self._player_spawner_system = extension_init_context.owner_system
end

function PlayerSpawnerExtension:activate_spawner(...)
	if not self._active then
		self._player_spawner_system:add_spawn_point(...)

		self._active = true
	end
end

function PlayerSpawnerExtension:deactivate_spawner(...)
	if self._active then
		self._player_spawner_system:remove_spawn_point(...)

		self._active = false
	end
end

return PlayerSpawnerExtension
