RMenu.Add('PoliceDutyMenu', 'main', RageUI.CreateMenu("", "~b~MET Police Duty Menu", 1250,100, "policemenu", "policemenu"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceDutyMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Commissioner Clocked")
                end
            end)
            
            RageUI.Button("~b~Deputy Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Deputy Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Deputy Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Deputy Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Commander" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Commander Clocked")
                end
            end)

            RageUI.Button("~b~Chief Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Chief Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Chief Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Chief Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Sergeant" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Sergeant Clocked")
                end
            end)

            RageUI.Button("~b~Special Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Special Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Senior Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Senior Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Community Support Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOn', "PCSO Clocked")
                end
            end)

            RageUI.Button("~r~Clock Off" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('PoliceMenu:ClockOff')
                    --[[ PD Armoury Weapons ]]--
                    RemoveAllPedWeapons(PlayerPedId(), true)
                end
            end)

            
        end) 
    end
end)

isInPoliceDutyMenu = false
currentPoliceDutyMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = 441.80776977539,-985.11273193359,30.689506530762
            local dutymenu = vector3(x,y,z)

            if isInArea(dutymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInPoliceDutyMenu == false then
            if isInArea(dutymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open Police Duty Menu')
                if IsControlJustPressed(0, 51) then 
                    currentPoliceDutyMenu = k
                    FGS_server_callback('PoliceMenu:CheckPermissions')
                    isInPoliceDutyMenu = true
                    currentPoliceDutyMenu = k 
                end
            end
            end
            if isInArea(dutymenu, 1.4) == false and isInPoliceDutyMenu and k == currentPoliceDutyMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"), false)
                isInPoliceDutyMenu = false
                currentPoliceDutyMenu = nil
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('PoliceDuty:Allowed')
AddEventHandler('PoliceDuty:Allowed', function(allowed)
    if allowed then
        RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"),true)
    elseif not allowed then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"), false)
        notify("You are not a part of the MET Police")
    end
end)