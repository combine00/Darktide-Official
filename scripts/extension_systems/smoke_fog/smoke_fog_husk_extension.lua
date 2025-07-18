local SmokeFogHuskExtension = class("SmokeFogHuskExtension")

function SmokeFogHuskExtension:init(extension_init_context, unit, extension_init_data, game_session, game_object_id)
	self._game_session = game_session
	self._game_object_id = game_object_id
	local smoke_fade_frame = GameSession.game_object_field(game_session, game_object_id, "smoke_fade_frame")
	self._smoke_fade_frame = smoke_fade_frame
	self._smoke_fade_t = smoke_fade_frame * Managers.state.game_session.fixed_time_step
end

function SmokeFogHuskExtension:update(unit, dt, t)
	local game_session = self._game_session
	local game_object_id = self._game_object_id
	local smoke_fade_frame = GameSession.game_object_field(game_session, game_object_id, "smoke_fade_frame")

	if smoke_fade_frame ~= self._smoke_fade_frame then
		self._smoke_fade_frame = smoke_fade_frame
		self._smoke_fade_t = smoke_fade_frame * Managers.state.game_session.fixed_time_step
	end
end

function SmokeFogHuskExtension:remaining_duration(t)
	return self._smoke_fade_t - t
end

return SmokeFogHuskExtension
