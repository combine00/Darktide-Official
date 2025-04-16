local PropData = require("scripts/settings/prop_data/prop_data")
local PropUnitData = component("PropUnitData")

function PropUnitData:init(unit)
	local unit_data_extension = ScriptUnit.fetch_component_extension(unit, "unit_data_system")

	if unit_data_extension then
		local armor_data_name = self:get_data(unit, "armor_data_name")

		unit_data_extension:setup_from_component(armor_data_name)
	end
end

function PropUnitData:editor_init(unit)
	return
end

local TEMP_MISSING_ACTOR_NAMES = {}

function PropUnitData:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") then
		local breed = PropData[self:get_data(unit, "armor_data_name")]
		local hit_zones = breed.hit_zones
		local num_missing_actor_names = 0

		for i = 1, #hit_zones do
			local zone_actors = hit_zones[i].actors

			for j = 1, #zone_actors do
				local actor = zone_actors[j]

				if Unit.find_actor(unit, actor) == nil then
					num_missing_actor_names = num_missing_actor_names + 1
					TEMP_MISSING_ACTOR_NAMES[num_missing_actor_names] = actor
				end
			end
		end

		if num_missing_actor_names > 0 then
			success = false

			table.sort(TEMP_MISSING_ACTOR_NAMES)

			local missing_actor_names_string = table.concat(TEMP_MISSING_ACTOR_NAMES, "\n\t")

			table.clear_array(TEMP_MISSING_ACTOR_NAMES, #TEMP_MISSING_ACTOR_NAMES)

			error_message = error_message .. string.format("\nThe following unit actors are missing:\n\t%s", missing_actor_names_string)
		end
	end

	return success, error_message
end

function PropUnitData:enable(unit)
	return
end

function PropUnitData:disable(unit)
	return
end

function PropUnitData:destroy(unit)
	return
end

PropUnitData.component_data = {
	armor_data_name = {
		value = "hazard_prop",
		ui_type = "combo_box",
		ui_name = "Prop Data",
		options_keys = {
			"corruptor_body",
			"corruptor_pustule",
			"druglab_tank_shield",
			"druglab_tank",
			"filtration_tank",
			"hazard_prop",
			"hazard_sphere",
			"heresy_altar",
			"ice_chunk",
			"icicle",
			"train_cogitator"
		},
		options_values = {
			"corruptor_body",
			"corruptor_pustule",
			"druglab_tank_shield",
			"druglab_tank",
			"filtration_tank",
			"hazard_prop",
			"hazard_sphere",
			"heresy_altar",
			"ice_chunk",
			"icicle",
			"train_cogitator"
		}
	},
	extensions = {
		"PropUnitDataExtension"
	}
}

return PropUnitData
