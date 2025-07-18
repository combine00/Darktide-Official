local GrowQueue = require("scripts/foundation/utilities/grow_queue")
local PriorityQueue = require("scripts/foundation/utilities/priority_queue")
local Promise = require("scripts/foundation/utilities/promise")
local StatConfigParser = require("scripts/managers/stats/utility/stat_config_parser")
local StatDefinitions = require("scripts/managers/stats/stat_definitions")
local StatNetworkTypes = require("scripts/settings/stats/stat_network_types")
local StatsManager = class("StatsManager")
local CLIENT_RPCS = {}

table.append(CLIENT_RPCS, table.map(table.keys(StatNetworkTypes), function (s)
	return "rpc_stat_update_" .. s
end))

local UserStates = table.enum("pulling", "pushing", "idle", "tracking")
StatsManager.user_states = UserStates

function StatsManager:init(is_client, event_delegate, rpc_settings)
	self._definitions = StatDefinitions
	self._event_delegate = event_delegate
	rpc_settings = rpc_settings or {
		{
			required_buffer = 25000,
			rpc_per_frame = 3
		},
		{
			required_buffer = 15000,
			rpc_per_frame = 2
		},
		{
			required_buffer = 5000,
			rpc_per_frame = 1
		}
	}
	self._rpc_settings = rpc_settings
	self._stat_lookup = {}
	local sorted_stat_keys = {}

	for key in pairs(self._definitions) do
		table.insert(sorted_stat_keys, key)
	end

	table.sort(sorted_stat_keys)

	for _, key in ipairs(sorted_stat_keys) do
		local stat = self._definitions[key]
		self._stat_lookup[stat.index] = key
	end

	self._last_t = 0
	self._next_listener_id = 0
	self._listeners = {}
	self._is_client = is_client

	if is_client then
		self._event_delegate:register_connection_events(self, unpack(CLIENT_RPCS))
	end

	self._next_user = 0

	self:clear()
end

function StatsManager:_valid_account_id(account_id)
	return account_id ~= nil and account_id ~= Managers.player.NO_ACCOUNT_ID
end

function StatsManager:_default_team()
	return {
		key = "TEAM",
		data = {},
		listeners = {},
		triggers = {},
		rpc_queue = GrowQueue:new(),
		rpc_dirty = {},
		trigger_queue = PriorityQueue:new()
	}
end

function StatsManager:clear()
	self._team = self:_default_team()
	self._users = {}
end

function StatsManager:destroy()
	for key, _ in pairs(self._users) do
		self:remove_user(key)
	end

	if self._is_client then
		self._event_delegate:unregister_events(unpack(CLIENT_RPCS))
	end
end

function StatsManager:_get_smallest_send_rpc(size)
	local rpcs_calls = self._rpc_calls
	local rpc_call_count = #rpcs_calls

	for i = 1, rpc_call_count - 1 do
		local call_data = rpcs_calls[i]
		local in_range = call_data.min <= size and size <= call_data.max

		if in_range then
			return call_data
		end
	end

	return rpcs_calls[rpc_call_count]
end

function StatsManager:_update_rpcs(user)
	local channel_id = user.rpc_channel

	if not channel_id then
		return
	end

	local peer_id = Network.peer_id(channel_id)
	local remaining_buffer_size = Network.reliable_send_buffer_left(peer_id)
	local settings_index = 1
	local rpc_settings = self._rpc_settings

	while settings_index <= #rpc_settings and remaining_buffer_size < rpc_settings[settings_index].required_buffer do
		settings_index = settings_index + 1
	end

	local rpc_setting = rpc_settings[settings_index]
	local rpc_per_frame = rpc_setting and rpc_setting.rpc_per_frame

	if not rpc_per_frame then
		return
	end

	local queue = user.rpc_queue
	local dirty = user.rpc_dirty
	local definitions = self._definitions
	local data = user.data
	local count = math.min(queue:size(), rpc_per_frame)

	for _ = 1, count do
		local stat_key = queue:pop_first()
		local stat = definitions[stat_key]
		dirty[stat_key] = false
		local value_to_send = math.round(data[stat_key])
		local rpc_data = self:_get_smallest_send_rpc(value_to_send)
		value_to_send = math.clamp(value_to_send, rpc_data.min, rpc_data.max)

		rpc_data.rpc(channel_id, user.local_player_id, stat.index, value_to_send)
	end
end

function StatsManager:_update_triggers(user, t)
	local trigger_queue = user.trigger_queue

	if not trigger_queue then
		return
	end

	while not trigger_queue:empty() and trigger_queue:peek() <= t do
		local _, values = trigger_queue:pop()
		local trigger = values[1]
		local stat = values[2]

		self:_trigger(user, trigger(stat, user.data, unpack(values, 3)))
	end
end

function StatsManager:update(dt, t)
	self._last_t = t

	if self:has_session() then
		local team = self._team
		local users = self._users
		local rpc_dirty = team.rpc_dirty
		local rpc_queue = team.rpc_queue

		while not rpc_queue:empty() do
			local stat_name = rpc_queue:pop_first()
			rpc_dirty[stat_name] = false

			for _, user in pairs(users) do
				local is_tracking = user.state == UserStates.tracking
				local is_dirty_remote = user.rpc_dirty and not user.rpc_dirty[stat_name]

				if is_tracking and is_dirty_remote then
					user.rpc_dirty[stat_name] = true

					user.rpc_queue:push_back(stat_name)
				end
			end
		end

		self:_update_triggers(team, t)
	end

	for _, user in pairs(self._users) do
		self:_update_rpcs(user)
		self:_update_triggers(user, t)
	end
end

function StatsManager:_empty_user(key, account_id, rpc_channel, local_player_id)
	local team_data = self._team.data
	local user = {
		key = key,
		account_id = account_id,
		rpc_channel = rpc_channel,
		local_player_id = local_player_id,
		state = UserStates.idle,
		data = setmetatable({}, {
			__index = team_data
		}),
		listeners = {}
	}

	if rpc_channel then
		user.rpc_queue = GrowQueue:new()
		user.rpc_dirty = {}
	end

	return user
end

function StatsManager:_initiate_stats(key)
	local users = self._users
	local user = users[key]
	local save_data = user.data
	local definitions = self._definitions

	for stat_id, definition in pairs(definitions) do
		local initiate_function = definition.init

		if save_data[stat_id] == nil and initiate_function then
			save_data[stat_id] = initiate_function(definition, save_data)
		end
	end

	for stat_id, _ in pairs(save_data) do
		if not definitions[stat_id] then
			save_data[stat_id] = nil
		end
	end
end

function StatsManager:_download_stats(key)
	local users = self._users
	local user = users[key]
	local account_id = user.account_id
	local backend_promise = Managers.backend.interfaces.commendations:get_commendations(account_id, false, true):next(function (data)
		return data.stats
	end)
	user.state = UserStates.pulling
	user.promise = backend_promise

	return backend_promise:next(function (backend_stats)
		user.state = UserStates.idle
		user.saved_data = {}

		for i = 1, #backend_stats do
			local stat_id = backend_stats[i].stat
			local value = backend_stats[i].value
			user.data[stat_id] = self:_parse_backend_value(value)
			user.saved_data[stat_id] = value
		end

		self:_initiate_stats(key)
	end)
end

function StatsManager:_initialize_rpcs()
	if self._rpc_calls then
		return
	end

	local rpc_calls = {}
	self._rpc_calls = rpc_calls

	for _, name in pairs(StatNetworkTypes) do
		local rpc_value_name = "stat_value_" .. name
		local rpc_value_info = Network.type_info(rpc_value_name)
		local min_value = rpc_value_info.min
		local max_value = rpc_value_info.max
		rpc_calls[#rpc_calls + 1] = {
			rpc = RPC["rpc_stat_update_" .. name],
			min = min_value,
			max = max_value
		}
	end

	table.sort(rpc_calls, function (a, b)
		return a.max < b.max
	end)
end

function StatsManager:add_user(key, account_id, rpc_channel, local_player_id)
	local users = self._users

	if not self:_valid_account_id(account_id) then
		account_id = nil
	end

	self:_initialize_rpcs()

	users[key] = self:_empty_user(key, account_id, rpc_channel, local_player_id)
	local listeners = self._listeners

	for listener_id, listener in pairs(listeners) do
		if listener.key == key then
			self:_attach_listener(key, listener_id)
		end
	end

	local promise = Promise.resolved()

	if account_id then
		promise = self:_download_stats(key)
	else
		self:_initiate_stats(key)
	end

	return promise
end

function StatsManager:remove_user(key)
	local user = self._users[key]

	if user == self._next_user then
		self._next_user = 0
	end

	if user.state == UserStates.tracking then
		self:stop_tracking_user(key)
	end

	if user.rpc_queue then
		user.rpc_queue:delete()
	end

	local listeners = self._listeners

	for listener_id, listener in pairs(listeners) do
		if listener.key == key then
			self:_detach_listener(key, listener_id)
		end
	end

	self._users[key] = nil

	if user.promise then
		user.promise:cancel()
	end
end

function StatsManager:user_state(key)
	local user = self._users[key]

	return user and user.state
end

function StatsManager:_data_version(data)
	local version = 0
	local definitions = self._definitions
	local stat_lookup = self._stat_lookup

	for i = 1, #stat_lookup do
		local id = stat_lookup[i]
		local stat = definitions[id]
		local flags = stat.flags

		if flags.backend then
			local send_value = self:_parse_backend_value(data[id] or stat.default)
			version = (11 * version + send_value + 1) % 32768
		end
	end

	return version
end

function StatsManager:user_version(key)
	local user = self._users[key]
	local data = user and user.data

	if data then
		return self:_data_version(data)
	end
end

function StatsManager:clear_session_data(key)
	local user = self._users[key]
	local data = user.data
	local definitions = self._definitions

	for id, stat in pairs(definitions) do
		local is_persistent = stat.flags.backend

		if not is_persistent then
			data[id] = nil
		end
	end
end

function StatsManager:reload(key)
	local user = self._users[key]
	local team_data = self._team.data
	user.data = setmetatable({}, {
		__index = team_data
	})

	if not self:_valid_account_id(user.account_id) then
		return Promise.resolved(nil)
	end

	return self:_download_stats(key)
end

function StatsManager:start_session(session_config)
	local parsed_session_config, config_error = StatConfigParser.modify("session", session_config)
	self._session_config = parsed_session_config
	self._session_stash = {}
	local team = self._team

	table.clear(team.data)

	local definitions = self._definitions
	local team_triggers = team.triggers

	for _, to_stat in pairs(definitions) do
		local include_condition = to_stat.include_condition
		local is_to_team = to_stat.flags.team
		local should_include = is_to_team and (not include_condition or include_condition(to_stat, parsed_session_config))

		if should_include then
			local stat_triggers = to_stat.triggers
			local stat_trigger_count = stat_triggers and #stat_triggers or 0

			for i = 1, stat_trigger_count do
				local trigger = stat_triggers[i]
				local from_stat_name = trigger.id
				local from_stat = definitions[from_stat_name]
				local is_from_team = from_stat.flags.team

				if is_from_team then
					local triggers = team_triggers[from_stat_name] or {}
					triggers[#triggers + 1] = {
						stat = to_stat,
						func = trigger.trigger,
						delay = trigger.delay,
						user = team
					}
					team_triggers[from_stat_name] = triggers
				end
			end
		end
	end
end

function StatsManager:stop_session()
	local team = self._team
	team.triggers = {}

	team.trigger_queue:clear()

	local promises = {}

	for _, user in pairs(self._users) do
		local should_save = user.state == "tracking"
		local is_saving = user.state == "pushing"

		if should_save or is_saving then
			promises[#promises + 1] = self:stop_tracking_user(user.key)
		end
	end

	self._session_config = nil
	self._session_stash = nil

	return Promise.all(unpack(promises))
end

function StatsManager:has_session()
	return self._session_stash ~= nil
end

function StatsManager:_get_stashed_data(user)
	local account_id = user.account_id

	if not account_id then
		return nil
	end

	local session_stash = self._session_stash
	local stashed_data = session_stash[account_id]
	session_stash[account_id] = nil

	return stashed_data
end

function StatsManager:is_tracking_user(key)
	local user = self._users[key]
	local is_tracking = user and user.state == UserStates.tracking

	return is_tracking
end

function StatsManager:start_tracking_user(key, user_config)
	local user = self._users[key]
	local definitions = self._definitions
	local stashed_data = self:_get_stashed_data(user)
	local stashed_config = stashed_data and stashed_data.config
	local parsed_user_config, config_error = StatConfigParser.modify("user", user_config, stashed_config)
	local configs_match = stashed_config and table.equals(stashed_config, parsed_user_config)
	local data_match = stashed_data and self:user_version(key) == self:_data_version(stashed_data.data)

	if configs_match and data_match then
		Log.info("StatsManager", "Reusing stats for user '%s'.", key)

		local dirty = user.rpc_dirty
		local queue = user.rpc_queue
		local is_remote = dirty ~= nil
		local stash_data = stashed_data.data
		local user_data = user.data

		for stat_name, value in pairs(stash_data) do
			local stat = definitions[stat_name]
			local flags = stat.flags
			local ignore_recover = flags.no_recover or flags.team or flags.hook

			if value ~= user_data[stat_name] and not ignore_recover then
				user_data[stat_name] = value
				local ignore_sync = flags.hook or flags.no_sync

				if is_remote and not ignore_sync then
					dirty[stat_name] = true

					queue:push_back(stat_name)
				end
			end
		end
	end

	local team = self._team
	local user_triggers = {}
	local config = setmetatable(parsed_user_config, {
		__index = self._session_config
	})

	for _, stat in pairs(definitions) do
		local include_condition = stat.include_condition
		local should_include = not include_condition or include_condition(stat, config)

		if should_include then
			local stat_triggers = stat.triggers
			local stat_trigger_count = stat_triggers and #stat_triggers or 0

			for i = 1, stat_trigger_count do
				local stat_trigger = stat_triggers[i]
				local from_stat_id = stat_trigger.id
				local from_stat = definitions[from_stat_id]
				local from_team = from_stat.flags.team
				local to_team = stat.flags.team

				if not from_team or not to_team then
					local to_user = to_team and team or user
					local from_triggers = from_team and team.triggers or user_triggers
					local triggers = from_triggers[from_stat_id] or {}
					triggers[#triggers + 1] = {
						stat = stat,
						func = stat_trigger.trigger,
						delay = stat_trigger.delay,
						user = to_user
					}
					from_triggers[from_stat_id] = triggers
				end
			end
		end
	end

	for stat_name, stat in pairs(definitions) do
		local flags = stat.flags
		local is_team = not not flags.team
		local should_sync = not flags.no_sync and not flags.hook
		local dirty = user.rpc_dirty
		local queue = user.rpc_queue
		local default = stat.default

		if is_team and should_sync and team.data[stat_name] and team.data[stat_name] ~= default and dirty and not dirty[stat_name] then
			dirty[stat_name] = true

			queue:push_back(stat_name)
		end
	end

	user.triggers = user_triggers
	user.state = UserStates.tracking
	user.config = parsed_user_config
	user.trigger_queue = PriorityQueue:new()
end

function StatsManager:hot_join_sync(sender, channel)
	local player = Managers.player:player(sender, 1)

	if self:has_session() then
		local stat_id = player.stat_id

		if not self:is_tracking_user(stat_id) then
			local joined_at = 0

			if Managers.state and Managers.state.main_path then
				joined_at = Managers.state.main_path:furthest_travel_percentage(1)
			end

			local player_stats_config = {
				archetype_name = player:archetype_name(),
				character_id = player:character_id(),
				joined_at = joined_at
			}

			self:start_tracking_user(player.stat_id, player_stats_config)
		end
	end
end

function StatsManager:_parse_backend_value(x)
	local rpc_calls = self._rpc_calls
	local last_call_data = rpc_calls[#rpc_calls]
	local min = last_call_data.min
	local max = last_call_data.max

	return math.round(math.clamp(x, min, max))
end

function StatsManager:stop_tracking_user(key)
	local user = self._users[key]

	if user.state == UserStates.pushing then
		return user.save_done_promise
	end

	local team = self._team

	for stat_name, triggers in pairs(team.triggers) do
		local trigger_count = triggers and #triggers or 0

		for i = trigger_count, 1, -1 do
			local trigger = triggers[i]

			if trigger.user == user then
				triggers[i] = triggers[trigger_count]
				triggers[trigger_count] = nil
				trigger_count = trigger_count - 1
			end
		end

		if trigger_count == 0 then
			triggers[stat_name] = nil
		end
	end

	user.triggers = nil

	user.trigger_queue:delete()

	user.trigger_queue = nil
	local account_id = user.account_id

	if not self:_valid_account_id(account_id) then
		user.state = UserStates.idle

		return Promise.resolved(nil)
	end

	local session_stash = self._session_stash

	if session_stash and account_id then
		session_stash[account_id] = {
			data = user.data,
			config = user.config
		}
	end

	local changes = {}
	local change_count = 0
	local current_data = user.data
	local last_saved_data = user.saved_data

	for _, stat in pairs(self._definitions) do
		local id = stat.id
		local saved_value = last_saved_data[id] or stat.default
		local save_to_backend = stat.flags.backend
		local current_value = save_to_backend and self:_parse_backend_value(current_data[id] or stat.default)

		if save_to_backend and saved_value ~= current_value then
			change_count = change_count + 1
			changes[change_count] = {
				isPlatformStat = false,
				stat = id,
				value = current_value
			}
		end
	end

	if change_count == 0 then
		user.state = UserStates.idle

		return Promise.resolved(nil)
	end

	local backend_promise = Managers.backend.interfaces.commendations:bulk_update_commendations({
		{
			accountId = account_id,
			stats = changes,
			completed = {}
		}
	})
	user.state = UserStates.pushing
	user.promise = backend_promise
	user.save_done_promise = backend_promise:next(function ()
		user.state = UserStates.idle
		user.promise = nil
		user.save_done_promise = nil

		for i = 1, change_count do
			local change = changes[i]
			user.saved_data[change.stat] = change.value
		end
	end)

	return user.save_done_promise
end

function StatsManager:set_user_stat(stat_name, value)
	local user = self._users[1]
	user.data[stat_name] = value
end

function StatsManager:read_team_stat(stat_name, ...)
	local stat = self._definitions[stat_name]

	return table.nested_get(self._team.data, stat_name, ...) or stat.default
end

function StatsManager:read_user_stat(key, stat_name, ...)
	local stat = self._definitions[stat_name]
	local user = self._users[key]

	return table.nested_get(user.data, stat_name, ...) or stat.default
end

function StatsManager:_attach_listener(key, listener_id)
	local user = key == "TEAM" and self._team or self._users[key]
	local listener = self._listeners[listener_id]
	local definitions = self._definitions
	local stat_names = listener.stat_names
	local user_listeners = user.listeners

	for i = 1, #stat_names do
		local stat_name = stat_names[i]
		local stat_listeners = user_listeners[stat_name] or {}
		stat_listeners[#stat_listeners + 1] = listener_id
		user_listeners[stat_name] = stat_listeners
	end
end

function StatsManager:_detach_listener(key, listener_id)
	local user = key == "TEAM" and self._team or self._users[key]
	local listener = self._listeners[listener_id]
	local stat_names = listener.stat_names
	local user_listeners = user.listeners

	for i = 1, #stat_names do
		local stat_name = stat_names[i]
		local stat_listeners = user_listeners[stat_name]
		local listener_count = stat_listeners and #stat_listeners or 0

		for j = listener_count, 1, -1 do
			if stat_listeners[j] == listener_id then
				stat_listeners[i] = stat_listeners[listener_count]
				stat_listeners[listener_count] = nil
				listener_count = listener_count - 1
			end
		end

		if listener_count == 0 then
			user_listeners[stat_name] = nil
		end
	end
end

function StatsManager:add_listener(key, stat_names, callback_fn)
	local listener_id = self._next_listener_id
	self._next_listener_id = self._next_listener_id + 1
	self._listeners[listener_id] = {
		key = key,
		stat_names = stat_names,
		callback_fn = callback_fn
	}
	local user = key == "TEAM" and self._team or self._users[key]

	if user then
		self:_attach_listener(key, listener_id)
	end

	return listener_id
end

function StatsManager:remove_listener(listener_id)
	local listener = self._listeners[listener_id]
	local user = self._users[listener.key]

	if user then
		self:_detach_listener(listener.key, listener_id)
	end

	self._listeners[listener_id] = nil
end

function StatsManager:_trigger(user, stat_name, ...)
	if not stat_name then
		return
	end

	local stat = self._definitions[stat_name]
	local flags = stat.flags
	local dirty = user.rpc_dirty
	local queue = user.rpc_queue

	if not flags.hook and not flags.no_sync and dirty and not dirty[stat_name] then
		dirty[stat_name] = true

		queue:push_back(stat_name)
	end

	local listeners = self._listeners
	local listener_ids = user.listeners[stat_name]
	local listenter_count = listener_ids and #listener_ids or 0

	for i = 1, listenter_count do
		local listener_id = listener_ids[i]
		local listener = listeners[listener_id]
		local callback_fn = listener.callback_fn

		callback_fn(listener_id, stat_name, ...)
	end

	local last_t = self._last_t
	local triggers = user.triggers[stat_name]
	local trigger_count = triggers and #triggers or 0

	for i = 1, trigger_count do
		local trigger = triggers[i]
		local trigger_stat = trigger.stat
		local trigger_delay = trigger.delay
		local trigger_func = trigger.func
		local next_user = trigger.user

		if trigger_delay then
			next_user.trigger_queue:push(last_t + trigger_delay, {
				trigger_func,
				trigger_stat,
				...
			})
		else
			self._next_user = next_user

			self:_trigger(next_user, trigger_func(trigger_stat, next_user.data, ...))
		end
	end
end

function StatsManager:rpc_stat_update(_, local_player_id, stat_index, stat_value)
	local user = self._users[local_player_id]
	local stat_name = self._stat_lookup[stat_index]
	local stat = self._definitions[stat_name]

	if user and stat then
		local flags = stat.flags
		user.data[stat_name] = stat_value

		if flags.team then
			return
		end

		local listeners = self._listeners
		local listener_ids = user.listeners[stat_name]
		local listenter_count = listener_ids and #listener_ids or 0

		for i = 1, listenter_count do
			local listener_id = listener_ids[i]
			local listener = listeners[listener_id]
			local callback_fn = listener.callback_fn

			callback_fn(listener_id, stat_name, stat_value)
		end
	end
end

for key in pairs(StatNetworkTypes) do
	StatsManager["rpc_stat_update_" .. key] = StatsManager.rpc_stat_update
end

function StatsManager:record_private(stat_name, player, ...)
	local stat = self._definitions[stat_name]
	local key = player.remote and player.stat_id or player:local_player_id()
	local user = self._users[key]

	if user and user.state == UserStates.tracking then
		self:_trigger(user, stat_name, ...)
	end
end

function StatsManager:record_team(stat_name, ...)
	local stat = self._definitions[stat_name]
	local team = self._team

	if self:has_session() then
		self:_trigger(team, stat_name, ...)
	end
end

function StatsManager:get_next_user()
	return self._next_user
end

function StatsManager:get_stats_config()
	return self._session_config
end

return StatsManager
