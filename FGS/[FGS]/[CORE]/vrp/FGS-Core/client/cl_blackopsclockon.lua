RMenu.Add('BlackOPSDutyMenu', 'main', RageUI.CreateMenu("", "~b~Black OPS Duty Menu", 1250,100, "policemenu", "policemenu"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('BlackOPSDutyMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~BlackOPS" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('BlackOPSMenu:ClockOn', "BlackOPS Clocked")
                end
            end)
            
            RageUI.Button("~r~Clock Off" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('BlackOPSMenu:ClockOff')
                    --[[ PD Armoury Weapons ]]--
                    RemoveAllPedWeapons(PlayerPedId(), true)
                end
            end)

            
        end) 
    end
end)

isInBlackOPSDutyMenu = false
currentBlackOPSDutyMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = 123.62696075439,-751.81896972656,45.763095855713
            local dutymenu = vector3(x,y,z)

            if isInArea(dutymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInBlackOPSDutyMenu == false then
            if isInArea(dutymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open BlackOPS Duty Menu')
                if IsControlJustPressed(0, 51) then 
                    currentBlackOPSDutyMenu = k
                    FGS_server_callback('BlackOPSMenu:CheckPermissions')
                    isInBlackOPSDutyMenu = true
                    currentBlackOPSDutyMenu = k 
                end
            end
            end
            if isInArea(dutymenu, 1.4) == false and isInBlackOPSDutyMenu and k == currentBlackOPSDutyMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("BlackOPSDutyMenu", "main"), false)
                isInBlackOPSDutyMenu = false
                currentBlackOPSDutyMenu = nil
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('BlackOPSDuty:Allowed')
AddEventHandler('BlackOPSDuty:Allowed', function(allowed)
    if allowed then
        RageUI.Visible(RMenu:Get("BlackOPSDutyMenu", "main"),true)
    elseif not allowed then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("BlackOPSDutyMenu", "main"), false)
        notify("You are not a part of Black OPS")
    end
end)