-- requires a attachment with a proximitypromt in the model along with a Bool Value named "Domes" 
-- Set the Domes value to true if your CCM has dome lights that run with it else keep it false
wait(0.1)
local car = script.Parent.Parent.Parent.Parent
local prox = script.Parent.Attachment.ProximityPrompt
local red = script.Parent.Parent.Red
local IsHold = script.IsHold
local lights = script.Parent.Parent.Parent.Lights.Dome.DLights
local CanTrigger = car.DriveSeat["Child Check"].CanTrigger
local Domes = script.Parent.Domes
local BusSettings = require(script.Parent.Parent.Parent.Parent.DriveSeat.BusSettings)
local ts = game:GetService("TweenService")
local Tinfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false)
local functions = require(script.Parent.Parent.Parent.Parent.DriveSeat.BusFunctions)

IsHold.Changed:Connect(function()
	while IsHold.Value == true do
		red.Material = "Neon"
		wait(0.05)
		red.Material = "SmoothPlastic"
		wait(0.05)
	end
end)

function EnableINC(l, s)
	if s then
		l.BrickColor = BrickColor.new(s)
	end
	local a = ts:Create(l, Tinfo, {Transparency = 0.01})
	a:Play()
end

function DisableINC(l)
	local a = ts:Create(l, Tinfo, {Transparency = 1})
	a:Play()
end

function DLL()
	for _,v in pairs(lights:GetChildren()) do -- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0
		v.Material = Enum.Material.SmoothPlastic
	end
	wait(0.4)
	for _,v in pairs(lights:GetChildren()) do -- on
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 2
		v.Material = Enum.Material.Neon
	end
	wait(0.4)
	for _,v in pairs(lights:GetChildren()) do -- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0

		v.Material = Enum.Material.SmoothPlastic
	end
	wait(0.4)
	for _,v in pairs(lights:GetChildren()) do -- on
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 2
		v.Material = Enum.Material.Neon
	end
	wait(0.4)
	for _,v in pairs(lights:GetChildren()) do -- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0
		v.Material = Enum.Material.SmoothPlastic
	end
end

function DLI()
	for _,v in pairs(lights:GetChildren()) do	-- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0
		DisableINC(v)
	end
	wait(1)
	for _,v in pairs(lights:GetChildren()) do -- on
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 2
		EnableINC(v)
	end
	wait(1)
	for _,v in pairs(lights:GetChildren()) do -- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0
		DisableINC(v)
	end
	wait(1)
	for _,v in pairs(lights:GetChildren()) do -- on
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 2
		EnableINC(v)
	end
	wait(1)
	for _,v in pairs(lights:GetChildren()) do -- off
		car.Body.Lights.Dome.DomeArea.DA.Brightness = 0
		DisableINC(v)
	end
end

prox.PromptButtonHoldBegan:Connect(function()
	IsHold.Value = true
end)

prox.PromptButtonHoldEnded:Connect(function()
	IsHold.Value = false
end)

prox.Triggered:Connect(function()
	if CanTrigger.Value == true then
		car.DriveSeat.CCActivate:Stop()
		CanTrigger.Value = false
		if Domes.Value == true then
			if BusSettings.DomeLights == "INC" then
			DLI()
			end
			if BusSettings.DomeLights == "LED" then
			DLL()
			end
		end
	end
end)
