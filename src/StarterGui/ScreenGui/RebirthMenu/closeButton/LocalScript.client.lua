local closeButton = script.Parent
local rebirthMenu = closeButton.Parent

closeButton.MouseButton1Up:Connect(function()
	rebirthMenu.Visible = false
end)