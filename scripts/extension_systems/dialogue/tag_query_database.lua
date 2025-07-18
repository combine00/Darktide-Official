local DialogueCategoryConfig = require("scripts/settings/dialogue/dialogue_category_config")
local TagQuery = require("scripts/extension_systems/dialogue/tag_query")
local TagQueryDatabase = class("TagQueryDatabase")
TagQueryDatabase.NUM_DATABASE_RULES = 4095

function TagQueryDatabase:init(dialogue_system)
	self._database = RuleDatabase.initialize(TagQueryDatabase.NUM_DATABASE_RULES)
	self._rule_id_mapping = {}
	self._rules_n = 0
	self._contexts_by_object = {}
	self._queries = {}
	self._dialogue_system = dialogue_system
end

function TagQueryDatabase:destroy()
	RuleDatabase.destroy(self._database)

	self._database = nil
	self._rule_id_mapping = nil
	self._contexts_by_object = nil
	self._queries = nil
end

function TagQueryDatabase:add_object_context(object, context_name, context)
	local object_context_list = self._contexts_by_object[object] or {}
	self._contexts_by_object[object] = object_context_list
	object_context_list[context_name] = context
end

function TagQueryDatabase:remove_object(object)
	self._contexts_by_object[object] = nil
end

function TagQueryDatabase:contexts_by_object()
	return self._contexts_by_object
end

function TagQueryDatabase:set_global_context(context)
	self.global_context = context
end

function TagQueryDatabase:create_query()
	return setmetatable({
		query_context = {},
		tagquery_database = self
	}, TagQuery)
end

function TagQueryDatabase:add_query(query)
	self._queries[#self._queries + 1] = query
end

function TagQueryDatabase:finalize_rules()
	RuleDatabase.sort_rules(self._database)
end

RuleDatabase.initialize_static_values()

local operator_lookup = {
	EQ = RuleDatabase.OPERATOR_EQUAL,
	LT = RuleDatabase.OPERATOR_LT,
	GT = RuleDatabase.OPERATOR_GT,
	NOT = RuleDatabase.OPERATOR_NOT,
	LTEQ = RuleDatabase.OPERATOR_LTEQ,
	GTEQ = RuleDatabase.OPERATOR_GTEQ,
	NEQ = RuleDatabase.OPERATOR_NOT_EQUAL,
	RAND = RuleDatabase.OPERATOR_RAND,
	SET_INCLUDES = RuleDatabase.OPERATOR_SET_INCLUDES,
	SET_INTERSECTS = RuleDatabase.OPERATOR_SET_INTERSECTS,
	SET_NOT_INTERSECTS = RuleDatabase.OPERATOR_SET_NOT_INTERSECTS,
	SET_NOT_INCLUDES = RuleDatabase.OPERATOR_SET_NOT_INCLUDES
}
local context_indexes = table.mirror_array_inplace({
	"global_context",
	"query_context",
	"user_context",
	"user_memory",
	"faction_memory",
	"faction_context"
})

function TagQueryDatabase:define_rule(rule_definition)
	local dialogue_name = rule_definition.name
	local criterias = rule_definition.criterias
	local real_criterias = table.clone(criterias)
	rule_definition.real_criterias = real_criterias
	local num_criterias = #criterias
	local context_indexes = context_indexes
	rule_definition.n_criterias = num_criterias
	local add_rule = true

	for i = 1, num_criterias do
		local criteria = criterias[i]
		local context_name = criteria[1]
		local operator = criteria[3]
		local value = nil

		if operator == "TIMEDIFF" then
			operator = criteria[4]
			value = criteria[5]
			criteria[5] = true
		else
			criteria[5] = false

			if criteria.args then
				value = criteria.args
			else
				value = criteria[4]
			end
		end

		local operator_index = operator_lookup[operator]
		criteria[3] = operator_index
		local value_type = type(value)

		if value_type == "string" then
			criteria[4] = value
		elseif value_type == "boolean" then
			if value then
				value = 1
			else
				value = 0
			end

			criteria[4] = value
		elseif value_type == "number" then
			criteria[4] = value
		elseif value_type == "table" then
			criteria[4] = value

			if table.is_empty(value) then
				add_rule = false
			end
		end
	end

	if add_rule then
		local rule_id = RuleDatabase.add_rule(self._database, dialogue_name, num_criterias, criterias)
		self._rule_id_mapping[rule_id] = rule_definition
		self._rule_id_mapping[rule_definition.name] = rule_id
		self._rules_n = self._rules_n + 1
	end
end

function TagQueryDatabase:remove_rule(rule_name)
	local rule_id = self._rule_id_mapping[rule_name]

	if rule_id then
		self._rule_id_mapping[rule_id] = nil
		self._rule_id_mapping[rule_name] = nil
		self._rules_n = self._rules_n - 1

		RuleDatabase.remove_rule(self._database, rule_id)
	end
end

function TagQueryDatabase:num_rules()
	return self._rules_n
end

local best_queries = Script.new_array(8)
local temp_queries = Script.new_array(16)

function TagQueryDatabase:iterate_queries(t)
	table.clear_array(best_queries, #best_queries)
	table.clear_array(temp_queries, #temp_queries)

	local num_iterations = #self._queries
	local num_temp_queries = 0
	local best_query = nil
	local best_query_value = 0
	local best_query_category, best_query_category_name = nil

	for i = 1, num_iterations do
		local query = self:_iterate_query(t)
		local result = query.result

		if result then
			local validated_rule = query.validated_rule
			local category_name = validated_rule.category
			local category = DialogueCategoryConfig[category_name]

			if category.multiple_allowed then
				num_temp_queries = num_temp_queries + 1
				temp_queries[num_temp_queries] = query
			end

			local category_score = category.query_score
			local value = validated_rule.n_criterias + category_score

			if best_query_value < value then
				best_query_category_name = category_name
				best_query_category = category
				best_query_value = value
				best_query = query
			elseif value == best_query_value and math.random() > 0.5 then
				best_query_category_name = category_name
				best_query_category = category
				best_query_value = value
				best_query = query
			end
		end
	end

	if best_query and best_query_category.multiple_allowed then
		local num_best_queries = 0

		for i = 1, num_temp_queries do
			local query = temp_queries[i]
			local validated_rule = query.validated_rule
			local category_name = validated_rule.category

			if category_name == best_query_category_name then
				num_best_queries = num_best_queries + 1
				best_queries[num_best_queries] = query
			end
		end
	elseif best_query then
		best_queries[1] = best_query
	end

	return best_queries
end

local dummy_table = {}

function TagQueryDatabase:_iterate_query(t)
	local query = table.remove(self._queries, 1)

	if not query then
		return
	end

	local query_context = query.query_context
	local source = query_context.source
	local user_context_list = self._contexts_by_object[source]

	if user_context_list == nil then
		return query
	end

	local nice_array = {
		self.global_context or dummy_table,
		query_context or dummy_table,
		user_context_list.user_context or dummy_table,
		user_context_list.user_memory or dummy_table,
		user_context_list.faction_memory or dummy_table,
		0
	}
	local dialogue_extension = ScriptUnit.extension_input(source, "dialogue_system")

	if dialogue_extension and dialogue_extension:faction_name() and dialogue_extension:faction_name() == "imperium" then
		self._dialogue_system:populate_faction_contexts(nice_array, 6, dialogue_extension:faction_name(), source)
	end

	local rule_index_found = RuleDatabase.iterate_query(self._database, nice_array, t)

	if rule_index_found then
		local rule = self._rule_id_mapping[rule_index_found]
		local response = rule.response
		local has_event = dialogue_extension:has_dialogue(response)

		if has_event then
			query.validated_rule = rule
			query.result = response
			query.rule_index = rule_index_found
		end
	end

	return query
end

function TagQueryDatabase:get_rule(rule_index)
	return self._rule_id_mapping[rule_index]
end

return TagQueryDatabase
