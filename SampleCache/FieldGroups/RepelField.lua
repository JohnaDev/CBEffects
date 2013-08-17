--------------------------------------------------------------------------------
--[[
RepelField

Creates a FieldGroup that repels particles. When the screen is touched, the FieldGroup is moved to that location and started.
--]]
--------------------------------------------------------------------------------

local CBE = require("CBEffects.Library")

local vent = CBE.NewVent{
	posRadius = display.contentCenterX -- Have particles appear all around the screen
}

local FieldGroup = CBE.FieldGroup{
	{
		targetVent = vent, -- Without a targetVent, an error will occur
		preset = "out",
		radius = display.contentCenterX, -- Make the collision radius large so that more particles are affected by it
		onFieldInit = function(f)
			f.magnitude = 0.01 -- The "out" preset multiplies the force by the field's magnitude, so we can set the "strength" without having to overwrite the onCollision function
		end
	}
}

local function onScreenTouch(event)
	FieldGroup:translate("out", event.x, event.y)

	if "began" == event.phase then
		FieldGroup:start("out")
	elseif "ended" == event.phase then
		FieldGroup:stop("out")
	end
end

vent:start()
Runtime:addEventListener("touch", onScreenTouch)