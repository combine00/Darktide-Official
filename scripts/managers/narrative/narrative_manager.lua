local BackendError = require("scripts/managers/error/errors/backend_error")
local Promise = require("scripts/foundation/utilities/promise")
local Settings = require("scripts/settings/narrative/narrative_stories")
local MissionUtilities = require("scripts/utilities/ui/mission")
local Stories = Settings.stories
local Events = Settings.events
local NarrativeManager = class("NarrativeManager")
NarrativeManager.STORIES = table.enum(unpack(table.keys(Stories)))
NarrativeManager.EVENTS = table.enum(unpack(table.keys(Events)))

function NarrativeManager:init()
	self._character_narrative_data = {}
	self._mission_data = {}
end

local function _player_profile()
	local local_player_id = 1
	local player = Managers.player:local_player(local_player_id)
	local profile = player:profile()

	return profile
end

local function _chapter_index_from_backend_id(story_name, backend_id)
	local chapters = Stories[story_name]

	for i = 1, #chapters do
		local c = chapters[i]

		if c.backend_id == backend_id then
			return c.index
		end
	end
end

function NarrativeManager:_setup_backend_narrative_data(backend_data)
	local data = {
		stories = {},
		events = {}
	}
	local backend_stories = backend_data.stories

	for story_name, _ in pairs(Stories) do
		local backend_id = backend_stories and backend_stories[story_name]
		local chapter_index = 0

		if backend_id and backend_id ~= 0 then
			chapter_index = _chapter_index_from_backend_id(story_name, backend_id)

			if not chapter_index then
				Log.warning("NarrativeManager", "Story %s has no chapter with backend_id %s, resetting story", story_name, backend_id)

				chapter_index = 0
			end
		end

		Log.debug("NarrativeManager", "Initiating story %s to chapter_index %s", story_name, chapter_index)

		data.stories[story_name] = chapter_index
	end

	local backend_events = backend_data.events

	for event_name, _ in pairs(self._events) do
		local completed_on_backend = backend_events and (backend_events[event_name] == "true" or backend_events[event_name] == true)
		data.events[event_name] = not not completed_on_backend

		Log.debug("NarrativeManager", "Initiating event %s to %s", event_name, data.events[event_name])
	end

	return data
end

function NarrativeManager:_get_missions()
	return Managers.data_service.mission_board:fetch():next(function (data)
		local missions = data.missions
		self._mission_data = missions
	end)
end

function NarrativeManager:_is_narrative_mission_available(book, chapter, page)
	local missions = self._mission_data or {}
	local available = not table.is_empty(MissionUtilities.filter_narrative_mission_by_values(missions, book, chapter, page))

	return available
end

function NarrativeManager:is_mission_available(query_mission_name)
	local missions = self._mission_data

	if not table.is_empty(missions) then
		for i = 1, #missions do
			local mission_data = missions[i]
			local mission_name = mission_data.map

			if mission_name == query_mission_name then
				return true
			end
		end
	end

	return false
end

function NarrativeManager:load_character_narrative(character_id)
	if self._character_narrative_data[character_id] then
		return Promise.resolved()
	end

	self._events = table.clone(Events)

	return Managers.backend.interfaces.characters:get_narrative(character_id):next(function (data)
		self._character_narrative_data[character_id] = self:_setup_backend_narrative_data(data)

		return nil
	end):catch(function (err)
		local level = Managers.error:report_error(BackendError:new(err))

		return Promise.rejected({})
	end)
end

function NarrativeManager:is_narrative_loaded_for_player_character()
	local profile = _player_profile()

	if profile == nil then
		return false
	end

	local character_id = profile.character_id
	local data = self._character_narrative_data[character_id]

	return data ~= nil
end

function NarrativeManager:last_completed_chapter(story_name)
	local chapters = Stories[story_name]
	local profile = _player_profile()

	if not profile then
		return
	end

	local character_id = profile.character_id
	local last_completed_index = self._character_narrative_data[character_id].stories[story_name]
	local last_chapter = chapters[last_completed_index]

	return last_chapter
end

function NarrativeManager:chapter_by_name(story_name, chapter_name)
	local chapters = Stories[story_name]

	for i = 1, #chapters do
		local chapter = chapters[i]

		if chapter.name == chapter_name then
			return chapter
		end
	end
end

function NarrativeManager:_complete_story_chapters_until_valid_chapter(story_name, chapters, starting_index)
	local profile = _player_profile()
	local archetype = profile.archetype

	for i = starting_index, #chapters do
		local chapter = chapters[i]
		local archetype_skip_func = chapter.archetype_skip_func
		local should_skip_chapter = archetype_skip_func and archetype_skip_func(chapter, archetype) or false

		if should_skip_chapter then
			if chapter.on_skip then
				chapter.on_skip()
			end

			if chapter.on_complete then
				chapter.on_complete()
			end
		else
			return i
		end
	end

	return nil
end

function NarrativeManager:_update_last_completed_chapter_id(player_profile, story_name, chapters, current_chapter_id)
	local character_id = player_profile.character_id
	local last_completed_index = self._character_narrative_data[character_id].stories[story_name]
	local new_completed_index = current_chapter_id and current_chapter_id - 1 or #chapters
	local chapter_id = chapters[new_completed_index] and chapters[new_completed_index].backend_id

	if chapter_id and last_completed_index < chapter_id then
		self._character_narrative_data[character_id].stories[story_name] = chapter_id

		Managers.backend.interfaces.characters:set_narrative_story_chapter(character_id, story_name, chapter_id)
	end
end

function NarrativeManager:current_chapter(story_name, ignore_all_requirements, ignore_mission_requirement)
	local chapters = Stories[story_name]
	local profile = _player_profile()
	local character_id = profile.character_id
	local last_completed_index = self._character_narrative_data[character_id].stories[story_name]
	local index = last_completed_index + 1
	index = self:_complete_story_chapters_until_valid_chapter(story_name, chapters, index)

	self:_update_last_completed_chapter_id(profile, story_name, chapters, index)

	local chapter = index and chapters[index]

	if not chapter then
		return nil
	end

	if ignore_all_requirements then
		return chapter
	end

	local requirement = chapter.requirement
	local narrative_mission_requirement = nil

	if not ignore_mission_requirement then
		local narrative_mission_requirement_data = chapter.narrative_mission_requirement

		if narrative_mission_requirement_data then
			narrative_mission_requirement = self:_is_narrative_mission_available(unpack(narrative_mission_requirement_data))
		end
	end

	if requirement and not requirement(profile) or narrative_mission_requirement == false then
		return nil
	end

	return chapter
end

function NarrativeManager:complete_current_chapter(story_name, optional_chapter_name)
	local chapter = self:current_chapter(story_name, nil, true)

	if not chapter then
		Log.info("NarrativeManager", "No current chapter to complete in story %s", story_name)

		return false
	end

	if optional_chapter_name then
		local chapter_name = chapter.name

		if chapter_name ~= optional_chapter_name then
			Log.info("NarrativeManager", "This is not the current chapter %s. Current chapter name is: %s", story_name, chapter_name)

			return false
		end
	end

	local profile = _player_profile()
	local character_id = profile.character_id
	self._character_narrative_data[character_id].stories[story_name] = chapter.index

	if chapter.on_complete then
		chapter.on_complete()
	end

	Managers.backend.interfaces.characters:set_narrative_story_chapter(character_id, story_name, chapter.backend_id):catch(function (err)
		Log.warning("NarrativeManager", "Backend fail setting chapter %s in story %s for character %s: %s", chapter.name, story_name, character_id, table.tostring(err))
	end)

	return true
end

function NarrativeManager:complete_chapter_by_name(story_name, chapter_name)
	local chapters = Stories[story_name]
	local chapter_index = self:chapter_index_from_name(story_name, chapter_name)
	local chapter = chapters[chapter_index]
	local profile = _player_profile()

	if not profile then
		return
	end

	local requirement = chapter.requirement

	if requirement and not requirement(profile) then
		Log.warning("NarrativeManager", "Failed completing chapter %s in story %s, requirement not fulfilled", chapter_name, story_name)

		return false
	end

	local character_id = profile.character_id
	self._character_narrative_data[character_id].stories[story_name] = chapter_index

	if chapter.on_complete then
		chapter.on_complete()
	end

	Managers.backend.interfaces.characters:set_narrative_story_chapter(character_id, story_name, chapter.backend_id):catch(function (err)
		Log.warning("NarrativeManager", "Backend fail setting chapter %s in story %s for character %s: %s", chapter_name, story_name, character_id, table.tostring(err))
	end)

	return true
end

function NarrativeManager:chapter_index_from_name(story_name, chapter_name)
	local chapters = Stories[story_name]

	for i = 1, #chapters do
		local c = chapters[i]

		if c.name == chapter_name then
			return i
		end
	end
end

function NarrativeManager:skip_story(story_name)
	local chapters = Stories[story_name]
	local current_chapter = self:current_chapter(story_name, true)
	local start_idx = current_chapter and current_chapter.index or 1

	for i = start_idx, #chapters do
		local chapter = chapters[i]

		if chapter.on_complete then
			chapter.on_complete()
		end

		if chapter.on_skip then
			chapter.on_skip()
		end
	end

	local profile = _player_profile()
	local character_id = profile.character_id
	local last_chapter = chapters[#chapters]
	self._character_narrative_data[character_id].stories[story_name] = last_chapter.index

	Managers.backend.interfaces.characters:set_narrative_story_chapter(character_id, story_name, last_chapter.backend_id):catch(function (err)
		Log.warning("NarrativeManager", "Backend fail setting chapter %s in story %s for character %s: %s", last_chapter.name, story_name, character_id, table.tostring(err))
	end)
end

function NarrativeManager:is_chapter_complete(story_name, chapter_name)
	local chapters = Stories[story_name]

	if not chapters then
		Log.warning("NarrativeManager", "No story with the name '%s'.", story_name)

		return false
	end

	local index = self:chapter_index_from_name(story_name, chapter_name)

	if not index then
		Log.warning("NarrativeManager", "No chapter '%s' in story '%s'.", chapter_name, story_name)

		return false
	end

	local last_completed_chapter = self:last_completed_chapter(story_name)

	if last_completed_chapter == nil or not last_completed_chapter.name then
		return false
	end

	local last_completed_index = last_completed_chapter.index

	return index <= last_completed_index
end

function NarrativeManager:is_story_complete(story_name)
	local chapters = Stories[story_name]

	if not chapters then
		Log.warning("NarrativeManager", "No story with the name '%s'.", story_name)

		return false
	end

	local last_completed_chapter = self:last_completed_chapter(story_name)

	if last_completed_chapter == nil or not last_completed_chapter.name then
		return false
	end

	local last_completed_index = last_completed_chapter.index
	local last_chapter_index = chapters[#chapters].index

	return last_chapter_index <= last_completed_index
end

function NarrativeManager:reset()
	table.clear(self._character_narrative_data)
	table.clear(self._mission_data)
end

function NarrativeManager:is_event_complete(event_name)
	if self._events[event_name] == nil then
		Log.warning("NarrativeManager", "No event with name '%s'.", event_name)

		return false
	end

	local profile = _player_profile()
	local character_id = profile.character_id

	return self._character_narrative_data[character_id].events[event_name] == true
end

function NarrativeManager:can_complete_event(event_name)
	local event = self._events[event_name]

	if event == nil then
		Log.warning("NarrativeManager", "No event with name '%s'.", event_name)

		return false
	end

	local event_completed = self:is_event_complete(event_name)

	if event_completed then
		return false
	end

	local requirement = event.requirement

	if requirement then
		local player_profile = _player_profile()

		return requirement(player_profile)
	end

	return true
end

function NarrativeManager:complete_event(event_name)
	local event = self._events[event_name]

	if event == nil then
		Log.warning("NarrativeManager", "No event with name '%s'.", event_name)

		return false
	end

	if not self:can_complete_event(event_name) then
		return false
	end

	local profile = _player_profile()
	local character_id = profile.character_id
	self._character_narrative_data[character_id].events[event_name] = true

	Managers.backend.interfaces.characters:set_narrative_event_completed(character_id, event_name):catch(function (err)
		Log.warning("NarrativeManager", "Backend failed completing event %s for character %s: %s", event_name, character_id, table.tostring(err))
	end)

	if event.on_complete then
		event.on_complete()
	end

	return true
end

return NarrativeManager
