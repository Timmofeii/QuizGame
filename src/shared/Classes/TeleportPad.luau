local TeleportPad = {}

TeleportPad.__index = TeleportPad

function TeleportPad.new(model,PlaceManager)
    local self = setmetatable({model = model,
    players = {},
    maxPlayers = 2,
    timer = nil,
    PlaceManager = PlaceManager,


}, TeleportPad)

end

function TeleportPad:ConnctTouch()
    self.model:WaitForChild("Gate"):Touched(function(hit)
        local player = game.Players:GetPlayerFormCharacter(hit.Parent)
        if not player then return end 
        self:TryAddPlayer(player)
    end)
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
function TeleportPad:LaunchMatch()
    local places = {}
    for _,player in ipairs(self.players) do
        local place = self.placeManager:TakeFreePlace()
        