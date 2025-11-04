

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local QuizGameShared = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("QuizGame")

local QuizGameConfig = require(QuizGameShared.Configs.QuizGameConfig)

local ServerConfig = {}
ServerConfig.__index = ServerConfig

function ServerConfig.new(model)
    local self = setmetatable({}, ServerConfig)

    self.Model = model
    self.Config = QuizGameConfig

    -- Модельные зависимости
    self.ChoicePlatform = model:WaitForChild("ChoicePlatform")
    self.LockOpenWall = model.QuizPlace.LockOpenWall
    self.ScreenPart = model:WaitForChild("ScreenPart")
    self.GameFrame = self.ScreenPart.SurfaceGui.GameFrame
    self.QuestionsFrame = self.GameFrame:WaitForChild("QuestionsFrame")

    local Teleports = model:WaitForChild("Teleports")
    self.TeleportToQuizPlace = Teleports:WaitForChild("TeleportToQuizPlace")
    self.TeleportToMainPlace = Teleports:WaitForChild("TeleportToMainPlace")

    self.ClearVariant = {'-', '-', '-', '-'}

    -- Модули
    local Modules = QuizGameShared.Modules
    self.Modules = {
        QuizQuestions = require(Modules.QuizQuestions),
        RotateCube = require(Modules.RotateCube),
        TeleportSystem = require(Modules.TeleportSystem),
        LKit = require(Modules.LKit)
    }

    -- Быстрые ссылки
    self.choicePlatformParts = self.ChoicePlatform:GetChildren()
    self.lockOpenWallParts = self.LockOpenWall:GetChildren()

    return self
end

return ServerConfig