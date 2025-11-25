local GameCoordinator = {}


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local shared = ReplicatedStorage.Shared
local GamePlaceManager = require(shared.Classes.GamePlaceManager)
local TeleportPad = require(shared.Classes.TeleportPad)
local GuessWhoConfig = require(shared.Configs.GuessWhoConfig)
local config = GuessWhoConfig

GameCoordinator.__index = GameCoordinator

function GameCoordinator.new()
    local self = setmetatable({
    games = {},
    placeManager = GamePlaceManager.new(config.TeleportPads),
    -- создать логику подключение падов...?
    
    },GameCoordinator)
    self.teleportPad = TeleportPad.new(config.TeleportPads.Pad, self.placeManager,1)   
    return self
end

function GameCoordinator:run()
    self.teleportPad:ConnectTouch()
end

return GameCoordinator 


