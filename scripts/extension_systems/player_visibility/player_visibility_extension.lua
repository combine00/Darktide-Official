local PlayerVisibilityExtension = class("PlayerVisibilityExtension")

function PlayerVisibilityExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._is_visible = true
	self._unit = unit
	self._first_person_unit = nil
	self._unit_tbl = {
		unit
	}
	local first_person_extension = ScriptUnit.has_extension(unit, "first_person_system")

	if first_person_extension then
		self._first_person_unit = first_person_extension:first_person_unit()
		self._first_person_unit_tbl = {
			self._first_person_unit
		}
	end
end

local function _set_player_companion_visibility(player_unit, visibility)
	local companion_spawner_extension = ScriptUnit.has_extension(player_unit, "companion_spawner_system")
	local companion_unit = companion_spawner_extension and companion_spawner_extension:companion_unit()

	if companion_unit and ALIVE[companion_unit] then
		Unit.set_unit_visibility(companion_unit, visibility, true)
	end
end

function PlayerVisibilityExtension:visible()
	return self._is_visible
end

function PlayerVisibilityExtension:hide()
	if self._is_visible then
		self:_take_snapshot()
		Unit.set_unit_visibility(self._unit, false, true)

		if self._first_person_unit then
			Unit.set_unit_visibility(self._first_person_unit, false, true)
		end

		_set_player_companion_visibility(self._unit, false)

		self._is_visible = false
	end
end

function PlayerVisibilityExtension:show()
	if not self._is_visible then
		self:_restore_snapshot()
		_set_player_companion_visibility(self._unit, true)

		self._is_visible = true
	end
end

function PlayerVisibilityExtension:_take_snapshot()
	Unit.take_visibility_snapshot(self._unit_tbl)

	if self._first_person_unit then
		Unit.take_visibility_snapshot(self._first_person_unit_tbl)
	end
end

function PlayerVisibilityExtension:_restore_snapshot()
	Unit.restore_visibility_snapshot(self._unit_tbl)

	if self._first_person_unit then
		Unit.restore_visibility_snapshot(self._first_person_unit_tbl)
	end
end

function PlayerVisibilityExtension:update_visibility_snapshot()
	if not self._is_visible then
		self:show()
		self:hide()
	end
end

return PlayerVisibilityExtension
