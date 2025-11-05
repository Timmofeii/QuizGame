local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts
local EventManager = require(StarterPlayerScripts.Client.QuizGameClient.EventManager)

-- Получаем локального игрока
local player = game.Players.LocalPlayer
if not player then
	player = game.Players.PlayerAdded:Wait()
end

-- Создаём менеджер событий для игрока
local eventManager = EventManager.new(player)

-- Запускаем обработку событий
eventManager:Start()
