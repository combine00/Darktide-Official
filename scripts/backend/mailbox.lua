local Promise = require("scripts/foundation/utilities/promise")
local BackendUtilities = require("scripts/foundation/managers/backend/utilities/backend_utilities")
local MailBox = class("MailBox")

local function _decorate_mail(mail)
	function mail:mark_mail_read_and_claimed()
		return Managers.backend.interfaces.mailbox:mark_mail_read_and_claimed(mail)
	end

	function mail:mark_read()
		return Managers.backend.interfaces.mailbox:mark_mail_read(mail)
	end

	function mail:mark_unread()
		return Managers.backend.interfaces.mailbox:mark_mail_unread(mail)
	end

	function mail:mark_claimed(reward_idx)
		return Managers.backend.interfaces.mailbox:mark_mail_claimed(mail, reward_idx)
	end
end

local function _patch_mail(mail, body)
	local self_url = mail and mail._links and mail._links.self and mail._links.self.href

	return Managers.backend:title_request(BackendUtilities.url_builder(self_url):to_string(), {
		method = "PATCH",
		body = body
	}):next(function (data)
		local result = data.body

		if result.reward then
			result.reward.gear_id = result.reward.gearId
			result.reward.gearId = nil
		end

		_decorate_mail(result.mail)

		return result
	end)
end

function MailBox:get_mail_paged(character_id, limit, include_unread_global, include_translation, source)
	local promise = nil

	if character_id then
		promise = BackendUtilities.make_account_title_request("characters", BackendUtilities.url_builder(character_id):path("/mail"):query("source", source):query("includeUnreadGlobal", include_unread_global):query("includeTranslation", include_translation):query("limit", limit))
	else
		promise = BackendUtilities.make_account_title_request("account", BackendUtilities.url_builder("/mail"):query("source", source):query("includeUnreadGlobal", include_unread_global):query("includeTranslation", include_translation):query("limit", limit))
	end

	return promise:next(function (data)
		local result = BackendUtilities.wrap_paged_response(data.body)
		result.globals = data.body._embedded.globals

		for i, v in ipairs(result.items) do
			_decorate_mail(v)
		end

		for i, v in ipairs(result.globals) do
			_decorate_mail(v)
		end

		return result
	end)
end

function MailBox:mark_mail_read_and_claimed(mail)
	if mail.isRead then
		return Promise.resolved()
	end

	if mail.claimed then
		return Promise.resolved()
	end

	return _patch_mail(mail, {
		claimed = true,
		read = true
	}):next(function (reward)
		mail.isRead = true
		mail.claimed = true

		if reward then
			return reward
		end
	end)
end

function MailBox:mark_mail_read(mail)
	if mail.isRead then
		return Promise.resolved()
	end

	return _patch_mail(mail, {
		read = true
	}):next(function ()
		mail.isRead = true
	end)
end

function MailBox:mark_mail_unread(mail)
	if not mail.isRead then
		return Promise.resolved()
	end

	return _patch_mail(mail, {
		read = false
	}):next(function ()
		mail.isRead = false
	end)
end

function MailBox:mark_mail_claimed(mail, reward_idx)
	if mail.claimed then
		return Promise.resolved()
	end

	return _patch_mail(mail, {
		claimed = true,
		rewardIndex = reward_idx
	}):next(function ()
		mail.claimed = true
		mail.rewardIndex = reward_idx
	end)
end

return MailBox
