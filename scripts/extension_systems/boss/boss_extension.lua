local BossExtension = class("BossExtension")
local BossNameTemplates = require("scripts/settings/boss/boss_name_templates")
local _setup_twins_special_names = nil

function BossExtension:init(extension_init_context, unit, extension_init_data, game_session, game_object_id)
	self._unit = unit
	local seed = extension_init_data.seed
	self._seed = seed
	local breed = extension_init_data.breed
	self._breed = breed
	self._is_server = extension_init_context.is_server
	self._nav_world = extension_init_context.nav_world
	self._physics_world = extension_init_context.physics_world
	self._world = extension_init_context.world
	self._wwise_world = extension_init_context.wwise_world
	self._boss_encounter_started = false

	self:_generate_display_name()

	local boss_template = breed.boss_template

	if not self._is_server and boss_template then
		self:_start_boss_template(boss_template)
	end

	Managers.event:register(self, "event_player_hud_created", "_event_player_hud_created")
end

function BossExtension:game_object_initialized(session, object_id)
	local breed = self._breed
	local boss_template = breed.boss_template

	if boss_template then
		self:_start_boss_template(boss_template)
	end

	self._game_object_id = object_id
end

function BossExtension:extensions_ready()
	local breed = self._breed

	if not breed.trigger_boss_health_bar_on_aggro and not breed.trigger_boss_health_bar_on_damaged and not breed.boss_health_bar_disabled then
		self:start_boss_encounter()
	end

	local health_extension = ScriptUnit.extension(self._unit, "health_system")
	local max_health = health_extension:max_health()
	local breed_name = ScriptUnit.extension(self._unit, "unit_data_system"):breed().name
	local initial_max_health = Managers.state.difficulty:get_minion_max_health(breed_name)

	if max_health < initial_max_health then
		self._is_weakened = true
	end
end

function BossExtension:hot_join_sync(unit, sender, channel_id)
	if self._boss_encounter_started then
		RPC.rpc_start_boss_encounter(channel_id, self._game_object_id)
	end
end

function BossExtension:_event_player_hud_created(player)
	if self._boss_encounter_started then
		self:start_boss_encounter()
	end
end

function BossExtension:update(unit, dt, t)
	local boss_template = self._boss_template

	if boss_template then
		boss_template.update(self._template_data, self._template_context, dt, t)
	end

	if self._start_boss_encounter then
		Managers.event:trigger("boss_encounter_start", self._unit, self)

		self._boss_encounter_started = true
		self._start_boss_encounter = nil
	end
end

function BossExtension:destroy()
	Managers.event:trigger("boss_encounter_end", self._unit, self)

	local boss_template = self._boss_template

	if boss_template then
		boss_template.stop(self._template_data, self._template_context)
	end

	Managers.event:unregister(self, "event_player_hud_created")
end

function BossExtension:damaged()
	if self._first_damaged_at == nil then
		self._first_damaged_at = Managers.time:time("main")
		local breed = self._breed

		if breed.trigger_boss_health_bar_on_damaged and not breed.boss_health_bar_disabled then
			self:start_boss_encounter()

			if self._is_server then
				Managers.state.game_session:send_rpc_clients("rpc_start_boss_encounter", self._game_object_id)
			end
		end
	end
end

function BossExtension:time_since_first_damage()
	if self._first_damaged_at ~= nil then
		return Managers.time:time("main") - self._first_damaged_at
	end

	return math.huge
end

function BossExtension:start_boss_encounter()
	self._start_boss_encounter = true

	if self._is_server then
		Managers.telemetry_events:boss_encounter_started(self._breed.name)
	end
end

function BossExtension:_generate_display_name()
	local breed = self._breed
	local display_name = breed.boss_display_name

	if display_name then
		local seed = self._seed

		if type(display_name) == "table" then
			local next_seed, index = math.next_random(seed, 1, #display_name)
			display_name = display_name[index]
			self._seed = next_seed
		end

		display_name = _setup_twins_special_names(display_name, breed)
		self._display_name = display_name
	end
end

function BossExtension:display_name()
	return self._display_name
end

function BossExtension:is_weakened()
	return self._is_weakened
end

function BossExtension:_start_boss_template(boss_template)
	self._template_context = {
		is_server = self._is_server,
		physics_world = self._physics_world,
		nav_world = self._nav_world,
		world = self._world,
		wwise_world = self._wwise_world
	}
	self._template_data = {
		unit = self._unit
	}

	boss_template.start(self._template_data, self._template_context)

	self._boss_template = boss_template
end

local ALLOWED_BREEDS = {
	renegade_twin_captain = true,
	renegade_twin_captain_two = true
}

function _setup_twins_special_names(display_name, breed)
	local havoc_mananger = Managers.state.havoc

	if not havoc_mananger:is_havoc() then
		return display_name
	end

	local name = breed.name

	if not ALLOWED_BREEDS[name] then
		return display_name
	end

	local concatenated_name = "havoc_" .. name
	local possible_display_names = BossNameTemplates[concatenated_name]

	if type(possible_display_names) == "table" then
		local next_seed = math.random(1, #possible_display_names)
		display_name = possible_display_names[next_seed]
		breed.display_name = display_name
	end

	return display_name
end

return BossExtension
