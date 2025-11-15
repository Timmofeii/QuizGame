local ClientConfig = require(script.Parent.ClientConfig)
local UIAnimation = require(script.Parent.Parent.UI.UIAnimation)

local EventManager = {}
EventManager.__index = EventManager

function EventManager.new(player: Player)
	local self = setmetatable({
		running = false,
	}, EventManager)

	self.config = ClientConfig.new(player)
	self.config:InitializeUI()
	self.ui = self.config:GetUIRefs()

	return self
end

function EventManager:Start()
	local events = self.config:GetEvents()
	if not events then
		warn("EventManager: GetEvents returned nil")
		return
	end

	-- ShowQuestionStage
	do
		local ev = events.ShowQuestionStage
		if ev and type(ev.IsA) == "function" and ev:IsA("RemoteEvent") then
			ev.OnClientEvent:Connect(function(question)
				self.ui.questionText.Text = question
				self.ui.questionFrame.Enabled = true

				local tweenUp = UIAnimation.Up(self.ui.questionFrame)
				tweenUp:Play()

				task.spawn(function()
					local time_freeze = self.config.TIME_BEFORE_TIMER / #self.config.startRound
					for _, text in ipairs(self.config.startRound) do
						self.ui.timerText.Text = text
						task.wait(time_freeze)
					end
					self.ui.timerText.Text = ""
				end)

				task.wait(self.config.TIME_BEFORE_TIMER)
				UIAnimation.Down(self.ui.questionFrame)
			end)
		else
			warn("EventManager: ShowQuestionStage missing or not a RemoteEvent")
		end
	end

	-- StartRound
	do
		local ev = events.StartRound
		if ev and type(ev.IsA) == "function" and ev:IsA("RemoteEvent") then
			ev.OnClientEvent:Connect(function(serverStartTime)
				self.running = true
				task.spawn(function()
					UIAnimation.Timer(self.ui.timerText, serverStartTime, self.config.ROUND_DURATION, self.running)
				end)
			end)
		else
			warn("EventManager: StartRound missing or not a RemoteEvent")
		end
	end

	-- EndRound
	do
		local ev = events.EndRound
		if ev and type(ev.IsA) == "function" and ev:IsA("RemoteEvent") then
			ev.OnClientEvent:Connect(function()
				self.running = false
				self.ui.questionFrame.Enabled = false
			end)
		else
			warn("EventManager: EndRound missing or not a RemoteEvent")
		end
	end
end

return EventManager
