--------------------------------------------------------------------------------
--[[
BasicFieldGroup

Demonstrates the basic usage of FieldGroups when coupled with a VentGroup
--]]
--------------------------------------------------------------------------------

local CBE=require("CBEffects.Library")

local VentGroup=CBE.VentGroup{
	{
		posRadius=display.contentCenterX*0.5,
		posInner=display.contentCenterX*0.45,
		onCreation=function(p)
			p:setLinearVelocity((display.contentCenterX-p.x)*0.02, (display.contentCenterY-p.y)*0.02)
		end
	}
}

local FieldGroup=CBE.FieldGroup{
	{
		targetVent=VentGroup:get("default"), -- Without a targetVent, an error will occur
		preset="stop"
	}
}

VentGroup:start("default")
FieldGroup:start("stop") -- FieldGroups must be started, just like VentGroups