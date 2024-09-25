local CameraShake = {
	camera_shake_by_distance = function (shake_name, position, near_distance, far_distance, near_value, far_value)
		local source_unit_data = {
			source_position = Vector3Box(position),
			near_distance = near_distance,
			far_distance = far_distance,
			near_value = near_value,
			far_value = far_value
		}

		Managers.state.camera:add_camera_effect_shake_event(shake_name, source_unit_data)
	end
}

return CameraShake
