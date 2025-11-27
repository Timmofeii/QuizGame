local LobbyTeleporter = require(script.Parent.LobbyTeleporter)
local TeleportPad = {}
local TeleportSystem = require(script.Parent.Parent.Modules.TeleportSystem)
TeleportPad.__index = TeleportPad

function TeleportPad.new(padModel,PlaceManager, maxPlayers)
    local self = setmetatable({
    pad = padModel,
    gate = padModel.Gate,
    players = {},
    maxPlayers = maxPlayers,
    timer = 5,
    PlaceManager = PlaceManager,
    
    teleporter = LobbyTeleporter.new(TeleportSystem)

    }, TeleportPad)
    self.frame = self.gate.billboardPart.billboardGui.Frame
    return self

end

function TeleportPad:SetStartUI()
    self.frame.players.Text = #self.players.."/"..self.maxPlayers
    self.frame.Status.Text = "Waiting for players..."
    
end
function TeleportPad:ResetPad()
    self.players = {}
    self:SetStartUI()
end
-- настроить изменения стаитуса, создать стадии ожидания и запуска игры
function TeleportPad:ConnectTouch()
    print("Pad touched connect")
    self.gate:WaitForChild("GatePart").Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if not player then return end 
        self:TryAddPlayer(player)
    end)
end
-- проверить запуск таймера и перенос игрока в игровую местность 
function TeleportPad:UpdateUI()
    self.frame.players.Text = #self.players.."/"..self.maxPlayers

end

function TeleportPad:StartCountdown()

    local timer = self.timer
    local timeLabel = self.frame.time
    for i= timer,0,-1 do
        timeLabel.Text = "Time: "..i
        task.wait(1)
    end

end
function TeleportPad:TryAddPlayer(player)
    if table.find(self.players ,player) then return end 
    if #self.players >= self.maxPlayers  then return end 
    table.insert(self.players, player)
    self:UpdateUI()
    if #self.players == self.maxPlayers then 
        
        self:StartCountdown()
        self:LaunchMatch()
    end
end
--заменить логику на получение свободного места через плейсМенеджера
function TeleportPad:LaunchMatch()
    --local place = self.gate.spawn
    local place = self.PlaceManager:TakeFreePlace()
    
    self.teleporter:teleportToLobby(self.players,place.PrimaryPart.Position)
   --
    self:ResetPad()

end 

return TeleportPad