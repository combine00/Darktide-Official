local Promise = require("scripts/foundation/utilities/promise")
local BasePlatformAchievement = class("BasePlatformAchievement")

function BasePlatformAchievement:init(definitions)
	return Promise.resolved()
end

function BasePlatformAchievement:destroy()
	return Promise.resolved()
end

function BasePlatformAchievement:is_platform_achievement(achievement_definition)
	return false
end

function BasePlatformAchievement:unlock(achievement_definition)
	return Promise.rejected()
end

function BasePlatformAchievement:is_unlocked(achievement_definition)
	return false
end

function BasePlatformAchievement:set_progress(achievement_definition, progress)
	return Promise.rejected()
end

function BasePlatformAchievement:get_progress(achievement_definition)
	return nil
end

return BasePlatformAchievement
