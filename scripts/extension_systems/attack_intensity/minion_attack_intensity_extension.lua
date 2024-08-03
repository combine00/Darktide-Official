local AttackIntensitySettings = require("scripts/settings/attack_intensity/attack_intensity_settings")
local Breed = require("scripts/utilities/breed")
local MinionAttackIntensityExtension = class("MinionAttackIntensityExtension")
local attack_intensities = AttackIntensitySettings.attack_intensities

function MinionAttackIntensityExtension:init(extension_init_context, unit, extension_init_data)
	local breed = extension_init_data.breed
	local cooldowns = breed.attack_intensity_cooldowns
	self._cooldowns = cooldowns
	self._breed = breed
	local difficulty_settings = {}
	local allowed_attacks = {}
	local uses_suppression = breed.suppress_config ~= nil

	for intensity_type, _ in pairs(cooldowns) do
		local settings = Managers.state.difficulty:get_table_entry_by_challenge(attack_intensities[intensity_type])
		allowed_attacks[intensity_type] = true
		difficulty_settings[intensity_type] = settings
	end

	self._difficulty_settings = difficulty_settings
	local blackboard = BLACKBOARDS[unit]
	self._perception_component = blackboard.perception

	if uses_suppression then
		self._suppression_component = blackboard.suppression
	end

	self._allowed_attacks = allowed_attacks
	self._current_cooldowns = {}
end

function MinionAttackIntensityExtension:update(unit, dt, t)
	local perception_component = self._perception_component
	local target_unit = perception_component.target_unit

	if not HEALTH_ALIVE[target_unit] then
		return
	end

	if self._allow_all_attacks_duration and self._allow_all_attacks_duration <= t then
		self._allow_all_attacks_duration = nil
		self._allow_all_attacks = false
	end

	local target_unit_data_extension = ScriptUnit.extension(target_unit, "unit_data_system")
	local breed = target_unit_data_extension:breed()
	local target_movement_state = nil

	if Breed.is_player(breed) then
		local movement_state_component = target_unit_data_extension:read_component("movement_state")
		target_movement_state = movement_state_component.method
	end

	local target_attack_intensity_extension = ScriptUnit.has_extension(target_unit, "attack_intensity_system")
	local suppression_component = self._suppression_component
	local cooldowns = self._cooldowns
	local current_cooldowns = self._current_cooldowns
	local allowed_attacks = self._allowed_attacks

	for intensity_type, cooldown in pairs(cooldowns) do
		repeat
			local difficulty_settings = self._difficulty_settings[intensity_type]
			local ignored_movement_states = difficulty_settings.ignored_movement_states
			local ignore_attack_intensity = ignored_movement_states and ignored_movement_states[target_movement_state]

			if ignore_attack_intensity then
				allowed_attacks[intensity_type] = true
			elseif suppression_component then
				local disallow_when_suppressed = difficulty_settings.disallow_when_suppressed
				local is_suppressed = suppression_component.is_suppressed
			else
				local attack_allowed = not target_attack_intensity_extension or target_attack_intensity_extension:attack_allowed(intensity_type)
				local ignore_cooldown = false

				if attack_allowed then
					if current_cooldowns[intensity_type] and t < current_cooldowns[intensity_type] then
						allowed_attacks[intensity_type] = false
					else
						allowed_attacks[intensity_type] = true
						current_cooldowns[intensity_type] = nil
					end
				elseif not current_cooldowns[intensity_type] then
					current_cooldowns[intensity_type] = t + (ignore_cooldown and 0 or math.random_range(cooldown[1], cooldown[2]))
					allowed_attacks[intensity_type] = false
				elseif current_cooldowns[intensity_type] <= t then
					current_cooldowns[intensity_type] = nil
				end
			end
		until true
	end
end

function MinionAttackIntensityExtension:set_monster_attacker(attacker_unit)
	return
end

function MinionAttackIntensityExtension:monster_attacker()
	return
end

function MinionAttackIntensityExtension:add_intensity(intensity_type, intensity)
	return
end

function MinionAttackIntensityExtension:get_intensity(intensity_type)
	return 0
end

function MinionAttackIntensityExtension:attack_allowed(intensity_type)
	return true
end

function MinionAttackIntensityExtension:locked_in_melee()
	return false
end

function MinionAttackIntensityExtension:add_to_locked_in_melee_timer()
	return
end

function MinionAttackIntensityExtension:set_attacked()
	return
end

function MinionAttackIntensityExtension:set_attacked_melee()
	return
end

function MinionAttackIntensityExtension:set_allow_all_attacks_duration(duration)
	local t = Managers.time:time("gameplay")
	self._allow_all_attacks_duration = t + duration
	self._allow_all_attacks = true
end

function MinionAttackIntensityExtension:remove_attacked_melee()
	return
end

function MinionAttackIntensityExtension:can_attack(attack_type)
	if self._allow_all_attacks then
		return true
	end

	return self._allowed_attacks[attack_type]
end

return MinionAttackIntensityExtension
