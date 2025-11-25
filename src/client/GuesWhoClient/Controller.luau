local CircularSelector = require(game.ReplicatedStorage.Shared.Classes.CircularSelector)


-- ToDo: добавить ивенты и функции для взаимодействия с сервером
-- скривать и закрывать кнопку конфирм между раундами
-- отображать прогресс бар между раундами убирая не нужные картинки
-- отображать победителя раунда и очки
-- отображать очки игроков в лидерборде
-- отображать победителя игры
-- анимации при победе и поражении
-- звуки при победе и поражении
-- анимации для прогресс бара
-- звуки для прогресс бара
-- анимации для кнопки конфирм
-- доработать модуль по UIAnimations для всех этих анимаций
-- настроить переключение характеристик и кнопку конфирм

local Controller = {}

Controller.__index = Controller 

function Controller.new(ClientConfig)
    local self = setmetatable({
        selector = CircularSelector.new(ClientConfig.Characterics), 
        config = ClientConfig, 
        _connections = {}
    }, Controller)
    return self

end


function Controller:connectButtons()
    local cfg = self.config
    local selector = self.selector 
    table.insert(self._connections, cfg.ToRightButton.MouseButton1Click:Connect(function()
       
       cfg.CharacteristicLabel.Text = selector:step(1).characteristic
    end))
    
    table.insert(self._connections, cfg.ToLeftButton.MouseButton1Click:Connect(function()
    cfg.CharacteristicLabel.Text = selector:step(-1).characteristic
   
    end))
    
end

function Controller:disable()
    for _, conn in ipairs(self._connections) do
        conn:Disconnect()
    end
    self._connections = {}
end

return Controller
