local distanceToCARGOEntrance = 1000
local distanceToCARGOExit = 1000
local CARGOEntranceVector = vector3(1196.3336181641,-3253.6408691406,7.1950117111206)
local CARGOExitVector = vector3(3065.654296875,-4816.3305664062,15.261612892151)

RMenu.Add('CARGO_enter', 'CARGO', RageUI.CreateMenu("", "",0,100,"banners","cargo"))
RMenu:Get('CARGO_enter', 'CARGO'):SetSubtitle("~r~Cargo Ship")
RMenu.Add('CARGO_exit', 'CARGO', RageUI.CreateMenu("", "",0,100,"banners","cargo"))
RMenu:Get('CARGO_exit', 'CARGO'):SetSubtitle("~r~Cargo Ship")

function showCARGOEnter(flag)
    RageUI.Visible(RMenu:Get('CARGO_enter', 'CARGO'), flag)
end

function showCARGOExit(flag)
    RageUI.Visible(RMenu:Get('CARGO_exit', 'CARGO'), flag)
end


RageUI.CreateWhile(1.0, RMenu:Get('CARGO_exit', 'CARGO'), nil, function()
    RageUI.IsVisible(RMenu:Get('CARGO_exit', 'CARGO'), true, false, true, function()

        RageUI.ButtonWithStyle("~b~Travel back", nil,{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Active) then

            end
            if (Selected) then
                SetEntityCoords(PlayerPedId(),CARGOEntranceVector.x,CARGOEntranceVector.y,CARGOEntranceVector.z)
                for k,v in pairs(cardObjects) do
                    for _,obj in pairs(v) do
                        DeleteObject(obj)
                    end
                end	
                RemoveAllPedWeapons(PlayerPedId(), true)
            end
        end)

    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('CARGO_enter', 'CARGO'), nil, function()
    RageUI.IsVisible(RMenu:Get('CARGO_enter', 'CARGO'), true, false, true, function()

        RageUI.ButtonWithStyle("~r~Enter cargo ship", nil,{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Active) then

            end
            if (Selected) then
                SetEntityCoords(PlayerPedId(),CARGOExitVector.x,CARGOExitVector.y,CARGOExitVector.z)
                --RemoveAllPedWeapons(PlayerPedId(), true)
            end
        end)

    end)
end)



Citizen.CreateThread(function()
    while true do 
        if distanceToCARGOEntrance < 1.5  then 
            showCARGOEnter(true)
        elseif distanceToCARGOEntrance < 2.5 then 
            showCARGOEnter(false)
        end
        if distanceToCARGOExit < 1.5  then 
            showCARGOExit(true)
        elseif distanceToCARGOExit < 2.5 then 
            showCARGOExit(false)
        end
        DrawMarker(27, CARGOEntranceVector.x, CARGOEntranceVector.y, CARGOEntranceVector.z-1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,0,0, 200, 0, 0, 0, 0)
        DrawMarker(27, CARGOExitVector.x, CARGOExitVector.y, CARGOExitVector.z-1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,0,0, 200, 0, 0, 0, 0)
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local playerCoords = GetEntityCoords(PlayerPedId())

        distanceToCARGOEntrance = #(playerCoords-CARGOEntranceVector)
        distanceToCARGOExit = #(playerCoords-CARGOExitVector)
        Wait(100)
    end
end)