function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, x + 3, y+ 3, z+1, 0.0, true , false)
    SetEntityAsMissionEntity(vehicle, true, true)
end

local cars = {
    --"spawncode",
}

RegisterCommand("spawnimport", function()
    local car = (cars[math.random(#cars)])
    spawnCar(car)
    Notify("~w~[~b~Met PD~w~] Import vehicle has been called: ~g~" .. car)
end)