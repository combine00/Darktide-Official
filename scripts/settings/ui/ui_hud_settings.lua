local default_element_draw_layer = 301
local ui_hud_settings = {
	element_draw_layers = {
		HudElementSuppressionIndicators = 0,
		HudElementCrosshair = 351,
		HudElementWorldMarkers = 0,
		HudElementCombatFeed = 990,
		HudElementSpectateFading = 998,
		HudElementCutsceneOverlay = 999,
		HudElementInteraction = 371,
		HudElementCutsceneFading = 998,
		HudElementAreaNotificationPopup = default_element_draw_layer,
		HudElementBlocking = default_element_draw_layer,
		HudElementBossHealth = default_element_draw_layer,
		HudElementCharacterNewsFeed = default_element_draw_layer,
		HudElementDamageIndicator = default_element_draw_layer,
		HudElementEmoteWheel = default_element_draw_layer + 150,
		HudElementMissionObjectiveFeed = default_element_draw_layer,
		HudElementMissionObjectivePopup = default_element_draw_layer,
		HudElementMissionSpeakerPopup = default_element_draw_layer,
		HudElementNameplates = default_element_draw_layer,
		HudElementObjectiveProgressBar = default_element_draw_layer,
		HudElementOnboardingPopup = default_element_draw_layer,
		HudElementOvercharge = default_element_draw_layer + 50,
		HudElementPlayerAbilityHandler = default_element_draw_layer,
		HudElementPlayerBuffs = default_element_draw_layer,
		HudElementPlayerWeaponHandler = default_element_draw_layer,
		HudElementPrologueStepTracker = default_element_draw_layer,
		HudElementPrologueTutorialInfoBox = default_element_draw_layer,
		HudElementPrologueTutorialSequenceTransitionEnd = default_element_draw_layer + 50,
		HudElementSmartTagging = default_element_draw_layer,
		HudElementSpectatorText = default_element_draw_layer,
		HudElementTacticalOverlay = default_element_draw_layer + 100,
		HudElementTeamPanelHandler = default_element_draw_layer,
		HudElementWeaponCounter = default_element_draw_layer + 50,
		HudElementWieldInfo = default_element_draw_layer + 10
	},
	bloom_settings = {
		offset_falloffs = {
			0,
			0.9,
			0.3
		},
		ui_bloom_tints = {
			0.617,
			0.491,
			0.238
		}
	},
	color_tint_main_1 = Color.terminal_text_header(255, true),
	color_tint_main_2 = Color.terminal_text_body(255, true),
	color_tint_main_3 = Color.terminal_text_body_sub_header(255, true),
	color_tint_main_4 = Color.terminal_frame(255, true),
	color_tint_secondary_1 = Color.ui_hud_yellow_super_light(255, true),
	color_tint_secondary_2 = Color.ui_hud_yellow_light(255, true),
	color_tint_secondary_3 = Color.ui_hud_yellow_medium(255, true),
	color_tint_alert_1 = Color.ui_hud_red_super_light(255, true),
	color_tint_alert_2 = Color.ui_hud_red_light(255, true),
	color_tint_alert_3 = Color.ui_hud_red_medium(255, true),
	color_tint_alert_4 = Color.ui_hud_red_dark(255, true),
	color_tint_ammo_low = Color.ui_hud_warp_charge_low(255, true),
	color_tint_ammo_medium = Color.ui_hud_warp_charge_medium(255, true),
	color_tint_ammo_high = Color.ui_hud_warp_charge_high(255, true),
	color_tint_0 = {
		150,
		0,
		0,
		0
	},
	color_tint_1 = {
		255,
		255,
		255,
		255
	},
	color_tint_2 = Color.ui_orange_light(153, true),
	color_tint_3 = Color.ui_orange_dark(153, true),
	color_tint_4 = Color.ui_grey_medium(153, true),
	color_tint_5 = Color.ui_terminal(255, true),
	color_tint_6 = Color.ui_toughness_default(255, true),
	color_tint_7 = Color.ui_toughness_medium(255, true),
	color_tint_8 = Color.ui_corruption_default(255, true),
	color_tint_9 = Color.ui_corruption_medium(255, true),
	color_tint_10 = Color.ui_toughness_buffed(255, true),
	color_tint_11 = Color.ui_ability_purple(255, true),
	player_status_icons = {
		consumed = "content/ui/materials/icons/player_states/incapacitated",
		warp_grabbed = "content/ui/materials/icons/player_states/incapacitated",
		ledge_hanging = "content/ui/materials/icons/player_states/incapacitated",
		hogtied = "content/ui/materials/icons/player_states/dead",
		grabbed = "content/ui/materials/icons/player_states/incapacitated",
		knocked_down = "content/ui/materials/icons/player_states/incapacitated",
		luggable = "content/ui/materials/icons/player_states/lugged",
		dead = "content/ui/materials/icons/player_states/dead",
		netted = "content/ui/materials/icons/player_states/incapacitated",
		mutant_charged = "content/ui/materials/icons/player_states/incapacitated",
		pounced = "content/ui/materials/icons/player_states/incapacitated"
	},
	player_status_colors = {
		dead = Color.ui_hud_green_super_light(255, true),
		hogtied = Color.ui_hud_green_super_light(255, true),
		pounced = Color.ui_hud_red_light(255, true),
		netted = Color.ui_hud_red_light(255, true),
		warp_grabbed = Color.ui_hud_red_light(255, true),
		mutant_charged = Color.ui_orange_light(255, true),
		consumed = Color.ui_orange_light(255, true),
		grabbed = Color.ui_orange_light(255, true),
		knocked_down = Color.ui_hud_red_light(255, true),
		ledge_hanging = Color.ui_hud_red_light(255, true),
		luggable = Color.ui_hud_green_super_light(255, true)
	}
}

local function get_hud_color(key, alpha)
	local color = table.clone(ui_hud_settings[key])

	if alpha then
		color[1] = alpha
	end

	return color
end

ui_hud_settings.get_hud_color = get_hud_color

return settings("UIHudSettings", ui_hud_settings)
