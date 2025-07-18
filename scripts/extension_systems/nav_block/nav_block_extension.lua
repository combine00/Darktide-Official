local NavBlockExtension = class("NavBlockExtension")

function NavBlockExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_server = extension_init_context.is_server
	self._layer_names = {}
end

function NavBlockExtension:destroy()
	if self._is_server then
		local nav_mesh_manager = Managers.state.nav_mesh

		for volume_name, layer_name in pairs(self._layer_names) do
			if not nav_mesh_manager:is_nav_tag_volume_layer_allowed(layer_name) then
				nav_mesh_manager:set_allowed_nav_tag_layer(layer_name, true)
			end
		end
	end

	if self._nav_tag_volume then
		Managers.state.nav_mesh:remove_nav_tag_volume(self._nav_tag_volume)
	end
end

function NavBlockExtension:setup_from_component(unit, volume_name, start_blocked)
	local unit_level_index = Managers.state.unit_spawner:level_index(unit)
	local layer_name = "nav_block_volume_" .. tostring(unit_level_index) .. "_" .. volume_name
	local volume_layer_allowed = nil

	if self._is_server then
		volume_layer_allowed = not start_blocked
	else
		volume_layer_allowed = true
	end

	local volume_points = Unit.volume_points(unit, volume_name)
	local volume_height = Unit.volume_height(unit, volume_name)
	local volume_alt_min, volume_alt_max = self:_get_volume_alt_min_max(unit, volume_points, volume_height)
	self._nav_tag_volume = Managers.state.nav_mesh:add_nav_tag_volume(volume_points, volume_alt_min, volume_alt_max, layer_name, volume_layer_allowed)
	self._layer_names[volume_name] = layer_name
end

function NavBlockExtension:set_block(volume_name, block)
	local is_allowed = not block

	Managers.state.nav_mesh:set_allowed_nav_tag_layer(self._layer_names[volume_name], is_allowed)
end

function NavBlockExtension:_get_volume_alt_min_max(unit, volume_points, volume_height)
	local alt_min, alt_max = nil

	for i = 1, #volume_points do
		local alt = volume_points[i].z

		if not alt_min or alt < alt_min then
			alt_min = alt
		end

		if not alt_max or alt_max < alt + volume_height then
			alt_max = alt + volume_height
		end
	end

	return alt_min, alt_max
end

return NavBlockExtension
