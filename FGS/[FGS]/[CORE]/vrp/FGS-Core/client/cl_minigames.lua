function SpawnWithBMX()
    local ped = GetPlayerPed(-1)
    SetEntityCoords(ped, -753.93408203125,5578.1064453125,36.709693908691)
    SpawnVehicle("bmx")
end


Citizen.CreateThread(function() 
    while true do
        local cfgcoords = vector3(450.91192626953,5574.5390625,796.64593505859)
        if isInArea(cfgcoords, 100.0) then 
            DrawMarker(27, vector3(450.91192626953,5574.5390625,796.64593505859-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
        end
        if isInArea(cfgcoords, 1.4) then 
            alert('Press ~INPUT_CONTEXT~ to enter the start the bmx trail')
            if IsControlJustPressed(0, 51) then 
                SpawnWithBMX()
            end
        end
        Citizen.Wait(0)
    end
end)