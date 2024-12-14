local buyButton = script.Parent
local infoHolder = buyButton.Parent

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = ReplicatedStorage:WaitForChild("remoteEvents")
local buyUpgrade = remoteEvents:WaitForChild("buyUpgrade")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local upgrades = player:WaitForChild("Upgrades")
local leaderstats = player:WaitForChild("leaderstats")

local maxRebirthButtons = 24
local maxClicksMultiplier = 10^12
local maxGemsMultiplier = 10^12
local maxWalkSpeed = 25

buyButton.MouseButton1Up:Connect(function()
	local upgradeName = infoHolder:WaitForChild("upgradeName")
	local gems = leaderstats.Gems.Value
	
	if upgradeName.Text == "Rebirth Buttons" then
		local rebirthButtons = upgrades:WaitForChild("RebirthButtons").Value
		if rebirthButtons < maxRebirthButtons then
			local price = ((10) + (rebirthButtons*10))
			if gems >= price then
				buyUpgrade:FireServer("rebirthButtons", price)
			end
		end
	elseif upgradeName.Text == "Clicks Multiplier" then
		local clicksMultiplier = upgrades:WaitForChild("ClicksMultiplier").Value
		if clicksMultiplier < maxClicksMultiplier then
			local price = ((10) + (clicksMultiplier*10))
			if gems >= price then
				buyUpgrade:FireServer("clicksMultiplier", price)
			end
		end
	elseif upgradeName.Text == "Gems Multiplier" then
		local gemsMultiplier = upgrades:WaitForChild("GemsMultiplier").Value
		if gemsMultiplier < maxGemsMultiplier then
			local price = ((10) + (gemsMultiplier*10))
			if gems >= price then
				buyUpgrade:FireServer("gemsMultiplier", price)
			end
		end
	elseif upgradeName.Text == "Walk Speed" then
		local walkSpeed = upgrades:WaitForChild("WalkSpeed").Value
		if walkSpeed < maxWalkSpeed then
			local price = ((10) + (walkSpeed*10))
			if gems >= price then
				buyUpgrade:FireServer("walkSpeed", price)
			end
		end
	end
end)