
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
function SeatManager:toSeat(character, seat)
    character:MoveTo(seat.Position)
    
end
-- free the seat
function SeatManager:freeSeat(seat)
    seat.isOccupied = false
end