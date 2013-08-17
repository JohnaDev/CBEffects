--------------------------------------------------------------------------------
--[[
AttractField

Creates a FieldGroup that attracts particles. When the screen is touched, the FieldGroup is moved to that location and started.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.NewVent{
	posRadius = display.contentCenterX
}

local FieldGroup = CBE.FieldGroup{
	{
		targetVent = vent,
		radius = display.contentCenterX, -- Make the collision radius large so that more particles are affected by it
		onFieldInit = function(f)
			f.magnitude = 0.01
		end
	}
}

local function onScreenTouch(event)
	FieldGroup:translate("default", event.x, event.y)

	if "began" == event.phase then
		FieldGroup:start("default")
	elseif "ended" == event.phase then
		FieldGroup:stop("default")
	end
end

vent:start()
Runtime:addEventListener("touch", onScreenTouch)