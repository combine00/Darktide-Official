local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local SmartTargetingTemplates = require("scripts/settings/equipment/smart_targeting_templates")
local wield_inputs = PlayerCharacterConstants.wield_inputs
local weapon_template = {
	action_inputs = {
		wield = {
			buffer_time = 0,
			clear_input_queue = true,
			input_sequence = {
				{
					inputs = wield_inputs
				}
			}
		}
	},
	action_input_hierarchy = {
		{
			transition = "stay",
			input = "wield"
		}
	},
	actions = {
		action_unwield = {
			allowed_during_sprint = true,
			anim_event = "unequip",
			start_input = "wield",
			uninterruptible = true,
			kind = "unwield",
			total_time = 0,
			allowed_chain_actions = {}
		},
		action_wield = {
			uninterruptible = true,
			anim_event = "scan_start",
			allowed_during_sprint = true,
			kind = "wield",
			total_time = 0.1
		}
	},
	crosshair = {
		crosshair_type = "ironsight"
	},
	keywords = {
		"devices"
	},
	breed_anim_state_machine_3p = {
		human = "content/characters/player/human/third_person/animations/unarmed",
		ogryn = "content/characters/player/ogryn/third_person/animations/unarmed"
	},
	breed_anim_state_machine_1p = {
		human = "content/characters/player/human/first_person/animations/scanner",
		ogryn = "content/characters/player/ogryn/first_person/animations/scanner"
	},
	smart_targeting_template = SmartTargetingTemplates.default_melee,
	ammo_template = "no_ammo",
	fx_sources = {
		_speaker = "fx_speaker"
	},
	dodge_template = "default",
	sprint_template = "default",
	stamina_template = "default",
	toughness_template = "auspex",
	look_delta_template = "auspex_scanner",
	hud_icon = "content/ui/materials/icons/pickups/default",
	hide_slot = true,
	hud_configuration = {
		uses_overheat = false,
		uses_ammunition = false
	},
	require_minigame = true,
	not_player_wieldable = true
}

local function _get_minigame(player)
	local player_unit = player.player_unit

	if not player_unit then
		return nil
	end

	local unit_data_extension = ScriptUnit.extension(player_unit, "unit_data_system")
	local minigame_character_state_component = unit_data_extension:read_component("minigame_character_state")
	local is_level_unit = minigame_character_state_component.interface_is_level_unit
	local unit_id = is_level_unit and minigame_character_state_component.interface_level_unit_id or minigame_character_state_component.interface_game_object_id
	local interface_unit = Managers.state.unit_spawner:unit(unit_id, is_level_unit)

	if not interface_unit then
		return nil
	end

	local minigame_extension = interface_unit and ScriptUnit.has_extension(interface_unit, "minigame_system")
	local minigame = minigame_extension:minigame()

	return minigame
end

local function _move_ui_validate(player)
	local minigame = _get_minigame(player)

	return minigame and minigame:uses_joystick()
end

function weapon_template.action_confirm_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	local minigame = _get_minigame(player)

	return minigame and minigame:uses_action()
end

function weapon_template.action_move_gamepad_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	if Managers.input:device_in_use("gamepad") then
		return _move_ui_validate(player)
	end

	return false
end

function weapon_template.action_move_keyboard_screen_ui_validation(wielded_slot_id, item, current_action, current_action_name, player)
	if not Managers.input:device_in_use("gamepad") then
		return _move_ui_validate(player)
	end

	return false
end

return weapon_template
