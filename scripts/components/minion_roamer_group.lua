local MinionRoamerGroup = component("MinionRoamerGroup")

function MinionRoamerGroup:init(unit)
	Managers.state.main_path:add_group_location(unit)
end

function MinionRoamerGroup:editor_init()
	return
end

function MinionRoamerGroup:enable(unit)
	return
end

function MinionRoamerGroup:disable(unit)
	return
end

function MinionRoamerGroup:destroy(unit)
	return
end

function MinionRoamerGroup:editor_validate(unit)
	local success = true
	local error_message = ""

	return success, error_message
end

MinionRoamerGroup.component_data = {}

return MinionRoamerGroup
