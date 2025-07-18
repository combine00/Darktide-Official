local LevelPropCustomization = component("LevelPropCustomization")

function LevelPropCustomization:init(unit)
	self._unit = unit
	self._world = Unit.world(self._unit)
	self._child_units = {}
	self._chunk_lodding_registered = false
	self._child_is_static = {}
	self._editor_toggle_visibility_state = true

	self:_spawn_children()

	self._lerp_material_variables_data = {}
	self._lerp_reverse = false
	self._should_update = false

	self:_set_material_variables()

	if Managers and Managers.state and Managers.state.chunk_lod and Managers.state.chunk_lod:register_unit(unit, callback(self, "on_chunk_visibility_state_changed")) then
		self._chunk_lodding_registered = true
	end

	return true
end

function LevelPropCustomization:editor_validate(unit)
	return true, ""
end

function LevelPropCustomization:on_chunk_visibility_state_changed(is_visible)
	local static_map = self._child_is_static

	for _, child_unit in ipairs(self._child_units) do
		Unit.set_unit_visibility(child_unit, is_visible)

		if static_map[child_unit] then
			if is_visible then
				self:_create_actors(child_unit)
			else
				self:_destroy_actors(child_unit)
			end
		end
	end
end

function LevelPropCustomization:editor_toggle_visibility_state(is_visible)
	self._editor_toggle_visibility_state = is_visible

	for _, child_unit in ipairs(self._child_units) do
		Unit.set_unit_visibility(child_unit, is_visible)
	end
end

function LevelPropCustomization:get_navgen_units()
	return self._child_units
end

function LevelPropCustomization:editor_world_transform_modified(unit)
	self:_unspawn_children()
	self:_spawn_children()
end

function LevelPropCustomization:destroy(unit)
	if self._chunk_lodding_registered then
		Managers.state.chunk_lod:unregister_unit(unit)

		self._chunk_lodding_registered = false
	end

	self:_unspawn_children()
end

function LevelPropCustomization:_spawn_children()
	local unit = self._unit
	local children_unit_spawn_info = self:get_data(unit, "children_units")

	for _, child_unit_spawn_info in ipairs(children_unit_spawn_info) do
		local enabled = child_unit_spawn_info.enabled
		local child_unit_name = child_unit_spawn_info.child_unit

		if enabled and child_unit_name ~= "" then
			local parent_node_name = child_unit_spawn_info.parent_node_name
			local parent_node = 1

			if parent_node_name and Unit.has_node(unit, parent_node_name) then
				parent_node = Unit.node(unit, parent_node_name)
			end

			local parent_pose = Unit.world_pose(unit, parent_node)
			local child_pose = Matrix4x4.identity()
			local child_scale = child_unit_spawn_info.child_scale:unbox()

			Matrix4x4.set_scale(child_pose, child_scale)

			local full_pose = Matrix4x4.multiply(child_pose, parent_pose)
			local world = self._world
			local child_unit = nil

			if child_unit_spawn_info.is_static then
				child_unit = World.spawn_unit_ex(world, child_unit_name, nil, full_pose, nil, true)
				self._child_is_static[child_unit] = true
			else
				child_unit = World.spawn_unit_ex(world, child_unit_name, nil, full_pose)

				self:_destroy_actors(child_unit)
				World.link_unit(world, child_unit, 1, unit, parent_node)
				Unit.set_local_scale(child_unit, 1, child_scale)

				self._child_is_static[child_unit] = false
			end

			if not child_unit_spawn_info.cast_shadows then
				Unit.set_unit_objects_visibility(child_unit, false, false, VisibilityContexts.SHADOW_CASTER_CONTEXT)
			end

			table.insert(self._child_units, child_unit)
		end
	end

	if rawget(_G, "LevelEditor") then
		self:editor_toggle_visibility_state(self._editor_toggle_visibility_state)
	end
end

function LevelPropCustomization:_destroy_actors(unit)
	for ii = 1, Unit.num_actors(unit) do
		Unit.destroy_actor(unit, ii)
	end
end

function LevelPropCustomization:_create_actors(unit)
	for ii = 1, Unit.num_actors(unit) do
		Unit.create_actor(unit, ii)
	end
end

function LevelPropCustomization:_unspawn_children()
	for _, child_unit in ipairs(self._child_units) do
		local world = self._world

		World.unlink_unit(world, child_unit)
		World.destroy_unit(world, child_unit)
	end

	table.clear(self._child_units)
end

function LevelPropCustomization:_set_material_variables()
	local unit = self._unit
	local material_variables = self:get_data(unit, "set_material_variables")

	for _, entry in ipairs(material_variables) do
		local material = entry.material
		local variable = entry.variable

		if material == nil or material == "" or variable == nil or variable == "" then
			return
		end

		if entry.use_scalar then
			Unit.set_scalar_for_material(unit, material, variable, entry.scalar)
		elseif entry.use_vector then
			Unit.set_vector3_for_material(unit, material, variable, entry.vector:unbox())
		elseif entry.use_color then
			local color = entry.color:unbox()
			local a, r, g, b = Quaternion.to_elements(color)

			Unit.set_vector3_for_material(unit, material, variable, Vector3(r / 255, g / 255, b / 255))
		end
	end

	local lerp_material_variables = self:get_data(unit, "lerp_material_variables")

	for _, entry in ipairs(lerp_material_variables) do
		local material = entry.material
		local variable = entry.variable
		self._lerp_material_variables_data[entry] = 0

		if material == nil or material == "" or variable == nil or variable == "" then
			return
		end

		Unit.set_scalar_for_material(unit, material, variable, entry.scalar_from)
	end
end

function LevelPropCustomization:enable(unit)
	return
end

function LevelPropCustomization:disable(unit)
	return
end

function LevelPropCustomization:update(unit, dt, t)
	if self._should_update then
		local keep_update = false

		for entry, current_t in pairs(self._lerp_material_variables_data) do
			local material = entry.material
			local variable = entry.variable
			local lerp_t = math.clamp01(current_t / entry.duration)

			if lerp_t ~= 1 then
				keep_update = true
				local value = not self._lerp_reverse and math.lerp(entry.scalar_from, entry.scalar_to, lerp_t) or math.lerp(entry.scalar_to, entry.scalar_from, lerp_t)
				self._lerp_material_variables_data[entry] = current_t + dt

				Unit.set_scalar_for_material(unit, material, variable, value)
			end
		end

		self._should_update = keep_update
	end

	return self._should_update
end

function LevelPropCustomization:_reset_lerp_material_variables_data()
	for entry, _ in pairs(self._lerp_material_variables_data) do
		self._lerp_material_variables_data[entry] = 0
	end
end

function LevelPropCustomization:play_lerp_material_variables(unit)
	self:_reset_lerp_material_variables_data()

	self._lerp_reverse = false
	self._should_update = true

	return true
end

function LevelPropCustomization:reverse_lerp_material_variables(unit)
	self:_reset_lerp_material_variables_data()

	self._lerp_reverse = true
	self._should_update = true

	return true
end

function LevelPropCustomization:editor_update(unit, dt, t)
	return self:update(unit, dt, t)
end

function LevelPropCustomization:editor_property_changed(unit)
	self:_unspawn_children()
	self:_spawn_children()
	self:_set_material_variables()
end

LevelPropCustomization.component_data = {
	children_units = {
		ui_type = "struct_array",
		category = "Attached Units",
		ui_name = "Linked Units",
		definition = {
			parent_node_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Node Name",
				category = "Parent"
			},
			child_unit = {
				ui_type = "resource",
				preview = true,
				category = "Child",
				value = "",
				ui_name = "Unit",
				filter = "unit"
			},
			child_scale = {
				ui_type = "vector",
				category = "Child",
				ui_name = "Scale",
				step = 0.1,
				value = Vector3Box(1, 1, 1)
			},
			is_static = {
				ui_type = "check_box",
				value = true,
				ui_name = "Static",
				category = "Child"
			},
			cast_shadows = {
				ui_type = "check_box",
				value = true,
				ui_name = "Cast Shadows",
				category = "Child"
			},
			enabled = {
				ui_type = "check_box",
				value = true,
				ui_name = "Enabled",
				category = "Child"
			}
		},
		control_order = {
			"parent_node_name",
			"child_unit",
			"child_scale",
			"is_static",
			"cast_shadows",
			"enabled"
		}
	},
	set_material_variables = {
		ui_type = "struct_array",
		category = "Material Variables",
		ui_name = "Set Material Variables",
		definition = {
			material = {
				ui_type = "text_box",
				value = "",
				ui_name = "Material"
			},
			variable = {
				ui_type = "text_box",
				value = "",
				ui_name = "Variable"
			},
			use_scalar = {
				ui_type = "check_box",
				value = false,
				ui_name = "Use Scalar"
			},
			scalar = {
				ui_type = "number",
				value = 0,
				ui_name = "Scalar"
			},
			use_vector = {
				ui_type = "check_box",
				value = false,
				ui_name = "Use Vector"
			},
			vector = {
				ui_type = "vector",
				ui_name = "Vector",
				value = Vector3Box(1, 0, 0)
			},
			use_color = {
				ui_type = "check_box",
				value = false,
				ui_name = "Use Color"
			},
			color = {
				ui_type = "color",
				ui_name = "Color",
				value = QuaternionBox(1, 0, 0, 0)
			}
		},
		control_order = {
			"material",
			"variable",
			"use_scalar",
			"scalar",
			"use_vector",
			"vector",
			"use_color",
			"color"
		}
	},
	lerp_material_variables = {
		ui_type = "struct_array",
		category = "Material Variables",
		ui_name = "Lerp Material Variables",
		definition = {
			material = {
				ui_type = "text_box",
				value = "",
				ui_name = "Material"
			},
			variable = {
				ui_type = "text_box",
				value = "",
				ui_name = "Variable"
			},
			scalar_from = {
				ui_type = "number",
				value = 0,
				ui_name = "From Value (Scalar)"
			},
			scalar_to = {
				ui_type = "number",
				value = 0,
				ui_name = "To Value (Scalar)"
			},
			duration = {
				ui_type = "number",
				value = 0,
				ui_name = "Duration"
			}
		},
		control_order = {
			"material",
			"variable",
			"scalar_from",
			"scalar_to",
			"duration"
		}
	},
	inputs = {
		play_lerp_material_variables = {
			accessibility = "public",
			type = "event"
		},
		reverse_lerp_material_variables = {
			accessibility = "public",
			type = "event"
		}
	}
}

return LevelPropCustomization
