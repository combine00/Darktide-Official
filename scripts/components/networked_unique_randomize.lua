local Component = require("scripts/utilities/component")
local NetworkedUniqueRandomize = component("NetworkedUniqueRandomize")

function NetworkedUniqueRandomize:init(unit, is_server)
	self:enable(unit)

	self._is_server = is_server
	self._unit = unit

	if is_server then
		self._min_rand = self:get_data(unit, "min_rand")
		self._max_rand = self:get_data(unit, "max_rand")
		self._queue_loop = self:get_data(unit, "queue_loop")
		self._pointer = 0
		self._rand_table = table.generate_random_table(self._min_rand, self._max_rand)

		self:reset()
	end
end

function NetworkedUniqueRandomize:editor_init(unit)
	self:enable(unit)
end

function NetworkedUniqueRandomize:editor_validate(unit)
	return true, ""
end

function NetworkedUniqueRandomize:enable(unit)
	return
end

function NetworkedUniqueRandomize:disable(unit)
	return
end

function NetworkedUniqueRandomize:destroy(unit)
	return
end

function NetworkedUniqueRandomize:get_next()
	if self._is_server then
		local index = self._pointer
		local result = 0

		if index == 0 then
			if self._queue_loop then
				self:reset()

				result = self._rand_table[self._pointer]
				self._pointer = self._pointer - 1
			end
		else
			result = self._rand_table[index]
			self._pointer = self._pointer - 1
		end

		local unit = self._unit

		Unit.set_flow_variable(unit, "lua_roll_output", result)
		Unit.flow_event(unit, "lua_rolled")
		Component.trigger_event_on_clients(self, "rpc_networked_unique_randomize_roll", "rpc_networked_unique_randomize_roll", result)
	else
		Log.info("NetworkedUniqueRandomize", "[get_next] Flow node effective on server only.")
	end
end

function NetworkedUniqueRandomize.events:rpc_networked_unique_randomize_roll(result)
	local unit = self._unit

	Unit.set_flow_variable(unit, "lua_roll_output", result)
	Unit.flow_event(unit, "lua_rolled")
end

function NetworkedUniqueRandomize:reset()
	if self._is_server then
		self._pointer = #self._rand_table
	else
		Log.info("NetworkedUniqueRandomize", "[reset] Flow node effective on server only.")
	end
end

function NetworkedUniqueRandomize:new_table()
	if self._is_server then
		self._rand_table = table.generate_random_table(self._min_rand, self._max_rand)
	else
		Log.info("NetworkedUniqueRandomize", "[new_table] Flow node effective on server only.")
	end
end

NetworkedUniqueRandomize.component_data = {
	min_rand = {
		ui_type = "number",
		min = 1,
		step = 1,
		value = 1,
		ui_name = "Min Randomize",
		max = 18
	},
	max_rand = {
		ui_type = "number",
		min = 1,
		step = 1,
		value = 18,
		ui_name = "Max Randomize",
		max = 18
	},
	queue_loop = {
		ui_type = "check_box",
		value = true,
		ui_name = "Queue Loop"
	},
	inputs = {
		get_next = {
			accessibility = "public",
			type = "event"
		},
		reset = {
			accessibility = "public",
			type = "event"
		},
		new_table = {
			accessibility = "public",
			type = "event"
		}
	},
	extensions = {}
}

return NetworkedUniqueRandomize
