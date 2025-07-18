local ScannerDisplayExtension = class("ScannerDisplayExtension")
local EMPTY_TABLE = {}

function ScannerDisplayExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._unit = unit
	self._view_name = "scanner_display_view"
	self._wwise_world = extension_init_context.wwise_world
end

function ScannerDisplayExtension:setup_from_component()
	return
end

function ScannerDisplayExtension:activate(device_owner_unit, interface_unit)
	local ui_manager = Managers.ui

	if ui_manager then
		self:_open_view(ui_manager, device_owner_unit, interface_unit)
	end
end

function ScannerDisplayExtension:deactivate()
	local ui_manager = Managers.ui

	if ui_manager then
		local view_name = self._view_name

		if ui_manager:view_active(view_name) then
			ui_manager:close_view(view_name)
		end
	end
end

function ScannerDisplayExtension:_open_view(ui_manager, device_owner_unit, interface_unit)
	local view_name = self._view_name
	local view_context = EMPTY_TABLE

	table.clear(view_context)

	view_context.wwise_world = self._wwise_world

	if interface_unit then
		local minigame_extension = ScriptUnit.extension(interface_unit, "minigame_system")
		view_context.device_owner_unit = device_owner_unit
		view_context.minigame_type = minigame_extension:minigame_type()
		view_context.minigame_extension = minigame_extension
	else
		view_context.device_owner_unit = device_owner_unit
		view_context.minigame_extension = nil
	end

	view_context.auspex_unit = self._unit

	ui_manager:open_view(view_name, nil, nil, nil, nil, view_context)
end

return ScannerDisplayExtension
