local SplineFollower = component("SplineFollower")

function SplineFollower:init(unit)
	return
end

function SplineFollower:editor_validate(unit)
	return true, ""
end

function SplineFollower:enable(unit)
	return
end

function SplineFollower:disable(unit)
	return
end

function SplineFollower:destroy(unit)
	return
end

SplineFollower.component_data = {
	extensions = {
		"SplineFollowerExtension"
	}
}

return SplineFollower
