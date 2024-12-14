local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = replicatedStorage:WaitForChild("remoteEvents")
local rebirthEvent = remoteEvents:WaitForChild("rebirth")
local ranksModule = require(replicatedStorage:WaitForChild("RanksModule"))

rebirthEvent.OnServerEvent:Connect(function(player, rebirthsAmount, gemsGiven)
    local leaderstats = player.leaderstats
    local Upgrades = player.Upgrades

    leaderstats.Clicks.Value = 0
    leaderstats.Rebirths.Value = leaderstats.Rebirths.Value + rebirthsAmount
    leaderstats.Gems.Value = leaderstats.Gems.Value + (gemsGiven * (Upgrades.GemsMultiplier.Value + 1))

    -- Actualizar el rango e imagen después del rebirth
    ranksModule.updateTitle(player, leaderstats.Clicks.Value)

    -- Actualizar la barra de progreso a 0%
	local progress, currentRank, nextRank = ranksModule.getProgress(leaderstats.Clicks.Value)
	local progressBar = player.PlayerGui.ScreenGui.rankProgressBar.progress
	progressBar.Size = UDim2.new(progress, 0, 1, 0)
	progressBar.Parent.progressText.Text = string.format("Progress: %d%% (%s to %s)", math.floor(progress * 100), currentRank or "No Rank", nextRank or "Max Rank")
end)
