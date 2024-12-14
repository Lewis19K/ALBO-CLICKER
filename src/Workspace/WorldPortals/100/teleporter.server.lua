local portal = script.Parent
local Players = game:GetService("Players")
local destination = portal.destination
local requiredRebirths = tonumber(portal.Name) -- Suponiendo que el nombre del portal es el número de rebirths requeridos

-- Debounce para evitar múltiples activaciones
local debounceTime = 3
local lastTouch = {}

portal.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)

		-- Verifica si el jugador ha tocado recientemente
		if lastTouch[player] and tick() - lastTouch[player] < debounceTime then
			return
		end

		-- Actualiza el tiempo del último toque
		lastTouch[player] = tick()

		-- Verificación de rebirths
		local leaderstats = player:FindFirstChild("leaderstats")
		local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths")

		if rebirths and rebirths.Value >= requiredRebirths then
			-- Teletransporta al jugador si tiene suficientes rebirths
			if player and destination then
				character.HumanoidRootPart.CFrame = destination.CFrame
			end
		else
			-- Opcional: mensaje al jugador indicando que no tiene suficientes rebirths
			player:SendNotification({
				Title = "Rebirths insuficientes",
				Text = "Necesitas " .. requiredRebirths .. " rebirths para usar este portal.",
				Duration = 3
			})
		end
	end
end)
