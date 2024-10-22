local PlayerSpawner = component("PlayerSpawner")

function PlayerSpawner:init(unit)
	self._unit = unit
	self._player_spawner_extension = ScriptUnit.fetch_component_extension(unit, "player_spawner_system")

	if self:get_data(unit, "active") then
		self:player_spawner_activate()
	end
end

function PlayerSpawner:editor_init(unit)
	return
end

function PlayerSpawner:editor_validate(unit)
	return true, ""
end

function PlayerSpawner:enable(unit)
	return
end

function PlayerSpawner:disable(unit)
	return
end

function PlayerSpawner:destroy(unit)
	return
end

function PlayerSpawner:player_spawner_activate()
	local player_spawner_extension = self._player_spawner_extension

	if not player_spawner_extension then
		return
	end

	local unit = self._unit
	local player_side = self:get_data(unit, "player_side")
	local spawn_identifier = self:get_data(unit, "spawn_identifier")
	local spawn_priority = self:get_data(unit, "spawn_priority")
	local parent_spawned = self:get_data(unit, "parent_spawned")

	player_spawner_extension:activate_spawner(unit, player_side, spawn_identifier, spawn_priority, parent_spawned)
end

function PlayerSpawner:player_spawner_deactivate()
	local player_spawner_extension = self._player_spawner_extension

	if not player_spawner_extension then
		return
	end

	local unit = self._unit
	local spawn_identifier = self:get_data(unit, "spawn_identifier")

	player_spawner_extension:deactivate_spawner(unit, spawn_identifier)
end

PlayerSpawner.component_data = {
	active = {
		ui_type = "check_box",
		value = true,
		ui_name = "Active"
	},
	player_side = {
		value = "heroes",
		ui_type = "combo_box",
		ui_name = "Player Side",
		options_keys = {
			"Heroes"
		},
		options_values = {
			"heroes"
		}
	},
	spawn_identifier = {
		value = "default",
		ui_type = "combo_box",
		ui_name = "Spawn Identifier",
		options_keys = {
			"Default",
			"Bots",
			"Recent Mission",
			"Shooting Range"
		},
		options_values = {
			"default",
			"bots",
			"recent_mission",
			"tg_shooting_range"
		}
	},
	spawn_priority = {
		ui_type = "number",
		min = 1,
		decimals = 0,
		value = 1,
		ui_name = "Spawn Priority",
		step = 1
	},
	parent_spawned = {
		ui_type = "check_box",
		value = false,
		ui_name = "Parent Spawned"
	},
	inputs = {
		player_spawner_activate = {
			accessibility = "public",
			type = "event"
		},
		player_spawner_deactivate = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"PlayerSpawnerExtension"
	}
}

return PlayerSpawner
