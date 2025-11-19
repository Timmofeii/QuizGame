local GamePlace = {}
GamePlace.__index = GamePlace

function GamePlace.new(part)
    local self = setmetatable({
        part = part,
        isBusy = false
    }, GamePlace)
    return self
end

function GamePlace:SetBusy(bool)
    self.isBusy = bool
end

return GamePlace
