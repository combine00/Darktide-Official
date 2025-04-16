local PromiseContainer = class("PromiseContainer")

function PromiseContainer:init()
	self._promises = {}
end

function PromiseContainer:destroy()
	for promise, _ in pairs(self._promises) do
		promise:cancel()
	end
end

function PromiseContainer:cancel_on_destroy(promise)
	local track_promise = promise:is_pending() and not self._promises[promise]

	if track_promise then
		self._promises[promise] = true

		promise:next(function ()
			self._promises[promise] = nil
		end, function ()
			self._promises[promise] = nil
		end)
	end

	return promise
end

return PromiseContainer
