local window_size = {
	1400,
	500
}
local image_size = {
	window_size[1] * 0.5,
	window_size[2] + 200
}
local content_size = {
	window_size[1] * 0.5,
	window_size[2]
}
local masteries_overview_view = {
	window_size = window_size,
	image_size = image_size,
	content_size = content_size
}

return settings("MasteriesOverviewViewSettings", masteries_overview_view)
