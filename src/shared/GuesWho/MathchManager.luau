local Mathch = require(script.Parent.Match)

local MatchManager = {}
MatchManager.__index = MatchManager
local lastMathcId = 1
function MatchManager.new()
    local self = setmetatable({
        matches = {}

    }, MatchManager)
    return self
end

-- Класс для контроля матчей, создание новых матчей, удаление завершенных матчей,
-- поиск матчей по id и передача матчу данных игроков и характеристик, проверка выхода игрока из матча
--• создаёт новый матч
-- • хранит список активных матчей
-- • ищет матч по matchId
-- • маршрутизирует выборы, отмены, выходы
-- • выдаёт автоинкрементный matchId

local MatchManager:AddMatch = function(self, players, CharacteristicManager)
    local match = Mathch.new(players, CharacteristicManager)
    self.matches[match.id] = match
    return match
end