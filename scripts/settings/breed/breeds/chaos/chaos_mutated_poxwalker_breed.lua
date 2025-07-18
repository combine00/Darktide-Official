local ArmorSettings = require("scripts/settings/damage/armor_settings")
local BreedBlackboardComponentTemplates = require("scripts/settings/breed/breed_blackboard_component_templates")
local BreedCombatRanges = require("scripts/settings/breed/breed_combat_ranges")
local BreedSettings = require("scripts/settings/breed/breed_settings")
local BreedTerrorEventSettings = require("scripts/settings/breed/breed_terror_event_settings")
local HitZone = require("scripts/utilities/attack/hit_zone")
local MinionDifficultySettings = require("scripts/settings/difficulty/minion_difficulty_settings")
local MinionGibbingTemplates = require("scripts/managers/minion/minion_gibbing_templates")
local MinionVisualLoadoutTemplates = require("scripts/settings/minion_visual_loadout/minion_visual_loadout_templates")
local NavigationCostSettings = require("scripts/settings/navigation/navigation_cost_settings")
local PerceptionSettings = require("scripts/settings/perception/perception_settings")
local SmartObjectSettings = require("scripts/settings/navigation/smart_object_settings")
local StaggerSettings = require("scripts/settings/damage/stagger_settings")
local TargetSelectionTemplates = require("scripts/extension_systems/perception/target_selection_templates")
local TargetSelectionWeights = require("scripts/settings/minion_target_selection/minion_target_selection_weights")
local WeakspotSettings = require("scripts/settings/damage/weakspot_settings")
local DamageProfileTemplates = require("scripts/settings/damage/damage_profile_templates")
local armor_types = ArmorSettings.types
local breed_types = BreedSettings.types
local hit_zone_names = HitZone.hit_zone_names
local stagger_types = StaggerSettings.stagger_types
local weakspot_types = WeakspotSettings.types
local breed_name = "chaos_mutated_poxwalker"
local breed_data = {
	spawn_inventory_slot = "slot_melee_weapon",
	walk_speed = 2.3,
	use_bone_lod = true,
	sub_faction_name = "chaos",
	fx_proximity_culling_weight = 1,
	ignore_ally_alerts = true,
	detection_radius = 12,
	unit_template_name = "minion",
	slot_template = "chaos_poxwalker",
	broadphase_radius = 1,
	stagger_resistance = 0.75,
	use_avoidance = true,
	can_be_blinded = true,
	game_object_type = "minion_melee",
	challenge_rating = 0.4,
	bone_lod_radius = 1.1,
	use_wounds = true,
	power_level_type = "horde_default_melee",
	display_name = "loc_breed_display_name_chaos_mutated_poxwalker",
	run_speed = 3.5,
	spawn_anim_state = "to_1h_weapon",
	faction_name = "chaos",
	base_height = 1.7,
	line_of_sight_collision_filter = "filter_minion_line_of_sight_check",
	player_locomotion_constrain_radius = 0.6,
	activate_slot_system_on_spawn = true,
	explosion_power_multiplier = 0.65,
	base_unit = "content/characters/enemy/chaos_poxwalker/third_person/base_tentacle",
	has_direct_ragdoll_flow_event = true,
	name = breed_name,
	breed_type = breed_types.minion,
	tags = {
		melee = true,
		poxwalker = true,
		minion = true,
		horde = true
	},
	point_cost = BreedTerrorEventSettings[breed_name].point_cost,
	armor_type = armor_types.disgustingly_resilient,
	hit_mass = MinionDifficultySettings.hit_mass[breed_name],
	gib_template = MinionGibbingTemplates.chaos_mutated_poxwalker,
	stagger_durations = {
		[stagger_types.light] = 0.5,
		[stagger_types.medium] = 0.8,
		[stagger_types.heavy] = 2.4,
		[stagger_types.light_ranged] = 0.75,
		[stagger_types.explosion] = 8.3,
		[stagger_types.killshot] = 1,
		[stagger_types.sticky] = 1,
		[stagger_types.blinding] = 5
	},
	stagger_thresholds = {
		[stagger_types.light] = 1,
		[stagger_types.medium] = 10,
		[stagger_types.heavy] = 20,
		[stagger_types.explosion] = 40,
		[stagger_types.light_ranged] = 8,
		[stagger_types.killshot] = 4
	},
	stagger_immune_times = {
		[stagger_types.light] = 0.2,
		[stagger_types.medium] = 0.2,
		[stagger_types.heavy] = 2.25,
		[stagger_types.light_ranged] = 0.2,
		[stagger_types.explosion] = 4,
		[stagger_types.killshot] = 0.5
	},
	inventory = MinionVisualLoadoutTemplates.chaos_mutated_poxwalker,
	sounds = require("scripts/settings/breed/breeds/chaos/chaos_mutated_poxwalker_sounds"),
	vfx = require("scripts/settings/breed/breeds/chaos/chaos_common_vfx"),
	behavior_tree_name = breed_name,
	animation_variables = {
		"moving_attack_fwd_speed",
		"anim_move_speed"
	},
	animation_variable_bounds = {
		anim_move_speed = {
			1,
			85
		}
	},
	animation_variable_init = {
		anim_move_speed = 1
	},
	combat_range_data = BreedCombatRanges.chaos_poxwalker,
	attack_intensity_cooldowns = {
		melee = {
			0.7,
			1.25
		},
		moving_melee = {
			0.7,
			0.8
		},
		running_melee = {
			1.7,
			2.8
		}
	},
	line_of_sight_data = {
		{
			id = "eyes",
			to_node = "enemy_aim_target_03",
			from_node = "j_head",
			offsets = PerceptionSettings.default_minion_line_of_sight_offsets
		}
	},
	target_selection_template = TargetSelectionTemplates.melee,
	target_selection_weights = TargetSelectionWeights.chaos_poxwalker,
	threat_config = {
		threat_multiplier = 0.1,
		max_threat = 50,
		threat_decay_per_second = 5
	},
	nav_cost_map_multipliers = {
		fire = NavigationCostSettings.IGNORE_NAV_COST_MAP_LAYER
	},
	nav_tag_allowed_layers = {
		cover_vaults = 0.9
	},
	randomized_nav_tag_costs = {
		{
			layer_name = "teleporters",
			chance_to_pick_first_index = 0.5,
			costs = {
				0.5,
				2
			}
		},
		{
			layer_name = "ledges",
			chance_to_pick_first_index = 0.1,
			costs = {
				1,
				10
			}
		},
		{
			layer_name = "ledges_with_fence",
			chance_to_pick_first_index = 0.1,
			costs = {
				1,
				10
			}
		},
		{
			layer_name = "cover_ledges",
			chance_to_pick_first_index = 0.1,
			costs = {
				1,
				10
			}
		}
	},
	smart_object_template = SmartObjectSettings.templates.chaos_poxwalker,
	size_variation_range = {
		0.9,
		1.1
	},
	fade = {
		max_distance = 0.7,
		max_height_difference = 1,
		min_distance = 0.2
	},
	hit_zones = {
		{
			name = hit_zone_names.head,
			actors = {
				"c_head",
				"c_neck"
			}
		},
		{
			name = hit_zone_names.torso,
			actors = {
				"c_hips",
				"c_spine1",
				"c_spine2",
				"c_rightshoulder"
			}
		},
		{
			name = hit_zone_names.tentacle,
			actors = {
				"c_leftshoulder"
			}
		},
		{
			name = hit_zone_names.upper_right_arm,
			actors = {
				"c_rightarm"
			}
		},
		{
			name = hit_zone_names.lower_right_arm,
			actors = {
				"c_rightforearm",
				"c_righthand"
			}
		},
		{
			name = hit_zone_names.upper_left_leg,
			actors = {
				"c_leftupleg"
			}
		},
		{
			name = hit_zone_names.lower_left_leg,
			actors = {
				"c_leftleg",
				"c_leftfoot"
			}
		},
		{
			name = hit_zone_names.upper_right_leg,
			actors = {
				"c_rightupleg"
			}
		},
		{
			name = hit_zone_names.lower_right_leg,
			actors = {
				"c_rightleg",
				"c_rightfoot"
			}
		},
		{
			name = hit_zone_names.afro,
			actors = {
				"r_afro"
			}
		},
		{
			name = hit_zone_names.center_mass,
			actors = {
				"c_hips",
				"c_spine1"
			}
		}
	},
	hit_zone_ragdoll_actors = {
		[hit_zone_names.head] = {
			"j_head",
			"j_neck"
		},
		[hit_zone_names.torso] = {
			"j_head",
			"j_neck",
			"j_spine1",
			"j_spine2",
			"j_rightshoulder",
			"j_rightarm",
			"j_rightforearm",
			"j_righthand"
		},
		[hit_zone_names.tentacle] = {
			"j_leftshoulder"
		},
		[hit_zone_names.upper_right_arm] = {
			"j_rightarm",
			"j_rightforearm",
			"j_righthand"
		},
		[hit_zone_names.lower_right_arm] = {
			"j_rightforearm",
			"j_righthand"
		},
		[hit_zone_names.upper_left_leg] = {
			"j_leftupleg",
			"j_leftleg",
			"j_leftfoot"
		},
		[hit_zone_names.lower_left_leg] = {
			"j_leftleg",
			"j_leftfoot"
		},
		[hit_zone_names.upper_right_leg] = {
			"j_rightupleg",
			"j_rightleg",
			"j_rightfoot"
		},
		[hit_zone_names.lower_right_leg] = {
			"j_rightleg",
			"j_rightfoot"
		}
	},
	hit_zone_ragdoll_pushes = {
		[hit_zone_names.head] = {
			j_rightshoulder = 0.15,
			j_spine1 = 0.1,
			j_spine = 0.3,
			j_head = 0.5,
			j_neck = 0.5
		},
		[hit_zone_names.torso] = {
			j_rightshoulder = 0,
			j_spine1 = 0.7,
			j_spine = 0.2,
			j_head = 0.1,
			j_neck = 0.1
		},
		[hit_zone_names.tentacle] = {
			j_leftshoulder = 0.15
		},
		[hit_zone_names.upper_right_arm] = {
			j_rightshoulder = 0.4,
			j_spine1 = 0.1,
			j_spine = 0.15,
			j_rightuparm = 0.8,
			j_head = 0.05,
			j_neck = 0.05
		},
		[hit_zone_names.lower_right_arm] = {
			j_rightshoulder = 0.4,
			j_spine1 = 0.1,
			j_spine = 0.15,
			j_rightuparm = 0.8,
			j_head = 0.05,
			j_neck = 0.05
		},
		[hit_zone_names.upper_left_leg] = {
			j_leftleg = 0.35,
			j_leftupleg = 0.35,
			j_spine = 0,
			j_leftfoot = 0.1,
			j_hips = 0.2,
			j_spine1 = 0.1
		},
		[hit_zone_names.lower_left_leg] = {
			j_leftleg = 0.35,
			j_leftupleg = 0.35,
			j_spine = 0,
			j_leftfoot = 0.1,
			j_hips = 0.2,
			j_spine1 = 0.1
		},
		[hit_zone_names.upper_right_leg] = {
			j_rightfoot = 0.3,
			j_rightupleg = 0.4,
			j_spine = 0,
			j_hips = 0.1,
			j_rightleg = 0.25,
			j_spine1 = 0
		},
		[hit_zone_names.lower_right_leg] = {
			j_rightfoot = 0.3,
			j_rightupleg = 0.4,
			j_spine = 0,
			j_hips = 0.1,
			j_rightleg = 0.25,
			j_spine1 = 0
		},
		[hit_zone_names.center_mass] = {
			j_hips = 0.5,
			j_spine = 0.5
		}
	},
	hit_zone_weakspot_types = {
		[hit_zone_names.head] = weakspot_types.headshot
	},
	hitzone_damage_multiplier = {
		ranged = {
			[hit_zone_names.lower_right_arm] = 0.5,
			[hit_zone_names.lower_left_leg] = 0.5,
			[hit_zone_names.lower_right_leg] = 0.5
		}
	},
	outline_config = {},
	blackboard_component_config = BreedBlackboardComponentTemplates.melee_base,
	tokens = {},
	companion_pounce_setting = {
		pounce_anim_event = "leap_attack",
		companion_pounce_action = "human",
		damage_profile = DamageProfileTemplates.adamant_companion_human_pounce,
		initial_damage_profile = DamageProfileTemplates.adamant_companion_initial_pounce,
		required_token = {
			free_target_on_assigned_token = true,
			name = "pounced"
		}
	}
}

return breed_data
