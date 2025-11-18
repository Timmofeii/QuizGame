local PlacesManager = {}
PlacesManager.__index = PlacesManager

function PlacesManager.new(places)
    local self = setmetatable({
        freePlaces = places,
        busyPlaces = {}
    }, PlacesManager)
    return self
end


-- TODO: получение игровой зоны и расширение, или сделать количество площадок под игроков
function PlacesManager:GetFreePlace()
    if #self.freePlaces >= 1 then
        return self.freePlaces[1]
    else
        return nil
    end
end

function PlacesManager:TakeFreePlace()
    local place = self:GetFreePlace()
    if place then
        self:OccupyPlace(place)
        return place
    end

    warn("GamePlaceManager: no free places available")
    return nil
end


function PlacesManager:FreePlace(place)
    if not place.isBusy then return end
    place.isBusy = false
    table.remove(self.busyPlaces, table.find(self.busyPlaces, place))
    table.insert(self.freePlaces, place)
end

return PlacesManager