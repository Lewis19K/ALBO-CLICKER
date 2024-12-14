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

local maxRebirthButtons = 24

local function calculateUpgradePrice(currentLevel)
	local basePrice = 100
	local multiplier = 1.5
	return math.floor(basePrice * (multiplier ^ (currentLevel - 1)))
end

moreRebirthButton.MouseButton1Up:Connect(function()
	local rebirthButtonsData = upgradesFile:WaitForChild("RebirthButtons")
	if rebirthButtonsData.Value < maxRebirthButtons then
		local calculatedPrice = calculateUpgradePrice(rebirthButtonsData.Value + 1)
		upgradeInfo.Text = "Purchasing this will give you more rebirth buttons!"
		upgradeName.Text = "Rebirth Buttons"
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	else
		upgradeInfo.Text = "Purchasing this will give you more rebirth buttons!"
		upgradeName.Text = "Rebirth Buttons"
		price.Text = "Max"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	end

	rebirthButtonsData.Changed:Connect(function()
		local calculatedPrice = calculateUpgradePrice(rebirthButtonsData.Value + 1)
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if rebirthButtonsData.Value >= maxRebirthButtons then
			price.Text = "Max"
		end
	end)
end)
