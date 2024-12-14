local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = ReplicatedStorage:WaitForChild("remoteEvents")
local buyUpgrade = remoteEvents:WaitForChild("buyUpgrade")

-- Función para calcular el precio de las mejoras con un crecimiento exponencial
local function calculateUpgradePrice(currentLevel)
	local basePrice = 100  -- Precio base de la mejora
	local multiplier = 1.5  -- Multiplicador exponencial
	return math.floor(basePrice * (multiplier ^ (currentLevel - 1)))
end

buyUpgrade.OnServerEvent:Connect(function(player, upgradeType)
	local leaderstats = player.leaderstats
	local upgrades = player.Upgrades
	local currentLevel = 0
	local price = 0

	-- Determinar el nivel actual y calcular el precio según el tipo de mejora
	if upgradeType == "rebirthButtons" then
		currentLevel = upgrades.RebirthButtons.Value + 1
		price = calculateUpgradePrice(currentLevel)

	elseif upgradeType == "clicksMultiplier" then
		currentLevel = upgrades.ClicksMultiplier.Value + 1
		price = calculateUpgradePrice(currentLevel)

	elseif upgradeType == "gemsMultiplier" then
		currentLevel = upgrades.GemsMultiplier.Value + 1
		price = calculateUpgradePrice(currentLevel)

	elseif upgradeType == "walkSpeed" then
		currentLevel = upgrades.WalkSpeed.Value + 1
		price = calculateUpgradePrice(currentLevel)
	end

	-- Verificar si el jugador tiene suficientes gems para comprar la mejora
	if leaderstats.Gems.Value >= price then
		leaderstats.Gems.Value = leaderstats.Gems.Value - price

		-- Incrementar el nivel de la mejora
		if upgradeType == "rebirthButtons" then
			upgrades.RebirthButtons.Value = currentLevel

		elseif upgradeType == "clicksMultiplier" then
			upgrades.ClicksMultiplier.Value = currentLevel

		elseif upgradeType == "gemsMultiplier" then
			upgrades.GemsMultiplier.Value = currentLevel

		elseif upgradeType == "walkSpeed" then
			upgrades.WalkSpeed.Value = currentLevel
		end
	else
		warn("Not enough gems to purchase upgrade: " .. upgradeType)
	end
end)
