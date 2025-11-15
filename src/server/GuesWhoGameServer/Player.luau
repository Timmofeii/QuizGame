local Player = {}   
Player.__index = Player
function Player.new(playerId,idCharacter, listAwailableCharacters)
    local self = setmetatable({}, Player)

    self.playerId = playerId
    self.idCharacter = idCharacter
    self.listAwailableCharacters = listAwailableCharacters
    

    -- Инициализация других свойств игрока здесь

    return self
end