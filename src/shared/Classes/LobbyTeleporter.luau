local LobbyTeleporter = {}


LobbyTeleporter.__index = LobbyTeleporter


function LobbyTeleporter.new(TeleportSystem)
    local self = setmetatable({
        TeleportSystem = TeleportSystem
    }, LobbyTeleporter)
    return self
end


function LobbyTeleporter:teleportToLobby(players, partToTeleport)
    for _, player in ipairs(players) do
        self.TeleportSystem.Teleport(partToTeleport,player)
    end 
end



return LobbyTeleporter