local Lobby = {}
Lobby.__index = Lobby

function Lobby.new(maxPlayers)
    local self = setmetatable({
        players = {},
        maxPlayers = maxPlayers or 2
    }, Lobby)
    return self
end

function Lobby:AddPlayer(player)
    if #self.players < self.maxPlayers then
        table.insert(self.players, player)
    end
end

function Lobby:IsFull()
    return #self.players == self.maxPlayers
end

return Lobby
