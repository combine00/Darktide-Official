local Component = require("scripts/utilities/component")
local HealthExtensionInterface = require("scripts/extension_systems/health/health_extension_interface")
local PropHealthExtension = class("PropHealthExtension")
PropHealthExtension.UPDATE_DISABLED_BY_DEFAULT = true

function PropHealthExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id)
	self._owner_system = extension_init_context.owner_system
	local is_server = extension_init_context.is_server
	self._unit = unit
	self._is_server = is_server
	self._health = 100
	self._damage = 0
	self._is_dead = false
	self._is_unkillable = false
	self._is_invulnerable = false
	self._regenerate_health = false
	self._breed_white_list = nil
	self._ignored_colliders = {}
	self._update_enabled = not PropHealthExtension.UPDATE_DISABLED_BY_DEFAULT
	self._speed_on_hit = 0
end

local HEALTH_DIFFICULTY_SCALING = {
	0.4,
	0.6,
	0.75,
	1,
	1
}

function PropHealthExtension:setup_from_component(create_health_game_object, health, difficulty_scaling, invulnerable, unkillable, regenerate_health, breed_white_list, ignored_collider_actor_names, speed_on_hit)
	if not self._is_server then
		return
	end

	if difficulty_scaling then
		local health_scale = Managers.state.difficulty:get_table_entry_by_challenge(HEALTH_DIFFICULTY_SCALING)
		health = health * health_scale
	end

	self._health = health
	self._damage = 0
	self._is_invulnerable = invulnerable
	self._is_unkillable = unkillable
	self._regenerate_health = regenerate_health
	self._create_health_game_object = create_health_game_object

	if breed_white_list then
		local white_list = {}

		for ii = 1, #breed_white_list do
			white_list[breed_white_list[ii]] = true
		end

		self._breed_white_list = white_list
	end

	self._speed_on_hit = speed_on_hit

	if ignored_collider_actor_names then
		local unit = self._unit

		for ii = 1, #ignored_collider_actor_names do
			local actor = Unit.actor(unit, ignored_collider_actor_names[ii])
			self._ignored_colliders[actor] = true
		end
	end

	if regenerate_health and not self._update_enabled then
		self._update_enabled = true

		self._owner_system:enable_update_function(self.__class_name, "fixed_update", self._unit, self)
	end
end

function PropHealthExtension:on_unit_id_resolved(world, unit)
	if self._is_server and self._create_health_game_object then
		self:_create_game_object()
	end
end

function PropHealthExtension:destroy()
	if self._is_server and self._game_object_id then
		self:_destroy_game_object()
	end
end

function PropHealthExtension:_create_game_object()
	local is_level_unit, unit_id = Managers.state.unit_spawner:game_object_id_or_level_index(self._unit)
	local game_object_data = {
		game_object_type = NetworkLookup.game_object_types.prop_health,
		is_level_unit = is_level_unit,
		unit_id = unit_id,
		health = self._health,
		damage = self._damage,
		is_dead = self._is_dead
	}
	local game_session = Managers.state.game_session:game_session()
	local game_object_id = GameSession.create_game_object(game_session, "prop_health", game_object_data)
	self._game_session = game_session
	self._game_object_id = game_object_id
end

function PropHealthExtension:_destroy_game_object()
	GameSession.destroy_game_object(self._game_session, self._game_object_id)

	self._game_session = nil
	self._game_object_id = nil
end

function PropHealthExtension:on_game_object_created(game_session, game_object_id)
	self._game_session = game_session
	self._game_object_id = game_object_id

	if not self._update_enabled then
		self._update_enabled = true

		self._owner_system:enable_update_function(self.__class_name, "update", self._unit, self)
	end
end

function PropHealthExtension:on_game_object_destroyed(game_session, game_object_id)
	self._game_session = nil
	self._game_object_id = nil

	if self._update_enabled then
		self._update_enabled = false

		self._owner_system:disable_update_function(self.__class_name, "update", self._unit, self)
	end
end

function PropHealthExtension:pre_update(unit, dt, t)
	self._was_hit_by_critical_hit_this_render_frame = false
end

function PropHealthExtension:fixed_update(unit, dt, t)
	if self._is_dead or not self._regenerate_health or not self._is_server then
		return
	end

	local damage = self._damage

	if damage > 0 then
		local current_health_percent = self:current_health_percent()
		local heal_multiplier = math.lerp(1, 5, 1 - current_health_percent)
		local heal_amount = self._health * 0.05 * heal_multiplier * dt
		local heal_type = nil

		self:add_heal(heal_amount, heal_type)
	end
end

function PropHealthExtension:update(unit, dt, t)
	local game_session = self._game_session
	local game_object_id = self._game_object_id

	if self._is_server or not game_session or not game_object_id then
		return
	end

	local was_dead = self._is_dead
	self._damage = GameSession.game_object_field(game_session, game_object_id, "damage")
	self._health = GameSession.game_object_field(game_session, game_object_id, "health")
	self._is_dead = GameSession.game_object_field(game_session, game_object_id, "is_dead")

	if not was_dead and self._is_dead then
		self:_died()

		if self._update_enabled then
			self._update_enabled = false

			self._owner_system:disable_update_function(self.__class_name, "update", self._unit, self)
		end
	end
end

function PropHealthExtension:kill()
	if self._is_unkillable then
		Log.warning("PropHealthExtension", "Trying to kill prop health extension which is unkillable")

		return
	end

	self._is_dead = true

	if self._game_object_id then
		GameSession.set_game_object_field(self._game_session, self._game_object_id, "is_dead", true)
	end

	self:_died()
end

function PropHealthExtension:_died()
	Component.event(self._unit, "unit_died")
	Unit.flow_event(self._unit, "lua_prop_died")

	HEALTH_ALIVE[self._unit] = nil
end

local function _add_force_on_parts(actor, mass, speed, attack_direction)
	local direction = attack_direction

	if not direction then
		local random_x = math.random() * 2 - 1
		local random_y = math.random() * 2 - 1
		local random_z = math.random() * 2 - 1
		local random_direction = Vector3(random_x, random_y, random_z)
		random_direction = Vector3.normalize(random_direction)
		direction = random_direction
	end

	Actor.add_impulse(actor, direction * mass * speed)
end

function PropHealthExtension:add_damage(damage_amount, permanent_damage, hit_actor, damage_profile, attack_type, attack_direction, attacking_unit)
	if self._ignored_colliders[hit_actor] then
		return 0
	end

	if not self:_can_receive_damage(attacking_unit, attack_type) then
		return 0
	end

	local current_damage = self._damage
	local health = self._health
	local new_damage = current_damage + damage_amount
	local game_session = self._game_session
	local game_object_id = self._game_object_id

	if game_session and game_object_id then
		local network_damage = math.min(new_damage, health)

		GameSession.set_game_object_field(game_session, game_object_id, "damage", network_damage)
	end

	self._damage = new_damage

	if hit_actor and Actor.is_dynamic(hit_actor) then
		_add_force_on_parts(hit_actor, Actor.mass(hit_actor), self._speed_on_hit, attack_direction)
	end

	local unit = self._unit

	Component.event(unit, "add_damage", damage_amount, hit_actor, attack_direction, attacking_unit)
	Component.event(unit, "on_hit", attack_direction, attacking_unit)
	Unit.set_flow_variable(unit, "lua_prop_health_percentage", health - new_damage / health)
	Unit.flow_event(unit, "lua_prop_damaged")

	if health <= new_damage then
		self:kill()
	end

	return damage_amount
end

function PropHealthExtension:add_heal(heal_amount, heal_type)
	local health = self._health
	local old_damage = self._damage
	local actual_heal_amount = math.min(heal_amount, old_damage)
	local new_damage = old_damage - actual_heal_amount
	local game_session = self._game_session
	local game_object_id = self._game_object_id

	if game_session and game_object_id then
		local network_damage = math.min(new_damage, health)

		GameSession.set_game_object_field(game_session, game_object_id, "damage", network_damage)
	end

	self._damage = new_damage

	return actual_heal_amount
end

function PropHealthExtension:set_last_damaging_unit(last_damaging_unit, hit_zone_name, last_hit_was_critical)
	self._last_damaging_unit = last_damaging_unit
	self._last_hit_zone_name = hit_zone_name
	self._last_hit_was_critical = last_hit_was_critical
	self._was_hit_by_critical_hit_this_render_frame = self._was_hit_by_critical_hit_this_render_frame or last_hit_was_critical
end

function PropHealthExtension:last_damaging_unit()
	return self._last_damaging_unit
end

function PropHealthExtension:last_hit_zone_name()
	return self._last_hit_zone_name
end

function PropHealthExtension:last_hit_was_critical()
	return self._last_hit_was_critical
end

function PropHealthExtension:was_hit_by_critical_hit_this_render_frame()
	return self._was_hit_by_critical_hit_this_render_frame
end

function PropHealthExtension:max_health()
	return self._health
end

function PropHealthExtension:current_health()
	return math.max(0, self._health - self._damage)
end

function PropHealthExtension:current_health_percent()
	local health = self._health

	if health <= 0 then
		return 0
	end

	return math.max(0, 1 - self._damage / health)
end

function PropHealthExtension:damage_taken()
	return self._damage
end

function PropHealthExtension:permanent_damage_taken()
	return 0
end

function PropHealthExtension:permanent_damage_taken_percent()
	return 0
end

function PropHealthExtension:total_damage_taken()
	return math.min(self._health, self._damage)
end

function PropHealthExtension:health_depleted()
	if self._is_unkillable then
		return false
	else
		return self._health <= self._damage
	end
end

function PropHealthExtension:is_alive()
	return not self._is_dead
end

function PropHealthExtension:is_unkillable()
	return self._is_unkillable
end

function PropHealthExtension:is_invulnerable()
	return self._is_invulnerable
end

function PropHealthExtension:set_unkillable(should_be_unkillable)
	if not self._is_server then
		return
	end

	self._is_unkillable = should_be_unkillable
end

function PropHealthExtension:set_invulnerable(should_be_invulnerable)
	if not self._is_server then
		return
	end

	self._is_invulnerable = should_be_invulnerable
end

function PropHealthExtension:num_wounds()
	return 1
end

function PropHealthExtension:max_wounds()
	return 1
end

function PropHealthExtension:create_health_game_object()
	return self._create_health_game_object
end

function PropHealthExtension:_can_receive_damage(attacking_unit, attack_type)
	if attacking_unit == self._unit then
		return true
	end

	if self._is_dead or self._is_invulnerable then
		return false
	end

	if attack_type and attack_type == "door_smash" then
		return true
	end

	local breed_white_list = self._breed_white_list

	if not breed_white_list then
		return true
	end

	local unit_data_extension = ScriptUnit.has_extension(attacking_unit, "unit_data_system")

	if unit_data_extension then
		local breed_name = unit_data_extension:breed_name()

		return breed_white_list[breed_name]
	end

	return false
end

implements(PropHealthExtension, HealthExtensionInterface)

return PropHealthExtension
