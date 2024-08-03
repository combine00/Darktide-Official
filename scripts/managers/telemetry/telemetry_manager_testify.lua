local TelemetryManagerTestify = {}

function TelemetryManagerTestify.send_telemetry_batch(telemetry_manager)
	telemetry_manager:post_batch()
end

function TelemetryManagerTestify.wait_for_batch_post(telemetry_manager)
	if telemetry_manager:batch_in_flight() then
		return Testify.RETRY
	end
end

return TelemetryManagerTestify
