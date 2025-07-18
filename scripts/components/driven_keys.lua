local DrivenKeys = component("DrivenKeys")
local TRANSLATE_LABELS = {
	"translateX",
	"translateY",
	"translateZ"
}
local ROTATE_LABELS = {
	"rotateX",
	"rotateY",
	"rotateZ"
}

function DrivenKeys:init(unit)
	local unit_lua_data = require(tostring(unit):match("'(.-)'"))
	self.driven_keys = unit_lua_data.driven_keys
	self._unit = unit
end

function DrivenKeys:enable(unit)
	return
end

function DrivenKeys:disable(unit)
	return
end

function DrivenKeys:destroy(unit)
	return
end

function DrivenKeys:changed(unit)
	for driven_node, driven_node_data in pairs(self.driven_keys) do
		self:_setDrivenPose(driven_node, driven_node_data)
	end
end

function DrivenKeys:_setDrivenPose(driven_node, driven_node_data)
	if not Unit.has_node(self._unit, driven_node) then
		return
	end

	local driven_node_index = Unit.node(self._unit, driven_node)
	local original_position = Unit.local_position(self._unit, driven_node_index)
	local driven_position = Unit.local_position(self._unit, driven_node_index)
	local driven_q = Unit.local_rotation(self._unit, driven_node_index)
	local original_rotation = self:_quaternionToEulerAngles(driven_q)
	local driven_rotation = self:_quaternionToEulerAngles(driven_q)

	for driven_attribute, driven_attribute_data in pairs(driven_node_data) do
		local sum_of_driven_values = self:_getSumOfDrivenValues(driven_attribute_data)
		local t_axis = self:_getAxis(driven_attribute, TRANSLATE_LABELS)
		local r_axis = self:_getAxis(driven_attribute, ROTATE_LABELS)

		if t_axis ~= nil then
			driven_position = self:_editDrivenVector(driven_position, sum_of_driven_values, t_axis)
		elseif r_axis ~= nil then
			driven_rotation = self:_editDrivenVector(driven_rotation, sum_of_driven_values, r_axis)
		end
	end

	if not Vector3.equal(original_position, driven_position) then
		Unit.set_local_position(self._unit, driven_node_index, driven_position)
	end

	if not Vector3.equal(original_rotation, driven_rotation) then
		local rx, ry, rz = Vector3.to_elements(driven_rotation)
		driven_q = Quaternion.from_euler_angles_xyz(rx, ry, rz)

		Unit.set_local_rotation(self._unit, driven_node_index, driven_q)
	end
end

function DrivenKeys:_getSumOfDrivenValues(driven_attribute_data)
	local sum_of_driven_values, t_axis, r_axis, driving_axis, driving_vector, driving_value, driven_value = nil

	for driving_node, driving_node_data in pairs(driven_attribute_data) do
		local driving_node_index = Unit.node(self._unit, driving_node)

		for driving_attribute, keys in pairs(driving_node_data) do
			t_axis = self:_getAxis(driving_attribute, TRANSLATE_LABELS)
			r_axis = self:_getAxis(driving_attribute, ROTATE_LABELS)
			driving_axis, driving_vector, driving_value = nil

			if t_axis ~= nil then
				driving_vector = self:_getLocalTransforms(driving_node_index)
				driving_axis = t_axis
			elseif r_axis ~= nil then
				driving_vector = self:_getLocalRotationFromOriginalParent(driving_node_index)
				driving_axis = r_axis
			end

			if driving_axis == 1 then
				driving_value = Vector3.x(driving_vector)
			elseif driving_axis == 2 then
				driving_value = Vector3.y(driving_vector)
			elseif driving_axis == 3 then
				driving_value = Vector3.z(driving_vector)
			end

			driven_value = self:linearLineEquation(driving_value, keys)

			if sum_of_driven_values == nil then
				sum_of_driven_values = driven_value
			else
				sum_of_driven_values = sum_of_driven_values + driven_value
			end
		end
	end

	return sum_of_driven_values
end

function DrivenKeys:_editDrivenVector(vector, sum_of_driven_values, axis)
	if axis == 1 then
		Vector3.set_x(vector, sum_of_driven_values)
	elseif axis == 2 then
		Vector3.set_y(vector, sum_of_driven_values)
	elseif axis == 3 then
		Vector3.set_z(vector, sum_of_driven_values)
	end

	return vector
end

function DrivenKeys:linearLineEquation(x, keys)
	local y = nil

	if x <= keys[1].x then
		y = keys[1].y
	elseif keys[#keys].x <= x then
		y = keys[#keys].y
	else
		local x1, y1, x2, y2 = nil

		for i, key in ipairs(keys) do
			local next_key = keys[i + 1]

			if key.x <= x and x <= next_key.x then
				y1 = key.y
				x1 = key.x
				y2 = next_key.y
				x2 = next_key.x

				break
			end
		end

		local k = (y1 - y2) / (x1 - x2)
		local m = y1 - k * x1
		y = k * x + m
	end

	return y
end

function DrivenKeys:_getLocalTranslationFromOriginalParent(node_index)
	local parent_index = Unit.scene_graph_parent(self._unit, node_index)
	local parent_world_position = Unit.world_position(self._unit, parent_index)
	local node_world_position = Unit.world_position(self._unit, node_index)

	return node_world_position - parent_world_position
end

function DrivenKeys:_getLocalRotationFromOriginalParent(node_index)
	local parent_index = Unit.scene_graph_parent(self._unit, node_index)
	local parent_world_rotation_q = Unit.world_rotation(self._unit, parent_index)
	local node_world_rotation_q = Unit.world_rotation(self._unit, node_index)
	local inverted_parent_world_rotation_q = Quaternion.inverse(parent_world_rotation_q)
	local q = Quaternion.multiply(inverted_parent_world_rotation_q, node_world_rotation_q)

	return self:_quaternionToEulerAngles(q)
end

function DrivenKeys:_getAxis(attribute_label, labels)
	for index, value in ipairs(labels) do
		if value == attribute_label then
			return index
		end
	end

	return nil
end

function DrivenKeys:_quaternionToEulerAngles(q)
	local qx, qy, qz, qw = Quaternion.to_elements(q)
	local t0 = 2 * (qw * qx + qy * qz)
	local t1 = 1 - 2 * (qx * qx + qy * qy)
	local x = math.radians_to_degrees(math.atan2(t0, t1))
	local t2 = 2 * (qw * qy - qz * qx)

	if t2 > 1 then
		t2 = 1
	elseif t2 < -1 then
		t2 = -1
	end

	local y = math.radians_to_degrees(math.asin(t2))
	local t3 = 2 * (qw * qz + qx * qy)
	local t4 = 1 - 2 * (qy * qy + qz * qz)
	local z = math.radians_to_degrees(math.atan2(t3, t4))
	local euler_angles = Vector3.zero()

	Vector3.set_xyz(euler_angles, x, y, z)

	return euler_angles
end

function DrivenKeys:editor_validate(unit)
	return true, ""
end

DrivenKeys.component_config = {
	disable_event_public = false,
	enable_event_public = false,
	starts_enabled_default = true
}
DrivenKeys.component_data = {
	enabled = {
		ui_type = "check_box",
		value = true,
		ui_name = "Enabled",
		category = "Settings"
	}
}

return DrivenKeys
