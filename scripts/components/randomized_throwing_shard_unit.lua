local RandomizedThrowingShardUnit = component("RandomizedThrowingShardUnit")
local DISSOLVE_TIME = 0.3

function RandomizedThrowingShardUnit:init(unit)
	self._unit = unit
	local world = Unit.world(unit)
	self._world = world
	self._wwise_world = Wwise.wwise_world(world)
	local visiblity_group_names = {}
	self._visiblity_group_names = visiblity_group_names
	self._dissolve_material_slot_name = self:get_data(unit, "dissolve_material_slot_name")
	self._dissolve_variable_name = self:get_data(unit, "dissolve_variable_name")
	local visiblity_groups = self:get_data(unit, "visiblity_groups")
	local num_visiblity_groups = #visiblity_groups

	for ii = 1, num_visiblity_groups do
		local entry = visiblity_groups[ii]
		local visiblity_group_name = entry.visiblity_group_name
		visiblity_group_names[#visiblity_group_names + 1] = visiblity_group_name
	end

	self._num_visibility_groups = #visiblity_group_names
	self._current_visibility_group_index = 1
	self._looping_effect_id = nil

	self:hide_all_vsibility_groups()

	return true
end

function RandomizedThrowingShardUnit:enable(unit)
	return
end

function RandomizedThrowingShardUnit:disable(unit)
	return
end

function RandomizedThrowingShardUnit:destroy(unit)
	self:hide()
end

function RandomizedThrowingShardUnit:update(unit, dt, t)
	self:_update_dissolve(dt, t)

	return true
end

function RandomizedThrowingShardUnit:_update_dissolve(dt, t)
	local start_t = self._dissolve_start_t

	if not start_t then
		return
	end

	local unit = self._unit
	local dissolve_material_slot_name = self._dissolve_material_slot_name
	local time_in_dissolve = t - start_t
	local value = time_in_dissolve / DISSOLVE_TIME

	Unit.set_scalar_for_material(unit, dissolve_material_slot_name, self._dissolve_variable_name, math.clamp01(value))

	if value >= 1 then
		self._dissolve_start_t = nil
	end
end

function RandomizedThrowingShardUnit:_show_visibility_group(visibility_group_index, scale)
	local unit = self._unit

	Unit.set_visibility(unit, self._visiblity_group_names[visibility_group_index], true, true)
	Unit.set_local_scale(unit, 1, Vector3.one() * scale)
end

function RandomizedThrowingShardUnit:_hide_visibility_group(visibility_group_index)
	local unit = self._unit

	Unit.set_visibility(unit, self._visiblity_group_names[visibility_group_index], false, true)
	Unit.set_local_scale(unit, 1, Vector3.one())
end

function RandomizedThrowingShardUnit:_start_dissolve(t)
	self._dissolve_start_t = t
	local unit = self._unit
	local dissolve_material_slot_name = self._dissolve_material_slot_name

	Unit.set_scalar_for_material(unit, dissolve_material_slot_name, self._dissolve_variable_name, 0)
end

function RandomizedThrowingShardUnit:set_visibility_group_index(visibility_group_index)
	self._visibility_group_index = visibility_group_index
end

function RandomizedThrowingShardUnit:show(t, particle_effect_name, wwise_event_name, scale)
	if particle_effect_name then
		local world = self._world
		local effect_id = World.create_particles(world, particle_effect_name, Vector3.zero())

		World.link_particles(world, effect_id, self._unit, 1, Matrix4x4.identity(), "stop")

		self._looping_effect_id = effect_id
	end

	if wwise_event_name then
		WwiseWorld.trigger_resource_event(self._wwise_world, wwise_event_name, self._unit)
	end

	self:_show_visibility_group(self._visibility_group_index, scale)
	self:_start_dissolve(t)
end

function RandomizedThrowingShardUnit:hide()
	if self._looping_effect_id then
		World.destroy_particles(self._world, self._looping_effect_id)

		self._looping_effect_id = nil
	end

	self:_hide_visibility_group(self._visibility_group_index)
end

function RandomizedThrowingShardUnit:hide_all_vsibility_groups()
	local num_visibility_groups = self._num_visibility_groups

	for ii = 1, num_visibility_groups do
		self:_hide_visibility_group(ii)
	end
end

function RandomizedThrowingShardUnit:num_visibility_groups()
	return self._num_visibility_groups
end

RandomizedThrowingShardUnit.component_data = {
	visiblity_groups = {
		ui_type = "struct_array",
		ui_name = "Visiblity Groups",
		definition = {
			visiblity_group_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Visiblity Group Name"
			}
		},
		control_order = {
			"visiblity_group_name"
		}
	},
	dissolve_variable_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Variable Name",
		category = "Dissolve"
	},
	dissolve_material_slot_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Material Slot Name",
		category = "Dissolve"
	}
}

return RandomizedThrowingShardUnit
