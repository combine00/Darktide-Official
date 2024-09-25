local RespawnBeaconQueries = require("scripts/extension_systems/respawn_beacon/utilities/respawn_beacon_queries")
local SharedNav = require("scripts/components/utilities/shared_nav")
local RespawnBeacon = component("RespawnBeacon")

function RespawnBeacon:init(unit)
	local respawn_beacon_extension = ScriptUnit.fetch_component_extension(unit, "respawn_beacon_system")

	if respawn_beacon_extension then
		local side = self:get_data(unit, "side")
		local debug_ignore_check_distances = self:get_data(unit, "debug_ignore_check_distances")

		respawn_beacon_extension:setup_from_component(side, debug_ignore_check_distances)
	end
end

function RespawnBeacon:destroy(unit)
	return
end

function RespawnBeacon:enable(unit)
	return
end

function RespawnBeacon:disable(unit)
	return
end

local FONT = "core/editor_slave/gui/arial"
local FONT_MATERIAL = "core/editor_slave/gui/arial"
local FONT_SIZE = 0.3

function RespawnBeacon:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = Application.main_world()
	self._world = world
	self._physics_world = World.physics_world(world)
	self._line_object = World.create_line_object(world)
	self._drawer = DebugDrawer(self._line_object, "retained")
	self._debug_text_id = nil
	self._gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1)
	self._selected = false

	if RespawnBeacon._nav_info == nil then
		RespawnBeacon._nav_info = SharedNav.create_nav_info()
	end

	self._my_nav_gen_guid = nil
	self._debug_draw_enabled = false
	local object_id = Unit.get_data(unit, "LevelEditor", "object_id")
	self._object_id = object_id
	self._in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(object_id)

	self:_reset_data()

	return true
end

function RespawnBeacon:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") and not Unit.has_volume(unit, "c_respawn_volume") then
		success = false
		error_message = error_message .. "\nMissing volume 'c_respawn_volume'"
	end

	return success, error_message
end

function RespawnBeacon:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local world = self._world
	local line_object = self._line_object

	LineObject.reset(line_object)
	LineObject.dispatch(world, line_object)
	World.destroy_line_object(world, line_object)

	local gui = self._gui

	if self._debug_text_id then
		Gui.destroy_text_3d(gui, self._debug_text_id)
	end

	World.destroy_gui(world, gui)
end

function RespawnBeacon:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	if self._in_active_mission_table then
		local with_traverse_logic = false
		local nav_gen_guid = SharedNav.check_new_navmesh_generated(RespawnBeacon._nav_info, self._my_nav_gen_guid, with_traverse_logic)

		if nav_gen_guid then
			self:_generate_spawn_slots(unit)
			self:_editor_debug_draw(unit)

			self._my_nav_gen_guid = nav_gen_guid
		end
	end

	return true
end

function RespawnBeacon:editor_on_mission_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	local in_active_mission_table = LevelEditor:is_level_object_in_active_mission_table(self._object_id)
	self._in_active_mission_table = in_active_mission_table

	if in_active_mission_table then
		self:_generate_spawn_slots(unit)
		self:_editor_debug_draw(unit)
	end
end

function RespawnBeacon:editor_world_transform_modified(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self:_generate_spawn_slots(unit)
	self:_editor_debug_draw(unit)
end

function RespawnBeacon:editor_toggle_debug_draw(enable)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._debug_draw_enabled = enable

	self:_editor_debug_draw(self.unit)
end

function RespawnBeacon:editor_selection_changed(unit, selected)
	if not rawget(_G, "LevelEditor") then
		return
	end

	self._selected = selected

	self:_editor_debug_draw(unit)
end

function RespawnBeacon:_editor_debug_draw(unit)
	if self._debug_text_id then
		Gui.destroy_text_3d(self._gui, self._debug_text_id)
	end

	local drawer = self._drawer

	drawer:reset()

	if self._selected and self._debug_draw_enabled then
		local active_mission_level_id = LevelEditor:get_active_mission_level()
		local nav_world = RespawnBeacon._nav_info.nav_world_from_level_id[active_mission_level_id]

		if nav_world then
			local valid_positions, on_nav_positions, fitting_positions, volume_positions = self:_unbox_positions()
			local player_radius = 1
			local player_height = 2.3

			RespawnBeaconQueries.debug_draw(drawer, valid_positions, on_nav_positions, fitting_positions, volume_positions, player_radius, player_height)

			local min_num_slots = 3

			self:_draw_text(unit, string.format("Possible Respawn slots(%d)", #valid_positions), min_num_slots < #valid_positions)
		else
			self:_draw_text(unit, string.format("No Nav World. Please Bake."), false)
		end
	end

	drawer:update(self._world)
end

function RespawnBeacon:_draw_text(unit, text, success)
	local text_color = nil

	if success == true then
		text_color = Color.green()
	else
		text_color = Color.red()
	end

	local text_position = Unit.local_position(unit, 1) + Vector3.up() * 3
	local translation_matrix = Matrix4x4.from_translation(text_position)
	local text_id = Gui.text_3d(self._gui, text, FONT_MATERIAL, FONT_SIZE, FONT, translation_matrix, Vector3.zero(), 3, text_color)
	self._debug_text_id = text_id
end

function RespawnBeacon:_generate_spawn_slots(unit)
	self:_reset_data()

	local active_mission_level_id = LevelEditor:get_active_mission_level()
	local nav_world = RespawnBeacon._nav_info.nav_world_from_level_id[active_mission_level_id]

	if nav_world then
		local physics_world = self._physics_world
		local player_radius = 1
		local player_height = 2.3
		local valid_positions, on_nav_positions, fitting_positions, volume_positions = RespawnBeaconQueries.spawn_locations(nav_world, physics_world, unit, player_radius, player_height)

		self:_store_positions(valid_positions, on_nav_positions, fitting_positions, volume_positions)
	end
end

function RespawnBeacon:_store_positions(valid_positions, on_nav_positions, fitting_positions, volume_positions)
	local Vector3Box = Vector3Box
	local positions = self._valid_positions

	for i = 1, #valid_positions do
		positions[#positions + 1] = Vector3Box(valid_positions[i])
	end

	positions = self._on_nav_positions

	for i = 1, #on_nav_positions do
		positions[#positions + 1] = Vector3Box(on_nav_positions[i])
	end

	positions = self._fitting_positions

	for i = 1, #fitting_positions do
		positions[#positions + 1] = Vector3Box(fitting_positions[i])
	end

	positions = self._volume_positions

	for i = 1, #volume_positions do
		positions[#positions + 1] = Vector3Box(volume_positions[i])
	end
end

function RespawnBeacon:_unbox_positions()
	local Vector3Box_unbox = Vector3Box.unbox
	local positions = self._valid_positions
	local valid_positions = {}

	for i = 1, #positions do
		valid_positions[i] = Vector3Box_unbox(positions[i])
	end

	positions = self._on_nav_positions
	local on_nav_positions = {}

	for i = 1, #positions do
		on_nav_positions[i] = Vector3Box_unbox(positions[i])
	end

	positions = self._fitting_positions
	local fitting_positions = {}

	for i = 1, #positions do
		fitting_positions[i] = Vector3Box_unbox(positions[i])
	end

	positions = self._volume_positions
	local volume_positions = {}

	for i = 1, #positions do
		volume_positions[i] = Vector3Box_unbox(positions[i])
	end

	return valid_positions, on_nav_positions, fitting_positions, volume_positions
end

function RespawnBeacon:_reset_data()
	self._valid_positions = {}
	self._on_nav_positions = {}
	self._fitting_positions = {}
	self._volume_positions = {}
end

RespawnBeacon.component_data = {
	side = {
		value = "heroes",
		ui_type = "combo_box",
		ui_name = "Side",
		options_keys = {
			"Heroes",
			"Villains"
		},
		options_values = {
			"heroes",
			"villains"
		}
	},
	debug_ignore_check_distances = {
		ui_type = "check_box",
		value = false,
		ui_name = "Ignore Debug Check Distances"
	},
	extensions = {
		"RespawnBeaconExtension"
	}
}

return RespawnBeacon
