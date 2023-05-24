local cfg = module("FGS-CARS", "cfg/cfg_garage")
local vehcategories = cfg.garage_types
local garage_type = "car";
local selected_category = nil;
local Hovered_Vehicles = nil;
local VehiclesFetchedTable = {};
local Table_Type = nil;
local RentedVeh = false;
local SelectedCar = {spawncode = nil, name = nil}
local veh = nil 
local cantload = {}
local vehname = nil 
RMenu.Add('vRPDealer', 'main', RageUI.CreateMenu("", "~b~Simeons Dealership",1250,100, "simeons", "simeons"))
RMenu.Add('vRPDealer', 'buy_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPDealer", "main")))
RMenu.Add('vRPDealer', 'buy_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPDealer", "buy_vehicles")))
RMenu.Add('vRPDealer', 'buy_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPDealer", "buy_vehicles_submenu")))

function DeleteCar(veh)
    if veh then 
        if DoesEntityExist(veh) then 
            Hovered_Vehicles = nil
            vehname = nil
            DeleteEntity(veh)
            veh = nil
        end
    end
end
local EnableBuyVehicles2 = true
-- Did you know you can toggle most things in vRP within the vrp/sharedcfg/options.lua?
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPDealer', 'main')) then
    
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            if EnableBuyVehicles2 then
                RageUI.Button("Buy Vehicles", "", {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        if Table_Type == nil or Table_Type then 
                            FGS_server_callback('vRP:FetchCars', false, garage_type)
                            Table_Type = false;
                        end
                    end
                end, RMenu:Get("vRPDealer", "buy_vehicles"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPDealer', 'buy_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPDealer", "buy_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPDealer', 'buy_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1], "", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('vRPDealer', 'buy_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1] .. ' Price: $' .. v[2])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("vRPDealer", "buy_vehicles_submenu_manage")) 
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPDealer', 'buy_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Buy Vehicle", "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('vRP:BuyVehicle', SelectedCar.spawncode)
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('vRPDealer', 'main'), true)  
                end
            end) 
        end)
    end
end)





RegisterNetEvent('vRP:ReturnFetchedCars')
AddEventHandler('vRP:ReturnFetchedCars', function(table)
    VehiclesFetchedTable = table;
end)

RegisterNetEvent('vRP:CloseGarage')
AddEventHandler('vRP:CloseGarage', function()
    DeleteCar(veh)
    Table_Type = nil;
    RageUI.ActuallyCloseAll()
end)


Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.dealers) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 150 then 
                local type = v[1]
                if type == "Car" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Boat" then 
                    DrawMarker(35, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                end
            end
        end
    end
end)

local MenuOpen = false; 
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(500)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        inMarker = false;
        for i,v in pairs(cfg.dealers) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                garage_type = v[1]
                break
            end
        end
        if not MenuOpen and inMarker then
            MenuOpen = true
            RageUI.Visible(RMenu:Get('vRPDealer', 'main'), true)  
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.ActuallyCloseAll()
            MenuOpen = false
        end
    end
end)

for i,v in pairs(cfg.dealers) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    if v[1] == "Car" then 
        SetBlipSprite(Blip, 734)
    elseif v[1] == "Boat" then 
        SetBlipSprite(Blip, 427)
    elseif v[1] == "Heli" then 
        SetBlipSprite(Blip, 43)
    end
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.9)
    SetBlipColour(Blip, 27)
    SetBlipAsShortRange(Blip, true)
    AddTextEntry("MAPBLIP", v[1] .. ' Dealership')
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end