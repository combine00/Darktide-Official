local PropOutline = component("PropOutline")

function PropOutline:init(unit)
	return
end

function PropOutline:editor_validate(unit)
	return true, ""
end

function PropOutline:enable(unit)
	return
end

function PropOutline:disable(unit)
	return
end

function PropOutline:destroy(unit)
	return
end

PropOutline.component_data = {
	extensions = {
		"PropOutlineExtension"
	}
}

return PropOutline
