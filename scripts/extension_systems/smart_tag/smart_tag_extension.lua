local BuffSettings = require("scripts/settings/buff/buff_settings")
local SmartTag = require("scripts/extension_systems/smart_tag/smart_tag")
local SmartTagSettings = require("scripts/settings/smart_tag/smart_tag_settings")
local buff_keywords = BuffSettings.keywords
local smart_tag_templates = SmartTagSettings.templates
local SmartTagExtension = class("SmartTagExtension")

function SmartTagExtension:init(extension_init_context, unit, extension_init_data, ...)
	self._unit = unit
	self._is_server = extension_init_context.is_server
	local target_type = extension_init_data.target_type

	if target_type then
		self._target_type = target_type

		Unit.set_data(unit, "smart_tag_target_type", target_type)

		self._target_actor = Unit.actor(unit, "smart_tagging")
		self._auto_tag_on_spawn = extension_init_data.auto_tag_on_spawn
		self._origin_player = extension_init_data.origin_player
	end

	self._owned_tag_ids = {}
	self._tag_id = nil
	self._display_name = nil
	self._replied_tag_ids = {}
end

function SmartTagExtension:setup_from_component(target_type)
	if target_type then
		self._target_type = target_type

		Unit.set_data(self._unit, "smart_tag_target_type", target_type)

		self._target_actor = Unit.actor(self._unit, "smart_tagging")
	end
end

function SmartTagExtension:destroy()
	self._unit = nil
	self._owned_tag_ids = nil
	self._tag_id = nil
	self._replied_tag_ids = nil
end

function SmartTagExtension:extensions_ready(world, unit)
	if self._target_type then
		self:_setup_display_name(unit)
	end
end

function SmartTagExtension:game_object_initialized(session, object_id)
	if self._is_server and self._auto_tag_on_spawn then
		self:_set_tag_on_spawn()
	end
end

function SmartTagExtension:_set_tag_on_spawn()
	local player = self._origin_player
	local player_unit = player and player.player_unit
	local tagger_unit = ALIVE[player_unit] and player_unit
	local tag_template = self:contextual_tag_template(tagger_unit)

	if tag_template then
		local target_unit = self._unit
		local target_location = nil
		local smart_tag_system = Managers.state.extension:system("smart_tag_system")

		smart_tag_system:set_tag(tag_template.name, tagger_unit, target_unit, target_location)
	end
end

function SmartTagExtension:_setup_display_name(unit)
	local target_type = self._target_type

	if target_type == "pickup" or target_type == "health_station" then
		local interactee_extension = ScriptUnit.has_extension(unit, "interactee_system")

		if interactee_extension then
			self._display_name = interactee_extension:description()
		end
	elseif target_type == "breed" then
		local unit_data_extension = ScriptUnit.extension(unit, "unit_data_system")
		local breed = unit_data_extension:breed()
		self._breed = breed
		self._display_name = breed.display_name
	end
end

function SmartTagExtension:can_tag(tagger_unit, alternate)
	local template_name = self:_contextual_tag_template_name(tagger_unit, alternate)

	return template_name ~= nil
end

function SmartTagExtension:contextual_tag_template(tagger_unit, alternate)
	local template_name = self:_contextual_tag_template_name(tagger_unit, alternate)
	local template = template_name and smart_tag_templates[template_name]

	return template
end

local _pickup_name_to_tag_template_name = {
	medical_crate_deployable = "deployed_medical_crate_over_here",
	large_metal = "large_metal_pickup_over_here",
	large_clip = "large_clip_over_here",
	small_platinum = "small_platinum_pickup_over_here",
	small_grenade = "small_grenade_over_here",
	control_rod_01_luggable = "luggable_control_rod_over_here",
	consumable = "side_mission_consumable_over_here",
	battery_02_luggable = "luggable_battery_over_here",
	syringe_ability_boost_pocketable = "syringe_ability_boost_over_here",
	syringe_corruption_pocketable = "syringe_corruption_over_here",
	small_metal = "small_metal_pickup_over_here",
	container_02_luggable = "luggable_container_over_here",
	container_01_luggable = "luggable_container_over_here",
	communications_hack_device = "side_mission_communication_device_over_here",
	grimoire = "side_mission_grimoire_over_here",
	large_platinum = "large_platinum_pickup_over_here",
	syringe_speed_boost_pocketable = "syringe_speed_boost_over_here",
	small_clip = "small_clip_over_here",
	container_03_luggable = "luggable_container_over_here",
	ammo_cache_pocketable = "pocketable_ammo_cache_over_here",
	battery_01_luggable = "luggable_battery_over_here",
	medical_crate_pocketable = "pocketable_medical_crate_over_here",
	tome = "side_mission_tome_over_here",
	ammo_cache_deployable = "deployed_ammo_cache_over_here",
	syringe_power_boost_pocketable = "syringe_power_boost_over_here"
}

function SmartTagExtension:_contextual_tag_template_name(tagger_unit, alternate)
	local target_type = self._target_type

	if not target_type then
		return nil
	end

	local unit = self._unit

	if tagger_unit == unit then
		return nil
	end

	local is_valid, _ = SmartTag.validate_target_unit(unit)

	if not is_valid then
		return nil
	end

	if target_type == "pickup" then
		local pickup_name = Unit.get_data(unit, "pickup_type")
		local template_name = _pickup_name_to_tag_template_name[pickup_name]

		if template_name then
			return template_name
		end
	elseif target_type == "medical_crate_deployable" then
		return "deployed_medical_crate_over_here"
	elseif target_type == "breed" then
		local side_system = Managers.state.extension:system("side_system")

		if side_system:is_enemy(tagger_unit, unit) then
			local buff_extension = ScriptUnit.has_extension(tagger_unit, "buff_system")
			local veteran_tag = buff_extension and buff_extension:has_keyword(buff_keywords.veteran_tag)

			if veteran_tag then
				return "enemy_over_here_veteran"
			end

			local companion_order = alternate

			if companion_order then
				local companion_spawner_extension = ScriptUnit.has_extension(tagger_unit, "companion_spawner_system")
				local has_companion = companion_spawner_extension and companion_spawner_extension:should_have_companion()

				if has_companion then
					return "enemy_companion_target"
				end

				return nil
			end

			return "enemy_over_here"
		end
	elseif target_type == "health_station" then
		local health_station_extension = ScriptUnit.extension(unit, "health_station_system")
		local has_battery = health_station_extension:battery_in_slot()

		if has_battery then
			return "health_station_over_here"
		else
			return "health_station_without_battery_over_here"
		end
	end
end

function SmartTagExtension:register_owned_tag(tag_id)
	local owned_tag_ids = self._owned_tag_ids
	owned_tag_ids[#owned_tag_ids + 1] = tag_id
end

function SmartTagExtension:unregister_owned_tag(tag_id)
	local owned_tag_ids = self._owned_tag_ids
	local remove_index = table.index_of(owned_tag_ids, tag_id)

	table.remove(owned_tag_ids, remove_index)
end

function SmartTagExtension:owned_tag_ids()
	return self._owned_tag_ids
end

function SmartTagExtension:register_tag(tag_id)
	self._tag_id = tag_id
end

function SmartTagExtension:unregister_tag(tag_id)
	if not tag_id or self._tag_id == tag_id then
		self._tag_id = nil
	end
end

function SmartTagExtension:display_name(tagger_unit)
	if self._display_name then
		return self._display_name
	end

	local template = self:contextual_tag_template(tagger_unit)

	return template and template.display_name or "n/a"
end

function SmartTagExtension:register_reply(tag_id)
	self._replied_tag_ids[tag_id] = true
end

function SmartTagExtension:unregister_reply(tag_id)
	self._replied_tag_ids[tag_id] = nil
end

function SmartTagExtension:replied_tag_ids()
	return self._replied_tag_ids
end

function SmartTagExtension:tag_id()
	return self._tag_id
end

function SmartTagExtension:target_actor()
	return self._target_actor
end

return SmartTagExtension
