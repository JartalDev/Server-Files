local chipsDesk = vector3(1087.4401855469,219.55816650391,-49.200351715088)
local isInMenu = false


RMenu.Add('highRollers', 'main', RageUI.CreateMenu("Diamond Casino", "~b~Diamond Casino",1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('highRollers', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()           
            RageUI.Button("Buy Highrollers [£10,000,000]", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('casino:buyHighrollers')
                end
            end)
        end, function()
        end)
    end
end)




Citizen.CreateThread(function() 
    isInMenu = false
    while true do
        if isInArea(chipsDesk, 100.0) then 
            DrawMarker(27, chipsDesk-0.9, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
        end
        if isInMenu == false then
            if isInArea(chipsDesk, 1.4) then 
                drawNativeNotification('Press ~INPUT_CONTEXT~ to buy highrollers')
                if IsControlJustPressed(0, 51) then 
                    RageUI.Visible(RMenu:Get("highRollers", "main"), true)
                    isInMenu = true
                end
            end
        end
        if isInArea(chipsDesk, 1.4) == false and isInMenu then
            RageUI.Visible(RMenu:Get("chipsDesk", "main"), false)
            isInMenu = false
        end
        Citizen.Wait(0)
    end
end)



