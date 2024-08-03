local WeakspotSettings = require("scripts/settings/damage/weakspot_settings")
local Weakspot = {}
local _weakspot_type = nil

function Weakspot.hit_weakspot(breed_or_nil, hit_zone_name)
	local weakspot_type = _weakspot_type(breed_or_nil, hit_zone_name)
	local hit_weakspot = weakspot_type ~= nil and weakspot_type ~= "shield"
	local hit_shield = weakspot_type == "shield"

	return hit_weakspot, hit_shield
end

function Weakspot.finesse_boost_modifer(breed_or_nil, hit_zone_name, finesse_boost_amount)
	local weakspot_type = _weakspot_type(breed_or_nil, hit_zone_name)

	if not weakspot_type then
		return 1
	end

	local modifier = WeakspotSettings.finesse_boost_modifers[weakspot_type](finesse_boost_amount)

	return modifier
end

function _weakspot_type(breed_or_nil, hit_zone_name)
	if not breed_or_nil or not breed_or_nil.hit_zone_weakspot_types then
		return
	end

	local weakspot_type = breed_or_nil.hit_zone_weakspot_types[hit_zone_name]

	return weakspot_type
end

return Weakspot
