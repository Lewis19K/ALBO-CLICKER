local button = script.Parent
local rebirthMenu = button.Parent.RebirthMenu
local upgradesMenu = button.Parent.UpgradesMenu
local worldMultiplierDisplay = button.Parent.worldMultiplierDisplay

button.MouseButton1Up:Connect(function()
	if rebirthMenu.Visible == true then
		rebirthMenu.Visible = false
	elseif rebirthMenu.Visible == false then
		rebirthMenu.Visible = true
		upgradesMenu.Visible = false
		worldMultiplierDisplay.Visible = true
	end
end)