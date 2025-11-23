local Game = {}
Game.__index = Game
function Game.new(name, maxPlayers, GamePlaceManager, SeatManager, CharacteristicManager, TeleportPad)
    local self = setmetatable({
        name = name,
        maxPlayers = maxPlayers,
        players = {},
    }, Game)
    return self
end