return {
	name = "adamant_tree",
	node_points = 30,
	version = 2,
	background_height = 2800,
	archetype_name = "adamant",
	talent_points = 30,
	nodes = {
		{
			type = "start",
			y = 430,
			widget_name = "node_43567fd7-f7c3-4b73-9cb5-3fb72af27a23",
			y_normalized = 0,
			max_points = 1,
			icon = "content/ui/textures/icons/talents/zealot/zealot_default_general_talent",
			x = 1120,
			x_normalized = 0,
			children = {
				"node_577dcd33-0991-437a-ac3f-93d5cf1eda97",
				"node_0ebf45d0-b4da-42ea-8735-1d9c31ac2a9f",
				"node_3684f20d-bb13-4f40-ba64-43d402eea435"
			},
			parents = {},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 0,
				all_parents_chosen = false
			}
		},
		{
			type = "aura",
			max_points = 1,
			widget_name = "node_d11bcab3-f47e-43ef-8f26-72e4ed2760fe",
			y = 1400,
			y_normalized = 0,
			talent = "adamant_companion_coherency",
			x = 830,
			x_normalized = 0,
			children = {
				"node_8250a1a1-97b9-4573-af63-05e81541bdeb"
			},
			parents = {
				"node_00091489-4546-42b8-8591-9eb519ade295"
			},
			requirements = {
				min_points_spent = 0,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion",
				children_unlock_points = 1,
				exclusive_group = "aura_1"
			}
		},
		{
			type = "aura",
			max_points = 1,
			widget_name = "node_d9c8ac91-9f39-43f5-9655-c836de0bb997",
			y = 1400,
			y_normalized = 0,
			talent = "adamant_wield_speed_aura",
			x = 1070,
			x_normalized = 0,
			children = {
				"node_a40126d6-c985-42b7-bffb-7234639e6704",
				"node_75d31c92-2869-4bbb-8f63-f0f7b9e15bdf"
			},
			parents = {
				"node_00091489-4546-42b8-8591-9eb519ade295"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "aura_1"
			}
		},
		{
			type = "keystone",
			max_points = 1,
			widget_name = "node_52c3f35e-7fe4-4321-a04c-2a51eccac74c",
			y = 2360,
			y_normalized = 0,
			talent = "adamant_exterminator",
			x = 710,
			x_normalized = 0,
			children = {
				"node_dbdb2b08-b8ce-4dc5-88c9-139f0486b54c",
				"node_8abdbb78-a06d-4d97-959a-a46930ab0752",
				"node_e686dc62-a877-4eef-8a96-52743b1c0fcd"
			},
			parents = {
				"node_e8d152e8-495b-4da1-86e8-4c78bd1dd63b",
				"node_0855dc6f-a4d5-4bd4-9bff-f31f23325eec",
				"node_939b77d7-9bd1-48a9-8ae6-66beae3686ec"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "keystone_1"
			}
		},
		{
			type = "keystone",
			max_points = 1,
			widget_name = "node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818",
			y = 2360,
			y_normalized = 0,
			talent = "adamant_bullet_rain",
			x = 1070,
			x_normalized = 0,
			children = {
				"node_9a64c5d0-9d4b-479f-90d2-4c48d8523a70",
				"node_b6adf64e-bc34-455a-a059-552c4fb0f8a0",
				"node_446b745a-e92e-4e31-8cc0-0ee5327f5674"
			},
			parents = {
				"node_37326b02-5f6c-44b7-9bf7-60333a78906f",
				"node_77cd8fa5-79d5-4338-8de4-b79c0942305c",
				"node_197cc061-785e-4921-9b69-94d199e346ea"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "keystone_1"
			}
		},
		{
			type = "keystone",
			max_points = 1,
			widget_name = "node_23717e1a-a7ea-44f6-b168-9bd668cd29a3",
			y = 2360,
			y_normalized = 0,
			talent = "adamant_forceful",
			x = 1430,
			x_normalized = 0,
			children = {
				"node_011c39aa-3025-4c37-b8de-608a36813a25",
				"node_26aa2932-e1d8-4b3b-9a28-f6d71f977f56",
				"node_adef8607-f04c-4b80-84a9-70247ea03536"
			},
			parents = {
				"node_6f8fc4e4-c5cd-423f-b612-4eb26dc2dadb",
				"node_f74129c0-c6ba-47d0-a058-315793b06763",
				"node_b122aa73-4f58-4e90-b3f3-d33aa101889b"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "keystone_1"
			}
		},
		{
			type = "tactical",
			max_points = 1,
			widget_name = "node_2d88b9f8-d7dc-402f-8c33-9d836f577ec6",
			y = 919.9999987913084,
			y_normalized = 0,
			talent = "adamant_whistle",
			x = 800,
			x_normalized = 0,
			children = {
				"node_1b027142-867d-492d-a12c-a31f83808c10"
			},
			parents = {
				"node_dda8cd93-78f0-4e39-90cd-9b151ee8bc22",
				"node_0b81c83e-9fd8-40e1-845d-08574cbca744",
				"node_840a6834-a491-4e29-8e44-2f9ccb6e2f03",
				"node_9bb51d57-e584-40a7-98cf-313f7e557773",
				"node_2af481c5-1995-4a67-897d-3c755692d325",
				"node_dcf01775-39a4-4a2e-a1b7-f2f68ff24fba",
				"node_3fb66d94-8500-432f-86e2-4c4ea2a49095",
				"node_429b1166-55ac-4676-893b-5b56055fbca6",
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			requirements = {
				min_points_spent = 0,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion",
				children_unlock_points = 1,
				exclusive_group = "blitz_1"
			}
		},
		{
			type = "tactical",
			max_points = 1,
			widget_name = "node_44cf93b1-fbc8-48a4-ba29-40c84aa6051f",
			y = 919.9999987913084,
			y_normalized = 0,
			talent = "adamant_grenade_improved",
			x = 1070,
			x_normalized = 0,
			children = {
				"node_1b027142-867d-492d-a12c-a31f83808c10",
				"node_0b4c5516-2cbb-479e-a82a-64e822112aba",
				"node_001a326c-f2a5-4b92-a514-fa5c1fe85c7d"
			},
			parents = {
				"node_dda8cd93-78f0-4e39-90cd-9b151ee8bc22",
				"node_0b81c83e-9fd8-40e1-845d-08574cbca744",
				"node_840a6834-a491-4e29-8e44-2f9ccb6e2f03",
				"node_9bb51d57-e584-40a7-98cf-313f7e557773",
				"node_2af481c5-1995-4a67-897d-3c755692d325",
				"node_dcf01775-39a4-4a2e-a1b7-f2f68ff24fba",
				"node_3fb66d94-8500-432f-86e2-4c4ea2a49095",
				"node_429b1166-55ac-4676-893b-5b56055fbca6",
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "blitz_1"
			}
		},
		{
			type = "aura",
			max_points = 1,
			widget_name = "node_6857741a-5da7-40c1-871b-4b62f91a52ea",
			y = 1400,
			y_normalized = 0,
			talent = "adamant_damage_vs_staggered_aura",
			x = 1310,
			x_normalized = 0,
			children = {
				"node_75d31c92-2869-4bbb-8f63-f0f7b9e15bdf",
				"node_030fde55-407f-4bb3-bd36-46d70fe56bbf"
			},
			parents = {
				"node_00091489-4546-42b8-8591-9eb519ade295"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "aura_1"
			}
		},
		{
			type = "ability",
			max_points = 1,
			widget_name = "node_db2750a5-ac31-469f-8e7d-294b6c750b35",
			y = 1809,
			y_normalized = 0,
			talent = "adamant_charge",
			icon = "content/ui/textures/icons/talents/adamant/adamant_ability_charge",
			x = 1359,
			x_normalized = 0,
			children = {
				"node_b0947b3d-cb39-43c3-8922-1a9c48dfb8d8",
				"node_b481951e-a77e-44a0-894b-b58d72182992"
			},
			parents = {
				"node_da43a66a-4f23-41fb-8257-6cf06d157433"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "ability_1"
			}
		},
		{
			type = "ability",
			max_points = 1,
			widget_name = "node_ccb98e10-453f-425b-8242-9d264faf7b25",
			y = 1809,
			y_normalized = 0,
			talent = "adamant_area_buff_drone",
			icon = "content/ui/textures/icons/talents/ogryn/ogryn_2_aura",
			x = 1059,
			x_normalized = 0,
			children = {
				"node_0db1fa97-50eb-44b9-9c27-730da36404d1",
				"node_99a483b6-3ac6-42da-b2ab-b0d3dcc062e9",
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719"
			},
			parents = {
				"node_4cb10022-552a-4499-84e1-b956aa007511"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "ability_1"
			}
		},
		{
			type = "ability",
			max_points = 1,
			widget_name = "node_f1a66593-132e-4464-9c20-c7a7cf79a4b0",
			y = 1809,
			y_normalized = 0,
			talent = "adamant_stance",
			icon = "content/ui/textures/icons/talents/adamant/adamant_ability_stance",
			x = 759,
			x_normalized = 0,
			children = {
				"node_7de43e6e-167c-4e17-9975-e23e5ef390ec",
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431"
			},
			parents = {
				"node_f68f014d-f97a-49e7-b2d3-f61285493da5"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "ability_1"
			}
		},
		{
			type = "tactical",
			max_points = 1,
			widget_name = "node_ff1dbe2a-92b6-46f8-9c71-dc777431a537",
			y = 919.9999987913084,
			y_normalized = 0,
			talent = "adamant_shock_mine",
			x = 1340,
			x_normalized = 0,
			children = {
				"node_1b027142-867d-492d-a12c-a31f83808c10"
			},
			parents = {
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				exclusive_group = "blitz_1"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_3684f20d-bb13-4f40-ba64-43d402eea435",
			y = 514.9999888697039,
			y_normalized = 0,
			talent = "adamant_elite_special_kills_offensive_boost",
			x = 845,
			x_normalized = 0,
			children = {
				"node_36d88b0b-d525-48ea-af8b-ec8485ace60f",
				"node_3541dea3-3eba-4635-a80b-9dd635c02298"
			},
			parents = {
				"node_43567fd7-f7c3-4b73-9cb5-3fb72af27a23"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_0ebf45d0-b4da-42ea-8735-1d9c31ac2a9f",
			y = 514.9999888697039,
			y_normalized = 0,
			talent = "adamant_damage_after_reloading",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_3541dea3-3eba-4635-a80b-9dd635c02298",
				"node_efb7ef59-9432-462f-b551-91a5e93f0789"
			},
			parents = {
				"node_43567fd7-f7c3-4b73-9cb5-3fb72af27a23"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_577dcd33-0991-437a-ac3f-93d5cf1eda97",
			y = 514.9999888697039,
			y_normalized = 0,
			talent = "adamant_multiple_hits_attack_speed",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_efb7ef59-9432-462f-b551-91a5e93f0789",
				"node_ff7e488d-67b2-4139-a794-6032177b6d56"
			},
			parents = {
				"node_43567fd7-f7c3-4b73-9cb5-3fb72af27a23"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_36d88b0b-d525-48ea-af8b-ec8485ace60f",
			y = 605,
			y_normalized = 0,
			talent = "adamant_dog_kills_replenish_toughness",
			x = 725,
			x_normalized = 0,
			children = {
				"node_4c33cf5f-8516-4c2d-bc50-7afd037eb239"
			},
			parents = {
				"node_3684f20d-bb13-4f40-ba64-43d402eea435"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_3541dea3-3eba-4635-a80b-9dd635c02298",
			y = 604.9999888697039,
			y_normalized = 0,
			talent = "adamant_elite_special_kills_replenish_toughness",
			x = 965,
			x_normalized = 0,
			children = {
				"node_4c33cf5f-8516-4c2d-bc50-7afd037eb239",
				"node_89e56162-d28d-49d5-a01a-ca818154041f"
			},
			parents = {
				"node_3684f20d-bb13-4f40-ba64-43d402eea435",
				"node_0ebf45d0-b4da-42ea-8735-1d9c31ac2a9f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_efb7ef59-9432-462f-b551-91a5e93f0789",
			y = 604.9999888697039,
			y_normalized = 0,
			talent = "adamant_close_kills_restore_toughness",
			x = 1205,
			x_normalized = 0,
			children = {
				"node_89e56162-d28d-49d5-a01a-ca818154041f",
				"node_433d6dd9-c8c4-4f9b-8f0f-e86cc9e69c8a"
			},
			parents = {
				"node_577dcd33-0991-437a-ac3f-93d5cf1eda97",
				"node_0ebf45d0-b4da-42ea-8735-1d9c31ac2a9f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_ff7e488d-67b2-4139-a794-6032177b6d56",
			y = 605,
			y_normalized = 0,
			talent = "adamant_staggers_replenish_toughness",
			x = 1445,
			x_normalized = 0,
			children = {
				"node_433d6dd9-c8c4-4f9b-8f0f-e86cc9e69c8a"
			},
			parents = {
				"node_577dcd33-0991-437a-ac3f-93d5cf1eda97"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_4c33cf5f-8516-4c2d-bc50-7afd037eb239",
			y = 694.9999888697039,
			y_normalized = 0,
			talent = "adamant_dog_attacks_electrocute",
			x = 845,
			x_normalized = 0,
			children = {
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			parents = {
				"node_36d88b0b-d525-48ea-af8b-ec8485ace60f",
				"node_3541dea3-3eba-4635-a80b-9dd635c02298"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_89e56162-d28d-49d5-a01a-ca818154041f",
			y = 694.9999888697039,
			y_normalized = 0,
			talent = "adamant_increased_damage_vs_horde",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			parents = {
				"node_3541dea3-3eba-4635-a80b-9dd635c02298",
				"node_efb7ef59-9432-462f-b551-91a5e93f0789"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_433d6dd9-c8c4-4f9b-8f0f-e86cc9e69c8a",
			y = 695,
			y_normalized = 0,
			talent = "adamant_limit_dmg_taken_from_hits",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f"
			},
			parents = {
				"node_efb7ef59-9432-462f-b551-91a5e93f0789",
				"node_ff7e488d-67b2-4139-a794-6032177b6d56"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_6b1ed144-097b-4dd0-9fab-c56e5722ee5f",
			y = 814,
			y_normalized = 0,
			talent = "base_toughness_damage_reduction_node_buff_low_1",
			x = 1084,
			x_normalized = 0,
			children = {
				"node_2d88b9f8-d7dc-402f-8c33-9d836f577ec6",
				"node_ff1dbe2a-92b6-46f8-9c71-dc777431a537",
				"node_44cf93b1-fbc8-48a4-ba29-40c84aa6051f"
			},
			parents = {
				"node_433d6dd9-c8c4-4f9b-8f0f-e86cc9e69c8a",
				"node_89e56162-d28d-49d5-a01a-ca818154041f",
				"node_4c33cf5f-8516-4c2d-bc50-7afd037eb239"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_1b027142-867d-492d-a12c-a31f83808c10",
			y = 1055.000012914773,
			y_normalized = 0,
			talent = "adamant_armor",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_df1e55b6-c494-4e6f-a158-70e78a41ae7e",
				"node_98d2783c-b2ac-4c17-963f-c1a4503544ac",
				"node_cd56b514-bd30-4c94-8387-11558c4552ef"
			},
			parents = {
				"node_ff1dbe2a-92b6-46f8-9c71-dc777431a537",
				"node_2d88b9f8-d7dc-402f-8c33-9d836f577ec6",
				"node_44cf93b1-fbc8-48a4-ba29-40c84aa6051f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_98d2783c-b2ac-4c17-963f-c1a4503544ac",
			y = 1085,
			y_normalized = 0,
			talent = "adamant_verispex",
			x = 965,
			x_normalized = 0,
			children = {},
			parents = {
				"node_1b027142-867d-492d-a12c-a31f83808c10"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_cd56b514-bd30-4c94-8387-11558c4552ef",
			y = 1085,
			y_normalized = 0,
			talent = "adamant_gutter_forged",
			x = 1205,
			x_normalized = 0,
			children = {},
			parents = {
				"node_1b027142-867d-492d-a12c-a31f83808c10"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_8cd80a54-2e4c-435c-9cdd-2ff7e4715505",
			y = 1174.9999976559839,
			y_normalized = 0,
			talent = "adamant_ammo_belt",
			x = 935,
			x_normalized = 0,
			children = {},
			parents = {
				"node_df1e55b6-c494-4e6f-a158-70e78a41ae7e"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_df1e55b6-c494-4e6f-a158-70e78a41ae7e",
			y = 1174.9999976559839,
			y_normalized = 0,
			talent = "adamant_mag_strips",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_00091489-4546-42b8-8591-9eb519ade295",
				"node_8cd80a54-2e4c-435c-9cdd-2ff7e4715505",
				"node_6a6a18ee-6f41-4a44-abd5-6237cd9a6b99"
			},
			parents = {
				"node_1b027142-867d-492d-a12c-a31f83808c10"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_6a6a18ee-6f41-4a44-abd5-6237cd9a6b99",
			y = 1174.9999976559839,
			y_normalized = 0,
			talent = "adamant_riot_pads",
			x = 1235,
			x_normalized = 0,
			children = {},
			parents = {
				"node_df1e55b6-c494-4e6f-a158-70e78a41ae7e"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_39b2491a-29f2-428c-9dc5-14d41204a76d",
			y = 1265,
			y_normalized = 0,
			talent = "adamant_rebreather",
			x = 965,
			x_normalized = 0,
			children = {},
			parents = {
				"node_00091489-4546-42b8-8591-9eb519ade295"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_00091489-4546-42b8-8591-9eb519ade295",
			y = 1295.000012914773,
			y_normalized = 0,
			talent = "adamant_plasteel_plates",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_39b2491a-29f2-428c-9dc5-14d41204a76d",
				"node_edc914ed-dc63-47f0-b8e5-97a051892616",
				"node_d9c8ac91-9f39-43f5-9655-c836de0bb997",
				"node_6857741a-5da7-40c1-871b-4b62f91a52ea",
				"node_d11bcab3-f47e-43ef-8f26-72e4ed2760fe"
			},
			parents = {
				"node_df1e55b6-c494-4e6f-a158-70e78a41ae7e"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_edc914ed-dc63-47f0-b8e5-97a051892616",
			y = 1265,
			y_normalized = 0,
			talent = "adamant_shield_plates",
			x = 1205,
			x_normalized = 0,
			children = {},
			parents = {
				"node_00091489-4546-42b8-8591-9eb519ade295"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_8250a1a1-97b9-4573-af63-05e81541bdeb",
			y = 1534,
			y_normalized = 0,
			talent = "base_movement_speed_node_buff_low_1",
			x = 844,
			x_normalized = 0,
			children = {
				"node_a40126d6-c985-42b7-bffb-7234639e6704",
				"node_f3713ddf-8e7b-443e-97a6-b997188f6096",
				"node_b4efa6cf-bc1d-4616-9518-4b9fc363dcf8"
			},
			parents = {
				"node_d11bcab3-f47e-43ef-8f26-72e4ed2760fe",
				"node_a40126d6-c985-42b7-bffb-7234639e6704"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_a40126d6-c985-42b7-bffb-7234639e6704",
			y = 1534,
			y_normalized = 0,
			talent = "base_ranged_damage_node_buff_low_1",
			x = 1084,
			x_normalized = 0,
			children = {
				"node_030fde55-407f-4bb3-bd36-46d70fe56bbf",
				"node_8250a1a1-97b9-4573-af63-05e81541bdeb",
				"node_b4efa6cf-bc1d-4616-9518-4b9fc363dcf8",
				"node_0986767e-393b-4625-af18-8f085a9a8557"
			},
			parents = {
				"node_d9c8ac91-9f39-43f5-9655-c836de0bb997",
				"node_030fde55-407f-4bb3-bd36-46d70fe56bbf",
				"node_8250a1a1-97b9-4573-af63-05e81541bdeb"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_030fde55-407f-4bb3-bd36-46d70fe56bbf",
			y = 1534,
			y_normalized = 0,
			talent = "base_melee_damage_node_buff_low_1",
			x = 1324,
			x_normalized = 0,
			children = {
				"node_a40126d6-c985-42b7-bffb-7234639e6704",
				"node_4bd3e71e-c621-4727-bedc-141b052cbee5",
				"node_0986767e-393b-4625-af18-8f085a9a8557"
			},
			parents = {
				"node_6857741a-5da7-40c1-871b-4b62f91a52ea",
				"node_a40126d6-c985-42b7-bffb-7234639e6704"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_75d31c92-2869-4bbb-8f63-f0f7b9e15bdf",
			y = 1475,
			y_normalized = 0,
			talent = "adamant_disable_companion",
			x = 1205,
			x_normalized = 0,
			children = {},
			parents = {
				"node_6857741a-5da7-40c1-871b-4b62f91a52ea",
				"node_d9c8ac91-9f39-43f5-9655-c836de0bb997"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_26aa2932-e1d8-4b3b-9a28-f6d71f977f56",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_forceful_companion",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_284a6993-4069-480f-be4b-ad6bb34c6739"
			},
			parents = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_011c39aa-3025-4c37-b8de-608a36813a25",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_forceful_melee",
			x = 1445,
			x_normalized = 0,
			children = {
				"node_284a6993-4069-480f-be4b-ad6bb34c6739",
				"node_deba29d6-030f-474a-9992-b6c75ee570bf"
			},
			parents = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_adef8607-f04c-4b80-84a9-70247ea03536",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_forceful_ranged",
			x = 1565,
			x_normalized = 0,
			children = {
				"node_deba29d6-030f-474a-9992-b6c75ee570bf"
			},
			parents = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_284a6993-4069-480f-be4b-ad6bb34c6739",
			y = 2615,
			y_normalized = 0,
			talent = "adamant_forceful_refresh_on_ability",
			x = 1385,
			x_normalized = 0,
			children = {},
			parents = {
				"node_26aa2932-e1d8-4b3b-9a28-f6d71f977f56",
				"node_011c39aa-3025-4c37-b8de-608a36813a25"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_deba29d6-030f-474a-9992-b6c75ee570bf",
			y = 2615,
			y_normalized = 0,
			talent = "adamant_forceful_toughness_regen",
			x = 1505,
			x_normalized = 0,
			children = {},
			parents = {
				"node_011c39aa-3025-4c37-b8de-608a36813a25",
				"node_adef8607-f04c-4b80-84a9-70247ea03536"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "tactical_modifier",
			max_points = 1,
			y = 937.4999987913084,
			widget_name = "node_001a326c-f2a5-4b92-a514-fa5c1fe85c7d",
			y_normalized = 0,
			x = 1207.5,
			x_normalized = 0,
			children = {},
			parents = {
				"node_44cf93b1-fbc8-48a4-ba29-40c84aa6051f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "tactical_modifier",
			max_points = 1,
			y = 937.4999987913084,
			widget_name = "node_0b4c5516-2cbb-479e-a82a-64e822112aba",
			y_normalized = 0,
			x = 967.5,
			x_normalized = 0,
			children = {},
			parents = {
				"node_44cf93b1-fbc8-48a4-ba29-40c84aa6051f"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_f3713ddf-8e7b-443e-97a6-b997188f6096",
			y = 1625,
			y_normalized = 0,
			talent = "adamant_toughness_regen_near_companion",
			x = 725,
			x_normalized = 0,
			children = {
				"node_f68f014d-f97a-49e7-b2d3-f61285493da5"
			},
			parents = {
				"node_8250a1a1-97b9-4573-af63-05e81541bdeb"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_b4efa6cf-bc1d-4616-9518-4b9fc363dcf8",
			y = 1625,
			y_normalized = 0,
			talent = "adamant_damage_reduction_after_elite_kill",
			x = 965,
			x_normalized = 0,
			children = {
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_f68f014d-f97a-49e7-b2d3-f61285493da5"
			},
			parents = {
				"node_a40126d6-c985-42b7-bffb-7234639e6704",
				"node_8250a1a1-97b9-4573-af63-05e81541bdeb"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_0986767e-393b-4625-af18-8f085a9a8557",
			y = 1625,
			y_normalized = 0,
			talent = "adamant_perfect_block_damage_boost",
			x = 1205,
			x_normalized = 0,
			children = {
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_da43a66a-4f23-41fb-8257-6cf06d157433"
			},
			parents = {
				"node_a40126d6-c985-42b7-bffb-7234639e6704",
				"node_030fde55-407f-4bb3-bd36-46d70fe56bbf"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_4bd3e71e-c621-4727-bedc-141b052cbee5",
			y = 1625,
			y_normalized = 0,
			talent = "adamant_staggers_reduce_damage_taken",
			x = 1445,
			x_normalized = 0,
			children = {
				"node_da43a66a-4f23-41fb-8257-6cf06d157433"
			},
			parents = {
				"node_030fde55-407f-4bb3-bd36-46d70fe56bbf"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_f68f014d-f97a-49e7-b2d3-f61285493da5",
			y = 1714,
			y_normalized = 0,
			talent = "base_toughness_damage_reduction_node_buff_low_2",
			x = 844,
			x_normalized = 0,
			children = {
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_f1a66593-132e-4464-9c20-c7a7cf79a4b0"
			},
			parents = {
				"node_f3713ddf-8e7b-443e-97a6-b997188f6096",
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_b4efa6cf-bc1d-4616-9518-4b9fc363dcf8"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_4cb10022-552a-4499-84e1-b956aa007511",
			y = 1714,
			y_normalized = 0,
			talent = "base_reload_speed_node_buff_low_1",
			x = 1084,
			x_normalized = 0,
			children = {
				"node_da43a66a-4f23-41fb-8257-6cf06d157433",
				"node_f68f014d-f97a-49e7-b2d3-f61285493da5",
				"node_ccb98e10-453f-425b-8242-9d264faf7b25"
			},
			parents = {
				"node_b4efa6cf-bc1d-4616-9518-4b9fc363dcf8",
				"node_0986767e-393b-4625-af18-8f085a9a8557",
				"node_da43a66a-4f23-41fb-8257-6cf06d157433",
				"node_f68f014d-f97a-49e7-b2d3-f61285493da5"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_da43a66a-4f23-41fb-8257-6cf06d157433",
			y = 1714,
			y_normalized = 0,
			talent = "base_stamina_node_buff_low_1",
			x = 1324,
			x_normalized = 0,
			children = {
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_db2750a5-ac31-469f-8e7d-294b6c750b35"
			},
			parents = {
				"node_4cb10022-552a-4499-84e1-b956aa007511",
				"node_4bd3e71e-c621-4727-bedc-141b052cbee5",
				"node_0986767e-393b-4625-af18-8f085a9a8557"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1835,
			widget_name = "node_c7200201-5541-4b79-bb97-f866d4859bd7",
			y_normalized = 0,
			x = 485,
			x_normalized = 0,
			children = {},
			parents = {
				"node_7de43e6e-167c-4e17-9975-e23e5ef390ec"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1835,
			widget_name = "node_7de43e6e-167c-4e17-9975-e23e5ef390ec",
			y_normalized = 0,
			x = 635,
			x_normalized = 0,
			children = {
				"node_cbd2062a-c53b-47d8-a07c-3868aa343031",
				"node_c7200201-5541-4b79-bb97-f866d4859bd7"
			},
			parents = {
				"node_f1a66593-132e-4464-9c20-c7a7cf79a4b0"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1925,
			widget_name = "node_cbd2062a-c53b-47d8-a07c-3868aa343031",
			y_normalized = 0,
			x = 545,
			x_normalized = 0,
			children = {},
			parents = {
				"node_7de43e6e-167c-4e17-9975-e23e5ef390ec"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1835,
			widget_name = "node_0db1fa97-50eb-44b9-9c27-730da36404d1",
			y_normalized = 0,
			x = 935,
			x_normalized = 0,
			children = {},
			parents = {
				"node_ccb98e10-453f-425b-8242-9d264faf7b25"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1835,
			widget_name = "node_99a483b6-3ac6-42da-b2ab-b0d3dcc062e9",
			y_normalized = 0,
			x = 1235,
			x_normalized = 0,
			children = {},
			parents = {
				"node_ccb98e10-453f-425b-8242-9d264faf7b25"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			widget_name = "node_b0947b3d-cb39-43c3-8922-1a9c48dfb8d8",
			y = 1835,
			y_normalized = 0,
			talent = "adamant_charge_toughness",
			x = 1535,
			x_normalized = 0,
			children = {
				"node_20638e8f-5c78-481c-a210-ec3fcdcd60e3",
				"node_ed72b6e9-1213-4760-bd1c-28c0f93c1f55"
			},
			parents = {
				"node_db2750a5-ac31-469f-8e7d-294b6c750b35"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			widget_name = "node_ed72b6e9-1213-4760-bd1c-28c0f93c1f55",
			y = 1835,
			y_normalized = 0,
			talent = "adamant_charge_cooldown_reduction",
			x = 1685,
			x_normalized = 0,
			children = {},
			parents = {
				"node_b0947b3d-cb39-43c3-8922-1a9c48dfb8d8"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "ability_modifier",
			max_points = 1,
			y = 1925,
			widget_name = "node_20638e8f-5c78-481c-a210-ec3fcdcd60e3",
			y_normalized = 0,
			x = 1625,
			x_normalized = 0,
			children = {},
			parents = {
				"node_b0947b3d-cb39-43c3-8922-1a9c48dfb8d8"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_1f033fe8-5a70-4e87-b143-fc080d1da431",
			y = 1954,
			y_normalized = 0,
			talent = "base_stamina_regen_delay_1",
			x = 724,
			x_normalized = 0,
			children = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719",
				"node_e992d16b-4372-4874-93ca-7a520cceb74c",
				"node_bdab99db-3a50-4368-a9d7-7dc613f86f2d",
				"node_62deceb2-66cd-4494-b96d-27b9fcc8732b"
			},
			parents = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719",
				"node_f1a66593-132e-4464-9c20-c7a7cf79a4b0"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_49bbfafc-233f-4a23-9a72-0412b4fcf719",
			y = 1954,
			y_normalized = 0,
			talent = "base_toughness_node_buff_low_1",
			x = 1084,
			x_normalized = 0,
			children = {
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431",
				"node_b481951e-a77e-44a0-894b-b58d72182992",
				"node_5a80539c-f229-4c5e-8984-4b4d08025f6c",
				"node_e3e5b107-e32b-47a0-b52b-11320f1e9fb3",
				"node_b93d4978-d0c5-4257-8725-9a1b20596f93"
			},
			parents = {
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431",
				"node_b481951e-a77e-44a0-894b-b58d72182992",
				"node_ccb98e10-453f-425b-8242-9d264faf7b25"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "stat",
			max_points = 1,
			widget_name = "node_b481951e-a77e-44a0-894b-b58d72182992",
			y = 1954,
			y_normalized = 0,
			talent = "base_toughness_damage_reduction_node_buff_low_3",
			x = 1444,
			x_normalized = 0,
			children = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719",
				"node_a9e22eac-7d0d-4567-ae6c-e7be34534eaa",
				"node_b4b7879c-20cc-40d3-ac4f-955b154a16e7",
				"node_856d1388-a8d1-43bf-9a89-7308c21fae88"
			},
			parents = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719",
				"node_db2750a5-ac31-469f-8e7d-294b6c750b35"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_e992d16b-4372-4874-93ca-7a520cceb74c",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_dog_applies_brittleness",
			x = 605,
			x_normalized = 0,
			children = {
				"node_e4460989-b9cf-434d-9924-4e8db174db46"
			},
			parents = {
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			y = 2165,
			widget_name = "node_e4460989-b9cf-434d-9924-4e8db174db46",
			y_normalized = 0,
			x = 605,
			x_normalized = 0,
			children = {
				"node_0855dc6f-a4d5-4bd4-9bff-f31f23325eec",
				"node_939b77d7-9bd1-48a9-8ae6-66beae3686ec",
				"node_a4fe35cf-a844-4f20-84d3-d54f38bb63f9",
				"node_32b8ad80-26e3-4b3f-b0da-679d0803d855"
			},
			parents = {
				"node_e992d16b-4372-4874-93ca-7a520cceb74c",
				"node_62deceb2-66cd-4494-b96d-27b9fcc8732b",
				"node_a4fe35cf-a844-4f20-84d3-d54f38bb63f9"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_bdab99db-3a50-4368-a9d7-7dc613f86f2d",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_dodge_grants_damage",
			x = 845,
			x_normalized = 0,
			children = {
				"node_9b76913c-5597-404c-ae20-7f3e16ec9273"
			},
			parents = {
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_e8d152e8-495b-4da1-86e8-4c78bd1dd63b",
			y = 2285,
			y_normalized = 0,
			talent = "adamant_stacking_weakspot_strength",
			x = 845,
			x_normalized = 0,
			children = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c"
			},
			parents = {
				"node_9b76913c-5597-404c-ae20-7f3e16ec9273"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_9b76913c-5597-404c-ae20-7f3e16ec9273",
			y = 2165,
			y_normalized = 0,
			talent = "adamant_elite_special_kills_reload_speed",
			x = 845,
			x_normalized = 0,
			children = {
				"node_e8d152e8-495b-4da1-86e8-4c78bd1dd63b",
				"node_939b77d7-9bd1-48a9-8ae6-66beae3686ec"
			},
			parents = {
				"node_bdab99db-3a50-4368-a9d7-7dc613f86f2d",
				"node_62deceb2-66cd-4494-b96d-27b9fcc8732b"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_e3e5b107-e32b-47a0-b52b-11320f1e9fb3",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_clip_size",
			x = 965,
			x_normalized = 0,
			children = {
				"node_7ba2e581-0bfd-4e4f-aafc-ad18ca55e1d1"
			},
			parents = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_b93d4978-d0c5-4257-8725-9a1b20596f93",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_movement_speed_on_block",
			x = 1205,
			x_normalized = 0,
			children = {
				"node_e8c565d5-0c8e-4364-ba72-4b85aa69433a"
			},
			parents = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			y = 2165,
			widget_name = "node_7ba2e581-0bfd-4e4f-aafc-ad18ca55e1d1",
			y_normalized = 0,
			x = 965,
			x_normalized = 0,
			children = {
				"node_37326b02-5f6c-44b7-9bf7-60333a78906f",
				"node_77cd8fa5-79d5-4338-8de4-b79c0942305c"
			},
			parents = {
				"node_e3e5b107-e32b-47a0-b52b-11320f1e9fb3",
				"node_5a80539c-f229-4c5e-8984-4b4d08025f6c"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_5a80539c-f229-4c5e-8984-4b4d08025f6c",
			y = 2075,
			y_normalized = 0,
			talent = "adamant_no_movement_penalty",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_77cd8fa5-79d5-4338-8de4-b79c0942305c",
				"node_7ba2e581-0bfd-4e4f-aafc-ad18ca55e1d1",
				"node_e8c565d5-0c8e-4364-ba72-4b85aa69433a"
			},
			parents = {
				"node_49bbfafc-233f-4a23-9a72-0412b4fcf719"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			y = 2165,
			widget_name = "node_e8c565d5-0c8e-4364-ba72-4b85aa69433a",
			y_normalized = 0,
			x = 1205,
			x_normalized = 0,
			children = {
				"node_77cd8fa5-79d5-4338-8de4-b79c0942305c",
				"node_197cc061-785e-4921-9b69-94d199e346ea"
			},
			parents = {
				"node_b93d4978-d0c5-4257-8725-9a1b20596f93",
				"node_5a80539c-f229-4c5e-8984-4b4d08025f6c"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_37326b02-5f6c-44b7-9bf7-60333a78906f",
			y = 2285,
			y_normalized = 0,
			talent = "adamant_damage_vs_suppressed",
			x = 965,
			x_normalized = 0,
			children = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			parents = {
				"node_7ba2e581-0bfd-4e4f-aafc-ad18ca55e1d1"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_77cd8fa5-79d5-4338-8de4-b79c0942305c",
			y = 2255,
			y_normalized = 0,
			talent = "adamant_suppression_immunity",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			parents = {
				"node_7ba2e581-0bfd-4e4f-aafc-ad18ca55e1d1",
				"node_5a80539c-f229-4c5e-8984-4b4d08025f6c",
				"node_e8c565d5-0c8e-4364-ba72-4b85aa69433a"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			y = 2285,
			widget_name = "node_197cc061-785e-4921-9b69-94d199e346ea",
			y_normalized = 0,
			x = 1205,
			x_normalized = 0,
			children = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			parents = {
				"node_e8c565d5-0c8e-4364-ba72-4b85aa69433a"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_a9e22eac-7d0d-4567-ae6c-e7be34534eaa",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_dog_pounces_bleed_nearby",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_2c04a28e-bcad-4554-b738-37f89f37eee2"
			},
			parents = {
				"node_b481951e-a77e-44a0-894b-b58d72182992"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_b4b7879c-20cc-40d3-ac4f-955b154a16e7",
			y = 2075,
			y_normalized = 0,
			talent = "adamant_cleave_after_push",
			x = 1445,
			x_normalized = 0,
			children = {
				"node_45a13e59-6a31-4c9f-89ac-fd66d37b137e",
				"node_f74129c0-c6ba-47d0-a058-315793b06763",
				"node_2c04a28e-bcad-4554-b738-37f89f37eee2",
				"node_44740858-05d7-46c6-a2f0-a51c3aadadaf"
			},
			parents = {
				"node_b481951e-a77e-44a0-894b-b58d72182992"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_856d1388-a8d1-43bf-9a89-7308c21fae88",
			y = 2045,
			y_normalized = 0,
			talent = "adamant_wield_speed_on_melee_kill",
			x = 1565,
			x_normalized = 0,
			children = {
				"node_44740858-05d7-46c6-a2f0-a51c3aadadaf"
			},
			parents = {
				"node_b481951e-a77e-44a0-894b-b58d72182992"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_2c04a28e-bcad-4554-b738-37f89f37eee2",
			y = 2165,
			y_normalized = 0,
			talent = "adamant_hitting_multiple_gives_tdr",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_6f8fc4e4-c5cd-423f-b612-4eb26dc2dadb",
				"node_f74129c0-c6ba-47d0-a058-315793b06763"
			},
			parents = {
				"node_a9e22eac-7d0d-4567-ae6c-e7be34534eaa",
				"node_b4b7879c-20cc-40d3-ac4f-955b154a16e7"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false,
				incompatible_talent = "adamant_disable_companion"
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_44740858-05d7-46c6-a2f0-a51c3aadadaf",
			y = 2165,
			y_normalized = 0,
			talent = "adamant_heavy_attacks_increase_damage",
			x = 1565,
			x_normalized = 0,
			children = {
				"node_b122aa73-4f58-4e90-b3f3-d33aa101889b",
				"node_f74129c0-c6ba-47d0-a058-315793b06763"
			},
			parents = {
				"node_856d1388-a8d1-43bf-9a89-7308c21fae88",
				"node_b4b7879c-20cc-40d3-ac4f-955b154a16e7"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_6f8fc4e4-c5cd-423f-b612-4eb26dc2dadb",
			y = 2285,
			y_normalized = 0,
			talent = "adamant_dog_damage_after_ability",
			x = 1325,
			x_normalized = 0,
			children = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			parents = {
				"node_2c04a28e-bcad-4554-b738-37f89f37eee2"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_f74129c0-c6ba-47d0-a058-315793b06763",
			y = 2255,
			y_normalized = 0,
			talent = "adamant_melee_attacks_on_staggered_rend",
			x = 1445,
			x_normalized = 0,
			children = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			parents = {
				"node_45a13e59-6a31-4c9f-89ac-fd66d37b137e",
				"node_b4b7879c-20cc-40d3-ac4f-955b154a16e7",
				"node_2c04a28e-bcad-4554-b738-37f89f37eee2",
				"node_44740858-05d7-46c6-a2f0-a51c3aadadaf"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_b122aa73-4f58-4e90-b3f3-d33aa101889b",
			y = 2285,
			y_normalized = 0,
			talent = "adamant_restore_toughness_to_allies_on_combat_ability",
			x = 1565,
			x_normalized = 0,
			children = {
				"node_23717e1a-a7ea-44f6-b168-9bd668cd29a3"
			},
			parents = {
				"node_44740858-05d7-46c6-a2f0-a51c3aadadaf"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_9a64c5d0-9d4b-479f-90d2-4c48d8523a70",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_bullet_rain_tdr",
			x = 965,
			x_normalized = 0,
			children = {
				"node_40edc5b7-fae7-4043-9cfd-7ec06b1b59cb"
			},
			parents = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_b6adf64e-bc34-455a-a059-552c4fb0f8a0",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_bullet_rain_ability",
			x = 1085,
			x_normalized = 0,
			children = {
				"node_40edc5b7-fae7-4043-9cfd-7ec06b1b59cb",
				"node_69edc205-aa8c-4b72-9b46-8b855516f2c0"
			},
			parents = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_446b745a-e92e-4e31-8cc0-0ee5327f5674",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_bullet_rain_toughness",
			x = 1205,
			x_normalized = 0,
			children = {
				"node_69edc205-aa8c-4b72-9b46-8b855516f2c0",
				"node_40edc5b7-fae7-4043-9cfd-7ec06b1b59cb"
			},
			parents = {
				"node_65d7f26b-711e-4ef9-ae0e-5bad2ac7a818"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_40edc5b7-fae7-4043-9cfd-7ec06b1b59cb",
			y = 2615,
			y_normalized = 0,
			talent = "adamant_bullet_rain_fire_rate",
			x = 1085,
			x_normalized = 0,
			children = {},
			parents = {
				"node_b6adf64e-bc34-455a-a059-552c4fb0f8a0",
				"node_9a64c5d0-9d4b-479f-90d2-4c48d8523a70",
				"node_446b745a-e92e-4e31-8cc0-0ee5327f5674"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_e686dc62-a877-4eef-8a96-52743b1c0fcd",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_exterminator_toughness",
			x = 605,
			x_normalized = 0,
			children = {
				"node_d6d7d5c6-b681-41e1-b6c1-05e35ebb9715"
			},
			parents = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_dbdb2b08-b8ce-4dc5-88c9-139f0486b54c",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_exterminator_ability_cooldown",
			x = 725,
			x_normalized = 0,
			children = {
				"node_d6d7d5c6-b681-41e1-b6c1-05e35ebb9715",
				"node_8cd57c7e-dccf-4dd5-9829-c953101e1d34"
			},
			parents = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_8abdbb78-a06d-4d97-959a-a46930ab0752",
			y = 2495,
			y_normalized = 0,
			talent = "adamant_exterminator_stack_during_activation",
			x = 845,
			x_normalized = 0,
			children = {
				"node_8cd57c7e-dccf-4dd5-9829-c953101e1d34"
			},
			parents = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_d6d7d5c6-b681-41e1-b6c1-05e35ebb9715",
			y = 2615,
			y_normalized = 0,
			talent = "adamant_exterminator_boss_damage",
			x = 665,
			x_normalized = 0,
			children = {},
			parents = {
				"node_dbdb2b08-b8ce-4dc5-88c9-139f0486b54c",
				"node_e686dc62-a877-4eef-8a96-52743b1c0fcd"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "keystone_modifier",
			max_points = 1,
			widget_name = "node_8cd57c7e-dccf-4dd5-9829-c953101e1d34",
			y = 2615,
			y_normalized = 0,
			talent = "adamant_exterminator_stamina_ammo",
			x = 785,
			x_normalized = 0,
			children = {},
			parents = {
				"node_dbdb2b08-b8ce-4dc5-88c9-139f0486b54c",
				"node_8abdbb78-a06d-4d97-959a-a46930ab0752"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_62deceb2-66cd-4494-b96d-27b9fcc8732b",
			y = 2075,
			y_normalized = 0,
			talent = "adamant_crit_chance_on_kill",
			x = 725,
			x_normalized = 0,
			children = {
				"node_939b77d7-9bd1-48a9-8ae6-66beae3686ec",
				"node_e4460989-b9cf-434d-9924-4e8db174db46",
				"node_9b76913c-5597-404c-ae20-7f3e16ec9273"
			},
			parents = {
				"node_1f033fe8-5a70-4e87-b143-fc080d1da431"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			y = 2285,
			widget_name = "node_0855dc6f-a4d5-4bd4-9bff-f31f23325eec",
			y_normalized = 0,
			x = 605,
			x_normalized = 0,
			children = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c",
				"node_b01de338-f9eb-49f5-983d-c033076bd161"
			},
			parents = {
				"node_e4460989-b9cf-434d-9924-4e8db174db46"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		},
		{
			type = "default",
			max_points = 1,
			widget_name = "node_939b77d7-9bd1-48a9-8ae6-66beae3686ec",
			y = 2255,
			y_normalized = 0,
			talent = "adamant_crits_rend",
			x = 725,
			x_normalized = 0,
			children = {
				"node_52c3f35e-7fe4-4321-a04c-2a51eccac74c"
			},
			parents = {
				"node_62deceb2-66cd-4494-b96d-27b9fcc8732b",
				"node_e4460989-b9cf-434d-9924-4e8db174db46",
				"node_9b76913c-5597-404c-ae20-7f3e16ec9273"
			},
			requirements = {
				min_points_spent = 0,
				children_unlock_points = 1,
				all_parents_chosen = false
			}
		}
	},
	offset = {
		0,
		0
	},
	size = {
		4096,
		5000
	}
}
