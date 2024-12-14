local dataStoreService = game:GetService("DataStoreService")
local clicksDataStore = dataStoreService:GetDataStore("Clicks1")
local rebirthsDataStore = dataStoreService:GetDataStore("Rebirths1")
local gemsDataStore = dataStoreService:GetDataStore("Gems1")
local rankDataStore = dataStoreService:GetDataStore("Rank")

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local clicks = Instance.new("IntValue", leaderstats)
	clicks.Name = "Clicks"
	clicks.Value = 0

	local rebirths = Instance.new("IntValue", leaderstats)
	rebirths.Name = "Rebirths"
	rebirths.Value = 0

	local gems = Instance.new("IntValue", leaderstats)
	gems.Name = "Gems"
	gems.Value = 0

	local rank = Instance.new("StringValue", leaderstats)
	rank.Name = "Rank"
	rank.Value = "Muertazo"

	local playerUserId = "player_"..player.UserId

	-- Loading Clicks Data
	local clicksData
	local success, errormessage = pcall(function()
		clicksData = clicksDataStore:GetAsync(playerUserId)
	end)

	if success and clicksData then
		clicks.Value = clicksData
	end

	-- Loading Rebirths Data
	local rebirthsData
	local success, errormessage = pcall(function()
		rebirthsData = rebirthsDataStore:GetAsync(playerUserId)
	end)

	if success and rebirthsData then
		rebirths.Value = rebirthsData
	end

	-- Loading Gems Data
	local gemsData
	local success, errormessage = pcall(function()
		gemsData = gemsDataStore:GetAsync(playerUserId)
	end)

	if success and gemsData then
		gems.Value = gemsData
	end

	-- Loading Rank
	local rankData
	local success, errormessage = pcall(function()
		rankData = rankDataStore:GetAsync(playerUserId)
	end)

	if success and rankData then
		rank.Value = rankData
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local playerUserId = "player_"..player.UserId

	-- Saving Clicks
	local clicksValue = player.leaderstats.Clicks.Value
	local success, errormessage = pcall(function()
		clicksDataStore:SetAsync(playerUserId, clicksValue)
	end)

	-- Saving Rebirths
	local rebirthsValue = player.leaderstats.Rebirths.Value
	local success, errormessage = pcall(function()
		rebirthsDataStore:SetAsync(playerUserId, rebirthsValue)
	end)

	-- Saving Gems
	local gemsValue = player.leaderstats.Gems.Value
	local success, errormessage = pcall(function()
		gemsDataStore:SetAsync(playerUserId, gemsValue)
	end)

	-- Saving Rank
	local rankValue = player.leaderstats.Rank.Value
	local success, errormessage = pcall(function()
		rankDataStore:SetAsync(playerUserId, rankValue)
	end)
end)

game:BindToClose(function()
	for _, player in pairs(game.Players:GetPlayers()) do
		local playerUserId = "player_"..player.UserId

		-- Saving Clicks
		local clicksValue = player.leaderstats.Clicks.Value
		local success, errormessage = pcall(function()
			clicksDataStore:SetAsync(playerUserId, clicksValue)
		end)

		-- Saving Rebirths
		local rebirthsValue = player.leaderstats.Rebirths.Value
		local success, errormessage = pcall(function()
			rebirthsDataStore:SetAsync(playerUserId, rebirthsValue)
		end)

		-- Saving Gems
		local gemsValue = player.leaderstats.Gems.Value
		local success, errormessage = pcall(function()
			gemsDataStore:SetAsync(playerUserId, gemsValue)
		end)

		-- Saving Rank
		local rankValue = player.leaderstats.Rank.Value
		local success, errormessage = pcall(function()
			rankDataStore:SetAsync(playerUserId, rankValue)
		end)
	end
end)