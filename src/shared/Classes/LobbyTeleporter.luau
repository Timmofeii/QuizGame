local LobbyTeleporter = {}


LobbyTeleporter.__index = LobbyTeleporter


function LobbyTeleporter.new(partFromTeleport:Part,TeleportSystem
    local self = setmetatable({
        partFrom = partFromTeleport,
        TeleportSystem = TeleportSystem,
        playersToTeleport = {}

    })
    return self
end


function LobbyTeleporter.teleportToLobby(players, partToTeleport)
    for _, player in ipairs(players) do
        self.TeleportSystem.Teleport(partToTeleport,player)
    end 
end



return LobbyTeleporter