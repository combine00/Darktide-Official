local DeployableLocomotion = require("scripts/extension_systems/locomotion/utilities/deployable_locomotion")
local DeployableUnitLocomotionExtension = class("DeployableUnitLocomotionExtension")

function DeployableUnitLocomotionExtension:init(extension_init_context, unit, extension_init_data)
	local world = extension_init_context.world
	local placed_on_unit = extension_init_data.placed_on_unit

	DeployableLocomotion.set_placed_on_unit(world, unit, placed_on_unit)
end

function DeployableUnitLocomotionExtension:game_object_initialized(game_session, game_object_id)
	self._game_object_id = game_object_id
	self._game_session = game_session
end

function DeployableUnitLocomotionExtension:current_state()
	return
end

return DeployableUnitLocomotionExtension
