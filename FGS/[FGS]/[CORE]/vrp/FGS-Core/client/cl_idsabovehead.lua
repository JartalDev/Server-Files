local disPlayerNames = 10
local playerDistances = {}

local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    local ticks = 250
	Wait(250)
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if not hideids then
        
            if targetPed ~= PlayerPedId() then
                if playerDistances[id] then
                    if playerDistances[id] < disPlayerNames then
                        local targetPedCords = GetEntityCoords(targetPed)
                        if NetworkIsPlayerTalking(id) then
                            ticks = 1
                            DrawText3D(targetPedCords, GetPlayerServerId(id), 0,179,255)
                        else
                            ticks = 1
                            DrawText3D(targetPedCords, GetPlayerServerId(id), 255,255,255)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(ticks)
        ticks = 250
    end
end)





Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords-GetEntityCoords(targetPed))
				playerDistances[id] = distance
            end
        end
        Wait(1000)
    end
end)



RegisterCommand('hideids', function()
    if hideids then 
        notify('~r~Ids enabled')
        hideids = false 
    else 
        notify('~g~Ids disabled')
        hideids = true
    end
end)