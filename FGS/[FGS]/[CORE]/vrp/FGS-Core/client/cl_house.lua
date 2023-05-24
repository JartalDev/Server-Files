
local homes = {}
local HouseName = nil
local ownerid, inserver = nil, nil 
local coords
local showexitmenu = false
local myid = nil 

RMenu.Add("HouseMenu", "houseexit", RageUI.CreateMenu("", " ", 1350, 50, "housing", "housing"))
RMenu.Add("HouseMenu", "houseenter", RageUI.CreateMenu("", " ", 1350, 50, "housing", "housing"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('HouseMenu', 'houseenter')) then
        if homes ~= nil and HouseName ~= nil then 
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
                RMenu:Get("HouseMenu", "houseenter"):SetSubtitle("~b~"..HouseName)
                if ownerid == nil then 
                    RageUI.Button("Purchase House", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:PurchaseHouse", HouseName)
                        end
                    end)
                else
                    RageUI.Button("Enter House", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:EnterHouse", HouseName)
                        end
                    end)
                end
                if ownerid == myid and ownerid ~= nil then 
                    RageUI.Button("Sell House To City", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:SellHouse", HouseName)
                        end
                    end)
                    RageUI.Button("Sell House To Player", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:SellHouseToPlayer", HouseName)
                        end
                    end)
                end
                if ownerid ~= nil or inserver ~= nil then 
                    RageUI.Button("House info", "UserID: " .. ownerid .. " | [ " .. inserver .. " ]" , { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then

                        end
                    end)
                end
            end)
        end
    end


    if RageUI.Visible(RMenu:Get('HouseMenu', 'houseexit')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RMenu:Get("HouseMenu", "houseexit"):SetSubtitle("~p~FGS Network Houses")
            RageUI.Button("Exit House", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback("FGS:LeaveHouse")
                    coords = false
                end
            end)
        end)
    end

end, 1)


RegisterNetEvent("FGS:HouseExit")
AddEventHandler("FGS:HouseExit", function(loc, loc2)
    coords = loc
    coords2 = loc2

    Citizen.CreateThread(function()
        while coords do 
            Citizen.Wait(1000)
            if coords then 
                local nearexit = #(GetEntityCoords(PlayerPedId()) - vec3(coords[1], coords[2], coords[3]))
                DrawMarker(2, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                if nearexit <= 2.0 then 
                    showexitmenu = true                
                    RageUI.Visible(RMenu:Get('HouseMenu', 'houseexit'), true)
                else
                    if showexitmenu then 
                        showexitmenu = false
                        RageUI.ActuallyCloseAll()
                        RageUI.Visible(RMenu:Get('HouseMenu', 'houseenter'), false)
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while coords2 do 
            Citizen.Wait(0)
            if coords2 then 
                DrawMarker(2, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                local nearexit = #(GetEntityCoords(PlayerPedId()) - vec3(coords2[1], coords2[2], coords2[3]))
                if nearexit <= 2.0 then 
                    DrawHelpMsg("Press [E]")
                    if IsControlJustPressed(0, 38) then 
                        TriggerEvent("OpenHouseInv")
                    end
                end
            end
        end
    end)
end)




RegisterNetEvent("FGS:gettingid", function(w)
    myid = w

end)

local housemenu = false
Citizen.CreateThread(function()
    Wait(50)
    FGS_server_callback("FGS:grabid")
    while true do
    Citizen.Wait(1000)
    NearHome = false
        for name, v in pairs(homes) do
            local Coords = GetEntityCoords(PlayerPedId())
            local distance = #(Coords - vec3(v.entry_point[1], v.entry_point[2], v.entry_point[3]))
            if distance < 3.0 then
                NearHome = true
                HouseName = name
                if distance < 1.0 then
                    FGS_server_callback("FGS:HouseInfo", HouseName)
                    Wait(50)
                    housemenu = true
                    RageUI.Visible(RMenu:Get('HouseMenu', 'houseenter'), true)
                end
            end
        end
        if not NearHome then
            HouseName = nil 
            ownerid, inserver = nil, nil 
            if housemenu then 
                housemenu = false
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get('HouseMenu', 'houseenter'), false)
            end
        end
    end
end)



function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end



RegisterNetEvent("RequestHomeData")
AddEventHandler("RequestHomeData", function(homedata)
    homes = homedata
    --codenigger
end)

RegisterNetEvent("FGS:HouseInfo")
AddEventHandler("FGS:HouseInfo", function(id, status)
    ownerid, inserver = id, status
end)