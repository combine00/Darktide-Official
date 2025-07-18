local ChatElementSettings = require("scripts/ui/constant_elements/elements/chat/constant_element_chat_settings")
local elements = {
	{
		package = "packages/ui/constant_elements/group_finder_status/group_finder_status",
		class_name = "ConstantGroupFinderStatus",
		filename = "scripts/ui/constant_elements/elements/group_finder_status/constant_element_group_finder_status",
		visibility_groups = {
			"in_hub_view",
			"in_hub",
			"default"
		}
	},
	{
		class_name = "ConstantElementTeamProfileLoader",
		filename = "scripts/ui/constant_elements/elements/team_profile_loader/constant_element_team_profile_loader",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_loading",
			"skippable_cinematic",
			"in_mission",
			"default"
		}
	},
	{
		draw_layer = 50,
		class_name = "ConstantElementSubtitles",
		filename = "scripts/ui/constant_elements/elements/subtitles/constant_element_subtitles",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_loading",
			"skippable_cinematic",
			"in_mission",
			"default"
		}
	},
	{
		package = "packages/ui/constant_elements/popup_handler/popup_handler",
		class_name = "ConstantElementPopupHandler",
		filename = "scripts/ui/constant_elements/elements/popup_handler/constant_element_popup_handler",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_loading",
			"skippable_cinematic",
			"in_mission",
			"default"
		}
	},
	{
		package = "packages/ui/constant_elements/notification_feed/notification_feed",
		use_hud_scale = true,
		class_name = "ConstantElementNotificationFeed",
		filename = "scripts/ui/constant_elements/elements/notification_feed/constant_element_notification_feed",
		visibility_groups = {
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		class_name = "ConstantElementWatermark",
		filename = "scripts/ui/constant_elements/elements/watermark/constant_element_watermark",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		class_name = "ConstantElementBetaLabel",
		filename = "scripts/ui/constant_elements/elements/beta_label/constant_element_beta_label",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		package = "packages/ui/constant_elements/mission_lobby_status/mission_lobby_status",
		class_name = "ConstantMissionLobbyStatus",
		filename = "scripts/ui/constant_elements/elements/mission_lobby_status/constant_element_mission_lobby_status",
		visibility_groups = {
			"mission_lobby"
		}
	},
	{
		package = "packages/ui/constant_elements/cursors/cursors",
		class_name = "ConstantElementSoftwareCursor",
		filename = "scripts/ui/constant_elements/elements/software_cursor/constant_element_software_cursor",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		package = "packages/ui/constant_elements/chat/chat",
		visibility_group_parameters_fallback = "default",
		class_name = "ConstantElementChat",
		filename = "scripts/ui/constant_elements/elements/chat/constant_element_chat",
		visibility_groups = {
			"mission_lobby",
			"end_of_round",
			"in_loading",
			"cutscene",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		},
		visibility_group_parameters = {
			default = {
				horizontal_alignment = ChatElementSettings.horizontal_alignment,
				vertical_alignment = ChatElementSettings.vertical_alignment,
				chat_window_offset = ChatElementSettings.chat_window_offset,
				chat_window_size = ChatElementSettings.chat_window_size
			},
			mission_lobby = {
				horizontal_alignment = "right",
				chat_window_offset = {
					-ChatElementSettings.chat_window_offset[1]
				}
			},
			end_of_round = {
				horizontal_alignment = "right",
				chat_window_offset = {
					-ChatElementSettings.chat_window_offset[1]
				}
			}
		}
	},
	{
		class_name = "ConstantElementHavocStatus",
		filename = "scripts/ui/constant_elements/elements/havoc/constant_element_havoc_status",
		visibility_groups = {
			"in_hub"
		}
	},
	{
		class_name = "ConstantElementLoading",
		filename = "scripts/ui/constant_elements/elements/loading/constant_element_loading",
		visibility_groups = {
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		class_name = "ConstantElementOnboardingHandler",
		filename = "scripts/ui/constant_elements/elements/onboarding_handler/constant_element_onboarding_handler",
		visibility_groups = {
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_hub",
			"in_mission",
			"default"
		}
	},
	{
		package = "packages/ui/constant_elements/voice_chat/voice_chat",
		use_hud_scale = true,
		class_name = "ConstantElementVoiceChat",
		filename = "scripts/ui/constant_elements/elements/voice_chat/constant_element_voice_chat",
		visibility_groups = {
			"tactical_overlay",
			"cutscene",
			"mission_lobby",
			"end_of_round",
			"in_view",
			"in_hub_view",
			"in_loading",
			"in_mission",
			"skippable_cinematic"
		}
	},
	{
		package = "packages/ui/constant_elements/mission_buffs/mission_buffs",
		use_hud_scale = true,
		class_name = "ConstantElementMissionBuffs",
		filename = "scripts/ui/constant_elements/elements/mission_buffs/constant_element_mission_buffs",
		visibility_groups = {
			"in_mission"
		}
	}
}

return elements
