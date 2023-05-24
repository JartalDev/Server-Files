RMenu.Add('AA', 'main', RageUI.CreateMenu("", "~o~AA",1300,100))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('AA', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Fix", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    local playerPed = PlayerPedId()
                    if IsPedInAnyVehicle(playerPed, false) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        SetVehicleEngineHealth(vehicle, 1000)
                        SetVehicleEngineOn( vehicle, true, true )
                        SetVehicleFixed(vehicle)
                        tvRP.notify("~g~Your vehicle has been fixed!")
                    else
                        tvRP.notify("~o~You're not in a vehicle! There is no vehicle to fix!")
                    end  
                end
            end)
        end)
    end
end)


RegisterNetEvent("GG:ToggleAAMenu", function()
    RageUI.Visible(RMenu:Get("AA", "main"), not RageUI.Visible(RMenu:Get("AA", "main")))
end)