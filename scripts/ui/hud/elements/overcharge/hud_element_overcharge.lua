local Colors = require("scripts/utilities/ui/colors")
local Definitions = require("scripts/ui/hud/elements/overcharge/hud_element_overcharge_definitions")
local Overheat = require("scripts/utilities/overheat")
local PlayerCharacterConstants = require("scripts/settings/player_character/player_character_constants")
local UIWidget = require("scripts/managers/ui/ui_widget")
local HudElementOvercharge = class("HudElementOvercharge", "HudElementBase")
local EPSILON = 0.00392156862745098

function HudElementOvercharge:init(parent, draw_layer, start_scale)
	HudElementOvercharge.super.init(self, parent, draw_layer, start_scale, Definitions)

	self._warp_charge_level = 0
	self._warp_charge_alpha_multiplier = 0
	self._overheat_level = 0
	self._overheat_alpha_multiplier = 0
	self._death_warning_alpha_multiplier = 0
	local weapon_slots = {}
	local slot_configuration = PlayerCharacterConstants.slot_configuration

	for slot_id, config in pairs(slot_configuration) do
		if config.slot_type == "weapon" then
			weapon_slots[#weapon_slots + 1] = slot_id
		end
	end

	self._weapon_slots = weapon_slots
end

function HudElementOvercharge:destroy(ui_renderer)
	HudElementOvercharge.super.destroy(self, ui_renderer)
end

function HudElementOvercharge:update(dt, t, ui_renderer, render_settings, input_service)
	HudElementOvercharge.super.update(self, dt, t, ui_renderer, render_settings, input_service)
	self:_update_warp_charge(dt)
	self:_update_overheat(dt)
end

function HudElementOvercharge:_draw_widgets(dt, t, input_service, ui_renderer, render_settings)
	local snap_pixel_positions = render_settings.snap_pixel_positions
	render_settings.snap_pixel_positions = true
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]

		if widget.dirty then
			UIWidget.draw(widget, ui_renderer)
		end
	end

	render_settings.snap_pixel_positions = snap_pixel_positions
end

function HudElementOvercharge:_update_warp_charge(dt)
	local warp_charge_level = 0
	local parent = self._parent
	local player_extensions = parent:player_extensions()

	if player_extensions then
		local player_unit_data_extension = player_extensions.unit_data

		if player_unit_data_extension then
			local warp_charge_component = player_unit_data_extension:read_component("warp_charge")
			warp_charge_level = warp_charge_component.current_percentage
		end
	end

	local widget = self._widgets_by_name.warp_charge

	if warp_charge_level == 0 then
		if widget.visible then
			widget.visible = false
			widget.dirty = true
		end

		self._warp_charge_level = warp_charge_level

		return
	end

	if warp_charge_level < self._warp_charge_level - EPSILON then
		warp_charge_level = math.lerp(self._warp_charge_level, warp_charge_level, dt * 2)
	end

	local previous_anim_progress = widget.content.anim_progress
	local animate_in = warp_charge_level > 0.75
	local anim_progress = self:_get_animation_progress(dt, previous_anim_progress, animate_in)

	if previous_anim_progress ~= anim_progress then
		widget.content.anim_progress = anim_progress
	end

	self:_animate_widget_warnings(widget, warp_charge_level, dt)

	local old_warning_text = widget.content.warning_text
	local new_warning_text = "" .. string.format("%.0f%%", warp_charge_level * 100)
	widget.content.warning_text = new_warning_text

	if old_warning_text ~= new_warning_text then
		widget.dirty = true
	end

	local visible = EPSILON < warp_charge_level
	self._warp_charge_alpha_multiplier = self:_update_visibility(dt, visible, self._warp_charge_alpha_multiplier)
	local alpha_multiplier = math.clamp(self._warp_charge_alpha_multiplier * 0.5 + warp_charge_level * 0.5, 0, 1)

	if EPSILON < math.abs((widget.alpha_multiplier or 0) - alpha_multiplier) then
		widget.alpha_multiplier = alpha_multiplier
		widget.dirty = true
		widget.visible = EPSILON < alpha_multiplier
	end

	self._warp_charge_level = warp_charge_level
end

function HudElementOvercharge:_overheat_configuration(slot_name, visual_loadout_extension)
	if slot_name == "none" then
		return nil
	end

	local slot_configuration = PlayerCharacterConstants.slot_configuration[slot_name]

	if slot_configuration.slot_type ~= "weapon" then
		return nil
	end

	local weapon_template = visual_loadout_extension:weapon_template_from_slot(slot_name)
	local uses_overheat = weapon_template and weapon_template.hud_configuration and weapon_template.hud_configuration.uses_overheat

	if not uses_overheat then
		return nil
	end

	local overheat_configuration = Overheat.configuration(visual_loadout_extension, slot_name)

	return overheat_configuration
end

function HudElementOvercharge:_update_overheat(dt)
	local overheat_level = 0
	local overheat_state = ""
	local overheat_configuration = nil
	local parent = self._parent
	local player_extensions = parent:player_extensions()

	if player_extensions then
		local player_unit_data_extension = player_extensions.unit_data
		local visual_loadout_extension = player_extensions.visual_loadout

		if player_unit_data_extension and visual_loadout_extension then
			local inventory_component = player_unit_data_extension:read_component("inventory")
			local wielded_slot = inventory_component.wielded_slot
			local wanted_slot = wielded_slot
			overheat_configuration = self:_overheat_configuration(wielded_slot, visual_loadout_extension)

			if not overheat_configuration then
				local weapon_slots = self._weapon_slots

				for ii = 1, #weapon_slots do
					local weapon_slot_name = weapon_slots[ii]

					if weapon_slot_name ~= wielded_slot then
						overheat_configuration = self:_overheat_configuration(weapon_slot_name, visual_loadout_extension)
					end

					if overheat_configuration then
						wanted_slot = weapon_slot_name

						break
					end
				end
			end

			if overheat_configuration then
				local slot_component = player_unit_data_extension:read_component(wanted_slot)
				overheat_level = slot_component.overheat_current_percentage
				overheat_state = slot_component.overheat_state
			end
		end
	end

	local widget = self._widgets_by_name.overheat

	if overheat_level == 0 then
		if widget.visible then
			widget.visible = false
			widget.dirty = true
		end

		return
	end

	local previous_anim_progress = widget.content.anim_progress
	local animate_in = overheat_level > 0.75
	local anim_progress = self:_get_animation_progress(dt, previous_anim_progress, animate_in)

	if previous_anim_progress ~= anim_progress then
		widget.content.anim_progress = anim_progress
	end

	local overheat_icon_text = ""

	if overheat_configuration then
		overheat_icon_text = overheat_configuration.overheat_icon_text or ""
	end

	self:_animate_widget_warnings(widget, overheat_level, dt)

	local old_warning_text = widget.content.warning_text
	local new_warning_text = overheat_icon_text .. string.format("%.0f%%", math.floor(overheat_level * 100))
	widget.content.warning_text = new_warning_text

	if old_warning_text ~= new_warning_text then
		widget.dirty = true
	end

	local visible = overheat_level > 0
	self._overheat_alpha_multiplier = self:_update_visibility(dt, visible, self._overheat_alpha_multiplier)
	local alpha_multiplier = math.clamp(self._overheat_alpha_multiplier * 0.5 + overheat_level, 0, 1)

	if EPSILON < math.abs((widget.alpha_multiplier or 0) - alpha_multiplier) then
		widget.alpha_multiplier = alpha_multiplier
		widget.dirty = true
		widget.visible = EPSILON < alpha_multiplier
	end

	self._overheat_level = overheat_level
end

function HudElementOvercharge:_update_visibility(dt, visible, previous_alpha_multiplier)
	previous_alpha_multiplier = previous_alpha_multiplier or 0
	local alpha_speed = 5
	local alpha_multiplier = nil

	if visible then
		alpha_multiplier = math.min(previous_alpha_multiplier + dt * alpha_speed, 1)
	else
		alpha_multiplier = math.max(previous_alpha_multiplier - dt * alpha_speed, 0)
	end

	return alpha_multiplier
end

function HudElementOvercharge:_animate_widget_warnings(widget, value_fraction, dt)
	local anim_progress = widget.content.anim_progress or 0
	local style = widget.style
	local warning_text_style = style.warning_text
	local font_size_threshold = warning_text_style and warning_text_style.font_size_threshold
	local warning_text_color = warning_text_style and warning_text_style.text_color
	local warning_icon_color = style.warning and style.warning.color
	local fill_color = style.fill and style.fill.color
	local alpha = 255 * anim_progress

	if warning_icon_color then
		warning_icon_color[1] = alpha
	end

	local speed = 12

	if anim_progress > 0 then
		local red_anim_progress = 1 - (0.5 + math.sin(Application.time_since_launch() * speed) * 0.5) * anim_progress
		local red = 146 + red_anim_progress * 100

		if warning_icon_color then
			warning_icon_color[2] = red
		end

		if warning_text_color then
			if warning_icon_color then
				warning_text_color[2] = red
			end

			warning_text_color[3] = 69
			warning_text_color[4] = 69
		end
	elseif fill_color then
		warning_text_color[2] = fill_color[2]
		warning_text_color[3] = fill_color[3]
		warning_text_color[4] = fill_color[4]
	end

	if font_size_threshold then
		local font_size = 0
		local new_threshold_index, animation_size_fraction = nil
		local wanted_font_size = font_size
		local wanted_color = nil

		for i = #font_size_threshold, 1, -1 do
			local font_size_data = font_size_threshold[i]

			if font_size_data.threshold <= value_fraction then
				font_size = font_size_data.font_size
				wanted_color = font_size_data.color
				animation_size_fraction = font_size_data.animation_size_fraction
				new_threshold_index = i

				break
			end

			font_size = font_size_data.font_size
		end

		local current_threshold_index = warning_text_style.current_threshold_index or 0
		local index_change = new_threshold_index ~= current_threshold_index

		if index_change then
			warning_text_style.current_threshold_index = new_threshold_index
			warning_text_style.font_size = font_size

			if animation_size_fraction then
				warning_text_style.font_anim_progress = 1

				if current_threshold_index < new_threshold_index then
					warning_text_style.extra_font_anim_size = math.ceil(font_size * animation_size_fraction)
				else
					warning_text_style.extra_font_anim_size = font_size_threshold[current_threshold_index].font_size - font_size
				end
			else
				warning_text_style.font_anim_progress = nil
			end
		end

		if warning_text_style.font_anim_progress then
			local anim_speed = 3
			local extra_font_anim_size = warning_text_style.extra_font_anim_size
			local animate_in = false
			local anim_progress = self:_get_animation_progress(dt, warning_text_style.font_anim_progress, animate_in, anim_speed)
			warning_text_style.font_size = font_size + math.easeInCubic(anim_progress) * extra_font_anim_size
			warning_text_style.font_anim_progress = anim_progress

			if wanted_color then
				local text_color = warning_text_style.text_color

				Colors.color_lerp(text_color, wanted_color, anim_progress, text_color, true)
			end
		end
	end

	widget.dirty = true
end

function HudElementOvercharge:_get_animation_progress(dt, progress, animate_in, anim_speed)
	anim_speed = anim_speed or 5
	local anim_progress = progress or 0

	if animate_in then
		anim_progress = math.min(anim_progress + dt * anim_speed, 1)
	else
		anim_progress = math.max(anim_progress - dt * anim_speed, 0)
	end

	return anim_progress
end

function HudElementOvercharge:set_visible(visible, ui_renderer, use_retained_mode)
	if use_retained_mode then
		if visible then
			self:set_dirty()
		else
			self:_destroy_widgets(ui_renderer)
		end
	end
end

function HudElementOvercharge:_destroy_widgets(ui_renderer, use_retained_mode)
	local widgets = self._widgets
	local num_widgets = #widgets

	for i = 1, num_widgets do
		local widget = widgets[i]

		UIWidget.destroy(ui_renderer, widget, use_retained_mode)
	end
end

return HudElementOvercharge
