local config = {}


-- === CONSTANTS ===
config.ROUND_DURATION = 10
config.TIME_START_TEXT = 3
config.TIME_BEFORE_TIMER = 3
-- === PATHS ===
local EventsShared = game:GetService("ReplicatedStorage").Shared.RemoteEvents


-- === EVENTS ===
config.Events = {
    StartRound = EventsShared.StartRoundEvent,
    EndRound = EventsShared.EndRoundEvent,
    ShowQuestionStage = EventsShared.ShowQuestionStage
}



return config

