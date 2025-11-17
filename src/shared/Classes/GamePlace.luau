local GamePlace = {}
GamePlace.__index = GamePlace

function GamePlace.new(place:Part,isEmpsy:bool)
    local self = setmetatable({
        place = place,
        isEmpsy = isEmpsy
    })
end 

function GamePlace.get_isEmpty(self)
    return self.isEmpsy
end