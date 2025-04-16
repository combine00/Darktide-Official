local Blackboard = require("scripts/extension_systems/blackboard/utilities/blackboard")
local BuffSettings = require("scripts/settings/buff/buff_settings")
local SpecialRulesSettings = require("scripts/settings/ability/special_rules_settings")
local proc_events = BuffSettings.proc_events
local special_rules = SpecialRulesSettings.special_rules
local CompanionSpawnerExtension = class("CompanionSpawnerExtension")

function CompanionSpawnerExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._player_spawner_system = extension_init_context.owner_system
	self._owner_player = extension_init_data.player
	self._archetype = extension_init_data.archetype
	self._is_local_unit = extension_init_data.is_local_unit
	self._spawned_unit = nil
	self._initialized = false
end

function CompanionSpawnerExtension:game_object_initialized(session, object_id)
	self:_initialize()
end

function CompanionSpawnerExtension:_initialize()
	local owner_player = self._owner_player
	local player_unit = owner_player.player_unit
	local profile = owner_player:profile()
	local archetype = profile.archetype
	local companion_breed = archetype.companion_breed
	self._companion_breed = companion_breed
	local side_system = Managers.state.extension:system("side_system")
	local side = side_system.side_by_unit[player_unit]
	local side_id = side and side.side_id
	self._side_id = side_id
	self._initialized = true
end

function CompanionSpawnerExtension:spawn_unit()
	if not self._initialized then
		self:_initialize()
	end

	if ALIVE[self._spawned_unit] then
		return
	end

	if not self._side_id or not self._companion_breed then
		return
	end

	self:_spawn_unit()
end

function CompanionSpawnerExtension:_spawn_unit()
	local owner_player = self._owner_player
	local player_unit = owner_player.player_unit
	local position = POSITION_LOOKUP[player_unit]
	local rotation = Unit.world_rotation(player_unit, 1)
	local minion_spawn_manager = Managers.state.minion_spawn
	local param_table = minion_spawn_manager:request_param_table()
	param_table.optional_owner_player_unit = player_unit
	param_table.optional_owner_player = owner_player
	local spawned_unit = minion_spawn_manager:spawn_minion(self._companion_breed, position, rotation, self._side_id, param_table)
	self._spawned_unit = spawned_unit

	if player_unit then
		self:_proc_owner_companion_spawn_event(player_unit, self._companion_breed, spawned_unit)
	end
end

function CompanionSpawnerExtension:_proc_owner_companion_spawn_event(player_unit, companion_breed, spawned_unit)
	local player_unit_buff_extension = ScriptUnit.has_extension(player_unit, "buff_system")
	local proc_event_param_table = player_unit_buff_extension and player_unit_buff_extension:request_proc_event_param_table()

	if proc_event_param_table then
		proc_event_param_table.owner_unit = player_unit
		proc_event_param_table.companion_breed = companion_breed
		proc_event_param_table.companion_unit = spawned_unit

		player_unit_buff_extension:add_proc_event(proc_events.on_player_companion_spawn, proc_event_param_table)
	end
end

function CompanionSpawnerExtension:companion_unit()
	return self._spawned_unit
end

function CompanionSpawnerExtension:should_have_companion()
	local owner_player = self._owner_player
	local player_unit = owner_player.player_unit
	local talent_extension = ScriptUnit.has_extension(player_unit, "talent_system")
	local has_disable_companion_special_rule = talent_extension and talent_extension:has_special_rule(special_rules.disable_companion)

	return not has_disable_companion_special_rule
end

function CompanionSpawnerExtension:destroy()
	local spawned_unit = self._spawned_unit

	if spawned_unit then
		local unit_blackboard = BLACKBOARDS[spawned_unit]

		if unit_blackboard then
			local behavior_extension = ScriptUnit.extension(spawned_unit, "behavior_system")
			local spawned_unit_brain = behavior_extension:brain()
			local t = Managers.time:time("gameplay")

			spawned_unit_brain:shutdown_behavior_tree(t, true)
			spawned_unit_brain:set_active(false)
			Managers.state.minion_spawn:unregister_unit(spawned_unit)
			Managers.state.unit_spawner:mark_for_deletion(spawned_unit)
		end
	end
end

return CompanionSpawnerExtension
