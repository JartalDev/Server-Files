local panic_cooldown = false 


RegisterCommand("panic", function()
    if panic_cooldown then 
        notify("~r~ Panic button can only be pressed every minute.") 
        return 
    end 
    TriggerServerEvent("FGS:PANIC", GetEntityCoords(GetPlayerPed(-1)))
    panic_cooldown = true
end)


RegisterNetEvent("FGS:PANICBUTTON")
AddEventHandler("FGS:PANICBUTTON", function(coords,paniccolor)
    local panicblip = AddBlipForRadius(coords.x,coords.y,coords.z, 75.0)
    SetBlipRoute(panicblip, true)
    SetBlipRouteColour(panicblip, 1)
    TriggerServerEvent("FGS:PlayWithinDistance", 3.0,"panic", 1, GetEntityCoords(GetPlayerPed(-1))) 
    for i = 1,60 do 
    Wait(500)
    SetBlipColour(panicblip, tonumber(paniccolor))
    SetBlipAlpha(panicblip, 180)
    Wait(500)
    SetBlipAlpha(panicblip, 0)
    end 
    SetBlipRoute(panicblip, false)
    RemoveBlip(panicblip)
end)


Citizen.CreateThread(function()
    while true do 
        Wait(60000)
        panic_cooldown = false 
    end
end)


function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end