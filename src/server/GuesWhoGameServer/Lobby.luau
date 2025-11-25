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

function Lobby:IsFull()
	return self.Player1 ~= nil and self.Player2 ~= nil
end

function Lobby:GetTurnPlayer()
	if self.turn == 1 then
		return self.Player1
	else
		return self.Player2
	end
end

function Lobby:SwitchTurn()
	if self.turn == 1 then
		self.turn = 2
	else
		self.turn = 1
	end
end

return Lobby
