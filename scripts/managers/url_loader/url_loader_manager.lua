local Promise = require("scripts/foundation/utilities/promise")
local UrlLoaderManager = class("UrlLoaderManager")

function UrlLoaderManager:init()
	self._cached_textures = {}
	self._cached_promises = {}
	self._reference_count = {}
end

function UrlLoaderManager:_on_load_texture_ok(url, backend_data)
	local texture_data = {
		url = url,
		texture = backend_data.texture,
		width = backend_data.texture_width,
		height = backend_data.texture_height
	}
	self._cached_promises[url] = nil
	self._cached_textures[url] = texture_data

	return texture_data
end

function UrlLoaderManager:_on_load_texture_error(url, backend_error)
	local error_string = type(backend_error) == "table" and table.tostring(backend_error, 3) or backend_error

	Log.warning("UrlLoaderManager", "Failed to load texture data for url '%s' with error: %s", url, error_string)

	local texture_data = {
		url = url
	}
	self._cached_promises[url] = nil
	self._cached_textures[url] = texture_data

	return texture_data
end

function UrlLoaderManager:load_texture(url, require_auth)
	self._reference_count[url] = (self._reference_count[url] or 0) + 1
	local cached_promise = self._cached_promises[url]

	if cached_promise then
		return cached_promise
	end

	local texture_data = self._cached_textures[url]

	if texture_data then
		return Promise.resolved(texture_data)
	end

	local promise = Managers.backend:url_request(url, {
		require_auth = require_auth ~= false
	}):next(callback(self, "_on_load_texture_ok", url), callback(self, "_on_load_texture_error", url))
	self._cached_promises[url] = promise

	return promise
end

function UrlLoaderManager:_destroy_texture_data(url)
	local texture_data = self._cached_textures[url]
	self._cached_textures[url] = nil
	self._reference_count[url] = nil
	local texture = texture_data.texture

	if texture then
		Backend.unload_texture(texture)
	end
end

function UrlLoaderManager:unload_texture(url)
	local count = self._reference_count[url]
	count = count - 1
	self._reference_count[url] = count
	local should_destroy = count == 0
	local has_data = self._cached_textures[url] ~= nil

	if should_destroy and has_data then
		self:_destroy_texture_data(url)
	end
end

function UrlLoaderManager:update(dt, t)
	local reference_count = self._reference_count

	for url, count in pairs(reference_count) do
		local has_promise = self._cached_promises[url] ~= nil

		if count == 0 and not has_promise then
			self:_destroy_texture_data(url)
		end
	end
end

function UrlLoaderManager:destroy()
	for _, promise in pairs(self._cached_promises) do
		promise:cancel()
	end
end

return UrlLoaderManager
