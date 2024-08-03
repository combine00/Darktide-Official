local ToxicGasFogSpawner = component("ToxicGasFogSpawner")

function ToxicGasFogSpawner:init(unit, is_server, nav_world)
	local run_update = false

	return run_update
end

function ToxicGasFogSpawner:destroy()
	return
end

function ToxicGasFogSpawner:enable(unit)
	return
end

function ToxicGasFogSpawner:disable(unit)
	return
end

function ToxicGasFogSpawner:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = Application.main_world()
	self._world = world
	local line_object = World.create_line_object(world)
	self._line_object = line_object
	self._drawer = DebugDrawer(line_object, "retained")
	self._gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1)

	return true
end

function ToxicGasFogSpawner:editor_validate(unit)
	return true, ""
end

function ToxicGasFogSpawner:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local line_object = self._line_object
	local world = self._world
	local gui = self._gui

	LineObject.reset(line_object)
	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)

	if self._debug_text_id then
		Gui.destroy_text_3d(gui, self._debug_text_id)
	end

	if self._section_debug_text_id then
		Gui.destroy_text_3d(gui, self._section_debug_text_id)
	end

	World.destroy_gui(world, gui)

	self._line_object = nil
	self._world = nil
end

function ToxicGasFogSpawner:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	return true
end

function ToxicGasFogSpawner:editor_world_transform_modified(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_refresh_debug_draw(unit)
end

function ToxicGasFogSpawner:editor_property_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_refresh_debug_draw(unit)
end

function ToxicGasFogSpawner:_refresh_debug_draw(unit)
	local drawer = self._drawer

	drawer:reset()
	self:_editor_debug_draw(unit)
	drawer:update(self._world)
end

function ToxicGasFogSpawner:editor_selection_changed(unit, selected)
	self._selected = selected

	self:_refresh_debug_draw(unit)
end

function ToxicGasFogSpawner:_editor_debug_draw(unit)
	local drawer = self._drawer
	local extents = self:get_data(unit, "extents")
	local position = Unit.world_position(unit, 1) + Vector3.up() * extents[3]
	local rotation = Unit.world_rotation(unit, 1)
	local pose = Matrix4x4.from_quaternion_position(rotation, position)
	local half_extents = Vector3(extents[1], extents[2], extents[3])

	drawer:box(pose, half_extents, Color.lime())
end

ToxicGasFogSpawner.component_data = {
	id = {
		ui_type = "number",
		min = 1,
		step = 1,
		value = 1,
		ui_name = "ID",
		max = 100
	},
	section = {
		ui_type = "number",
		min = 1,
		step = 1,
		value = 1,
		ui_name = "Section ID",
		max = 50
	},
	extents = {
		ui_type = "vector",
		ui_name = "Extents",
		value = Vector3Box(2, 2, 2)
	}
}

return ToxicGasFogSpawner
