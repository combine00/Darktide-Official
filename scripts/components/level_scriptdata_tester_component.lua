local LevelScriptdataTesterComponent = component("LevelScriptdataTesterComponent")

function LevelScriptdataTesterComponent:init(unit)
	self:enable(unit)
end

function LevelScriptdataTesterComponent:editor_init(unit)
	self:enable(unit)
end

local function get_neighbour_data_as_table(level, ...)
	local i = 1
	local data = {}

	while Level.has_data(level, ..., i) do
		local d = {
			level = Level.get_data(level, ..., i, "level"),
			state = Level.get_data(level, ..., i, "state")
		}
		data[i] = d
		i = i + 1
	end

	return data
end

function LevelScriptdataTesterComponent:editor_validate(unit)
	return true, ""
end

function LevelScriptdataTesterComponent:enable(unit)
	return
end

function LevelScriptdataTesterComponent:disable(unit)
	return
end

function LevelScriptdataTesterComponent:destroy(unit)
	return
end

LevelScriptdataTesterComponent.component_data = {}
