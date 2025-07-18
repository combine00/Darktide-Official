local Breed = require("scripts/utilities/breed")

local function _init_breed_settings(Breeds)
	for breed_name, breed_data in pairs(Breeds) do
		local need_initial_settings = Breed.is_minion(breed_data) or Breed.is_companion(breed_data)

		if need_initial_settings then
			local line_of_sight_data = breed_data.line_of_sight_data

			for i = 1, #line_of_sight_data do
				local data = line_of_sight_data[i]
				data.num_offsets = #data.offsets
			end

			local sounds = breed_data.sounds
			local events = sounds.events
			local use_proximity_culling = sounds.use_proximity_culling

			for sound_alias, _ in pairs(events) do
				if use_proximity_culling[sound_alias] == nil then
					use_proximity_culling[sound_alias] = true
				end
			end
		end
	end
end

return _init_breed_settings
