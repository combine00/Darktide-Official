local PlayerUnitData = require("scripts/extension_systems/unit_data/utilities/player_unit_data")
local WieldableSlotScriptInterface = require("scripts/extension_systems/visual_loadout/wieldable_slot_scripts/wieldable_slot_script_interface")
local AuspexEffects = class("AuspexEffects")
local LOOPING_SOUND_ALIAS = "sfx_minigame_loop"
local FX_SOURCE_NAME = "_speaker"
local WWISE_PARAMETER_NAME = "auspex_scanner_speed"
local PARAMETER_VALUE = 2

function AuspexEffects:init(context, slot, weapon_template, fx_sources, item, unit_1p, unit_3p)
	local is_husk = context.is_husk
	local owner_unit = context.owner_unit
	self._wwise_world = context.wwise_world
	self._fx_source_name = fx_sources[FX_SOURCE_NAME]
	self._is_husk = is_husk
	self._fx_extension = ScriptUnit.extension(owner_unit, "fx_system")
	local unit_data_extension = ScriptUnit.extension(owner_unit, "unit_data_system")
end

function AuspexEffects:destroy()
	return
end

function AuspexEffects:_run_looping_sound(fixed_frame)
	local fx_extension = self._fx_extension
	local fx_source_name = self._fx_source_name
	local fx_source = self._fx_extension:sound_source(fx_source_name)

	if not fx_extension:is_looping_sound_playing(LOOPING_SOUND_ALIAS) then
		WwiseWorld.set_source_parameter(self._wwise_world, fx_source, WWISE_PARAMETER_NAME, PARAMETER_VALUE)
	end

	fx_extension:run_looping_sound(LOOPING_SOUND_ALIAS, fx_source_name, nil, fixed_frame)
end

function AuspexEffects:wield()
	if self._is_husk then
		return
	end

	self._play_looping_sfx = true
end

function AuspexEffects:unwield()
	if self._is_husk then
		return
	end

	self._play_looping_sfx = false
end

function AuspexEffects:fixed_update(unit, dt, t, frame)
	if self._is_husk then
		return
	end

	if self._play_looping_sfx then
		self:_run_looping_sound(frame)
	end
end

function AuspexEffects:update(unit, dt, t)
	return
end

function AuspexEffects:update_first_person_mode(first_person_mode)
	return
end

implements(AuspexEffects, WieldableSlotScriptInterface)

return AuspexEffects
