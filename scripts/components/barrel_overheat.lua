local BarrelOverheat = component("BarrelOverheat")
local BARREL_OVERHEAT_MATERIAL_VARIABLE = "overheat"

function BarrelOverheat:editor_validate(unit)
	return true, ""
end

function BarrelOverheat:init(unit)
	self:enable(unit)

	self._unit = unit
	self._overheat_min = self:get_data(unit, "overheat_min")
	self._overheat_max = self:get_data(unit, "overheat_max")

	self:_set_barrel_overheat(0)
end

function BarrelOverheat:_set_barrel_overheat(value)
	local overheat_value = math.lerp(self._overheat_min, self._overheat_max, value)

	Unit.set_scalar_for_materials(self._unit, BARREL_OVERHEAT_MATERIAL_VARIABLE, overheat_value, true)
end

function BarrelOverheat:enable(unit)
	return
end

function BarrelOverheat:disable(unit)
	return
end

function BarrelOverheat:destroy(unit)
	return
end

function BarrelOverheat.events:set_barrel_overheat(value)
	if self._set_barrel_overheat then
		self:_set_barrel_overheat(value)
	end
end

BarrelOverheat.component_data = {
	overheat_min = {
		ui_type = "slider",
		min = 0,
		step = 0.01,
		decimals = 2,
		value = 0,
		ui_name = "Blur min",
		max = 3
	},
	overheat_max = {
		ui_type = "slider",
		min = 0,
		step = 0.01,
		decimals = 2,
		value = 1,
		ui_name = "Blur max",
		max = 1
	},
	inputs = {
		set_barrel_overheat = {
			accessibility = "public",
			type = "event"
		}
	}
}

return BarrelOverheat
