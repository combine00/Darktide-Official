local ChainSwordSpin = component("ChainSwordSpin")
local DEFAULT_SPEED = 1

function ChainSwordSpin:init(unit)
	if not Unit.has_animation_state_machine(unit) then
		self._initialized = false

		return
	end

	self._initialized = true
	self._unit = unit
	self._speed_variable_index = Unit.animation_find_variable(unit, "speed")

	self:_set_speed()
end

function ChainSwordSpin:editor_validate(unit)
	return true, ""
end

function ChainSwordSpin:_set_speed(speed)
	speed = speed or DEFAULT_SPEED
	local unit = self._unit

	if speed >= 0 then
		Unit.animation_event(unit, "forward")
	else
		Unit.animation_event(unit, "backward")

		speed = -speed
	end

	Unit.animation_set_variable(unit, self._speed_variable_index, speed)
end

function ChainSwordSpin:enable(unit)
	return
end

function ChainSwordSpin:disable(unit)
	return
end

function ChainSwordSpin:destroy(unit)
	return
end

function ChainSwordSpin.events:set_speed(speed)
	if not self._initialized then
		Log.error("ChainSwordSpin", "Trying to set speed for a unit without an animation state machine")

		return
	end

	self:_set_speed(speed)
end

ChainSwordSpin.component_data = {
	inputs = {
		set_speed = {
			accessibility = "public",
			type = "event"
		}
	}
}

return ChainSwordSpin
