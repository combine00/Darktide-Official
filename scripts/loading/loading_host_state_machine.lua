local HostCreateWorldState = require("scripts/loading/host_states/host_create_world_state")
local HostDetermineSpawnGroupState = require("scripts/loading/host_states/host_determine_spawn_group_state")
local HostIngameState = require("scripts/loading/host_states/host_in_game_state")
local HostLevelState = require("scripts/loading/host_states/host_level_state")
local HostMechanismLevelState = require("scripts/loading/host_states/host_mechanism_level_state")
local HostLoadersState = require("scripts/loading/host_states/host_loaders_state")
local HostThemeState = require("scripts/loading/host_states/host_theme_state")
local HostWaitForMissionBriefingDoneState = require("scripts/loading/host_states/host_wait_for_mission_briefing_done_state")
local Missions = require("scripts/settings/mission/mission_templates")
local ScriptWorld = require("scripts/foundation/utilities/script_world")
local StateMachine = require("scripts/foundation/utilities/state_machine")
local LoadingHostStateMachine = class("LoadingHostStateMachine")

function LoadingHostStateMachine:init(loading_context, level_editor_level, spawn_queue, loaders, done_loading_level_func, single_player, mission_seed)
	local mission_name = loading_context.mission_name
	local circumstance_name = loading_context.circumstance_name
	local shared_state = {
		state = "loading",
		world_name = "level_world",
		loading_context = loading_context,
		mission_name = mission_name,
		level_name = Missions[mission_name].level or level_editor_level,
		circumstance_name = circumstance_name,
		havoc_data = loading_context.havoc_data,
		spawn_queue = spawn_queue,
		done_loading_level_func = done_loading_level_func,
		loaders = loaders,
		themes = {},
		single_player = single_player,
		mission_seed = mission_seed
	}
	self._shared_state = shared_state
	local parent = nil
	local state_machine = StateMachine:new("LoadingHostStateMachine", parent, shared_state)

	state_machine:add_transition("HostDetermineSpawnGroupState", "spawn_group_done", HostLoadersState)
	state_machine:add_transition("HostLoadersState", "load_done", HostCreateWorldState)
	state_machine:add_transition("HostCreateWorldState", "load_done", HostThemeState)
	state_machine:add_transition("HostThemeState", "load_done", HostLevelState)
	state_machine:add_transition("HostLevelState", "load_done", HostMechanismLevelState)

	local loading_done_state = single_player and HostWaitForMissionBriefingDoneState or HostIngameState

	state_machine:add_transition("HostMechanismLevelState", "spawning_done", loading_done_state)
	state_machine:add_transition("HostWaitForMissionBriefingDoneState", "mission_briefing_done", HostIngameState)
	state_machine:set_initial_state(HostDetermineSpawnGroupState)

	self._state_machine = state_machine
end

function LoadingHostStateMachine:destroy()
	local shared_state = self._shared_state

	self:_cleanup_level(shared_state)

	local loaders = shared_state.loaders

	for _, loader in ipairs(loaders) do
		loader:cleanup()
	end

	self._state_machine:delete()

	self._state_machine = nil
	self._shared_state = nil
end

function LoadingHostStateMachine:_cleanup_level(shared_state)
	local themes = shared_state.themes
	local level = shared_state.level
	local world = shared_state.world

	if #themes > 0 then
		for _, theme in ipairs(themes) do
			World.destroy_theme(world, theme)
		end

		shared_state.themes = {}
	end

	if shared_state.level_spawner then
		shared_state.level_spawner:destroy()

		shared_state.level_spawner = nil
	elseif level then
		local level_name = shared_state.level_name

		ScriptWorld.destroy_level(world, level_name)

		shared_state.level = nil
	end

	if world then
		Managers.world:destroy_world(world)

		shared_state.world = nil
	end
end

function LoadingHostStateMachine:update(dt)
	self._state_machine:update(dt)
end

function LoadingHostStateMachine:take_ownership_of_level()
	local world, level = nil
	local themes = {}
	local shared_state = self._shared_state
	shared_state.world = world
	world = shared_state.world
	shared_state.level = level
	level = shared_state.level
	shared_state.themes = themes
	themes = shared_state.themes

	return world, level, themes, shared_state.world_name
end

function LoadingHostStateMachine:is_level_loaded()
	return self._shared_state.state == "playing"
end

return LoadingHostStateMachine
