local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileManager = require(ServerScriptService.Server.ProfileManager)

Players.PlayerAdded:Connect(function(player)
	ProfileManager:Load(player)
	ProfileManager:SetupLeaderstats(player)
end)

Players.PlayerRemoving:Connect(function(player)
	ProfileManager:Release(player)
end)

