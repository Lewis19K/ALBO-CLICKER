local Players = game:GetService("Players")
local player = Players.LocalPlayer

local worlds = game:GetService("Workspace"):WaitForChild("WorldPortals")

local leaderstats = player:WaitForChild("leaderstats")
local rebirths = leaderstats:WaitForChild("Rebirths")

for i, portal in pairs(worlds:GetChildren()) do
	if portal:IsA("Part") then
		if tonumber(portal.Name) <= rebirths.Value then
			if portal:FindFirstChild("SurfaceGui") then
				portal.SurfaceGui:Destroy()
			end
		end
	end
end

rebirths.Changed:Connect(function()
	local rebirths = leaderstats:WaitForChild("Rebirths")
	for i, portal in pairs(worlds:GetChildren()) do
		if portal:IsA("Part") then
			if tonumber(portal.Name) <= rebirths.Value then
				if portal:FindFirstChild("SurfaceGui") then
					portal.SurfaceGui:Destroy()
				end
			end
		end
	end
end)