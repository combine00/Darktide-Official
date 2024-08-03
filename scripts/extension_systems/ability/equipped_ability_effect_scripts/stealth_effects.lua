local BuffSettings = require("scripts/settings/buff/buff_settings")
local keywords = BuffSettings.keywords
local INVISIBLE_MIN_FADE = 0.5
local DEFAULT_MIN_FADE = 0
local StealthEffects = class("StealthEffects")

function StealthEffects:init(context, ability_template)
	local unit = context.unit
	self._unit = unit
	self._fade_system = Managers.state.extension:system("fade_system")
	self._buff_extension = ScriptUnit.has_extension(unit, "buff_system")
	self._is_invisible = false
end

function StealthEffects:extensions_ready(world, unit)
	self._buff_extension = self._buff_extension or ScriptUnit.has_extension(unit, "buff_system")
end

function StealthEffects:destroy()
	self._fade_system:set_min_fade(self._unit, DEFAULT_MIN_FADE)
end

function StealthEffects:update(unit, dt, t)
	local buff_extension = self._buff_extension

	if not buff_extension then
		return
	end

	local is_invisible = buff_extension:has_keyword(keywords.invisible)
	local was_invisible = self._is_invisible

	if is_invisible ~= was_invisible then
		self._fade_system:set_min_fade(self._unit, is_invisible and INVISIBLE_MIN_FADE or DEFAULT_MIN_FADE)

		self._is_invisible = is_invisible
	end
end

return StealthEffects
