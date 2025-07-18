local ParticleEffect = component("ParticleEffect")

function ParticleEffect:init(unit)
	self._unit = unit
	self._world = Unit.world(unit)
	local particle_name = self:get_data(unit, "particle")
	self._particle_name = particle_name
	self._particle_id = nil
	self._particle_node = 1
	local particle_node_name = self:get_data(unit, "particle_node_name")

	if Unit.has_node(unit, particle_node_name) then
		self._particle_node = Unit.node(unit, particle_node_name)
	end

	local create_particle_on_spawn = self:get_data(unit, "create_particle_on_spawn")

	Unit.flow_event(unit, "particle_effect_component_init")

	if create_particle_on_spawn then
		self:_create_particle()
	end

	self._selected = false
	self._highlight = false
end

function ParticleEffect:editor_validate(unit)
	local success = true
	local error_message = ""

	if self:get_data(unit, "particle") == "" then
		success = false
		error_message = error_message .. "\nMissing unit data 'particle' it can't be empty"
	end

	local particle_node_name = self:get_data(unit, "particle_node_name")

	if particle_node_name ~= "" and not Unit.has_node(unit, particle_node_name) then
		success = false
		error_message = error_message .. "\nMissing unit node '" .. particle_node_name .. "'"
	end

	return success, error_message
end

function ParticleEffect:_set_highlight_effect(highlight)
	if self._particle_id ~= nil then
		World.set_particle_effect_highlight(self._world, self._particle_id, highlight)
	end
end

function ParticleEffect:editor_highlight_changed(unit, highlight)
	self._highlight = highlight

	self:_set_highlight_effect(highlight or self._selected)
end

function ParticleEffect:editor_selection_changed(unit, selected)
	self._selected = selected

	self:_set_highlight_effect(selected or self._highlight)
end

function ParticleEffect:enable(unit)
	return
end

function ParticleEffect:disable(unit)
	return
end

function ParticleEffect:destroy(unit)
	if self._particle_id ~= nil then
		self:_destroy_particle()
	end
end

function ParticleEffect:_create_particle()
	if self._particle_id ~= nil then
		Log.error("ParticleEffect", "[create_particle] Particle already created.\n%s", Script.callstack())

		return
	end

	local particle_name = self._particle_name
	local world = self._world
	local unit = self._unit
	local world_position = Unit.world_position(unit, 1)
	local world_rotation = Unit.world_rotation(unit, 1)
	local world_scale = Unit.world_scale(unit, 1)
	local particle_id = World.create_particles(world, particle_name, world_position, world_rotation, world_scale)

	World.link_particles(world, particle_id, unit, self._particle_node, Matrix4x4.identity(), "unlink")

	self._particle_id = particle_id
	local scalar_parameters = self:get_data(unit, "scalar_parameters")
	local success = self:_set_non_boxed_parameters(world, particle_id, scalar_parameters, World.set_particles_material_scalar)

	if not success then
		self:_destroy_particle()

		return
	end

	local vector_two_parameters = self:get_data(unit, "vector_two_parameters")
	success = self:_set_boxed_parameters(world, particle_id, vector_two_parameters, World.set_particles_material_vector2)

	if not success then
		self:_destroy_particle()

		return
	end

	local vector_three_parameters = self:get_data(unit, "vector_three_parameters")
	success = self:_set_boxed_parameters(world, particle_id, vector_three_parameters, World.set_particles_material_vector3)

	if not success then
		self:_destroy_particle()

		return
	end

	local vector_four_parameters = self:get_data(unit, "vector_four_parameters")
	success = self:_set_boxed_parameters(world, particle_id, vector_four_parameters, World.set_particles_material_vector4)

	if not success then
		self:_destroy_particle()

		return
	end
end

local function _check(world, particle_id, cloud_name, parameter_name, particle_name)
	if not World.has_particles_material(world, particle_id, cloud_name) then
		Log.error("ParticleEffect", "[_check] Cloud '%s' does not exist for particle '%s'.", cloud_name, particle_name)

		return false
	elseif parameter_name == "" then
		Log.error("ParticleEffect", "[_check][_set_non_boxed_parameters] empty parameter name", particle_name)
	end

	return true
end

function ParticleEffect:_set_non_boxed_parameters(world, particle_id, parameters, set_material_function)
	for i = 1, #parameters do
		local parameter = parameters[i]
		local cloud_name = parameter.cloud_name
		local parameter_name = parameter.parameter_name
		local parameter_value = parameter.parameter_value

		if not _check(world, particle_id, cloud_name, parameter_name, self._particle_name) then
			return false
		end

		set_material_function(world, particle_id, cloud_name, parameter_name, parameter_value)
	end

	return true
end

function ParticleEffect:_set_boxed_parameters(world, particle_id, parameters, set_material_function)
	for i = 1, #parameters do
		local parameter = parameters[i]
		local cloud_name = parameter.cloud_name
		local parameter_name = parameter.parameter_name
		local parameter_value = parameter.parameter_value:unbox()

		if not _check(world, particle_id, cloud_name, parameter_name, self._particle_name) then
			return false
		end

		set_material_function(world, particle_id, cloud_name, parameter_name, parameter_value)
	end

	return true
end

function ParticleEffect:_destroy_particle()
	local particle_id = self._particle_id

	if particle_id ~= nil then
		local world = self._world

		World.destroy_particles(world, particle_id)

		self._particle_id = nil
	else
		Log.error("ParticleEffect", "[destroy_particle] Particle not created.\n%s", Script.callstack())
	end
end

function ParticleEffect:editor_property_changed(unit)
	if self._particle_id ~= nil then
		self:_destroy_particle()
	end

	if self._editor_hidden ~= true then
		self:_create_particle()
	end
end

function ParticleEffect:editor_world_transform_modified(unit)
	if self._particle_id ~= nil then
		self:_destroy_particle()
	end

	if self._editor_hidden ~= true then
		self:_create_particle()
	end
end

function ParticleEffect:editor_toggle_visibility_state(visible)
	if visible then
		self._editor_hidden = false

		if self._particle_id == nil then
			self:_create_particle()
		end
	else
		self._editor_hidden = true

		if self._particle_id ~= nil then
			self:_destroy_particle()
		end
	end
end

function ParticleEffect:create_particle()
	if not self._particle_id then
		self:_create_particle()
	end
end

function ParticleEffect:destroy_particle()
	if self._particle_id ~= nil then
		self:_destroy_particle()
	end
end

function ParticleEffect:stop_particle()
	if self._particle_id ~= nil then
		World.stop_spawning_particles(self._world, self._particle_id)

		self._particle_id = nil
	end
end

ParticleEffect.component_data = {
	particle = {
		ui_type = "resource",
		preview = false,
		value = "",
		ui_name = "Particle",
		filter = "particles"
	},
	particle_node_name = {
		ui_type = "text_box",
		value = "",
		ui_name = "Node Name"
	},
	create_particle_on_spawn = {
		ui_type = "check_box",
		value = true,
		ui_name = "Create Particle on Spawn"
	},
	scalar_parameters = {
		ui_type = "struct_array",
		ui_name = "List of parameters (scalar)",
		definition = {
			cloud_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Particle Cloud Name"
			},
			parameter_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Parameter Name"
			},
			parameter_value = {
				ui_type = "number",
				decimals = 2,
				value = 0,
				ui_name = "Value",
				step = 0.01
			}
		},
		control_order = {
			"cloud_name",
			"parameter_name",
			"parameter_value"
		}
	},
	vector_two_parameters = {
		ui_type = "struct_array",
		ui_name = "List of parameters (vector2)",
		definition = {
			cloud_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Particle Cloud Name"
			},
			parameter_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Parameter Name"
			},
			parameter_value = {
				ui_type = "vector",
				ui_name = "Value",
				value = Vector3Box(0, 0, 0)
			}
		},
		control_order = {
			"cloud_name",
			"parameter_name",
			"parameter_value"
		}
	},
	vector_three_parameters = {
		ui_type = "struct_array",
		ui_name = "List of parameters (vector3)",
		definition = {
			cloud_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Particle Cloud Name"
			},
			parameter_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Parameter Name"
			},
			parameter_value = {
				ui_type = "vector",
				ui_name = "Value",
				value = Vector3Box(0, 0, 0)
			}
		},
		control_order = {
			"cloud_name",
			"parameter_name",
			"parameter_value"
		}
	},
	vector_four_parameters = {
		ui_type = "struct_array",
		ui_name = "List of parameters (vector4)",
		definition = {
			cloud_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Particle Cloud Name"
			},
			parameter_name = {
				ui_type = "text_box",
				value = "",
				ui_name = "Parameter Name"
			},
			parameter_value = {
				ui_type = "color",
				ui_name = "Value",
				value = QuaternionBox(1, 0, 0, 0)
			}
		},
		control_order = {
			"cloud_name",
			"parameter_name",
			"parameter_value"
		}
	},
	inputs = {
		create_particle = {
			accessibility = "public",
			type = "event"
		},
		destroy_particle = {
			accessibility = "public",
			type = "event"
		},
		stop_particle = {
			accessibility = "public",
			type = "event"
		}
	}
}

return ParticleEffect
