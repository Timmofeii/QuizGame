local config = {}


-- === CONSTANTS ===
config.ROUND_DURATION = 10
config.TIME_START_TEXT = 3
config.TIME_BEFORE_TIMER = 3
-- === PATHS ===
local Events = game:GetService("ReplicatedStorage").Shared.RemoteEvents


-- === EVENTS ===
config.Events = {
    StartRound = Events.StartRoundEvent,
    EndRound = Events.EndRoundEvent,
    ShowQuestionStage = Events.ShowQuestionStage
}



return config

