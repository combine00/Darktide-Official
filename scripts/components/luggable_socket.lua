local LuggableSocket = component("LuggableSocket")

function LuggableSocket:init(unit)
	self:enable(unit)

	local luggable_socket_extension = ScriptUnit.fetch_component_extension(unit, "luggable_socket_system")

	if luggable_socket_extension then
		local consume_luggable = self:get_data(unit, "consume_luggable")
		local is_side_mission_socket = self:get_data(unit, "is_side_mission_socket")
		local lock_offset_node = self:get_data(unit, "lock_offset_node")

		if lock_offset_node == "" then
			lock_offset_node = nil
		end

		luggable_socket_extension:setup_from_component(consume_luggable, is_side_mission_socket, lock_offset_node)
	end
end

function LuggableSocket:editor_init(unit)
	self:enable(unit)
end

function LuggableSocket:editor_validate(unit)
	local success = true
	local error_message = ""

	if rawget(_G, "LevelEditor") then
		if Unit.find_actor(unit, "g_slot") == nil then
			success = false
			error_message = error_message .. "\nCouldn't find actor 'g_slot'"
		end

		if not Unit.has_visibility_group(unit, "main") then
			success = false
			error_message = error_message .. "\nCouldn't find visibility group 'main'"
		end
	end

	return success, error_message
end

function LuggableSocket:enable(unit)
	return
end

function LuggableSocket:disable(unit)
	return
end

function LuggableSocket:destroy(unit)
	return
end

LuggableSocket.component_data = {
	consume_luggable = {
		ui_type = "check_box",
		value = false,
		ui_name = "Consume Luggable"
	},
	is_side_mission_socket = {
		ui_type = "check_box",
		value = false,
		ui_name = "Is Side Mission Socket",
		category = "Side Mission"
	},
	lock_offset_node = {
		ui_type = "text_box",
		value = "",
		ui_name = "Lock Offset Node"
	},
	extensions = {
		"LuggableSocketExtension"
	}
}

return LuggableSocket
