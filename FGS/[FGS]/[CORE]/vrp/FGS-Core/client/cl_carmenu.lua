local doors = {
    [0] = "Front Left",
    [1] = "Front Right" ,
    [2] = "Back Left",
    [3] = "Back Right",
    [4] = "Hood" ,
    [5] = "Trunk",  
    [6] = "Back" , 
    [7] = "Back 2"  
}
local index = {
    door = 0
}

local cardoors = {}

for k, v in pairs (doors) do 
    cardoors[k] = v
end


local lockStatus = {
    [1] = false
}

local doorStatus = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false
}

local engineStatus = {
    [1] = true
}

RMenu.Add("vehicle", "main", RageUI.CreateMenu("", "~b~Vehicle menu", 1350, 50, "vehiclemenu", "vehiclemenu"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vehicle', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Toggle Engine" , "Turn Engine on or off", {},true, function(Hovered, Active, Selected)
                if (Selected) then
                    if engineStatus[1] then
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), false ,true, true)
                        engineStatus[1] = false
                        tvRP.notify("~r~Engine Off")
                    else
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), true ,true, true)
                        engineStatus[1] = true
                        tvRP.notify("~g~Engine On")
                    end 
                end
            end)

            RageUI.List("Toggle Door", cardoors, index.door, nil, {},true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if doorStatus[Index] then
                        SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), false),Index, false, false)
                        doorStatus[Index] = false
                    else
                        SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false),Index, false, false)
                        doorStatus[Index] = true
                    end 
                end
                if (Active) then 
                    index.door = Index;
                end
            end)
        end)
    end
end, 1)


RegisterCommand("VehicleMenu", function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then 
        RageUI.Visible(RMenu:Get("vehicle", "main"), true)
    end
end)


RegisterKeyMapping("VehicleMenu", "Vehicle Menu", "keyboard", "M")