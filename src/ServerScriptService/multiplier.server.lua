game.Players.PlayerAdded:Connect(function(player)
	local clicksMultiplier = Instance.new("IntValue", player)
	clicksMultiplier.Name = "clicksMultiplier"

	local worldMultiplier = Instance.new("IntValue", player)
	worldMultiplier.Name = "worldMultiplier"
	worldMultiplier.Value = 1

	local leaderstats = player:WaitForChild("leaderstats")
	local upgrades = player:WaitForChild("Upgrades")

	local function updateClickMultiplier()
		clicksMultiplier.Value = 1 + leaderstats.Rebirths.Value * upgrades.ClicksMultiplier.Value
	end

	-- Inicializar el multiplicador correctamente
	updateClickMultiplier()

	-- Actualizar cuando cambian los rebirths o las mejoras
	leaderstats.Rebirths.Changed:Connect(updateClickMultiplier)
	upgrades.ClicksMultiplier.Changed:Connect(updateClickMultiplier)

	-- Manejar la velocidad de movimiento
	local character = player.Character or player.CharacterAdded:Wait()
	character.Humanoid.WalkSpeed = 16 + upgrades.WalkSpeed.Value

	upgrades.WalkSpeed.Changed:Connect(function()
		character.Humanoid.WalkSpeed = 16 + upgrades.WalkSpeed.Value
	end)
end)
