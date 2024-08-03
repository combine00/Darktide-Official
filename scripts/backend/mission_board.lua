local Promise = require("scripts/foundation/utilities/promise")
local BackendError = require("scripts/foundation/managers/backend/backend_error")
local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local Interface = {
	"fetch",
	"create_mission"
}
local MissionBoard = class("MissionBoard")
local missionboard_path = "/mission-board"

function MissionBoard:init()
	return
end

function MissionBoard:fetch_mission(mission_id)
	return Managers.backend:title_request(missionboard_path .. "/" .. mission_id):next(function (data)
		return data.body
	end)
end

function MissionBoard:fetch(on_expiry, pause_time)
	return Managers.backend:title_request(missionboard_path):next(function (data)
		data.body.expire_in = BackendUtilities.on_expiry_do(data.headers, on_expiry, pause_time)
		data.body.server_time = data.headers["server-time"]
		data.body.data_age = (data.headers.age or 0) * 1000

		return data.body
	end)
end

function MissionBoard:create_mission(mission_data)
	if not next(mission_data.flags) then
		mission_data.flags = {
			none = {
				none = "test"
			}
		}
	end

	return Managers.backend:title_request(missionboard_path .. "/create", {
		method = "POST",
		body = {
			mission = mission_data
		}
	}):next(function (data)
		return data.body
	end)
end

function MissionBoard:get_rewards(on_expiry, pause_time)
	return Managers.backend:title_request(missionboard_path .. "/rewards", {
		method = "GET"
	}):next(function (data)
		return data.body
	end)
end

implements(MissionBoard, Interface)

return MissionBoard
