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

local maxGemsMultiplier = 10^12

local function calculateUpgradePrice(currentLevel)
	local basePrice = 100
	local multiplier = 1.5
	return math.floor(basePrice * (multiplier ^ (currentLevel - 1)))
end

moreRebirthButton.MouseButton1Up:Connect(function()
	local gemsMultiplierData = upgradesFile:WaitForChild("GemsMultiplier")
	if gemsMultiplierData.Value < maxGemsMultiplier then
		local calculatedPrice = calculateUpgradePrice(gemsMultiplierData.Value + 1)
		upgradeInfo.Text = "Purchasing this will give you a gems multiplier!"
		upgradeName.Text = "Gems Multiplier"
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	else
		upgradeInfo.Text = "Purchasing this will give you a gems multiplier!"
		upgradeName.Text = "Gems Multiplier"
		price.Text = "Max"
		if infoHolder.Visible == false then
			infoHolder.Visible = true
		end
	end

	gemsMultiplierData.Changed:Connect(function()
		local calculatedPrice = calculateUpgradePrice(gemsMultiplierData.Value + 1)
		price.Text = abbreviateNumber:Abbreviate(calculatedPrice) .. " Gems"
		if gemsMultiplierData.Value >= maxGemsMultiplier then
			price.Text = "Max"
		end
	end)
end)
