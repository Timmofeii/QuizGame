local ClientConfig = require(script.Parent.ClientConfig)
local UIAnimation = require(script.Parent.Parent.UI.UIAnimation)

local EventManager = {}
EventManager.__index = EventManager

function EventManager.new(player: Player)
	local self = setmetatable({
		running = false
	}, EventManager)

	self.config = ClientConfig.new(player)
	self.config:InitializeUI()
	self.ui = self.config:GetUIRefs()
	self.Events = self.config:GetEvents()

	return self
end

function EventManager:Start()
	local events = self.Events
	if not events then
		warn("EventManager: no events in config")
		return
	end

	-- Обработчик показа вопроса и стартового текста
	events.ShowQuestionStage:Connect(function(question: string)
		self.ui.questionText.Text = question
		self.ui.questionFrame.Enabled = true

		-- Анимация появления вопроса
		local tweenUp = UIAnimation.Up(self.ui.questionFrame)
		tweenUp:Play()

		-- Показываем стартовый текст
		task.spawn(function()
			local time_freeze = self.config.TIME_BEFORE_TIMER / #self.config.startRound
			for _, replic in ipairs(self.config.startRound) do
				self.ui.timerText.Text = replic
				task.wait(time_freeze)
			end
			self.ui.timerText.Text = ""
		end)

		task.wait(self.TIME_BEFORE_TIMER)
		UIAnimation.Down(self.ui.questionFrame)
	end)

	-- Обработчик старта раунда и таймера
	events.StartRound:Connect(function(serverStartTime: number)
		self.running = true
		task.spawn(function()
			UIAnimation.Timer(self.ui.timerText, serverStartTime, self.TIME_BEFORE_TIMER, self.running)
		end)
	end)

	-- Обработчик завершения раунда
	events.EndRound:Connect(function()
		self.running = false
		self.ui.questionFrame.Enabled = false
	end)
end

return EventManager
