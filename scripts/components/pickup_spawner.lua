local Pickups = require("scripts/settings/pickup/pickups")
local PickupSpawner = component("PickupSpawner")
local PICKUPS_BY_NAME = Pickups.by_name

function PickupSpawner:init(unit, is_server)
	self._unit = unit
	self._is_server = is_server
	local spawn_method = self:get_data(unit, "spawn_method")
	self._spawn_method = spawn_method
	local pickup_spawner_extension = ScriptUnit.fetch_component_extension(unit, "pickup_system")

	if pickup_spawner_extension then
		local ignore_item_list = self:get_data(unit, "ignore_item_list")
		local items = self:get_data(unit, "items")
		local item_spawn_selection = self:get_data(unit, "item_spawn_selection")
		local spawn_nodes = self:get_data(unit, "spawn_nodes")
		local index = 1

		while true do
			local pickup_name = items[index]

			if not pickup_name then
				break
			end

			if not PICKUPS_BY_NAME[pickup_name] then
				table.swap_delete(items, index)
			else
				index = index + 1
			end
		end

		pickup_spawner_extension:setup_from_component(self, spawn_method, ignore_item_list, items, item_spawn_selection, spawn_nodes)

		self._pickup_spawner_extension = pickup_spawner_extension
	end
end

function PickupSpawner:editor_init(unit)
	return
end

function PickupSpawner:editor_validate(unit)
	local success = true
	local error_message = ""
	local spawn_nodes = self:get_data(unit, "spawn_nodes")

	for i = 1, #spawn_nodes do
		if not Unit.has_node(unit, spawn_nodes[i]) then
			success = false
			error_message = error_message .. "\nMissing node '" .. spawn_nodes[i] .. "'"
		end
	end

	return success, error_message
end

function PickupSpawner:enable(unit)
	return
end

function PickupSpawner:disable(unit)
	return
end

function PickupSpawner:destroy(unit)
	return
end

function PickupSpawner:spawn_item()
	local pickup_spawner_extension = self._pickup_spawner_extension

	if pickup_spawner_extension and self._is_server then
		pickup_spawner_extension:spawn_item()
	end
end

PickupSpawner.component_data = {
	spawn_method = {
		value = "primary_distribution",
		ui_type = "combo_box",
		category = "Spawn Parameters",
		ui_name = "Spawn Method",
		options_keys = {
			"primary_distribution",
			"secondary_distribution",
			"mid_event_distribution",
			"end_event_distribution",
			"guaranteed_spawn",
			"manual_spawn",
			"side_mission",
			"flow_spawn"
		},
		options_values = {
			"primary_distribution",
			"secondary_distribution",
			"mid_event_distribution",
			"end_event_distribution",
			"guaranteed_spawn",
			"manual_spawn",
			"side_mission",
			"flow_spawn"
		}
	},
	ignore_item_list = {
		ui_type = "check_box",
		value = true,
		ui_name = "Accept Any Pool Items",
		category = "Items"
	},
	items = {
		category = "Items",
		ui_type = "combo_box_array",
		size = 0,
		ui_name = "Items",
		values = {},
		options_keys = {
			"none",
			"ammo_cache_pocketable",
			"battery_01_luggable",
			"battery_02_luggable",
			"communications_hack_device",
			"consumable",
			"container_01_luggable",
			"container_02_luggable",
			"container_03_luggable",
			"control_rod_01_luggable",
			"grimoire",
			"hordes_mcguffin",
			"large_clip",
			"large_metal",
			"large_platinum",
			"medical_crate_pocketable",
			"prismata_case_01_luggable",
			"small_clip",
			"small_grenade",
			"small_metal",
			"small_platinum",
			"syringe_ability_boost_pocketable",
			"syringe_corruption_pocketable",
			"syringe_power_boost_pocketable",
			"syringe_speed_boost_pocketable",
			"tome"
		},
		options_values = {
			"none",
			"ammo_cache_pocketable",
			"battery_01_luggable",
			"battery_02_luggable",
			"communications_hack_device",
			"consumable",
			"container_01_luggable",
			"container_02_luggable",
			"container_03_luggable",
			"control_rod_01_luggable",
			"grimoire",
			"hordes_mcguffin",
			"large_clip",
			"large_metal",
			"large_platinum",
			"medical_crate_pocketable",
			"prismata_case_01_luggable",
			"small_clip",
			"small_grenade",
			"small_metal",
			"small_platinum",
			"syringe_ability_boost_pocketable",
			"syringe_corruption_pocketable",
			"syringe_power_boost_pocketable",
			"syringe_speed_boost_pocketable",
			"tome"
		}
	},
	item_spawn_selection = {
		value = "random_in_list",
		ui_type = "combo_box",
		category = "Spawn Parameters",
		ui_name = "Item Spawn Selection",
		options_keys = {
			"next_in_list",
			"random_in_list"
		},
		options_values = {
			"next_in_list",
			"random_in_list"
		}
	},
	spawn_nodes = {
		category = "Spawn Parameters",
		ui_type = "text_box_array",
		size = 1,
		ui_name = "Spawn Nodes",
		values = {
			"c_pickup"
		}
	},
	inputs = {
		spawn_item = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"PickupSpawnerExtension"
	}
}

return PickupSpawner
