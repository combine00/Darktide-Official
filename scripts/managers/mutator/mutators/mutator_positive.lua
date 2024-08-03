require("scripts/managers/mutator/mutators/mutator_base")

local MutatorPositive = class("MutatorPositive", "MutatorBase")

function MutatorPositive:init(is_server, network_event_delegate, mutator_template)
	self._is_server = is_server
	self._network_event_delegate = network_event_delegate
	self._is_active = false
	self._buffs = {}
	self._template = mutator_template
	local template = self._template
	local init_modify_pacing = template.init_modify_pacing

	if self._is_server then
		-- Nothing
	end
end

function MutatorPositive:on_gameplay_post_init(level, themes)
	return
end

return MutatorPositive
