local Players = game:GetService("Players")

-- Conexión de eventos Touched para detectar cuando un jugador entra o sale de una región.
for _, region in pairs(workspace.worldRegions:GetChildren()) do
	region.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			local worldMultiplier = player:FindFirstChild("worldMultiplier")
			if worldMultiplier then
				worldMultiplier.Value = tonumber(region.Name)
			end
		end
	end)
end
