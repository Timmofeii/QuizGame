local PlacesManager = {}
PlacesManager.__index = PlacesManager

function PlacesManager.new(places)
    local self = setmetatable({
        freePlaces = places,
        busyPlaces = {}
    }, PlacesManager)
    return self
end


-- Returns a free place without occupying it
function PlacesManager:GetFreePlace()
    if #self.freePlaces >= 1 then
        return self.freePlaces[1]
    else
        return nil
    end
end
-- Occupies a given place
function PlacesManager:OccupyPlace(place)
    if place.isBusy then return end
    place:SetBusy(true)
    table.remove(self.freePlaces, table.find(self.freePlaces, place))
    table.insert(self.busyPlaces, place)
end
-- Takes and occupies a free place
function PlacesManager:TakeFreePlace()
    local place = self:GetFreePlace()
    if place then
        self:OccupyPlace(place)
        return place
    end

    warn("GamePlaceManager: no free places available")
    return nil
end

-- Frees a given place
function PlacesManager:FreePlace(place)
    if not place.isBusy then return end
    place:SetBusy(false)
    table.remove(self.busyPlaces, table.find(self.busyPlaces, place))
    table.insert(self.freePlaces, place)
end

return PlacesManager