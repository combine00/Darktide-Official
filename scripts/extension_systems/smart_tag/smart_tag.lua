local ProjectileLocomotionSettings = require("scripts/settings/projectile_locomotion/projectile_locomotion_settings")
local projectile_valid_interaction_states = ProjectileLocomotionSettings.valid_interaction_states
local SmartTag = class("SmartTag")
local REMOVE_TAG_REASONS = table.enum("canceled_by_owner", "expired", "group_limit_exceeded", "tagged_unit_removed", "tagged_unit_died", "invalid_interaction_state", "health_station_depleted", "smart_tag_system_destroyed", "external_removal")
SmartTag.REMOVE_TAG_REASONS = REMOVE_TAG_REASONS

function SmartTag:init(tag_id, template, tagger_unit, target_unit, target_location, replies, is_server)
	self._id = tag_id
	self._template = template
	self._tagger_unit = tagger_unit
	self._target_unit = target_unit
	self._target_unit_outline = template.target_unit_outline
	self._replies = replies or {}
	self._is_server = is_server
	self._tagger_player = Managers.state.player_unit_spawn:owner(tagger_unit)

	if target_unit then
		local unit_data_extension = ScriptUnit.has_extension(target_unit, "unit_data_system")

		if unit_data_extension then
			self._breed = unit_data_extension:breed()
		end
	end

	if target_location then
		self._target_location = Vector3Box(target_location)
	end
end

function SmartTag:destroy()
	self._tagger_unit = nil
	self._tagger_player = nil
	self._template = nil
	self._target_unit = nil
	self._target_location = nil
	self._replies = nil
end

function SmartTag:id()
	return self._id
end

function SmartTag:template()
	return self._template
end

function SmartTag:group()
	return self._template.group
end

function SmartTag:target_unit()
	return self._target_unit
end

function SmartTag:target_location()
	local target_location = self._target_location

	if target_location then
		return target_location:unbox()
	end
end

function SmartTag:display_name()
	local target_unit = self._target_unit

	if target_unit then
		local smart_tag_extension = ScriptUnit.has_extension(target_unit, "smart_tag_system")

		return smart_tag_extension:display_name()
	end

	local template = self._template

	return template.display_name
end

function SmartTag:tagger_unit()
	return self._tagger_unit
end

function SmartTag:tagger_player()
	return self._tagger_player
end

function SmartTag:set_expire_time(expire_time)
	self._expire_time = expire_time
end

function SmartTag:expire_time()
	return self._expire_time
end

function SmartTag:clear_tagger()
	self._tagger_unit = nil
	self._tagger_player = nil
end

function SmartTag:add_reply(replier_unit, reply)
	self._replies[replier_unit] = reply
end

function SmartTag:remove_reply(replier_unit)
	self._replies[replier_unit] = nil
end

function SmartTag:replies()
	return self._replies
end

function SmartTag:available_replies()
	return self._template.replies
end

function SmartTag:default_reply()
	local replies = self._template.replies
	local reply = replies and replies[1]

	return reply
end

function SmartTag:is_cancelable()
	return self._template.is_cancelable
end

function SmartTag:is_valid(t)
	if self._expire_time <= t then
		return false, REMOVE_TAG_REASONS.expired
	end

	local target_unit = self._target_unit

	if target_unit then
		return self.validate_target_unit(target_unit)
	else
		return true
	end
end

function SmartTag.validate_target_unit(target_unit)
	if not Unit.alive(target_unit) then
		return false, REMOVE_TAG_REASONS.tagged_unit_died
	end

	local target_type = Unit.get_data(target_unit, "smart_tag_target_type")

	if target_type == "pickup" then
		local locomotion_extension = ScriptUnit.has_extension(target_unit, "locomotion_system")

		if locomotion_extension then
			local current_state = locomotion_extension:current_state()

			if current_state and not projectile_valid_interaction_states[current_state] then
				return false, REMOVE_TAG_REASONS.invalid_interaction_state
			end
		end
	elseif target_type == "breed" then
		if not HEALTH_ALIVE[target_unit] then
			return false, REMOVE_TAG_REASONS.tagged_unit_died
		end
	elseif target_type == "health_station" then
		local health_station_extension = ScriptUnit.extension(target_unit, "health_station_system")
		local has_battery = health_station_extension:battery_in_slot()

		if has_battery then
			local charge_amount = health_station_extension:charge_amount()

			if charge_amount == 0 then
				return false, REMOVE_TAG_REASONS.health_station_depleted
			end
		end
	end

	return true
end

function SmartTag:breed()
	return self._breed
end

function SmartTag:target_unit_outline()
	return self._target_unit_outline
end

function SmartTag:set_target_unit_outline(wanted_target_unit_outline)
	self._target_unit_outline = wanted_target_unit_outline
end

return SmartTag
