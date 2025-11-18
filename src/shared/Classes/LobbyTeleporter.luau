local LobbyTeleporter = {}


LobbyTeleporter.__index = LobbyTeleporter


function LobbyTeleporter.new(partFromTeleport:Part
    local self = setmetatable({
        partFrom = partFromTeleport,
       
        playersToTeleport = {}

    })
end


function LobbyTeleporter.teleportToLobby(players, partToTeleport)
    for _, player in ipairs(players) do
        TeleportSystem.Teleport(partToTeleport,player)
    end 
end



return LobbyTeleporter