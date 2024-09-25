local PlayerSpawner = component("PlayerSpawner")

function PlayerSpawner:init(unit)
	local player_spawner_extension = ScriptUnit.fetch_component_extension(unit, "player_spawner_system")

	if player_spawner_extension and self:get_data(unit, "active") then
		local player_side = self:get_data(unit, "player_side")
		local spawn_identifier = self:get_data(unit, "spawn_identifier")
		local spawn_priority = self:get_data(unit, "spawn_priority")
		local parent_spawned = self:get_data(unit, "parent_spawned")

		player_spawner_extension:setup_from_component(unit, player_side, spawn_identifier, spawn_priority, parent_spawned)
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
	extensions = {
		"PlayerSpawnerExtension"
	}
}

return PlayerSpawner
