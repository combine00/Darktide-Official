local NetworkedTimer = component("NetworkedTimer")

function NetworkedTimer:init(unit, is_server)
	self:enable(unit)

	local networked_timer_extension = ScriptUnit.fetch_component_extension(unit, "networked_timer_system")

	if networked_timer_extension then
		local duration = self:get_data(unit, "duration")
		local hud_description = self:get_data(unit, "hud_description")
		local max_speed_modifier = self:get_data(unit, "max_speed_modifier")

		networked_timer_extension:setup_from_component(duration, hud_description, max_speed_modifier)

		self._networked_timer_extension = networked_timer_extension
	end
end

function NetworkedTimer:editor_init(unit)
	return
end

function NetworkedTimer:editor_validate(unit)
	return true, ""
end

function NetworkedTimer:editor_update(unit, dt, t)
	return
end

function NetworkedTimer:enable(unit)
	return
end

function NetworkedTimer:disable(unit)
	return
end

function NetworkedTimer:destroy(unit)
	return
end

function NetworkedTimer:start()
	local networked_timer_extension = self._networked_timer_extension

	if networked_timer_extension then
		networked_timer_extension:start()
	end
end

function NetworkedTimer:pause()
	local networked_timer_extension = self._networked_timer_extension

	if networked_timer_extension then
		networked_timer_extension:pause()
	end
end

function NetworkedTimer:stop()
	local networked_timer_extension = self._networked_timer_extension

	if networked_timer_extension then
		networked_timer_extension:stop()
	end
end

function NetworkedTimer:fast_forward()
	local networked_timer_extension = self._networked_timer_extension

	if networked_timer_extension then
		networked_timer_extension:fast_forward()
	end
end

function NetworkedTimer:rewind()
	local networked_timer_extension = self._networked_timer_extension

	if networked_timer_extension then
		networked_timer_extension:rewind()
	end
end

NetworkedTimer.component_data = {
	duration = {
		ui_type = "number",
		value = 1,
		ui_name = "Duration (in sec.)",
		step = 0.01
	},
	hud_description = {
		ui_type = "text_box",
		value = "loc_description",
		ui_name = "HUD Description"
	},
	max_speed_modifier = {
		ui_type = "number",
		value = 1,
		ui_name = "Max Speed Modifier",
		step = 0.01
	},
	inputs = {
		start = {
			accessibility = "public",
			type = "event"
		},
		pause = {
			accessibility = "public",
			type = "event"
		},
		stop = {
			accessibility = "public",
			type = "event"
		},
		fast_forward = {
			accessibility = "public",
			type = "event"
		},
		rewind = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {
		"NetworkedTimerExtension"
	}
}

return NetworkedTimer
