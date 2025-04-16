require("scripts/extension_systems/weapon/actions/action_weapon_base")

local ActionOrderCompanion = class("ActionOrderCompanion", "ActionAbilityBase")
local ShoutAbilityImplementation = require("scripts/extension_systems/ability/utilities/shout_ability_implementation")
local Vo = require("scripts/utilities/vo")

function ActionOrderCompanion:init(action_context, action_params, action_settings)
	ActionOrderCompanion.super.init(self, action_context, action_params, action_settings)

	local unit_data_extension = action_context.unit_data_extension
end

function ActionOrderCompanion:start(action_settings, t, ...)
	ActionOrderCompanion.super.start(self, action_settings, t, ...)

	local radius = 10
	local shout_target_template_name = "adamant_shout"
	local player_unit = self._player_unit
	local companion_spawner_extension = ScriptUnit.has_extension(player_unit, "companion_spawner_system")
	local companion_unit = companion_spawner_extension and companion_spawner_extension:companion_unit()

	if companion_unit then
		local dog_position = Unit.local_position(companion_unit, 1)
		local dog_rotation = Quaternion.identity()
		local dog_forward = Vector3.normalize(Vector3.flat(Quaternion.forward(dog_rotation)))

		ShoutAbilityImplementation.execute(radius, shout_target_template_name, player_unit, t, nil, dog_forward, dog_position, dog_rotation)

		local vfx = "content/fx/particles/abilities/adamant/adamant_shout"
		local vfx_pos = dog_position + Vector3.up()

		self._fx_extension:spawn_particles(vfx, vfx_pos)
	end
end

return ActionOrderCompanion
