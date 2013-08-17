--------------------------------------------------------------------------------
--[[
LoadPreset

The absolute minimum code required to get a preset vent loaded onscreen.

Note how the addition of a single parameter can change the entire vent effect - welcome to the world of presets, mon!
--]]
--------------------------------------------------------------------------------

local CBE=require("CBEffects.Library")

local elements=CBE.VentGroup{
	{
		preset="burn"
	}
}

elements:start("burn") -- Vent title defaults to preset name