local ReporterInterface = require("scripts/managers/telemetry/reporters/reporter_interface")
local LoadTimesReporter = class("LoadTimesReporter")

function LoadTimesReporter:init()
	Managers.event:register(self, "event_loading_started", "_loading_started")
	Managers.event:register(self, "event_loading_finished", "_loading_finished")
	Managers.event:register(self, "event_loading_resources_started", "_loading_resources_started")
	Managers.event:register(self, "event_loading_resources_finished", "_loading_resources_finished")
	Managers.event:register(self, "event_mission_intro_started", "_mission_intro_started")
	Managers.event:register(self, "event_mission_intro_finished", "_mission_intro_finished")

	self._read_from_disk_time = 0
	self._is_loading = false
end

function LoadTimesReporter:destroy()
	Managers.event:unregister(self, "event_loading_started")
	Managers.event:unregister(self, "event_loading_finished")
	Managers.event:unregister(self, "event_loading_resources_started")
	Managers.event:unregister(self, "event_loading_resources_finished")
	Managers.event:unregister(self, "event_mission_intro_started")
	Managers.event:unregister(self, "event_mission_intro_finished")
end

function LoadTimesReporter:_loading_started()
	self._mission_name = nil

	self:reset_timers()
	self:start_timer("loading_timer")
	self:start_timer("wait_for_network_timer")
end

function LoadTimesReporter:_loading_resources_started(mission_name)
	self._mission_name = mission_name

	self:stop_timer("wait_for_network_timer")
	self:start_timer("resource_loading_timer")

	self._is_loading = true
	self._read_from_disk_time = 0
end

function LoadTimesReporter:_loading_resources_finished()
	self:stop_timer("resource_loading_timer")
	self:start_timer("wait_for_spawn_timer")

	self._is_loading = false
end

function LoadTimesReporter:_mission_intro_started()
	self:start_timer("mission_intro_timer")
end

function LoadTimesReporter:_mission_intro_finished()
	if Managers.time:has_timer("mission_intro_timer") then
		self:stop_timer("mission_intro_timer")
	end
end

function LoadTimesReporter:_loading_finished()
	self._is_loading = false

	self:stop_timer("loading_timer")
	self:report()
end

function LoadTimesReporter:update(dt, t)
	if self._is_loading and Managers.package:is_anything_loading_now() then
		self._read_from_disk_time = self._read_from_disk_time + dt
	end
end

function LoadTimesReporter:report(dt, t)
	local mission_name = self._mission_name
	local wait_for_network_time = self:time("wait_for_network_timer")
	local resource_loading_time = self:time("resource_loading_timer")
	local wait_for_spawn_time = self:time("wait_for_spawn_timer")
	local read_from_disk_time = self._read_from_disk_time
	local mission_intro_time = 0

	if Managers.time:has_timer("mission_intro_timer") then
		mission_intro_time = self:time("mission_intro_timer")
	end

	Managers.telemetry_events:performance_load_times(mission_name, wait_for_network_time, resource_loading_time, mission_intro_time, wait_for_spawn_time, read_from_disk_time)
end

function LoadTimesReporter:start_timer(timer_name)
	Log.info("LoadTimesReporter", "Starting timer %s", timer_name)

	if Managers.time:has_timer(timer_name) then
		Managers.time:set_time(timer_name, 0)
		Managers.time:set_active(timer_name, true)
		Log.info("LoadTimesReporter", "Reseting timer %s", timer_name)
	else
		Managers.time:register_timer(timer_name, "main", 0)
	end
end

function LoadTimesReporter:stop_timer(timer_name)
	Managers.time:set_active(timer_name, false)
	Log.info("LoadTimesReporter", "Stopping timer %s", timer_name)
end

function LoadTimesReporter:time(timer_name)
	return Managers.time:time(timer_name, 0)
end

local TIMERS = {
	"loading_timer",
	"wait_for_network_timer",
	"resource_loading_timer",
	"wait_for_spawn_timer",
	"mission_intro_timer"
}

function LoadTimesReporter:reset_timers()
	for _, timer_name in ipairs(TIMERS) do
		if Managers.time:has_timer(timer_name) then
			Managers.time:unregister_timer(timer_name)
		end
	end
end

implements(LoadTimesReporter, ReporterInterface)

return LoadTimesReporter
