local MinigameSettings = require("scripts/settings/minigame/minigame_settings")

require("scripts/extension_systems/minigame/minigames/minigame_base")

local FX_SOURCE_NAME = "_speaker"
local MinigameBalance = class("MinigameBalance", "MinigameBase")

function MinigameBalance:init(unit, is_server, seed)
	MinigameBalance.super.init(self, unit, is_server, seed)

	self._stage_amount = 1
	self._current_stage = 1
	self._position = {
		x = 0,
		y = 0
	}
	self._speed = {
		x = 0,
		y = 0
	}
	self._last_axis_set = 0
	self._disrupt_timer = 0
	self._objective = nil
	self._start_progression = 0
	self._is_stuck_indication = false
	self._sound_alert_time = 0
end

function MinigameBalance:hot_join_sync(sender, channel)
	MinigameBalance.super.hot_join_sync(self, sender, channel)
end

function MinigameBalance:_player_fail(player)
	if not player then
		Log.error("MinigameBalance", "Trying to access user but there is none")

		return
	end

	local unique_id = player:unique_id()
	self._misses_per_player[unique_id] = (self._misses_per_player[unique_id] or 0) + 1
end

function MinigameBalance:decode_interrupt()
	MinigameBalance.super.decode_interrupt(self)

	local target_extension = ScriptUnit.has_extension(self._minigame_unit, "mission_objective_target_system")

	if self._start_progression == 0 and target_extension then
		local objective_name = target_extension:objective_name()
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")
		local objective = mission_objective_system:active_objective(objective_name)
		self._start_progression = objective and objective:progression() or 0
	end
end

function MinigameBalance:start(player)
	MinigameBalance.super.start(self, player)

	self._moved_time = Managers.time:time("gameplay")

	Unit.flow_event(self._minigame_unit, "lua_minigame_start")

	if player then
		self:_setup_sound(player, FX_SOURCE_NAME)

		local player_unit = player.player_unit

		Unit.set_flow_variable(self._minigame_unit, "player_unit", player_unit)
	end

	local target_extension = ScriptUnit.has_extension(self._minigame_unit, "mission_objective_target_system")

	if target_extension then
		local objective_name = target_extension:objective_name()
		local mission_objective_system = Managers.state.extension:system("mission_objective_system")
		self._objective = mission_objective_system:active_objective(objective_name)
	end
end

function MinigameBalance:stop()
	Unit.flow_event(self._minigame_unit, "lua_minigame_stop")
	MinigameBalance.super.stop(self)
end

function MinigameBalance:setup_game()
	MinigameBalance.super.setup_game(self)
end

function MinigameBalance:update(dt, t)
	MinigameBalance.super.update(self, dt, t)

	if self._is_server then
		local pos = self._position
		local speed = self._speed
		pos.x = pos.x + speed.x * dt
		pos.y = pos.y + speed.y * dt
		local aim_away = math.atan2(-pos.y, pos.x)
		local distance = math.sqrt(pos.x * pos.x + pos.y * pos.y)

		if distance > 1.02 then
			pos.x = math.cos(aim_away) * 1.01
			pos.y = -math.sin(aim_away) * 1.01
			speed.x = 0
			speed.y = 0
		elseif distance < 1 then
			local power = (1 - distance) * MinigameSettings.balance_push_ratio * dt
			speed.x = speed.x + math.cos(aim_away) * power
			speed.y = speed.y - math.sin(aim_away) * power
		end

		self._disrupt_timer = self._disrupt_timer - dt

		if not self:progressing() then
			self._disrupt_timer = MinigameSettings.balance_disrupt_interval
		elseif self._disrupt_timer <= 0 then
			self._disrupt_timer = self._disrupt_timer + MinigameSettings.balance_disrupt_interval
			local aim_random = math.random(0, math.pi * 2)
			local power = MinigameSettings.balance_disrupt_power
			speed.x = speed.x + math.cos(aim_random) * power
			speed.y = speed.y - math.sin(aim_random) * power
		end

		local max_speed = MinigameSettings.balance_max_speed
		speed.x = math.clamp(speed.x, -max_speed, max_speed)
		speed.y = math.clamp(speed.y, -max_speed, max_speed)

		self:send_rpc("rpc_minigame_sync_balance_set_position", pos.x, pos.y)

		if self._sound_alert_time > 0 then
			self._sound_alert_time = self._sound_alert_time - dt
		else
			local is_stuck = not self:progressing()

			if is_stuck ~= self._is_stuck_indication then
				if is_stuck then
					self:play_sound("sfx_minigame_fail")
				end

				self._is_stuck_indication = is_stuck
				self._sound_alert_time = MinigameSettings.balance_sound_block
			end
		end
	end
end

function MinigameBalance:on_axis_set(t, x, y)
	MinigameBalance.super.on_axis_set(self, t, x, y)

	if not self._is_server then
		return
	end

	y = -y
	local dt = t - self._last_axis_set
	self._last_axis_set = t
	local changed = false

	if x ~= 0 then
		local old_x = self._speed.x
		local new_x = self._speed.x + x * MinigameSettings.balance_move_ratio * dt

		if old_x ~= new_x then
			self._speed.x = new_x
			changed = true
		end
	end

	if y ~= 0 then
		local old_y = self._speed.y
		local new_y = self._speed.y + y * MinigameSettings.balance_move_ratio * dt

		if old_y ~= new_y then
			self._speed.y = new_y
			changed = true
		end
	end
end

function MinigameBalance:uses_action()
	return false
end

function MinigameBalance:uses_joystick()
	return true
end

function MinigameBalance:set_position(x, y)
	local pos = self._position
	pos.x = x
	pos.y = y
end

function MinigameBalance:position()
	return self._position
end

function MinigameBalance:progressing()
	local pos = self._position

	return math.sqrt(pos.x * pos.x + pos.y * pos.y) < 1
end

function MinigameBalance:distance()
	local pos = self._position

	return math.sqrt(pos.x * pos.x + pos.y * pos.y)
end

function MinigameBalance:progression()
	if not self._objective or self._objective.__deleted then
		return 0
	end

	return (self._objective:progression() - self._start_progression) / (1 - self._start_progression)
end

return MinigameBalance
