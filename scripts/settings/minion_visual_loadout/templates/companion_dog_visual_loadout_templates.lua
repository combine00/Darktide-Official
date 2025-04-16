local templates = {
	companion_dog = {}
}
local base_template = {
	slots = {}
}
local default_1 = table.clone(base_template)
templates.companion_dog.default = {
	default_1
}

return templates
