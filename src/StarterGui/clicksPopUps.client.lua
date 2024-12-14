local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local clicks = leaderstats:WaitForChild("Clicks")
local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

local clicksPopUpTemplate = replicatedStorage:WaitForChild("clicksPopUp")
local abbreviateNumber = require(replicatedStorage:WaitForChild("abbreviateNumber"))

-- Variable para almacenar el último valor de clics
local oldClicksValue = clicks.Value

-- Función para crear un pop-up
local function createClickPopUp(value)
	local clicksPopUp = clicksPopUpTemplate:Clone()
	clicksPopUp.Parent = screenGui
	clicksPopUp.amount.Text = "+" .. abbreviateNumber:Abbreviate(value)

	local randomPosX = math.random(3, 8) / 10
	local randomPosY = math.random(1, 7) / 10
	clicksPopUp.Position = UDim2.new(randomPosX, 0, randomPosY, 0)

	clicksPopUp:TweenSize(
		UDim2.new(0.237, 0, 0.102, 0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Back,
		0.5,
		false,
		function()
			clicksPopUp:TweenSize(
				UDim2.new(0, 0, 0, 0),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Sine,
				0.5,
				false,
				function()
					clicksPopUp:Destroy()
				end
			)
		end
	)
end

-- Función para manejar el cambio de clicks
local function onClicksChanged()
	local newClicksValue = clicks.Value
	local valueGained = newClicksValue - oldClicksValue

	if valueGained > 0 then
		createClickPopUp(valueGained)
	end

	oldClicksValue = newClicksValue
end

-- Conecta el evento de cambio de clics
clicks.Changed:Connect(onClicksChanged)

-- Manejo del rebirth
local rebirthEvent = replicatedStorage:WaitForChild("remoteEvents"):WaitForChild("rebirth")
rebirthEvent.OnClientEvent:Connect(function()
	oldClicksValue = 0  -- Resetea el valor de clics previo
end)
