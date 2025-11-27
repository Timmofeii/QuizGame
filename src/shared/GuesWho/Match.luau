local Lobby = require(script.Parent.Lobby)
local EventManager = require(script.Parent.EventManager)
local PlayersCharaterController = require(script.Parent.PlayersCharaterController)
local Match = {}
Match.__index = Match
function Match.new( players,CharacteristicManager )
    local self = setmetatable({
       
        players = players,
        choices = {},
        lobby = Lobby.new(players),
        eventManager = EventManager.new(),
        characteristicManager = CharacteristicManager,
    }, Match)
    
    return self
end

-- запуск игры, оповещение игроков через ивент для открытия UI игры и передачи начальных данных для выбора персонажа
-- ожидание от игроков выбора персондажей через ивент 20 секунд, таймер на сервере
-- после получения выборов от обоих игроков или истечения таймера, переход к следующему этапу
-- привязка персонажа к игроку 
-- оповещение игроков через ивент о начале игры, передача данных о персонажах соперника без раскрытия выбранного персонажа
-- начало игрового цикла, оповещение текущего игрока о его ходе через ивент
-- ожидание выбора текущего игрока через ивент, таймер на сервере 30 секунд
-- изменение хода, оповещение следующего игрока через ивент
-- проверка на победу после каждого хода, если победа достигнута, оповещение обоих игроков через ивент о результате игры
--  на этом уровне только оповещаем игрока о выходе опонента!!! отдельно ловить ивень о выходе игрока из игры, завершение матча и оповещение второго игрока через ивент о выходе соперника

--• хранит своих игроков
-- • хранит их выборы
-- • следит, готовы ли оба
-- • запускает раунд
-- • завершается

function Mathch:StatGame()
    self.eventManager:FireStartGameEvent(self.players, "name imagers ")-- при наличие картинок передавать их сюда
    self.EventManager:ConfirmCharacer(function(plr, mathcId, character)
        self.choices[plr] = {mathcId = mathcId, character = character}
        -- проверить если оба игрока выбрали персонажей или истек таймер
        if #self.choices >= #self.players then
            self:BeginGameplay()
        end
    end)
end

return Match
