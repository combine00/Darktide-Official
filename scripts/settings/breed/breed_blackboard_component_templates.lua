local breed_blackboard_component_templates = {}

local function _create_breed_blackboard_component_templates(path)
	local blackboard_component_templates = require(path)

	for name, template in pairs(blackboard_component_templates) do
		breed_blackboard_component_templates[name] = template
	end
end

_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/melee_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/monster_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/ranged_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/chaos_beast_of_nurgle_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/chaos_daemonhost_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/chaos_hound_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/chaos_poxwalker_bomber_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/cultist_mutant_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/renegade_captain_blackboard_component_templates")
_create_breed_blackboard_component_templates("scripts/settings/breed/breed_blackboard_component_templates/companion_dog_blackboard_component_templates")

return settings("BreedBlackboardComponentTemplates", breed_blackboard_component_templates)
