local UIPopupTemplates = require("scripts/settings/ui/ui_popup_templates")
local VideoManager = class("VideoManager")

function VideoManager:init()
	self._video_config_name = nil
	self._popup_config_name = nil
	self._popup_id = nil
end

function VideoManager:play_video_with_popup(video_config_name, popup_config_name)
	if self._popup_id then
		Managers.event:trigger("event_remove_ui_popup", self._popup_id)

		self._popup_id = nil

		Log.warning("VideoManager", "A new video popup replaced an old video popup")
	end

	self._popup_config_name = popup_config_name
	self._video_config_name = video_config_name
end

function VideoManager:update()
	if self._popup_config_name then
		self:_show_popup(self._popup_config_name)

		self._popup_config_name = nil
	end
end

function VideoManager:_show_popup(config_name)
	local settings = UIPopupTemplates[config_name]
	local on_popup_continue = callback(self, "on_popup_continue")
	local popup_context = {
		title_text = settings.title_text,
		description_text = settings.description_text,
		options = {
			{
				close_on_pressed = true,
				text = settings.button_text,
				callback = on_popup_continue
			}
		}
	}

	local function popup_callback(id)
		self._popup_id = id
	end

	Managers.event:trigger("event_show_ui_popup", popup_context, popup_callback)
end

function VideoManager:on_popup_continue()
	Managers.ui:open_view("video_view", nil, true, true, nil, {
		allow_skip_input = true,
		template = self._video_config_name
	})

	self._popup_id = nil
	self._video_config_name = nil
end

function VideoManager:destroy()
	Managers.event:trigger("event_remove_ui_popup", self._popup_id)

	self._popup_id = nil
end

return VideoManager
