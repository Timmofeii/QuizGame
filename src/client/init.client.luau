local Client = script.Parent.Client
local ClientConfig = require(Client.GuesWhoClient.Configs.ClientConfig)
local GuesWhoController = require(Client.GuesWhoClient.Controller)
local controller = GuesWhoController.new(ClientConfig)
controller:connectButtons()
-- при завершение игры controller:disable()

