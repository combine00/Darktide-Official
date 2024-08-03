local DeployableDeviceEffects = class("DeployableDeviceEffects")
local FX_SOURCE_NAME = "_source"
local SFX_STOP_ALIAS = "sfx_device_stop"

function DeployableDeviceEffects:init(context, slot, weapon_template, fx_sources)
	local owner_unit = context.owner_unit
	self._wwise_world = context.wwise_world
	self._fx_source_name = fx_sources[FX_SOURCE_NAME]
	self._fx_extension = ScriptUnit.extension(owner_unit, "fx_system")
	self._visual_loadout_extension = ScriptUnit.extension(owner_unit, "visual_loadout_system")
end

function DeployableDeviceEffects:destroy()
	return
end

function DeployableDeviceEffects:wield()
	return
end

function DeployableDeviceEffects:unwield()
	self._fx_extension:trigger_gear_wwise_event_with_source(SFX_STOP_ALIAS, true, self._fx_source_name, true)
end

function DeployableDeviceEffects:fixed_update(unit, dt, t, frame)
	return
end

function DeployableDeviceEffects:update(unit, dt, t)
	return
end

function DeployableDeviceEffects:update_first_person_mode(first_person_mode)
	return
end

return DeployableDeviceEffects
