local LobbyTeleporter = {}
local TeleportSystem = require(game.ReplicatedStorage.shared.Modules.TeleportSystem)

LobbyTeleporter.__index = LobbyTeleporter

function LobbyTeleporter.new(partFromTeleport:Part,gamePlaces:table, countLobbyPeople:number)
    local self = setmetatable({
        partFrom = partFromTeleport,
        gamePlaces = gamePlaces,
        countLobbyPeople = countLobbyPeople,
        playersToTeleport = {}

    })
end



-- to thing есть смысл передавать не конкретное место 
--для телепорта а таблицу со свободными площадками для игр, и дальше игр распределять по свободным точкам 
-- подумать над тем чтобы игровые площадки сделать в виде столов и кресел, за которыми будут игры, после окончания игры, игрок будет просто вставать со свободного стула, а сами площадки будут в закрытых комнатах?
function LobbyTeleporter.teleportToLobby()
    for _, player in ipairs(self.players) do
        TeleportSystem.Teleport(self.partToTeleport,player)
    end 
    
end



return LobbyTeleporter