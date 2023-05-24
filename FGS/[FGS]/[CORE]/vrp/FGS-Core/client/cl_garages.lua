local vehicles = {}
local hasvip = false

RegisterNetEvent('FGS:SetPlayerAsVIP', function(boolvalue)
    hasvip = boolvalue
end)



function tvRP.spawnGarageVehicle(vtype, name, pos) -- vtype is the vehicle type (one vehicle per type allowed at the same time)
    TriggerServerEvent("vRP:GetVehicleOut", name)
    local vehicle = vehicles[vtype]
    if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
        -- despawn vehicle
        SetVehicleHasBeenOwnedByPlayer(vehicle[3], false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
        vehicles[vtype] = nil
    end

    vehicle = vehicles[vtype]
    if vRPConfig.AllowMoreThenOneCar or vehicle == nil then
        -- load vehicle model
        local mhash = GetHashKey(name)

        local i = 0
        while not HasModelLoaded(mhash) and i < 2500 do
            RequestModel(mhash)
            Citizen.Wait(10)
            i = i + 1
        end

        -- spawn car
        if HasModelLoaded(mhash) then
            local x, y, z = tvRP.getPosition()
            if pos then
                x, y, z = table.unpack(pos)
            end

            local nveh = CreateVehicle(mhash, x, y, z + 0.5, 0.0, true, false)
            SetVehicleOnGroundProperly(nveh)
            SetEntityInvincible(nveh, false)
            SetPedIntoVehicle(GetPlayerPed(-1), nveh, -1) -- put player inside
            SetVehicleNumberPlateText(nveh, "P " .. tvRP.getRegistrationNumber())
            -- Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
            SetVehicleHasBeenOwnedByPlayer(nveh, true)

            -- Network vehicle set to allow migration by default
            local nid = NetworkGetNetworkIdFromEntity(nveh)
            SetNetworkIdCanMigrate(nid, cfg.vehicle_migration)

            vehicles[vtype] = {vtype, name, nveh} -- set current vehicule
            --print(name, nveh)
            FGS_server_callback("LSC:applyModifications", name, nveh)
            SetModelAsNoLongerNeeded(mhash)
        end
    else
        tvRP.notify("You can only have one of this type of vehicle out.")
    end
end

function tvRP.despawnGarageVehicle(vtype, max_range)
    local vehicle = vehicles[vtype]
    if vehicle then
        local x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
        local px, py, pz = tvRP.getPosition()

        if GetDistanceBetweenCoords(x, y, z, px, py, pz, true) < max_range then -- check distance with the vehicule
            -- remove vehicle
            SetVehicleHasBeenOwnedByPlayer(vehicle[3], false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
            SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
            vehicles[vtype] = nil
            tvRP.notify("Vehicle stored.")
        else
            tvRP.notify("Too far away from the vehicle.")
        end
    end
end

-- check vehicles validity
--[[
Citizen.CreateThread(function()
  Citizen.Wait(30000)
  for k,v in pairs(vehicles) do
    if IsEntityAVehicle(v[3]) then -- valid, save position
      v.pos = {table.unpack(GetEntityCoords(vehicle[3],true))}
    elseif v.pos then -- not valid, respawn if with a valid position
      print("[vRP] invalid vehicle "..v[1]..", respawning...")
      tvRP.spawnGarageVehicle(v[1], v[2], v.pos)
    end
  end
end)
--]]

-- (experimental) this function return the nearest vehicle
-- (don't work with all vehicles, but aim to)
function tvRP.getNearestVehicle(radius)
    local x, y, z = tvRP.getPosition()
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
        return GetVehiclePedIsIn(ped, true)
    else
        -- flags used:
        --- 8192: boat
        --- 4096: helicos
        --- 4,2,1: cars (with police)

        local veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 8192 + 4096 + 4 + 2 + 1) -- boats, helicos
        if not IsEntityAVehicle(veh) then
            veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 4 + 2 + 1)
        end -- cars
        return veh
    end
end

function tvRP.fixeNearestVehicle(radius)
    local veh = tvRP.getNearestVehicle(radius)
    if IsEntityAVehicle(veh) then
        SetVehicleFixed(veh)
    end
end

function tvRP.replaceNearestVehicle(radius)
    local veh = tvRP.getNearestVehicle(radius)
    if IsEntityAVehicle(veh) then
        SetVehicleOnGroundProperly(veh)
    end
end

-- try to get a vehicle at a specific position (using raycast)
function tvRP.getVehicleAtPosition(x, y, z)
    x = x + 0.0001
    y = y + 0.0001
    z = z + 0.0001

    local ray = CastRayPointToPoint(x, y, z, x, y, z + 4, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, ent = GetRaycastResult(ray)
    return ent
end

-- return ok,vtype,name
function tvRP.getNearestOwnedVehicle(radius)
    local px, py, pz = tvRP.getPosition()
    for k, v in pairs(vehicles) do
        local x, y, z = table.unpack(GetEntityCoords(v[3], true))
        local dist = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
        -- {vtype,name,nveh} 
        if dist <= radius + 0.0001 then
            return true, v[1], v[2]
        end
    end

    return false, "", ""
end

-- return ok,x,y,z
function tvRP.getAnyOwnedVehiclePosition()
    for k, v in pairs(vehicles) do
        if IsEntityAVehicle(v[3]) then
            local x, y, z = table.unpack(GetEntityCoords(v[3], true))
            return true, x, y, z
        end
    end

    return false, 0, 0, 0
end

-- return x,y,z
function tvRP.getOwnedVehiclePosition(vtype)
    local vehicle = vehicles[vtype]
    local x, y, z = 0, 0, 0

    if vehicle then
        x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
    end

    return x, y, z
end

-- return ok, vehicule network id
function tvRP.getOwnedVehicleId(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        return true, NetworkGetNetworkIdFromEntity(vehicle[3])
    else
        return false, 0
    end
end

-- eject the ped from the vehicle
function tvRP.ejectVehicle()
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
        local veh = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, veh, 4160)
    end
end

-- vehicle commands
function tvRP.vc_openDoor(vtype, door_index)
    local vehicle = vehicles[vtype]
    if vehicle then
        SetVehicleDoorOpen(vehicle[3], door_index, 0, false)
    end
end

function tvRP.vc_closeDoor(vtype, door_index)
    local vehicle = vehicles[vtype]
    if vehicle then
        SetVehicleDoorShut(vehicle[3], door_index)
    end
end

function tvRP.vc_detachTrailer(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        DetachVehicleFromTrailer(vehicle[3])
    end
end

function tvRP.vc_detachTowTruck(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local ent = GetEntityAttachedToTowTruck(vehicle[3])
        if IsEntityAVehicle(ent) then
            DetachVehicleFromTowTruck(vehicle[3], ent)
        end
    end
end

function tvRP.vc_detachCargobob(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local ent = GetVehicleAttachedToCargobob(vehicle[3])
        if IsEntityAVehicle(ent) then
            DetachVehicleFromCargobob(vehicle[3], ent)
        end
    end
end

function tvRP.vc_toggleEngine(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle[3]) -- GetIsVehicleEngineRunning
        SetVehicleEngineOn(vehicle[3], not running, true, true)
        if running then
            SetVehicleUndriveable(vehicle[3], true)
        else
            SetVehicleUndriveable(vehicle[3], false)
        end
    end
end

function tvRP.vc_toggleLock(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local veh = vehicle[3]
        local locked = GetVehicleDoorLockStatus(veh) >= 2
        if locked then -- unlock
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            SetVehicleDoorsLocked(veh, 1)
            SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
            tvRP.notify("~r~Vehicle unlocked.")
        else -- lock
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            tvRP.notify("~g~Vehicle locked.")
        end
    end
end



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
--Created by JamesUK#6793 :)
RMenu.Add('vRPGarages', 'main', RageUI.CreateMenu("", "~b~Garage Menu",1300,100, "Garage", "Garage"))
RMenu.Add('vRPGarages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles")))
RMenu.Add('vRPGarages', 'buy_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'buy_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "buy_vehicles")))
RMenu.Add('vRPGarages', 'buy_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "buy_vehicles_submenu")))
RMenu.Add('vRPGarages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles")))
RMenu.Add('vRPGarages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles_submenu")))
RMenu.Add('vRPGarages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage")))
RMenu.Add('vRPGarages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles")))
RMenu.Add('vRPGarages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles_out_manage")))
RMenu:Get('vRPGarages', 'owned_vehicles'):SetSubtitle("~b~Vehicle Categories")
RMenu:Get('vRPGarages', 'scrap_vehicle_confirmation'):SetSubtitle("~b~Are you sure you want to scrap this vehicle?")



RMenu.Add('vRPGarages', 'owned_vehicles2',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu:Get('vRPGarages', 'owned_vehicles2'):SetSubtitle("~b~Vehicle Categories")
--Created by JamesUK#6793 :)

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

-- Did you know you can toggle most things in vRP within the vrp/sharedcfg/options.lua?
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPGarages', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            if vRPConfig.EnableBuyVehicles then
                RageUI.Button("Buy Vehicles", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected) 
                    if Selected then
                        Table_Type = nil;
                        if Table_Type == nil or Table_Type then 
                            FGS_server_callback('vRP:FetchCars', false, garage_type)
                            Table_Type = false;
                        end
                    end
                end, RMenu:Get("vRPGarages", "buy_vehicles"))
            end
            RageUI.Button("Owned Vehicles", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected) 
                if Selected then
                    Table_Type = nil;
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        FGS_server_callback('vRP:FetchCars', true, garage_type)
                    end
                end
            end, RMenu:Get("vRPGarages", "owned_vehicles"))
            RageUI.Button("Locks And Imports", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    Table_Type = nil;
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        TriggerServerEvent('vRP:FetchCars2', true, garage_type)
                    end
                end
            end, RMenu:Get("vRPGarages", "owned_vehicles2"))
            RageUI.Button("Rented Vehicles", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPGarages", "rented_vehicles"))
            RageUI.Button("Store Vehicle", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    tvRP.despawnGarageVehicle(garage_type,vRPConfig.VehicleStoreRadius)
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "buy_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1].." [£"..v[2].."]", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('vRPGarages', 'buy_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1] .. ' Price: £' .. v[2])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("vRPGarages", "buy_vehicles_submenu_manage")) 
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Buy Vehicle", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('vRP:BuyVehicle', SelectedCar.spawncode)
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
                end
            end) 
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles2')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                if RentedVeh then 
                    RageUI.Button(v[1], v[2] .. " until the vehicle is returned.", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage"))
                else 
                    RageUI.Button(v[1], "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage")) 
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Spawn Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then 
                    tvRP.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()))
                    DeleteCar(veh)
                    RageUI.ActuallyCloseAll()
                end
                if Active then 
                
                end
            end)
            if not RentedVeh then 
                RageUI.Button('Scrap Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)end,RMenu:Get("vRPGarages", "scrap_vehicle_confirmation"))
                RageUI.Button('Rent out Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('vRP:RentVehicle', SelectedCar.spawncode) 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Sell Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                    if Selected then 
                        FGS_server_callback('vRP:SellVehicle', SelectedCar.spawncode)
                    end
                    if Active then 
                    
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'scrap_vehicle_confirmation')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Yes', "WARNING: THIS WILL DESTROY YOUR VEHICLE THIS IS NOT REVERSIBLE.", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('vRP:ScrapVehicle', SelectedCar.spawncode) 
                    Table_Type = nil;
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
                end
            end)
            RageUI.Button('No', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)end,RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button('Rented Vehicles Out', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    FGS_server_callback('vRP:FetchVehiclesOut')
                end
            end,RMenu:Get("vRPGarages", "rented_vehicles_out_manage"))
            RageUI.Button('Rented Vehicles In', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    RentedVeh = true;
                    FGS_server_callback('vRP:FetchVehiclesIn')
                end
            end,RMenu:Get("vRPGarages", "rented_vehicles_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_out_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "rented_vehicles_out_manage_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_out_manage_submenu')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1] .. ' Rented to: ' .. v[3], v[2] .. " until the vehicle is returned to you.", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
end)


if vRPConfig.LoadPreviews then 
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if Hovered_Vehicles then 
                if vehname and vehname ~= Hovered_Vehicles then 
                    DeleteEntity(veh)
                    vehname = Hovered_Vehicles
                end
                local hash = GetHashKey(Hovered_Vehicles)
                if not DoesEntityExist(veh) and not IsPedInAnyVehicle(PlayerPedId(), false) and not cantload[Hovered_Vehicles] and Hovered_Vehicles then
                    local i = 0
                    while not HasModelLoaded(hash) do
                        RequestModel(hash)
                        i = i + 1
                        Citizen.Wait(10)
                        if i > 30 then
                            tvRP.notify('~r~Model could not be loaded!') 
                            if vehname then 
                                cantload[vehname] = true
                            end
                            break 
                        end
                    end
                    local coords = GetEntityCoords(PlayerPedId())
                    local ped = PlayerPedId()
                    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y-7, coords.z + 1.5, 350.00,0.00,0.00, 50.00, false, 0)
                    vehname = Hovered_Vehicles
                    veh = CreateVehicle(hash,coords.x, coords.y, coords.z + 1, 0.0,false,false)
                    FreezeEntityPosition(veh,true)
                    SetEntityInvincible(veh,true)
                    SetVehicleDoorsLocked(veh,4)
                    SetModelAsNoLongerNeeded(hash)
                    for i = 0,24 do
                        SetVehicleModKit(veh,0)
                        RemoveVehicleMod(veh,i)
                    end
                    SetEntityCollision(veh, false, false)
                    Citizen.CreateThread(function()
                        while DoesEntityExist(veh) do
                            Citizen.Wait(25)
                            SetEntityHeading(veh, GetEntityHeading(veh)+0.5 %360)
                            FreezeEntityPosition(ped,true)
                            SetCamActive(cam, true)
                            RenderScriptCams(true, false, 1, true, true)
                            SetEntityVisible(ped, false, false)
                        end
                        FreezeEntityPosition(ped,false)
                        RenderScriptCams(false, true, 500, true, true)
                        SetEntityVisible(ped, true, false)
                        SetCamActive(cam, false)
                        DestroyCam(cam, true)
                        SetEntityVisible(ped, true, false)
                    end)
                end
            end
        end
    end)
end



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
        for i,v in pairs(cfg.garages) do 
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

Citizen.CreateThread(function()
    local MenuOpen = false; 
    local inMarker = false;
    while true do 
        Wait(300)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        inMarker = false;
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                garage_type = v[1]
                break
            end
        end
        if not MenuOpen and inMarker then
            MenuOpen = true
            RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.ActuallyCloseAll()
            MenuOpen = false
        end
    end
end)
for i,v in pairs(cfg.garages) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    if v[1] == "Car" then 
        SetBlipSprite(Blip, 50)
    elseif v[1] == "Heli" then 
        SetBlipSprite(Blip, 43)
    end
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.5)
    SetBlipColour(Blip, 2)
    SetBlipAsShortRange(Blip, true)
    AddTextEntry("MAPBLIP", v[1] .. ' Garage')
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.redgarages) do 
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

Citizen.CreateThread(function()
    local MenuOpen = false; 
    local inMarker = false;
    while true do 
        Wait(300)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        inMarker = false;
        for i,v in pairs(cfg.redgarages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                garage_type = v[1]
                break
            end
        end
        if not MenuOpen and inMarker then
            MenuOpen = true
            RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.ActuallyCloseAll()
            MenuOpen = false
        end
    end
end)
for i,v in pairs(cfg.redgarages) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    if v[1] == "Car" then 
        SetBlipSprite(Blip, 50)
    elseif v[1] == "Heli" then 
        SetBlipSprite(Blip, 43)
    end
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.5)
    SetBlipColour(Blip, 1)
    SetBlipAsShortRange(Blip, true)
    AddTextEntry("MAPBLIP", v[1] .. ' Garage')
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end

RMenu.Add('VIPGarages', 'main', RageUI.CreateMenu("", "~b~Garage Menu",1300,100, "Garage", "Garage"))
RMenu.Add('VIPGarages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "main")))
RMenu.Add('VIPGarages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "main")))
RMenu.Add('VIPGarages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "rented_vehicles")))
RMenu.Add('VIPGarages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "owned_vehicles")))
RMenu.Add('VIPGarages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "owned_vehicles_submenu")))
RMenu.Add('VIPGarages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "owned_vehicles_submenu_manage")))
RMenu.Add('VIPGarages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "rented_vehicles")))
RMenu.Add('VIPGarages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("VIPGarages", "rented_vehicles_out_manage")))
RMenu:Get('VIPGarages', 'owned_vehicles'):SetSubtitle("~b~Vehicle Categories")
RMenu:Get('VIPGarages', 'scrap_vehicle_confirmation'):SetSubtitle("~b~Are you sure you want to scrap this vehicle?")

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('VIPGarages', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button("Owned Vehicles", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        FGS_server_callback('vRP:FetchCars', true, garage_type)
                    end
                end
            end, RMenu:Get("VIPGarages", "owned_vehicles"))
            RageUI.Button("Locks And Imports", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    Table_Type = nil;
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        TriggerServerEvent('vRP:FetchCars2', true, garage_type)
                    end
                end
            end, RMenu:Get("vRPGarages", "owned_vehicles2"))
            RageUI.Button("Rented Vehicles", "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected) end, RMenu:Get("VIPGarages", "rented_vehicles"))
            RageUI.Button("Store Vehicle", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    tvRP.despawnGarageVehicle(garage_type,vRPConfig.VehicleStoreRadius)
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'owned_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("VIPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'owned_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                if RentedVeh then 
                    RageUI.Button(v[1], v[2] .. " until the vehicle is returned.", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('VIPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("VIPGarages", "owned_vehicles_submenu_manage"))
                else 
                    RageUI.Button(v[1], "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('VIPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~b~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("VIPGarages", "owned_vehicles_submenu_manage")) 
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'owned_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Spawn Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then 
                    tvRP.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()))
                    DeleteCar(veh)
                    RageUI.ActuallyCloseAll()
                end
                if Active then 
                
                end
            end)
            if not RentedVeh then 
                RageUI.Button('Scrap Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)end,RMenu:Get("VIPGarages", "scrap_vehicle_confirmation"))
                RageUI.Button('Rent out Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('vRP:RentVehicle', SelectedCar.spawncode) 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Sell Vehicle', "", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                    if Selected then 
                        FGS_server_callback('vRP:SellVehicle', SelectedCar.spawncode)
                    end
                    if Active then 
                    
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'scrap_vehicle_confirmation')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Yes', "WARNING: THIS WILL DESTROY YOUR VEHICLE THIS IS NOT REVERSIBLE.", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('vRP:ScrapVehicle', SelectedCar.spawncode) 
                    Table_Type = nil;
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('VIPGarages', 'main'), true)  
                end
            end)
            RageUI.Button('No', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)end,RMenu:Get("VIPGarages", "owned_vehicles_submenu_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'rented_vehicles')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button('Rented Vehicles Out', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    FGS_server_callback('vRP:FetchVehiclesOut')
                end
            end,RMenu:Get("VIPGarages", "rented_vehicles_out_manage"))
            RageUI.Button('Rented Vehicles In', "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    RentedVeh = true;
                    FGS_server_callback('vRP:FetchVehiclesIn')
                end
            end,RMenu:Get("VIPGarages", "rented_vehicles_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'rented_vehicles_out_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("VIPGarages", "rented_vehicles_out_manage_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'rented_vehicles_out_manage_submenu')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1] .. ' Rented to: ' .. v[3], v[2] .. " until the vehicle is returned to you.", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('VIPGarages', 'rented_vehicles_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("VIPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local vipplrcoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.vipgarages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(vipplrcoords - vec3(x,y,z)) <= 150 then 
                DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
            end
        end
    end
end)

local VIPOpen = false; 
local inVIPMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(300)
        local vipplrcoords = GetEntityCoords(PlayerPedId())
        inVIPMarker = false;
        if hasvip then
            for i,v in pairs(cfg.vipgarages) do 
                local x,y,z = v[2], v[3], v[4]
                if #(vipplrcoords - vec3(x,y,z)) <= 3.0 then 
                    inVIPMarker = true 
                    garage_type = v[1]
                    break

                end
            end
            if not VIPOpen and inVIPMarker and hasvip then
                VIPOpen = true
                RageUI.Visible(RMenu:Get('VIPGarages', 'main'), true)  
            end
            if not inVIPMarker and VIPOpen then
                DeleteCar(veh)
                Table_Type = nil;
                RageUI.ActuallyCloseAll()
                VIPOpen = false
            end
        end
    end
end)

for i,v in pairs(cfg.vipgarages) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(Blip, 50)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.5)
    SetBlipColour(Blip, 5)
    SetBlipAsShortRange(Blip, true)
    AddTextEntry("MAPBLIP", 'VIP Garage')
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end



