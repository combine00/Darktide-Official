local CinematicManagerTestify = {}

function CinematicManagerTestify.deactivate_testify_camera(cinematic_manager)
	cinematic_manager:deactivate_testify_camera()
end

function CinematicManagerTestify.set_active_testify_camera(cinematic_manager, camera)
	cinematic_manager:set_active_testify_camera(camera)
end

function CinematicManagerTestify.wait_for_mission_intro(cinematic_manager)
	local has_mission_intro_played = cinematic_manager:mission_intro_played()

	if not has_mission_intro_played then
		return Testify.RETRY
	end
end

return CinematicManagerTestify
