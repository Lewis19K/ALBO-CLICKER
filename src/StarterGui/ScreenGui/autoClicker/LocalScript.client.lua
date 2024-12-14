local button = script.Parent
local marketplaceservice = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("remoteEvents")
local clickEvent = remoteEvents:WaitForChild("click")

local running = false
local gamePassId = 884671363

button.MouseButton1Up:Connect(function()
	if running == false then
		button.BackgroundColor3 = Color3.new(0, 1, 0)
		if marketplaceservice:UserOwnsGamePassAsync(player.UserId, gamePassId) then
			running = true
			while wait(0.2) and running == true do
				clickEvent:FireServer(player)
			end
		else
			marketplaceservice:PromptGamePassPurchase(player, gamePassId)
		end
	elseif running == true then
		running = false
		button.BackgroundColor3 = Color3.new(1, 0, 0)
	end
end)