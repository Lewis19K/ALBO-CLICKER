local moreRebirthButton = script.Parent
local infoHolder = moreRebirthButton.Parent.Parent.infoHolder
local price = infoHolder.Cost.price
local upgradeInfo = infoHolder.upgradeInfo
local upgradeName = infoHolder.upgradeName

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local upgradesFile = player:WaitForChild("Upgrades")

local replicatedStorage = game:GetService("ReplicatedStorage")
local abbreviateNumber = require(replicatedStorage:WaitForChild("abbreviateNumber"))

local maxWalkSpeed = 25

local function calculateUpgradePrice(currentLevel)
	local basePrice = 100
	local multiplier = 1.5
	return math.floor(basePrice * (multiplier ^ (currentLevel - 1)))
end

moreRebirthButton.MouseButton1Up:Connect(function()
	local walkSpeedData = upgradesFile:WaitForChild("WalkSpeed")
	if walkSpeedData.Value < maxWalkSpeed then
		local calculatedPrice = calculateUpgradePrice(walkSpeedData.Value + 1)
		upgradeInfo.Text = "Purchasing this will give you extra walk speed!"
		upgradeName.Text = "Walk Speed"
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	else
		upgradeInfo.Text = "Purchasing this will give you extra walk speed!"
		upgradeName.Text = "Walk Speed"
		price.Text = "Max"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	end

	walkSpeedData.Changed:Connect(function()
		local calculatedPrice = calculateUpgradePrice(walkSpeedData.Value + 1)
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if walkSpeedData.Value >= maxWalkSpeed then
			price.Text = "Max"
		end
	end)
end)
