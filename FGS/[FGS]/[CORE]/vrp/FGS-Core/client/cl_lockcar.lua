RegisterCommand('lockcar', function()
    local veh, name, nveh = tvRP.getNearestOwnedVehicle(5)
    print(veh)
    if veh then 
        tvRP.vc_toggleLock(name)
        tvRP.playSound("HUD_MINI_GAME_SOUNDSET", "5_SEC_WARNING")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 82) then
            ExecuteCommand('lockcar')
        end
    end
end)