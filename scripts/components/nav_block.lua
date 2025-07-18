local NavBlock = component("NavBlock")

function NavBlock:init(unit, is_server)
	self._is_server = is_server
	local nav_block_extension = ScriptUnit.fetch_component_extension(unit, "nav_block_system")

	if nav_block_extension then
		local start_blocked = self:get_data(unit, "start_blocked")
		local volume_name = self:get_data(unit, "volume_name")

		nav_block_extension:setup_from_component(unit, volume_name, start_blocked)

		self._nav_block_extension = nav_block_extension
		self._volume_name = volume_name
	end
end

function NavBlock:editor_validate(unit)
	local success = true
	local error_message = ""
	local volume_name = self:get_data(unit, "volume_name")

	if volume_name == "" then
		success = false
		error_message = error_message .. "\nVolume Name can't be empty"
	elseif rawget(_G, "LevelEditor") and not Unit.has_volume(unit, volume_name) then
		success = false
		error_message = error_message .. "\nMissing volume '" .. volume_name .. "'"
	end

	return success, error_message
end

function NavBlock:_set_block(val)
	local nav_block_extension = self._nav_block_extension

	if nav_block_extension and self._is_server then
		nav_block_extension:set_block(self._volume_name, val)
	end
end

function NavBlock:editor_init(unit)
	return
end

function NavBlock:enable(unit)
	return
end

function NavBlock:disable(unit)
	return
end

function NavBlock:destroy(unit)
	return
end

function NavBlock:block_nav()
	self:_set_block(true)
end

function NavBlock:unblock_nav()
	self:_set_block(false)
end

NavBlock.component_data = {
	start_blocked = {
		ui_type = "check_box",
		value = true,
		ui_name = "Start blocked"
	},
	volume_name = {
		ui_type = "text_box",
		value = "g_volume_block",
		ui_name = "Volume Name"
	},
	inputs = {
		block_nav = {
			accessibility = "public",
			type = "event"
		},
		unblock_nav = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"NavBlockExtension"
	}
}

return NavBlock
