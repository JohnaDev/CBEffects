--------------------------------------------------------------------------------
--[[
Ring

A vent with preset "default" edited to appear in a ring.

Be careful that the posInner parameter is never above the posRadius parameter!
--]]
--------------------------------------------------------------------------------

local CBE=require("CBEffects.Library")

local VentGroup=CBE.VentGroup{
	{
		posRadius=display.contentCenterX*0.5,
		posInner=display.contentCenterX*0.45
	}
}

VentGroup:start("default")