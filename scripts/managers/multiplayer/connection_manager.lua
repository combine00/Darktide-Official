local ConnectionManagerTestify = GameParameters.testify and require("scripts/managers/multiplayer/connection_manager_testify")
local VotingNetworkInterface = require("scripts/managers/voting/voting_network_interface")
local ConnectionManager = class("ConnectionManager")

local function _info(...)
	Log.info("ConnectionManager", ...)
end

local IS_ERROR = true
local IS_NOT_ERROR = false
local IS_HOST = true
local IS_NOT_HOST = false
local EVENT_NAMES = {
	"client_connected",
	"client_disconnected",
	"connected_to_host",
	"disconnected_from_host"
}
local default_game_udp_key, default_game_udp_cert = nil

local function _source_reason(game_reason, engine_reason)
	if game_reason then
		return "game", game_reason
	elseif engine_reason then
		return "engine", engine_reason
	else
		return "N/A", "N/A"
	end
end

function ConnectionManager:init(options, event_delegate, approve_channel_delegate)
	self.config_file_name = "application_settings/global"
	self.oodle_net_file_name = "application_settings/oodle_trained_network_data"
	self.platform = options.network_platform
	self.lan_port = nil
	self.wan_port = nil
	self._client = nil
	self._is_dedicated_hub_server = options.is_dedicated_hub_server
	self._is_dedicated_mission_server = options.is_dedicated_mission_server

	if options.network_platform == "lan" then
		self.lan_port = options.lan_port
		self._client = Network.init_lan_client(self.config_file_name, self.lan_port)
		self._client_destructor = Network.shutdown_lan_client
	elseif options.network_platform == "wan_server" then
		local game_udp_key = os.getenv("GAME_UDP_KEY")

		if game_udp_key then
			game_udp_key = string.decode_base64(game_udp_key)
		else
			game_udp_key = default_game_udp_key
		end

		local game_udp_cert = os.getenv("GAME_UDP_CERT")

		if game_udp_cert then
			game_udp_cert = string.decode_base64(game_udp_cert)
		else
			game_udp_cert = default_game_udp_cert
		end

		self.wan_port = options.wan_port
		self._client = Network.init_wan_server(self.config_file_name, self.wan_port, self.oodle_net_file_name, game_udp_cert, game_udp_key)
		self._client_destructor = Network.shutdown_lan_client
	elseif options.network_platform == "wan_client" then
		-- Nothing
	elseif options.network_platform == "steam" then
		self._client = Network.init_steam_client(self.config_file_name)
		self._client_destructor = Network.shutdown_steam_client
	elseif options.network_platform == "steam_server" then
		self.server_port = options.server_port
		self.steam_port = options.steam_port
		self.query_port = options.query_port
	else
		ferror("Network platform %q not implemented.", tostring(options.network_platform))
	end

	self._connection_host = nil
	self._connection_host_event_object = nil
	self._connection_client = nil
	self._connection_client_event_object = nil
	local trunk_revision = APPLICATION_SETTINGS.content_revision or LOCAL_CONTENT_REVISION
	trunk_revision = tostring(trunk_revision)

	if trunk_revision == "Unknown" then
		Log.warning("ConnectionManager", "Content revision unknown, ensure SVN hook scripts are enabled, SVN with command line tools is installed & run a SVN update. Reach out to a friendly programmer if you need help.")
	end

	local project_hash = options.project_hash
	local argument_hash = options.argument_hash
	local stripping_hash = ""
	self.network_hash = Network.config_hash(self.config_file_name)
	self.combined_hash = Application.make_hash(self.network_hash, trunk_revision, project_hash, argument_hash, stripping_hash)

	Log.info("ConnectionManager", "Combined hash: %s", tostring(self.combined_hash))
	Log.info("ConnectionManager", "network hash: %s, svn revision: %s, project hash: %s, argument hash: %s, stripping hash: %s", tostring(self.network_hash), tostring(trunk_revision), tostring(project_hash), tostring(argument_hash), tostring(stripping_hash))

	self._event_delegate = event_delegate
	self._approve_channel_delegate = approve_channel_delegate

	event_delegate:register_connection_events(approve_channel_delegate, "approve_channel")

	self._peer_to_channel = {}
	self._channel_to_peer = {}
	self._members = {}
	local event_listeners = {}

	for i = 1, #EVENT_NAMES do
		event_listeners[EVENT_NAMES[i]] = {}
	end

	self._event_listeners = event_listeners
end

local WAN_RANDOM_PEER_ID = 9

function ConnectionManager:default_game_udp_cert()
	return default_game_udp_cert
end

function ConnectionManager:initialize_wan_client(peer_id)
	peer_id = peer_id or WAN_RANDOM_PEER_ID
	local client = Network.init_wan_client(self.config_file_name, peer_id, self.oodle_net_file_name)

	if client then
		self._client = client

		Log.info("ConnectionManager", "Initialized wan_client with peer_id %s", Network.peer_id())

		self._client_destructor = Network.shutdown_lan_client

		return true
	else
		Log.error("ConnectionManager", "Failed initializing wan_client")

		return false
	end
end

function ConnectionManager:destroy_wan_client()
	Log.info("ConnectionManager", "Destroying wan_client with peer_id %s", Network.peer_id())
	self:shutdown_connections("wan_client_destroyed")
	self._client_destructor(self._client)

	self._client = nil
end

function ConnectionManager:is_initialized()
	return self._client ~= nil
end

function ConnectionManager:client()
	return self._client
end

function ConnectionManager:destroy()
	self:shutdown_connections("connection_manager_destroyed")

	if self._client then
		self._client_destructor(self._client)

		self._client = nil
	end

	local event_delegate = self._event_delegate

	event_delegate:unregister_events("approve_channel")

	self._approve_channel_delegate = nil
	self._event_listeners = nil
end

function ConnectionManager:peer_to_channel(peer_id)
	return self._peer_to_channel[peer_id]
end

function ConnectionManager:channel_to_peer(channel_id)
	return self._channel_to_peer[channel_id]
end

function ConnectionManager:allocation_state()
	return self._connection_host:allocation_state()
end

function ConnectionManager:num_members()
	return table.size(self._members)
end

function ConnectionManager:member_peers()
	return table.keys(self._members)
end

function ConnectionManager:max_members()
	if self:is_host() then
		return self._connection_host:max_members()
	elseif self:is_client() then
		return self._connection_client:max_members()
	end
end

function ConnectionManager:tick_rate()
	if self:is_host() then
		return self._connection_host:tick_rate()
	elseif self:is_client() then
		return self._connection_client:tick_rate()
	end

	ferror("Asked for tick_rate before we have network context.")
end

function ConnectionManager:update(dt)
	if self._connection_client then
		self:_update_client(dt)
	end

	if self._connection_host then
		self:_update_host(dt)
	end

	if GameParameters.testify then
		Testify:poll_requests_through_handler(ConnectionManagerTestify, self)
	end
end

function ConnectionManager:is_client()
	return self._connection_client ~= nil
end

function ConnectionManager:is_host()
	return self._connection_host ~= nil
end

function ConnectionManager:host_type()
	if self:is_host() then
		return self._connection_host:host_type()
	elseif self:is_client() then
		return self._connection_client:host_type()
	end
end

function ConnectionManager:host_is_dedicated_server()
	if self:is_host() then
		return self._connection_host:host_is_dedicated_server()
	elseif self:is_client() then
		return self._connection_client:host_is_dedicated_server()
	end
end

function ConnectionManager:is_dedicated_hub_server()
	return self._is_dedicated_hub_server
end

function ConnectionManager:is_dedicated_mission_server()
	return self._is_dedicated_mission_server
end

function ConnectionManager:server_name()
	if self:is_host() then
		return self._connection_host:server_name()
	elseif self:is_client() then
		return self._connection_client:server_name()
	end
end

function ConnectionManager:unique_instance_id()
	if self:is_client() then
		return self._connection_client:unique_instance_id()
	end
end

function ConnectionManager:region()
	if self:is_client() then
		return self._connection_client:region()
	end
end

function ConnectionManager:deployment_id()
	if self:is_client() then
		return self._connection_client:deployment_id()
	end
end

function ConnectionManager:accelerated_endpoint()
	if self:is_client() then
		return self._connection_client:accelerated_endpoint()
	end
end

function ConnectionManager:matched_game_session_id()
	if self:is_client() then
		return self._connection_client:matched_game_session_id()
	end
end

function ConnectionManager:initial_party_id()
	if self:is_client() then
		return self._connection_client:initial_party_id()
	end
end

function ConnectionManager:engine_lobby()
	if self:is_host() then
		return self._connection_host:engine_lobby()
	elseif self:is_client() then
		return self._connection_client:engine_lobby()
	end
end

function ConnectionManager:engine_lobby_id()
	if self:is_host() then
		return self._connection_host:engine_lobby_id()
	elseif self:is_client() then
		return self._connection_client:engine_lobby_id()
	end
end

function ConnectionManager:session_id()
	if self:is_host() then
		return self._connection_host:session_id()
	elseif self:is_client() then
		return self._connection_client:session_id()
	end
end

function ConnectionManager:session_seed()
	if self:is_host() then
		return self._connection_host:session_seed()
	elseif self:is_client() then
		return self._connection_client:session_seed()
	end
end

function ConnectionManager:set_lobby_data_key(key, value)
	local engine_lobby = self:engine_lobby()

	engine_lobby:set_data(key, value)
end

function ConnectionManager:connecting_peers()
	if self:is_host() then
		return self._connection_host:connecting_peers()
	end
end

function ConnectionManager:has_connecting_peers()
	if self:is_host() then
		return self._connection_host:has_connecting_peers()
	else
		return false
	end
end

function ConnectionManager:host()
	if self:is_host() then
		return self._connection_host:host()
	elseif self:is_client() then
		return self._connection_client:host()
	end
end

function ConnectionManager:host_channel()
	if self:is_client() then
		return self._connection_client:host_channel()
	end
end

function ConnectionManager:set_connection_host(connection_host, event_object)
	self:shutdown_connections("new_connection_host")

	self._connection_host = connection_host
	self._connection_host_event_object = event_object

	self:_initialize_network()

	local host_type = connection_host:host_type()
	local lobby_id = connection_host:engine_lobby_id()

	event_object:became_host(host_type, lobby_id)
	connection_host:register_profile_synchronizer()
end

function ConnectionManager:set_connection_client(connection_client, event_object)
	self:shutdown_connections("new_connection_client")

	self._connection_client = connection_client
	self._connection_client_event_object = event_object

	self:_initialize_network()
end

function ConnectionManager:disconnect(peer_id)
	local engine_lobby = nil

	if self._connection_host then
		engine_lobby = self._connection_host:engine_lobby()
	elseif self._connection_client then
		engine_lobby = self._connection_client:engine_lobby()
	else
		return
	end

	local channel = self:peer_to_channel(peer_id)

	if channel then
		engine_lobby:close_channel(channel)
	end
end

function ConnectionManager:kick(peer_id, reason, option_details)
	local connection_host = self._connection_host
	local channel = self:peer_to_channel(peer_id)

	if channel then
		connection_host:kick(channel, reason, option_details)
		Managers.telemetry_events:player_kicked(peer_id, reason, option_details)
	end
end

function ConnectionManager:kick_all(reason, option_details)
	local connection_host = self._connection_host
	local connecting_peers = self:connecting_peers()

	for i = 1, #connecting_peers do
		local peer_id = connecting_peers[i]

		self:kick(peer_id, reason, option_details)
	end

	for peer_id, _ in pairs(self._members) do
		self:kick(peer_id, reason, option_details)
	end
end

function ConnectionManager:_shutdown_connection_host(is_error, game_reason, engine_reason)
	for peer_id, _ in pairs(self._members) do
		self:_remove_client(self:peer_to_channel(peer_id), peer_id, game_reason, engine_reason)
	end

	local source, reason = _source_reason(game_reason, engine_reason)

	self._connection_host_event_object:stopped_being_host(is_error, source, reason)
	self._connection_host:unregister_profile_synchronizer()
	self._connection_host:delete()

	self._connection_host = nil
	self._connection_host_event_object = nil

	table.clear(self._peer_to_channel)
	table.clear(self._channel_to_peer)
end

function ConnectionManager:_shutdown_connection_client(is_error, game_reason, engine_reason)
	local game_session_manager = Managers.state.game_session

	if game_session_manager and game_session_manager:is_client() then
		game_session_manager:leave()
	end

	local host_peer_id = self._connection_client:host()
	local host_channel_id = self:peer_to_channel(host_peer_id)

	self:_peer_disconnected(host_channel_id, host_peer_id, IS_HOST, is_error, game_reason, engine_reason)

	for peer_id, _ in pairs(self._members) do
		local channel_id = self:peer_to_channel(peer_id)

		if channel_id then
			self:_peer_disconnected(channel_id, peer_id, IS_NOT_HOST, IS_NOT_ERROR, game_reason, engine_reason)
		else
			self:_member_left(peer_id)
		end
	end

	self._connection_client:delete()

	self._connection_client = nil
	self._connection_client_event_object = nil

	table.clear(self._peer_to_channel)
	table.clear(self._channel_to_peer)
end

function ConnectionManager:shutdown_connections(reason)
	if GameParameters.testify then
		ConnectionManagerTestify.unregister_testify_connection_events(self)
	end

	local game_reason = reason
	local engine_reason = nil

	if self._connection_host then
		self:_shutdown_connection_host(IS_NOT_ERROR, game_reason, engine_reason)
	elseif self._connection_client then
		self:_shutdown_connection_client(IS_NOT_ERROR, game_reason, engine_reason)
	end

	local is_empty = table.is_empty
end

function ConnectionManager:network_event_delegate()
	return self._event_delegate
end

function ConnectionManager:approve_channel_delegate()
	return self._approve_channel_delegate
end

function ConnectionManager:send_rpc_clients(rpc_name, ...)
	local rpc = RPC[rpc_name]

	for peer, _ in pairs(self._members) do
		local channel = self:peer_to_channel(peer)

		rpc(channel, ...)
	end
end

function ConnectionManager:send_rpc_clients_except(rpc_name, except_channel_id, ...)
	local rpc = RPC[rpc_name]
	local except_peer = self:channel_to_peer(except_channel_id)

	for peer, _ in pairs(self._members) do
		if peer ~= except_peer then
			local channel = self:peer_to_channel(peer)

			rpc(channel, ...)
		end
	end
end

function ConnectionManager:send_rpc_client(rpc_name, peer, ...)
	local members = self._members
	local rpc = RPC[rpc_name]
	local channel = self:peer_to_channel(peer)

	rpc(channel, ...)
end

function ConnectionManager:send_rpc_server(rpc_name, ...)
	local host_channel = self:host_channel()

	RPC[rpc_name](host_channel, ...)
end

function ConnectionManager:_update_client(dt)
	self._connection_client:update(dt)

	while true do
		local event, parameters = self._connection_client:next_event()

		if event == nil then
			break
		end

		local peer_id = parameters.peer_id
		local channel_id = parameters.channel_id

		if event == "connecting" then
			self._channel_to_peer[channel_id] = peer_id
			self._peer_to_channel[peer_id] = channel_id

			_info("Peer %s is connecting", peer_id)
		elseif event == "connected" then
			self:_peer_connected(channel_id, peer_id)
		elseif event == "disconnected" then
			local is_error = not parameters.engine_reason or parameters.engine_reason ~= "closed_connection"
			local host_peer_id = self._connection_client:host()

			if peer_id == host_peer_id then
				self:_shutdown_connection_client(is_error, parameters.game_reason, parameters.engine_reason)

				break
			else
				self:_peer_disconnected(channel_id, peer_id, IS_NOT_HOST, is_error, parameters.game_reason, parameters.engine_reason)
			end
		elseif event == "player_connected" then
			local player_sync_data = parameters.player_sync_data

			self:_member_joined(peer_id, player_sync_data)
		elseif event == "player_disconnected" then
			self:_member_left(peer_id)
		end
	end
end

function ConnectionManager:_update_host(dt)
	self._connection_host:update(dt)

	while true do
		local event, parameters = self._connection_host:next_event()

		if event == nil then
			break
		end

		local peer_id = parameters.peer_id
		local channel_id = parameters.channel_id

		if event == "connecting" then
			self._channel_to_peer[channel_id] = peer_id
			self._peer_to_channel[peer_id] = channel_id

			self:_detected_client(channel_id, peer_id)
		elseif event == "connected" then
			local player_sync_data = parameters.player_sync_data

			self:_add_client(channel_id, peer_id, player_sync_data)
		elseif event == "disconnected" then
			self:_remove_client(channel_id, peer_id, parameters.game_reason, parameters.engine_reason)
		end
	end
end

function ConnectionManager:_peer_connected(channel_id, peer_id)
	_info("Peer %s is connected", peer_id)

	local connection_client = self._connection_client
	local is_host = peer_id == connection_client:host()
	self._members[peer_id] = true

	if is_host then
		local host_type = connection_client:host_type()

		self:_joined_host(channel_id, peer_id, host_type)
		self:_call_event_listeners("connected_to_host", self, peer_id, channel_id)
	end

	Log.info("ConnectionManager", "_peer_connected %s", peer_id)
end

function ConnectionManager:_peer_disconnected(channel_id, peer_id, disconnected_peer_is_host, is_error, game_reason, engine_reason)
	local source, reason = _source_reason(game_reason, engine_reason)

	_info("Channel %s to peer %s was disconnected with %s reason %s", tostring(channel_id), peer_id, source, reason)

	local was_connected = self._members[peer_id] ~= nil

	if channel_id then
		self._channel_to_peer[channel_id] = nil
	end

	self._peer_to_channel[peer_id] = nil
	self._members[peer_id] = nil

	if disconnected_peer_is_host then
		_info("Left host %s", peer_id)
		self._connection_client_event_object:disconnected_from_host(is_error, source, reason)
		self._connection_client:unregister_profile_synchronizer()

		if was_connected then
			self:_call_event_listeners("disconnected_from_host", self, peer_id, channel_id)
		end
	end

	Log.info("ConnectionManager", "_peer_disconnected %s", peer_id)
end

function ConnectionManager:_joined_host(channel_id, peer_id, host_type)
	_info("Joined host channel(%d), peer(%s), host_type(%s)", channel_id, peer_id, host_type)
	self._connection_client_event_object:joined_host(channel_id, peer_id, host_type)
	self._connection_client:register_profile_synchronizer()
end

function ConnectionManager:_member_joined(peer_id, player_sync_data)
	_info("Remote peer %s connected to host", peer_id)

	self._members[peer_id] = true

	self._connection_client_event_object:other_client_joined(peer_id, player_sync_data)
end

function ConnectionManager:_member_left(peer_id)
	_info("Remote peer %s disconnected from host", peer_id)

	self._members[peer_id] = nil

	self._connection_client_event_object:other_client_left(peer_id)
end

function ConnectionManager:_detected_client(channel_id, peer_id)
	_info("Peer %s is connecting", peer_id)
end

function ConnectionManager:_add_client(channel_id, peer_id, player_sync_data)
	_info("Peer %s is connected", peer_id)

	self._members[peer_id] = true

	if DEDICATED_SERVER then
		local players, slots = self._connection_host:allocation_state()
		local engine_lobby = self._connection_host:engine_lobby()

		if engine_lobby.name then
			local client_user_name = engine_lobby:name(peer_id)

			CommandWindow.print(string.format("Player %s [Peer %s] joined (%d/%d)", client_user_name, peer_id, players, slots))
			_info("Player %s is connected", client_user_name)
		else
			CommandWindow.print(string.format("Peer %s joined (%d/%d)", peer_id, players, slots))
		end
	end

	self._connection_host_event_object:client_joined(channel_id, peer_id, player_sync_data)
	self:_call_event_listeners("client_connected", self, peer_id, channel_id)

	if GameParameters.testify then
		Testify:add_peer(peer_id, channel_id)
	end
end

function ConnectionManager:_remove_client(channel_id, peer_id, game_reason, engine_reason)
	local source, reason = _source_reason(game_reason, engine_reason)

	_info("Peer %s was disconnected with %s reason %s", peer_id, source, reason)

	local has_connected = self._members[peer_id] ~= nil

	if channel_id == self._peer_to_channel[peer_id] then
		self._channel_to_peer[channel_id] = nil
		self._peer_to_channel[peer_id] = nil
		self._members[peer_id] = nil
	end

	if has_connected then
		local game_session_manager = Managers.state.game_session

		if game_session_manager and game_session_manager:is_host() then
			game_session_manager:remove_peer(peer_id)
		end

		self._connection_host_event_object:client_disconnected(channel_id, peer_id, game_reason, engine_reason, table.is_empty(self._members))
		self:_call_event_listeners("client_disconnected", self, peer_id, channel_id)
	end

	if DEDICATED_SERVER then
		local players, slots = self._connection_host:allocation_state()

		CommandWindow.print(string.format("Peer %s left (%d/%d)", peer_id, players, slots))
	end

	self._connection_host:remove(channel_id)

	if GameParameters.testify then
		Testify:remove_peer(peer_id, channel_id)
	end
end

function ConnectionManager:_initialize_network()
	Log.info("ConnectionManager", "My peer id is %s.", Network.peer_id())

	local pong_timeout = GameParameters.pong_timeout

	Log.info("ConnectionManager", "Setting ping timeout to %f", pong_timeout)
	Network.set_pong_timeout(pong_timeout)
	require("scripts/network_lookup/network_constants")

	if GameParameters.testify then
		ConnectionManagerTestify.register_testify_connection_events(self)
	end
end

function ConnectionManager:register_event_listener(object, event_name, func)
	local listeners = self._event_listeners[event_name]
	listeners[object] = func
end

function ConnectionManager:unregister_event_listener(object, event_name)
	local listeners = self._event_listeners[event_name]
	listeners[object] = nil
end

function ConnectionManager:_call_event_listeners(event_name, ...)
	local listeners = self._event_listeners[event_name]

	if listeners then
		for object, func in pairs(listeners) do
			object[func](object, ...)
		end
	end
end

implements(ConnectionManager, VotingNetworkInterface)

return ConnectionManager
