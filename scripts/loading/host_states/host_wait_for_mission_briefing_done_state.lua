local HostWaitForMissionBriefingDoneState = class("HostWaitForMissionBriefingDoneState")

function HostWaitForMissionBriefingDoneState:init(state_machine, shared_state)
	self._shared_state = shared_state
end

function HostWaitForMissionBriefingDoneState:destroy()
	return
end

function HostWaitForMissionBriefingDoneState:update(dt)
	local mission_intro_view_active = Managers.ui:view_active("mission_intro_view")

	if not mission_intro_view_active then
		Log.info("HostWaitForMissionBriefingDoneState", "no mission_intro_view active")

		return "mission_briefing_done"
	end

	local mission_intro_view = Managers.ui:view_instance("mission_intro_view")

	if not mission_intro_view then
		Log.info("HostWaitForMissionBriefingDoneState", "no mission_intro_view active")

		return "mission_briefing_done"
	end

	local mission_briefing_done = mission_intro_view.mission_briefing_done

	if mission_briefing_done then
		Log.info("HostWaitForMissionBriefingDoneState", "mission_briefing_done")

		return "mission_briefing_done"
	end
end

return HostWaitForMissionBriefingDoneState
