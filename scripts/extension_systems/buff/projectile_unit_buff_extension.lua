require("scripts/extension_systems/buff/buff_extension_base")

local Ailment = require("scripts/utilities/ailment")
local BuffExtensionInterface = require("scripts/extension_systems/buff/buff_extension_interface")
local BuffTemplates = require("scripts/settings/buff/buff_templates")
local BuffExtensionBase = require("scripts/extension_systems/buff/buff_extension_base")
local FixedFrame = require("scripts/utilities/fixed_frame")
local EMPTY_TABLE = {}
local ProjectileUnitBuffExtension = class("ProjectileUnitBuffExtension")

function ProjectileUnitBuffExtension:init(extension_init_context, unit, extension_init_data, game_object_data_or_game_session, nil_or_game_object_id)
	local owner_unit = extension_init_data.owner_unit
	self._owner_unit = owner_unit
	local is_server = extension_init_context.is_server
	self._is_server = is_server
	self._stat_buffs = extension_init_data.stat_buffs
	self._keywords = extension_init_data.keywords
end

function ProjectileUnitBuffExtension:hot_join_sync(unit, sender, channel)
	return
end

function ProjectileUnitBuffExtension:game_object_initialized(game_session, game_object_id)
	return
end

function ProjectileUnitBuffExtension:update(unit, dt, t)
	return
end

function ProjectileUnitBuffExtension:keywords()
	if not self._is_server then
		local exception_message = string.format("A non-server is trying to access keywords on a projectile")

		Log.exception("ProjectileUnitBuffExtension", exception_message)
	end

	return self._keywords
end

function ProjectileUnitBuffExtension:has_keyword(keyword)
	if not self._is_server then
		local exception_message = string.format("A non-server is trying to access keywords on a projectile")

		Log.exception("ProjectileUnitBuffExtension", exception_message)
	end

	return not not self._keywords[keyword]
end

function ProjectileUnitBuffExtension:stat_buffs()
	if not self._is_server then
		local exception_message = string.format("A non-server is trying to access stat buffs on a projectile")

		Log.exception("ProjectileUnitBuffExtension", exception_message)
	end

	return self._stat_buffs
end

function ProjectileUnitBuffExtension:buffs()
	return EMPTY_TABLE
end

function ProjectileUnitBuffExtension:refresh_duration_of_stacking_buff(buff_name, t)
	return
end

function ProjectileUnitBuffExtension:is_frame_unique_proc(event, unique_key)
	return
end

function ProjectileUnitBuffExtension:current_stacks(buff_name)
	return
end

function ProjectileUnitBuffExtension:request_proc_event_param_table()
	return nil
end

function ProjectileUnitBuffExtension:set_frame_unique_proc(event, unique_key)
	ferror("ProjectileUnitBuffExtension can't proc but triggered set_frame_unique_proc on %s, %s", event, unique_key)
end

function ProjectileUnitBuffExtension:add_proc_event(event, params)
	ferror("ProjectileUnitBuffExtension can't proc but triggered proc event %s", event)
end

function ProjectileUnitBuffExtension:add_internally_controlled_buff(template_name, t, ...)
	ferror("Can't add buffs to ProjectileUnitBuffExtension, tried to add buff %s", template_name)
end

function ProjectileUnitBuffExtension:add_externally_controlled_buff(template_name, t, ...)
	ferror("Can't add buffs to ProjectileUnitBuffExtension, tried to add buff %s", template_name)
end

function ProjectileUnitBuffExtension:remove_externally_controlled_buff(local_index)
	ferror("Can't remove buffs to ProjectileUnitBuffExtension but tried to remove buff with local index %d", local_index)
end

function ProjectileUnitBuffExtension:_remove_internally_controlled_buff(local_index)
	ferror("Can't remove buffs to ProjectileUnitBuffExtension but tried to remove buff with local index %d", local_index)
end

function ProjectileUnitBuffExtension:_remove_buff(index)
	ferror("Can't remove buffs to ProjectileUnitBuffExtension but tried to remove buff with index %d", index)
end

function ProjectileUnitBuffExtension:rpc_add_buff(...)
	ferror("Can't add buffs to ProjectileUnitBuffExtension, but tried to add buffs troguh rpc")
end

function ProjectileUnitBuffExtension:rpc_remove_buff(...)
	ferror("Can't remove buffs to ProjectileUnitBuffExtension, but tried to remove buffs troguh rpc")
end

function ProjectileUnitBuffExtension:rpc_buff_proc_set_active_time(...)
	ferror("ProjectileUnitBuffExtension can't activate a buff")
end

function ProjectileUnitBuffExtension:rpc_buff_set_start_time(channel_id, game_object_id, server_index, activation_frame)
	ferror("ProjectileUnitBuffExtension can't start a buff")
end

implements(ProjectileUnitBuffExtension, BuffExtensionInterface)

return ProjectileUnitBuffExtension
