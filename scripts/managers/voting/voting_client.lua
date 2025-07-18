local VotingClient = class("VotingClient")

local function _info(...)
	Log.info("VotingClient", ...)
end

local STATES = table.enum("waiting_for_host_accept", "in_progress", "completed", "aborted")

function VotingClient:init(voting_id, initiator_peer, template, optional_params, member_list, initial_votes_list, time_left)
	self._voting_id = voting_id
	self._initiator_peer = initiator_peer
	self._template = template
	local params = optional_params or {}
	self._params = params
	local network_interface = template.network_interface()
	self._network_interface = network_interface
	self._time_left = time_left
	self._agreement_duration = template.agreement_duration
	self._agreement_time = nil
	self._member_list = {}
	self._votes = {}
	self._result = nil
	self._abort_reason = nil

	if initiator_peer == Network.peer_id() then
		self._state = STATES.waiting_for_host_accept
		local rpc_name = template.rpc_request_voting
		local template_id = NetworkLookup.voting_templates[template.name]

		self:_send_rpc_host(rpc_name, voting_id, template_id, template.pack_params(params))
		_info("Requested voting %q (%s), params: %s", voting_id, template.name, table.tostring(params))
	else
		self._state = STATES.in_progress

		for i = 1, #member_list do
			local peer_id = member_list[i]
			self._member_list[i] = peer_id
			self._votes[peer_id] = initial_votes_list[i]
		end
	end
end

function VotingClient:destroy()
	self._template = nil
	self._params = nil
	self._member_list = nil
	self._votes = nil
end

function VotingClient:on_voting_accepted(member_list, initial_votes_list, time_left)
	self._state = STATES.in_progress

	for i = 1, #member_list do
		local peer_id = member_list[i]
		self._member_list[i] = peer_id
		self._votes[peer_id] = initial_votes_list[i]
	end

	self._time_left = time_left

	_info("Voting %q accepted by host", self._voting_id)
end

function VotingClient:on_voting_aborted(reason)
	self._state = STATES.aborted
	self._abort_reason = reason

	_info("Voting %q aborted, reason: %s", self._voting_id, reason)
end

function VotingClient:on_voting_completed(result)
	self._state = STATES.completed
	self._result = result

	_info("Voting %q completed, result: %s, votes: %s", self._voting_id, result, table.tostring(self._votes))
end

function VotingClient:on_vote_denied(reason)
	_info("Vote denied by host in voting %q, reason: %s", self._voting_id, reason)
end

function VotingClient:on_member_joined(peer_id)
	local member_list = self._member_list
	member_list[#member_list + 1] = peer_id
	self._votes[peer_id] = StrictNil

	_info("Voting member %s joined voting %q", peer_id, self._voting_id)
end

function VotingClient:on_member_left(peer_id)
	local member_list = self._member_list
	local index = table.index_of(member_list, peer_id)

	table.remove(member_list, index)

	self._votes[peer_id] = nil

	_info("Voting member %s left voting %q", peer_id, self._voting_id)
end

function VotingClient:is_host()
	return false
end

function VotingClient:state()
	return self._state
end

function VotingClient:host_channel()
	return self._network_interface:host_channel()
end

function VotingClient:has_member(peer_id)
	return table.index_of(self._member_list, peer_id) ~= -1
end

function VotingClient:has_voted(peer_id)
	return self._votes[peer_id] ~= StrictNil
end

function VotingClient:has_option(option)
	return table.contains(self._template.options, option)
end

function VotingClient:network_interface()
	return self._network_interface
end

function VotingClient:template()
	return self._template
end

function VotingClient:params()
	return self._params
end

local member_list_copy = {}

function VotingClient:member_list()
	table.clear(member_list_copy)

	local member_list = self._member_list

	for i = 1, member_list do
		member_list_copy[i] = member_list[i]
	end

	return member_list_copy
end

local votes_copy = {}

function VotingClient:votes()
	table.clear(votes_copy)

	for peer_id, vote in pairs(self._votes) do
		votes_copy[peer_id] = vote
	end

	return votes_copy
end

function VotingClient:time_left()
	if self._agreement_time then
		local duration = self._agreement_duration
		local time_left = math.max(duration - self._agreement_time, 0)
		local time_left_normalized = math.max(time_left / duration, 0)

		return time_left, time_left_normalized
	end

	local duration = self._template.duration
	local time_left = self._time_left
	local time_left_normalized = time_left and math.max(time_left / duration, 0)

	return time_left, time_left_normalized
end

function VotingClient:register_vote(voter_peer_id, option)
	self._votes[voter_peer_id] = option
	local voting_id = self._voting_id
	local template = self._template

	_info("Registered vote %q casted by %s in voting %q (%s)", option, voter_peer_id, voting_id, template.name)

	self._agreement_time = nil
end

function VotingClient:request_vote(option)
	local option_id = NetworkLookup.voting_options[option]
	local voting_id = self._voting_id

	self:_send_rpc_host("rpc_request_vote", voting_id, option_id)
	_info("Requested vote %q in %s, voting_id: %q", option, self._template.name, voting_id)
end

function VotingClient:result()
	return self._result
end

function VotingClient:abort_reason()
	return self._abort_reason
end

function VotingClient:_is_current_votes_in_argeement()
	local votes = self._votes
	local num_total_votes = table.size(votes)

	if num_total_votes > 0 then
		local last_vote_option = nil

		for _, option in pairs(votes) do
			if option == StrictNil then
				return false
			end

			if last_vote_option and last_vote_option ~= option then
				return false
			end

			last_vote_option = option
		end

		return true
	end

	return false
end

function VotingClient:update(dt, t)
	if self._state ~= STATES.in_progress then
		return
	end

	local time_left = self._time_left

	if time_left then
		time_left = math.max(time_left - dt, 0)
		self._time_left = time_left
	end

	if self._agreement_duration then
		if self:_is_current_votes_in_argeement() then
			self._agreement_time = (self._agreement_time or 0) + dt
		else
			self._agreement_time = nil
		end
	end
end

function VotingClient:_send_rpc_host(rpc_name, ...)
	local host_channel = self._network_interface:host_channel()

	RPC[rpc_name](host_channel, ...)
end

return VotingClient
