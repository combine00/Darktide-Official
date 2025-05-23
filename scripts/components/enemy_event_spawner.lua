local HordeTemplates = require("scripts/managers/horde/horde_templates")
local EnemyEventSpawnerSettings = require("scripts/settings/components/enemy_event_spawner_settings")
local EnemyEventSpawner = component("EnemyEventSpawner")
local side_id = 2
local target_side_id = 1

function EnemyEventSpawner:init(unit, is_server, nav_world)
	self._is_server = is_server

	if not is_server then
		return
	end

	local template_name = self:get_data(unit, "compositions")
	self._compositions = EnemyEventSpawnerSettings[template_name]
	self._unit = unit
	self._nav_world = nav_world
end

function EnemyEventSpawner:editor_init(unit)
	return
end

function EnemyEventSpawner:editor_validate(unit)
	return true, ""
end

function EnemyEventSpawner:enable(unit)
	return
end

function EnemyEventSpawner:disable(unit)
	return
end

function EnemyEventSpawner:destroy(unit)
	return
end

function EnemyEventSpawner:spawn_event_enemies()
	if not self._is_server then
		return
	end

	local unit = self._unit
	local current_faction = Managers.state.pacing:current_faction()
	local compositions = self._compositions[current_faction]
	local random_index = math.random(1, #compositions)
	local chosen_compositions = compositions[random_index]
	local chosen_compositions_by_resistance = Managers.state.difficulty:get_table_entry_by_resistance(chosen_compositions)
	local horde_template_name = "ambush_horde"
	local horde_template = HordeTemplates[horde_template_name]
	self._world = Unit.world(unit)
	self._physics_world = World.physics_world(self._world)
	local nav_world = self._nav_world
	local side_system = Managers.state.extension:system("side_system")
	local side = side_system:get_side(side_id)
	local target_side = side_system:get_side(target_side_id)

	horde_template.execute(self._physics_world, nav_world, side, target_side, chosen_compositions_by_resistance)
end

EnemyEventSpawner.component_data = {
	inputs = {
		spawn_event_enemies = {
			accessibility = "public",
			type = "event"
		}
	},
	compositions = {
		value = "nurgle_totem",
		ui_type = "combo_box",
		ui_name = "Compositions",
		options_keys = {
			"nurgle_totem"
		},
		options_values = {
			"nurgle_totem"
		}
	}
}

return EnemyEventSpawner
