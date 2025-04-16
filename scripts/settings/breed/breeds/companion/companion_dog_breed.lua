local BreedBlackboardComponentTemplates = require("scripts/settings/breed/breed_blackboard_component_templates")
local BreedSettings = require("scripts/settings/breed/breed_settings")
local HitZone = require("scripts/utilities/attack/hit_zone")
local MinionVisualLoadoutTemplates = require("scripts/settings/minion_visual_loadout/minion_visual_loadout_templates")
local PerceptionSettings = require("scripts/settings/perception/perception_settings")
local SmartObjectSettings = require("scripts/settings/navigation/smart_object_settings")
local TargetSelectionTemplates = require("scripts/extension_systems/perception/target_selection_templates")
local TargetSelectionWeights = require("scripts/settings/minion_target_selection/minion_target_selection_weights")
local breed_types = BreedSettings.types
local hit_zone_names = HitZone.hit_zone_names
local breed_name = "companion_dog"
local breed_data = {
	run_speed = 5,
	end_of_round_state_machine = "content/characters/player/companion_dog/third_person/animations/unarmed",
	inventory_state_machine = "content/characters/player/companion_dog/third_person/animations/unarmed",
	look_at_distance = 20,
	fx_proximity_culling_weight = 6,
	unit_template_name = "minion_companion_dog",
	character_creation_state_machine = "content/characters/player/companion_dog/third_person/animations/unarmed",
	faction_name = "imperium",
	mission_intro_state_machine = "content/characters/player/companion_dog/third_person/animations/unarmed",
	uses_script_components = true,
	target_stickiness_distance = 10,
	broadphase_radius = 1,
	walk_speed = 2,
	base_height = 1.5,
	player_locomotion_constrain_radius = 0.7,
	fx_node = "fx_jaw",
	use_bone_lod = false,
	force_aggro = true,
	line_of_sight_collision_filter = "filter_minion_line_of_sight_check",
	display_name = "loc_breed_display_name_undefined",
	use_avoidance = true,
	looping_moving_sound_event_start = "wwise/events/npc/play_adamant_dog_vce_breath_loop",
	navigation_propagation_box_extent = 200,
	looping_moving_sound_event_stop = "wwise/events/npc/stop_adamant_dog_vce_breath_loop",
	portrait_state_machine = "content/characters/player/companion_dog/third_person/animations/unarmed",
	use_navigation_path_splines = true,
	game_object_type = "minion_companion_dog",
	base_unit = "content/characters/player/companion_dog/third_person/base",
	challenge_rating = 0,
	bone_lod_radius = 1.5,
	name = breed_name,
	breed_type = breed_types.companion,
	tags = {
		minion = true,
		companion = true
	},
	inventory = MinionVisualLoadoutTemplates.companion_dog,
	sounds = require("scripts/settings/breed/breeds/companion/companion_dog_sounds"),
	vfx = require("scripts/settings/breed/breeds/companion/companion_dog_vfx"),
	look_at_tag = breed_name,
	behavior_tree_name = breed_name,
	outline_config = {},
	animation_variables = {
		"walk_speed",
		"trot_speed",
		"canter_speed",
		"gallop_speed",
		"gallop_fast_speed",
		"attack_start_angle",
		"gallop_lean"
	},
	animation_variable_bounds = {
		walk_speed = {
			0.2,
			1.2
		},
		trot_speed = {
			0.7,
			1.3
		},
		canter_speed = {
			0.8,
			1.3
		},
		gallop_speed = {
			0.9,
			1.4
		},
		gallop_fast_speed = {
			1.4,
			1.5
		}
	},
	animation_variable_init = {
		gallop_fast_speed = 0.5,
		walk_speed = 0.5,
		gallop_speed = 0.5,
		canter_speed = 0.5,
		trot_speed = 0.5
	},
	animation_speed_thresholds = {
		walk = {
			speed_variable = "walk_speed",
			min = 0,
			event_name = "to_walk",
			offset = 0.3,
			max = 1.8
		},
		trot = {
			speed_variable = "trot_speed",
			min = 1.8,
			event_name = "to_trot",
			offset = 0.3,
			max = 3.6
		},
		canter = {
			speed_variable = "canter_speed",
			min = 3.6,
			event_name = "to_canter",
			offset = 0.3,
			max = 4.8
		},
		gallop = {
			speed_variable = "gallop_speed",
			min = 4.8,
			event_name = "to_gallop",
			offset = 0.3,
			max = 9
		},
		gallop_fast = {
			speed_variable = "gallop_fast_speed",
			min = 9,
			event_name = "to_gallop_fast",
			offset = 0.3,
			max = 10
		}
	},
	navigation_path_spline_config = {
		spline_distance_to_borders = 2,
		spline_recomputation_ratio = 0.5,
		navigation_channel_radius = 6,
		turn_sampling_angle = 30,
		spline_length = 100,
		channel_smoothing_angle = 15,
		max_distance_to_spline_position = 5,
		max_distance_between_gates = 5,
		min_distance_between_gates = 0.25
	},
	nav_tag_allowed_layers = {
		ledges_with_fence = 40,
		cover_vaults = 0.5,
		jumps = 40,
		ledges = 40,
		cover_ledges = 40
	},
	smart_object_template = SmartObjectSettings.templates.chaos_hound,
	fade = {
		max_distance = 0.7,
		max_height_difference = 1,
		min_distance = 0.2
	},
	detection_radius = math.huge,
	target_changed_attack_intensities = {
		disabling = 5
	},
	line_of_sight_data = {
		{
			id = "eyes",
			to_node = "enemy_aim_target_03",
			from_node = "j_head",
			offsets = PerceptionSettings.default_minion_line_of_sight_offsets
		}
	},
	target_selection_template = TargetSelectionTemplates.companion_dog,
	target_selection_weights = TargetSelectionWeights.companion_dog,
	threat_config = {
		threat_multiplier = 1,
		max_threat = 50,
		threat_decay_per_second = 2.5
	},
	aim_config = {
		lerp_speed = 200,
		target = "head_aim_target",
		distance = 5,
		node = "j_neck",
		target_node = "enemy_aim_target_03"
	},
	combat_vector_config = {
		choose_furthest_away = true,
		default_combat_range = "far",
		valid_combat_ranges = {
			far = true
		}
	},
	hit_zones = {
		{
			name = hit_zone_names.center_mass,
			actors = {
				"c_spine",
				"c_spine1",
				"c_spine2"
			}
		}
	},
	blackboard_component_config = BreedBlackboardComponentTemplates.companion_dog,
	testify_flags = {
		spawn_all_enemies = false
	}
}

return breed_data
