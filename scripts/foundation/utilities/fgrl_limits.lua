local BURST_TIME = 15
local SUSTAIN_TIME = 300
FGRLLimits = FGRLLimits or {
	tracked_interfaces = {},
	stats = {}
}
local TRACKING_DATA = {
	XUser = {
		functions = {
			add_user_async = true,
			get_xbs_token_async = true,
			resolve_privilege_async = true,
			from_device_async = true
		},
		limits = {
			burst_limit = 10,
			sustain_limit = 30
		}
	},
	XboxLivePrivacy = {
		functions = {
			get_mute_list = true,
			get_avoid_list = true,
			check_user_permission = true,
			batch_check_permission = true
		},
		limits = {
			burst_limit = 10,
			sustain_limit = 30
		}
	},
	XboxLiveAchievement = {
		functions = {
			result_get_next_async = true,
			get_achievement_async = true,
			update_achievement = true
		},
		limits = {
			burst_limit = 100,
			sustain_limit = 300
		}
	},
	XSocialManager = {
		functions = {
			add_local_user = true,
			create_social_group = true
		},
		limits = {
			burst_limit = 10,
			sustain_limit = 30
		}
	},
	XSocial = {
		functions = {
			get_user_presence_data = true,
			get_relationships = true
		},
		limits = {
			burst_limit = 10,
			sustain_limit = 100,
			get_relationships = {
				burst_limit = 10,
				sustain_limit = 30
			}
		}
	},
	XboxLiveProfile = {
		functions = {
			get_user_profiles = true
		},
		limits = {
			burst_limit = 10,
			sustain_limit = 30
		}
	},
	XboxLiveMPA = {
		functions = {
			get_activity = true,
			delete_activity = true,
			update_recent_players = true,
			set_activity = true,
			send_invites = true
		},
		limit_groups = {
			activity = {
				burst_limit = 10,
				sustain_limit = 100
			}
		},
		limits = {
			burst_limit = 20,
			sustain_limit = 200,
			send_invites = {
				burst_limit = 7,
				sustain_limit = 50
			},
			delete_activity = {
				limit_group = "activity"
			},
			set_activity = {
				limit_group = "activity"
			},
			update_recent_players = {
				burst_limit = 3,
				sustain_limit = 50
			}
		}
	}
}

local function interface_limit_reached(fgrl_stats, limits, interface_name, function_name)
	local num_burst_calls = #fgrl_stats.burst_calls
	local burst_limit = limits.burst_limit

	if burst_limit <= num_burst_calls then
		return true, "BURST LIMIT REACHED - " .. interface_name .. (function_name and "." .. function_name or "") .. " (" .. num_burst_calls .. "/" .. burst_limit .. ")"
	end

	local num_sustain_calls = #fgrl_stats.sustain_calls
	local sustain_limit = limits.sustain_limit

	if limits.sustain_limit <= num_sustain_calls then
		return true, "SUSTAIN LIMIT REACHED - " .. interface_name .. (function_name and "." .. function_name or "") .. " (" .. num_sustain_calls .. "/" .. sustain_limit .. ")"
	end

	return false
end

local function fgrl_failed(error_message, ...)
	if rawget(_G, "Log") then
		Log.error("FGRLLimits", error_message)
	end

	return nil, nil, error_message
end

local function track_fgrl(interface_name, function_name)
	local time = Application.time_since_launch()
	local interface_tracking_data = TRACKING_DATA[interface_name]
	FGRLLimits.stats[interface_name] = FGRLLimits.stats[interface_name] or {
		burst_calls = {},
		sustain_calls = {},
		burst_time = time + BURST_TIME,
		sustain_time = time + SUSTAIN_TIME,
		function_stats = {}
	}
	local fgrl_stats = nil
	local function_tracking_data = interface_tracking_data.limits[function_name]

	if function_tracking_data then
		local function_stats = FGRLLimits.stats[interface_name].function_stats
		local tracking_name = function_tracking_data.limit_group or function_name
		function_stats[tracking_name] = function_stats[tracking_name] or {
			burst_calls = {},
			sustain_calls = {},
			burst_time = time + BURST_TIME,
			sustain_time = time + SUSTAIN_TIME
		}
		fgrl_stats = function_stats[tracking_name]
	else
		fgrl_stats = FGRLLimits.stats[interface_name]
	end

	local limits = interface_tracking_data.limits
	limits = limits[function_name] or limits

	if limits.limit_group then
		limits = interface_tracking_data.limit_groups[limits.limit_group]
	end

	if fgrl_stats.burst_time <= time then
		table.clear(fgrl_stats.burst_calls)

		fgrl_stats.burst_time = time + BURST_TIME
	end

	if fgrl_stats.sustain_time <= time then
		table.clear(fgrl_stats.sustain_calls)

		fgrl_stats.sustain_time = time + SUSTAIN_TIME
	end

	local limit_reached, error_message = interface_limit_reached(fgrl_stats, limits, interface_name, function_name)

	if limit_reached then
		return error_message
	else
		fgrl_stats.burst_calls[#fgrl_stats.burst_calls + 1] = function_name
		fgrl_stats.sustain_calls[#fgrl_stats.sustain_calls + 1] = function_name
	end
end

if IS_XBS or IS_GDK then
	for interface_name, interface_tracking_data in pairs(TRACKING_DATA) do
		local new_interface = {}
		local interface = _G[interface_name]

		if not FGRLLimits.tracked_interfaces[interface_name] then
			FGRLLimits.tracked_interfaces[interface_name] = true

			if rawget(_G, "Log") then
				Log.info("TRACKING FGRL", "###### Started tracking %q ######", interface_name)
			end

			for function_name, _ in pairs(interface_tracking_data.functions) do
				local limits = interface_tracking_data.limits[function_name] or interface_tracking_data.limits

				if limits.limit_group then
					limits = interface_tracking_data.limit_groups[limits.limit_group]
				end

				if rawget(_G, "Log") then
					Log.info("TRACKING FGRL", "- function: %q (Burst Limit: %d / Sustain Limit: %d)", function_name, limits.burst_limit, limits.sustain_limit)
				end
			end

			local metatable = {
				__index = function (t, k)
					if interface_tracking_data.functions[k] then
						local error_message = track_fgrl(interface_name, k)

						if error_message then
							return callback(fgrl_failed, error_message)
						end
					end

					return interface[k]
				end
			}

			setmetatable(new_interface, metatable)

			_G[interface_name] = new_interface
		end
	end
end

return FGRLLimits
