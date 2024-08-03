local PlayerHubToughnessExtension = class("PlayerHubToughnessExtension")

function PlayerHubToughnessExtension:init(extension_init_context, unit, extension_init_data, game_object_data)
	self._unit = unit
	self._is_server = extension_init_context.is_server
	local toughness_template = extension_init_data.toughness_template

	self:_initialize_toughness(toughness_template)

	self._toughness_template = toughness_template

	if self._is_server then
		self._weapon_extension = ScriptUnit.extension(unit, "weapon_system")
	end
end

function PlayerHubToughnessExtension:_initialize_toughness(toughness_template)
	local toughness_constant = NetworkConstants.toughness
	local min = toughness_constant.min
	local max = toughness_constant.max
	self._max_toughness = toughness_template.max
end

function PlayerHubToughnessExtension:update(context, dt, t)
	return
end

function PlayerHubToughnessExtension:max_toughness_visual()
	return self._max_toughness
end

function PlayerHubToughnessExtension:max_toughness()
	return self._max_toughness
end

function PlayerHubToughnessExtension:toughness_damage()
	return 0
end

function PlayerHubToughnessExtension:remaining_toughness()
	return self._max_toughness
end

function PlayerHubToughnessExtension:current_toughness_percent_visual()
	return 1
end

function PlayerHubToughnessExtension:current_toughness_percent()
	return 1
end

function PlayerHubToughnessExtension:handle_max_toughness_changes_due_to_buffs()
	return
end

function PlayerHubToughnessExtension:toughness_templates()
	if self._is_server then
		local weapon_toughness_template = self._weapon_extension:toughness_template()

		return self._toughness_template, weapon_toughness_template
	else
		return self._toughness_template, nil
	end
end

function PlayerHubToughnessExtension:recover_toughness()
	return
end

function PlayerHubToughnessExtension:recover_percentage_toughness()
	return
end

function PlayerHubToughnessExtension:recover_flat_toughness()
	return
end

function PlayerHubToughnessExtension:recover_max_toughness()
	return
end

function PlayerHubToughnessExtension:set_toughness_broken_time()
	return
end

function PlayerHubToughnessExtension:time_since_toughness_broken()
	return math.huge
end

function PlayerHubToughnessExtension:set_toughness_regen_delay()
	return
end

function PlayerHubToughnessExtension:add_damage(damage_amount, attack_result, hit_actor, damage_profile, attack_type, attack_direction, hit_world_position_or_nil)
	return
end

return PlayerHubToughnessExtension
