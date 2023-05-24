RMenu.Add('PoliceDuty2Menu', 'main', RageUI.CreateMenu("", "~b~MET Police Duty Menu", 1250,100, "policemenu", "policemenu"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceDuty2Menu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Commissioner Clocked")
                end
            end)
            
            RageUI.Button("~b~Deputy Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Deputy Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Deputy Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Deputy Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Commander" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Commander Clocked")
                end
            end)

            RageUI.Button("~b~Chief Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Chief Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Chief Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Chief Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Sergeant" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Sergeant Clocked")
                end
            end)

            RageUI.Button("~b~Special Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Special Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Senior Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Senior Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Community Support Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOn', "PCSO Clocked")
                end
            end)

            RageUI.Button("~r~Clock Off" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu2:ClockOff')
                    --[[ PD Armoury Weapons ]]--
                    RemoveAllPedWeapons(PlayerPedId(), true)
                end
            end)

            
        end) 
    end
end)

isInPoliceDuty2Menu = false
currentPoliceDuty2Menu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = -1099.0737304688,-840.53088378906,19.001468658447
            local dutymenu = vector3(x,y,z)

            if isInArea(dutymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInPoliceDuty2Menu == false then
            if isInArea(dutymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open Police Duty Menu')
                if IsControlJustPressed(0, 51) then 
                    currentPoliceDuty2Menu = k
                    FGS_server_callback('PoliceMenu2:CheckPermissions')
                    isInPoliceDuty2Menu = true
                    currentPoliceDuty2Menu = k 
                end
            end
            end
            if isInArea(dutymenu, 1.4) == false and isInPoliceDuty2Menu and k == currentPoliceDuty2Menu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("PoliceDuty2Menu", "main"), false)
                isInPoliceDuty2Menu = false
                currentPoliceDuty2Menu = nil
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('PoliceDuty2:Allowed')
AddEventHandler('PoliceDuty2:Allowed', function(allowed)
    if allowed then
        RageUI.Visible(RMenu:Get("PoliceDuty2Menu", "main"),true)
    elseif not allowed then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("PoliceDuty2Menu", "main"), false)
        notify("You are not a part of the MET Police")
    end
end)