local config = {}
config.GuesWhoGui = game:GetService("StarterGui"):WaitForChild("GuesWhoGui")
local GuesWhoGameAssets = game:GetService("ReplicatedStorage"):WaitForChild("GuesWhoGameAssets")
config.CharacterImagesFolder = GuesWhoGameAssets:WaitForChild("CharacterImages")

config.SwitchFrame = config.GuesWhoGui.SwitchFrame
config.ButtonsFrame = config.SwitchFrame.ButtonsFrame
config.ToLeftButton = config.ButtonsFrame.ToLeftButton
config.ToRightButton = config.ButtonsFrame.ToRightButton
config.CharacteristicLabel = config.ButtonsFrame.CharacteristicLabel

config.ConfirmButton = config.SwitchFrame.ConfirmButton

config.CharactersImagesFrame = config.GuesWhoGui.CharactersImagesFrame

return config