local BuffSettings = require("scripts/settings/buff/buff_settings")
local DamageSettings = require("scripts/settings/damage/damage_settings")
local Health = require("scripts/utilities/health")
local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local PlayerUnitStatus = require("scripts/utilities/attack/player_unit_status")
local proc_events = BuffSettings.proc_events
local buff_keywords = BuffSettings.keywords
local REPORT_TIME = 1
local PlayerUnitHealthExtension = class("PlayerUnitHealthExtension")

function PlayerUnitHealthExtension:init(extension_init_context, unit, extension_init_data, game_object_data)
	self._unit = unit
	self._player = extension_init_data.player
	local world = extension_init_context.world
	self._world = world
	self._wwise_world = Wwise.wwise_world(world)
	local health = extension_init_data.health or Unit.get_data(unit, "health")
	local knocked_down_health = extension_init_data.knocked_down_health
	self._health = health
	self._knocked_down_health = knocked_down_health
	self._is_unkillable = not not extension_init_data.is_unkillable
	self._is_invulnerable = not not extension_init_data.is_invulnerable
	local damage = 0

	if extension_init_data.optional_damage then
		damage = math.clamp(extension_init_data.optional_damage, 0, health)
	end

	local permanent_damage = 0

	if extension_init_data.optional_permanent_damage then
		permanent_damage = math.clamp(extension_init_data.optional_permanent_damage, 0, health)
	end

	self._damage = damage
	self._permanent_damage = permanent_damage
	self._knocked_down_damage = 0
	self._is_dead = false
	self._is_knocked_down = false
	self._base_max_wounds = extension_init_data.wounds
	game_object_data.health = self._health
	game_object_data.knocked_down_health = self._knocked_down_health
	game_object_data.damage = self._damage
	game_object_data.permanent_damage = self._permanent_damage
	game_object_data.knocked_down_damage = self._knocked_down_damage
	game_object_data.max_wounds = self._base_max_wounds
	local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
	self._character_state_component = unit_data_extension:read_component("character_state")
	self._game_session = nil
	self._game_object_id = nil
	self._stat_record_timer = 0
end

function PlayerUnitHealthExtension:extensions_ready(world, unit)
	self._toughness_extension = ScriptUnit.extension(unit, "toughness_system")
	self._buff_extension = ScriptUnit.extension(unit, "buff_system")
end

function PlayerUnitHealthExtension:game_object_initialized(session, object_id)
	self._game_session = session
	self._game_object_id = object_id
end

function PlayerUnitHealthExtension:pre_update(unit, dt, t)
	self._was_hit_by_critical_hit_this_render_frame = false
end

function PlayerUnitHealthExtension:fixed_update(unit, dt, t)
	local is_knocked_down = PlayerUnitStatus.is_knocked_down(self._character_state_component)
	self._is_knocked_down = is_knocked_down
	local max_health = self:max_health()
	local knocked_down_health = self:max_health(true)
	local max_wounds = self:max_wounds()
	local current_health = self:current_health()

	GameSession.set_game_object_field(self._game_session, self._game_object_id, "health", max_health)
	GameSession.set_game_object_field(self._game_session, self._game_object_id, "knocked_down_health", knocked_down_health)
	GameSession.set_game_object_field(self._game_session, self._game_object_id, "max_wounds", max_wounds)

	local player = self._player
	local stats_manager = Managers.stats

	if stats_manager and player then
		local new_time = self._stat_record_timer + dt

		if REPORT_TIME <= new_time then
			local remaining_health_segments = max_wounds - Health.calculate_num_segments(current_health, max_health, max_wounds)

			stats_manager:record_private("hook_health_update", player, new_time, remaining_health_segments, is_knocked_down)

			new_time = 0
		end

		self._stat_record_timer = new_time
	end
end

function PlayerUnitHealthExtension:is_alive()
	return not self._is_dead
end

function PlayerUnitHealthExtension:is_unkillable()
	return self._is_unkillable
end

function PlayerUnitHealthExtension:is_invulnerable()
	local is_invulnerable = self._is_invulnerable
	local buff_extension = self._buff_extension
	is_invulnerable = is_invulnerable or buff_extension and buff_extension:has_keyword(buff_keywords.invulnerable) or false

	return is_invulnerable
end

function PlayerUnitHealthExtension:current_health()
	local max_health = self:max_health()
	local damage_taken = self:damage_taken()

	return max_health - damage_taken
end

function PlayerUnitHealthExtension:current_health_percent()
	local max_health = self:max_health()
	local damage_taken = self:damage_taken()

	if damage_taken < 0 then
		return 0
	end

	return (max_health - damage_taken) / max_health
end

function PlayerUnitHealthExtension:damage_taken()
	if self._is_knocked_down then
		return self._knocked_down_damage
	else
		return self._damage
	end
end

function PlayerUnitHealthExtension:permanent_damage_taken()
	if self._is_knocked_down then
		return 0
	else
		return self._permanent_damage
	end
end

function PlayerUnitHealthExtension:permanent_damage_taken_percent()
	local max_health = self:max_health()
	local permanent_damage = self:permanent_damage_taken()

	if max_health <= 0 then
		return 0
	end

	return permanent_damage / max_health
end

function PlayerUnitHealthExtension:total_damage_taken()
	return self:damage_taken()
end

function PlayerUnitHealthExtension:max_health(force_knocked_down_health)
	local stat_buffs = self._buff_extension:stat_buffs()
	local health = nil

	if self._is_knocked_down or force_knocked_down_health then
		local knocked_down_health_modifier = stat_buffs.knocked_down_health_modifier or 1
		health = self._knocked_down_health * knocked_down_health_modifier
	else
		health = self._health
	end

	local max_health_multiplier = stat_buffs.max_health_multiplier
	local max_health_modifier = stat_buffs.max_health_modifier
	health = health * max_health_multiplier * max_health_modifier
	health = math.ceil(health)

	return health
end

function PlayerUnitHealthExtension:add_damage(damage_amount, permanent_damage, hit_actor, damage_profile, attack_type, attack_direction, attacking_unit)
	local current_damage = self:damage_taken()
	local current_permanent_damage = self:permanent_damage_taken()
	local max_health = self:max_health()
	local new_damage = math.clamp(current_damage + damage_amount, 0, max_health)
	local new_permanent_damage = math.clamp(current_permanent_damage + permanent_damage, 0, max_health)

	self:_set_damage(new_damage)
	self:_set_permanent_damage(new_permanent_damage)

	local actual_damage_dealt = math.clamp(damage_amount, 0, max_health - current_damage)

	return actual_damage_dealt
end

function PlayerUnitHealthExtension:add_heal(heal_amount, heal_type)
	local damage_taken = self:damage_taken()
	local permanent_damage_taken = self:permanent_damage_taken()
	local actual_heal_amount, new_permanent_damage, new_damage = nil

	if DamageSettings.permanent_heal_types[heal_type] then
		actual_heal_amount = math.min(permanent_damage_taken, heal_amount)
		new_permanent_damage = permanent_damage_taken - actual_heal_amount
		new_damage = damage_taken
	else
		local buffs = self._buff_extension:stat_buffs()
		local healing_buff_modifier = buffs.healing_recieved_modifier or 1
		heal_amount = heal_amount * healing_buff_modifier
		new_permanent_damage = permanent_damage_taken
		local clamped_heal = math.min(damage_taken, heal_amount)
		new_damage = math.max(damage_taken - clamped_heal, permanent_damage_taken)
		actual_heal_amount = damage_taken - new_damage
	end

	self:_set_permanent_damage(new_permanent_damage)
	self:_set_damage(new_damage)

	local param_table = self._buff_extension:request_proc_event_param_table()

	if param_table then
		param_table.damage_amount = heal_amount
		param_table.heal_type = heal_type

		self._buff_extension:add_proc_event(proc_events.on_healing_taken, param_table)
	end

	return actual_heal_amount
end

function PlayerUnitHealthExtension:reduce_permanent_damage(amount)
	local permanent_damage_taken = self:permanent_damage_taken()
	local max_health = self:max_health()
	local max_wounds = self:max_wounds()
	local current_wounds = self:num_wounds()
	local fixed_permanent_damage = nil

	if current_wounds == max_wounds then
		fixed_permanent_damage = math.floor(max_health * (1 - current_wounds / max_wounds))
	else
		fixed_permanent_damage = math.floor(max_health * (1 - current_wounds / max_wounds) + 1)
	end

	local new_permanent_damage = math.max(fixed_permanent_damage, permanent_damage_taken - amount)

	self:_set_permanent_damage(new_permanent_damage)
end

function PlayerUnitHealthExtension:on_player_unit_spawn(spawn_health_percentage)
	local max_health = self:max_health()
	local spawn_damage = math.ceil(max_health * (1 - spawn_health_percentage))

	self:_set_damage(spawn_damage)
end

function PlayerUnitHealthExtension:on_player_unit_respawn(respawn_health_percentage)
	local max_health = self:max_health()
	local respawn_damage = math.ceil(max_health * (1 - respawn_health_percentage))

	self:_set_damage(respawn_damage)
end

function PlayerUnitHealthExtension:remove_wounds(num_wounds)
	local max_health = self:max_health()
	local damage = self:damage_taken()
	local max_wounds = self:max_wounds()
	local current_wounds = self:num_wounds()
	local new_wounds = current_wounds - num_wounds
	local new_permanent_damage = max_wounds > 0 and max_health * (1 - new_wounds / max_wounds) or 0
	new_permanent_damage = math.ceil(new_permanent_damage * 10) / 10
	local new_damage = damage

	if damage < new_permanent_damage then
		new_damage = new_permanent_damage
	end

	self:_set_permanent_damage(new_permanent_damage)
	self:_set_damage(new_damage)
end

function PlayerUnitHealthExtension:entered_knocked_down()
	local game_session = self._game_session
	local game_object_id = self._game_object_id
	local knocked_down_damage = 0
	self._knocked_down_damage = knocked_down_damage

	GameSession.set_game_object_field(game_session, game_object_id, "knocked_down_damage", knocked_down_damage)
end

function PlayerUnitHealthExtension:exited_knocked_down()
	local game_session = self._game_session
	local game_object_id = self._game_object_id
	local permanent_damage = self._permanent_damage
	local new_damage = permanent_damage
	self._damage = new_damage

	GameSession.set_game_object_field(game_session, game_object_id, "damage", new_damage)
end

function PlayerUnitHealthExtension:health_depleted()
	if self._is_unkillable then
		return false
	else
		local max_health = self:max_health()
		local damage = self:damage_taken()

		return max_health <= damage
	end
end

function PlayerUnitHealthExtension:should_die()
	if self._is_unkillable then
		return false
	else
		local num_wounds = self:num_wounds()

		if num_wounds <= 0 then
			return true
		end

		local max_health = self:max_health()

		if max_health <= 0 then
			return true
		end

		return false
	end
end

function PlayerUnitHealthExtension:set_unkillable(should_be_unkillable)
	self._is_unkillable = should_be_unkillable
end

function PlayerUnitHealthExtension:set_invulnerable(should_be_invulnerable)
	self._is_invulnerable = should_be_invulnerable
end

function PlayerUnitHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	self._last_damaging_unit = last_damaging_unit
	self._last_hit_zone_name = hit_zone_name
	self._last_hit_was_critical = last_hit_was_critical
	self._was_hit_by_critical_hit_this_render_frame = self._was_hit_by_critical_hit_this_render_frame or last_hit_was_critical
end

function PlayerUnitHealthExtension:last_damaging_unit()
	return self._last_damaging_unit
end

function PlayerUnitHealthExtension:last_hit_zone_name()
	return self._last_hit_zone_name
end

function PlayerUnitHealthExtension:last_hit_was_critical()
	return self._last_hit_was_critical
end

function PlayerUnitHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return self._was_hit_by_critical_hit_this_render_frame
end

function PlayerUnitHealthExtension:kill()
	Managers.event:trigger("unit_died", self._unit)

	HEALTH_ALIVE[self._unit] = nil
	self._is_dead = true
end

function PlayerUnitHealthExtension:num_wounds()
	local permanent_damage = self:permanent_damage_taken()
	local max_wounds = self:max_wounds()
	local max_health = self:max_health()
	local num_wounds = Health.calculate_num_segments(permanent_damage, max_health, max_wounds)

	return num_wounds
end

function PlayerUnitHealthExtension:max_wounds()
	local buff_extension = self._buff_extension
	local stat_buffs = buff_extension:stat_buffs()
	local extra_wounds = stat_buffs.extra_max_amount_of_wounds or 0

	return math.max(self._base_max_wounds + extra_wounds, 1)
end

function PlayerUnitHealthExtension:_set_damage(damage)
	local max_health = self:max_health()
	local network_damage = math.min(damage, max_health)

	if self._is_knocked_down then
		self._knocked_down_damage = damage

		GameSession.set_game_object_field(self._game_session, self._game_object_id, "knocked_down_damage", network_damage)
	else
		self._damage = damage

		GameSession.set_game_object_field(self._game_session, self._game_object_id, "damage", network_damage)
	end
end

function PlayerUnitHealthExtension:_set_permanent_damage(permanent_damage)
	if not self._is_knocked_down then
		self._permanent_damage = permanent_damage
		local max_health = self:max_health()
		local network_permanent_damage = math.min(permanent_damage, max_health)

		GameSession.set_game_object_field(self._game_session, self._game_object_id, "permanent_damage", network_permanent_damage)
	end
end

function PlayerUnitHealthExtension:persistent_data()
	local max_health = self._health
	local damage_percent = math.clamp(self._damage, 0, max_health) / max_health
	local permanent_damage_percent = math.clamp(self._permanent_damage, 0, max_health) / max_health

	return damage_percent, permanent_damage_percent
end

function PlayerUnitHealthExtension:apply_persistent_data(damage_percent, permanent_damage_percent)
	local max_health = self._health

	self:_set_damage(max_health * damage_percent)
	self:_set_permanent_damage(max_health * permanent_damage_percent)
end

implements(PlayerUnitHealthExtension, HealthExtensionInterface)

return PlayerUnitHealthExtension
