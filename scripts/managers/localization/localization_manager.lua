local LocalizationMacros = require("scripts/managers/localization/localization_macros")
local LocalizationManager = class("LocalizationManager")
local STRING_RESOURCE_NAMES = {
	"content/localization/ui",
	"content/localization/subtitles",
	"content/localization/items",
	"content/localization/path_of_trust/ui"
}
local ASSERT_ON_MISSING_LOC_PREFIX = false
local STRING_CACHE_EXPECTED_SIZE = 2048
local DEFAULT_LANGUAGE = "en"

local function xbox_format_locale(language_id)
	local supported_languages = {
		["zh-hk"] = "zh-cn",
		["fr-ch"] = "fr",
		["ru-ru"] = "ru",
		["de-ch"] = "de",
		["de-at"] = "de",
		["en-ca"] = "en",
		["en-il"] = "en",
		["en-sa"] = "en",
		["fr-be"] = "fr",
		["en-hk"] = "en",
		["en-cz"] = "en",
		["en-us"] = "en",
		["es-co"] = "es",
		["en-hu"] = "en",
		["en-sg"] = "en",
		["en-gb"] = "en",
		["en-ae"] = "en",
		["zh-tw"] = "zh-tw",
		["en-in"] = "en",
		["de-de"] = "de",
		["en-gr"] = "en",
		["zh-sg"] = "zh-cn",
		["es-ar"] = "es",
		["en-sk"] = "en",
		["pl-pl"] = "pl",
		["ko-kr"] = "ko",
		["pt-br"] = "pt-br",
		["it-it"] = "it",
		["zh-mo"] = "zh-cn",
		["es-es"] = "es",
		["en-au"] = "en",
		["es-mx"] = "es",
		["en-nz"] = "en",
		["zh-cn"] = "zh-cn",
		["fr-fr"] = "fr",
		["fr-ca"] = "fr",
		["ja-jp"] = "ja",
		["es-cl"] = "es",
		["en-ie"] = "en",
		["en-za"] = "en"
	}

	return supported_languages[string.lower(language_id)] or "en"
end

local function ps5_format_locale(language_id)
	local supported_languages = {
		["es-es"] = "es",
		["es-419"] = "es",
		["ru-ru"] = "ru",
		["fr-ca"] = "fr",
		["zh-cn"] = "zh-cn",
		["fr-fr"] = "fr",
		["de-de"] = "de",
		["en-gb"] = "en",
		["ja-jp"] = "ja",
		["ko-kr"] = "ko",
		["pt-br"] = "pt-br",
		["en-us"] = "en",
		["it-it"] = "it",
		["zh-tw"] = "zh-tw",
		["pl-pl"] = "pl"
	}

	return supported_languages[string.lower(language_id)] or "en"
end

local LOCALIZATION_MANAGER_STATUS = table.enum("empty", "loading", "ready")

local function _select_language()
	local language = nil

	if PLATFORM == "win32" then
		language = Application.user_setting("language_id") or HAS_STEAM and Steam:language() or DEFAULT_LANGUAGE
	elseif PLATFORM == "ps5" then
		local locale = PS5.locale() or "error"
		language = ps5_format_locale(locale)
	elseif PLATFORM == "xb1" then
		local locale = XboxLive.locale() or "error"
		language = xbox_format_locale(locale)
	elseif PLATFORM == "xbs" then
		local locale = XboxLive.locale() or "error"
		language = xbox_format_locale(locale)
	elseif PLATFORM == "linux" then
		language = "en"
	end

	return language
end

Localize = Localize or false

function LocalizationManager:init()
	self._backend_localizations = {}
	self._string_cache = Script.new_map(STRING_CACHE_EXPECTED_SIZE)
	local language = _select_language()
	self._original_language = language
	self._enable_string_tags = false
	self._language = language
	self._status = LOCALIZATION_MANAGER_STATUS.empty

	self:_set_resource_property_preference_order(language)
	rawset(_G, "Localize", function (key, no_cache, context)
		return self:localize(key, no_cache, context)
	end)
end

function LocalizationManager:reset_cache()
	self._string_cache = Script.new_map(STRING_CACHE_EXPECTED_SIZE)
end

function LocalizationManager:destroy()
	rawset(_G, "Localize", false)
end

function LocalizationManager:_set_resource_property_preference_order(language)
	if language == DEFAULT_LANGUAGE then
		Application.set_resource_property_preference_order(DEFAULT_LANGUAGE)
	else
		Application.set_resource_property_preference_order(language, DEFAULT_LANGUAGE)
	end
end

function LocalizationManager:setup_localizers(strings_package_id)
	self._package_id = strings_package_id

	print("[LocalizationManager] Setup localizers")

	local num_string_resources = #STRING_RESOURCE_NAMES
	local localizers = Script.new_array(num_string_resources)

	for i = 1, num_string_resources do
		local resource_name = STRING_RESOURCE_NAMES[i]
		localizers[i] = Localizer(resource_name)
	end

	self._localizers = localizers
	self._status = LOCALIZATION_MANAGER_STATUS.ready
end

function LocalizationManager:_teardown_localizers()
	print("[LocalizationManager] Tearing down localizers")

	self._localizers = nil
	local package_manager = Managers.package

	package_manager:release(self._package_id)

	self._package_id = nil
	self._status = LOCALIZATION_MANAGER_STATUS.empty
end

function LocalizationManager:_lookup(key)
	local localizers = self._localizers

	for ii = 1, #localizers do
		local localizer = localizers[ii]
		local loc_str = nil

		if self._lookup_with_tag ~= nil and self._enable_string_tags then
			loc_str = self:_lookup_with_tag(localizer, key)
		else
			loc_str = Localizer.lookup(localizer, key)
		end

		if loc_str then
			return loc_str
		end
	end

	return self._backend_localizations[key]
end

function LocalizationManager:append_backend_localizations(localizations)
	local backend_localizations = self._backend_localizations

	for key, str in pairs(localizations) do
		backend_localizations[key] = str
	end
end

local function _handle_error(key, err)
	local display_message = string.format("<unlocalized %q: %s>", key, err)

	return display_message
end

function LocalizationManager:localize(key, no_cache, context)
	local string_cache = self._string_cache

	if not no_cache and string_cache[key] then
		return string_cache[key]
	end

	if self._status ~= LOCALIZATION_MANAGER_STATUS.ready then
		return ""
	end

	local raw_str = self:_lookup(key)

	if not raw_str then
		return _handle_error(key, "string not found")
	end

	if string.sub(key, 1, 4) ~= "loc_" then
		if ASSERT_ON_MISSING_LOC_PREFIX then
			ferror("[LocalizationManager] Localized string %s is missing 'loc_' prefix", key)
		else
			return _handle_error(key, "missing 'loc_' prefix")
		end
	end

	local str, err = self:_process_string(key, raw_str, context)

	if err then
		return _handle_error(key, err)
	end

	string_cache[key] = str

	return str
end

local function _apply_macro_callback(key, errors, macro_name, macro_param)
	local macro_func = LocalizationMacros[macro_name]

	if not macro_func then
		errors[#errors + 1] = string.format("macro %q not found", macro_name)

		return ""
	end

	if macro_param == "" then
		macro_param = nil
	end

	return macro_func(macro_param)
end

local function _apply_interpolation_callback(string_key, errors, context, context_key, format)
	local context_value = context and context[context_key]

	if not context_value then
		Log.error("LocalizationManager", "Missing context value for key %q in %s", context_key, string_key)

		format = "%s"
		context_value = string.format("\"%s:undefined\"", context_key)
	end

	if format == "" then
		return tostring(context_value)
	end

	local success, result = pcall(string.format, format, context_value)

	if success then
		return result
	else
		errors[#errors + 1] = string.format("string.format() failed on context.%s", context_key)

		return ""
	end
end

local _error_table = {}

function LocalizationManager:_process_string(key, raw_str, context)
	table.clear(_error_table)

	raw_str = string.gsub(raw_str, "%$([%a%d_]*):*([%a%d,_]*)%$", callback(_apply_macro_callback, key, _error_table))
	raw_str = string.gsub(raw_str, "{([%a%d_]*):*([%a%d%.%%]*)}", callback(_apply_interpolation_callback, key, _error_table, context))
	local error_string = #_error_table > 0 and table.concat(_error_table, "; ") or nil

	return raw_str, error_string
end

function LocalizationManager:exists(key)
	return self:_lookup(key) ~= nil
end

function LocalizationManager:language()
	return self._language
end

return LocalizationManager
