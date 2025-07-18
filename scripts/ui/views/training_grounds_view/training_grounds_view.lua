local Definitions = require("scripts/ui/views/training_grounds_view/training_grounds_view_definitions")
local VendorInteractionViewBase = require("scripts/ui/views/vendor_interaction_view_base/vendor_interaction_view_base")
local GameModeSettings = require("scripts/settings/game_mode/game_mode_settings")
local MatchmakingConstants = require("scripts/settings/network/matchmaking_constants")
local PlayerProgressionUnlocks = require("scripts/settings/player/player_progression_unlocks")
local SINGLEPLAY_TYPES = MatchmakingConstants.SINGLEPLAY_TYPES
local TrainingGroundsView = class("TrainingGroundsView", "VendorInteractionViewBase")

function TrainingGroundsView:init(settings, context)
	TrainingGroundsView.super.init(self, Definitions, settings, context)
end

function TrainingGroundsView:on_enter()
	TrainingGroundsView.super.on_enter(self)

	local viewport_name = Definitions.background_world_params.viewport_name

	if self._world_spawner then
		self._world_spawner:set_listener(viewport_name)
	end

	self:play_vo_events({
		"hub_interact_training_ground_psyker"
	}, "training_ground_psyker_a", nil, 0.8, true)
end

function TrainingGroundsView:on_exit()
	if self._world_spawner then
		self._world_spawner:release_listener()
	end

	TrainingGroundsView.super.on_exit(self)
end

return TrainingGroundsView
