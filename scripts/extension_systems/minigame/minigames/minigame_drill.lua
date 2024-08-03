local MinigameSettings = require("scripts/settings/minigame/minigame_settings")

require("scripts/extension_systems/minigame/minigames/minigame_base")

local FX_SOURCE_NAME = "_speaker"
local MinigameDrill = class("MinigameDrill", "MinigameBase")

function MinigameDrill:init(unit, is_server, seed, context)
	MinigameDrill.super.init(self, unit, is_server, seed, context)

	self._start_seed = seed
	self._cursor_position = nil
	self._selected_index = nil
	self._last_move = 0
	self._search_time = false
	self._transition_start_time = nil
	self._stage_amount = MinigameSettings.drill_stage_amount
	self._targets = {}
	self._correct_targets = {}
end

function MinigameDrill:hot_join_sync(sender, channel)
	MinigameDrill.super.hot_join_sync(self, sender, channel)

	if #self._correct_targets ~= 0 then
		self:send_rpc_to_channel(channel, "rpc_minigame_sync_drill_generate_targets", self._start_seed)
	end

	if self._current_stage then
		self:send_rpc_to_channel(channel, "rpc_minigame_sync_set_stage", self._current_stage)
	end

	if self._cursor_position then
		self:send_rpc_to_channel(channel, "rpc_minigame_sync_drill_set_cursor", self._cursor_position.x, self._cursor_position.y, self._selected_index or 0)
	end

	if self._search_time then
		self:send_rpc_to_channel(channel, "rpc_minigame_sync_drill_set_search", true, self._search_time)
	end
end

function MinigameDrill:start(player)
	MinigameDrill.super.start(self, player)
	Unit.flow_event(self._minigame_unit, "lua_minigame_start")

	local is_server = self._is_server

	if is_server then
		local player_unit = player.player_unit
		local visual_loadout_extension = ScriptUnit.extension(player_unit, "visual_loadout_system")
		local fx_sources = visual_loadout_extension:source_fx_for_slot("slot_device")

		Unit.set_flow_variable(self._minigame_unit, "player_unit", player_unit)

		self._fx_extension = ScriptUnit.extension(player_unit, "fx_system")
		self._fx_source_name = fx_sources[FX_SOURCE_NAME]
	end
end

function MinigameDrill:stop()
	Unit.flow_event(self._minigame_unit, "lua_minigame_stop")

	if self._is_server then
		self._current_stage = nil
	end

	MinigameDrill.super.stop(self)
end

function MinigameDrill:complete()
	MinigameDrill.super.complete(self)
	table.clear(self._correct_targets)
end

function MinigameDrill:setup_game()
	MinigameDrill.super.setup_game(self)

	if #self._correct_targets == 0 then
		self:generate_targets(self._seed)
		self:send_rpc("rpc_minigame_sync_drill_generate_targets", self._start_seed)
	end

	self._current_stage = 1

	self:send_rpc("rpc_minigame_sync_set_stage", self._current_stage)

	self._cursor_position = {
		x = 0,
		y = 0
	}
	self._selected_index = nil

	self:send_rpc("rpc_minigame_sync_drill_set_cursor", self._cursor_position.x, self._cursor_position.y, 0)

	self._search_time = false

	self:send_rpc("rpc_minigame_sync_drill_set_search", false, 0)
end

local function _target_overlap(x, y, targets)
	for i = 1, #targets do
		local target = targets[i]

		if math.sqrt((x - target.x) * (x - target.x) + (y - target.y) * (y - target.y)) < 0.35 then
			return true
		end
	end

	return false
end

function MinigameDrill:generate_targets(seed)
	self._start_seed = seed
	local targets = self._targets
	local correct_targets = self._correct_targets

	for stage = 1, MinigameSettings.drill_stage_amount do
		seed, correct_targets[stage] = math.next_random(seed, 1, MinigameSettings.drill_stage_targets)
		local stage_targets = targets[stage] or {}
		targets[stage] = stage_targets

		table.clear(stage_targets)

		for target = 1, MinigameSettings.drill_stage_targets do
			local x, y = nil

			repeat
				seed, x = math.next_random(seed, 1, 100)
				x = -0.8 + x / 100 * 1.6
				seed, y = math.next_random(seed, 1, 100)
				y = -0.5 + y / 100 * 1
			until not _target_overlap(x, y, stage_targets)

			stage_targets[target] = {
				x = x,
				y = y
			}
		end
	end

	self._seed = seed
end

function MinigameDrill:handle_state(state)
	state = MinigameDrill.super.handle_state(self, state)

	if state == MinigameSettings.game_states.transition or state == MinigameSettings.game_states.outro then
		self._transition_start_time = Managers.time:time("gameplay")
	end

	return state
end

function MinigameDrill:update(dt, t)
	MinigameDrill.super.update(self, dt, t)

	if not self._is_server then
		return
	end

	if self._current_state == MinigameSettings.game_states.transition then
		if MinigameSettings.drill_transition_time < t - self._transition_start_time then
			self:set_state(MinigameSettings.game_states.gameplay)
		end

		return
	elseif self._current_state ~= MinigameSettings.game_states.gameplay then
		return
	end

	local search_time = self._search_time

	if search_time then
		local progress_time = t - (search_time + MinigameSettings.drill_search_time)

		if progress_time >= 0 and progress_time < dt then
			if self:is_on_target() then
				self:play_sound("sfx_minigame_bio_selection_right")
			else
				self:play_sound("sfx_minigame_bio_selection_wrong")
			end
		end
	end
end

function MinigameDrill:on_action_pressed(t)
	MinigameDrill.super.on_action_pressed(self, t)

	if self._current_state ~= MinigameSettings.game_states.gameplay or not self._selected_index then
		return
	end

	if not self._search_time then
		return
	end

	if self:search_percentage(t) < 1 then
		return
	end

	if self:is_on_target() then
		self._search_time = false

		self:send_rpc("rpc_minigame_sync_drill_set_search", false, 0)

		self._selected_index = nil
		self._cursor_position.x = 0
		self._cursor_position.y = 0

		self:send_rpc("rpc_minigame_sync_drill_set_cursor", self._cursor_position.x, self._cursor_position.y, 0)

		self._current_stage = math.min(self._current_stage + 1, self._stage_amount + 1)

		self:send_rpc("rpc_minigame_sync_set_stage", self._current_stage)
		self:set_state(MinigameSettings.game_states.transition)

		if self._stage_amount < self._current_stage then
			Unit.flow_event(self._minigame_unit, "lua_minigame_success_last")
			self:play_sound("sfx_minigame_bio_progress_last")
		else
			Unit.flow_event(self._minigame_unit, "lua_minigame_success")
			self:play_sound("sfx_minigame_bio_progress")
		end
	else
		Unit.flow_event(self._minigame_unit, "lua_minigame_fail")
		self:play_sound("sfx_minigame_bio_fail")
	end
end

function MinigameDrill:on_axis_set(t, x, y)
	MinigameDrill.super.on_axis_set(self, t, x, y)

	if self._current_state ~= MinigameSettings.game_states.gameplay then
		return
	end

	if x == 0 and y == 0 then
		return
	end

	if t <= self._last_move + MinigameSettings.drill_move_delay then
		return
	end

	self._last_move = t
	local aim_radian = math.atan2(-y, x)
	local targets = self._targets[self._current_stage]
	local closest_index = nil
	local lowest_points = math.huge
	local cursor_position = self._cursor_position

	for i = 1, #targets do
		if i ~= self._selected_index then
			local target = targets[i]
			local radian = math.atan2(target.y - cursor_position.y, target.x - cursor_position.x)
			local angle = math.abs(radian - aim_radian)

			if math.pi < angle then
				angle = 2 * math.pi - angle
			end

			local distance = math.sqrt((cursor_position.x - target.x) * (cursor_position.x - target.x) + (cursor_position.y - target.y) * (cursor_position.y - target.y))
			local points = distance + angle * MinigameSettings.drill_move_distance_power

			if lowest_points > points and angle < math.pi / 3 then
				closest_index = i
				lowest_points = points
			end
		end
	end

	if closest_index then
		self._selected_index = closest_index
		local target = targets[closest_index]
		cursor_position.x = target.x
		cursor_position.y = target.y

		self:send_rpc("rpc_minigame_sync_drill_set_cursor", self._cursor_position.x, self._cursor_position.y, closest_index)

		self._search_time = t

		self:send_rpc("rpc_minigame_sync_drill_set_search", true, t)
		self:play_sound("sfx_minigame_bio_selection")
	end
end

function MinigameDrill:should_exit()
	if self._current_state == MinigameSettings.game_states.outro and MinigameSettings.drill_transition_time < Managers.time:time("gameplay") - self._transition_start_time then
		return true
	end

	return false
end

function MinigameDrill:uses_joystick()
	return true
end

function MinigameDrill:is_on_target()
	if not self._selected_index then
		return false
	end

	return self._selected_index == self._correct_targets[self._current_stage]
end

function MinigameDrill:selected_index()
	return self._selected_index
end

function MinigameDrill:targets()
	return self._targets
end

function MinigameDrill:correct_targets()
	return self._correct_targets
end

function MinigameDrill:set_cursor_position(x, y, selected_target)
	if not self._cursor_position then
		self._cursor_position = {}
	end

	self._cursor_position.x = x
	self._cursor_position.y = y

	if selected_target ~= 0 then
		self._selected_index = selected_target
	else
		self._selected_index = nil
	end
end

function MinigameDrill:cursor_position()
	return self._cursor_position
end

function MinigameDrill:set_searching(t)
	self._search_time = t
end

function MinigameDrill:is_searching()
	return not not self._search_time
end

function MinigameDrill:search_percentage(t)
	if not self._search_time then
		return 0
	end

	return math.clamp((t - self._search_time) / MinigameSettings.drill_search_time, 0, 1)
end

function MinigameDrill:transition_percentage(t)
	if self._current_state ~= MinigameSettings.game_states.transition and self._current_state ~= MinigameSettings.game_states.outro then
		return 0
	end

	return math.clamp((t - self._transition_start_time) / MinigameSettings.drill_transition_time, 0, 1)
end

return MinigameDrill
