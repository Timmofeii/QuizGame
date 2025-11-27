local Manager = {}
Manager.__index = Manager
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GuesWhoGameEvents = ReplicatedStorage:WaitForChild("GuesWhoGameEvents")
local FromServerEvent = GuesWhoGameEvents.FromServer
local ToServerEvent = GuesWhoGameEvents.ToServer
-- добавить ивенты для эффектов UI и звуков

function Manager.new()
    local self = setmetatable({
        StartGameEvent = FromServerEvent.StartGameEvent,
        UpdateGameStateEvent = FromServerEvent.UpdateGameStateEvent,
        PlayerTurnEvent = FromServerEvent.PlayerTurnEvent,
        GameOverEvent = FromServerEvent.GameOverEvent,
        ConfirmEvent = ToServerEvent.ConfirmEvent,
        PlayerRemovedEvent = ToServerEvent.PlayerRemovedEvent
    }, Manager)
    return self
end

local function fireClients(event, players, ...)
    for _, player in pairs(players) do
        event:FireClient(player, ...)
    end
end
function Manager:FireStartGameEvent(players, gameData)
    fireClients( self.StartGameEvent, players, gameData)
end

function  Manager:UpdateEvent(players,args)
    fireClients(self.UpdateGameStateEvent, players, args)
end

-- отправляет ивент для разблокировки хода игрока(кнопки confirm)
function Manager:FirePlayerTurnEvent(player, turnData)
    self.PlayerTurnEvent:FireClient(player, turnData)
end

-- отправляем ивент с результатами игры обоим игрокам, от результата будет зависеть UI победы или поражения
function Manager:FireGameOverEvent(players, resultData)
    fireClients(self.GameOverEvent, players, resultData)
end

function Manager:ConfirmCharacer(callback)
    self.ConfirmCharacer.OnServerEvent:Connect(function(plr,mathcId character)
        callback(plr, mathcId, character)
    end)
end
-- подумать над тем чтобы передавать игроку ид лобби и по нему проверять состояние игры для быстрого поиска лобби
function  Manager:ConfirmEvent()
    return self.ConfirmEvent.OnServerEvent:Connect(function(plr,  choice))
end
-- в обработчике удаляем игрока из лобби и уведомляем второго игрока о выходе соперника + надо ловить всех игроков которые выходят из игры и удалять их из лобби
function Manager:PlayerRemovedEvent(player, lobbyId)
    return self.PlayerRemovedEvent.OnServerEvent:Connect(function(plr, lobbyId))
end
return Manager
