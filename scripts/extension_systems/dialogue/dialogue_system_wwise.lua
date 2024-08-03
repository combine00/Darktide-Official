local DialogueSystemWwise = class("DialogueSystemWwise")

function DialogueSystemWwise:init(world)
	self._wwise_world = Managers.world:wwise_world(world)
end

function DialogueSystemWwise:make_unit_auto_source(unit, node_id)
	local source = nil

	if node_id then
		source = WwiseWorld.make_auto_source(self._wwise_world, unit, node_id)
	else
		source = WwiseWorld.make_auto_source(self._wwise_world, unit)
	end

	return source
end

function DialogueSystemWwise:trigger_resource_external_event(sound_event, sound_source, file_path, file_format, wwise_source_id)
	return WwiseWorld.trigger_resource_external_event(self._wwise_world, sound_event, sound_source, file_path, file_format, wwise_source_id)
end

function DialogueSystemWwise:trigger_vorbis_external_event(sound_event, sound_source, file_path, wwise_source_id)
	return WwiseWorld.trigger_resource_external_event(self._wwise_world, sound_event, sound_source, file_path, 4, wwise_source_id)
end

function DialogueSystemWwise:trigger_resource_event(wwise_event_name, unit_or_source_id)
	return WwiseWorld.trigger_resource_event(self._wwise_world, wwise_event_name, unit_or_source_id)
end

function DialogueSystemWwise:set_switch_and_vo_center(source_id, switch_group, switch_value, vo_center_percent)
	WwiseWorld.set_switch(self._wwise_world, switch_group, switch_value, source_id)
	WwiseWorld.set_source_parameter(self._wwise_world, source_id, "vo_center_percent", vo_center_percent)
end

function DialogueSystemWwise:is_playing(event_id)
	return WwiseWorld.is_playing(self._wwise_world, event_id)
end

function DialogueSystemWwise:has_event(event_id)
	return Wwise.has_event(event_id)
end

function DialogueSystemWwise:stop_if_playing(event_id)
	local is_playing = WwiseWorld.is_playing(self._wwise_world, event_id)

	if is_playing then
		WwiseWorld.stop_event(self._wwise_world, event_id)
	end
end

function DialogueSystemWwise:set_switch(source_id, switch_group, value)
	WwiseWorld.set_switch(self._wwise_world, switch_group, value, source_id)
end

return DialogueSystemWwise
