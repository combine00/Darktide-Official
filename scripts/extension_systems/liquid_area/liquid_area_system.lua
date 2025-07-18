require("scripts/extension_systems/liquid_area/liquid_area_extension")
require("scripts/extension_systems/liquid_area/husk_liquid_area_extension")

local LiquidAreaTemplates = require("scripts/settings/liquid_area/liquid_area_templates")
local LiquidAreaDrawer = require("scripts/extension_systems/liquid_area/liquid_area_drawer")
local Navigation = require("scripts/extension_systems/navigation/utilities/navigation")
local LiquidAreaSystem = class("LiquidAreaSystem", "ExtensionSystemBase")
local NAV_TAG_LAYER_COSTS = {}

function LiquidAreaSystem:init(...)
	LiquidAreaSystem.super.init(self, ...)

	self._liquid_paint_id = 0
	self._liquid_paint_id_to_unit_map = {}
	local drawers = {}

	for name, template in pairs(LiquidAreaTemplates) do
		if template.use_liquid_drawer then
			drawers[name] = LiquidAreaDrawer:new(self._world, template)
		end
	end

	self._drawers = drawers
end

function LiquidAreaSystem:update(context, dt, t)
	local listener_position_or_nil = nil
	local local_player = Managers.player:local_player(1)

	if local_player then
		local viewport_name = local_player.viewport_name
		local listener_pose = Managers.state.camera:listener_pose(viewport_name)
		listener_position_or_nil = Matrix4x4.translation(listener_pose)
	end

	LiquidAreaSystem.super.update(self, context, dt, t, listener_position_or_nil)
end

function LiquidAreaSystem:on_gameplay_post_init(level)
	if self._is_server then
		local traverse_logic, nav_tag_cost_table = Navigation.create_traverse_logic(self._nav_world, NAV_TAG_LAYER_COSTS, nil, false)
		self._nav_tag_cost_table = nav_tag_cost_table
		self._traverse_logic = traverse_logic
		self._extension_init_context.traverse_logic = traverse_logic
	else
		local traverse_logic = Managers.state.nav_mesh:client_traverse_logic()
		self._traverse_logic = traverse_logic
		self._extension_init_context.traverse_logic = traverse_logic
	end
end

function LiquidAreaSystem:on_add_extension(world, unit, extension_name, extension_init_data, ...)
	local extension = LiquidAreaSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data, ...)

	extension:set_drawer(self._drawers)

	local liquid_paint_id = extension_init_data.optional_liquid_paint_id

	if liquid_paint_id then
		if not self._liquid_paint_id_to_unit_map[liquid_paint_id] then
			self._liquid_paint_id_to_unit_map[liquid_paint_id] = {}
		end

		local unit_map = self._liquid_paint_id_to_unit_map[liquid_paint_id]
		unit_map[unit] = extension
	end

	return extension
end

function LiquidAreaSystem:on_remove_extension(unit, extension_name)
	if extension_name == "LiquidAreaExtension" then
		local extension = self._unit_to_extension_map[unit]
		local liquid_paint_id = extension:liquid_paint_id()

		if liquid_paint_id then
			local unit_map = self._liquid_paint_id_to_unit_map[liquid_paint_id]
			unit_map[unit] = nil
		end
	end

	LiquidAreaSystem.super.on_remove_extension(self, unit, extension_name)
end

function LiquidAreaSystem:destroy()
	for _, drawer in pairs(self._drawers) do
		drawer:delete()
	end

	if self._is_server and self._traverse_logic then
		GwNavTraverseLogic.destroy(self._traverse_logic)
		GwNavTagLayerCostTable.destroy(self._nav_tag_cost_table)
	end

	LiquidAreaSystem.super.destroy(self)
end

function LiquidAreaSystem:delete_units()
	if not self._is_server then
		return
	end

	local unit_spawner_manager = Managers.state.unit_spawner

	for unit, _ in pairs(self._unit_to_extension_map) do
		unit_spawner_manager:mark_for_deletion(unit)
	end
end

function LiquidAreaSystem:start_paint()
	self._liquid_paint_id = self._liquid_paint_id + 1

	return self._liquid_paint_id
end

function LiquidAreaSystem:stop_paint(liquid_paint_id)
	return
end

function LiquidAreaSystem:paint(liquid_paint_id, max_liquid_paint_distance, nav_mesh_position, optional_brush_size)
	local closest_liquid_unit, closest_liquid_extension = nil
	local closest_liquid_distance_sq = math.huge
	local max_liquid_paint_distance_sq = max_liquid_paint_distance * max_liquid_paint_distance
	local Vector3_distance_squared = Vector3.distance_squared
	local existing_liquid_units = self._liquid_paint_id_to_unit_map[liquid_paint_id]

	if existing_liquid_units then
		for unit, extension in pairs(existing_liquid_units) do
			local broadphase_center = extension:broadphase_center()
			local distance_sq = Vector3_distance_squared(broadphase_center, nav_mesh_position)

			if distance_sq < closest_liquid_distance_sq and distance_sq < max_liquid_paint_distance_sq then
				closest_liquid_extension = extension
				closest_liquid_unit = unit
				closest_liquid_distance_sq = distance_sq
			end
		end
	end

	if closest_liquid_extension then
		closest_liquid_extension:paint_liquid_at(nav_mesh_position, optional_brush_size)
	end

	return closest_liquid_unit
end

function LiquidAreaSystem:is_position_in_liquid(position)
	local result = false

	for _, extension in pairs(self._unit_to_extension_map) do
		result = extension:is_position_inside(position)

		if result then
			break
		end
	end

	return result
end

function LiquidAreaSystem:find_liquid_areas_in_position(position, results)
	for _, extension in pairs(self._unit_to_extension_map) do
		local is_inside = extension:is_position_inside(position)

		if is_inside then
			table.insert(results, extension)
		end
	end

	return results
end

function LiquidAreaSystem:traverse_logic()
	return self._traverse_logic
end

function LiquidAreaSystem:remove_any_cell_inside_of_radius(position, radius)
	for _, extension in pairs(self._unit_to_extension_map) do
		extension:remove_any_cell_inside_of_radius(position, radius)
	end
end

function LiquidAreaSystem:allow_nav_tag_layer(layer_name, layer_allowed)
	local layer_id = Managers.state.nav_mesh:nav_tag_layer_id(layer_name)
	local nav_tag_cost_table = self._nav_tag_cost_table

	if layer_allowed then
		GwNavTagLayerCostTable.allow_layer(nav_tag_cost_table, layer_id)
	else
		GwNavTagLayerCostTable.forbid_layer(nav_tag_cost_table, layer_id)
	end
end

function LiquidAreaSystem:is_traverse_logic_initialized()
	return self._traverse_logic ~= nil
end

return LiquidAreaSystem
