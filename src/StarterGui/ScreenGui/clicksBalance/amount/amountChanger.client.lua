local clicksBalance = script.Parent

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local clicks = leaderstats:WaitForChild("Clicks")

local number = clicks.Value

local replicatedStorage = game:GetService("ReplicatedStorage")
local abbreviateNumber = require(replicatedStorage:WaitForChild("abbreviateNumber"))

clicksBalance.Text = abbreviateNumber:Abbreviate(clicks.Value)

clicks.Changed:Connect(function()
	clicksBalance.Text = abbreviateNumber:Abbreviate(clicks.Value)
end)