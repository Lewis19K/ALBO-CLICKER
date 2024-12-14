local closeButton = script.Parent
local upgradesMenu = closeButton.Parent
local worldMultiplierDisplay = upgradesMenu.Parent:WaitForChild("worldMultiplierDisplay")

closeButton.MouseButton1Up:Connect(function()
	upgradesMenu.Visible = false
	if worldMultiplierDisplay.Visible == false then
		worldMultiplierDisplay.Visible = true
	end
end)