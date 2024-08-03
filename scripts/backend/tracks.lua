local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Tracks = class("Tracks")

function Tracks:get_all_tracks_state(optional_account_id)
	return Managers.backend:authenticate():next(function (account)
		local account_id = optional_account_id or account.sub
		local builder = BackendUtilities.url_builder():path("/data/"):path(account_id):path("/trackstate/")

		return Managers.backend:title_request(builder:to_string()):next(function (response)
			return response.body
		end)
	end)
end

function Tracks:get_track_state(optional_track_id, optional_account_id)
	return Managers.backend:authenticate():next(function (account)
		local account_id = optional_account_id or account.sub
		local builder = BackendUtilities.url_builder():path("/data/"):path(account_id):path("/trackstate")

		if optional_track_id then
			builder:path("/"):path(optional_track_id)
		end

		return Managers.backend:title_request(builder:to_string()):next(function (response)
			if optional_track_id then
				return response.body.track
			else
				local tracks_by_id = {}
				local tracks = response.body.tracks or {}

				for i = 1, #tracks do
					local track = tracks[i]
					tracks_by_id[track.id] = track
				end

				return tracks_by_id
			end
		end)
	end)
end

function Tracks:get_track(track_id)
	local builder = BackendUtilities.url_builder():path("/tracks/"):path(track_id)

	return Managers.backend:title_request(builder:to_string()):next(function (data)
		return data.body
	end)
end

function Tracks:claim_track_tier(track_id, tier, optional_account_id)
	return Managers.backend:authenticate():next(function (account)
		local account_id = optional_account_id or account.sub
		local builder = BackendUtilities.url_builder():path("/data/"):path(account_id):path("/tracks/"):path(track_id):path("/tiers/"):path(tier)
		local options = {
			method = "POST"
		}

		return Managers.backend:title_request(builder:to_string(), options)
	end)
end

function Tracks:claim_trait_tier_reward(track_id, tier, reward_id)
	return Managers.backend:authenticate():next(function (account)
		local account_id = account.sub
		local builder = BackendUtilities.url_builder():path("/data/"):path(account_id):path("/tracks/"):path(track_id):path("/tiers/"):path(tier):path("/rewards/"):path(reward_id)
		local options = {
			method = "POST"
		}

		return Managers.backend:title_request(builder:to_string(), options)
	end)
end

function Tracks:modify_track_account_state(account_id, track_id, track_xp)
	local builder = BackendUtilities.url_builder():path("/data/"):path(account_id):path("/tracks/"):path(track_id)
	local options = {
		method = "PATCH",
		body = {
			xp = track_xp
		}
	}

	return Managers.backend:title_request(builder:to_string(), options)
end

function Tracks:get_event_tracks()
	local builder = BackendUtilities.url_builder():path("/tracks"):path("/category"):path("/event")

	return Managers.backend:title_request(builder:to_string()):next(function (data)
		return data.body.tracks
	end)
end

return Tracks
