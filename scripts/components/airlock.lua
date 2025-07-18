local Airlock = component("Airlock")

function Airlock:init(unit, is_server)
	if not is_server then
		return false
	end

	local side_system = Managers.state.extension:system("side_system")
	local side_name = side_system:get_default_player_side_name()
	self._side = side_system:get_side_from_name(side_name)
	self._unit_untargetable_id = Script.new_map(4)
	self._perception_system = Managers.state.extension:system("perception_system")
end

function Airlock:destroy(unit)
	if not self.is_server then
		return
	end

	Managers.event:unregister(self, "player_unit_spawned")
end

function Airlock:enable(unit)
	return
end

function Airlock:disable(unit)
	return
end

function Airlock:editor_init()
	return
end

function Airlock:editor_validate(unit)
	return true, ""
end

function Airlock:editor_destroy(unit)
	return
end

function Airlock:start_lockdown()
	if not self.is_server then
		return
	end

	local perception_system = self._perception_system
	local unit_untargetable_id = self._unit_untargetable_id
	local side = self._side
	local valid_player_units = side.valid_player_units

	for i = 1, #valid_player_units do
		local player_unit = valid_player_units[i]
		unit_untargetable_id[player_unit] = perception_system:set_untargetable(self, player_unit)
	end

	Managers.event:register(self, "player_unit_spawned", "_on_player_unit_spawned")

	local enemy_minions = side:alive_units_by_tag("enemy", "minion")
	local num_enemy_minions = enemy_minions.size
	local unit_to_navigation_extension_map = Managers.state.extension:system("navigation_system"):unit_to_extension_map()
	local aggroed_minion_target_units = side.aggroed_minion_target_units
	local BLACKBOARDS = BLACKBOARDS

	for i = 1, num_enemy_minions do
		local minion_unit = enemy_minions[i]

		if aggroed_minion_target_units[minion_unit] or BLACKBOARDS[minion_unit].perception.aggro_state ~= "passive" then
			perception_system:register_prioritized_unit_update(minion_unit)

			local navigation_extension = unit_to_navigation_extension_map[minion_unit]

			navigation_extension:stop()
		end
	end
end

function Airlock:_on_player_unit_spawned(player)
	local player_unit = player.player_unit
	self._unit_untargetable_id[player_unit] = self._perception_system:set_untargetable(self, player_unit)
end

function Airlock:stop_lockdown()
	if not self.is_server then
		return
	end

	local perception_system = self._perception_system
	local unit_untargetable_id = self._unit_untargetable_id

	for unit, id in pairs(unit_untargetable_id) do
		if ALIVE[unit] then
			perception_system:set_targetable(unit, id)
		end

		unit_untargetable_id[unit] = nil
	end

	Managers.event:unregister(self, "player_unit_spawned")
end

Airlock.component_data = {
	inputs = {
		start_lockdown = {
			accessibility = "private",
			type = "event"
		},
		stop_lockdown = {
			accessibility = "private",
			type = "event"
		}
	}
}

return Airlock
