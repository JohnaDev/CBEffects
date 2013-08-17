--------------------------------------------------------------------------------
--[[
BasicVent

The absolute minimum code required to get a functional particle effect onscreen.
--]]
--------------------------------------------------------------------------------

local CBE=require("CBEffects.Library")

local VentGroup=CBE.VentGroup{
	{}
}

VentGroup:start("default") -- Vent title defaults to preset name