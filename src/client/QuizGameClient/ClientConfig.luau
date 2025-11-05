local SharedConfig = require(game:GetService("ReplicatedStorage").Shared.Configs.QuizGameConfig)
-- Скопировать таблицу ссылок в инстанс
-- Типы для UI элементов
export type UIRefs = {
	timerText: TextLabel,
	questionText: TextLabel,
	questionFrame: Frame,
	scoreFrame: Frame,
	scoreText: TextLabel,
}
export type Events = {
	StartRound: RemoteEvent,
	EndRound: RemoteEvent,
	ShowQuestionStage: RemoteEvent,
}

local ClientConfig = {}

ClientConfig.__index = ClientConfig
function ClientConfig.new(player: Player)
	local self = setmetatable({
		player = player,
		gui = nil,
		Events = nil :: Events?,
		uiRefs = {} :: UIRefs,
		startRound = { "Ready, Steady", "GO!" },
	}, ClientConfig)
	return self
end
function ClientConfig:InitializeUI()
	self.gui = self.player.PlayerGui:WaitForChild("QuizGameGui")
	self.Events = SharedConfig.Events or {}
	self.ROUND_DURATION = SharedConfig.ROUND_DURATION
	self.TIME_START_TEXT = SharedConfig.ROUND_DURATION
	self.TIME_BEFORE_TIMER = SharedConfig.TIME_BEFORE_TIMER
	self.uiRefs = {
		timerText = self.gui.TimerFrame.TimerLabel,
		questionText = self.gui.QuestionFrame.QuestionText,
		-- ...
	}
end

-- getters for ui
function ClientConfig:GetUIRefs(): UIRefs
	return self.uiRefs
end

function ClientConfig:GetEvents(): Events
	return self.Events
end
