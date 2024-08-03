local ServerMetricsManagerDummy = class("DummyServerMetricsManager")
local ServerMetricsManagerInterface = require("scripts/managers/server_metrics/server_metrics_manager_interface")

function ServerMetricsManagerDummy:init()
	return
end

function ServerMetricsManagerDummy:destroy()
	return
end

function ServerMetricsManagerDummy:add_annotation(type_name, metadata)
	return
end

function ServerMetricsManagerDummy:set_gauge(metric_name, value)
	return
end

function ServerMetricsManagerDummy:update(dt)
	return
end

implements(ServerMetricsManagerDummy, ServerMetricsManagerInterface)

return ServerMetricsManagerDummy
