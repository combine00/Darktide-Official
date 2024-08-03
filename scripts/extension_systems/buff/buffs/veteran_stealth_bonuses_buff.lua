require("scripts/extension_systems/buff/buffs/buff")

local VeteranStealthBonusesBuff = class("VeteranStealthBonusesBuff", "Buff")

function VeteranStealthBonusesBuff:init(context, template, start_time, instance_id, ...)
	VeteranStealthBonusesBuff.super.init(self, context, template, start_time, instance_id, ...)

	self._buff_extension = context.buff_extension
	self._in_invisibility = true
	self._stop_t = 0
end

function VeteranStealthBonusesBuff:update(dt, t, portable_random)
	VeteranStealthBonusesBuff.super.update(self, dt, t, portable_random)

	if self._in_invisibility then
		local in_invisibility = self._buff_extension:has_unique_buff_id("veteran_invisibility")

		if not in_invisibility then
			self._stop_t = t + self._template.duration
			self._in_invisibility = false
		end
	elseif not self._finished and self._stop_t < t then
		self._finished = true
	end
end

function VeteranStealthBonusesBuff:duration_progress()
	if self._in_invisibility then
		return 1
	end

	local gameplay_t = Managers.time:time("gameplay")
	local time_left = math.max(1e-06, self._stop_t - gameplay_t)
	local duration = self._template.duration

	return time_left / duration
end

function VeteranStealthBonusesBuff:duration()
	return nil
end

return VeteranStealthBonusesBuff
