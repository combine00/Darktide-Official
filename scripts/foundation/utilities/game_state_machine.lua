local GameStateMachine = class("GameStateMachine")
GameStateMachine.DEBUG = true

local function _debug_print(format, ...)
	if GameStateMachine.DEBUG then
		if rawget(_G, "Log") then
			Log.info("GameStateMachine", format, ...)
		else
			print(string.format("[GameStateMachine] " .. format, ...))
		end
	end

	if rawget(_G, "Managers") and Managers.server_metrics then
		Managers.server_metrics:add_annotation(string.format("[GameStateMachine] " .. format, ...))
	end
end

function GameStateMachine:init(parent, start_state, params, optional_creation_context, state_change_callbacks, name, log_breadcrumbs)
	self._parent = parent
	self._next_state = start_state
	self._next_state_params = params
	self._optional_creation_context = optional_creation_context
	self._name = name
	self._log_breadcrumbs = log_breadcrumbs
	self._state_change_callbacks = {}

	if state_change_callbacks then
		for reference_name, callback in pairs(state_change_callbacks) do
			self:register_on_state_change_callback(reference_name, callback)
		end
	end

	_debug_print("[%s] Init statemachine with '%s'", name, start_state.__class_name)
	self:_change_state()
end

function GameStateMachine:register_on_state_change_callback(reference_name, callback)
	self._state_change_callbacks[reference_name] = callback
end

function GameStateMachine:unregister_on_state_change_callback(reference_name)
	self._state_change_callbacks[reference_name] = nil
end

function GameStateMachine:next_state()
	return self._next_state
end

function GameStateMachine:_log_state_change(current_state, next_state)
	local current_state_name = ""

	if current_state then
		current_state_name = current_state.__class_name
	end

	local next_state_name = ""

	if next_state then
		next_state_name = next_state.__class_name
	end

	_debug_print("[%s] Changing state '%s' -> '%s'", self._name, current_state_name, next_state_name)
	Profiler.send_message(string.format("[%s] Changing state '%s' -> '%s'", self._name, current_state_name, next_state_name))
end

function GameStateMachine:_change_state()
	local new_state = self._next_state
	local params = self._next_state_params
	self._next_state = nil
	self._next_state_params = nil
	local current_state_name = self:current_state_name()

	if self._state and self._state.on_exit then
		self._state:on_exit()
		self._state:delete()
	end

	local new_state_name = new_state.__class_name
	local state_change_callbacks = self._state_change_callbacks

	for _, callback in pairs(state_change_callbacks) do
		callback(current_state_name, new_state_name)
	end

	self._state = new_state:new()

	if rawget(_G, "Crashify") and self._log_breadcrumbs then
		Crashify.print_breadcrumb(string.format("Entering Game State %s", new_state_name))
	end

	if self._state.on_enter then
		self._state:on_enter(self._parent, params, self._optional_creation_context)
	end
end

function GameStateMachine:force_change_state(state, params)
	if self._state == state then
		return
	end

	self._next_state = state
	self._next_state_params = params

	self:_log_state_change(self._state, self._next_state)
	self:_change_state()
end

function GameStateMachine:update(dt, t)
	if self._next_state then
		self:_log_state_change(self._state, self._next_state)
		self:_change_state()
	end

	self._next_state, self._next_state_params = self._state:update(dt, t)
end

function GameStateMachine:post_update(dt, t)
	if self._state and self._state.post_update then
		self._state:post_update(dt, t)
	end
end

function GameStateMachine:render()
	if self._state and self._state.render then
		self._state:render()
	end
end

function GameStateMachine:post_render()
	if self._state and self._state.post_render then
		self._state:post_render()
	end
end

function GameStateMachine:on_reload(refreshed_resources)
	if self._state and self._state.on_reload then
		self._state:on_reload(refreshed_resources)
	end
end

function GameStateMachine:on_close()
	if self._state and self._state.on_close then
		return self._state:on_close()
	else
		return true
	end
end

function GameStateMachine:destroy(...)
	local state_change_callbacks = self._state_change_callbacks

	if not table.is_empty(state_change_callbacks) then
		for reference_name, _ in pairs(state_change_callbacks) do
			if rawget(_G, "Log") then
				Log.warning("GameStateMachine", "Found unregistered callback for state change by name: (%s)", reference_name)
			else
				_debug_print("Found unregistered callback for state change by name: (%s)", reference_name)
			end
		end

		ferror("[GameStateMachine] - Trying to terminate state machine without cleaning up registered callbacks.")
	end

	_debug_print("[%s] Exit statemachine from '%s'", self._name, self._state.__class_name)

	if self._state and self._state.on_exit then
		self._state:on_exit(...)
	end
end

function GameStateMachine:current_state_name()
	if self._state then
		return self._state.__class_name
	else
		return ""
	end
end

function GameStateMachine:current_state()
	return self._state
end

return GameStateMachine
