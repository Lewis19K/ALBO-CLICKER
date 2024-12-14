local rebirthButton = script.Parent

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("remoteEvents")
local rebirthEvent = remoteEvents:WaitForChild("rebirth")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")

rebirthButton.MouseButton1Up:Connect(function()
	local clicks = leaderstats.Clicks.Value
	local rebirths = leaderstats.Rebirths.Value
	
	local rebirthsAmount = tonumber(rebirthButton.Name)
	local cost = rebirthsAmount*100*((1)+(rebirths/10))
	local gemsGiven = rebirthsAmount*10
	
	if clicks >= cost then
		rebirthEvent:FireServer(rebirthsAmount, gemsGiven)
	end
end)