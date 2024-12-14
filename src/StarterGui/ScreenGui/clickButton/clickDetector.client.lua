local clicksButton = script.Parent
local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("remoteEvents")
local clickEvent = remoteEvents:WaitForChild("click")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

function debounce(func)
	local isRunning = false
	return function()
		if not isRunning then
			isRunning = true
			wait(0.05)
			func()
			isRunning = false
		end
	end
end

clicksButton.MouseButton1Up:Connect(debounce(function()
	clickEvent:FireServer(player)
end))