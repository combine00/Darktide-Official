local NetworkedTimerExtension = class("NetworkedTimerExtension")

function NetworkedTimerExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_server = extension_init_context.is_server
	self._unit = unit
	self._duration = 0
	self._hud_description = "loc_description"
	self._max_speed_modifier = 1
	self._reset_speed_modifier_on_state_change = true
	self._active = false
	self._counting = false
	self._total_timer = 0
	self._speed_modifier = 1
end

function NetworkedTimerExtension:setup_from_component(duration, hud_description, max_speed_modifier, reset_speed_modifier_on_state_change)
	if duration ~= nil then
		self._duration = duration
	end

	if hud_description ~= nil then
		self._hud_description = hud_description
	end

	if max_speed_modifier ~= nil then
		self._max_speed_modifier = max_speed_modifier
	end

	if reset_speed_modifier_on_state_change ~= nil then
		self._reset_speed_modifier_on_state_change = reset_speed_modifier_on_state_change
	end
end

function NetworkedTimerExtension:update(unit, dt, t)
	if self._active then
		if self._total_timer < self._duration then
			if self._counting then
				self._total_timer = math.min(self._total_timer + dt * self._speed_modifier, self._duration)
			end
		elseif self._is_server then
			self:finished()
		end
	end
end

function NetworkedTimerExtension:hot_join_sync(unit, sender, channel)
	local unit_id = Managers.state.unit_spawner:level_index(self._unit)
	local active = self._active
	local counting = self._counting
	local total_timer = self._total_timer
	local speed_modifier_normalized = self._speed_modifier / self._max_speed_modifier

	Managers.state.game_session:send_rpc_clients("rpc_networked_timer_sync_state", unit_id, active, counting, total_timer, speed_modifier_normalized)
end

function NetworkedTimerExtension:sync_state(active, counting, total_timer, speed_modifier_normalized)
	self._active = active
	self._counting = counting
	self._total_timer = total_timer

	self:set_speed_modifier_with_normalized_value(speed_modifier_normalized)

	if active then
		Unit.flow_event(self._unit, "lua_timer_sync_active")
		Unit.flow_event(self._unit, counting and "lua_timer_sync_counting" or "lua_timer_sync_paused")
	end
end

function NetworkedTimerExtension:start()
	self._active = true
	self._counting = true
	self._speed_modifier = self._reset_speed_modifier_on_state_change and 1 or self._speed_modifier

	Unit.flow_event(self._unit, "lua_timer_started")

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_start", unit_id)
	end
end

function NetworkedTimerExtension:start_paused()
	self._active = true
	self._counting = false
	self._speed_modifier = self._reset_speed_modifier_on_state_change and 1 or self._speed_modifier

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)
		local active = self._active
		local counting = self._counting
		local total_timer = self._total_timer
		local speed_modifier_normalized = self._speed_modifier / self._max_speed_modifier

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_sync_state", unit_id, active, counting, total_timer, speed_modifier_normalized)
	end
end

function NetworkedTimerExtension:pause()
	self._counting = false
	self._speed_modifier = self._reset_speed_modifier_on_state_change and 1 or self._speed_modifier

	Unit.flow_event(self._unit, "lua_timer_paused")

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_pause", unit_id)
	end
end

function NetworkedTimerExtension:stop()
	self._active = false
	self._counting = false
	self._total_timer = 0
	self._speed_modifier = self._reset_speed_modifier_on_state_change and 1 or self._speed_modifier

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_stop", unit_id)
	end
end

function NetworkedTimerExtension:set_speed_modifier_with_normalized_value(speed_modifier_normalized)
	speed_modifier_normalized = math.clamp01(speed_modifier_normalized)
	self._speed_modifier = self._max_speed_modifier * speed_modifier_normalized
end

function NetworkedTimerExtension:set_speed_modifier(new_speed_modifier)
	if not self._is_server then
		return
	end

	self._speed_modifier = math.min(new_speed_modifier, self._max_speed_modifier)
	local unit_id = Managers.state.unit_spawner:level_index(self._unit)
	local speed_modifier_normalized = new_speed_modifier / self._max_speed_modifier

	Managers.state.game_session:send_rpc_clients("rpc_networked_timer_set_speed_modifier", unit_id, speed_modifier_normalized)
end

function NetworkedTimerExtension:fast_forward()
	if self._speed_modifier < 1 then
		self._speed_modifier = 1
	end

	self._speed_modifier = self._speed_modifier + 1
	self._speed_modifier = math.min(self._speed_modifier, self._max_speed_modifier)

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_fast_forward", unit_id)
	end
end

function NetworkedTimerExtension:rewind()
	return
end

function NetworkedTimerExtension:finished()
	self._active = false
	self._counting = false
	self._total_timer = 0

	Unit.flow_event(self._unit, "lua_timer_finished")

	if self._is_server then
		local unit_id = Managers.state.unit_spawner:level_index(self._unit)

		Managers.state.game_session:send_rpc_clients("rpc_networked_timer_finished", unit_id)
	end
end

function NetworkedTimerExtension:is_active()
	return self._active
end

function NetworkedTimerExtension:is_counting()
	return self._counting
end

function NetworkedTimerExtension:get_timer()
	return self._total_timer
end

function NetworkedTimerExtension:get_remaining_time()
	return self._duration - self._total_timer
end

function NetworkedTimerExtension:progression()
	local progression = 0

	if self._duration > 0 then
		progression = self._total_timer / self._duration
	end

	progression = math.clamp(progression, 0, 1)

	return progression
end

return NetworkedTimerExtension
