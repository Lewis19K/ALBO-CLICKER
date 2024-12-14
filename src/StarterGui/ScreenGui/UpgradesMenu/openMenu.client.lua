local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = ReplicatedStorage:WaitForChild("remoteEvents")
local openUpgrades = remoteEvents:WaitForChild("openUpgrades")

local upgradesMenu = script.Parent

openUpgrades.OnClientEvent:Connect(function()
	upgradesMenu.Visible = true
end)