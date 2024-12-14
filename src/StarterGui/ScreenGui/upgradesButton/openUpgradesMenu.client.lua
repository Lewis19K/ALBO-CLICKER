local button = script.Parent
local upgradesMenu = button.Parent.UpgradesMenu
local worldMultiplierDisplay = button.Parent.worldMultiplierDisplay
local rebirthMenu = button.Parent.RebirthMenu

button.MouseButton1Up:Connect(function()
	if upgradesMenu.Visible == true then
		upgradesMenu.Visible = false
		worldMultiplierDisplay.Visible = true
	elseif upgradesMenu.Visible == false then
		upgradesMenu.Visible = true
		worldMultiplierDisplay.Visible = false
		rebirthMenu.Visible = false
	end
end)