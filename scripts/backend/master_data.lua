local CacheWrapper = require("scripts/backend/cache_wrapper")
local ItemPackage = require("scripts/foundation/managers/package/utilities/item_package")
local LocalLoader = require("scripts/settings/equipment/local_items_loader")
local Promise = require("scripts/foundation/utilities/promise")
local Interface = {
	"items_cache"
}
local MasterData = class("MasterData")
local ITEMS_TO_PROCESS_PER_BATCH = 100

function MasterData:init()
	self._local_item_version = 0
end

function MasterData:on_reload(refreshed_resources)
	if refreshed_resources.item then
		self._local_item_version = self._local_item_version + 1

		Log.info("MasterData", "Items recompiled, reloading. Version: %s", self._local_item_version)
		self._fetch_items_wrapper:refresh()
	end
end

function MasterData:items_cache()
	if not self._fetch_items_wrapper then
		local metadata_cb = callback(self, "_get_items_metadata")
		local fetch_cb = callback(self, "_get_items_from_backend")
		local fallback_cb = callback(self, "_fail_on_missing_metadata")
		self._fetch_items_wrapper = CacheWrapper:new(metadata_cb, fetch_cb, fallback_cb)
	end

	return self._fetch_items_wrapper
end

local function create_network_lookup(items)
	NetworkLookup.create_item_names_lookup(items)
	NetworkLookup.create_attachment_names_lookup(items)

	local NetworkConstants = require("scripts/network_lookup/network_constants")

	NetworkConstants.check_network_lookup_boundaries("player_item_name", "player_item_names")
	NetworkConstants.check_network_lookup_boundaries("player_attachment_name", "player_attachment_names")
end

function MasterData:refresh_network_lookup()
	if not NetworkLookup.player_item_names then
		create_network_lookup(self:items_cache():get_cached())
	end
end

local function _process_slice(batch, process_func)
	return function ()
		for i = 1, #batch do
			batch[i] = process_func(batch[i])
		end

		return Promise.delay(0)
	end
end

local function _process_batch_slice(data, max_events_per_batch, process_func)
	if #data == 0 then
		return Promise.resolved()
	end

	local batches = {}
	local from = {}

	for position = 1, #data, max_events_per_batch do
		local remaining_size = math.min(#data - position + 1, max_events_per_batch)
		local batch = table.slice(data, position, remaining_size)
		batches[#batches + 1] = batch
		from[#from + 1] = position
	end

	local promise = _process_slice(batches[1], process_func)()

	for i = 2, #batches do
		promise = promise:next(_process_slice(batches[i], process_func))
	end

	return promise:next(function ()
		return data
	end)
end

local function _patch_non_released_dlcs(item_data)
	return
end

local function _include_item_definition(item_data)
	item_data.display_name = item_data.display_name or "n/a"
	item_data.resource_dependencies = {}

	ItemPackage.compile_resource_dependencies(item_data, item_data.resource_dependencies)
end

local function _include_items_definition(items)
	local items_array = {}

	for k, item_data in pairs(items) do
		item_data.name = k
		items_array[#items_array + 1] = item_data
	end

	return _process_batch_slice(items_array, ITEMS_TO_PROCESS_PER_BATCH, _include_item_definition)
end

function MasterData:_get_items_from_metadata_db()
	return LocalLoader.get_items_from_metadata_db():next(function (items)
		return _include_items_definition(items):next(function ()
			create_network_lookup(items)
			table.set_readonly(items, "Item Definitions")

			return items
		end)
	end)
end

function MasterData:_get_items_from_backend(version, url)
	local promise = nil

	if version ~= nil and url ~= nil then
		Log.info("MasterData", "Fetching master items at %s", url)

		promise = Managers.backend:url_request(url, {
			require_auth = true
		})
	else
		promise = self:_get_items_metadata():next(function (metadata)
			Log.info("MasterData", "Fetching master items at %s", metadata.url)

			return Managers.backend:url_request(metadata.url, {
				require_auth = true
			})
		end)
	end

	return promise:next(function (data)
		return data.body
	end):next(function (items)
		return _include_items_definition(items):next(function ()
			create_network_lookup(items)
			table.set_readonly(items, "Item Definitions")

			return items
		end)
	end)
end

function MasterData:_get_local_items_metadata()
	local promise = Promise.new()

	promise:resolve({
		version = self._local_item_version
	})

	return promise
end

function MasterData:_fail_on_missing_metadata()
	return Promise.rejected({
		message = "Failed fetching item master data"
	})
end

function MasterData:_get_items_metadata()
	return Managers.backend:title_request("/master-data/meta/items"):next(function (data)
		return data.body
	end):next(function (metadata)
		return {
			version = metadata.playerItems.version,
			url = metadata.playerItems.href
		}
	end)
end

implements(MasterData, Interface)

return MasterData
