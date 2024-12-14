local ranksModule = {}

ranksModule.imagesIds = {
	["javierToledo"] = "rbxassetid://18868172308",
	["ramiroGonzales"] = "rbxassetid://18854374797",
	["pauloGarces"] = "rbxassetid://18868215227",
	["brunoGutierrez"] = "rbxassetid://18856238586",
	["conoGil"] = "rbxassetid://18854339873",
	["vicentePizarro"] = "rbxassetid://18963089390",
	["gilPrime"] = "rbxassetid://18868222021",
	["carlosPalacios"] = "rbxassetid://18854344978",
	["carlosPalaciosPrime"] = "rbxassetid://18868227793",
	["jaimeValdes"] = "rbxassetid://18963077970",
	["aturoVidal"] = "rbxassetid://18854342307",
	["matiFernandez"] = "rbxassetid://18868208423",
	["matiPrime"] = "rbxassetid://18854352363",
	["condorRojas"] = "rbxassetid://18963060106",
	["jaimePizarro"] = "rbxassetid://18963069115",
	["lizardoGarrido"] = "rbxassetid://18963087148",
	["estebanParedes"] = "rbxassetid://18868167058",
	["estebanParedesPrime"] = "rbxassetid://18868239001",
	["barticciotto"] = "rbxassetid://18963020915",
	["caszely"] = "rbxassetid://18854349031",
	["chamacoValdes"] = "rbxassetid://18963028344"
}

ranksModule.ranks = {
	{threshold = 10^0, image = ranksModule.imagesIds["pauloGarces"], title = "XD"},
	{threshold = 10^1, image = ranksModule.imagesIds["ramiroGonzales"], title = "Muertazo"},
	{threshold = 10^2, image = ranksModule.imagesIds["brunoGutierrez"], title = "Verde"},
	{threshold = 10^3, image = ranksModule.imagesIds["conoGil"], title = "Cono Gil"},
	{threshold = 10^4, image = ranksModule.imagesIds["gilPrime"], title = "Gil (P)"},
	{threshold = 10^5, image = ranksModule.imagesIds["vicentePizarro"], title = "Promesa"},
	{threshold = 10^6, image = ranksModule.imagesIds["carlosPalacios"], title = "La joya"},
	{threshold = 10^7, image = ranksModule.imagesIds["carlosPalaciosPrime"], title = "La joya (P)"},
	{threshold = 10^8, image = ranksModule.imagesIds["jaimeValdes"], title = "Pajarito"},
	{threshold = 10^9, image = ranksModule.imagesIds["aturoVidal"], title = "King"},
	{threshold = 10^10, image = ranksModule.imagesIds["matiFernandez"], title = "Matigol"},
	{threshold = 10^11, image = ranksModule.imagesIds["matiPrime"], title = "Matigol (P)"},
	{threshold = 10^12, image = ranksModule.imagesIds["condorRojas"], title = "Condor Rojas"},
	{threshold = 10^13, image = ranksModule.imagesIds["jaimePizarro"], title = "Kaiser"},
	{threshold = 10^14, image = ranksModule.imagesIds["lizardoGarrido"], title = "Referente"},
	{threshold = 10^15, image = ranksModule.imagesIds["estebanParedes"], title = "Paredes"},
	{threshold = 10^16, image = ranksModule.imagesIds["barticciotto"], title = "Idolo"},
	{threshold = 10^17, image = ranksModule.imagesIds["caszely"], title = "Leyenda"},
	{threshold = 10^18, image = ranksModule.imagesIds["chamacoValdes"], title = "Maxima leyenda"}
}

function ranksModule.updateTitle(player, clicks)
	local character = player.Character or player.CharacterAdded:Wait()
	local head = character:WaitForChild("Head")

	-- Obtener el rango más bajo como predeterminado
	local lowestRank = ranksModule.ranks[1]

	local highestRank = lowestRank  -- Asignar el rango más bajo por defecto
	for _, rank in ipairs(ranksModule.ranks) do
		if clicks >= rank.threshold then
			highestRank = rank
		end
	end

	-- Mostrar el rango solo si hay clics o si es el rango más bajo
	if highestRank and (clicks > 0 or highestRank == lowestRank) then
		if character:FindFirstChild("TitleGui") then
			character.TitleGui:Destroy()
		end

		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "TitleGui"
		billboardGui.Adornee = head
		billboardGui.Size = UDim2.new(4, 0, 2, 0)
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.Parent = character

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 0.5, 0)
		textLabel.Text = highestRank.title
		textLabel.TextScaled = true
		textLabel.BackgroundTransparency = 1
		textLabel.Parent = billboardGui

		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
		imageLabel.Position = UDim2.new(0.25, 0, 0.5, 0)
		imageLabel.Image = highestRank.image
		imageLabel.BackgroundTransparency = 1
		imageLabel.SizeConstraint = Enum.SizeConstraint.RelativeXX
		imageLabel.Parent = billboardGui

		player.leaderstats.Rank.Value = highestRank.title
	else
		warn("Error: No valid rank found for clicks", clicks)
	end
end

function ranksModule.getProgress(clicks)
	local currentRank = { title = "No Rank" }  -- Valor por defecto para evitar errores
	local nextRank = nil

	for i, rank in ipairs(ranksModule.ranks) do
		if clicks < rank.threshold then
			nextRank = rank
			break
		end
		currentRank = rank
	end

	if nextRank then
		local progress = (clicks - currentRank.threshold) / (nextRank.threshold - currentRank.threshold)
		return progress, currentRank.title, nextRank.title
	else
		return 1, currentRank.title, "Max Rank"  -- 1 significa que se ha alcanzado el último rango
	end
end


return ranksModule
