local VotingManagerImmateriumPartyTestify = {}

function VotingManagerImmateriumPartyTestify.accept_vote(voting_manager_immaterium_party)
	local current_vote = voting_manager_immaterium_party:current_vote()
	local voting_id = current_vote.id

	Managers.voting:cast_vote(voting_id, "yes")
end

function VotingManagerImmateriumPartyTestify.wait_for_ongoing_vote(voting_manager_immaterium_party)
	if not voting_manager_immaterium_party:current_vote().state == "ONGOING" then
		return Testify.RETRY
	end
end

return VotingManagerImmateriumPartyTestify
