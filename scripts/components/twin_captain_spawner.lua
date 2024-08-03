local TwinCaptainSpawner = component("TwinCaptainSpawner")

function TwinCaptainSpawner:init(unit, is_server, nav_world)
	self._unit = unit
	local run_update = false

	return run_update
end

function TwinCaptainSpawner:destroy(unit)
	return
end

function TwinCaptainSpawner:enable(unit)
	return
end

function TwinCaptainSpawner:disable(unit)
	return
end

function TwinCaptainSpawner:editor_init(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	return true
end

function TwinCaptainSpawner:editor_validate(unit)
	return true, ""
end

function TwinCaptainSpawner:editor_destroy(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end
end

function TwinCaptainSpawner:editor_update(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end

	return true
end

function TwinCaptainSpawner:editor_property_changed(unit)
	if not rawget(_G, "LevelEditor") then
		return
	end
end

function TwinCaptainSpawner:_editor_debug_draw(unit)
	return
end

TwinCaptainSpawner.component_data = {
	id = {
		ui_type = "number",
		min = 1,
		step = 1,
		category = "Circumstance Gameplay Data",
		value = 1,
		ui_name = "ID",
		max = 100
	},
	section = {
		ui_type = "number",
		min = 1,
		step = 1,
		category = "Circumstance Gameplay Data",
		value = 1,
		ui_name = "Section ID",
		max = 50
	},
	twin_id = {
		ui_type = "number",
		min = 1,
		step = 1,
		category = "Circumstance Gameplay Data",
		value = 1,
		ui_name = "Twin ID",
		max = 2
	}
}

return TwinCaptainSpawner
