local HideableAmmo = component("HideableAmmo")

function HideableAmmo:init(unit)
	self._unit = unit
	local start_hidden = self:get_data(unit, "start_hidden")
	self._use_random_rotation = self:get_data(unit, "use_random_rotation")

	if start_hidden then
		self:hide()
	else
		self:show()
	end
end

function HideableAmmo:enable(unit)
	return
end

function HideableAmmo:disable(unit)
	return
end

function HideableAmmo:destroy(unit)
	return
end

local TWO_PI = math.pi * 2

function HideableAmmo:show()
	if self._use_random_rotation then
		local random_rotation = Quaternion.axis_angle(Vector3.forward(), math.random() * TWO_PI)

		Unit.set_local_rotation(self._unit, 1, random_rotation)
	end

	Unit.set_unit_visibility(self._unit, true, true)
end

function HideableAmmo:hide()
	Unit.set_unit_visibility(self._unit, false, true)
end

HideableAmmo.component_data = {
	start_hidden = {
		ui_type = "check_box",
		value = false,
		ui_name = "Start Hidden"
	},
	use_random_rotation = {
		ui_type = "check_box",
		value = true,
		ui_name = "Use Random Rotation"
	}
}

return HideableAmmo
