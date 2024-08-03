local BasePlatformAchievement = "scripts/managers/achievements/platforms/base_platform_achievement"
local Promise = require("scripts/foundation/utilities/promise")
local SteamPlatformAchievement = class("SteamPlatformAchievement", "BasePlatformAchievement")

function SteamPlatformAchievement:init(definitions)
	return Promise.resolved()
end

function SteamPlatformAchievement:destroy()
	return Promise.resolved()
end

function SteamPlatformAchievement:_get_platform_id(achievement_definition)
	local steam_data = achievement_definition.steam
	local platform_id = steam_data and steam_data.id

	return platform_id
end

function SteamPlatformAchievement:_get_platform_stat_id(achievement_definition)
	local steam_data = achievement_definition.steam
	local platform_stat_id = steam_data and steam_data.stat_id

	return platform_stat_id
end

function SteamPlatformAchievement:is_platform_achievement(achievement_definition)
	return self:_get_platform_id(achievement_definition) ~= nil
end

function SteamPlatformAchievement:unlock(achievement_definition)
	local platform_id = self:_get_platform_id(achievement_definition)

	if platform_id and Achievement.unlock(platform_id) then
		return Promise.resolved()
	end

	return Promise.rejected()
end

function SteamPlatformAchievement:is_unlocked(achievement_definition)
	local platform_id = self:_get_platform_id(achievement_definition)

	return platform_id ~= nil and Achievement.unlocked(platform_id)
end

function SteamPlatformAchievement:set_progress(achievement_definition, progress)
	local platform_id = self:_get_platform_id(achievement_definition)
	local platform_stat_id = self:_get_platform_stat_id(achievement_definition)

	if not platform_id or not platform_stat_id then
		return Promise.rejected()
	end

	progress = math.floor(progress)

	Stats.set(platform_stat_id, progress)

	return Promise.resolved()
end

function SteamPlatformAchievement:get_progress(achievement_definition)
	local platform_id = self:_get_platform_id(achievement_definition)
	local platform_stat_id = self:_get_platform_stat_id(achievement_definition)

	if not platform_id or not platform_stat_id then
		Log.warning("SteamPlatformAchievement", "Achievement '%s' couldn't be read. Missing platform data.", achievement_definition.id)

		return nil
	end

	local progress, error = Stats.get(platform_stat_id)

	if error then
		Log.warning("SteamPlatformAchievement", "Achievement '%s' couldn't be read. %s", achievement_definition.id, error)

		return nil
	end

	return progress
end

return SteamPlatformAchievement
