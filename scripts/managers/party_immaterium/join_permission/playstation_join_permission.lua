local Promise = require("scripts/foundation/utilities/promise")
local PlaystationJoinPermission = {
	test_play_mutliplayer_permission = function (account_id, platform, platform_user_id, context)
		return Promise.resolved("OK")
	end
}

return PlaystationJoinPermission
