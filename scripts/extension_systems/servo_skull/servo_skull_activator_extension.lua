local ServoSkullActivatorExtension = class("ServoSkullActivatorExtension")

function ServoSkullActivatorExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_server = extension_init_context.is_server
	self._unit = unit
	self._hidden = true
	self._interactee_extension = nil
	self._mission_objective_target_extension = nil
	self._objective_name = nil

	Unit.set_visibility(unit, "main", false)
end

function ServoSkullActivatorExtension:extensions_ready(world, unit)
	local interactee_extension = ScriptUnit.extension(unit, "interactee_system")
	local interaction_type = interactee_extension:interaction_type()
	local mission_objective_target_extension = ScriptUnit.extension(unit, "mission_objective_target_system")
	self._objective_name = mission_objective_target_extension:objective_name()
	self._interactee_extension = interactee_extension
	self._mission_objective_target_extension = mission_objective_target_extension
end

function ServoSkullActivatorExtension:on_gameplay_post_init(unit)
	local mission_objective_system = Managers.state.extension:system("mission_objective_system")
	local synchronizer_unit = mission_objective_system:objective_synchronizer_unit(self._objective_name)

	if synchronizer_unit == nil then
		Log.error("ServoSkullActivatorExtension", "[on_gameplay_post_init] Please setup ServoSkullActivator component for unit(%s, %s) else the scanning event is not functional.", tostring(self._unit), Unit.id_string(self._unit))
	else
		local synchronizer_unit_extension = ScriptUnit.extension(synchronizer_unit, "event_synchronizer_system")

		synchronizer_unit_extension:register_servor_skull_activator_extension(self)
		self._interactee_extension:set_active(false)
	end
end

function ServoSkullActivatorExtension:on_start_event()
	self:set_visibility(true)
	self._interactee_extension:set_active(true)

	if self._is_server then
		self._mission_objective_target_extension:add_unit_marker()
	end
end

function ServoSkullActivatorExtension:deactivate()
	self:set_visibility(false)
	self._interactee_extension:set_active(false)

	if self._is_server then
		self._mission_objective_target_extension:remove_unit_marker()
	end
end

function ServoSkullActivatorExtension:hidden()
	return self._hidden
end

function ServoSkullActivatorExtension:objective_name()
	return self._objective_name
end

function ServoSkullActivatorExtension:set_visibility(value)
	local unit = self._unit

	Unit.set_visibility(unit, "main", value)

	self._hidden = not value

	if self._is_server then
		local level_unit_id = Managers.state.unit_spawner:level_index(unit)

		Managers.state.game_session:send_rpc_clients("rpc_servo_skull_activator_set_visibility", level_unit_id, value)
	end
end

return ServoSkullActivatorExtension
