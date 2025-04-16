local Minigame = component("Minigame")

function Minigame:init(unit)
	self:enable(unit)

	local minigame_extension = ScriptUnit.fetch_component_extension(unit, "minigame_system")

	if minigame_extension then
		local minigame_type = self:get_data(unit, "minigame_type")

		minigame_extension:setup_from_component(minigame_type)
	end
end

function Minigame:editor_init(unit)
	self:enable(unit)
end

function Minigame:editor_validate(unit)
	return true, ""
end

function Minigame:enable(unit)
	return
end

function Minigame:disable(unit)
	return
end

function Minigame:destroy(unit)
	return
end

Minigame.component_data = {
	minigame_type = {
		value = "none",
		ui_type = "combo_box",
		ui_name = "Minigame Type",
		options_keys = {
			"None",
			"Default",
			"Scan",
			"Balance",
			"Decode Symbols",
			"Defuse",
			"Drill",
			"Find Frequency"
		},
		options_values = {
			"none",
			"default",
			"scan",
			"balance",
			"decode_symbols",
			"defuse",
			"drill",
			"frequency"
		}
	},
	extensions = {
		"MinigameExtension"
	}
}

return Minigame
