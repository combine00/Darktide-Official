local WwiseRoomVolume = component("WwiseRoomVolume")

function WwiseRoomVolume:init(unit)
	self._wwise_world = Wwise.wwise_world(Unit.world(unit))

	if not Unit.has_volume(unit, "room_volume") then
		return false
	end

	local rooms_and_portals_manager = Managers and Managers.state and Managers.state.rooms_and_portals

	if rooms_and_portals_manager then
		rooms_and_portals_manager:register_room(self)

		return true
	end

	return false
end

function WwiseRoomVolume:destroy(unit)
	local rooms_and_portals_manager = Managers and Managers.state and Managers.state.rooms_and_portals

	if rooms_and_portals_manager then
		rooms_and_portals_manager:remove_room(self)
	end
end

function WwiseRoomVolume:enable(unit)
	return
end

function WwiseRoomVolume:disable(unit)
	return
end

function WwiseRoomVolume:editor_init(unit)
	return
end

function WwiseRoomVolume:editor_destroy(unit)
	return
end

function WwiseRoomVolume:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_volume(unit, "room_volume") then
		success = false
		error_message = error_message .. "\nMissing volume 'room_volume'"
	end

	return success, error_message
end

WwiseRoomVolume.component_data = {
	priority = {
		ui_type = "number",
		min = 1,
		step = 1,
		decimals = 0,
		value = 1,
		ui_name = "Priority",
		max = 1024
	},
	wall_occlusion = {
		ui_type = "number",
		min = 0,
		step = 1,
		decimals = 2,
		value = 1,
		ui_name = "Wall Occlusion",
		max = 1
	},
	aux_send_to_self = {
		ui_type = "number",
		min = 0,
		step = 1,
		decimals = 2,
		value = 0.25,
		ui_name = "Aux send to self",
		max = 1
	},
	reverb_aux_bus = {
		ui_type = "combo_box",
		value = "indoor_medium_3d",
		ui_name = "Reverb aux bus",
		options = {
			"indoor_large_3d",
			"indoor_medium_3d",
			"indoor_small_3d",
			"indoor_tiny_3d",
			"urban_large_3d",
			"urban_medium_3d",
			"urban_small_3d",
			"indoor_small_tunnel_3d",
			"indoor_large_echo_3d",
			"indoor_medium_hallway_3d",
			"indoor_huge_cylinder_3d",
			"indoor_small_hallway_3d",
			"outside_huge_canyon_3d"
		}
	},
	ambient_event = {
		ui_type = "resource",
		preview = true,
		thumbnails = false,
		value = "",
		ui_name = "Ambient event",
		filter = "wwise_event"
	},
	environment_state = {
		ui_type = "combo_box",
		value = "indoor_medium",
		ui_name = "Environment state",
		options = {
			"indoor_huge",
			"indoor_large",
			"indoor_medium",
			"indoor_small",
			"indoor_tiny",
			"urban_large",
			"urban_medium",
			"urban_small"
		}
	}
}

return WwiseRoomVolume
