
local SeatManager = {}
SeatManager.__index = SeatManager
function SeatManager.new(seats)
    local self = setmetatable({}, SeatManager)
    self.seats = {
        seats = seats

    }
    return self
end

local function isSeatAvaiLable(seat)
        return not seat.isOccupied    
end

-- менеджер должен уссаживать игрока на свободное место и занимать его


-- для блока движения

-- local controls = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
--controls:Disable()

-- oncupied  seat
local function toSeat(character, seat)
    character:MoveTo(seat.Position)
    seat.isOccupied = true
end
-- free the seat
local function freeSeat(seat)
    seat.isOccupied = false
end

function SeatManager:GetFree