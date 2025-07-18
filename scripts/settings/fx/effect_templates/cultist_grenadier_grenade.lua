local MasterItems = require("scripts/backend/master_items")
local GRENADE_ITEM_NAME = "content/items/weapons/minions/ranged/cultist_grenade"
local resources = {
	grenade_item_name = GRENADE_ITEM_NAME
}
local effect_template = {
	name = "cultist_grenadier_grenade",
	resources = resources,
	start = function (template_data, template_context)
		local unit = template_data.unit
		local world = template_context.world
		local item_definitions = MasterItems.get_cached()
		local grenade_item = item_definitions[GRENADE_ITEM_NAME]
		local base_unit_name = grenade_item.base_unit
		local grenade_unit = Managers.state.unit_spawner:spawn_unit(base_unit_name)

		Unit.destroy_actor(grenade_unit, "dynamic")

		local attach_node = grenade_item.wielded_attach_node
		local node = Unit.node(unit, attach_node)

		World.link_unit(world, grenade_unit, 1, unit, node)

		template_data.grenade_unit = grenade_unit
	end,
	update = function (template_data, template_context, dt, t)
		return
	end,
	stop = function (template_data, template_context)
		local grenade_unit = template_data.grenade_unit

		Managers.state.unit_spawner:mark_for_deletion(grenade_unit)
	end
}

return effect_template
