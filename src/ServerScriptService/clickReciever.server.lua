local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("remoteEvents")
local clickEvent = remoteEvents:WaitForChild("click")
local ranksModule = require(replicatedStorage:WaitForChild("RanksModule"))

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local leaderstats = player:WaitForChild("leaderstats")
		local clicks = leaderstats and leaderstats:FindFirstChild("Clicks")

		if clicks and clicks.Value > 0 then
			ranksModule.updateTitle(player, clicks.Value)

			-- Actualizar la barra de progreso
			local progress, currentRank, nextRank = ranksModule.getProgress(clicks.Value)
			local progressBar = player.PlayerGui.ScreenGui.rankProgressBar.progress
			progressBar.Size = UDim2.new(progress, 0, 1, 0)
			progressBar.Parent.progressText.Text = string.format("Progress: %d%% (%s to %s)", math.floor(progress * 100), currentRank, nextRank)
		end
	end)
end)

clickEvent.OnServerEvent:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local multiplier = player:FindFirstChild("clicksMultiplier")
	local worldMultiplier = player:FindFirstChild("worldMultiplier")
	local clicks = leaderstats and leaderstats:FindFirstChild("Clicks")

	if clicks and multiplier and worldMultiplier then
		local highestRankThreshold = ranksModule.ranks[#ranksModule.ranks].threshold

		-- Solo permite sumar clicks si no ha alcanzado el rango máximo
		if clicks.Value < highestRankThreshold then
			clicks.Value = math.min(clicks.Value + (1 * multiplier.Value) * worldMultiplier.Value, highestRankThreshold)

			-- Usar la función del módulo para actualizar el rango
			ranksModule.updateTitle(player, clicks.Value)

			-- Actualizar la barra de progreso
			local progress, currentRank, nextRank = ranksModule.getProgress(clicks.Value)
			local progressBar = player.PlayerGui.ScreenGui.rankProgressBar.progress
			progressBar.Size = UDim2.new(progress, 0, 1, 0)
			progressBar.Parent.progressText.Text = string.format("Progress: %d%% (%s to %s)", math.floor(progress * 100), currentRank, nextRank)
		else
			print("Max rank reached, no more clicks can be added.")
		end
	else
		print("Error: Missing leaderstats or multipliers for player", player.Name)
	end
end)
