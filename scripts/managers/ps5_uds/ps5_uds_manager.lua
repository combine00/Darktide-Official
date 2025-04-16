local Promise = require("scripts/foundation/utilities/promise")

local function log_info(...)
	if DevParameters.debug_trophies then
		Log.info("PS5UDSManager", ...)
	end
end

local function log_error(...)
	Log.error("PS5UDSManager", "Error: %s\nCallstack: %s", string.format(...), Script.callstack())
end

local PS5UDSManager = class("PS5UDSManager")
local states = table.enum("not_started", "create_uds_context", "create_trophy_context", "ready", "error")
PS5UDSManager.job_types = table.enum("uds", "trophy")

function PS5UDSManager:init()
	self._user_id = PS5.initial_user_id()
	self._trophy_context_id = nil
	self._uds_context_id = nil
	self._state = states.not_started
	self._ongoing_jobs = {}
	self._trophy_data = {}
	self._trophy_details = {}
	self._trophies_per_get_info = 10
	self._trophy_info_job_id = nil
	self._get_trophy_info_promise = nil
	self._create_uds_context_job_id = nil
	self._create_trophy_context_job_id = nil
	self._end_id = nil
end

function PS5UDSManager:wrap(job_type, job_id, debug_name)
	local promise = Promise:new()
	self._ongoing_jobs[job_id] = {
		job_type = job_type,
		promise = promise,
		debug_name = debug_name
	}

	return promise
end

function PS5UDSManager:_handle_uds_context_creation()
	local uds_job_id = self._create_uds_context_job_id
	local status, error_code = UDS.status(uds_job_id)

	if status == UDS_JOB_STATUS.COMPLETED then
		if error_code then
			self:_set_state(states.error)
			log_error("Failed creating UDS context with 0x%x", error_code)
		else
			self._uds_context_id = UDS.setup_context_async_result(uds_job_id)
			self._create_trophy_context_job_id = Trophies.setup_context_async(self._user_id, self._uds_context_id)

			self:_set_state(states.create_trophy_context)
		end

		UDS.free_job(uds_job_id)

		self._create_uds_context_job_id = nil
	elseif status == UDS_JOB_STATUS.UNKNOWN then
		self:_set_state(states.error)
		log_error("Unknown UDS job id %d", uds_job_id)
	end
end

function PS5UDSManager:_handle_trophy_context_creation()
	local trophy_context_job_id = self._create_trophy_context_job_id
	local status, error_code = Trophies.status(trophy_context_job_id)

	if status == UDS_JOB_STATUS.COMPLETED then
		if error_code then
			self:_set_state(states.error)
			log_error("Failed creating trophy context with 0x%x", error_code)
		else
			self._trophy_context_id = Trophies.setup_context_async_result(trophy_context_job_id)

			self:_set_state(states.ready)
		end

		Trophies.free_job(trophy_context_job_id)

		self._create_trophy_context_job_id = nil
	elseif status == UDS_JOB_STATUS.UNKNOWN then
		self:_set_state(states.error)
		log_error("Unknown trophy context job id %d", trophy_context_job_id)
	end
end

function PS5UDSManager:_handle_ongoing_jobs()
	for job, data in pairs(self._ongoing_jobs) do
		local status = UDS.status(job)

		if status == UDS_JOB_STATUS.COMPLETED then
			data.promise:resolve(job)
		elseif status ~= UDS_JOB_STATUS.PENDING then
			if data.debug_name then
				log_error("Rejecting job with debug_name %s, error code %d", data.debug_name, status)
			end

			data.promise:reject({
				status
			})
		end
	end
end

function PS5UDSManager:_handle_trophy_info()
	local status, status_error_code = Trophies.status(self._trophy_info_job_id)

	if status == UDS_JOB_STATUS.COMPLETED then
		if status_error_code then
			self:_set_state(states.error)
			log_error("[_handle_trophy_info] Error 0x%x", status_error_code)
			self._get_trophy_info_promise:resolve({
				data = {},
				details = {}
			})
		else
			local trophy_details_list, trophy_data_list, error_code = Trophies.get_trophies_info_async_result(self._trophy_info_job_id)

			Trophies.free_job(self._trophy_info_job_id)

			self._trophy_info_job_id = nil

			if error_code then
				self:_set_state(states.error)
				log_error("[_handle_trophy_info] Error 0x%x", error_code)
				self._get_trophy_info_promise:resolve({
					data = {},
					details = {}
				})
			else
				for _, trophy_details in ipairs(trophy_details_list) do
					self._trophy_details[#self._trophy_details + 1] = trophy_details
				end

				for _, trophy_data in ipairs(trophy_data_list) do
					self._trophy_data[#self._trophy_data + 1] = trophy_data
				end

				if #trophy_details_list > 0 then
					self:_get_trophy_info()
				else
					self._get_trophy_info_promise:resolve({
						data = self._trophy_data,
						details = self._trophy_details
					})
				end
			end
		end
	elseif status == UDS_JOB_STATUS.UNKNOWN then
		-- Nothing
	elseif status == UDS_JOB_STATUS.PENDING then
		-- Nothing
	end
end

function PS5UDSManager:_set_state(new_state)
	self._state = new_state
end

function PS5UDSManager:update()
	if self._state == states.not_started then
		self:_set_state(states.create_uds_context)

		self._create_uds_context_job_id = UDS.setup_context_async(self._user_id)
	elseif self._state == states.create_uds_context then
		self:_handle_uds_context_creation()
	elseif self._state == states.create_trophy_context then
		self:_handle_trophy_context_creation()
	elseif self._state == states.ready then
		self:_handle_ongoing_jobs()

		if self._trophy_info_job_id then
			self:_handle_trophy_info()
		end
	end
end

function PS5UDSManager:release(job)
	local job_data = self._ongoing_jobs[job]

	if job_data and job_data.promise:is_pending() then
		if job_data.debug_name then
			log_error("Aborted job with debug_name %s", job_data.debug_name)
		end

		job_data.promise:reject({
			-1
		})
	end

	self._ongoing_jobs[job] = nil
end

function PS5UDSManager:get_all_achievements()
	if not self._get_trophy_info_promise then
		self:_get_trophy_info(0)

		self._get_trophy_info_promise = Promise:new()
	end

	return self._get_trophy_info_promise
end

function PS5UDSManager:_get_trophy_info(start_id)
	start_id = start_id or self._end_id
	self._trophy_info_job_id = Trophies.get_trophies_info_async(self._trophy_context_id, start_id, self._trophies_per_get_info)
	self._end_id = start_id + self._trophies_per_get_info
end

function PS5UDSManager:destroy()
	Trophies.destroy_context_async(self._trophy_context_id)
	UDS.destroy_context_async(self._uds_context_id)
end

function PS5UDSManager:_wrap(job, debug_name)
	local promise = Promise:new()
	self._ongoing_jobs[job] = {
		promise = promise,
		debug_name = debug_name
	}

	return promise
end

function PS5UDSManager:unlock_trophy(achievement_id)
	local unlock_trophy_job = Trophies.unlock_trophy_async(self._uds_context_id, achievement_id)
	local promise = self:_wrap(unlock_trophy_job, "unlock_trophy")

	promise:next(function ()
		local error_code = Trophies.unlock_trophy_async_result(unlock_trophy_job)

		log_info("[unlock_trophy] Error code: 0x%x", error_code)
	end)
end

function PS5UDSManager:update_achievement(achievement_id, progression)
	local progress_trophy_job = Trophies.progress_trophy_async(self._uds_context_id, achievement_id, progression)
	local promise = self:_wrap(progress_trophy_job, "progress_trophy")

	promise:next(function ()
		local error_code = Trophies.progress_trophy_async_result(progress_trophy_job)

		log_info("[update_achievement] Error code: 0x%x", error_code)
	end)

	return promise
end

return PS5UDSManager
