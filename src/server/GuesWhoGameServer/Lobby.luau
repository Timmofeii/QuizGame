local Lobby = {}
Lobby.__index = Lobby
function Lobby.new(lobbyId, Player1, Player2, state, turn)
	local self = setmetatable({}, Lobby)

	self.lobbyId = lobbyId
	self.Player1 = Player1
	self.Player2 = Player2
	self.state = state
	self.turn = turn

	-- Инициализация других свойств лобби здесь

	return self
end

function Lobby:isFull()
	return self.Player1 ~= nil and self.Player2 ~= nil
end

function Lobby:getTurnPlayer()
	if self.turn == 1 then
		return self.Player1
	else
		return self.Player2
	end
end

function Lobby:switchTurn()
	if self.turn == 1 then
		self.turn = 2
	else
		self.turn = 1
	end
end

return Lobby
