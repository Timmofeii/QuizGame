local PlacesManager = {}
PlacesManager.__index = PlacesManager

function PlacesManager.new(places)
    local self = setmetatable({
        places = places,
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

function PlacesManager:SetBusyPlace()
    local freePlace = self:GetFreePlace()
    if freePlace then
        table.insert(self.busyPlaces, freePlace)
        table.remove(self.freePlaces, 1)
    else
        warn("GamePlaceManager: no free places available")
    end
end

function PlacesManager:PlaceToFree(busyPlaceId)
    if busyPlaceId and self.busyPlaces[busyPlaceId] then
        table.insert(self.freePlaces, self.busyPlaces[busyPlaceId])
        table.remove(self.busyPlaces, busyPlaceId)
    end
end 

return PlacesManager