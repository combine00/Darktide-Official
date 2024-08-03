local MainFlowCallbacks = require("scripts/script_flow_nodes/flow_callbacks")
UIFlowCallbacks = UIFlowCallbacks or {}
local flow_return_table = {}
local flow_callback_white_list = {
	"get_component_data",
	"set_component_data",
	"trigger_lua_unit_event",
	"trigger_lua_string_event",
	"local_player_level_larger_than"
}

for function_name, func in pairs(MainFlowCallbacks) do
	if not table.find(flow_callback_white_list, function_name) then
		UIFlowCallbacks[function_name] = function ()
			return
		end
	else
		UIFlowCallbacks[function_name] = func
	end
end

function UIFlowCallbacks.clear_return_value()
	table.clear(flow_return_table)
end

function UIFlowCallbacks.player_voice(params)
	return
end

function UIFlowCallbacks.player_fx(params)
	return
end

function UIFlowCallbacks.player_footstep(params)
	return
end

function UIFlowCallbacks.player_material_fx(params)
	return
end

function UIFlowCallbacks.enable_script_component(params)
	local guid = params.guid
	local unit = params.unit
	local world = Application.flow_callback_context_world()
	local extension_manager = Managers.ui:world_extension_manager(world)
	local component_system = extension_manager:system("component_system")

	component_system:enable_component(unit, guid)
end

function UIFlowCallbacks.disable_script_component(params)
	local guid = params.guid
	local unit = params.unit
	local world = Application.flow_callback_context_world()
	local extension_manager = Managers.ui:world_extension_manager(world)
	local component_system = extension_manager:system("component_system")

	component_system:disable_component(unit, guid)
end

function UIFlowCallbacks.call_script_component(params)
	local guid = params.guid
	local unit = params.unit
	local function_name = params.event
	local world = Application.flow_callback_context_world()
	local extension_manager = Managers.ui:world_extension_manager(world)
	local component_system = extension_manager:system("component_system")

	component_system:flow_call_component(unit, guid, function_name)
end

function UIFlowCallbacks.register_extensions(params)
	local unit = params.unit
	local world = Application.flow_callback_context_world()
	local extension_manager = Managers.ui:world_extension_manager(world)

	extension_manager:register_unit(world, unit, "flow_spawned")
end

function UIFlowCallbacks.delete_extension_registered_unit(params)
	local unit = params.unit
	local world = Application.flow_callback_context_world()
	local extension_manager = Managers.ui:world_extension_manager(world)

	Unit.flow_event(unit, "cleanup_before_destroy")
	Unit.flow_event(unit, "unit_despawned")
	extension_manager:unregister_unit(unit)
	World.destroy_unit(world, unit)
end

function UIFlowCallbacks.spawn_unit(params)
	return
end

function UIFlowCallbacks.unspawn_unit(params)
	return
end

return UIFlowCallbacks
