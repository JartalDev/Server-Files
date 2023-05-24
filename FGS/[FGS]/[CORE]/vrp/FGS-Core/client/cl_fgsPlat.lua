_G.plat_hoursLeft = 0
_G.plat_hasPlat = false

RMenu.Add('btfPlus', 'main', RageUI.CreateMenu("btf Plus", "", 1300, 100, "commonmenu", "medal_gold"))
RMenu.Add('btfPlus', 'subscription', RageUI.CreateMenu("Manage Subscription", "", 1300, 100, "commonmenu", "medal_gold"))

local whereIs

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('btfPlus', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.EmptyButton("", "", {}, true, function(Hovered, Active, Selected)
                if Active then
                    RageUI.GoDown()
                end
            end)
            RageUI.Button("Manage Subscription", "", { RightLabel = "→→→" }, true, function()
            end, RMenu:Get('btfPlus', 'subscription'))
        end)
    end
    if RageUI.Visible(RMenu:Get('btfPlus', 'subscription')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.EmptyButton("", "", {}, true, function(Hovered, Active, Selected)
                if Active then
                    if whereIs == 1 then
                        RageUI.GoUp()
                    else
                        RageUI.GoDown()
                    end
                end
            end)
            RageUI.Button("Subscription Remaining: (DD/HH/MM/SS) ", "", { RightLabel = plat_hoursLeft }, true,function(Hovered, Active, Selected)
                if Active then
                    whereIs = 1
                end
            end)
            RageUI.Button("Sell Platinum Subscription", "", { RightLabel = "→→→" }, true,function(Hovered, Active, Selected)
                if Active then
                    whereIs = 2
                end
                if (Selected) then
                    TriggerServerEvent("btfPlat:addPlus")
                end
            end)
        end)
    end
end)

Citizen.CreateThread(function()
    local time = 0
    while true do
        Citizen.Wait(time)
        if RageUI.Visible(RMenu:Get('btfPlus', 'subscription')) then
            time = 1000
            TriggerServerEvent('btf_plat:checkPlat')
        else
            time = 10000
        end
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        TriggerServerEvent('btf_plat:checkPlat')
    end
end)]]


RegisterNetEvent('btf:client:updatePlat')
AddEventHandler('btf:client:updatePlat', function(hoursLeft, hasPlat)
    plat_hoursLeft = hoursLeft
    plat_hasPlat = hasPlat
end)

RegisterNetEvent('btf:client:spawnMoped', function()
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local vehicle = GetHashKey('faggio')
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    local veh = CreateVehicle(vehicle, x, y, z, 0.0, true, false)
    SetPedIntoVehicle(ped, veh, -1)
    SetVehicleNumberPlateText(veh, "btf-Plat")
end)


RegisterCommand('btfclub', function()
    RageUI.Visible(RMenu:Get('btfPlus', 'main'), not RageUI.Visible(RMenu:Get('btfPlus', 'main')))
end)
RegisterCommand('craftmoped', function()
    TriggerServerEvent('btf:plat:craftMoped')
end)
