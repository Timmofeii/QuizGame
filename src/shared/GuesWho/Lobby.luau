local Lobby = {}
Lobby.__index = Lobby
local lobbyIdCounter = 0
local CircularSelector = require(game.ReplicatedStorage.Shared.Classes.CircularSelector)

-- связать с Places количество лобби зависит от количества одновременных игр
function Lobby.new(players)
	local self = setmetatable({
	circularSelector = CircularSelector.new(players),
	lobbyId = lobbyIdCounter,
	lobbyIdCounter = lobbyIdCounter + 1,
	players = players,
	turn = math.random(1,#players) --рандомный выбор первого игрока	
	}, Lobby)
	return self
end

-- Получить игрока, чей сейчас ход

function Lobby:GetTurnPlayer()
	return self.players[self.turn]
end

function Lobby:SwitchTurn()
	self.turn = self.circularSelector:step(1)
end

return Lobby
