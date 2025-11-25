local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local GameCoordinator = require(script.GuesWhoGameServer.GameCoordinator)
local ProfileManager = require(ServerScriptService.Server.ProfileManager)
local ProfileService = require(ServerScriptService.ServerPackages.ProfileService)
Players.PlayerAdded:Connect(function(player)
	ProfileManager:Load(player)
	ProfileManager:SetupLeaderstats(player)
end)

Players.PlayerRemoving:Connect(function(player)
	ProfileManager:Release(player)
end)

local guesWhoCoordinator = GameCoordinator.new()
guesWhoCoordinator:run()
