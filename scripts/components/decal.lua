local Decal = component("Decal")

function Decal:init(unit)
	local sort_order = self:get_data(unit, "sort_order")

	if sort_order ~= 0 then
		Unit.set_sort_order(unit, sort_order)
	end
end

function Decal:editor_validate(unit)
	return true, ""
end

function Decal:enable(unit)
	return
end

function Decal:disable(unit)
	return
end

function Decal:destroy(unit)
	return
end

Decal.component_data = {
	sort_order = {
		value = 0,
		min = 0,
		ui_type = "number",
		decimals = 0,
		ui_name = "Sort Order",
		max = 2900000
	}
}

return Decal
