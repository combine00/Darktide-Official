local Settings = require("scripts/ui/views/mission_board_view_pj/mission_board_view_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local Dimensions = Settings.dimensions
local MissionBoardViewStyles = {
	colors = {}
}

local function _adjust_color(color, k)
	if not color then
		return {
			255,
			255,
			255,
			255
		}
	end

	return {
		color[1],
		math.clamp(color[2] * k, 0, 255),
		math.clamp(color[3] * k, 0, 255),
		math.clamp(color[4] * k, 0, 255)
	}
end

local default_colors = {
	background = {
		200,
		0,
		0,
		0
	},
	corner = Color.terminal_corner(nil, true),
	frame = {
		255,
		101,
		145,
		102
	},
	main = {
		255,
		101,
		145,
		102
	},
	main_light = Color.terminal_text_header(nil, true),
	accent = Color.golden_rod(nil, true),
	disabled = {
		255,
		78,
		87,
		80
	},
	gray = {
		200,
		135,
		153,
		131
	},
	cursor = Color.golden_rod(nil, true),
	dark_opacity = {
		75,
		0,
		0,
		0
	},
	green_faded = {
		128,
		169,
		211,
		158
	},
	corner_selected = Color.terminal_corner_selected(nil, true),
	text_title = {
		255,
		167,
		190,
		151
	},
	text_body = {
		255,
		101,
		145,
		102
	},
	text_sub_header = {
		255,
		101,
		145,
		102
	},
	terminal_header_text = {
		255,
		167,
		190,
		151
	},
	terminal_frame = {
		255,
		101,
		145,
		102
	},
	terminal_text_dark = {
		255,
		0,
		162,
		70
	},
	terminal_text_darker = _adjust_color({
		255,
		0,
		162,
		70
	}, 0.5)
}
local story_default_color = {
	255,
	255,
	88,
	27
}
local color_by_mission_type = {
	default = {
		selected_color = _adjust_color(default_colors.main, 1.35),
		hover_color = _adjust_color(default_colors.main, 1.15),
		default_color = table.shallow_copy(default_colors.main),
		corner_color = _adjust_color(default_colors.main, 0.75),
		disabled_color = _adjust_color(default_colors.main, 0.5)
	},
	story = {
		selected_color = _adjust_color(story_default_color, 1.35),
		hover_color = _adjust_color(story_default_color, 1.15),
		default_color = {
			255,
			255,
			88,
			27
		},
		corner_color = _adjust_color(story_default_color, 0.75),
		disabled_color = _adjust_color(story_default_color, 0.5)
	},
	common = {
		selected_color = _adjust_color(default_colors.main, 1.35),
		hover_color = _adjust_color(default_colors.main, 1.15),
		default_color = table.shallow_copy(default_colors.main),
		corner_color = _adjust_color(default_colors.main, 0.75),
		disabled_color = _adjust_color(default_colors.main, 0.5)
	},
	maelstrom = {
		selected_color = _adjust_color(default_colors.main, 1.35),
		hover_color = _adjust_color(default_colors.main, 1.15),
		default_color = table.shallow_copy(default_colors.main),
		corner_color = _adjust_color(default_colors.main, 0.75),
		disabled_color = _adjust_color(default_colors.main, 0.5)
	},
	event = {
		selected_color = _adjust_color(default_colors.main, 1.35),
		hover_color = _adjust_color(default_colors.main, 1.15),
		default_color = table.shallow_copy(default_colors.main),
		corner_color = _adjust_color(default_colors.main, 0.75),
		disabled_color = _adjust_color(default_colors.main, 0.5)
	}
}
MissionBoardViewStyles.colors.default = default_colors
MissionBoardViewStyles.colors.color_by_mission_type = color_by_mission_type
MissionBoardViewStyles.difficulty_progress_tooltip = {
	background = {
		scale_to_material = true,
		size = {
			Dimensions.threat_tooltip_size[1],
			Dimensions.threat_tooltip_size[2]
		},
		offset = {
			0,
			0,
			3
		},
		color = Color.black(255, true)
	},
	frame = {
		scale_to_material = true,
		size = {
			Dimensions.threat_tooltip_size[1],
			Dimensions.threat_tooltip_size[2]
		},
		offset = {
			0,
			0,
			4
		},
		color = {
			255,
			169,
			211,
			158
		}
	},
	text = {
		font_size = 16,
		text_vertical_alignment = "center",
		horizontal_alignment = "center",
		text_horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "proxima_nova_medium",
		size = {
			Dimensions.threat_tooltip_size[1] - 20,
			Dimensions.threat_tooltip_size[2] - 10
		},
		text_color = table.shallow_copy(default_colors.terminal_text_dark),
		offset = {
			0,
			0,
			5
		}
	}
}
MissionBoardViewStyles.screen_frame = {
	scale_to_material = true,
	size = {},
	offset = {
		0,
		0,
		-50
	},
	color = Color.white(nil, true)
}
MissionBoardViewStyles.screen_frame_glow = {
	vertical_alignment = "bottom",
	horizontal_alignment = "center",
	scale_to_material = true,
	size = {
		1330,
		308
	},
	offset = {
		-705,
		0,
		1
	},
	color = Color.white(nil, true)
}
MissionBoardViewStyles.difficulty_progress_bar = {
	frame = {
		scale_to_material = true,
		size = {
			nil,
			8
		},
		offset = {
			0,
			0,
			5
		},
		color = Color.white(nil, true)
	},
	progress_bar = {
		scale_to_material = true,
		size = {
			Dimensions.threat_level_progress_bar_size[1],
			Dimensions.threat_level_progress_bar_size[2]
		},
		default_size = {
			Dimensions.threat_level_progress_bar_size[1],
			Dimensions.threat_level_progress_bar_size[2]
		},
		offset = {
			0,
			0,
			4
		},
		color = Color.white(nil, true)
	}
}
MissionBoardViewStyles.play_button = {
	default = {
		scale_to_material = true,
		offset = {
			0,
			0,
			3
		}
	},
	hover = {
		vertical_alignment = "center",
		scale_to_material = true,
		horizontal_alignment = "center",
		offset = {
			0,
			1,
			4
		},
		color = {
			125,
			255,
			255,
			255
		}
	},
	hotspot = {
		horizontal_alignment = "center",
		vertical_alignment = "center",
		on_hover_sound = UISoundEvents.default_mouse_hover,
		on_pressed_sound = UISoundEvents.default_click,
		offset = {
			0,
			0,
			2
		},
		size = {
			268,
			40
		},
		color = {
			255,
			255,
			255,
			0
		}
	},
	disabled = {
		hdr = true,
		scale_to_material = true,
		offset = {
			0,
			0,
			3
		}
	},
	default_text = {
		text_vertical_alignment = "center",
		font_size = 28,
		horizontal_alignment = "center",
		text_horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "proxima_nova_bold",
		offset = {
			0,
			0,
			5
		},
		size_addition = {
			0,
			0
		},
		text_color = Color.light_green(nil, true)
	},
	selected_text = {
		text_vertical_alignment = "center",
		font_size = 32,
		horizontal_alignment = "center",
		text_horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "proxima_nova_bold",
		offset = {
			0,
			0,
			5
		},
		size_addition = {
			0,
			0
		},
		text_color = Color.black(nil, true)
	},
	disabled_text = {
		text_vertical_alignment = "center",
		horizontal_alignment = "center",
		font_size = 18,
		text_horizontal_alignment = "center",
		vertical_alignment = "center",
		font_type = "proxima_nova_medium",
		size = {
			345,
			72
		},
		offset = {
			0,
			0,
			5
		},
		size_addition = {
			0,
			0
		},
		text_color = Color.ui_interaction_critical(255, true)
	}
}
MissionBoardViewStyles.threat_level_progress = {
	background = {
		scale_to_material = true,
		offset = {
			0,
			0,
			3
		},
		color = Color.black(95, true)
	},
	background_frame = {
		scale_to_material = true,
		offset = {
			0,
			0,
			4
		},
		color = {
			255,
			169,
			211,
			158
		}
	},
	background_frame_corner = {
		scale_to_material = true,
		offset = {
			0,
			0,
			5
		},
		size_addition = {
			5,
			5
		},
		color = Color.terminal_text_header(nil, true)
	},
	threat_level_text = {
		vertical_alignment = "top",
		font_type = "proxima_nova_bold",
		horizontal_alignment = "left",
		font_size = 18,
		text_vertical_alignment = "top",
		text_horizontal_alignment = "left",
		offset = {
			10,
			10,
			5
		},
		text_color = {
			255,
			169,
			211,
			158
		}
	},
	threat_level_progression_text = {
		vertical_alignment = "center",
		font_type = "proxima_nova_bold",
		horizontal_alignment = "left",
		font_size = 18,
		text_vertical_alignment = "center",
		text_horizontal_alignment = "left",
		offset = {
			10,
			0,
			5
		},
		text_color = {
			255,
			169,
			211,
			158
		}
	},
	threat_level_exp_text = {
		vertical_alignment = "bottom",
		font_type = "proxima_nova_bold",
		horizontal_alignment = "right",
		font_size = 18,
		text_vertical_alignment = "bottom",
		text_horizontal_alignment = "right",
		offset = {
			-5,
			-5,
			5
		},
		text_color = {
			255,
			169,
			211,
			158
		}
	},
	progress_bar = {
		vertical_alignment = "bottom",
		horizontal_alignment = "left",
		scale_to_material = true,
		size = {
			0,
			Dimensions.threat_level_progress_bar_size[2]
		},
		offset = {
			10,
			-10,
			5
		},
		color = Color.golden_rod(nil, true)
	},
	progress_bar_bg = {
		vertical_alignment = "bottom",
		horizontal_alignment = "left",
		scale_to_material = true,
		size = Dimensions.threat_level_progress_bar_size,
		offset = {
			10,
			-10,
			4
		},
		color = Color.gray(185, true)
	}
}
MissionBoardViewStyles.mission_area_info = {
	image = {
		vertical_alignment = "bottom",
		horizontal_alignment = "center",
		size = {
			480,
			270
		},
		offset = {
			0,
			0,
			1
		},
		material_values = {
			texture_map = "content/ui/textures/missions/quickplay"
		}
	},
	inner_shadow = {
		vertical_alignment = "bottom",
		scale_to_material = true,
		horizontal_alignment = "center",
		color = {
			255,
			0,
			0,
			0
		},
		offset = {
			0,
			0,
			2
		}
	},
	lock = {
		vertical_alignment = "bottom",
		horizontal_alignment = "center",
		scale_to_material = true,
		size = {
			252,
			252
		},
		offset = {
			0,
			-10,
			5
		},
		color = {
			125,
			255,
			255,
			255
		}
	},
	outer_frame = {
		scale_to_material = true,
		color = table.shallow_copy(default_colors.terminal_frame),
		offset = {
			0,
			0,
			10
		}
	},
	title_frame = {
		vertical_alignment = "top",
		scale_to_material = true,
		horizontal_alignment = "center",
		size = {
			Dimensions.details_width,
			66
		},
		color = Color.terminal_frame(nil, true),
		offset = {
			0,
			0,
			2
		}
	},
	title_background = {
		vertical_alignment = "top",
		scale_to_material = true,
		horizontal_alignment = "center",
		size = {
			Dimensions.details_width,
			66
		},
		color = Color.black(165, true),
		offset = {
			0,
			0,
			-1
		}
	},
	mission_title = {
		font_size = 24,
		text_vertical_alignment = "top",
		horizontal_alignment = "center",
		text_horizontal_alignment = "left",
		vertical_alignment = "top",
		font_type = "proxima_nova_bold",
		size = {
			Dimensions.details_width,
			78
		},
		text_color = table.shallow_copy(default_colors.terminal_header_text),
		offset = {
			20,
			8,
			2
		}
	},
	mission_sub_title = {
		font_size = 18,
		text_vertical_alignment = "top",
		horizontal_alignment = "center",
		text_horizontal_alignment = "left",
		vertical_alignment = "top",
		font_type = "proxima_nova_medium",
		size = {
			Dimensions.details_width,
			78
		},
		text_color = table.shallow_copy(default_colors.text_sub_header),
		offset = {
			20,
			34,
			2
		}
	},
	timer = {}
}
MissionBoardViewStyles.mission_area_info.timer.timer_bar_frame = {
	vertical_alignment = "top",
	scale_to_material = true,
	horizontal_alignment = "right",
	offset = {
		0,
		-28,
		4
	},
	size = {
		364,
		28
	},
	color = table.shallow_copy(default_colors.terminal_frame)
}
MissionBoardViewStyles.mission_area_info.timer.timer_frame = {
	vertical_alignment = "top",
	scale_to_material = true,
	horizontal_alignment = "right",
	offset = {
		-20,
		-(Dimensions.sidebar_small_buffer - 8 + 13),
		4
	},
	size = {
		320,
		8
	},
	color = table.shallow_copy(default_colors.terminal_frame)
}
MissionBoardViewStyles.mission_area_info.timer.timer_bar = {
	vertical_alignment = "top",
	horizontal_alignment = "right",
	offset = {
		-20,
		-(Dimensions.sidebar_small_buffer - 8 + 13),
		3
	},
	size = {
		320,
		8
	},
	material_values = {
		progress = 1
	},
	color = table.shallow_copy(default_colors.main)
}
MissionBoardViewStyles.mission_area_info.timer.timer_text_frame = {
	vertical_alignment = "top",
	scale_to_material = true,
	horizontal_alignment = "left",
	offset = {
		0,
		-28,
		4
	},
	size = {
		120,
		28
	},
	color = table.shallow_copy(default_colors.terminal_frame)
}
MissionBoardViewStyles.mission_area_info.timer.timer_icon = {
	vertical_alignment = "top",
	horizontal_alignment = "left",
	size = {
		19,
		19
	},
	offset = {
		16,
		-(19 + Dimensions.sidebar_small_buffer - 8),
		3
	},
	color = table.shallow_copy(default_colors.terminal_header_text)
}
MissionBoardViewStyles.mission_area_info.timer.timer_text = {
	font_size = 20,
	text_vertical_alignment = "bottom",
	horizontal_alignment = "left",
	vertical_alignment = "top",
	drop_shadow = true,
	font_type = "proxima_nova_bold",
	size = {
		nil,
		24
	},
	offset = {
		40,
		-(Dimensions.sidebar_small_buffer - 8 + 21),
		3
	},
	text_color = table.shallow_copy(default_colors.terminal_header_text)
}
MissionBoardViewStyles.mission_area_info.timer.infinite_symbol = {
	vertical_alignment = "top",
	horizontal_alignment = "left",
	visible = true,
	size = {
		25.2,
		14.399999999999999
	},
	offset = {
		46,
		-20,
		10
	},
	color = table.shallow_copy(default_colors.terminal_header_text)
}
MissionBoardViewStyles.mission_area_info.circumstance = {
	circumstance_title = {
		font_size = 24,
		text_vertical_alignment = "top",
		font_type = "proxima_nova_bold",
		text_horizontal_alignment = "left",
		size = {
			Dimensions.details_width - 90 - 21
		},
		text_color = Color.terminal_text_header(nil, true),
		offset = {
			90,
			10,
			7
		}
	},
	circumstance_description = {
		font_size = 18,
		text_vertical_alignment = "top",
		font_type = "proxima_nova_medium",
		text_horizontal_alignment = "left",
		size = {
			Dimensions.details_width - 90 - 21
		},
		text_color = Color.terminal_text_body(nil, true),
		offset = {
			90,
			40,
			7
		}
	},
	background = {
		vertical_alignment = "center",
		horizontal_alignment = "right",
		offset = {
			0,
			0,
			6
		},
		color = {
			165,
			0,
			0,
			0
		}
	},
	corner = {
		vertical_alignment = "center",
		horizontal_alignment = "right",
		scale_to_material = true,
		visible = false,
		size = {
			32,
			32
		},
		offset = {
			16,
			0,
			7
		}
	},
	icon = {
		vertical_alignment = "center",
		visible = false,
		horizontal_alignment = "left",
		size = {
			64,
			64
		},
		size_addition = {
			-4,
			-4
		},
		offset = {
			14,
			0,
			7
		}
	},
	story_icon = {
		vertical_alignment = "center",
		visible = false,
		horizontal_alignment = "left",
		size = {
			73.6,
			73.6
		},
		size_addition = {
			-4,
			-4
		},
		offset = {
			14,
			0,
			7
		},
		material_values = {
			gradient_map = "content/ui/textures/mission_board/gradient_digital_circumstances"
		}
	},
	rect_detail = {
		vertical_alignment = "center",
		horizontal_alignment = "left",
		scale_to_material = true,
		size = {
			4
		},
		offset = {
			0,
			0,
			6
		}
	}
}
MissionBoardViewStyles.objectives_panel = {
	frame = {
		scale_to_material = true,
		offset = {
			0,
			0,
			5
		},
		color = table.shallow_copy(default_colors.terminal_frame)
	},
	sub_title = {
		vertical_alignment = "top",
		font_size = 16,
		horizontal_alignment = "center",
		font_type = "proxima_nova_medium",
		text_vertical_alignment = "top",
		text_horizontal_alignment = "left",
		text_color = default_colors.text_sub_header,
		offset = {
			68,
			16,
			5
		}
	},
	title = {
		vertical_alignment = "top",
		font_size = 18,
		horizontal_alignment = "center",
		font_type = "proxima_nova_bold",
		text_vertical_alignment = "top",
		text_horizontal_alignment = "left",
		text_color = table.shallow_copy(default_colors.terminal_header_text),
		offset = {
			68,
			34,
			5
		}
	},
	icon = {
		vertical_alignment = "center",
		horizontal_alignment = "left",
		size = {
			55.199999999999996,
			55.199999999999996
		},
		size_addition = {
			-4,
			-4
		},
		color = Color.white(255, true),
		offset = {
			10,
			0,
			5
		}
	},
	background_gradient = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		offset = {
			0,
			0,
			2
		},
		color = table.shallow_copy(default_colors.terminal_header_text)
	},
	hotspot = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		offset = {
			0,
			0,
			1
		},
		on_hover_sound = UISoundEvents.default_mouse_hover,
		on_pressed_sound = UISoundEvents.default_click
	}
}
MissionBoardViewStyles.mission_objective_info = {
	frame = {
		scale_to_material = true,
		offset = {
			0,
			0,
			20
		},
		color = table.shallow_copy(default_colors.terminal_frame)
	},
	objective_description = {
		font_type = "proxima_nova_medium",
		font_size = 18,
		text_vertical_alignment = "top",
		text_horizontal_alignment = "left",
		text_color = table.shallow_copy(default_colors.text_body),
		offset = {
			20,
			80,
			7
		},
		size_addition = {
			-40,
			0
		}
	},
	background = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		offset = {
			0,
			0,
			1
		},
		color = {
			255,
			0,
			0,
			0
		}
	},
	mission_giver_frame = {
		vertical_alignment = "bottom",
		horizontal_alignment = "right",
		scale_to_material = true,
		size = {
			Dimensions.details_width * 0.52,
			Dimensions.rewards_height
		},
		offset = {
			0,
			0,
			5
		},
		color = table.shallow_copy(default_colors.terminal_frame)
	},
	mission_giver_name = {
		font_size = 14,
		text_vertical_alignment = "center",
		horizontal_alignment = "right",
		text_horizontal_alignment = "right",
		vertical_alignment = "bottom",
		font_type = "proxima_nova_medium",
		size = {
			Dimensions.details_width * 0.52,
			Dimensions.rewards_height
		},
		text_color = table.shallow_copy(default_colors.terminal_text_dark),
		offset = {
			-36,
			0,
			5
		}
	},
	mission_giver_icon = {
		vertical_alignment = "bottom",
		horizontal_alignment = "right",
		size = {
			26.8,
			32.160000000000004
		},
		color = Color.white(255, true),
		offset = {
			-2,
			-2,
			30
		}
	},
	reward = {}
}
MissionBoardViewStyles.mission_objective_info.reward.frame = {
	scale_to_material = true,
	offset = {
		0,
		0,
		5
	},
	color = table.shallow_copy(default_colors.terminal_frame)
}
MissionBoardViewStyles.mission_objective_info.reward.amount = {
	vertical_alignment = "bottom",
	font_size = 18,
	horizontal_alignment = "left",
	font_type = "proxima_nova_bold",
	text_vertical_alignment = "center",
	text_horizontal_alignment = "left",
	text_color = table.shallow_copy(default_colors.terminal_text_dark),
	offset = {
		10,
		0,
		5
	}
}
MissionBoardViewStyles.mission_objective_info.reward.icon = {
	vertical_alignment = "center",
	horizontal_alignment = "right",
	size = {
		32,
		32
	},
	size_addition = {
		-4,
		-4
	},
	color = Color.white(255, true),
	offset = {
		-6,
		0,
		5
	}
}
MissionBoardViewStyles.mission_tile = {
	fluff_frame = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		default_size = Dimensions.small_mission_size,
		color = {
			80,
			113,
			126,
			103
		},
		offset = {
			0,
			0,
			-2
		},
		size_addition = {
			80,
			60
		}
	},
	glow = {
		horizontal_alignment = "center",
		vertical_alignment = "center",
		scale_to_material = true,
		selected_color = {
			255,
			250,
			189,
			73
		},
		hover_color = {
			255,
			204,
			255,
			204
		},
		default_color = {
			255,
			0,
			0,
			0
		},
		default_size = Dimensions.small_mission_size,
		offset = {
			0,
			0,
			-1
		},
		size_addition = {
			24,
			24
		}
	},
	timer_bar = {
		vertical_alignment = "top",
		horizontal_alignment = "center",
		size = {
			nil,
			5
		},
		offset = {
			0,
			-5,
			1
		},
		material_values = {
			progress = 0.1
		}
	},
	location_image = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		offset = {
			0,
			0,
			1
		},
		material_values = {
			texture_map = "content/ui/textures/pj_missions/fm_cargo_small"
		}
	},
	location_vignette = {
		vertical_alignment = "center",
		scale_to_material = true,
		horizontal_alignment = "center",
		color = {
			255,
			0,
			0,
			0
		},
		offset = {
			0,
			0,
			2
		}
	},
	location_frame = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		scale_to_material = true,
		offset = {
			0,
			0,
			3
		}
	},
	location_cornet = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		scale_to_material = true,
		offset = {
			0,
			0,
			4
		}
	},
	location_lock = {
		drop_shadow = false,
		font_size = 50,
		text_vertical_alignment = "center",
		font_type = "itc_novarese_bold",
		text_horizontal_alignment = "center",
		offset = {
			0,
			0,
			5
		}
	},
	location_rect = {
		vertical_alignment = "center",
		horizontal_alignment = "center",
		visible = false,
		offset = {
			0,
			0,
			2
		},
		color = {
			200,
			0,
			0,
			0
		}
	}
}
MissionBoardViewStyles.gradient_by_category = {
	default = {
		disabled_gradient = "content/ui/textures/mission_board/gradient_digital_disabled_green",
		default_gradient = "content/ui/textures/mission_board/gradient_farme_selected_green",
		selected_gradient = "content/ui/textures/mission_board/gradient_digital_green"
	},
	story = {
		disabled_gradient = "content/ui/textures/mission_board/gradient_digital_disabled_red",
		default_gradient = "content/ui/textures/mission_board/gradient_digital_frame_red",
		selected_gradient = "content/ui/textures/mission_board/gradient_farme_selected_red"
	},
	circumstance = {
		disabled_gradient = "content/ui/textures/mission_board/gradient_digital_circumstances_locked",
		default_gradient = "content/ui/textures/mission_board/gradient_digital_circumnstance_default",
		selected_gradient = "content/ui/textures/mission_board/gradient_digital_circumstances"
	}
}
MissionBoardViewStyles.colors.auric = setmetatable({
	corner = {
		255,
		249,
		231,
		115
	},
	frame = {
		255,
		164,
		139,
		86
	},
	main = {
		255,
		228,
		197,
		130
	},
	green_faded = {
		255,
		171,
		146,
		92
	}
}, {
	__index = MissionBoardViewStyles.colors.default
})

local function _get_color_by_name(color_name, palette_name)
	palette_name = palette_name or "default"

	return MissionBoardViewStyles.colors[palette_name][color_name]
end

function MissionBoardViewStyles.screen_decorations_widget_style_function(mission_type)
	return {
		overlay = {
			color = {
				75,
				0,
				0,
				0
			},
			offset = {
				0,
				0,
				-1
			}
		},
		overlay_top = {
			color = {
				0,
				0,
				0,
				0
			},
			offset = {
				0,
				0,
				500
			}
		},
		corner_right = {
			uvs = {
				{
					1,
					0
				},
				{
					0,
					1
				}
			}
		}
	}
end

function MissionBoardViewStyles.info_box_widget_style_function(mission_type)
	return {
		background = {
			color = {
				150,
				58,
				15,
				15
			}
		},
		frame = {
			scale_to_material = true,
			color = {
				0,
				0,
				0,
				0
			},
			color_info = _get_color_by_name("accent", mission_type),
			color_warning = Color.ui_interaction_critical(255, true),
			offset = {
				0,
				0,
				1
			}
		},
		text = {
			font_type = "proxima_nova_bold",
			font_size = 18,
			text_vertical_alignment = "center",
			text_horizontal_alignment = "center",
			text_color = Color.ui_interaction_critical(255, true),
			offset = {
				0,
				0,
				2
			},
			size_addition = {
				-10,
				0
			}
		}
	}
end

MissionBoardViewStyles.adjust_color = _adjust_color

return settings("MissionBoardViewStyles", MissionBoardViewStyles)
