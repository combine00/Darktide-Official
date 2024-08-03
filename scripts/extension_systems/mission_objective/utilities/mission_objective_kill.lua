require("scripts/extension_systems/mission_objective/utilities/mission_objective_base")

local MissionObjectiveKill = class("MissionObjectiveKill", "MissionObjectiveBase")

function MissionObjectiveKill:start_stage(stage)
	MissionObjectiveKill.super.start_stage(self, stage)
	self:set_max_increment(0)
end

function MissionObjectiveKill:register_unit(unit)
	MissionObjectiveKill.super.register_unit(self, unit)

	local kill_synchronizer_extension = self:synchronizer_extension()

	kill_synchronizer_extension:register_minion_unit(unit)
end

function MissionObjectiveKill:update_progression()
	MissionObjectiveKill.super.update_progression(self)

	local kill_synchronizer_extension = self:synchronizer_extension()
	local progression = kill_synchronizer_extension:progression()

	self:set_progression(progression)

	if self:max_progression_achieved() then
		self:stage_done()
	end
end

function MissionObjectiveKill:_init_objective_unit(unit)
	local mission_objective_target_extension = ScriptUnit.has_extension(unit, "mission_objective_target_system")

	if mission_objective_target_extension then
		MissionObjectiveKill.super._init_objective_unit(self, unit)
	else
		Managers.state.extension:system("mission_objective_system"):add_marker(self._name, unit)
		self:register_unit(unit)
	end
end

return MissionObjectiveKill
