local TrainBackdrop = component("TrainBackdrop")
local Chunk = class("Chunk")

function TrainBackdrop:init(unit)
	self._unit = unit
	self._num_chunks = 48
	self._current_chunk = 1
	self._current_player_chunk_location = 29
	self._wagons_chunk_location_start = 19
	self._wagons_chunk_location_end = 30
	self._enabled_chunks = {
		default = self:get_data(self._unit, "enable_default"),
		tunnel = self:get_data(self._unit, "enable_tunnel"),
		covered = self:get_data(self._unit, "enable_covered"),
		wall_left = self:get_data(self._unit, "enable_wall_left"),
		wall_right = self:get_data(self._unit, "enable_wall_right"),
		flat = self:get_data(self._unit, "enable_flat")
	}
	self._wagons_in_tunnel = {}
	self._spawned_units = {}
	self._speed_multiplier = self:get_data(self._unit, "speed_multiplier")
	self._speed_variable = Unit.animation_find_variable(self._unit, "move_speed")
	self._speed_dampening = self:get_data(self._unit, "speed_dampening")
	self._target_speed_multiplier = self:get_data(self._unit, "speed_multiplier")
	self._accelerating = false
	self._decelerating = false
	self._acceleration = 0

	if DEDICATED_SERVER then
		return false
	end

	local i = 1

	while i <= 11 do
		Unit.create_actor(self._unit, "c_trigger_" .. string.format("%02d", i), false)

		i = i + 1
	end

	local show_train_sections = self:get_data(self._unit, "show_train_sections")

	if not show_train_sections then
		Unit.set_visibility(self._unit, "chunks", false)
	end

	self._chunks = {}
	self._active_chunks = {}

	self:_spawn()

	self._chunk_que_index = nil

	self:_start()

	return false
end

function TrainBackdrop:_spawn()
	local unit = self._unit
	local world = Unit.world(unit)
	local pos = Unit.world_position(unit, 1)
	local rot = Unit.world_rotation(unit, 1)
	local scl = Vector3(1, 1, 1)
	local pose = Matrix4x4.from_quaternion_position_scale(rot, pos, scl)
	local chunk_units_info = self:get_data(unit, "chunk_units")

	for _, chunk_unit_info in ipairs(chunk_units_info) do
		local chunk_size = chunk_unit_info.chunk_size
		local chunk_unit = chunk_unit_info.chunk_unit
		local chunk_type = chunk_unit_info.chunk_type
		local chunk_order = chunk_unit_info.chunk_order
		local chunk_flip = chunk_unit_info.chunk_flip

		if chunk_unit ~= "" then
			local spawned_unit = World.spawn_unit_ex(world, chunk_unit, nil, pose, nil, true)
			self._spawned_units[#self._spawned_units + 1] = spawned_unit

			Unit.set_unit_visibility(spawned_unit, false, true)

			local chunk = Chunk:new(chunk_size, spawned_unit, chunk_type, unit, chunk_flip)
			self._chunks[chunk_order] = chunk
		end
	end
end

function TrainBackdrop:_start()
	local current_chunk = self._num_chunks

	for i = 1, #self._chunks do
		local chunk = self._chunks[i]

		if self._enabled_chunks[chunk._chunk_type] then
			if current_chunk < 1 then
				self._chunk_que_index = i

				break
			end

			chunk:activate(current_chunk, current_chunk)

			self._active_chunks[#self._active_chunks + 1] = chunk
			current_chunk = current_chunk - chunk._size
			self._chunk_que_wait = chunk._size
		end
	end

	if self._chunk_que_index ~= nil then
		Unit.animation_event(self._unit, "start")
		Unit.animation_set_variable(self._unit, self._speed_variable, self._speed_multiplier)
	else
		Log.debug("TrainBackdrop", "Not enough chunks to populate full 48 slots", tostring(self._current_player_chunk_location))
	end
end

function TrainBackdrop:enable(unit)
	return
end

function TrainBackdrop:disable(unit)
	return
end

function TrainBackdrop:destroy(unit)
	if DEDICATED_SERVER then
		return false
	end

	local world = Unit.world(unit)

	for i = 1, #self._chunks do
		local spawned_unit = self._chunks[i]._unit

		World.unlink_unit(world, spawned_unit)
		World.destroy_unit(world, spawned_unit)
	end
end

function TrainBackdrop:editor_validate(unit)
	local success = true
	local error_message = ""

	return success, error_message
end

function TrainBackdrop:_update_current_player_location(location)
	self._current_player_chunk_location = location

	Log.debug("TrainBackdrop", "Current player location is: %s", tostring(self._current_player_chunk_location))
end

function TrainBackdrop:anim_tick(unit)
	Log.debug("TrainBackdrop", "Anim Tick: %s", tostring(self._current_chunk))

	self._current_chunk = self._current_chunk + 1

	if self._num_chunks < self._current_chunk then
		self._current_chunk = 1
	end

	self:_update_chunks()
end

function TrainBackdrop:update(unit, dt, t)
	if DEDICATED_SERVER then
		return false
	end

	local continue_update = self:_update_acceleration(unit, dt, t)

	return continue_update
end

function TrainBackdrop:editor_update(unit, dt, t)
	local continue_update = self:_update_acceleration(unit, dt, t)

	return continue_update
end

function TrainBackdrop:_update_acceleration(unit, dt, t)
	if self._accelerating then
		self._acceleration = self._acceleration + self._speed_dampening * dt
	elseif self._decelerating then
		self._acceleration = self._acceleration - self._speed_dampening * dt
	else
		return false
	end

	self._speed_multiplier = self._speed_multiplier + self._acceleration

	if self._target_speed_multiplier <= self._speed_multiplier then
		self._accelerating = false
		self._acceleration = 0
		self._speed_multiplier = self._target_speed_multiplier

		Unit.animation_set_variable(self._unit, self._speed_variable, self._speed_multiplier)

		return false
	elseif self._speed_multiplier <= 0 then
		self._decelerating = false
		self._acceleration = 0
		self._speed_multiplier = 0

		Unit.animation_set_variable(self._unit, self._speed_variable, self._speed_multiplier)

		return false
	end

	Unit.animation_set_variable(self._unit, self._speed_variable, self._speed_multiplier)

	return true
end

function TrainBackdrop:_update_chunks()
	local to_remove = nil

	for i = 1, #self._active_chunks do
		local chunk = self._active_chunks[i]
		chunk.location_index = chunk.location_index + 1

		if self._num_chunks <= chunk.location_index then
			chunk.location_index = 1

			chunk:shift(self._num_chunks)
		end

		if chunk.shifted and chunk.location_index == chunk._size then
			chunk:deactivate()

			to_remove = i
		end

		self:_update_player_effects(chunk)
		self:_update_light_groups(chunk)
	end

	self:_update_effects()

	if to_remove ~= nil then
		table.remove(self._active_chunks, to_remove)
	end

	local last_chunk = self._active_chunks[#self._active_chunks]

	if last_chunk.location_index - last_chunk._size == 1 then
		local next_link_index = last_chunk.link_index - last_chunk._size

		if next_link_index < 1 then
			next_link_index = self._num_chunks - 1 + next_link_index
		end

		local next_chunk = self._chunks[self._chunk_que_index]

		while self._enabled_chunks[next_chunk._chunk_type] == nil do
			self._chunk_que_index = self._chunk_que_index + 1

			if self._chunk_que_index > #self._chunks then
				self._chunk_que_index = 1
			end

			next_chunk = self._chunks[self._chunk_que_index]
		end

		next_chunk:activate(next_link_index, 1)

		self._active_chunks[#self._active_chunks + 1] = next_chunk
		self._chunk_que_index = self._chunk_que_index + 1

		if self._chunk_que_index > #self._chunks then
			self._chunk_que_index = 1
		end
	end
end

function TrainBackdrop:_update_effects(chunk)
	local num_wagon_chunks = self._wagons_chunk_location_end - self._wagons_chunk_location_start

	for i = 1, num_wagon_chunks do
		local wagon_index = self._wagons_chunk_location_start - 1 + i
		local wagon_number = string.format("%02d", i)

		for _, active_chunk in pairs(self._active_chunks) do
			local chunk_end = active_chunk.location_index - active_chunk._size - 1
			local is_wagon_in_chunk = wagon_index <= active_chunk.location_index and chunk_end < wagon_index
			local is_chunk_covered = active_chunk._chunk_type == "tunnel" or active_chunk._chunk_type == "covered"
			local is_wagon_already_in_cover = self._wagons_in_tunnel[i] == true

			if is_wagon_in_chunk and is_wagon_already_in_cover and not is_chunk_covered then
				local flow_event = "in_wagon_" .. wagon_number .. "_tunnel_off"

				Unit.flow_event(self._unit, flow_event)

				self._wagons_in_tunnel[i] = false

				break
			elseif is_wagon_in_chunk and is_chunk_covered and not is_wagon_already_in_cover then
				local flow_event = "in_wagon_" .. wagon_number .. "_tunnel_on"

				Unit.flow_event(self._unit, flow_event)

				self._wagons_in_tunnel[i] = true

				break
			end
		end
	end
end

function TrainBackdrop:_update_player_effects(chunk)
	if chunk._chunk_type == "tunnel" or chunk._chunk_type == "covered" then
		local chunk_end = chunk.location_index - chunk._size - 1

		if self._current_player_chunk_location == chunk.location_index then
			local flow_event = "in_player_tunnel_off"

			Unit.flow_event(self._unit, flow_event)

			self._player_in_tunnel = true
		end

		if self._current_player_chunk_location == chunk_end then
			local flow_event = "in_player_tunnel_on"

			Unit.flow_event(self._unit, flow_event)

			self._player_in_tunnel = false
		end
	end
end

function TrainBackdrop:_update_light_groups(chunk)
	return
end

function TrainBackdrop:disable_default_chunks()
	self._enabled_chunks.default = nil
end

function TrainBackdrop:disable_tunnel_chunks()
	self._enabled_chunks.tunnel = nil
end

function TrainBackdrop:disable_covered_chunks()
	self._enabled_chunks.covered = nil
end

function TrainBackdrop:disable_wall_left_chunks()
	self._enabled_chunks.wall_left = nil
end

function TrainBackdrop:disable_wall_right_chunks()
	self._enabled_chunks.wall_right = nil
end

function TrainBackdrop:disable_flat_chunks()
	self._enabled_chunks.flat = nil
end

function TrainBackdrop:enable_default_chunks()
	self._enabled_chunks.default = true
end

function TrainBackdrop:enable_tunnel_chunks()
	self._enabled_chunks.tunnel = true
end

function TrainBackdrop:enable_covered_chunks()
	self._enabled_chunks.covered = true
end

function TrainBackdrop:enable_wall_left_chunks()
	self._enabled_chunks.wall_left = true
end

function TrainBackdrop:enable_wall_right_chunks()
	self._enabled_chunks.wall_right = true
end

function TrainBackdrop:enable_flat_chunks()
	self._enabled_chunks.flat = true
end

function TrainBackdrop:enable_all_chunks()
	self._enabled_chunks = {
		default = true,
		tunnel = true,
		flat = true,
		wall_right = true,
		wall_left = true,
		covered = true
	}
end

function TrainBackdrop:start_slowdown()
	self._decelerating = true

	return true
end

function TrainBackdrop:start_acceleration()
	self._accelerating = true

	return true
end

function Chunk:init(size, unit, chunk_type, parent_unit, chunk_flip)
	self._size = size
	self._unit = unit
	self._chunk_type = chunk_type
	self._parent_unit = parent_unit
	self._chunk_flip = chunk_flip
	self.location_index = nil
	self.link_index = nil
	self.shifted = false
end

function Chunk:activate(link_index, location_index)
	self.link_index = link_index
	self.location_index = location_index
	local parent_node = Unit.node(self._parent_unit, "j_chunk_" .. string.format("%02d", link_index))
	local world = Unit.world(self._parent_unit)

	World.link_unit(world, self._unit, 1, self._parent_unit, parent_node)

	if self._chunk_flip then
		Unit.set_local_rotation(self._unit, 1, Quaternion.from_euler_angles_xyz(0, 0, 180))
		Unit.set_local_position(self._unit, 1, Vector3(0, -self._size * 44, 0))
	end

	Unit.set_unit_visibility(self._unit, true, true)

	self.shifted = false
end

function Chunk:shift(num_chunks)
	self.shifted = true
	local new_link_index = self.link_index - self._size

	if new_link_index < 1 then
		new_link_index = num_chunks - 1 + new_link_index
	end

	local node_name = "j_chunk_" .. string.format("%02d", new_link_index)
	local parent_node = Unit.node(self._parent_unit, node_name)
	local world = Unit.world(self._parent_unit)

	World.link_unit(world, self._unit, 1, self._parent_unit, parent_node)
	Unit.set_local_position(self._unit, 1, Vector3(0, self._size * 44, 0))

	if self._chunk_flip then
		Unit.set_local_rotation(self._unit, 1, Quaternion.from_euler_angles_xyz(0, 0, 180))
		Unit.set_local_position(self._unit, 1, Vector3(0, -self._size * 44, 0))
	end
end

function Chunk:deactivate()
	local world = Unit.world(self._unit)

	Unit.set_unit_visibility(self._unit, false, true)
	World.unlink_unit(world, self._unit)
end

function TrainBackdrop:on_enter_01(unit)
	self:_update_current_player_location(29)
end

function TrainBackdrop:on_enter_02(unit)
	self:_update_current_player_location(28)
end

function TrainBackdrop:on_enter_03(unit)
	self:_update_current_player_location(27)
end

function TrainBackdrop:on_enter_04(unit)
	self:_update_current_player_location(26)
end

function TrainBackdrop:on_enter_05(unit)
	self:_update_current_player_location(25)
end

function TrainBackdrop:on_enter_06(unit)
	self:_update_current_player_location(24)
end

function TrainBackdrop:on_enter_07(unit)
	self:_update_current_player_location(23)
end

function TrainBackdrop:on_enter_08(unit)
	self:_update_current_player_location(22)
end

function TrainBackdrop:on_enter_09(unit)
	self:_update_current_player_location(21)
end

function TrainBackdrop:on_enter_10(unit)
	self:_update_current_player_location(20)
end

function TrainBackdrop:on_enter_11(unit)
	self:_update_current_player_location(19)
end

TrainBackdrop.component_data = {
	speed_multiplier = {
		ui_type = "number",
		min = 0,
		decimals = 2,
		max = 10,
		value = 1,
		ui_name = "Speed Multiplier",
		step = 0.1
	},
	speed_dampening = {
		ui_type = "number",
		min = 0.0001,
		decimals = 4,
		max = 1,
		value = 0.01,
		ui_name = "Speed Dampening",
		step = 0.01
	},
	show_train_sections = {
		ui_type = "check_box",
		value = false,
		ui_name = "Debug Show Train Sections"
	},
	chunk_units = {
		ui_type = "struct_array",
		category = "Chunk Units",
		ui_name = "Chunk Units",
		definition = {
			chunk_unit = {
				ui_type = "resource",
				preview = true,
				category = "Chunk",
				value = "",
				ui_name = "Unit",
				filter = "unit"
			},
			chunk_size = {
				ui_type = "number",
				min = 1,
				category = "Chunk",
				value = 1,
				ui_name = "Size",
				step = 1
			},
			chunk_type = {
				value = "default",
				ui_type = "combo_box",
				category = "Chunk",
				ui_name = "Type",
				options = {
					"default",
					"tunnel",
					"covered",
					"wall_left",
					"wall_right",
					"flat"
				}
			},
			chunk_order = {
				ui_type = "number",
				min = 1,
				category = "Chunk",
				value = 1,
				ui_name = "Order",
				step = 1
			},
			chunk_flip = {
				ui_type = "check_box",
				value = false,
				ui_name = "Flip Chunk",
				category = "Chunk"
			}
		},
		control_order = {
			"chunk_unit",
			"chunk_size",
			"chunk_type",
			"chunk_order",
			"chunk_flip"
		}
	},
	enable_default = {
		ui_type = "check_box",
		value = true,
		ui_name = "Default",
		category = "Chunk Types On Spawn"
	},
	enable_tunnel = {
		ui_type = "check_box",
		value = true,
		ui_name = "Tunnel",
		category = "Chunk Types On Spawn"
	},
	enable_covered = {
		ui_type = "check_box",
		value = true,
		ui_name = "Covered",
		category = "Chunk Types On Spawn"
	},
	enable_wall_left = {
		ui_type = "check_box",
		value = true,
		ui_name = "Wall Left",
		category = "Chunk Types On Spawn"
	},
	enable_wall_right = {
		ui_type = "check_box",
		value = true,
		ui_name = "Wall Right",
		category = "Chunk Types On Spawn"
	},
	enable_flat = {
		ui_type = "check_box",
		value = true,
		ui_name = "Flip Chunk",
		category = "Chunk Types On Spawn"
	},
	enable_inputs = {
		on_enter_01 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_02 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_03 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_04 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_05 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_06 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_07 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_08 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_09 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_10 = {
			accessibility = "private",
			type = "event"
		},
		on_enter_11 = {
			accessibility = "private",
			type = "event"
		},
		anim_tick = {
			accessibility = "private",
			type = "event"
		},
		disable_default_chunks = {
			accessibility = "public",
			type = "event"
		},
		disable_tunnel_chunks = {
			accessibility = "public",
			type = "event"
		},
		disable_covered_chunks = {
			accessibility = "public",
			type = "event"
		},
		disable_wall_left_chunks = {
			accessibility = "public",
			type = "event"
		},
		disable_wall_right_chunks = {
			accessibility = "public",
			type = "event"
		},
		disable_flat_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_default_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_tunnel_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_covered_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_wall_left_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_wall_right_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_flat_chunks = {
			accessibility = "public",
			type = "event"
		},
		enable_all_chunks = {
			accessibility = "public",
			type = "event"
		},
		start_slowdown = {
			accessibility = "public",
			type = "event"
		},
		start_acceleration = {
			accessibility = "public",
			type = "event"
		}
	}
}

return TrainBackdrop
