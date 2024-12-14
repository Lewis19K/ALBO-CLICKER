local dataStoreService = game:GetService("DataStoreService")
local upgradesDataStore = dataStoreService:GetDataStore("UpgradesData")

game.Players.PlayerAdded:Connect(function(player)
	local upgradesFolder = Instance.new("Folder", player)
	upgradesFolder.Name = "Upgrades"
	
	local rebirthButtons = Instance.new("IntValue", upgradesFolder)
	rebirthButtons.Name = "RebirthButtons"
	rebirthButtons.Value = 1
	
	local clicksMultiplier = Instance.new("IntValue", upgradesFolder)
	clicksMultiplier.Name = "ClicksMultiplier"
	clicksMultiplier.Value = 0
	
	local gemsMultiplier = Instance.new("IntValue", upgradesFolder)
	gemsMultiplier.Name = "GemsMultiplier"
	gemsMultiplier.Value = 0
	
	local walkSpeed = Instance.new("IntValue", upgradesFolder)
	walkSpeed.Name = "WalkSpeed"
	walkSpeed.Value = 0
	
	
	local upgradesData = upgradesDataStore:GetAsync(player.UserId)
	if upgradesData ~= nil then
		rebirthButtons.Value = upgradesData[1]
		clicksMultiplier.Value = upgradesData[2]
		gemsMultiplier.Value = upgradesData[3]
		walkSpeed.Value = upgradesData[4]
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local upgrades = {}
	for _, child in pairs(player.Upgrades:GetChildren()) do
		table.insert(upgrades, child.Value)
	end
	
	pcall(function()
		upgradesDataStore:SetAsync(player.UserId, upgrades)
	end)
end)

game:BindToClose(function()
	for _, Player in pairs(game.Players:GetPlayers()) do
		local upgrades = {}
		for _, child in pairs(Player.Upgrades:GetChildren()) do
			table.insert(upgrades, child.Value)
		end

		pcall(function()
			upgradesDataStore:SetAsync(Player.UserId, upgrades)
		end)
	end
end)