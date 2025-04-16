local ConstantElementHavocStatus = class("ConstantElementHavocStatus")

function ConstantElementHavocStatus:init(parent, draw_layer, start_scale)
	self._notifications_allowed = false
	self._havoc_status = nil
	self._notification_id = nil

	Managers.event:register(self, "event_havoc_status_refreshed", "_event_havoc_status_refreshed")
end

function ConstantElementHavocStatus:_event_havoc_status_refreshed(status)
	self._havoc_status = status

	self:_update_notification()
end

function ConstantElementHavocStatus:set_visible(visible, optional_visibility_parameters)
	self._notifications_allowed = visible

	self:_update_notification()
end

function ConstantElementHavocStatus:_update_notification()
	local should_show_locked_notification = self._notifications_allowed and self._havoc_status == "havoc_locked"

	if should_show_locked_notification and not self._notification_id then
		local message = Localize("loc_notification_havoc_prohibited")

		Managers.event:trigger("event_add_notification_message", "havoc_status", message, function (id)
			self._notification_id = id
		end)
	elseif not should_show_locked_notification and self._notification_id then
		Managers.event:trigger("event_remove_notification", self._notification_id)

		self._notification_id = nil
	end
end

function ConstantElementHavocStatus:should_update()
	return false
end

function ConstantElementHavocStatus:should_draw()
	return false
end

function ConstantElementHavocStatus:destroy()
	Managers.event:unregister(self, "event_havoc_status_refreshed")

	if self._notification_id then
		Managers.event:trigger("event_remove_notification", self._notification_id)

		self._notification_id = nil
	end
end

return ConstantElementHavocStatus
