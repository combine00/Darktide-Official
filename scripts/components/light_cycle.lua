local LightCycle = component("LightCycle")

function LightCycle:init(unit)
	if self:get_data(unit, "start_enabled") then
		self:start(unit)
	else
		self:stop(unit)
	end
end

function LightCycle:editor_init(unit)
	self:init(unit)
	self:editor_update_gizmo(unit)
end

function LightCycle:editor_property_changed(unit)
	self:editor_update_gizmo(unit)
end

function LightCycle:enable(unit)
	return
end

function LightCycle:disable(unit)
	return
end

function LightCycle:destroy(unit)
	return
end

function LightCycle:editor_validate(unit)
	return true, ""
end

function LightCycle:editor_update_gizmo(unit)
	local distance = self:get_data(unit, "distance")

	Unit.set_local_position(unit, Unit.node(unit, "g_gizmo_end"), Vector3(0, distance, 0))
end

function LightCycle:start(unit)
	local distance = self:get_data(unit, "distance")

	Unit.set_local_scale(unit, Unit.node(unit, "ap_scl_01"), Vector3(1, distance, 1))

	local speed = self:get_data(unit, "speed")
	local animation_speed = 1 / distance

	Unit.set_flow_variable(unit, "lua_anim_speed", animation_speed * speed)
	Unit.flow_event(unit, "lua_anim_play")
end

function LightCycle:stop(unit)
	Unit.set_local_scale(unit, Unit.node(unit, "ap_scl_01"), Vector3(1, 0.001, 1))
	Unit.flow_event(unit, "lua_anim_stop")
end

LightCycle.component_data = {
	distance = {
		ui_type = "slider",
		min = 0,
		step = 1,
		decimals = 1,
		value = 1,
		ui_name = "Distance (Meters)",
		max = 100
	},
	speed = {
		ui_type = "number",
		decimals = 1,
		value = 1,
		ui_name = "Speed (Meters per Second)",
		step = 1
	},
	start_enabled = {
		ui_type = "check_box",
		value = true,
		ui_name = "Start Enabled"
	},
	inputs = {
		start = {
			accessibility = "public",
			type = "event"
		},
		stop = {
			accessibility = "public",
			type = "event"
		}
	}
}

return LightCycle
