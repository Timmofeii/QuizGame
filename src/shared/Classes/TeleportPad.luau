local LobbyTeleporter = require(script.Parent.LobbyTeleporter)
local TeleportPad = {}

TeleportPad.__index = TeleportPad

function TeleportPad.new(padModel,PlaceManager, maxPlayers)
    local self = setmetatable({
    pad = padModel,
    gate = padModel.Gate,
    players = {},
    maxPlayers = maxPlayers,
    timer = nil,
    PlaceManager = PlaceManager,
    
    teleporter = LobbyTeleporter

    }, TeleportPad)
    self.frame = self.gate.billboardPart.billboardGui.Frame
    return self

end

function TeleportPad:ConnectTouch()
    print("Pad touched connect")
    self.gate:WaitForChild("GatePart").Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if not player then return end 
        self:TryAddPlayer(player)
    end)
end

function TeleportPad:UpdateUI()
    self.frame.players.Text = #self.players.."/"..self.maxPlayers

end

function TeleportPad:StartCount()
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

    end
end
--заменить логику на получение свободного места через плейсМенеджера
function TeleportPad:LaunchMatch()
    local place = self.pad.spawn
    --local place = self.PlaceManager:TakeFreePlace()
   self.teleporter:teleportToLobby(self.players,place)

end 

return TeleportPad
