local Players = game:GetService("Players")
local player = Players.LocalPlayer
local worldMultiplier = player:WaitForChild("worldMultiplier")

local multiplierDisplay = script.Parent

worldMultiplier.Changed:Connect(function()
	local multiplier = worldMultiplier.Value
	multiplierDisplay.Text = "World Boost: X"..multiplier
end)