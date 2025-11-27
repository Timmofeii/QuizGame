local PlacesManager = {}
PlacesManager.__index = PlacesManager

function PlacesManager.new(places)
    local self = setmetatable({
        places = places,
        states = {
            free = {},
            busy = {},
            reserved = {}
        }   
    }, PlacesManager)
    for _, place in ipairs(places) do
        table.insert(self.states.free, place)
    end
    return self
end


function PlacesManager:switchPlace(place, newState)
    local oldState = place.state
    if oldState == newState then return end
    -- remove from old state
    local idx = table.find(self.states[oldState], place)
    if idx then
        table.remove(self.states[oldState], idx)
    end
    -- add to new state
    table.insert(self.states[newState], place)
    place.state = newState
end

-- TODO: получение игровой зоны и расширение, или сделать количество площадок под игроков
function PlacesManager:GetFreePlace()
   return self.states.free[1] 
end
-- function get free place, occypy and return place
function PlacesManager:TakeFreePlace()
    local place = self:GetFreePlace()
    if place then
        self:switchPlace(place, "busy")
        return place
    else 
        warm("GamePlaceManager: no free places available")
        return nil
    end

    warn("GamePlaceManager: no free places available")
    return nil
end



function PlacesManager:FreePlace(place)
    if not place.state ~= 'busy' then return end
    self:switchPlace(place, "free")
end

return PlacesManager