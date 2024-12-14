local rebirthOptions = {
	1, --1 rebirthButtons value
	5, --2 rebirthsButton value
	10,
	25,
	50,
	100,
	250,
	500,
	1000,
	2500, --10 rebirthButtons value
	5000,
	10000,
	25000,
	50000,
	100000,
	250000,
	500000,
	1000000,
	2500000,
	5000000, --20
	10000000,
	25000000,
	50000000,
	100000000,
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local template = ReplicatedStorage:WaitForChild("templateRebirthButton")
local abbreviateNumber = require(ReplicatedStorage:WaitForChild("abbreviateNumber"))

local scrollingFrame = script.Parent

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local leaderstats = player:WaitForChild("leaderstats")
local rebirths = leaderstats:WaitForChild("Rebirths")
local upgrades = player:WaitForChild("Upgrades")
local rebirthButtons = upgrades:WaitForChild("RebirthButtons")

local amount = rebirthButtons.Value
for count = 1, amount do
	if not scrollingFrame:FindFirstChild(rebirthOptions[count]) then
		local newButton = template:Clone()
		local rebirthsAmount = rebirthOptions[count]
		newButton.Name = rebirthsAmount
		newButton.rebirthAmount.Text = abbreviateNumber:Abbreviate(rebirthsAmount).." Rebirths"
		--newButton.rebirthAmount.Text = rebirthsAmount.." Rebirths"
		newButton.cost.Text = abbreviateNumber:Abbreviate(rebirthsAmount*100*((1)+(rebirths.Value/10))).." Clicks"
		--newButton.cost.Text = rebirthsAmount*100*((1)+(rebirths.Value/10)).." Clicks"
		newButton.Parent = scrollingFrame
	end
end

rebirthButtons.Changed:Connect(function()
	local amount = rebirthButtons.Value
	for count = 1, amount do
		if not scrollingFrame:FindFirstChild(rebirthOptions[count]) then
			local newButton = template:Clone()
			local rebirthsAmount = rebirthOptions[count]
			newButton.Name = rebirthsAmount
			newButton.rebirthAmount.Text = abbreviateNumber:Abbreviate(rebirthsAmount).." Rebirths"
			newButton.cost.Text = abbreviateNumber:Abbreviate(rebirthsAmount*100*((1)+(rebirths.Value/10))).." Clicks"
			newButton.Parent = scrollingFrame
		end
	end
end)

rebirths.Changed:Connect(function()
	local rebirths = leaderstats:WaitForChild("Rebirths").Value
	for _, child in pairs(scrollingFrame:GetChildren()) do
		if child:IsA("TextButton") then
			local rebirthsAmount = tonumber(child.Name)
			child.cost.Text = abbreviateNumber:Abbreviate(rebirthsAmount*100*((1)+(rebirths/10))).." Clicks"
		end
	end
end)