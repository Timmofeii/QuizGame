local GamePlace = {}
GamePlace.__index = GamePlace

function GamePlace.new()
    local self = setmetatable({    
        isBusy = false
    }, GamePlace)
    return self
end

function GamePlace:SetBusy(bool)
    self.isBusy = bool
end

return GamePlace
