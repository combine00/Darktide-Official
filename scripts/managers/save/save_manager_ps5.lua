local SaveData = require("scripts/managers/save/save_data")
local Save = require("scripts/managers/save/utilities/save")
local PlayerManager = require("scripts/foundation/managers/player/player_manager")
local STATES = table.enum("idle", "saving", "showing_dialog", "loading")

local function _info(...)
	Log.info("SaveManager", ...)
end

local SaveManager = class("SaveManager")

function SaveManager:init(file_name)
	self._file_name = "save_data.sav"
	self._folder_name = "darktide"
	self._token = nil
	self._state = STATES.idle
	self._save_data = SaveData:new()
	self._queued_save = false
	self._save_done_cb = callback(self, "cb_save_done")
	self._load_done_cb = callback(self, "cb_load_done")
end

function SaveManager:data()
	return self._save_data.data
end

function SaveManager:state()
	return self._state
end

function SaveManager:queue_save()
	if self._state == STATES.idle then
		self:save()
	else
		self._queued_save = true
	end
end

function SaveManager:save(optional_callback)
	local save_info = {
		title = "Darktide",
		name = self._folder_name,
		files = {
			{
				path = self._file_name,
				data = self._save_data
			}
		}
	}

	_info("SAVING...")

	self._token = Save.save(save_info, self._save_done_cb)
	self._save_callback = optional_callback
	self._state = STATES.saving
end

function SaveManager:abort()
	self._callback = nil
	self._state = STATES.idle

	Save.abort(self._token)

	self._token = nil
end

function SaveManager:update()
	if self._state == STATES.showing_dialog then
		local status = SaveSystemDialog.update()

		if status == SaveSystemDialog.FINISHED then
			SaveSystemDialog.terminate()
			self:_trigger_save_done()
		end
	end
end

function SaveManager:cb_save_done(info)
	_info("Save done")

	if info.error == "OUT_OF_SPACE" then
		self._state = STATES.showing_dialog

		SaveSystemDialog.initialize()

		local user_id = PS5.initial_user_id()

		SaveSystemDialog.open(info.space_missing, user_id)
	else
		self:_trigger_save_done()
	end

	self._token = nil
end

function SaveManager:_trigger_save_done()
	self._state = STATES.idle

	if self._save_callback then
		self._save_callback()

		self._save_callback = nil
	end

	self:_handle_queued_save()
end

function SaveManager:_handle_queued_save()
	if self._queued_save then
		self._queued_save = false

		self:save()
	end
end

function SaveManager:set_save_data_account_id(account_id)
	self._signed_in_account_id = account_id
end

function SaveManager:save_data_account_id()
	return self._signed_in_account_id
end

function SaveManager:account_data(account_id)
	account_id = account_id or self:save_data_account_id() or PlayerManager.NO_ACCOUNT_ID

	return self._save_data:account_data(account_id)
end

function SaveManager:character_data(character_id)
	local account_id = self:save_data_account_id()

	if not character_id then
		local player_manager = Managers.player
		local player = player_manager and player_manager:local_player(1)
		character_id = player and player:character_id()
	end

	return self._save_data:character_data(account_id, character_id)
end

function SaveManager:load(optional_callback)
	_info("LOADING...")

	local load_info = {
		name = self._folder_name,
		files = {
			{
				path = self._file_name
			}
		}
	}
	self._load_callback = optional_callback
	self._token = Save.load(load_info, self._load_done_cb)
	self._state = STATES.loading
end

function SaveManager:cb_load_done(token)
	_info("Load done")

	self._token = nil

	self._save_data:populate(token.data)

	self._state = STATES.idle

	if self._load_callback then
		self._load_callback()

		self._load_callback = nil
	end

	self:_handle_queued_save()
end

return SaveManager
