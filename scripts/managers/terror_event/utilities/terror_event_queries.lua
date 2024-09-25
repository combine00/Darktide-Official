local TerrorEventQueries = {}

local function _count_num_alive_minions_in_spawners(tag, side, spawner_queue_id)
	local allied_alive_tag_units_lookup = side.units_by_relation_tag_lookup.allied[tag]
	local side_units_lookup = side.units_lookup
	local num_alive_minions = 0

	for spawner_extension, queue_ids in pairs(spawner_queue_id) do
		for i = 1, #queue_ids do
			local queue_id = queue_ids[i]
			local spawned_minions = spawner_extension:spawned_minions_by_queue_id(queue_id)

			if spawned_minions then
				for j = 1, #spawned_minions do
					local spawned_minion = spawned_minions[j]

					if allied_alive_tag_units_lookup[spawned_minion] and side_units_lookup[spawned_minion] then
						num_alive_minions = num_alive_minions + 1
					end
				end
			end
		end
	end

	return num_alive_minions
end

local DEFAULT_SIDE_NAME = "villains"

function TerrorEventQueries.num_alive_minions(optional_tag, optional_side_name, optional_event)
	local event = optional_event or Managers.state.terror_event:current_event()
	local spawner_queue_id = event.spawned_minion_data.spawner_queue_id
	local num_alive_minions = 0

	if spawner_queue_id then
		local tag = optional_tag or "minion"
		local side_name = optional_side_name or DEFAULT_SIDE_NAME
		local side = Managers.state.extension:system("side_system"):get_side_from_name(side_name)
		num_alive_minions = _count_num_alive_minions_in_spawners(tag, side, spawner_queue_id)
	end

	return num_alive_minions
end

function TerrorEventQueries.num_alive_minions_in_level(optional_tag, optional_side_name)
	local tag = optional_tag or "minion"
	local side_name = optional_side_name or DEFAULT_SIDE_NAME
	local side = Managers.state.extension:system("side_system"):get_side_from_name(side_name)
	local allied_sides = side:relation_sides("allied")
	local allied_alive_minion_units = side:alive_units_by_tag("allied", tag)

	if #allied_sides > 1 then
		local num_alive_minions = 0
		local units_lookup = side.units_lookup

		for i = 1, #allied_alive_minion_units do
			if units_lookup[allied_alive_minion_units[i]] then
				num_alive_minions = num_alive_minions + 1
			end
		end

		return num_alive_minions
	else
		local num_alive_minions = #allied_alive_minion_units

		return num_alive_minions
	end
end

function TerrorEventQueries.num_aggroed_minions_in_level(optional_side_name)
	local side_name = optional_side_name or DEFAULT_SIDE_NAME
	local side = Managers.state.extension:system("side_system"):get_side_from_name(side_name)
	local num_aggroed = side.num_aggroed_minion_units

	return num_aggroed
end

function TerrorEventQueries.num_aggroed_minions_in_level_by_tag(tag, optional_side_name)
	local side_name = optional_side_name or DEFAULT_SIDE_NAME
	local side = Managers.state.extension:system("side_system"):get_side_from_name(side_name)
	local allied_alive_tag_units = side:alive_units_by_tag("allied", tag)
	local aggroed_minion_units = side.aggroed_minion_units
	local num_aggroed_by_tag = 0

	for i = 1, #allied_alive_tag_units do
		if aggroed_minion_units[allied_alive_tag_units[i]] then
			num_aggroed_by_tag = num_aggroed_by_tag + 1
		end
	end

	return num_aggroed_by_tag
end

return TerrorEventQueries
