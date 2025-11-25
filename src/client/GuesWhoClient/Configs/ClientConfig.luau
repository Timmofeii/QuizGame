local config = {}
local player = game.Players.LocalPlayer

config.GuesWhoGui = player:WaitForChild("PlayerGui"):WaitForChild("GuesWhoGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local sharedGuesWho = ReplicatedStorage.Shared.GuesWho
config.Characterics = require(sharedGuesWho.Characteristics)

local gameAssets = ReplicatedStorage.GameAssets
config.CharacterImagesFolder = gameAssets.ImageCharacters

config.CharactersImagesFrame = config.GuesWhoGui.CharactersImageFrame

config.SwitchFrame = config.GuesWhoGui.SwitchFrame
config.ButtonsFrame = config.SwitchFrame.ButtonsFrame
config.ToLeftButton = config.ButtonsFrame.ToLeftButton
config.ToRightButton = config.ButtonsFrame.ToRightButton
config.CharacteristicLabel = config.ButtonsFrame.CharacteristicLabel
config.ConfirmButton = config.SwitchFrame.ConfirmButton



return config