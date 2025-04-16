local ActionInputHierarchy = {}

function ActionInputHierarchy.update_hierarchy_entry(hierarchy, target_input, new_transition)
	local target_index = nil

	for i, entry in ipairs(hierarchy) do
		if entry.input == target_input then
			target_index = i

			break
		end
	end

	local new_entry = {
		input = target_input,
		transition = new_transition
	}

	if target_index then
		hierarchy[target_index] = new_entry
	else
		table.insert(hierarchy, #hierarchy + 1, new_entry)
	end
end

function ActionInputHierarchy.find_hierarchy_transition(hierarchy, action_input)
	for _, entry in ipairs(hierarchy) do
		if entry.input == action_input then
			return entry.transition
		end
	end

	return nil
end

function ActionInputHierarchy.find_hierarchy_entry(hierarchy, action_input)
	for _, entry in ipairs(hierarchy) do
		if entry.input == action_input then
			return entry
		end
	end

	return nil
end

function ActionInputHierarchy.add_missing_ordered(dest, source)
	local existing_keys = {}

	for _, entry in ipairs(dest) do
		existing_keys[entry.input] = true
	end

	for _, entry in ipairs(source) do
		if not existing_keys[entry.input] then
			table.insert(dest, entry)
		end
	end

	return dest
end

return ActionInputHierarchy
