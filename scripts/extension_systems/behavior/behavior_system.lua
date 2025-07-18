require("scripts/extension_systems/behavior/minion_behavior_extension")
require("scripts/extension_systems/behavior/combat_range_user_behavior_extension")
require("scripts/extension_systems/behavior/bot_behavior_extension")

local BehaviorTree = require("scripts/extension_systems/behavior/trees/behavior_tree")
local BehaviorTrees = require("scripts/extension_systems/behavior/trees/behavior_trees")
local BehaviorSystem = class("BehaviorSystem", "ExtensionSystemBase")

function BehaviorSystem:init(...)
	BehaviorSystem.super.init(self, ...)

	self._behavior_trees = {}

	self:_create_behavior_trees()
end

function BehaviorSystem:_create_behavior_trees()
	local behavior_trees = self._behavior_trees

	for tree_name, root in pairs(BehaviorTrees) do
		local tree = BehaviorTree:new(root, tree_name)
		behavior_trees[tree_name] = tree
	end
end

function BehaviorSystem:on_gameplay_post_init(level)
	self:call_gameplay_post_init_on_extensions(level)
end

function BehaviorSystem:on_reload(refreshed_resources)
	self:_create_behavior_trees()
	BehaviorSystem.super.on_reload(self, refreshed_resources)
end

function BehaviorSystem:update(context, dt, t, ...)
	BehaviorSystem.super.update(self, context, dt, t, ...)
	GwNavWorld.kick_async_update(self._nav_world, dt)
end

function BehaviorSystem:behavior_tree(tree_name)
	return self._behavior_trees[tree_name]
end

return BehaviorSystem
