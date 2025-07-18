require("scripts/extension_systems/weapon/actions/action_ability_base")

local ActionUtility = require("scripts/extension_systems/weapon/actions/utilities/action_utility")
local AimProjectile = require("scripts/utilities/aim_projectile")
local LagCompensation = require("scripts/utilities/lag_compensation")
local MasterItems = require("scripts/backend/master_items")
local ProjectileLocomotionSettings = require("scripts/settings/projectile_locomotion/projectile_locomotion_settings")
local Vo = require("scripts/utilities/vo")
local locomotion_states = ProjectileLocomotionSettings.states
local ActionThrowGrenade = class("ActionThrowGrenade", "ActionWeaponBase")

function ActionThrowGrenade:init(action_context, action_params, action_settings)
	ActionThrowGrenade.super.init(self, action_context, action_params, action_settings)

	self._item_definitions = MasterItems.get_cached()
	local unit_data_extension = action_context.unit_data_extension
	self._action_aim_projectile_component = unit_data_extension:read_component("action_aim_projectile")
	self._action_settings = action_settings
	self._ability_extension = action_context.ability_extension
	self._weapon_template = action_params.weapon.weapon_template
	self._side_system = Managers.state.extension:system("side_system")
end

function ActionThrowGrenade:start(action_settings, t, ...)
	self:_check_for_critical_strike(false, true)

	local projectile_template = ActionUtility.projectile_template(action_settings, self._weapon_template, self._ability_extension)

	if projectile_template then
		Vo.throwing_item_event(self._player_unit, projectile_template.name)
	end

	self._spawn_at_time = t + (action_settings.spawn_at_time or 0)

	self:_set_haptic_trigger_template(self._action_settings, self._weapon_template)
end

local LAG_COMPENSATION_MULTIPLIER = 0.0005

function ActionThrowGrenade:fixed_update(dt, t, time_in_action)
	local rewind_ms = LagCompensation.rewind_ms(self._is_server, self._is_local_unit, self._player) * LAG_COMPENSATION_MULTIPLIER

	if self._spawn_at_time and self._spawn_at_time < t + rewind_ms then
		self._spawn_at_time = nil

		self:_spawn_projectile()

		local action_settings = self._action_settings
		local use_ability_charge = action_settings.use_ability_charge

		if use_ability_charge then
			self:_use_ability_charge()
		end
	end
end

function ActionThrowGrenade:_spawn_projectile()
	if not self._is_server then
		return
	end

	local ability_extension = self._ability_extension
	local action_settings = self._action_settings
	local weapon_template = self._weapon_template
	local item, origin_item_slot = ActionUtility.ability_item(action_settings, ability_extension)
	local projectile_template = ActionUtility.projectile_template(action_settings, weapon_template, ability_extension)
	local locomotion_template = projectile_template.locomotion_template
	local owner_unit = self._player_unit
	local material = nil
	local fire_config = action_settings.fire_configuration
	local skip_aiming = fire_config and fire_config.skip_aiming
	local first_person_component = self._first_person_component
	local look_rotation = first_person_component.rotation
	local look_position = first_person_component.position
	local position, rotation, direction, speed, momentum = AimProjectile.get_spawn_parameters_from_current_aim(action_settings, look_position, look_rotation, locomotion_template)

	if not skip_aiming then
		local throw_type = action_settings.throw_type
		local aim_parameters = AimProjectile.aim_parameters(position, look_position, look_rotation, locomotion_template, throw_type, 0)
		local radius = locomotion_template.integrator_parameters.radius
		position = AimProjectile.check_throw_position(aim_parameters.position, look_position, locomotion_template, radius, self._physics_world)
		local action_aim_projectile_component = self._action_aim_projectile_component
		rotation = action_aim_projectile_component.rotation
		speed = action_aim_projectile_component.speed
		momentum = action_aim_projectile_component.momentum
	end

	local spawn_node = action_settings.spawn_node

	if spawn_node then
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local first_person_unit = first_person_extension:first_person_unit()
		local node = Unit.node(first_person_unit, spawn_node)
		position = Unit.world_position(first_person_unit, node)
	end

	local throw_type = action_settings.throw_type
	local trajectory_parameters = locomotion_template and locomotion_template.trajectory_parameters and locomotion_template.trajectory_parameters[throw_type]
	local starting_state = trajectory_parameters and trajectory_parameters.locomotion_state or locomotion_states.manual_physics
	local is_critical_strike = self._critical_strike_component.is_active

	if self._is_server then
		local owner_side = self._side_system.side_by_unit[self._player_unit]
		local owner_side_name = owner_side and owner_side:name()
		local buff_extension = self._buff_extension
		local stat_buffs = buff_extension:stat_buffs()
		local extra_grenade_throw_chance = stat_buffs.extra_grenade_throw_chance
		local extra_direction = direction
		local extra_grenade = extra_grenade_throw_chance > 0 and math.random() < extra_grenade_throw_chance

		if extra_grenade then
			local split_settings = projectile_template.split_settings
			local split_angle = split_settings and split_settings.split_angle or math.pi * 0.05
			local angle = split_angle * (math.random() < 0.5 and -1 or 1)
			extra_direction = Quaternion.rotate(Quaternion.axis_angle(Vector3.up(), angle), extra_direction)

			if split_settings and split_settings.even_split then
				direction = Quaternion.rotate(Quaternion.axis_angle(Vector3.up(), -angle), direction)
			end
		end

		local unit_template_name = projectile_template.unit_template_name or "item_projectile"

		Managers.state.unit_spawner:spawn_network_unit(nil, unit_template_name, position, rotation, material, item, projectile_template, starting_state, direction, speed, momentum, owner_unit, is_critical_strike, origin_item_slot, nil, nil, nil, nil, nil, owner_side_name)

		if extra_grenade then
			local damage_settings = projectile_template.damage
			local fuse_settings = damage_settings and damage_settings.fuse
			local fuse_base_time = fuse_settings and fuse_settings.fuse_time
			local fuse_time_override = fuse_base_time and fuse_base_time + 0.3 or nil

			Managers.state.unit_spawner:spawn_network_unit(nil, unit_template_name, position, rotation, material, item, projectile_template, starting_state, extra_direction, speed, momentum, owner_unit, is_critical_strike, origin_item_slot, nil, nil, nil, nil, fuse_time_override, owner_side_name)
		end
	end
end

function ActionThrowGrenade:finish(reason, data, t, time_in_action)
	ActionThrowGrenade.super.finish(self, reason, data, t, time_in_action)
end

return ActionThrowGrenade
