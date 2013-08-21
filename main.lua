display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------
--CBResources Sample App
--------------------------------------------------------------------------------

local originX
local exitX
local wrap
local pairsByKeys
local initiate
local either
local logo
local toFront
local buttonSheet
local CBE
local ParticleHelper
local widget
local extras
local custom
local samples
local sampleLib
local samplecache
local curSample
local nextSample
local prevSample
local numSamples
local texts
local centerText
local leftText
local rightText
local centerBkg
local leftBkg
local rightBkg
local updateTexts
local buttons
local leftButton
local rightButton
local leftListener
local rightListener
local alertListener
local mode

custom = require("SampleApp.custom")
mode = "custom"

-- Display values
originX=display.screenOriginX
exitX=display.contentWidth-originX

-- Wrap a number from range 1-[high]
function wrap(num, high) return ((num-1)%high)+1 end

-- Alphabetical pairs
function pairsByKeys(t, f) local a={} for n in pairs(t) do table.insert(a, n) end table.sort(a, f) local i=0 return function() i=i+1 return a[i], t[a[i]] end end
	
-- Pick a random entry from a table
function either(table) if #table==0 then return nil else return table[math.random(#table)] end end


initiate=function()
	-- Load external libraries
	CBE=require("CBEffects.Library")
	ParticleHelper=require("CBEffects.ParticleHelper")
	widget=require("widget")
	extras=require("SampleApp.extras")
	
	samples={}
	curSample=0; nextSample=0; prevSample=0; numSamples=0

	buttonSheet=graphics.newImageSheet("Textures/generic_particle.png", {width=200, height=200, numFrames=1})


	------------------------------------------------------------------------------
	-- Build Preset Samples
	------------------------------------------------------------------------------
	for k, v in pairsByKeys(ParticleHelper.presets.vents) do
		samples[#samples+1]={title="Preset: "..string.upper(k:sub(1,1))..k:sub(2,#k)}
		local s=samples[#samples]
		s.initiate=function()
			s.sampleVent=CBE.NewVent{preset = k}
			s.sampleVent:start()
		end
		s.stop=function()
			s.sampleVent:destroy()
			s.sampleVent=nil
		end
		numSamples=numSamples+1
	end
	

	------------------------------------------------------------------------------
	-- Build Sample Library Samples
	------------------------------------------------------------------------------
	sampleLib=require("SampleApp.samples")

	for i=1, #sampleLib do
		samples[#samples+1]=sampleLib[i]
		numSamples=numSamples+1
	end

	curSample=numSamples
	prevSample=wrap(curSample-1, numSamples)
	nextSample=wrap(curSample+1, numSamples)


	------------------------------------------------------------------------------
	-- Build Status Texts
	------------------------------------------------------------------------------
	texts=display.newGroup()

		centerText=extras.createStatusText(samples[curSample].title, 512, 47, texts)

		centerBkg=extras.createStatusBkg(centerText.width*1.2, centerText.height*1.1, 512, 50, texts)

		----------------------------------------------------------------------------

		leftText=extras.createStatusText(samples[prevSample].title, originX+30, 27, texts, 20)
		leftText.alpha=0.6

		leftBkg=extras.createStatusBkg(leftText.width*1.2, leftText.height*1.1, leftText.x+(leftText.width/2), 30, texts)
		leftBkg.alpha=0.6

		----------------------------------------------------------------------------

		rightText=extras.createStatusText(samples[nextSample].title, exitX-30, 27, texts, 20)
		rightText.alpha=0.6

		rightBkg=extras.createStatusBkg(rightText.width*1.2, rightText.height*1.1, rightText.x-(rightText.width/2), 30, texts)
		rightBkg.alpha=0.6

		----------------------------------------------------------------------------

		function updateTexts()
			centerBkg.width=centerText.width*1.2

			leftText:setReferencePoint(display.CenterLeftReferencePoint)
			leftText.x, leftText.y=originX+30, 27

			rightText:setReferencePoint(display.CenterRightReferencePoint)
			rightText.x, rightText.y=exitX-30, 27

			leftBkg.width=leftText.width*1.2
			leftBkg.x=leftText.x+(leftText.width/2)

			rightBkg.width=rightText.width*1.2
			rightBkg.x=rightText.x-(rightText.width/2)


			rightText:toFront()
			leftText:toFront()
			centerText:toFront()
		end

	buttons=display.newGroup()

		function leftListener()
			samples[curSample].stop()
			curSample=wrap(curSample-1, numSamples)
			prevSample=wrap(curSample-1, numSamples)
			nextSample=wrap(curSample+1, numSamples)

			samples[curSample].initiate()

			centerText.text=samples[curSample].title
			rightText.text=samples[nextSample].title
			leftText.text=samples[prevSample].title
			updateTexts()
		end

		function rightListener()
			samples[curSample].stop()
			curSample=wrap(curSample+1, numSamples)
			prevSample=wrap(curSample-1, numSamples)
			nextSample=wrap(curSample+1, numSamples)

			samples[curSample].initiate()

			centerText.text=samples[curSample].title
			rightText.text=samples[nextSample].title
			leftText.text=samples[prevSample].title
			updateTexts()
		end

		leftButton=widget.newButton{
			defaultFile="Textures/button_default.png",
			overFile="Textures/button_over.png",
			width=64,
			height=64,
			onRelease=leftListener,
			isEnabled=false
		}
		leftButton.x, leftButton.y=originX+32, 384
		buttons:insert(leftButton)
		leftButton:setFillColor(255, 255, 0)
		leftButton._view._over:setFillColor(255, 255, 0)

		rightButton=widget.newButton{
			defaultFile="Textures/button_default.png",
			overFile="Textures/button_over.png",
			width=64,
			height=64,
			onRelease=rightListener,
			isEnabled=false
		}
		rightButton.x, rightButton.y=exitX-32, 384
		buttons:insert(rightButton)
		rightButton:setFillColor(255, 255, 0)
		rightButton._view._over:setFillColor(255, 255, 0)

	logo=display.newImage("Bragging/logo_website.png")
	logo.x, logo.y=512, 384
	logo.alpha=0
	transition.to(logo, {alpha = 1, time = 500, delay = 500})
	transition.to(logo, {xScale = 1.2, yScale = 1.2, alpha = 0, delay = 1500, time=500, transition=easing.outQuad, onComplete=function() 
		timer.performWithDelay(500, function()
			samples[curSample].initiate()
				leftButton:setEnabled(true)
				rightButton:setEnabled(true)
			end)
		end
	})

	function toFront()
		texts:toFront()
		logo:toFront()
	end
	
	updateTexts()
	Runtime:addEventListener("enterFrame", toFront)
end

alertListener=function(event)
	if event.index==1 then
		initiate()
	elseif event.index==2 then
		custom.initiate()
	end
end

if mode=="choose" then
	native.showAlert("Startup", "Welcome to CBResources! You have a choice whether to use the sample browser app or to load the custom code found in the \"initiate\" function of custom.lua. To change the load type beforehand, edit line #44 of main.lua to one of these values.\n\n\"custom\" loads the custom code on startup\n\"samples\" loads the sample browser on startup\n\"choose\" gives you this choice on startup\n\nEnjoy!", {"Load Sample Browser", "Load Custom Code"}, alertListener)
elseif mode=="custom" then
	custom.initiate()
elseif mode=="samples" then
	initiate()
end