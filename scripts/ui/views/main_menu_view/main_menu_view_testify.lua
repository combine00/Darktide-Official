local ProfileUtils = require("scripts/utilities/profile_utils")
local MainMenuViewTestify = {}

function MainMenuViewTestify.delete_all_characters(main_menu_view)
	local character_profiles = main_menu_view:character_profiles()
	local character_ids = {}

	for i = 1, #character_profiles do
		local character_id = character_profiles[i].character_id
		character_ids[#character_ids + 1] = character_id
	end

	Managers.event:trigger("event_request_delete_multiple_characters", character_ids)
end

function MainMenuViewTestify.delete_character_by_name(main_menu_view, name)
	local character_profiles = main_menu_view:character_profiles()
	local character_ids = {}

	for i = 1, #character_profiles do
		local character_name = ProfileUtils.character_name(character_profiles[i])

		if character_name == name then
			local character_id = character_profiles[i].character_id
			character_ids[#character_ids + 1] = character_id
		end
	end

	Managers.event:trigger("event_request_delete_multiple_characters", character_ids)
end

function MainMenuViewTestify.navigate_to_create_character_from_main_menu(main_menu_view)
	main_menu_view:on_create_character_pressed()
end

function MainMenuViewTestify.press_play_main_menu(main_menu_view)
	main_menu_view:on_play_pressed()
end

function MainMenuViewTestify.select_character_widget(main_menu_view, index)
	main_menu_view:on_character_widget_selected(index)
end

function MainMenuViewTestify.is_any_character_created(main_menu_view)
	local character_profiles = main_menu_view:character_profiles()
	local number_profiles = #character_profiles

	return number_profiles ~= 0
end

function MainMenuViewTestify.wait_for_in_hub(main_menu_view)
	main_menu_view:on_play_pressed()

	return Testify.RETRY
end

function MainMenuViewTestify.wait_for_main_menu_play_button_enabled(main_menu_view)
	local play_button = main_menu_view._widgets_by_name.play_button.content

	if play_button.visible and play_button.hotspot.disabled ~= true then
		return
	else
		return Testify.RETRY
	end
end

function MainMenuViewTestify.wait_for_main_menu_displayed()
	return
end

return MainMenuViewTestify
