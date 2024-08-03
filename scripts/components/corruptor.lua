local Corruptor = component("Corruptor")

function Corruptor:init(unit)
	local corruptor_extension = ScriptUnit.fetch_component_extension(unit, "corruptor_system")

	if corruptor_extension then
		local use_trigger = self:get_data(unit, "use_trigger")

		corruptor_extension:setup_from_component(use_trigger)

		self._corruptor_extension = corruptor_extension
	end
end

function Corruptor:editor_init(unit)
	return
end

function Corruptor:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_animation_state_machine(unit) then
		error_message = error_message .. "\nmissing animation state machine"
		success = false
	end

	return success, error_message
end

function Corruptor:enable(unit)
	return
end

function Corruptor:disable(unit)
	return
end

function Corruptor:destroy(unit)
	return
end

function Corruptor.events:demolition_segment_start()
	if self._corruptor_extension then
		self._corruptor_extension:awake()
	end
end

function Corruptor.events:demolition_stage_start()
	if self._corruptor_extension then
		self._corruptor_extension:expose()
	end
end

function Corruptor.events:unit_died()
	if self._corruptor_extension then
		self._corruptor_extension:died()
	end
end

function Corruptor.events:add_damage(damage, hit_actor, attack_direction)
	if self._corruptor_extension then
		self._corruptor_extension:damaged(damage)
	end
end

function Corruptor:activate_segment_units()
	if self._corruptor_extension then
		self._corruptor_extension:activate_segment_units()
	end
end

Corruptor.component_data = {
	use_trigger = {
		ui_type = "check_box",
		value = false,
		ui_name = "Use Trigger"
	},
	inputs = {
		activate_segment_units = {
			accessibility = "private",
			type = "event"
		}
	},
	extensions = {
		"CorruptorExtension"
	}
}

return Corruptor
