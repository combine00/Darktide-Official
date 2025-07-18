local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local screen_ratio = UIWorkspaceSettings.screen.size[1] / UIWorkspaceSettings.screen.size[2]
local symbols_spacing = 40
local symbols_widget_size = {
	screen_ratio * 100,
	100
}
local cursor_widget_size = {
	screen_ratio * 105,
	105
}
local scanner_display_view_defuse_settings = {
	stages_starting_offset_x = 260,
	target_starting_offset_x = -650,
	option_starting_offset_y = -178,
	stages_starting_offset_y = 300,
	stage_spacing = 30,
	option_starting_offset_x = 0,
	target_starting_offset_y = 0,
	symbol_spacing = symbols_spacing,
	symbol_widget_size = symbols_widget_size,
	cursor_widget_size = cursor_widget_size
}

return settings("ScannerDisplayViewDefuseSettings", scanner_display_view_defuse_settings)
