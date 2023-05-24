Citizen.CreateThread(function()
	while true do
        if IsPedBeingStunned(GetPlayerPed(-1)) then
            taserFX()
        end
        Wait(100)
    end
end)

function taserFX()
    local playerPed = GetPlayerPed(-1)
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
    end
    SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 15000)
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    SetTimecycleModifier("spectator5")
    SetPedIsDrunk(playerPed, true)
    Wait(15000)
    SetPedMotionBlur(playerPed, true)
    Wait(60000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
end