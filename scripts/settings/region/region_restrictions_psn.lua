local RegionConstants = require("scripts/settings/region/region_constants")
local restrictions = RegionConstants.restrictions
local RegionRestrictionsPSN = {
	at = {
		[restrictions.ragdoll_interaction] = true,
		[restrictions.visible_minion_wounds] = false,
		[restrictions.gibbing] = false,
		[restrictions.blood_decals] = false
	},
	de = {
		[restrictions.ragdoll_interaction] = true,
		[restrictions.visible_minion_wounds] = false,
		[restrictions.gibbing] = false,
		[restrictions.blood_decals] = false
	},
	jp = {
		[restrictions.ragdoll_interaction] = true,
		[restrictions.visible_minion_wounds] = true,
		[restrictions.gibbing] = true,
		[restrictions.blood_decals] = true
	},
	unknown = {
		[restrictions.ragdoll_interaction] = true,
		[restrictions.visible_minion_wounds] = true,
		[restrictions.gibbing] = true,
		[restrictions.blood_decals] = true
	}
}

return settings("RegionRestrictionsPSN", RegionRestrictionsPSN)
