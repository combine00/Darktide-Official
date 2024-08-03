local ScannerDisplay = component("ScannerDisplay")

function ScannerDisplay:init(unit)
	local scanner_display_extension = ScriptUnit.fetch_component_extension(unit, "scanner_display_system")

	if scanner_display_extension then
		scanner_display_extension:setup_from_component()
	end
end

function ScannerDisplay:editor_init(unit)
	return
end

function ScannerDisplay:editor_validate(unit)
	return true, ""
end

function ScannerDisplay:enable(unit)
	return
end

function ScannerDisplay:disable(unit)
	return
end

function ScannerDisplay:destroy(unit)
	return
end

ScannerDisplay.component_data = {
	extensions = {
		"ScannerDisplayExtension"
	}
}

return ScannerDisplay
