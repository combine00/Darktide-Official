local ShadingEnvironmentExtension = class("ShadingEnvironmentExtension")

function ShadingEnvironmentExtension:init(extension_init_context, unit, extension_init_data, game_object_data, ...)
	local world = extension_init_context.world
	self._world = world
	self._unit = unit
	self._weight = 0
	self._shading_environment_resource_name = nil
	self._shading_environment_resource = nil
	self._fade_in_distance = 1
	self._layer = 1
	self._blend_mask = ShadingEnvironmentBlendMask.ALL
	self._slot = -1
end

function ShadingEnvironmentExtension:_clear_previous_shading_environment_resource()
	if self._shading_environment_resource then
		World.destroy_shading_environment_resource(self._world, self._shading_environment_resource)

		self._shading_environment_resource = nil
		self._shading_environment_resource_name = nil

		Managers.state.camera:remove_environment(self)

		self._enabled = false
	end
end

function ShadingEnvironmentExtension:setup_from_component(fade_in_distance, layer, blend_mask, shading_environment_resource_name, shading_environment_slot, start_enabled)
	self:_clear_previous_shading_environment_resource()

	self._shading_environment_resource_name_default = shading_environment_resource_name
	self._fade_in_distance = fade_in_distance
	self._layer = layer
	self._slot = shading_environment_slot

	if blend_mask == "OVERRIDES" then
		self._blend_mask = ShadingEnvironmentBlendMask.OVERRIDES
	elseif blend_mask == "ALL" then
		self._blend_mask = ShadingEnvironmentBlendMask.ALL
	end

	if self._shading_environment_resource_name_default ~= "" and self._slot == -1 then
		self._shading_environment_resource_name = self._shading_environment_resource_name_default

		if start_enabled then
			self:enable()
		end

		self._shading_environment_resource = World.create_shading_environment_resource(self._world, shading_environment_resource_name)
	end
end

function ShadingEnvironmentExtension:set_slot(shading_environment_slot)
	self._slot = shading_environment_slot
end

function ShadingEnvironmentExtension:slot()
	return self._slot
end

function ShadingEnvironmentExtension:destroy(unit)
	self:disable()
	self:_clear_previous_shading_environment_resource()
end

function ShadingEnvironmentExtension:enable()
	if not self._enabled then
		local camera_manager = Managers.state.camera

		camera_manager:add_environment(self)
	end

	self._enabled = true
end

function ShadingEnvironmentExtension:disable()
	if self._enabled then
		local camera_manager = Managers.state.camera

		camera_manager:remove_environment(self)
	end

	self._enabled = false
end

function ShadingEnvironmentExtension:setup_theme(shading_environment_system, force_reset)
	local slot_id = self._slot

	if slot_id > -1 then
		if force_reset then
			self:_clear_previous_shading_environment_resource()
		end

		local shading_environment = shading_environment_system:theme_environment_from_slot(slot_id)

		if shading_environment then
			self._shading_environment_resource_name = shading_environment
		else
			self._shading_environment_resource_name = self._shading_environment_resource_name_default
		end

		if self._shading_environment_resource_name and self._shading_environment_resource_name ~= "" then
			local camera_manager = Managers.state.camera

			camera_manager:add_environment(self)

			self._enabled = true
			self._shading_environment_resource = World.create_shading_environment_resource(self._world, self._shading_environment_resource_name)
		end
	end
end

function ShadingEnvironmentExtension:layer()
	return self._layer
end

function ShadingEnvironmentExtension:resource()
	return self._shading_environment_resource
end

function ShadingEnvironmentExtension:name()
	return self._shading_environment_resource_name
end

function ShadingEnvironmentExtension:blend_mask()
	return self._blend_mask
end

function ShadingEnvironmentExtension:weight(observer_position)
	local inside = Unit.is_point_inside_volume(self._unit, "env_volume", observer_position)

	if inside then
		local distance_to_border = Unit.distance_to_volume(self._unit, "env_volume", observer_position)
		self._weight = math.clamp(distance_to_border / self._fade_in_distance, 0, 1)
	else
		self._weight = 0
	end

	return self._weight
end

return ShadingEnvironmentExtension
